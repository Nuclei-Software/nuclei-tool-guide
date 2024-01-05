.. _qemu_intro:

About Nuclei QEMU
===================

Nuclei QEMU is developed based on QEMU version 8.0, supporting the machine features of Nuclei Demosoc and Evalsoc. In terms of extensions, it supports RVV 1.0, Nuclei DSP extension, ZC extension (RISC-V Code Size Reduction), XLCZ extension, as well as features like the B extension, K extension, and Nuclei Nice instructions.

If you want to access the code of Nuclei QEMU, you can visit our opensource `Nuclei QEMU Github Repository <https://github.com/riscv-mcu/qemu/tree/nuclei/8.0>`_.


Design and Architecture
=======================

Nuclei QEMU has several types of parameters that can be configured.
You can enter qemu-system-riscv32 --help to view the parameters that can be configured in Nuclei QEMU. Here are some commonly used parameters:

* ``qemu-system-riscv32`` or ``qemu-system-riscv64``: The main program for the QEMU RISC-V architecture is divided into qemu-system-riscv32 and qemu-system-riscv64. Specifically, qemu-system-riscv32 corresponds to 32-bit architecture CPUs such as N200, N300, N600, and others. On the other hand, qemu-system-riscv64 corresponds to 64-bit architecture CPUs like NX600, NX900, and similar series. U-series processors come with an MMU (Memory Management Unit) and are capable of running Linux.The following image displays the CPU types supported by Nuclei QEMU.

.. figure:: /asserts/images/qemu_nuclei_cpus_support.png
   :align: center
   :alt: Nuclei QEMU CPUs Support

* ``-M nuclei_evalsoc,download=ilm``: ``-M`` represents ``machine``, which means selecting the type of machine. Currently, Nuclei QEMU has added "nuclei_demosoc" (which will be deprecated in future versions) and "nuclei_evalsoc" to the existing options. "download=" is used to choose the download mode, and currently, it supports four download modes: ``flashxip, flash, ilm, and ddr``.

* ``-cpu nuclei-nx900fd,ext=_xxldsp``: Using the ``-cpu`` option, you can specify the type of Nuclei core.The way to enable different extensions is to add them inside it, for example, 'xxldsp' represents enabling the CoreXtend DSP extension. Currently, Nuclei QEMU supports the following common RISC-V instruction set extension types:

+--------------+-------------------------------------------------------------------------+
| Extension Name       | Extension Functionality                                         |
+==============+=========================================================================+
| v            | RISC-V V-Extension                                                      |
+--------------+-------------------------------------------------------------------------+
| h            | RISC-V H-Extension                                                      |
+--------------+-------------------------------------------------------------------------+
| zicbom       | RISC-V Zicbom Extension                                                 |
+--------------+-------------------------------------------------------------------------+
| zicboz       | RISC-V Zicboz Extension                                                 |
+--------------+-------------------------------------------------------------------------+
| zicond       | RISC-V Zicond Extension                                                 |
+--------------+-------------------------------------------------------------------------+
| zicsr        | RV32/RV64 Zicsr Standard Extension                                      |
+--------------+-------------------------------------------------------------------------+
| zifencei     | RV32/RV64 Zifencei Standard Extension                                   |
+--------------+-------------------------------------------------------------------------+
| zihintpause  | ZiHintPause extension                                                   |
+--------------+-------------------------------------------------------------------------+
| zawrs        | Zawrs extension                                                         |
+--------------+-------------------------------------------------------------------------+
| zfh          | Zfh  Extension                                                          |
+--------------+-------------------------------------------------------------------------+
| zfa          | Zfa  Extension                                                          |
+--------------+-------------------------------------------------------------------------+
| zfhmin       | Zfhmin Extension                                                        |
+--------------+-------------------------------------------------------------------------+
| zfinx        | Zfinx  Extension                                                        |
+--------------+-------------------------------------------------------------------------+
| zdinx        | Zdinx  Extension                                                        |
+--------------+-------------------------------------------------------------------------+
| zca          | RISC-V ZC* Extension                                                    |
+--------------+-------------------------------------------------------------------------+
| zcb          | RISC-V ZC* Extension                                                    |
+--------------+-------------------------------------------------------------------------+
| zcf          | RISC-V ZC* Extension                                                    |
+--------------+-------------------------------------------------------------------------+
| zcd          | RISC-V ZC* Extension                                                    |
+--------------+-------------------------------------------------------------------------+
| zce          | RISC-V ZC* Extension                                                    |
+--------------+-------------------------------------------------------------------------+
| zcmp         | RISC-V ZC* Extension                                                    |
+--------------+-------------------------------------------------------------------------+
| zcmt         | RISC-V ZC* Extension                                                    |
+--------------+-------------------------------------------------------------------------+
| zba          | RISC-V Bitmanipulation Extension                                        |
+--------------+-------------------------------------------------------------------------+
| zbb          | RISC-V Bitmanipulation Extension                                        |
+--------------+-------------------------------------------------------------------------+
| zbc          | RISC-V Bitmanipulation Extension                                        |
+--------------+-------------------------------------------------------------------------+
| zbkb         | RISC-V Bitmanipulation Extension                                        |
+--------------+-------------------------------------------------------------------------+
| zbkc         | RISC-V Bitmanipulation Extension                                        |
+--------------+-------------------------------------------------------------------------+
| zbkx         | RISC-V Bitmanipulation Extension                                        |
+--------------+-------------------------------------------------------------------------+
| zbs          | RISC-V Bitmanipulation Extension                                        |
+--------------+-------------------------------------------------------------------------+
| zk           | RISC-V Scalar Crypto Extension                                          |
+--------------+-------------------------------------------------------------------------+
| zkn          | RISC-V Scalar Crypto Extension                                          |
+--------------+-------------------------------------------------------------------------+
| zknd         | RISC-V Scalar Crypto Extension                                          |
+--------------+-------------------------------------------------------------------------+
| zkne         | RISC-V Scalar Crypto Extension                                          |
+--------------+-------------------------------------------------------------------------+
| zknh         | RISC-V Scalar Crypto Extension                                          |
+--------------+-------------------------------------------------------------------------+
| zkr          | RISC-V Scalar Crypto Extension                                          |
+--------------+-------------------------------------------------------------------------+
| zks          | RISC-V Scalar Crypto Extension                                          |
+--------------+-------------------------------------------------------------------------+
| zksed        | RISC-V Scalar Crypto Extension                                          |
+--------------+-------------------------------------------------------------------------+
| zksh         | RISC-V Scalar Crypto Extension                                          |
+--------------+-------------------------------------------------------------------------+
| zkt          | RISC-V Scalar Crypto Extension                                          |
+--------------+-------------------------------------------------------------------------+
| zve32f       | RISC-V V-Extension                                                      |
+--------------+-------------------------------------------------------------------------+
| zve64f       | RISC-V V-Extension                                                      |
+--------------+-------------------------------------------------------------------------+
| zve64d       | RRISC-V V-Extension                                                     |
+--------------+-------------------------------------------------------------------------+
| zvfh         | RISC-V V-Extension                                                      |
+--------------+-------------------------------------------------------------------------+
| zvfhmin      | RISC-V V-Extension                                                      |
+--------------+-------------------------------------------------------------------------+
| zhinx        | Zhinx  Extension                                                        |
+--------------+-------------------------------------------------------------------------+
| zhinxmin     | Zhinxmin  Extension                                                     |
+--------------+-------------------------------------------------------------------------+
| smaia        | Smaia   Extension                                                       |
+--------------+-------------------------------------------------------------------------+
| ssaia        | Ssaia  Extension                                                        |
+--------------+-------------------------------------------------------------------------+
| sscofpmf     | Sscofpmf  Extension                                                     |
+--------------+-------------------------------------------------------------------------+
| sstc         | Sstc  Extension                                                         |
+--------------+-------------------------------------------------------------------------+
| svadu        | Svadu Extension                                                         |
+--------------+-------------------------------------------------------------------------+
| svinval      | Svinval Extension                                                       |
+--------------+-------------------------------------------------------------------------+
| svnapot      | Svnapot Extension                                                       |
+--------------+-------------------------------------------------------------------------+
| svpbmt       | Svpbmt Extension                                                        |
+--------------+-------------------------------------------------------------------------+
| xxldsp       | Nuclei DSP Extension based on P-ext 0.5.4 + default 8 EXPD instructions |
+--------------+-------------------------------------------------------------------------+
| xxldspn1x    | Xxldsp + Nuclei N1 extension                                            |
+--------------+-------------------------------------------------------------------------+
| xxldspn2x    | Xxldspn1x + Nuclei N2 extension                                         |
+--------------+-------------------------------------------------------------------------+
| xxldspn3x    | Xxldspn2x + Nuclei N3 extension                                         |
+--------------+-------------------------------------------------------------------------+
| xxlcz        | Nuclei code size reduction extension                                    |
+--------------+-------------------------------------------------------------------------+

Use Nuclei QEMU in Nuclei SDK
=============================

**Setup Tools and Environment**

1. Download the `nuclei-sdk <https://github.com/Nuclei-Software/nuclei-sdk>`_, checkout to ``master`` branch.

2. Download RISC-V GNU Toolchain form `Nuclei Download Center <https://nucleisys.com/download.php>`_.

3. Set up the system environment variables to ensure that the directories containing ``riscv64-unknown-elf-gcc`` and ``qemu-system-riscv32`` are included in the global system variable environment.

**Example**

If you want to use QEMU on Nuclei-SDK, entry to the ``nuclei-sdk/application/baremetal/demo_dsp/`` and run ``make CORE=nx900fd SOC=evalsoc DOWNLOAD=ilm ARCH_EXT=_xxldsp clean dasm run_qemu``.

Where **ARCH_EXT** can be used to pass the extension name.
Under normal circumstances, you should see the final output ``NMSIS_TEST_PASS``, which indicates that all test cases have passed successfully.

And Nuclei QEMU and Nuclei SDK are deeply integrated in Nuclei Studio, you can also use it in Nuclei Studio, see https://nucleisys.com/upload/files/doc/nucleistudio/Nuclei_Studio_User_Guide.202310.pdf

Use Nuclei QEMU in Nuclei Linux SDK
===================================

Nuclei QEMU can also used to boot and test RISC-V Linux Kernel using emulated Nuclei EvalSoC, please check documentation
here https://github.com/Nuclei-Software/nuclei-linux-sdk#booting-linux-on-nuclei-qemu

