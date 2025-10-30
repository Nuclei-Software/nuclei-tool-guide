.. _toolchain_gnu_intro:

About GNU Toolchain
===================

The official toolchain repository is located at https://github.com/riscv-collab/riscv-gnu-toolchain.git.

Nuclei maintained toolchain repo is located at https://github.com/riscv-mcu/riscv-gnu-toolchain.

The latest release **2025.10** branch for gcc14 and llvm19 is ``nuclei/2025.10``, in which the tools included versions are: gcc 14.2.1, binutils 2.44, gdb 16.2, newlib 4.5.0, llvm 19.1.7, glibc 2.41, and also have merged some important patches from their upstream, as well as additional support for Nuclei custom extensions and pipelines, etc.

.. note::

    The toolchain is implemented based on the upstream version. Many features can be referenced in the GCC online documentation: https://gcc.gnu.org/onlinedocs/. Please check the corresponding GNU release version in the online documentation for accurate details. Additionally, local documentation is available under ``gcc/share/doc`` in the toolchain directory.

Extensions Support
==================

.. rubric:: Standard Extensions

- Basic Extensions

    i, m, a, f, d, c, h, q(Assembly only), zaamo, zalrsc, zicsr, zifencei, zicond, zawrs, zfh, zfhmin, zmmul, svinval, svnapot.

- Z*Inx Extensions

    zfinx, zdinx, zhinx, zhinxmin.

- CMO Extensions

    zicboz, zicbom, zicbop.

- Bitmanip Extensions

    zba, zbb, zbc, zbs

- Crypto Extensions

    zbkb, zbkc, zbkx, zknd, zkne, zknh, zkr, zks, zksed, zksh, zkt.

- Vector Extensions

    zve32x, zve32f, zve64x, zve64f, zve64d, zvfh, zvfhmin, v.

- Zc Extensions

    zca, zcb, zce, zcf, zcd, zcmp, zcmt.

    - zce = zca + zcb + zcmp + zcmt
    - f + zce =  zca + zcb + zcf + zcmp + zcmt
    - f + d + zce =  zca + zcb + zcf + zcd + zcmp + zcmt

- Zvb Extensions

    zvbb, zvbc

- Zvk Extensions

    zvkg, zvkned, zvknha, zvknhb, zvksed, zvksh, zvkn, zvknc, zvkng, zvks, zvksc, zvksg, zvkt.

- BFloat 16 Extensions

    - Standard: Zfbfmin, Zvfbfmin, Zvfbfwma
    - Nuclei customized: :ref:`Xxlfbf, Xxlvfbf <toolchain_gnu_nuclei_bf16>`

- Zilsd Extensions

    Zilsd, Zclsd

.. rubric:: Nuclei Custom Extensions

- Packed SIMD Extension 0.5.4

    xxldsp, xxldspn1x, xxldspn2x, xxldspn3x.

    - xxldsp: P-spec-v0.54 + Nuclei Custom EXPD* instructions
    - xxldspn1x: xxldsp + Nuclei Custom N1
    - xxldspn2x: xxldsp + Nuclei Custom N1 & N2
    - xxldspn3x: xxldsp + Nuclei Custom N1 & N2 & N3

- Xxlcz Extensions

    xxlczpstinc, xxlczbmrk, xxlczbitop, xxlczslet, xxlczabs, xxlczmac, xxlczbri, xxlczbitrev, xxlczgp.

- Nuclei custom VPU Extensions

    :ref:`xxlvqmacc <toolchain_gnu_nuclei_vpu>`

- Nuclei custom XXLVW Extensions

    :ref:`xxlvvw <toolchain_gnu_nuclei_xxlvw>`

.. note::

    Extensions starting with **x** are generally reserved for manufacturers to customize, and should be placed after extensions starting with **z** when used.


General Options
===============

`-march=ISA-string`

    Generate code for given RISC-V ISA. ISA strings must be lower-case. Examples include ``rv64i``, ``rv32g``, ``rv32e``, and ``rv32imaf``. When ``-march=`` is not specified, use the setting from ``-mcpu``. If both ``-march`` and ``-mcpu=`` are not specified, the default for this argument is system dependent, users who want a specific architecture extensions should specify one explicitly.

`-mabi=ABI-string`

    Specify integer and floating-point calling convention. ABI-string contains two parts: the size of integer types and the registers used for floating-point types. For example ``-march=rv64ifd -mabi=lp64d`` means that **long** and **pointers** are 64-bit (implicitly defining **int** to be 32-bit), and that floating-point values up to 64 bits wide are passed in F registers. Contrast this with ``-march=rv64ifd -mabi=lp64f``, which still allows the compiler to generate code that uses the F and D extensions but only allows floating-point values up to 32 bits long to be passed in registers; or ``-march=rv64ifd -mabi=lp64``, in which no floating-point arguments will be passed in registers.

    The default for this argument is system dependent, users who want a specific calling convention should specify one explicitly. The valid calling conventions are: ``ilp32``, ``ilp32f``, ``ilp32d``, ``lp64``, ``lp64f``, and ``lp64d``. Some calling conventions are impossible to implement on some ISAs: for example, ``-march=rv32if -mabi=ilp32d`` is invalid because the ABI requires 64-bit values be passed in F registers, but F registers are only 32 bits wide. There is also the ``ilp32e`` ABI that can only be used with the ``rv32e`` architecture. This ABI is not well specified at present, and is subject to change.

`-mcmodel=medlow`

    Generate code for the medium-low code model. The program and its statically defined symbols must lie within a single 2 GiB address range and must lie between absolute addresses -2 GiB and +2 GiB. Programs can be statically or dynamically linked. This is the default code model.

`-mcmodel=medany`

    Generate code for the medium-any code model. The program and its statically defined symbols must be within any single 2 GiB address range. Programs can be statically or dynamically linked.

    The code generated by the medium-any code model is position-independent, but is not guaranteed to function correctly when linked into position-independent executables or libraries.

`-mtune=processor-string`

    Optimize the output for the specified processor by either microarchitecture or a specific CPU name. The allowable values for this option include: ``nuclei-100-series``, ``nuclei-200-series``, ``nuclei-300-series``, ``nuclei-600-series``, ``nuclei-900-series``, ``nuclei-1000-series``, ``nuclei-1000-3w-series``, and ``nuclei-1000-4w-series``. Note that ``nuclei-1000-series`` and ``nuclei-1000-4w-series`` are considered equivalent. All these options are valid for the -mcpu= flag.

    When ``-mtune=`` is not specified, use the setting from ``-mcpu``, the default is ``rocket`` if both are not specified.

    The ``size`` choice is not intended for use by end-users. This is used when -Os is specified. It overrides the instruction cost info provided by ``-mtune=``, but does not override the pipeline info. This helps reduce code size while still giving good performance.

`-mautovec-dsp/-mno-autovec-dsp`

    Controls the generation of automatic vectorization of Nuclei DSP instructions, with the compiler enabling Nuclei DSP instructions instruction auto-vectorization by default.

`-maddibne/-mno-addibne`

    Controls auto-generation of the ``addibne`` instruction for the ``xxlcz`` extension. Enabled by default.

`-fstrict-aliasing`

    It is recommended to add the optimization option ``-fno-strict-aliasing`` to the project, In some circumstances, this flag allows the compiler to assume that pointers to different types do not alias.

`-ftree-loop-vectorize`

    If you need to disable the RISC-V RVV automatic vectorization, you can use the options ``-fno-tree-loop-vectorize`` and ``-fno-tree-slp-vectorize``. For GCC 13, you can use ``--param=riscv-autovec-preference=none``.

`-fno-builtin`

    The ``-fno-builtin`` option instructs the compiler to avoid replacing standard library function calls with optimized built-in versions. If your program requires implementing its own system functions, such as memcpy, memset, etc., you need to use this option.

`Optimization Options`

    `-O0`
        Reduce compilation time and make debugging produce the expected results. This is the default.

    `-O/-O1`
        With -O, the compiler tries to reduce code size and execution time, without performing any optimizations that take a great deal of compilation time.

    `-O2`
        Optimize even more. GCC performs nearly all supported optimizations that do not involve a space-speed tradeoff. As compared to -O, this option increases both compilation time and the performance of the generated code.

    `-O3`
        This option turns on all options in -O2, as well as several other optimizations to improve the performance of the object code.

    `-Os`
        This optimization option is often used to tell the compiler to reduce the size of the object code as much as possible while maintaining performance. It will remove some optimization strategies that increase the object code size from all options enabled by -O2.

    `-Ofast`
        Disregard strict standards compliance. -Ofast enables all -O3 optimizations. It also enables optimizations that are not valid for all standard-compliant programs.

For more information about RISC-V Options used in GCC, please check https://gcc.gnu.org/onlinedocs/gcc-14.2.0/gcc/RISC-V-Options.html

For RISC-V ELF psABI Document, please check https://github.com/riscv-non-isa/riscv-elf-psabi-doc


Libraries
=========

.. note::

   - ``glibc`` is used in Linux GNU Glibc toolchain used to compile linux kernel, opensbi, uboot, and linux applications.
   - ``newlibc`` is used in Baremetal or RTOS toolchain, used to compile baremetal or rtos source code, which contains ``newlib``, ``newlib-nano`` and :ref:`libncrt <libncrt_intro>`

`glibc`

    glibc stands for GNU C Library which is the standard system C library for all GNU systems. It provides the system API for all programs written in C and C-compatible languages such as C++ and Objective C; the runtime facilities of other programming languages use the C library to access the underlying operating system. This library is only supported on Nuclei linux toolchain, not on Nuclei bare-metal toolchain.

`newlib`

    newlib is written as a glibc replacement for embedded systems. It can be used with no OS (“bare metal”) or with a lightweight RTOS. Newlib is the default library for embedded GCC distributions.

`newlib-nano`

    Newlib-nano is a derivative of the newlib C library for embedded systems. It is smaller and faster than newlib by code and data size reduction through optimization and removal of non-MCU features. 

:ref:`libncrt <libncrt_intro>`

    ``libncrt`` is short of **Nuclei C Runtime Library**, which currently support Nuclei RV32 processor, which is released by Nuclei to reduce c library code size, and improve math library speed, for details, please refer to the user guide located in ``gcc\share\pdf\Nuclei C Runtime Library Doc.pdf``

Changelog
=========

    Please check :ref:`Changelog <toolchain_changelog>` here.

Install and Setup
=================

.. rubric:: Build Toolchain

For more information about how to build a toolchain, see https://github.com/riscv-mcu/riscv-gnu-toolchain/tree/nuclei/2025/scripts/toolchain. (Only for Nuclei internal use, no technical support is provided)

.. rubric:: Development

The process of user compilation and development can see from https://github.com/riscv-mcu/riscv-gnu-toolchain/blob/nuclei/2025/README.md. To get other technical support, please send issues directly to the upstream repository https://github.com/riscv-collab/riscv-gnu-toolchain.

.. rubric:: Examples

1. If you choose a core of Nuclei N300FD, then the parameter you pass to 'march' should be ``rv32*fd*``, and 'mabi' should choose ``ilp32d``.

2. If you want to bring the full ``B/K/P`` extension, then you also need to bring all the subsets of them in the 'march'. For example, for the ``B`` extension, the parameter you pass to 'march' is ``_zba_zbb_zbc_zbs``.

3. When using a library, we can tell the linker which library we need to link by using the '-l', for example, ``-lc`` for newlib-full, ``-lc_nano`` for newlib-nano. For libncrt, you should pass ``--specs=libncrt_xxx.specs`` when using gcc. In addition, you need to link extra 'fileops' and 'heapops' static libraries during the linking phase by using the '-l', and for the 'fileops', you must select one of the three options: 'uart', 'semi' or 'rtt',
and for the 'heapops', you must select one of the three options: 'basic', 'realtime' or 'minimal'.


Checking GNU Version
====================

To check the basic version information of GCC, you can use the command ``riscv64-unknown-elf-gcc -v``.

If you need to report an issue to the developers, please provide:

1. The ``gcc/build.txt`` file (located in the GCC directory) for GCC compilation details.

2. The ``gcc/gitrepo.txt`` file to confirm commit IDs of each tool, which helps determine more detailed build information.

Known Issues
============

``sscanf`` Format Specifiers Issue in Newlib-nano
-------------------------------------------------

sscanf fails with hhu, llu, etc., due to missing C99 support (%hhX, %llX, %jX, %zX, %tX).

References:

- https://docs.zephyrproject.org/latest/develop/languages/c/newlib.html

- https://github.com/32bitmicro/newlib-nano-1.0/blob/master/newlib/README.nano


GDB RISC-V Memory Access at Address 0 When Symbols Are Missing
--------------------------------------------------------------

When debugging a RISC-V target via OpenOCD+GDB, running a stepping command (si) before loading an ELF with symbols causes GDB to incorrectly read memory near address 0x0.

References:

- https://github.com/riscv-mcu/riscv-openocd/issues/16

