Nuclei NICE Plugin
==================

Nuclei QEMU provides a NICE plugin mechanism for custom RISC-V instructions. With this mechanism, users can keep the standard Nuclei QEMU binary unchanged and implement their own NICE or VNICE instruction behavior in an external shared library.

This mechanism is mainly used to emulate user-defined instructions in the custom opcode space. At runtime, QEMU decodes the instruction fields, reads the source operands, and dispatches the instruction to the handler function defined by the user library. If no handler matches the current instruction, QEMU raises an illegal-instruction exception.

How to Load the NICE Plugin
---------------------------

The plugin is loaded through qemu's generic ``-plugin`` option. Taking Linux as an example:

.. code-block:: shell

  $ qemu-system-riscv32 -M nuclei_evalsoc,download=ilm \
      -cpu nuclei-n300fd,ext=_v,vlen=128,elen=64 \
      -plugin /path/to/qemu/lib/qemu/libnice.so,lib=/path/to/libuser_nice.so,verbose=on \
      -nographic -serial stdio -kernel demo_nice.elf

In this command:

* ``/path/to/qemu/lib/qemu/libnice.so`` is the NICE plugin provided by Nuclei QEMU itself for Linux version, it is built and installed together with qemu. For Windows version, the ``libnice.dll`` file is used and is also stored in the ``/bin/lib/qemu/`` directory of the Windows QEMU package.

* ``lib=`` is a required parameter. Users should implement their custom NICE & VNICE instructions in ``user_nice.c`` first, then build that file into a shared library, and finally pass the generated library path through ``lib=``. For example, on Linux it can be built as follows:

  .. code-block:: shell

    gcc -O2 -shared -fPIC -I/path/to/qemu/include user_nice.c -o libuser_nice.so

  On Windows, you need to build it into a ``.dll`` library, for example:

  .. code-block:: shell

    gcc -O2 -shared -fPIC -I/path/to/qemu/bin/include user_nice.c -o libuser_nice.dll


* ``verbose=on`` is an optional parameter. When enabled, the plugin will print the loaded instruction entries and related matching information at startup, which is convenient for debugging.

How to Extend ``user_nice.c``
-----------------------------

UUsers need to provide a ``user_nice.c`` file to describe and implement their custom instructions. They only need to fill in ``nice_def_t nice_defs[]`` according to the specification in ``/path/to/qemu/include/nice_api.h``. Several key macros are described below:

* ``CI_ANY``: used to indicate that the corresponding register field is not used as a sub-opcode and instead carries a normal register value; if the corresponding register field is used as a sub-opcode, the sub-opcode value must be specified explicitly.

* ``CI_CALL_INT``: integer mode, handler prototype is ``uint64_t fn(uint64_t...)``.

* ``CI_CALL_F32``: single-precision floating-point mode, handler prototype is ``float fn(float...)``.

* ``CI_CALL_F64``: double-precision floating-point mode, handler prototype is ``double fn(double...)``.

* ``CI_CALL_VEC``: vector mode, handler prototype is ``void fn(qemu_plugin_nice_info_t *info)``. In this mode, the handler can directly access vector registers through ``rd_vreg``, ``rs1_vreg``, and ``rs2_vreg``.

* ``NICE_VSEW_E*``: used to set the element width of VNICE instructions.

The following is an example file:

.. code-block:: c

  /*
   * user_nice.c — Example user-side instruction handler library.
   *
   * This file demonstrates how to define custom RISC-V instruction handlers
   * for use with the QEMU NICE plugin.
   */

  #include "nice_api.h"

  /* --- custom-0 integer handlers ------------- */

  static uint64_t insn_add(uint64_t a, uint64_t b)
  {
      return a + b;
  }

  static uint64_t insn_mac(uint64_t acc, uint64_t a, uint64_t b)
  {
      return acc + a * b;
  }

  static uint64_t insn_popcount(uint64_t a)
  {
      return (uint64_t)__builtin_popcountll(a);
  }

  /* --- custom-0 FPU handlers: ---------------- */

  static float insn_fadd(float a, float b)
  { 
      return a + b;
  }

  /* --- custom-2 RVV vector handlers (CI_CALL_VEC) ---------------------------
   *
   * Pure-C loop implementation; runs on the QEMU host (x86-64, aarch64, …).
   * Each handler receives qemu_plugin_nice_info_t* with zero-copy pointers
   * directly into QEMU's vreg[] array:
   *
   *   info->rd_vreg   — vd  destination (writable, info->vlenb bytes)
   *   info->rs1_vreg  — vs1 source (valid when xs1=1)
   *   info->rs2_vreg  — vs2 source (valid when xs2=1)
   *   info->vl        — current vector length
   *   info->vsew      — element width: 0=e8 1=e16 2=e32 3=e64
   *   info->vstart    — first active element
   * ----------------------------------------------------------------------- */

  /* vadd_i32: vd[i] = vs1[i] + vs2[i]  (e32, funct7=0x01, funct3=7) */
  static void insn_vadd_i32(qemu_plugin_nice_info_t *info)
  {
      uint32_t vl = (uint32_t)info->vl;
      int32_t       *vd  = (int32_t *)info->rd_vreg;
      const int32_t *vs1 = (const int32_t *)info->rs1_vreg;
      const int32_t *vs2 = (const int32_t *)info->rs2_vreg;
      for (uint32_t i = (uint32_t)info->vstart; i < vl; i++) {
          vd[i] = vs1[i] + vs2[i];
      }
  }

  /* --- Instruction definition table --------------------------------------- */
  nice_def_t nice_defs[] = {
      /* opcode,  funct7, rs1_enc, rs2_enc, funct3, fn,           call_type,   vsew_enc */

      /* custom-0 integer */
      { 0x0b,     0x00,   CI_ANY,  CI_ANY,  7,      insn_add                           },
      { 0x0b,     0x40,   CI_ANY,  CI_ANY,  7,      insn_mac                           },

      /* custom-1 bitcount (rs2 field = sub-opcode; xs2=0 → funct3=6) */
      { 0x2b,     0x00,   CI_ANY,  1,       6,      insn_popcount                      },

      /* custom-0 FPU (funct7[5]=1 → is_fpu=1; lower bits = FPU sub-opcode) */
      { 0x0b,     0x20,   CI_ANY,  CI_ANY,  7,      insn_fadd,    CI_CALL_F32          },

      /* custom-2 (0x5b) RVV vector — CI_CALL_VEC
       *
       * vadd: same encoding for e8 and e32; vsew_enc routes to the right handler
       *   funct7=0x01 (vm=1=unmasked), funct3=7 (xd=xs1=xs2=1)              */
      { 0x5b,     0x01,   CI_ANY,  CI_ANY,  7,      insn_vadd_i32,CI_CALL_VEC, NICE_VSEW_E32 },

      { CI_TABLE_END, 0, 0, 0, 0, NULL }
  };



On Windows, users should follow the same workflow: keep implementing custom instructions in ``user_nice.c``, build it into a Windows shared library, and pass that generated library through ``lib=``.

Usage Notes
-----------

The following points should also be noted when using the NICE plugin:

* The current dispatch path is used for instructions in ``custom-0``, ``custom-1``, ``custom-2`` and ``custom-3`` opcode spaces. If QEMU enables the ``Xxldsp`` extension at the same time, please **DO NOT** use the ``custom-3`` opcode space. If QEMU enables the ``Xxlcz`` extension at the same time, please **DO NOT** use the ``custom-2`` or ``custom-3`` opcode space.

* Instructions already handled by QEMU built-in decoders will not enter the NICE plugin dispatch path. For example, built-in Nuclei NICE or VNICE instructions that have already been implemented in QEMU will continue to use the built-in implementation.

* When using ``CI_CALL_F32`` or ``CI_CALL_F64``, the corresponding floating-point extension needs to be enabled on the cpu.

* When using ``CI_CALL_VEC``, the cpu needs to enable the RISC-V V extension, otherwise the vector register pointers in the callback context will not be valid.

* If the current instruction does not match any entry in ``nice_defs[]``, QEMU will trigger an illegal instruction exception.
