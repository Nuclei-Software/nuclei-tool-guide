.. _xlmodel_intro:

About Nuclei Near Cycle Model
=============================

The ``Nuclei Near Cycle Model`` (referred to as `xlmodel`) is a co-simulation using **SystemC TLM-2 combined with xlspike**. Xlspike uses spike as the RISC-V ISA simulator and adds support for Nuclei's N/NX/UX RISC-V processors.
SystemC establishes the TLM 2.0 interaction relationships among the components under **Nuclei EvalSoC**.

- The `xlmodel` can be obtained in **Nuclei Studio 2026.10**.
- The `xlmodel` is supported on both **Linux and Windows** system.
- The `xlmodel` supports **GDB debugging** capabilities (GDB RSP interface) with Nuclei Studio, including **SMP multi-thread debugging**, breakpoints and watchpoints.
- The `xlmodel` is a **near cycle model** that can test the performance of firmware with different ISA configurations.
- The `xlmodel` has SystemC built-in and uses version 2.3.4 by default.
- The `xlmodel` has built-in **gprof** functionality, offering a detailed view of the functions call graph and the cycle count distribution across functions in the test code.
- The `xlmodel` supports **flame graph** generation for visualizing call stack performance and multi-core/multi-threaded application execution.
- The `xlmodel` supports **semihosting** (guest ``printf``/file-I/O/exit via the RISC-V semihosting convention).
- The `xlmodel` can run **big-endian** RISC-V ELF files directly; target endianness is detected from the ELF header.
- The `xlmodel` can boot a **RISC-V Linux kernel** with the Nuclei Linux SDK, in both uniprocessor and SMP mode. See :ref:`xlmodel_linux_sdk`.
- The `xlmodel` supports SoC configuration through a ``soc-cfg`` JSON file, and provides a ``--fastmode`` option for maximum functional simulation speed.
- The `xlmodel` can easily extend **user-defined** instructions, namely **Nuclei NICE instructions**.
- Xlspike supports RV32IMAFDCBPV and RV64IMAFDCBPV ISA.

Since this model is also integrated in Nuclei Studio, you can use it to do

- Profiling and Code Coverage

  - Demonstrating the acceleration of Nuclei Model NICE/VNICE instructions through Profiling: https://doc.nucleisys.com/nuclei_studio_supply/18-demonstrate_NICE_VNICE_acceleration_of_the_Nuclei_Model_through_profiling/
  - Nuclei Model combined with Nice Wizard for rapid verification of NICE/VNICE instruction acceleration: https://doc.nucleisys.com/nuclei_studio_supply/19-rapid_verification_of_NICE_VNICE_acceleration_with_Nuclei_Model_and_NICE_Wizard/
  - :ref:`ide_advanceusage_profiling`
- NICE Instruction Design and Modeling
  - :ref:`ide_nuclei_nice_wizard`
- Debugging in Nuclei Studio
  - :ref:`ide_nuclei_model_debugger`
- Flame Graph
  - :ref:`Nuclei Studio use xlmodel flame graph <ide_nuclei_model_flame>`

.. note::

  Before using `xlmodel`, you should check the current version using the ``--version`` parameter to verify whether it is the latest release. The version output also contains the git commit hash of the build.

The version output of the current latest version is

.. code-block:: text

        SystemC 2.3.4-Accellera --- May 16 2024 16:02:03
        Copyright (c) 1996-2022 by all Contributors,
        ALL RIGHTS RESERVED
   [XLMODEL-INFO] xl_cpumodel Commit: 4175eb9
   [XLMODEL-INFO] xl_cpumodel Version 2026.10 - 1.3.0, Build Time Oct 30 2026, 18:29:51


Design and Architecture
=======================

.. _xlmodel_systemc_components:

SystemC components
------------------

Brief description of the `xlmodel` SystemC components:

* Evalsoc: SystemC modeling of EvalSoC, including the binding relationships of all components and load image functionality
* Cluster: Modeling of single-core or multi-core CPU, using xlspike internally to execute instructions
* Bus: Simple bus manager
* Memory: Simple memory, including default sram/ddr iregion and flashxip iregion
* Timer: Nuclei SysTimer unit (ECLIC mode and CLINT-compatible window)
* Cidu: Core Interrupt Distribution Unit for multi-core interrupt routing, inter-core interrupts and semaphores
* EvalUart: Nuclei EvalSoC UART
* EvalQspi: Nuclei EvalSoC QSPI

Address Allocation of Evalsoc in xlmodel
----------------------------------------

The following table shows the default EvalSoC address map in `xlmodel`. Memory regions and peripherals can be relocated or resized with command-line options (such as ``--ddrbase`` and ``--ddrsz``) or through ``soc-cfg``. IREGION devices use fixed offsets from ``iregion.base``, whose default value is ``0x18000000``.

.. list-table:: Default EvalSoC address map
   :header-rows: 1
   :align: center
   :widths: 16 18 18 18 30

   * - Type
     - Component
     - Base address
     - Size
     - Description
   * - Memory
     - XIP/NOR flash
     - ``0x20000000``
     - ``0x10000000``
     - Boot flash and XIP memory.
   * - Memory
     - DDR
     - ``0x80000000``
     - ``0x04000000``
     - General-purpose system memory; enlarge it when booting Linux.
   * - Memory
     - ILM
     - ``0x80000000``
     - ``0x00800000``
     - Instruction local memory.
   * - Memory
     - DLM
     - ``0x90000000``
     - ``0x00800000``
     - Data local memory.
   * - Memory
     - SRAM
     - ``0xA0000000``
     - ``0x20000000``
     - On-chip SRAM address window.
   * - Fixed peripheral
     - UART0
     - ``0x10013000``
     - ``0x00001000``
     - EvalSoC serial controller.
   * - Fixed peripheral
     - QSPI0
     - ``0x10014000``
     - ``0x00001000``
     - SPI/QSPI controller.
   * - Fixed peripheral
     - QSPI1
     - ``0x10024000``
     - ``0x00001000``
     - SPI/QSPI controller.
   * - Fixed peripheral
     - QSPI2
     - ``0x10034000``
     - ``0x00001000``
     - SPI/QSPI controller.
   * - IREGION
     - ECLIC
     - ``iregion + 0x20000``
     - ``0x00010000``
     - Nuclei ECLIC unit.
   * - IREGION
     - TIMER
     - ``iregion + 0x30000``
     - ``0x00010000``
     - Nuclei SysTimer/CLINT-compatible window.
   * - IREGION
     - SMP/CC
     - ``iregion + 0x40000``
     - ``0x00001000``
     - SMP and cluster-cache control unit.
   * - IREGION
     - CIDU
     - ``iregion + 0x50000``
     - ``0x00010000``
     - Core interrupt distribution unit.
   * - IREGION
     - PLIC
     - ``iregion + 0x4000000``
     - ``0x04000000``
     - Platform-level interrupt controller.

For details, please see :ref:`xlmodel_description_of_parameters`.

Nuclei CPU Features Supported in xlmodel
----------------------------------------

The following table summarizes the current implementation status.

.. list-table:: Nuclei feature status
   :header-rows: 1
   :widths: 25 75

   * - Feature
     - Status
   * - NMI
     - Supported.
   * - TIMER
     - Supported; see :ref:`xlmodel_support_status_of_timer`.
   * - PLIC
     - Supported; see :ref:`xlmodel_support_status_of_plic`.
   * - ECLIC v1/v2
     - Supported; see :ref:`xlmodel_support_status_of_eclic`.
   * - CIDU
     - Supported; see :ref:`xlmodel_support_status_of_cidu`.
   * - PMP
     - Supported.
   * - TEE
     - Supported.
   * - WFI
     - Supported.
   * - WFE
     - Not supported.
   * - ECC
     - ECC-related CSRs are implemented.
   * - CCM
     - CCM-related CSRs are implemented.
   * - SPMP
     - Not supported.
   * - SMPU
     - Supported.
   * - SMP / CLUSTER CACHE
     - Register-level access is supported; cache behavior is not modeled.
   * - Big-endian
     - Supported; driven by the ELF header.
   * - Semihosting
     - Supported; see :ref:`xlmodel_semihosting`.

.. _xlmodel_support_status_of_timer:

TIMER Support
~~~~~~~~~~~~~

The Nuclei SysTimer implements a shared time base, per-hart timer comparison and delivery, and multi-core ECLIC operation. EvalSoC also provides a CLINT-compatible timer model for conventional RISC-V software, and the ``Sstc`` supervisor timer extension is supported.

.. _xlmodel_support_status_of_plic:

PLIC Support
~~~~~~~~~~~~

The PLIC model supports platform-level interrupt prioritization and routing for machine-mode and supervisor-mode interrupt contexts, with up to 1024 interrupt sources. Multi-core PLIC mode is not supported.

.. _xlmodel_support_status_of_eclic:

ECLIC Support
~~~~~~~~~~~~~

ECLIC supports single-core and multi-core operation in both M-mode and S-mode. The ECLIC v1 model provides the basic interrupt configuration, arbitration, nesting and trigger behavior. ECLIC v2 additionally supports automatic context save/restore and shadow general-purpose register groups, together with the associated nested-trap state handling. The interrupt number count and ``CLICINTCTLBITS`` can be configured with ``--eclic``.

.. _xlmodel_support_status_of_cidu:

CIDU Support
~~~~~~~~~~~~

The CIDU distributes external interrupts among per-hart ECLIC instances. It also implements inter-core interrupts, multiple interrupt-distribution modes, and hardware semaphores for multicore software.

Nuclei SDK Cases Supported in xlmodel
-------------------------------------

See :ref:`xlmodel_use_in_sdk` for the case status table.

.. _xlmodel_description_of_parameters:

Nuclei Model Command-line Options
=================================

This section covers EvalSoC-specific settings and commonly used `xlmodel` options. Run ``xl_cpumodel --help`` for the full list.

Command-line Syntax and Help
----------------------------

Use :file:`bin/xl_cpumodel` on Linux and :file:`bin/xl_cpumodel.exe` on Windows, together with the ELF file of the test program:

.. code-block:: text

   xl_cpumodel [options] <elf-file>

The following parameter examples are based on a Linux system. If you are using a Windows system, simply replace :command:`xl_cpumodel` with :command:`xl_cpumodel.exe`.

Use the following commands to discover the options and cores available in the installed package:

.. code-block:: shell

   xl_cpumodel --help
   xl_cpumodel --version
   xl_cpumodel --cpu=?

The default test code ELF files are provided in the :file:`tests` directory of the package, for example::

  ./xl_cpumodel --cpu=nx900 --download=ilm ../tests/demotimer/demotimer_nx900.elf

CPU Configuration
-----------------

``--cpu=<str>``: Selects the CPU model, defaults to ``n300fd``. Use ``--cpu=?`` to list all supported Nuclei cores (rv32/rv64), or refer to the `Supported Nuclei Processor Cores section <https://doc.nucleisys.com/nuclei_sdk/develop/buildsystem.html#core>`__ of the Nuclei SDK documentation.

``--ext=<str>``: Enables additional ISA extensions, separated by ``_``, for example ``--ext=_zba_zbb_zbc_zbs_xxldspn1x``. See :ref:`xlmodel_supported_isa_extensions` for the available extensions. The ``Sstc`` extension is enabled by default and does not need to be passed; an extension can also be disabled or re-enabled by appending ``name=true/false`` items, where later items take precedence, for example ``--ext=_zba_zbb,sstc=false``. Example::

  ./xl_cpumodel --cpu=n300fd --download=ilm --ext=_zba_zbb_zbc_zbs_xxldspn1x ../tests/demodsp/demodsp_n300fd.elf

``--bpu=<str>``: Selects the **BPU strategy** based on Nuclei core types, which affects the cycle count of branch and jump instructions. ``--bpu=n300`` is applicable to Nuclei cores up to and including N300, and ``--bpu=n900`` is applicable to Nuclei cores from N300 onwards::

  ./xl_cpumodel --cpu=n300fd --ext=_zba_zbb_zbc_zbs_xxldspn1x --download=ilm --bpu=n300 ../tests/demodsp/demodsp_n300fd.elf

  ./xl_cpumodel --cpu=nx900 --download=ilm --bpu=n900 ../tests/demotimer/demotimer_nx900.elf

``--priv=<str>``: Selects the implemented privilege modes ``m``, ``mu`` or ``msu``, defaulting to ``msu``. Use ``--priv=m`` for M-mode only CPUs.

``--eclic=<str>``: Configures the ECLIC with ``irqnums:<n>,intctlbits:<n>,shdnum:<n>``, defaulting to ``irqnums:64,intctlbits:3,shdnum:9``. ``irqnums`` sets the total number of interrupt lines, ``intctlbits`` sets ``CLICINTCTLBITS``, and ``shdnum`` sets the number of ECLIC v2 shadow register groups. Use it together with ``--ext=_xlclicv2`` to enable ECLIC v2::

  ./xl_cpumodel --cpu=n900 --download=ilm --ext=_xlclicv2 --eclic=irqnums:64,intctlbits:3,shdnum:9 --soc-cfg=../tests/demoeclicstress_eclicv2_n900/cpu.json ../tests/demoeclicstress_eclicv2_n900/demoeclicstress.elf

``--varch=vlen:n,elen:n``: Sets the RISC-V Vector micro-architecture configuration when the V extension is enabled, defaulting to ``vlen:128,elen:64``. **VLEN and ELEN must comply with the RISC-V Vector specifications.** Example::

  ./xl_cpumodel --cpu=ux900fd --ext=v --download=ilm --varch=vlen:128,elen:64 ../tests/rvv_conv_f32/rvv_conv_f32.elf
  ./xl_cpumodel --cpu=ux900fd --ext=v --download=ilm --varch=vlen:512,elen:64 ../tests/rvv_conv_f32/rvv_conv_f32.elf

VLEN values of 2048 and 4096 are also supported, which is useful for VNICE instruction modeling with very wide vector registers::

  ./xl_cpumodel --cpu=ux900fd --ext=v --download=ilm --varch=vlen:2048,elen:64 ../tests/rvv_conv_f32/rvv_conv_f32.elf

``--smp=<n>``: Sets the SMP system core number, with a maximum of 16. If this parameter is not set, 1 CPU is used. Example::

  ./xl_cpumodel --cpu=nx900 --download=sram --smp=4 ../tests/smphello_4core/smphello_nx900.elf

.. _xlmodel_supported_isa_extensions:

Supported ISA Extensions
~~~~~~~~~~~~~~~~~~~~~~~~

The following extensions can be selected through ``--ext=``. Choose extensions supported by the selected CPU configuration and the guest program.

+--------------+-------------------------------------------------------------------------+
| Extension    | Functionality                                                           |
+==============+=========================================================================+
| v            | RISC-V V Extension                                                      |
+--------------+-------------------------------------------------------------------------+
| h            | RISC-V H-Extension                                                      |
+--------------+-------------------------------------------------------------------------+
| _zicbom      | RISC-V Zicbom Extension                                                 |
+--------------+-------------------------------------------------------------------------+
| _zicboz      | RISC-V Zicboz Extension                                                 |
+--------------+-------------------------------------------------------------------------+
| _zicond      | RISC-V Zicond Extension                                                 |
+--------------+-------------------------------------------------------------------------+
| _zicsr       | RV32/RV64 Zicsr Standard Extension                                      |
+--------------+-------------------------------------------------------------------------+
| _zifencei    | RV32/RV64 Zifencei Standard Extension                                   |
+--------------+-------------------------------------------------------------------------+
| _zihintpause | ZiHintPause extension                                                   |
+--------------+-------------------------------------------------------------------------+
| _zilsd       | Zilsd extension (RV32 ONLY)                                             |
+--------------+-------------------------------------------------------------------------+
| _zimop       | Zimop extension                                                         |
+--------------+-------------------------------------------------------------------------+
| _zcmop       | Zcmop extension                                                         |
+--------------+-------------------------------------------------------------------------+
| _zcmlsd      | Zcmlsd extension (RV32 ONLY)                                            |
+--------------+-------------------------------------------------------------------------+
| _zawrs       | Zawrs extension                                                         |
+--------------+-------------------------------------------------------------------------+
| _zacas       | Zacas extension (AMO CAS)                                               |
+--------------+-------------------------------------------------------------------------+
| _zfh         | Zfh  Extension                                                          |
+--------------+-------------------------------------------------------------------------+
| _zfa         | Zfa  Extension                                                          |
+--------------+-------------------------------------------------------------------------+
| _zfhmin      | Zfhmin Extension                                                        |
+--------------+-------------------------------------------------------------------------+
| _zfinx       | Zfinx  Extension                                                        |
+--------------+-------------------------------------------------------------------------+
| _zdinx       | Zdinx  Extension                                                        |
+--------------+-------------------------------------------------------------------------+
| _zibi        | Nuclei Zibi Extension                                                   |
+--------------+-------------------------------------------------------------------------+
| _zicfilp     | RISC-V Zicfilp Extension (landing pad)                                  |
+--------------+-------------------------------------------------------------------------+
| _zca         | RISC-V ZC* Extension                                                    |
+--------------+-------------------------------------------------------------------------+
| _zcb         | RISC-V ZC* Extension                                                    |
+--------------+-------------------------------------------------------------------------+
| _zcf         | RISC-V ZC* Extension                                                    |
+--------------+-------------------------------------------------------------------------+
| _zcd         | RISC-V ZC* Extension                                                    |
+--------------+-------------------------------------------------------------------------+
| _zcmp        | RISC-V ZC* Extension                                                    |
+--------------+-------------------------------------------------------------------------+
| _zcmt        | RISC-V ZC* Extension                                                    |
+--------------+-------------------------------------------------------------------------+
| _zba         | RISC-V Bitmanipulation Extension                                        |
+--------------+-------------------------------------------------------------------------+
| _zbb         | RISC-V Bitmanipulation Extension                                        |
+--------------+-------------------------------------------------------------------------+
| _zbc         | RISC-V Bitmanipulation Extension                                        |
+--------------+-------------------------------------------------------------------------+
| _zbkb        | RISC-V Bitmanipulation Extension                                        |
+--------------+-------------------------------------------------------------------------+
| _zbkc        | RISC-V Bitmanipulation Extension                                        |
+--------------+-------------------------------------------------------------------------+
| _zbkx        | RISC-V Bitmanipulation Extension                                        |
+--------------+-------------------------------------------------------------------------+
| _zbs         | RISC-V Bitmanipulation Extension                                        |
+--------------+-------------------------------------------------------------------------+
| _zk          | RISC-V Scalar Crypto Extension                                          |
+--------------+-------------------------------------------------------------------------+
| _zkn         | RISC-V Scalar Crypto Extension                                          |
+--------------+-------------------------------------------------------------------------+
| _zknd        | RISC-V Scalar Crypto Extension                                          |
+--------------+-------------------------------------------------------------------------+
| _zkne        | RISC-V Scalar Crypto Extension                                          |
+--------------+-------------------------------------------------------------------------+
| _zknh        | RISC-V Scalar Crypto Extension                                          |
+--------------+-------------------------------------------------------------------------+
| _zkr         | RISC-V Scalar Crypto Extension                                          |
+--------------+-------------------------------------------------------------------------+
| _zks         | RISC-V Scalar Crypto Extension                                          |
+--------------+-------------------------------------------------------------------------+
| _zksed       | RISC-V Scalar Crypto Extension                                          |
+--------------+-------------------------------------------------------------------------+
| _zksh        | RISC-V Scalar Crypto Extension                                          |
+--------------+-------------------------------------------------------------------------+
| _zkt         | RISC-V Scalar Crypto Extension                                          |
+--------------+-------------------------------------------------------------------------+
| _zve32x      | RISC-V V Extension                                                      |
+--------------+-------------------------------------------------------------------------+
| _zve32f      | RISC-V V Extension                                                      |
+--------------+-------------------------------------------------------------------------+
| _zve64x      | RISC-V V Extension                                                      |
+--------------+-------------------------------------------------------------------------+
| _zve64f      | RISC-V V Extension                                                      |
+--------------+-------------------------------------------------------------------------+
| _zve64d      | RISC-V V Extension                                                      |
+--------------+-------------------------------------------------------------------------+
| _zvfh        | RISC-V V Extension                                                      |
+--------------+-------------------------------------------------------------------------+
| _zvfhmin     | RISC-V V Extension                                                      |
+--------------+-------------------------------------------------------------------------+
| _zvkg        | RISC-V Vector Crypto Extension                                          |
+--------------+-------------------------------------------------------------------------+
| _zvkned      | RISC-V Vector Crypto Extension                                          |
+--------------+-------------------------------------------------------------------------+
| _zvksed      | RISC-V Vector Crypto Extension                                          |
+--------------+-------------------------------------------------------------------------+
| _zvksh       | RISC-V Vector Crypto Extension                                          |
+--------------+-------------------------------------------------------------------------+
| zhinx        | Zhinx Extension                                                         |
+--------------+-------------------------------------------------------------------------+
| zhinxmin     | Zhinxmin Extension                                                      |
+--------------+-------------------------------------------------------------------------+
| smaia        | Smaia Extension                                                         |
+--------------+-------------------------------------------------------------------------+
| _smrnmi      | Smrnmi Extension                                                        |
+--------------+-------------------------------------------------------------------------+
| ssaia        | Ssaia  Extension                                                        |
+--------------+-------------------------------------------------------------------------+
| _sscofpmf    | Sscofpmf  Extension                                                     |
+--------------+-------------------------------------------------------------------------+
| _sstc        | Sstc Extension (enabled by default)                                     |
+--------------+-------------------------------------------------------------------------+
| _svinval     | Svinval Extension                                                       |
+--------------+-------------------------------------------------------------------------+
| _svnapot     | Svnapot Extension                                                       |
+--------------+-------------------------------------------------------------------------+
| _svpbmt      | Svpbmt Extension                                                        |
+--------------+-------------------------------------------------------------------------+
| _xxldsp      | Nuclei DSP Extension based on P-ext 0.5.4 + default 8 EXPD instructions |
+--------------+-------------------------------------------------------------------------+
| _xxldspn1x   | Xxldsp + Nuclei N1 extension                                            |
+--------------+-------------------------------------------------------------------------+
| _xxldspn2x   | Xxldspn1x + Nuclei N2 extension                                         |
+--------------+-------------------------------------------------------------------------+
| _xxldspn3x   | Xxldspn2x + Nuclei N3 extension                                         |
+--------------+-------------------------------------------------------------------------+
| _xxlcz       | Nuclei code size reduction extension                                    |
+--------------+-------------------------------------------------------------------------+
| _xxlvqmacc   | Nuclei custom vpu extension                                             |
+--------------+-------------------------------------------------------------------------+
| _xxlfbf      | Nuclei scalar BF16 extension                                            |
+--------------+-------------------------------------------------------------------------+
| _xxlvfbf     | Nuclei vector BF16 extension                                            |
+--------------+-------------------------------------------------------------------------+
| _xlclicv2    | Nuclei ECLIC v2 extension (hardware context and shadow registers)       |
+--------------+-------------------------------------------------------------------------+

SoC Configuration
-----------------------------

``-M/--machine=<str>``: Machine type config, defaults to ``nuclei_evalsoc``.

``--download=<str>``: Selects the download mode; the default is ``flashxip`` and it can be set to ``ilm``, ``ddr``, ``sram`` or ``flash``. The startup address of the selected mode is the EvalSoC memory base by default, and can be overridden per mode through ``soc-cfg`` or globally with ``--vectorbase``. Example::

  ./xl_cpumodel --cpu=nx900 --download=sram --smp=4 ../tests/democidu_en_firclaim/democidu_en_firclaim_nx900.elf

``--soc-cfg=<file.json>``: Overrides the built-in board configuration with a JSON file. See :ref:`xlmodel_soc_cfg`.

``--mem=<str>``: Defines additional user memory regions when the test code uses external memory sections, for example ``--mem="0x30000000:0x10000000,0x40000000:0x10000000"``. Example::

  ./xl_cpumodel --cpu=nx900 --download=ilm --mem="0x30000000:0x10000000,0x40000000:0x10000000" ../tests/demoeclic_swirq_high/demoeclic_swirq_high_nx900.elf

``--vectorbase=<addr>``: Sets the reset vector address explicitly. It takes precedence over the startup address selected by ``--download``, including the ``download.<mode>.startaddr`` item of the ``--soc-cfg`` file and the default memory base. When it is set, the consistency check between the ELF entry point and the selected download mode is skipped.

.. _xlmodel_soc_cfg:

soc-cfg JSON Configuration
--------------------------

The ``--soc-cfg=<file.json>`` option loads a JSON file that overrides the built-in EvalSoC board configuration, aligned with the ``soc-cfg`` format used by Nuclei QEMU. Without ``--soc-cfg``, `xlmodel` uses the built-in default layout. For any configurable item, the effective value is resolved in the order **CLI parameter > ``soc-cfg`` JSON > built-in default**.

The following example overrides memory regions, selected peripherals and download-mode startup addresses:

.. code-block:: json

   {
       "general_config": {
           "ddr": {
               "base": "0x80000000",
               "size": "64M"
           },
           "ilm": {
               "base": "0x80000000",
               "size": "0x800000"
           },
           "dlm": {
               "base": "0x90000000",
               "size": "0x800000"
           },
           "sram": {
               "base": "0xA0000000",
               "size": "512M"
           },
           "norflash": {
               "base": "0x20000000",
               "size": "256M"
           },
           "iregion": {
               "base": "0x18000000",
               "eclic": "1",
               "smpcc": "1",
               "cidu": "1",
               "plic": "1"
           },
           "uart0": {
               "base": "0x10013000",
               "size": "0x1000",
               "irq": "32",
               "enable": "1"
           },
           "qspi0": {
               "base": "0x10014000",
               "size": "0x1000",
               "irq": "34",
               "enable": "1"
           },
           "timer_freq": "32768",
           "cpu_freq": "16000000"
       },
       "download": {
           "ilm": {
               "startaddr": "0x80000000"
           },
           "flashxip": {
               "startaddr": "0x20000000"
           },
           "flash": {
               "startaddr": "0x20000000"
           },
           "sram": {
               "startaddr": "0xA0000000"
           },
           "ddr": {
               "startaddr": "0x80000000"
           }
       }
   }

.. list-table:: ``soc-cfg`` fields supported by xlmodel
   :header-rows: 1
   :widths: 22 42 36
   :align: center

   * - Field
     - Applies to objects
     - Description
   * - ``base``, ``size``
     - ``ilm``, ``dlm``, ``sram``, ``ddr``, ``norflash``, ``uart0``, ``qspi0``, ``iregion``
     - Sets the base address and size of the corresponding memory or MMIO region.
   * - ``irq``
     - ``uart0``, ``qspi0``
     - Sets the peripheral interrupt ID routed to ECLIC/CIDU.
   * - ``enable``
     - ``uart0``, ``qspi0``
     - Enables or disables the corresponding device.
   * - ``eclic``, ``smpcc``, ``cidu``, ``plic``
     - ``iregion``
     - Enable or disable the corresponding IREGION block.
   * - ``timer_freq``
     - ``general_config``
     - Sets the SysTimer clock frequency; overridden by ``--timefreq``.
   * - ``cpu_freq``
     - ``general_config``
     - Sets the CPU frequency; overridden by ``--cpufreq``.
   * - ``startaddr``
     - ``download.ilm``, ``download.ddr``, ``download.sram``, ``download.flashxip``, ``download.flash``
     - Sets the firmware startup address for the corresponding download mode.

Notes on the JSON format:

* Numeric leaf values can be written as decimal strings, ``0x``-prefixed hexadecimal strings, or with a ``K``/``M``/``G`` size suffix; plain JSON numbers and ``true``/``false`` are also accepted.
* Partial overrides are supported: omitted objects and fields keep their defaults.
* ``download.<mode>.startaddr`` only changes the startup address of that download mode; it does not change the memory-region mapping.

An example of running with a ``soc-cfg`` file::

  ./xl_cpumodel --cpu=nx900 --download=ilm --soc-cfg=soc.json ../tests/demotimer/demotimer_nx900.elf

Memory Configuration
--------------------

The base address and size of each memory region can be adjusted with the following options; they override the same items in ``soc-cfg``:

* ``--ilmbase`` / ``--ilmsz``: ILM base address and size
* ``--dlmbase`` / ``--dlmsz``: DLM base address and size
* ``--srambase`` / ``--sramsz``: SRAM base address and size
* ``--ddrbase`` / ``--ddrsz``: DDR base address and size
* ``--flashxipbase`` / ``--flashxipsz``: XIP (NOR flash) base address and size
* ``--iregionbase``: IREGION base address

For example, enlarging DDR to 2 GB when booting Linux::

  ./xl_cpumodel --cpu=ux900fd --download=ddr --ddrbase=0x80000000 --ddrsz=0x80000000 <linux-image.elf>

Simulation Speed and Time
-------------------------

``--cpufreq=<n>``: Simulated CPU frequency in Hz (default 655360). It takes precedence over the ``cpu_freq`` item of the ``--soc-cfg`` file. The frequency does not change the per-instruction cycle estimates: it only defines the cycle-to-second conversion and the mtime tick interval (one tick every ``cpu_freq / timer_freq`` cycles). Example::

  ./xl_cpumodel --cpu=nx900 --download=ilm --cpufreq=16000000 ../tests/demotimer/demotimer_nx900.elf

.. note::

  Set ``--cpufreq`` to the real board frequency when comparing simulated timings against hardware, and keep the default for functional runs. A higher value does not improve cycle accuracy: timer-driven workloads (RTOS ticks, busy-wait delays) retire instructions proportionally to ``cpu_freq / timer_freq`` while waiting, so raising it slows the simulation proportionally — at 50 MHz demotimer retires ~76x more instructions than at the default and takes minutes instead of seconds.

``--timefreq=<n>``: Sets the timer frequency in Hz, defaulting to 32768 Hz.

``--timeout=<n>``: Sets the expected real execution time in seconds for a simulation run; otherwise, it is unlimited. **This parameter is ignored during GDB debugging.** When the timeout is reached, the enabled gprof/flame graph files are generated. Example::

  ./xl_cpumodel --cpu=nx900 --download=sram --smp=2 --gprof=1 --flamegraph=1 --timeout=3 ../tests/freertos_smpdemo/freertos_smpdemo_nx900.elf

Pressing ``Ctrl+C`` also stops the simulation gracefully, and similarly generates gprof/flame graph files for the period from startup to shutdown.

``--funcmode=1``: Every retired instruction is counted as a fixed 1 cycle and the per-instruction near-cycle calculation is skipped. Trace, gprof and flame graph are still available in this mode.

``--fastmode=1``: Switches to the fast functional mode to maximize simulation speed. The functional behavior (instruction execution, peripherals, interrupts) is unchanged, so use it when the exact cycle count is not required, such as booting Linux or running very long functional tests. Cycle-related features such as ``--trace``, ``--gprof`` and ``--flamegraph`` are not available in this mode::

  ./xl_cpumodel ../tests/demodsp/demodsp_n300fd.elf --cpu=n300fd --ext=_zba_zbb_zbc_zbs_xxldspn1x --download=ilm --fastmode=1

Trace, Profiling and Logs
-------------------------

``--trace=1``: Generates the instruction trace file :file:`<elf-name>.rvtrace` in the current execution path. It contains the instruction count, cycle count, hart, pc, opcode and disassembly of each instruction. Example::

  ./xl_cpumodel --cpu=nx900 --download=ilm --trace=1 ../tests/demoeclic_swirq_low/demoeclic_swirq_low_nx900.elf

``-t <path>``: Specifies the trace file path directly and enables tracing at the same time.

``--gprof=1``: Enables the built-in **gprof** functionality. The :file:`gprof<n>.gmon` and :file:`gprof<n>.log` files are generated when the simulation completes, where ``n`` is the hart ID. Import them into Nuclei Studio for detailed analysis. Example::

  ./xl_cpumodel --cpu=nx900fd --download=ilm --gprof=1 ../tests/whet/whet_nx900fd.elf

``--flamegraph=1``: Enables the built-in **flame graph** functionality. The :file:`xlmodel_flame_<n>.gtef` files are generated when the simulation completes, where ``n`` is the hart ID. For each hart, the flame graph shows the main thread, RTOS task threads, and M-mode/S-mode interrupt threads. Import them into Nuclei Studio, see :ref:`Nuclei Studio use xlmodel flame graph <ide_nuclei_model_flame>` for detailed usage. Example::

  ./xl_cpumodel --cpu=n300fd --download=ilm --flamegraph=1 ../tests/demo_clint_timer/demo_clint_timer_n300fd.elf

``--logdir=<str>``: The directory to store generated files (instruction trace, gprof files, flame graphs). Example::

  ./xl_cpumodel --cpu=nx900 --download=ilm --trace=1 --gprof=1 --flamegraph=1 --logdir=../log ../tests/demoeclic_swirq_low/demoeclic_swirq_low_nx900.elf

``--log=<str>``: Sets the log level, from least to most detailed: ``error``, ``info``, ``debug``, ``tlm``. The default is ``info``, and ``--log=debug --trace=1`` can adds register updates, exceptions and CSRs to the trace file. Example::

  ./xl_cpumodel --cpu=nx900 --download=ilm --trace=1 --log=debug ../tests/demotimer/demotimer_nx900.elf

DEBUG
=====

.. _xlmodel_debug:

You can debug applications running with `xlmodel` by passing the ``--gdbport=<port_num>`` parameter. This enables the GDB server and allows external GDB (e.g., ``riscv64-unknown-elf-gdb``) to connect via the specified portnum for software debugging.

To debug via the command line, follow these steps on a Linux system: (Windows is similar)

1. Start `xlmodel` with GDB debugging enabled::

    ./xl_cpumodel --cpu=nx900 --download=ilm --gdbport=1234 ../tests/demotimer/demotimer_nx900.elf

2. Open another command-line terminal and run GDB::

    riscv64-unknown-elf-gdb tests/demotimer/demotimer_nx900.elf

3. Connect to the GDB port, load the ELF file, and perform standard GDB debugging:

  .. code-block:: shell

      target remote :1234
      load tests/demotimer/demotimer_nx900.elf
      set disassemble-next-line on
      info register all
      si
      b xxx
      c

.. image:: /asserts/images/xlmodel/xlmodel_gdb_debug.png

The GDB stub supports:

* **SMP debugging**: ``info threads`` lists every hart of the cluster; ``thread <n>`` switches the target hart and ``si`` single-steps only the selected hart, while ``continue`` runs the whole cluster.
* **Breakpoints and watchpoints**: software breakpoints (``b``), hardware breakpoints (``hbreak``), and watchpoints (``watch``/``rwatch``/``awatch``) on physical or virtual addresses. Stop replies report the stop reason, e.g. ``swbreak``, ``hwbreak``, ``watch``, ``rwatch`` or ``awatch``.
* **Memory access after MMU is enabled**: addresses are translated from VA to PA automatically. Use ``monitor pa on`` / ``monitor pa off`` to force the GDB stub to access physical addresses directly.

For an easier experience using GDB debugging with `xlmodel`, we recommend using Nuclei Studio. When GDB is enabled, passing ``--gprof=1`` and ``--flamegraph=1`` allows you to capture profiling result and generated flame graph visualizations while the program is suspended in GDB.

For more information on using `xlmodel` debugging in Nuclei Studio, please refer to the :ref:`ide_nuclei_model_debugger`.

.. note::

  The ``--timeout=<n>`` parameter has no effect when software debugging is enabled.

.. _xlmodel_semihosting:

Semihosting
===========

`xlmodel` supports the RISC-V semihosting convention: when ``--semihosting=1`` is passed, an ``EBREAK`` instruction surrounded by the semihosting magic words traps into the host and executes the requested semihosting call, with the operation number in register ``a0`` and the parameter block pointer in ``a1``. Semihosting calls are executed by the host directly and bypass the UART.

Supported operations include basic printing (``SYS_WRITE0``/``SYS_WRITEC``), file I/O (``SYS_OPEN``, ``SYS_CLOSE``, ``SYS_READ``, ``SYS_WRITE``, ``SYS_FLEN``, ``SYS_SEEK``), and program exit (``SYS_EXIT``).

Build the guest program with semihosting enabled (for example ``--specs=semihost.specs`` or the SDK semihosting support), then run::

  ./xl_cpumodel --cpu=nx900 --download=ilm --semihosting=1 <semihosting-enabled.elf>

.. _xlmodel_use_in_sdk:

Use Nuclei Model in Nuclei SDK
==============================

**Setup Tools and Environment**

1. Download the `nuclei-sdk <https://github.com/Nuclei-Software/nuclei-sdk>`_, checkout to ``master`` branch.
2. Download RISC-V GNU Toolchain from `Nuclei Download Center <https://nucleisys.com/download.php>`__.
3. Download the `xlmodel` software package from `Nuclei Download Center <https://nucleisys.com/download.php>`__ (or obtain it in Nuclei Studio), extract it and add :file:`xlmodel/bin` to the ``PATH`` environment variable.

**Example**

If you want to use `xlmodel` on Nuclei SDK. The example here uses the CPU of the n300fd, but other CPU types can also be used for testing. The example is demo_dsp.

First, you need to configure the toolchain, nuclei-sdk, and xlmodel environments according to the documentation https://doc.nucleisys.com/nuclei_sdk/quickstart.html

.. code-block:: shell

   # Enter the example folder of demo_dsp
   cd nuclei-sdk/application/baremetal/demo_dsp/
   # Clear the compilation cache
   make clean
   # Compile the program for the n300fd, set the download mode to ILM, and enable the xxldsp extension
   make CORE=n300fd SOC=evalsoc DOWNLOAD=ilm ARCH_EXT=_xxldsp dasm
   # Automatically generate xlmodel running commands and execute the program
   make CORE=n300fd SOC=evalsoc DOWNLOAD=ilm ARCH_EXT=_xxldsp run_xlmodel

Where **ARCH_EXT** can be used to pass the extension name. The ``run_xlmodel`` target calls ``xl_cpumodel`` with the matching ``--cpu``, ``--download`` and ``--ext`` options (and ``--smp`` when ``CPU_CNT`` is set), so no extra `xlmodel` options are needed and make sure ``xl_cpumodel`` is in the ``PATH``. Under normal circumstances, you should see the test cases finish successfully.

**Support for Nuclei SDK Cases on xlmodel**

  ``Y`` - Successfully run and consistent with hardware

  ``N`` - Successfully run but inconsistent with hardware

  ``F`` - Failed

+-----------------------+---------------+---------------+-----------------------------------------------+
| Cases                 | SMP=1         | SMP>1         | Description (additional compilation           |
|                       |               |               | parameters and running status)                |
+=======================+===============+===============+===============================================+
| benchmark/coremark    | Y             |               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+
| benchmark/dhrystone   | Y             |               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+
| benchmark/            | Y             |               |                                               |
| dhrystone_v2.2        |               |               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+
| benchmark/whetstone   | Y             |               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+
| benchmark/            | Y             |               |                                               |
| whetstone_v1.2        |               |               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+
| cpuinfo/              | N             |               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+
| demo_backtrace/       | Y             |               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+
| demo_cache/           | F             |               | Cache emulation is not supported.             |
+-----------------------+---------------+---------------+-----------------------------------------------+
| demo_cidu/            |               | Y             | SMP=4, XLCFG_CIDU=1.                          |
+-----------------------+---------------+---------------+-----------------------------------------------+
| demo_clint_timer/     | Y             |               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+
| demo_dsp/             | Y             |               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+
| demo_ecc/             | N             |               | ECC error injection and correction behavior   |
|                       |               |               | is not modeled.                               |
+-----------------------+---------------+---------------+-----------------------------------------------+
| demo_eclic/           | Y             |               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+
| demo_eclic_stress/    | Y             |               | XLCFG_ECLIC=2, ECLIC_HWCTX=0/1; run with an   |
|                       |               |               | increased ``--cpufreq`` (eg 16MHz).           |
+-----------------------+---------------+---------------+-----------------------------------------------+
| demo_eclic_umode/     | Y             |               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+
| demo_nice/            | Y             |               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+
| demo_plic/            | Y             |               | XLCFG_PLIC=1.                                 |
+-----------------------+---------------+---------------+-----------------------------------------------+
| demo_pma/             | N             |               | XLCFG_CCM=1, XLCFG_HPM=1.                     |
+-----------------------+---------------+---------------+-----------------------------------------------+
| demo_pmp/             | Y             |               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+
| demo_profiling/       | N             |               | xlmodel already implements its own profiling. |
+-----------------------+---------------+---------------+-----------------------------------------------+
| demo_smode_clint/     | Y             |               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+
| demo_smode_eclic/     | Y             |               | XLCFG_TEE=1.                                  |
+-----------------------+---------------+---------------+-----------------------------------------------+
| demo_smode_plic/      | Y             |               | XLCFG_PLIC=1.                                 |
+-----------------------+---------------+---------------+-----------------------------------------------+
| demo_smpcc/           | N             |               | Control registers are modeled; cluster-cache  |
|                       |               |               | behavior is not modeled.                      |
+-----------------------+---------------+---------------+-----------------------------------------------+
| demo_smpu/            | Y             |               | XLCFG_SMPU=1, CHK_MODE=0 through 5.           |
+-----------------------+---------------+---------------+-----------------------------------------------+
| demo_sstc/            | Y             |               | XLCFG_TEE=1, XLCFG_SSTC=1.                    |
+-----------------------+---------------+---------------+-----------------------------------------------+
| demo_stack_check/     | N             |               | Only CSRs are implemented.                    |
+-----------------------+---------------+---------------+-----------------------------------------------+
| demo_timer/           | Y             |               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+
| demo_vnice/           | Y             |               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+
| empty/                | Y             |               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+
| exception_mmode/      | Y             |               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+
| exception_smode/      | Y             |               | XLCFG_TEE=1.                                  |
+-----------------------+---------------+---------------+-----------------------------------------------+
| exception_umode/      | Y             |               | XLCFG_SMODE=1, XLCFG_SMPU=1.                  |
+-----------------------+---------------+---------------+-----------------------------------------------+
| helloworld/           | Y             |               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+
| lowpower/             | Y             |               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+
| smphello/             |               | Y             | SMP=4.                                        |
+-----------------------+---------------+---------------+-----------------------------------------------+
| freertos/demo/        | Y             |               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+
| freertos/smpdemo/     |               | Y             | SMP=4.                                        |
+-----------------------+---------------+---------------+-----------------------------------------------+
| rtthread/demo/        | Y             |               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+
| rtthread/demo_smode/  | Y             |               | XLCFG_TEE=1, XLCFG_SSTC=1.                    |
+-----------------------+---------------+---------------+-----------------------------------------------+
| rtthread/msh/         | Y             |               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+
| threadx/demo/         | Y             |               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+
| threadx/smpdemo/      |               | Y             | SMP=4.                                        |
+-----------------------+---------------+---------------+-----------------------------------------------+
| ucosii/demo/          | Y             |               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+

And `xlmodel` and Nuclei SDK are deeply integrated in Nuclei Studio, you can run Nuclei SDK test code using `xlmodel` in Nuclei Studio, please refer to the :ref:`Nuclei Studio use xlmodel <ide_nuclei_near_cycle_model>`.

.. _xlmodel_linux_sdk:

Use Nuclei Model in Nuclei Linux SDK
====================================

`xlmodel` can boot and test a RISC-V Linux Kernel using the emulated Nuclei EvalSoC, in both uniprocessor and SMP mode, for RV64 and RV32. For more information about the Nuclei Linux SDK, see https://github.com/Nuclei-Software/nuclei-linux-sdk .

Prebuilt boot images built from the Linux SDK are provided in the :file:`tests` directory of the `xlmodel` package:

.. list-table:: Prebuilt Linux boot images
   :header-rows: 1
   :widths: 50 14 36
   :align: center

   * - File
     - Arch
     - Description
   * - :file:`tests/boot_linux_rv64/fw_payload_xlspike_ux900fd_flash_job_5c231cec.elf`
     - RV64
     - Linux 6.6 flash payload for ux900fd from the Linux SDK CI.
   * - :file:`tests/boot_linux_rv32/fw_payload_xlspike_u900_flash_job_5c231cec.elf`
     - RV32
     - Linux 6.6 flash payload for u900 from the Linux SDK CI.

An example of booting Linux on a single core::

  ./xl_cpumodel --cpu=ux900fd --download=ddr \
      --ext=_svpbmt_zicbom_sstc_sscofpmf_zba_zbb_zbc_zbs_zicond \
      --fastmode=1 --ddrbase=0x80000000 --ddrsz=0x80000000 \
      --timeout=3600 ../tests/boot_linux_rv64/fw_payload_xlspike_ux900fd_flash_job_5c231cec.elf

An example of booting Linux on two cores (SMP): add ``--smp=2`` and disable ILM with ``--ilmsz=0``, because the SMP image uses a DDR-only memory map and the default ILM overlaps the enlarged DDR region::

  ./xl_cpumodel --cpu=ux900fd --download=ddr \
      --ext=_svpbmt_zicbom_sstc_sscofpmf_zba_zbb_zbc_zbs_zicond \
      --fastmode=1 --smp=2 --ilmsz=0 --ddrbase=0x80000000 --ddrsz=0x80000000 \
      --timeout=3600 ../tests/boot_linux_rv64/fw_payload_xlspike_ux900fd_flash_job_5c231cec.elf

The RV32 image boots in the same way with ``--cpu=u900`` and the :file:`tests/boot_linux_rv32` image.

.. note::

  Booting Linux requires a large DDR (2 GB in the examples above, via ``--ddrsz``), and ``--fastmode=1`` is recommended. Tracing and profiling options are not available in fast mode.

NICE support
============

NICE build
----------

If you need to validate your custom **NICE** instructions, you need to contact Nuclei Support to obtain software package of model (`xlmodel_nice`).

The directory structure of `xlmodel_nice` is as follows, you need to implement the **NICE** instructions in `nice/nice.cc`.

+--------------------+----------------------------------------------------------------+
| nice directory     | description                                                    |
+====================+================================================================+
| nice               | header and source files for the NICE interface                 |
+--------------------+----------------------------------------------------------------+
| systemc            | SystemC 2.3.4 header files and static libraries                |
+--------------------+----------------------------------------------------------------+
| xl_model           | xlmodel header files and library files                         |
+--------------------+----------------------------------------------------------------+
| xl_spike           | xlspike header files and library files                         |
+--------------------+----------------------------------------------------------------+
| tests              | simple test codes                                              |
+--------------------+----------------------------------------------------------------+
| CMakeLists.txt     | CMake file required for compilation                            |
+--------------------+----------------------------------------------------------------+

After implementing the **NICE** instruction, you need to recompile `xlmodel_nice`.

**nice build for Linux**

.. code-block:: shell

    # Install essential compilation tools
    sudo apt install build-essential cmake
    # Check the tools have been installed successfully
    gcc -v && g++ -v && cmake --version
    # Change to the root directory of the xlmodel_nice package
    cd <xlmodel_nice root directory>
    mkdir build && cd build
    cmake -DCMAKE_BUILD_TYPE=Release ..
    make -j$(nproc)

**nice build for Windows**

To compile `xlmodel_nice` on Windows, you need to download a Windows-compatible GCC tool, such as **MinGW64**. You can download **MSYS2** to easily obtain the MinGW64 toolchain, which simplifies the installation and management of MinGW64 on Windows.

Below are the steps to use MSYS2's MinGW64 to compile `xlmodel_nice` on Windows:

1. Install the latest version of MSYS2 from https://www.msys2.org/, and then add the MinGW64 toolchain path to the **environment variables**:

.. image:: /asserts/images/xlmodel/environment_variable.png

2. Install MinGW64 toolchain, CMake, and other basic compilation tools in the **MSYS2 terminal**::

    # Sync the package databases first, rerun until it prints "there is nothing to do"
    pacman -Syu
    pacman -S base-devel mingw-w64-x86_64-gcc mingw-w64-x86_64-cmake

3. Compile `xlmodel_nice` in the **MinGW64 terminal**:

.. code-block:: shell

    # Check the tools have been installed successfully
    gcc -v && g++ -v && cmake --version
    # Change to the root directory of the xlmodel_nice package
    cd <xlmodel_nice root directory>
    mkdir build && cd build
    cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release ..
    make -j$(nproc)

.. note::

  If you need to import and compile `xlmodel_nice` in Nuclei Studio (:ref:`Nuclei Studio use xlmodel <ide_nuclei_near_cycle_model>`), you also need to configure the **MSYS2** environment as described above first.

NICE example
------------

If you are unfamiliar with how to implement the NICE instruction, refer to the implementation in `xlmodel_nice/nice/nice.cc` for custom **Nuclei NICE/VNICE** instructions.

The test example for Nuclei NICE instruction features are located in `tests/demonice`::

    ./xl_cpumodel --cpu=nx900 --download=ilm ../tests/demonice/demonice_nx900.elf

The test example for Nuclei VNICE instruction features are located in `tests/demovnice`::

    ./xl_cpumodel --cpu=nx900fd --ext=v --download=ilm ../tests/demovnice/demovnice_nx900fd.elf

SystemC integration
===================

If you need to integrate `xlmodel` into a third-party SoC simulation platform, you need to contact Nuclei AE for the software integration package of the model (`xlmodel_integrate`).

`xlmodel_integrate` mainly includes the source code of :ref:`xlmodel_systemc_components`. You can extract the parts you need and use them on third-party platforms with relatively little adaptation.

The integration package is delivered per target platform. The standard package is built against **SystemC 2.3.4** and is available for several Linux distributions (linux64, Debian 10, CentOS 7) and Windows (win32); for Ubuntu hosts, additional variants built against **SystemC 3.0.0 and SystemC 3.0.2** are provided, so the package can be linked into SystemC 3.x based platforms as well.

.. list-table:: Main directory structure of ``xlmodel_integrate``
   :header-rows: 1
   :widths: 16 84
   :align: center

   * - directory
     - description
   * - src
     - All SystemC components, Cluster and Timer are mandatory to integrate, while others can be integrated as needed.
   * - inc
     - All header files related to xlmodel, which are integrated as needed.
   * - systemc
     - SystemC 2.3.4 header files and the platform-specific static library (``library/<platform>/libsystemc.a``).
   * - cycle
     - The near cycle lib file, must be integrated.
   * - profiling
     - The xlmodel profiling lib file, which is integrated as needed.
   * - xlspike
     - xlspike header files and the platform-specific static library (``library/<platform>/libxl_spike.a``), must be fully integrated.
   * - tests
     - simple test codes.
   * - nice
     - header and source files for the NICE interface, must be fully integrated.
   * - CMakeLists.txt
     - CMake file required for compilation.

Here are the integration steps instructions:

1. Find the Cluster class in `inc/cluster.h`:

   - The Cluster class contains two types of variables:

     * **Internal variables**: Initialized to default values in the constructor's member initialization list.

     * **User-defined variables**: Initialization in the constructor's member list depends on your **firmware, CPU configurations and extra simulation feature needs**.

   - Usage recommendations:

     * You can inherit the Cluster class in your SystemC platform class to use base methods of your platform.

2. Find the Cluster class in `src/cluster.cpp`:

   - Usage recommendations:

     * If you do not need to replace the SystemC sockets and TLM methods in the Cluster class, you can directly use the constructor and methods in the Cluster class without any modification.

     * Adjust the user-defined variables in the constructor's member initialization list.

     * If your platform implements TLM transmission from CPU to Bus, you can substitute the read/write implementations into ``cpu_read_tlm()`` and ``cpu_write_tlm()``.

3. Use External Interrupts:

   - To connect User-defined external interrupts to the CPU:

     * Pass the number of external interrupt sources to the Cluster constructor. It decides the size of the Cluster's ``irq_sockets``, and each source is bound to one socket.

     * The total number of interrupt lines is configured with ``irq_num``. An external interrupt ID must be smaller than ``irq_num`` minus the built-in interrupt offset (19 for ECLIC, 1 for PLIC).

     * Bind your device's interrupt socket to one of the Cluster's ``irq_sockets``.

Changelog
=========

.. _xlmodel_changelog_202610:

Version 2026.10
---------------

This release is based on **2025.10** version with some new features and bug fixes introduced.

**New Features:**

- Support booting a RISC-V Linux kernel with the Nuclei Linux SDK (RV64/RV32, uniprocessor and SMP)
- SMP GDB debugging: per-hart thread switching, single-step on the selected hart, watchpoints (watch/rwatch/awatch) on virtual addresses, stop-reason reporting, dynamic vector register XML per VLEN
- Support ECLIC v2 hardware context and shadow register groups (``--ext=_xlclicv2``); add ``--eclic=irqnums:<n>,intctlbits:<n>,shdnum:<n>``
- ECLIC interrupt sources scale to 4096(M-only) or 1024(M/S), and Privilege can be configured by ``--priv=m/mu/msu`` options; PLIC interrupt sources scale to 1024
- Support big-endian RISC-V ELF files; target endianness is detected from the ELF header, including big-endian GDB debugging
- Support RISC-V semihosting (``--semihosting=1``) for guest printf/file-I/O/exit via EBREAK
- Support ``soc-cfg`` JSON configuration files (``--soc-cfg``), aligned with the Nuclei QEMU format, with CLI > soc-cfg > default priority
- Add ``--fastmode=1`` for maximum functional simulation speed
- Support the ``Sstc`` supervisor timer extension by default
- Faster flame graph ``.gtef`` generation with improved symbol resolution
- Add new extensions: Zibi, Zicfilp, Zacas, Zaamo/Zalrsc, vector crypto (Zvkg/Zvkned/Zvksed/Zvksh), Nuclei ``Xxlfbf``/``Xxlvfbf`` BF16 and ``Xxlvqmacc`` VPU extensions; DSP extensions differentiated into Xxldspn1x/N2x/N3x; VLEN 2048/4096 support
- UART: RX polling mode: guest can poll RXDATA without enabling the UART interrupt
- Add ``--cpu=?`` core listing, ``--timefreq``, ``--srambase/--sramsz`` and ``--vectorbase`` options; ``--ext`` supports per-extension ``name=true/false`` overrides; ``--version`` output now includes the git commit hash
- Support pure-BSS ELF loading
- The integrate package now supports multiple Linux distributions (linux64, Debian 10, CentOS 7) and provides SystemC 3.0.0/3.0.2 variants on Ubuntu, in addition to the SystemC 2.3.4 based standard package

**Bug Fixes:**

- Fixed ECLIC pending-bit handling that caused continuous interrupt re-triggering, ECLIC re-arbitration after configuration register writes, edge-trigger handling and S-mode software interrupt issues
- Fixed lr/sc reservation invalidation across harts in SMP
- Fixed ThreadX SMP regression on nx900fd
- Fixed PMP fetch/load/store checks, instruction access fault reporting and page-fault exception injection
- Fixed UART interrupt level/IP status reporting
- Fixed flame graph issues: RTOS tasks migrating across SMP cores were shown with duplicated thread identities, and M-mode/S-mode interrupt handlers were attributed to the wrong interrupt thread lane

**Known Issues:**

- Does not support CACHE emulation
- Some ThreadX SMP cases are not yet running correctly

.. _xlmodel_changelog_202510:

Version 2025.10
---------------

This release is based on **2025.02** version with some new features and bug fixes introduced.

- Support GDB debugging
- Support flame graph
- Add the CIDU module
- Add Nuclei systimer support in CLINT mode
- Support SMP ECLIC, can run smpdemo of FreeRTOS
- Add new cpu support for the Nuclei n300e and 1000 series
- Add zfinx/zhinx/zhinxmin/zdinx/zimop/zcmop/smaia/ssaia extensions
- Add hypervisor aia
- The base address and size of memory resources can be configured
- Support for setting the CPU frequency
- Output is separated into stdout and stderr

**Known Issues:**

- Does not support CACHE emulation
- Does not support booting a Linux Kernel
- Some SMP cases for RT-Thread and Zephyr are not yet running correctly
- When debugging with Nuclei Studio, if the ELF file lacks DWARF debug information, you need to add the ``--mem=0x0:0x10000000`` option as a workaround to prevent GDB from reporting memory read errors

.. _xlmodel_changelog_202502:

Version 2025.02
---------------

**Known Issues:**

- Does not support smp ECLIC, CIDU and CACHE emulation

**New Features:**

- Nuclei 200/300/900/1000 are supported, and support cpu core name are aligned with Nuclei SDK 0.7.1 release.
- Added support for Windows system, now both windows and linux system are supported.
- Added important parameters such as ``--cpu``, ``--ext``, and ``--mem``, and changed the ``--time`` parameter to ``--timeout``
- Added rough cycle calculation for vector instructions

**Improvements:**

- Improved the CPU, Timer, and UART models
- Improved the `xlmodel_nice` software package
- Resolved the issue where some instructions could not be profiled
- Adapted to run `demo_vnice`, `demo_plic`, and multiple RTOS cases in nuclei-sdk
