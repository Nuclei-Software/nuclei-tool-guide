.. _libncrt_intro:

About Nuclei C Runtime Library
==============================

``Nuclei C Runtime Library`` is written in standard ANSI C and RISC-V assembly language and can run on RISC-V CPU. Here`s a list summarising the main features of ``Nuclei C Runtime Library``:

**libncrt** is short of ``Nuclei C Runtime Library``.

- Clean ISO/ANSI C source code.
- **Fast assembly language floating point support**.
- Conforms to standard runtime ABIs for the RISC-V architectures.
- ``Nuclei C Runtime Library`` supports RV32 and optimizations for the **B extension and P extension**.
- GCC 10.2 `riscv-nuclei-elf-gcc` to GCC 14 **riscv64-unknown-elf-gcc** for GNU toolchain.
- We also bring ``Nuclei C Runtime Library`` support for **LLVM toolchain**.
- ``Nuclei C Runtime Library`` now separated into three parts, `libncrt`, `'heapops'` and `'fileops'` library.
- Previously, if you want to select a variant of ``Nuclei C Runtime Library``, you can pass ``--specs=libncrt_xxx.specs`` command when using gcc, but now it is not enough, you need to link extra `fileops` and `heapops` static libraries during the linking phase.
- For the `'fileops'` static library, you must select one of the three options: `uart`, `semi` or `rtt`, and for the `'heapops'` static library, you must select one of the three options: `basic`, `realtime` or `minimal`.
- All assembly language routines are valid **zicfilp landing pad** targets when the library is built with CFI landing pad enabled, so indirect calls guarded by the **zicfilp** extension can safely land in runtime library code (see :ref:`zicfilp landing pad usage <libncrt_zicfilp_usage>`).
- ``Nuclei C Runtime Library`` supports the **RISC-V big-endian**: using the big-endian C library requires the tools prefixed with ``riscv64be-unknown-elf-`` together with the ``-mbig-endian`` compile option (see :ref:`Big-endian usage <libncrt_big_endian_usage>`).