.. _toolchain_llvm_intro:

About LLVM Toolchain
====================

The current llvm toolchain is developed based on the upstream V19.1.7, for extensions we supported, check below:

You can find our llvm source code in https://github.com/riscv-mcu/llvm-project/tree/nuclei/19.x

.. note::

    The LLVM toolchain is implemented based on the upstream version. Many features can be referenced in the official LLVM documentation: https://llvm.org/docs/. Please refer to the corresponding LLVM release version in the documentation for accurate details. Local documentation is also available under ``gcc/share/doc/llvm/docs/html`` within the toolchain directory.

Extensions Support
==================

.. rubric:: Ratified Extensions

- Basic Extensions

    i, m, a, f, d, c, h(Assembly only), zaamo, zalrsc, zicsr, zifencei, zihintpause(Assembly only), zicond, zawrs(Assembly only), zfh, zfhmin, zmmul, svinval(Assembly only), svnapot(Assembly only), svpbmt.

- Z*inx Extensions

    zfinx, zdinx, zhinx, zhinxmin.

- CMO Extensions(Assembly only)

    zicboz, zicbom, zicbop.

- Bitmanip Extensions

    zba, zbb, zbc, zbs

- Crypto Extensions

    zbkb, zbkc, zbkx, zknd, zkne, zknh, zkr, zks, zksed, zksh, zkt.

- Vector Extensions

    zve32x, zve32f, zve64x, zve64f, zve64d, zvfh, zvfhmin, v.

- Zc Extensions

    zca, zcb, zce, zcf, zcd, zcmp(Assembly only), zcmt(Assembly only).

- Zvb Extensions

    zvbb, zvbc

- Zvk Extensions

    zvkg, zvkned, zvknha, zvknhb, zvksed, zvksh, zvkn, zvknc, zvkng, zvks, zvksc, zvksg, zvkt.

- Zilsd Extensions

    Zilsd, Zclsd

- Xxlcz Extensions(Assembly only)

    xxlczpstinc, xxlczbmrk, xxlczbitop, xxlczslet, xxlczabs, xxlczmac, xxlczbri, xxlczbitrev, xxlczgp.

- Packed SIMD Extension 0.5.4(Assembly only)

    xxldsp, xxldspn1x, xxldspn2x, xxldspn3x.

    - xxldsp: P-spec-v0.54 + Nuclei Custom EXPD* instructions
    - xxldspn1x: xxldsp + Nuclei Custom N1
    - xxldspn2x: xxldsp + Nuclei Custom N1 & N2
    - xxldspn3x: xxldsp + Nuclei Custom N1 & N2 & N3

    .. note::

        Currently, xxldsp assembly instructions implemented in LLVM only support single registers, while instructions using register pairs under rv32 behave abnormally. See `this issue <https://github.com/riscv-mcu/riscv-gnu-toolchain/issues/34>`_.

- Nuclei custom VPU Extensions

    xxlvqmacc

- Nuclei custom Scalar BFloat16 Extensions

    :ref:`Xxlfbf <toolchain_gnu_nuclei_bf16>`

.. rubric:: Experimental Extensions

LLVM supports (to various degrees) a number of experimental extensions.  All experimental extensions have ``experimental-`` as a prefix. Listed below:

    smaia, ssaia, zacas, zfa, zfbfmin, zvfbfmin, zvfbfwma, zicond, zihintntl, ztso, zvbb, zvbc, zvkg, zvkn, zvknc, zvkned, zvkng, zvknha, zvknhb, zvks, zvksc, zvksed, zvksg, zvksh, zvkt, zilsd, zclsd.

.. note::

    To use an experimental extension from `clang`, you must add ``-menable-experimental-extensions`` to the command line, and specify the exact version of the experimental extension you are using.  To use an experimental extension with LLVM's internal developer tools (e.g. `llc`, `llvm-objdump`, `llvm-mc`), you must prefix the extension name with ``experimental-``.

General Options
===============

`-march=<cpu>`

    Specify that Clang should generate code for a specific processor family member and later. For example, if you specify -march=i486, the compiler is allowed to generate instructions that are valid on i486 and later processors, but which may not exist on earlier ones.

`-mcmodel=<arg>`

    -mcmodel=medany (equivalent to -mcmodel=medium), -mcmodel=medlow (equivalent to -mcmodel=small)

`-mcpu=help, -mtune=help`

    Print out a list of supported processors for the given target (specified through ``--target=<architecture>`` or ``-arch <architecture>``). If no target is specified, the system default target will be used.

`-fno-vectorize`

    Use ``-fno-vectorize`` and ``-fno-slp-vectorize`` to disable LLVM19 automatic vectorization for RVV; by default, automatic vectorization is enabled.

`Optimization Option`

    `-O0`
        Means “no optimization”: this level compiles the fastest and generates the most debuggable code.

    `-O/-O1`
        Somewhere between -O0 and -O2.

    `-O2`
        Moderate level of optimization which enables most optimizations.

    `-O3`
        Like -O2, except that it enables optimizations that take longer to perform or that may generate larger code (in an attempt to make the program run faster).

    `-Ofast`
        Enables all the optimizations from -O3 along with other aggressive optimizations that may violate strict compliance with language standards.

    `-Os`
        Like -O2 with extra optimizations to reduce code size.

For more about RISC-V options used by LLVM toolchain, please check https://releases.llvm.org/19.1.0/docs/RISCVUsage.html

Install and Setup
=================

More information on building and running LLVM, see https://llvm.org/docs/GettingStarted.html#getting-the-source-code-and-building-llvm

Changelog
=========

    Please check :ref:`Changelog <toolchain_changelog>` here.

Checking LLVM Version
=====================

To check the basic version information of LLVM, you can use the command ``riscv64-unknown-elf-clang -v``.

If you need to report an issue to the developers, please provide:

1. The ``gcc/build.txt`` file (located in the GCC directory) for GCC compilation details.

2. The ``gcc/gitrepo.txt`` file to confirm commit IDs of each tool, which helps determine more detailed build information.
