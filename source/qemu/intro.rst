.. _qemu_intro:

About Nuclei QEMU
===================

Nuclei QEMU is developed based on QEMU version 8.0, supporting the machine features of Nuclei Demosoc and Evalsoc. In terms of extensions, it supports RVV 1.0, Nuclei DSP extension, ZC extension (RISC-V Code Size Reduction), Nuclei Xlcz extension, as well as features like the B extension, K extension, and Nuclei Nice instructions.

If you want to access the code of Nuclei QEMU, you can visit our opensource `Nuclei QEMU Github Repository <https://github.com/riscv-mcu/qemu/tree/nuclei/8.0>`_.


Design and Architecture
=======================

Nuclei QEMU has several types of parameters that can be configured.
You can enter qemu-system-riscv32 --help to view the parameters that can be configured in Nuclei QEMU. Here are some commonly used parameters:

* ``qemu-system-riscv32`` or ``qemu-system-riscv64``: The main program for the QEMU RISC-V architecture is divided into ``qemu-system-riscv32`` and ``qemu-system-riscv64``.

  ``qemu-system-riscv32`` corresponds to 32-bit architecture CPUs such as N200, N300, N600, and others. On the other hand, ``qemu-system-riscv64`` corresponds to 64-bit architecture CPUs like NX600, NX900, and similar series. U-series processors come with an MMU (Memory Management Unit) and are capable of running Linux. The following image displays the CPU types supported by Nuclei QEMU.

  .. figure:: /asserts/images/qemu_nuclei_cpus_support.png
     :align: center
     :alt: Nuclei QEMU CPUs Support

* ``-M nuclei_evalsoc,download=ddr,soc-cfg=evalsoc.json``:

  ``-M`` represents ``machine``, which means selecting the type of machine. Currently, Nuclei QEMU has added "nuclei_demosoc" (which will be deprecated in future versions) and "nuclei_evalsoc" to the existing options.

  ``download=`` is used to choose the download mode, and currently, it supports four download modes: ``sram, flashxip, flash, ilm, and ddr``.

  ``soc-cfg=`` is an optional option to pass dynamic modifications to the initial configuration of the machine with a json file. Here is an example:

  .. code-block:: json

    {
        "general_config": {
            "ddr": {
                    "base":"0x70000000",
                    "size":"2G"
            },
            "ilm": {
                    "base":"0x90000000",
                    "size":"0x100000"
            },
            "dlm": {
                    "base":"0xA0000000",
                    "size":"0x100000"
            },
            "sram": {
                    "base":"0xB0000000",
                    "size":"0x10000000"
            },
            "norflash": {
                    "base":"0x30000000",
                    "size":"32M"
            },
            "uart0": {
                    "base":"0x20013000",
                    "irq":"34"
            },
            "uart1": {
                    "base":"0x20023000",
                    "irq":"35"
            },
            "qspi0": {
                    "base":"0x20014000",
                    "irq":"36"
            },
            "qspi2": {
                    "base":"0x20034000",
                    "irq":"37"
            },
            "iregion": {
                    "base":"0x1000000"
            },
            "cpu_freq":"50000000",
            "timer_freq":"32768",
            "irqmax":"100"
        },
        "download": {
            "ilm": {
                    "startaddr":"0x90000000"
            },
            "flashxip": {
                    "startaddr":"0x30000000"
            },
            "flash": {
                    "startaddr":"0x30000000"
            },
            "sram": {
                    "startaddr":"0xB0000000"
            },
            "ddr": {
                    "startaddr":"0x70000000"
            }
        }
    }

  **general_config** : mainly used to configure the board resource or chip base address

  **base**: module base address, only support hex format

  **size**: module size, support hex, dec, size string format

  **irq**: peripheral interrupt id, dec format

  **download**: firmware startup address

  The irq peripheral interrupt id is equal to hardware interrupt wire connect number plus one, users should follow this rule when configuring irq.

  +-----------+-------------------+--------+
  | IRQ_HW_ID | PLIC Interrupt ID | Source |
  +===========+===================+========+
  | 32        | 33                | uart0  |
  +-----------+-------------------+--------+
  | 34        | 35                | qspi0  |
  +-----------+-------------------+--------+
  | 35        | 36                | qspi1  |
  +-----------+-------------------+--------+
  | 36        | 37                | qspi2  |
  +-----------+-------------------+--------+

  In the above script, if there is no **download startaddr** information, the program entry will be the start address of the address range relative to the download mode. For example, when ``download=ilm``, if the following configuration is not in the script,

  .. code-block:: json

    "download": {
            "ilm": {
                    "startaddr":"0x90000000"
            }

  then the ilm base in **general_config** will be used as the program start address by default.

  .. code-block:: json

    "general_config": {
         "ilm": {
                 "base":"0x90000000",
                 "size":"0x100000"
         }

  Other configurations follow this rule as well.

  .. note::

        In the **general_config** JSON configuration script, the **base** attribute must coexist with either **size** or **irq**, and the format requires **base** to be written first, followed by either **size** or **irq**.



* ``-cpu nuclei-nx900fd,ext=_xxldsp``: Using the ``-cpu`` option, you can specify the type of Nuclei core. The way to enable different extensions is to add them inside it, for example, 'xxldsp' represents enabling the CoreXtend DSP extension. Currently, Nuclei QEMU supports the following common RISC-V instruction set extension types:

  +--------------+-------------------------------------------------------------------------+
  | Extension    | Functionality                                                           |
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
  | zilsd        | Zilsd extension (RV32 ONLY)                                             |
  +--------------+-------------------------------------------------------------------------+
  | zcmlsd       | Zcmlsd extension (RV32 ONLY)                                            |
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
  | zve32x       | RISC-V V-Extension                                                      |
  +--------------+-------------------------------------------------------------------------+
  | zve32f       | RISC-V V-Extension                                                      |
  +--------------+-------------------------------------------------------------------------+
  | zve64x       | RISC-V V-Extension                                                      |
  +--------------+-------------------------------------------------------------------------+
  | zve64f       | RISC-V V-Extension                                                      |
  +--------------+-------------------------------------------------------------------------+
  | zve64d       | RISC-V V-Extension                                                      |
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

* ``-m 512M``: To set the DDR size in QEMU, if the DDR size is not passed with ``-m``, then the JSON config will be used to determine the size, and lastly, if neither is specified, it will initialize with 32MB.

  .. note::

        The following is the current default qemu memory size configuration, **xip: 32MB**, **ddr:64MB**, **ilm: 8MB**, **dlm: 8MB**, **sram: 512MB**. You can change the size of the DDR by using **-m size**. When **-m 128M** or no -m is passed, the default DDR size configured in the JSON or the size initialized by the program will be used. If the DDR size is configured too large and the computer does not have enough memory to allocate, an error such as **qemu-system-riscv32: cannot set up guest memory 'riscv.evalsoc.ram.sram'** may occur.

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

And Nuclei QEMU and Nuclei SDK are deeply integrated in Nuclei Studio, you can also use it in Nuclei Studio, see https://nucleisys.com/upload/files/doc/nucleistudio/Nuclei_Studio_User_Guide.202402.pdf

Use Nuclei QEMU in Nuclei Linux SDK
===================================

Nuclei QEMU can also used to boot and test RISC-V Linux Kernel using emulated Nuclei EvalSoC, please check documentation
here https://github.com/Nuclei-Software/nuclei-linux-sdk#booting-linux-on-nuclei-qemu

