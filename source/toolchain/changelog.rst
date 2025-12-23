.. _toolchain_changelog:

Changelog
=========

.. note::

    To check the known issues encountered after the toolchain release, please refer to the content at the following link:

    - `Known Issues <https://github.com/riscv-mcu/riscv-gnu-toolchain/issues/18>`_

.. _toolchain_changelog_202510:

Version 2025.10
---------------

.. note::

    - This version is modified based on version 2025.02, only newlib and glibc do upstream version bump
    - Windows toolchain now changed from win32 to win64
    - A lot of known issues are fixed in this release

- Updated toolchain components to these versions: GCC 14.2.1, Binutils 2.44, GDB 16.2, Newlib 4.5.0, LLVM 19.1.7, and GLIBC 2.41.

- Feature: Windows newlib GCC now supports Win32_x64 (64-bit), replacing Win32 (32-bit).

- Feature: Added auto-generation support for the ``Zcmt`` extension.

- Feature: Initial support for ``ECLIC v2`` instructions and CSRs added to Binutils and GDB.

- Feature: Added multilib support for ``Zfinx``, ``Zdinx``, and related extensions.

- Feature: Binutils and GDB now add support for ``Virtual Supervisor-level`` CSRs.

- Feature: Add missing ``fcvt.d.h/fcvt.h.d`` instructions for ``Xxlfbf`` extension.

- Feature: Added ``Xxlvw`` extension support.

- Feature: Add a new ``-maddibne/-mno-addibne`` option to control whether Xxlcz's addibne instruction is auto-generated.

- Performance optimization: Aligned Newlib memory/string routines (memcpy/memset/setjmp/strcmp/strcpy/strlen) to 4-byte boundaries.

- Fixed: Compilation issues with semihosting functions ``_times`` and ``_gettimeofday`` in Newlib.

- Fixed: Incorrect inline assembly translation for the ``clrov`` instruction in Xxldsp (Binutils).

- Fixed: Conflicts between the ``Xxlvfbf`` extension and ``Zvfbfmin/Zvfbfwma`` extensions.

- Fixed: Fix codegen regression in branch condition optimization by removing redundant AND -1 instruction.

- Fixed: Fix unnecessary ``slli/srai`` instruction generation when using int16 type.

- LLVM: Initial implementation of pipeline support for Nuclei processor ``100/200/300/600/900/1000`` series.

- LLVM: Added scalar BFloat16 support for Nuclei processors.

- LLVM: Implemented Nuclei-specific VPU matrix instructions.

- LLVM: Added missing ``Virtual Supervisor-level`` CSRs (hedelegh/medelegh) support in LLVM

- LLVM: Added Nuclei custom macro ``__riscv_dsp``, which can be used instead of ``__riscv_xxldsp`` in the old version.

- LLVM: Added missing instructions ``dkabs32``, ``dsma32.u``, ``clrov``, ``rdov``, ``kmada32``, and ``smbb32``.

- LLVM: Fixed the issue where the Xxldsp extension could not be disassembled correctly.

.. _toolchain_changelog_202502:

Version 2025.02
---------------

- Updated toolchain components to these versions: GCC 14.2.1, Binutils 2.44, GDB 16.2, Newlib 4.4.0, LLVM 19.1.7, and GLIBC 2.40.

- Support for the ``Zilsd`` and ``Zclsd`` extensions.

- Some Nuclei custom CSR naming has been re-revised and corrected.

- Implement custom VPU intrinsics for Nuclei RISC-V CPU.

- Nuclei introduces the ``bf16`` type and supports the ``xxlvfbf`` and ``xxlfbf`` extensions.

- Added support for 3-issue(``nuclei-1000-3w-series``) and 4-issue(``nuclei-1000-4w-series``) in the Nuclei 1000 series CPUs.

- GCC14 introduces additional function attribute checks compared to GCC13. For more details, you can refer to https://gcc.gnu.org/gcc-14/porting_to.html.

- Add the option to automatically generate control for Xldsp with ``-mautovec-dsp/-mno-autovec-dsp`` for gcc, which is enabled by default.

- The ``riscv_vector.h`` must be included when leverage intrinsic type(s) and API(s).  And the scope of this attribute should not exceed the function body.  Meanwhile, to make rvv types and API(s) available for this attribute, include ``riscv_vector.h`` will not report error for now if v is not present in march.

- LLVM: Add Zilsd & Zclsd V1.0 assembly support

- LLVM: Add Nuclei Xxldsp/Xxldspn1x/Xxldspn2x/Xxldspn3x extensions assembly support

- LLVM: Add Nuclei Xxlcz extension assembly support

- LLVM: Add Nuclei Xxlvamacc extension intrinsic support

- LLVM: Update Nuclei custom csrs

- LLVM: Update the multilib list

.. _toolchain_changelog_202406:

Version 2024.06
---------------

- Updated toolchain components to these versions: GCC 13.1, Binutils 2.40, GDB 13.2, Newlib 4.3.0, LLVM 17.0.2, and GLIBC 2.38.

- Instead of using single-letter ``bkp`` to enable these extensions as we did on gcc10, we split them all into corresponding sub-extensions, for example, ``_zba_zkr_zve32f``, please check https://doc.nucleisys.com/nuclei_sdk/develop/buildsystem.html#arch-ext to learn about how to adapt Nuclei SDK to support gcc13 upgraded from gcc10.

- Implement new style of architecture extension test macros: each architecture extension has a corresponding feature test macro, which can be used to test its existence and version information. In addition, we add several custom macros, ``__riscv_dsp``, ``__riscv_bitmanip``.

- Add new option ``-misa-spec=*`` to control ISA spec version. This controls the default version of each extensions. The official version is ``20191213``, but it is set to ``2.2`` when configuring nuclei toolchain.
  The difference between them is that in ``20191213`` version, ``Zicsr`` and ``Zifencei`` are separated from the ``i`` extension into two independent extensions, and using ``-misa-spec=2.2`` can avoid incompatible errors when the ``Zicsr`` and ``Zifencei`` are not passed to ``-march=``. See for details at https://github.com/riscv-collab/riscv-gnu-toolchain/issues/1315

- Support for vector intrinsics as specified in version 0.12 of the RISC-V vector intrinsic specification.

- The toolchain component prefix is ``riscv-nuclei-elf-`` on gcc10, but is ``riscv64-unknown-elf-`` on gcc13.

- On gcc10, RISCV intrinsic api heads contain ``riscv_vector.h``, ``riscv_vector_itr.h``, ``rvintrin.h``, ``rvp_intrinsic.h``, but now only ``riscv_vector.h``, ``rvp_intrinsic.h``, ``riscv_nuclei_xlcz.h`` are provided in gcc13, if you want to find ``b`` or ``k`` intrinsic API, please check https://github.com/riscv/riscv-crypto/blob/main/benchmarks/share/rvintrin.h and https://github.com/riscv/riscv-crypto/blob/main/benchmarks/share/riscv-crypto-intrinsics.h , and for RVV intrinsic API, we
  support 0.12 in gcc13 now, see https://github.com/riscv-non-isa/rvv-intrinsic-doc/releases/tag/v1.0-rc0

- The version of the libncrt was changed from v2.0.0 to v3.0.0, and libncrt is now split into three parts, 'libncrt', 'heapops' and 'fileops', click https://doc.nucleisys.com/nuclei_sdk/develop/buildsystem.html#stdclib to learn about how the newlib/libncrt are used in Nuclei SDK with gcc13.

