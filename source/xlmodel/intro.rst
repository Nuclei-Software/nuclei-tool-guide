.. _xlmodel_intro:

About Nuclei Near Cycle Model
=============================

The ``Nuclei Near Cycle Model`` (referred to as `xlmodel`) is a co-simulation using **SystemC TLM-2 combined with xlspike**. Xlspike uses spike as the RISC-V ISA simulator and adds support for Nuclei's N/NX/UX RISC-V processors.
SystemC establishes the TLM 2.0 interaction relationships among the components under **Nuclei EvalSoC**.

- The `xlmodel` can be obtained in **Nuclei Studio 2025.10**.
- The `xlmodel` is supported on both **Linux and Windows** system.
- The `xlmodel` supports **GDB debugging** capabilities (GDB RSP interface) with Nuclei Studio.
- The `xlmodel` is a **near cycle model** that can test the performance of firmware with different ISA configurations.
- The `xlmodel` has SystemC built-in and uses version 2.3.4 by default.
- The `xlmodel` has built-in **gprof** functionality, offering a detailed view of the functions call graph and the cycle count distribution across functions in the test code.
- The `xlmodel` supports **flame graph** generation for visualizing call stack performance and multi-core/multi-threaded application execution.
- The `xlmodel` can easily extend **user-defined** instructions, namely **Nuclei NICE instructions**.
- Xlspike supports RV32IMAFDCBPV and RV64IMAFDCBPV ISA.

Since this model is also integrated in Nuclei Studio, you can use it to do

- Profiling and Code Coverage
  - https://doc.nucleisys.com/nuclei_studio_supply/18-demonstrate_NICE_VNICE_acceleration_of_the_Nuclei_Model_through_profiling/
  - https://doc.nucleisys.com/nuclei_studio_supply/19-rapid_verification_of_NICE_VNICE_acceleration_with_Nuclei_Model_and_NICE_Wizard/
  - :ref:`ide_advanceusage_profiling`
- NICE Instruction Design and Modeling
  - :ref:`ide_nuclei_nice_wizard`
- Debugging in Nuclei Studio
  - :ref:`ide_nuclei_model_debugger`
- Flame Graph
  - :ref:`Nuclei Studio use xlmodel flame graph <ide_nuclei_model_flame>`

.. note::

  Before using `xlmodel`, you should check the current version using the ``--version`` parameter to verify whether it is the latest release.

The version output of the current latest version is

.. image:: /asserts/images/xlmodel/xlmodel_version.png


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
* EvalUart: Nuclei EvalSoC UART
* EvalQspi: Nuclei EvalSoC QSPI

Address Allocation of Evalsoc in xlmodel
----------------------------------------

For the sake of generality, some Nuclei IP cores have been mapped and implemented in `xlmodel`. Some of these IP cores use fixed addresses, while others are dynamically initialized based on iregion information.

  ``Fixed``: The address is fixed by default in `xlmodel`.

  ``Offset``: The address is equal to iregion base address plus the corresponding offset.

  +---------------------+-----------------------+-----------------------+-----------------------+---------------------------------------+
  |                     | Component             | Base Address          | Size                  | Description                           |
  +=====================+=======================+=======================+=======================+=======================================+
  | Memory Resource     | XIP                   | 0x20000000            | 0x10000000            | XIP address space.                    |
  +---------------------+-----------------------+-----------------------+-----------------------+---------------------------------------+
  |                     | DDR                   | 0x80000000            | 0x04000000            | DDR address space.                    |
  +---------------------+-----------------------+-----------------------+-----------------------+---------------------------------------+
  |                     | ILM                   | 0x80000000            | 0x10000000            | ILM address space.                    |
  +---------------------+-----------------------+-----------------------+-----------------------+---------------------------------------+
  |                     | DLM                   | 0x90000000            | 0x10000000            | DLM address space.                    |
  +---------------------+-----------------------+-----------------------+-----------------------+---------------------------------------+
  |                     | SRAM                  | 0xA0000000            | 0x10000000            | SRAM address space.                   |
  +---------------------+-----------------------+-----------------------+-----------------------+---------------------------------------+
  | Peripherals (Fixed) | MROM                  | 0x1000                | 0xf000                | MROM address space.                   |
  +---------------------+-----------------------+-----------------------+-----------------------+---------------------------------------+
  |                     | UART0                 | 0x10013000            | 0x1000                | UART0 address space.                  |
  +---------------------+-----------------------+-----------------------+-----------------------+---------------------------------------+
  |                     | QSPI0                 | 0x10014000            | 0x1000                | QSPI0 address space.                  |
  +---------------------+-----------------------+-----------------------+-----------------------+---------------------------------------+
  |                     | QSPI1                 | 0x10024000            | 0x1000                | QSPI1 address space.                  |
  +---------------------+-----------------------+-----------------------+-----------------------+---------------------------------------+
  |                     | QSPI2                 | 0x10034000            | 0x1000                | QSPI2 address space.                  |
  +---------------------+-----------------------+-----------------------+-----------------------+---------------------------------------+
  | Peripherals (Offset)| ECLIC                 | 0x20000               | 0x10000               | ECLIC address space.                  |
  +---------------------+-----------------------+-----------------------+-----------------------+---------------------------------------+
  |                     | TIMER                 | 0x30000               | 0x10000               | TIMER address space.                  |
  +---------------------+-----------------------+-----------------------+-----------------------+---------------------------------------+
  |                     | CIDU                  | 0x50000               | 0x10000               | CIDU address space.                   |
  +---------------------+-----------------------+-----------------------+-----------------------+---------------------------------------+
  |                     | PLIC                  | 0x4000000             | 0x4000000             | PLIC address space.                   |
  +---------------------+-----------------------+-----------------------+-----------------------+---------------------------------------+

Evalsoc's memory resource address mapping can be modified using parameters such as ``--ddrbase=<ddr_start_addr>`` and ``--ddrsz=<ddr_size>``. Users can also define additional memory regions for memory expansion via the ``--mem=<str>`` parameter.

For details, please see :ref:`xlmodel_description_of_parameters`.

Nuclei CPU Features Supported in xlmodel
----------------------------------------

The following is the support status of Nuclei CPU features in `xlmodel`.

  +---------------------+-------------------------------------------------------+
  | CPU Features        | Status in xlmodel                                     |
  +=====================+=======================================================+
  |NMI                  | Supported                                             |
  +---------------------+-------------------------------------------------------+
  |TIMER                | Supported, see :ref:`xlmodel_support_status_of_timer` |
  +---------------------+-------------------------------------------------------+
  |PLIC                 | Supported, see :ref:`xlmodel_support_status_of_plic`  |
  +---------------------+-------------------------------------------------------+
  |ECLIC                | Supported, see :ref:`xlmodel_support_status_of_eclic` |
  +---------------------+-------------------------------------------------------+
  |CIDU                 | Supported, see :ref:`xlmodel_support_status_of_cidu`  |
  +---------------------+-------------------------------------------------------+
  |PMP                  | Supported                                             |
  +---------------------+-------------------------------------------------------+
  |TEE                  | Supported                                             |
  +---------------------+-------------------------------------------------------+
  |WFI/WFE              | Not supported                                         |
  +---------------------+-------------------------------------------------------+
  |ECC                  | Only CSRs Supported                                   |
  +---------------------+-------------------------------------------------------+
  |CCM                  | Only CSRs Supported                                   |
  +---------------------+-------------------------------------------------------+
  |SPMP                 | Not supported                                         |
  +---------------------+-------------------------------------------------------+
  |SMPU                 | Supported                                             |
  +---------------------+-------------------------------------------------------+
  |SMP&CLUSTER CACHE    | Not supported                                         |
  +---------------------+-------------------------------------------------------+

.. _xlmodel_support_status_of_timer:

TIMER Support
~~~~~~~~~~~~~

TIMER currently supports normal access and interrupt triggering under two interrupt architectures, eclic and clint (plic) in m-mode, but the functionality in s-mode has not yet been implemented.

.. _xlmodel_support_status_of_plic:

PLIC Support
~~~~~~~~~~~~

The PLIC interrupt architecture supports M-mode and S-mode, but it only supports single-core mode and does not support multi-core mode.

.. _xlmodel_support_status_of_eclic:

ECLIC Support
~~~~~~~~~~~~~

Now `xlmodel` have been equipped with ECLIC, which is optimized based on the RISC-V standard CLIC, to manage all interrupt sources. The ECLIC interrupt architecture supports M-mode and S-mode, and it can support multi-core mode.

.. _xlmodel_support_status_of_cidu:

CIDU Support
~~~~~~~~~~~~

  The CIDU is used to distribute external interrupts to the core's ECLIC, and also provides Inter Core Interrupt (ICI) and Semaphores Mechanism. All of these features are currently implemented and available.


Nuclei SDK Cases Supported in xlmodel
-------------------------------------

  ``Y`` - Successfully run and consistent with hardware

  ``N`` - Successfully run but inconsistent with hardware

  ``F`` - Failed

+---------------------------+-------+-------+----------------------------------------------------+-----------------------------------------------------------------------------------+
| Cases                     | SMP=1 | SMP>1 | Additional compilation parameters                  | Running Status                                                                    |
+===========================+=======+=======+====================================================+===================================================================================+
| benchmark/coremark/       | Y     |       |                                                    |                                                                                   |
+---------------------------+-------+-------+----------------------------------------------------+-----------------------------------------------------------------------------------+
| benchmark/dhrystone/      | Y     |       |                                                    |                                                                                   |
+---------------------------+-------+-------+----------------------------------------------------+-----------------------------------------------------------------------------------+
| benchmark/dhrystone_v2.2/ | Y     |       |                                                    |                                                                                   |
+---------------------------+-------+-------+----------------------------------------------------+-----------------------------------------------------------------------------------+
| benchmark/whetstone/      | Y     |       |                                                    |                                                                                   |
+---------------------------+-------+-------+----------------------------------------------------+-----------------------------------------------------------------------------------+
| benchmark/whetstone_v1.2/ | Y     |       |                                                    |                                                                                   |
+---------------------------+-------+-------+----------------------------------------------------+-----------------------------------------------------------------------------------+
| cpuinfo/                  | N     |       |                                                    |                                                                                   |
+---------------------------+-------+-------+----------------------------------------------------+-----------------------------------------------------------------------------------+
| demo_cache/               | F     |       | XLCFG_CCM, eg:XLCFG_CCM=1                          | xlmodel does not support cache emulation.                                         |
+---------------------------+-------+-------+----------------------------------------------------+-----------------------------------------------------------------------------------+
| demo_cidu/                |       | Y     | SMP,XLCFG_CIDU, eg:SMP=4 XXLCFG_CIDU=1             |                                                                                   |
+---------------------------+-------+-------+----------------------------------------------------+-----------------------------------------------------------------------------------+
| demo_clint_timer/         | Y     |       |                                                    |                                                                                   |
+---------------------------+-------+-------+----------------------------------------------------+-----------------------------------------------------------------------------------+
| demo_dsp/                 | Y     |       |                                                    |                                                                                   |
+---------------------------+-------+-------+----------------------------------------------------+-----------------------------------------------------------------------------------+
| demo_eclic/               | Y     |       |                                                    |                                                                                   |
+---------------------------+-------+-------+----------------------------------------------------+-----------------------------------------------------------------------------------+
| demo_nice/                | Y     |       |                                                    |                                                                                   |
+---------------------------+-------+-------+----------------------------------------------------+-----------------------------------------------------------------------------------+
| demo_plic/                | Y     |       | XLCFG_PLIC, eg:XLCFG_PLIC=1                        |                                                                                   |
+---------------------------+-------+-------+----------------------------------------------------+-----------------------------------------------------------------------------------+
| demo_pmp/                 | Y     |       |                                                    |                                                                                   |
+---------------------------+-------+-------+----------------------------------------------------+-----------------------------------------------------------------------------------+
| demo_profiling/           | N     |       |                                                    | xlmodel already implements its own profiling, so there is no need to run this case|
+---------------------------+-------+-------+----------------------------------------------------+-----------------------------------------------------------------------------------+
| demo_smode_eclic/         | Y     |       | XLCFG_TEE, eg:XLCFG_TEE=1                          |                                                                                   |
+---------------------------+-------+-------+----------------------------------------------------+-----------------------------------------------------------------------------------+
| demo_smode_plic/          | Y     |       | XLCFG_PLIC, eg:XLCFG_PLIC=1                        |                                                                                   |
+---------------------------+-------+-------+----------------------------------------------------+-----------------------------------------------------------------------------------+
| demo_smpu/                | Y     |       | XLCFG_SMPU, eg:XLCFG_SMPU=1                        |                                                                                   |
+---------------------------+-------+-------+----------------------------------------------------+-----------------------------------------------------------------------------------+
| demo_sstc/                | F     |       | XLCFG_TEE,XLCFG_SSTC, eg:XLCFG_TEE=1 XLCFG_SSTC=1  | xlmodel does not support SSTC.                                                    |
+---------------------------+-------+-------+----------------------------------------------------+-----------------------------------------------------------------------------------+
| demo_stack_check/         | N     |       |                                                    | xlmodel only implements CSR read and write, so there is no need to run this case. |
+---------------------------+-------+-------+----------------------------------------------------+-----------------------------------------------------------------------------------+
| demo_timer/               | Y     |       |                                                    |                                                                                   |
+---------------------------+-------+-------+----------------------------------------------------+-----------------------------------------------------------------------------------+
| demo_vnice/               | Y     |       |                                                    |                                                                                   |
+---------------------------+-------+-------+----------------------------------------------------+-----------------------------------------------------------------------------------+
| helloworld/               | Y     |       |                                                    |                                                                                   |
+---------------------------+-------+-------+----------------------------------------------------+-----------------------------------------------------------------------------------+
| lowpower/                 | Y     |       |                                                    |                                                                                   |
+---------------------------+-------+-------+----------------------------------------------------+-----------------------------------------------------------------------------------+
| smphello/                 |       | Y     | SMP, eg:SMP=4                                      |                                                                                   |
+---------------------------+-------+-------+----------------------------------------------------+-----------------------------------------------------------------------------------+
| freertos/demo/            | Y     |       |                                                    |                                                                                   |
+---------------------------+-------+-------+----------------------------------------------------+-----------------------------------------------------------------------------------+
| freertos/smpdemo/         |       | Y     | SMP, eg:SMP=4                                      |                                                                                   |
+---------------------------+-------+-------+----------------------------------------------------+-----------------------------------------------------------------------------------+
| rtthread/demo/            | Y     |       |                                                    |                                                                                   |
+---------------------------+-------+-------+----------------------------------------------------+-----------------------------------------------------------------------------------+
| rtthread/demo_smode/      | F     |       | XLCFG_TEE,XLCFG_SSTC, eg:XLCFG_TEE=1 XLCFG_SSTC=1  | xlmodel does not support SSTC.                                                    |
+---------------------------+-------+-------+----------------------------------------------------+-----------------------------------------------------------------------------------+
| rtthread/msh/             | Y     |       |                                                    |                                                                                   |
+---------------------------+-------+-------+----------------------------------------------------+-----------------------------------------------------------------------------------+
| threadx/demo/             | Y     |       |                                                    |                                                                                   |
+---------------------------+-------+-------+----------------------------------------------------+-----------------------------------------------------------------------------------+
| ucosii/demo/              | Y     |       |                                                    |                                                                                   |
+---------------------------+-------+-------+----------------------------------------------------+-----------------------------------------------------------------------------------+

And `xlmodel` and Nuclei SDK are deeply integrated in Nuclei Studio, you can run Nuclei SDK test code using `xlmodel` in Nuclei Studio, please refer to the :ref:`Nuclei Studio use xlmodel <ide_nuclei_near_cycle_model>`.

.. _xlmodel_description_of_parameters:

Description of Parameters
=========================

model help
----------

.. rubric:: Frequently used command line parameters

+--------------------------+-------------------------------------------------------------------------------------------------------------------+
| parameter                | description                                                                                                       |
+==========================+===================================================================================================================+
| ``--version``            | display version info                                                                                              |
+--------------------------+-------------------------------------------------------------------------------------------------------------------+
| ``--machine=<str>``      | machine type config, defaults to 'nuclei_evalsoc'                                                                 |
+--------------------------+-------------------------------------------------------------------------------------------------------------------+
| ``--cpu=<str>``          | core config, defaults to 'n300fd'                                                                                 |
+--------------------------+-------------------------------------------------------------------------------------------------------------------+
| ``--ext=<str>``          | RISC-V arch extensions config, defaults to NULL                                                                   |
+--------------------------+-------------------------------------------------------------------------------------------------------------------+
| ``--download=<str>``     | download type config, defaults to ``--download=flashxip`` and can be set to ``ilm``, ``ddr``, ``sram``, ``flash`` |
+--------------------------+-------------------------------------------------------------------------------------------------------------------+
| ``--cpufreq=<n>``        | CPU frequency (Hz), default is 655360 Hz, Set to a higher value for improved simulation accuracy                  |
+--------------------------+-------------------------------------------------------------------------------------------------------------------+
| ``--timeout=<n>``        | expected real execution time(s) for running simulation; otherwise, it is unlimited                                |
+--------------------------+-------------------------------------------------------------------------------------------------------------------+
| ``--trace=<n>``          | whether generate the trace file, ``--trace=1`` means generating                                                   |
+--------------------------+-------------------------------------------------------------------------------------------------------------------+
| ``--flamegraph=<n>``     | whether dump flame graph file xlmodel_flame_[coreid].gtef, ``--flamegraph=1`` means generating                    |
+--------------------------+-------------------------------------------------------------------------------------------------------------------+
| ``--bpu=<str>``          | core bpu type config, defaults to ``--bpu=n300`` and can be set to ``n900``                                       |
+--------------------------+-------------------------------------------------------------------------------------------------------------------+
| ``--smp=<n>``            | SMP system core number configuration, with a maximum of 16                                                        |
+--------------------------+-------------------------------------------------------------------------------------------------------------------+
| ``--funcmode=<n>``       | Whether to only use the function model which instructions do not have cycle count in                              |
+--------------------------+-------------------------------------------------------------------------------------------------------------------+
| ``--gdbport=<n>``        | Accept gdbport connection with ``--gdbport=port num``                                                             |
+--------------------------+-------------------------------------------------------------------------------------------------------------------+
| ``--gprof=<n>``          | whether to use profiling, ``--gprof=1`` means using profiling                                                     |
+--------------------------+-------------------------------------------------------------------------------------------------------------------+
| ``--varch=<str>``        | RISCV Vector uArch config, defaults to ``--varch=vlen:128,elen:64``                                               |
+--------------------------+-------------------------------------------------------------------------------------------------------------------+
| ``--log=<str>``          | logging system level, defaults to ``--log=info`` and can be set to ``error``, ``tlm``, ``debug``                  |
+--------------------------+-------------------------------------------------------------------------------------------------------------------+
| ``--logdir=<str>``       | the directory to save trace and gprof files                                                                       |
+--------------------------+-------------------------------------------------------------------------------------------------------------------+
| ``--mem=<str>``          | User-defined additional memory map config, ``--mem="start_addr0:size0,start_addr1:size1..."``                     |
+--------------------------+-------------------------------------------------------------------------------------------------------------------+
| ``--iregionbase=<str>``  | iregionbase config, ``--iregionbase=iregion_start_addr``                                                          |
+--------------------------+-------------------------------------------------------------------------------------------------------------------+
| ``--ilmbase=<str>``      | ilmbase config, ``--ilmbase=ilm_start_addr``                                                                      |
+--------------------------+-------------------------------------------------------------------------------------------------------------------+
| ``--ilmsz=<str>``        | ilmsz config, ``--ilmsz=ilm_size``                                                                                |
+--------------------------+-------------------------------------------------------------------------------------------------------------------+
| ``--dlmbase=<str>``      | dlmbase config, ``--dlmbase=dlm_start_addr``                                                                      |
+--------------------------+-------------------------------------------------------------------------------------------------------------------+
| ``--dlmsz=<str>``        | dlmsz config, ``--dlmsz=dlm_size``                                                                                |
+--------------------------+-------------------------------------------------------------------------------------------------------------------+
| ``--ddrbase=<str>``      | ddrbase config, ``--ddrbase=ddr_start_addr``                                                                      |
+--------------------------+-------------------------------------------------------------------------------------------------------------------+
| ``--ddrsz=<str>``        | ddrsz config, ``--ddrsz=ddr_size``                                                                                |
+--------------------------+-------------------------------------------------------------------------------------------------------------------+
| ``--flashxipbase=<str>`` | flashxipbase config, ``--flashxipbase=flashxip_start_addr``                                                       |
+--------------------------+-------------------------------------------------------------------------------------------------------------------+
| ``--flashxipsz=<str>``   | flashxipsz config, ``--flashxipsz=flashxip_size``                                                                 |
+--------------------------+-------------------------------------------------------------------------------------------------------------------+

You need to pass the different parameters above based on the results you want to obtain and the specific test code you are running.

parameter usage
---------------

When you want to use the model, you can select the executable file as follows:

- For Linux: :file:`bin/xl_cpumodel`
- For Windows: :file:`bin/xl_cpumodel.exe`

The following parameter examples are based on a Linux system. If you are using a Windows system, simply replace :command:`xl_cpumodel` with :command:`xl_cpumodel.exe`.

The default test code ELF files are provided in the :file:`tests` directory.

* ``--cpu=<core_type>``: Each test code needs to be run with this parameter. To see all Nuclei cores that are supported by `xlmodel`, refer to the `Supported Nuclei Processor Cores section <https://doc.nucleisys.com/nuclei_sdk/develop/buildsystem.html#core>`__. This is an example of running an ELF file with `nx900` core using the `xlmodel`::

  ./xl_cpumodel --cpu=nx900 --download=ilm ../tests/demotimer/demotimer_nx900.elf

  .. image:: /asserts/images/xlmodel/demotimer.png

* ``--ext=xxx``: This parameter is used to pass different riscv extension, the way to enable different extensions is to add them inside it. For example, ``_xxldsp`` represents enable the nuclei DSP extension, ``v`` represents enable RISC-V V Extension. Currently, `xlmodel` supports the following common RISC-V instruction set extension types:

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
  | _zfh         | Zfh  Extension                                                          |
  +--------------+-------------------------------------------------------------------------+
  | _zfa         | Zfa  Extension                                                          |
  +--------------+-------------------------------------------------------------------------+
  | _zfhmin      | Zfhmin Extension                                                        |
  +--------------+-------------------------------------------------------------------------+
  | zfinx        | Zfinx  Extension                                                        |
  +--------------+-------------------------------------------------------------------------+
  | zdinx        | Zdinx  Extension                                                        |
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
  | zhinx        | Zhinx Extension                                                         |
  +--------------+-------------------------------------------------------------------------+
  | zhinxmin     | Zhinxmin Extension                                                      |
  +--------------+-------------------------------------------------------------------------+
  | smaia        | Smaia Extension                                                         |
  +--------------+-------------------------------------------------------------------------+
  | ssaia        | Ssaia  Extension                                                        |
  +--------------+-------------------------------------------------------------------------+
  | _sscofpmf    | Sscofpmf  Extension                                                     |
  +--------------+-------------------------------------------------------------------------+
  | _sstc        | Sstc  Extension                                                         |
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

  This is an example of running an ELF file with `_zba_zbb_zbc_zbs_xxldspn1x` extension using the `xlmodel`::

  ./xl_cpumodel --cpu=n300fd --download=ilm --ext=_zba_zbb_zbc_zbs_xxldspn1x ../tests/demodsp/demodsp_n300fd.elf

* ``--varch=vlen:n,elen:n``: The VLEN and ELEN are only effective when the V extension instructions of RISC-V are enabled. **Note that VLEN and ELEN must comply with the RISC-V Vector specifications**. Example::

  ./xl_cpumodel --cpu=ux900fd --ext=v --download=ilm --varch=vlen:128,elen:64 ../tests/rvv_conv_f32/rvv_conv_f32.elf
  ./xl_cpumodel --cpu=ux900fd --ext=v --download=ilm --varch=vlen:256,elen:64 ../tests/rvv_conv_f32/rvv_conv_f32.elf
  ./xl_cpumodel --cpu=ux900fd --ext=v --download=ilm --varch=vlen:512,elen:64 ../tests/rvv_conv_f32/rvv_conv_f32.elf
  ./xl_cpumodel --cpu=ux900fd --ext=v --download=ilm --varch=vlen:1024,elen:64 ../tests/rvv_conv_f32/rvv_conv_f32.elf

* ``--download=xxx``: This parameter is used to choose the download mode, currently it supports five download modes: ``sram``, ``flashxip``, ``flash``, ``ilm``, and ``ddr``. If this parameter is not present, the default value is ``flashxip``. Example::

  ./xl_cpumodel --cpu=nx900 --download=sram --smp=4 ../tests/democidu_en_firclaim/democidu_en_firclaim_nx900.elf

* ``--cpufreq=<n>``: This parameter sets the CPU frequency (Hz), the default is 655360 Hz. **Note that a higher frequency setting improves simulation accuracy and should typically be set above the default value**. Example::

  ./xl_cpumodel ../tests/demodsp/demodsp_n300fd.elf --cpu=n300fd --ext=_zba_zbb_zbc_zbs_xxldspn1x --download=ilm --cpufreq=50000000

  When using flame graphs, you can set different frequencies to observe variations in program execution time. 

* ``--smp=n``: `xlmodel` currently supports up to 16 CPUs. If this parameter is not set, then uses 1 CPU. Running the 4-core SMP example is as follows::

  ./xl_cpumodel --cpu=nx900 --download=sram --smp=4 ../tests/smphello_4core/smphello_nx900.elf

* ``--mem=start_addr0:size0,start_addr1:size1...``: when you compile the test code using external memory sections, you need to pass the memory map of the SoC, i.e., the starting address and sizes of each section, as parameters to the `xlmodel`. Example::

  ./xl_cpumodel --cpu=nx900 --download=ilm --mem="0x30000000:0x10000000,0x40000000:0x10000000" ../tests/demoeclic_swirq_high/demoeclic_swirq_high_nx900.elf

* ``--bpu=xxx``: The `xlmodel` can select different **BPU strategies** based on Nuclei core types, which will affect the cycle count of branch and jump instructions. `xlmodel` currently supports the ``--bpu=n300`` and ``--bpu=n900`` parameters.

  * The ``--bpu=n300`` parameter is applicable to Nuclei cores up to and including N300 (<= N300)::

    ./xl_cpumodel --cpu=n300fd --ext=_zba_zbb_zbc_zbs_xxldspn1x --download=ilm --bpu=n300 ../tests/demodsp/demodsp_n300fd.elf

  * The ``--bpu=n900`` parameter is applicable to Nuclei cores from N300 onwards (> N300)::

    ./xl_cpumodel --cpu=nx900 --download=ilm --bpu=n900 ../tests/demotimer/demotimer_nx900.elf

*  ``--trace=1``: `xlmodel` currently supports outputting instruction trace streams during execution, The :file:`<elf-name>.rvtrace` file will be generated in the current execution path. Example::

    ./xl_cpumodel --cpu=nx900 --download=ilm --trace=1 ../tests/demoeclic_swirq_low/demoeclic_swirq_low_nx900.elf

  You can obtain information such as the instruction count, cycle count, the associated hart, pc, opcode, disassembly code for each instruction in generated :file:`<elf-name>.rvtrace` file.

*  ``--gprof=1``: This parameter is used to enable the built-in **gprof** functionality of `xlmodel`. The :file:`gprof<n>.gmon` and :file:`gprof<n>.log` files will be generated in the current execution path. Example::

    ./xl_cpumodel --cpu=nx900fd --download=ilm --gprof=1 ../tests/whet/whet_nx900.elf

  You can obtain the :file:`gprof<n>.gmon` and :file:`gprof<n>.log` files when the simulation is complete, where n represents the hart ID.

  To use them further, you need to import them into the IDE, then you can refer to the model usage guide in the Nuclei Studio for detailed instructions on using **gprof**.

*  ``--flamegraph=1``: This parameter is used to enable the built-in **flamegraph** functionality of `xlmodel`. The :file:`xlmodel_flame_<n>.gtef` files will be generated in the current execution path. Example::

    ./xl_cpumodel --cpu=n300fd --download=ilm --flamegraph=1 ../tests/demo_clint_timer/demo_clint_timer_n300fd.elf

  You can obtain the :file:`xlmodel_flame_<n>.gtef` files when the simulation is complete, where n represents the hart ID.

  To use them further, you need to import them into the IDE, then you can refer to the :ref:`Nuclei Studio use xlmodel flame graph <ide_nuclei_model_flame>` for detailed usage.

* ``--logdir=<str>``: The directory to store generated log files (e.g., instruction trace, gprof files, or flame graphs). This setting takes effect when any of the following options is enabled: ``--trace=1``, ``--gprof=1`` or ``--flamegraph=1``. Example::

  ./xl_cpumodel --cpu=nx900 --download=ilm --trace=1 --gprof=1 --flamegraph=1 --logdir=../log ../tests/demoeclic_swirq_low/demoeclic_swirq_low_nx900.elf

* ``--timeout=<n>``: You can pass this parameter to set the real execution duration for simulation runs. **Note that this parameter is ignored during GDB debugging**.

  When the timeout period is reached, the :file:`gprof<n>.gmon` and :file:`gprof<n>.log` files will be generated if the ``--gprof=1`` parameter is enabled. An example of specifying a 20-second simulation is as follows::

    ./xl_cpumodel --cpu=nx900 --download=ilm --timeout=20 --gprof=1 ../tests/cmk/cmk_nx900.elf

  When the timeout period is reached, the :file:`xlmodel_flame_<n>.gtef` files will be generated if the ``--flamegraph=1`` parameter is enabled. An example of specifying a 3-second simulation is as follows::

    ./xl_cpumodel --cpu=nx900 --download=sram --smp=2 --flamegraph=1 --timeout=3 ../tests/freertos_smpdemo/freertos_smpdemo_nx900.elf

* ``--log=xxx``: The `xlmodel` has multiple log levels, listed from least to most detailed as `error`, `info`, `debug`, `tlm`. By default, it provides basic log information at the `info` level, which can be changed by passing ``--log=xxx``.

  When ``--log=error`` is selected, it only outputs error messages generated during the xlmodel runtime::

    ./xl_cpumodel --cpu=nx900 --download=ilm --log=error ../tests/demotimer/demotimer_nx900.elf

  When ``--log=debug`` is selected, the following options provide additional detailed information:

    * ``--trace=1``: The :file:`<elf-name>.rvtrace` file will contain detailed trace information, including register updates, exceptions, and CSRs::

      ./xl_cpumodel --cpu=nx900 --download=ilm --log=debug --trace=1 ../tests/demotimer/demotimer_nx900.elf

    * ``--gprof=1``: It will output the completion status of gprof file to the terminal, ``Write done for core <n>`` means completed, otherwise means incomplete::

      ./xl_cpumodel --cpu=nx900 --download=ilm --log=debug --gprof=1 ../tests/demotimer/demotimer_nx900.elf

  When ``--log=tlm`` is selected, it includes all the features of ``--log=debug`` and additionally outputs TLM bus read and write information to the terminal::

    ./xl_cpumodel --cpu=nx900 --download=ilm --log=tlm ../tests/demotimer/demotimer_nx900.elf

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

For an easier experience using GDB debugging with `xlmodel`, we recommend using Nuclei Studio. When GDB is enabled, passing ``--gprof=1`` and ``--flamegraph=1`` allows you to capture profiling result and generated flame graph visualizations while the program is suspended in GDB.

For more information on using `xlmodel` debugging in Nuclei Studio, please refer to the :ref:`ide_nuclei_model_debugger`.

.. note::

  The ``--timeout=<n>`` parameter has no effect when software debugging is enabled.

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

    pacman -S base-devel mingw-w64-x86_64-gcc mingw-w64-x86_64-cmake

3. Compile `xlmodel_nice` in the **MinGW64 terminal**:

.. code-block:: shell

    # Check the tools have been installed successfully
    gcc -v && g++ -v && cmake --version
    # Change to the root directory of the xlmodel_nice package
    cd <xlmodel_nice root directory>
    mkdir build && cd build
    cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Rlease ..
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

If you need to integrate `xlmodel` into a third-party SoC simulation platform, you need to contact Nuclei AE for the software integration package of the model (`xlmodel_integration`).

`xlmodel_integration` mainly includes the source code of :ref:`xlmodel_systemc_components`. You can extract the parts you need and use them on third-party platforms with relatively little adaptation.

The main directory structure of `xlmodel_integration` is as follows:

+----------------+------------------------------------------------------------------------------------------------------------+
| directory      | description                                                                                                |
+================+============================================================================================================+
| src            | All SystemC components, Cluster and Timer are mandatory to integrate, while others be integrated as needed |
+----------------+------------------------------------------------------------------------------------------------------------+
| inc            | All header files related to xlmodel, which are integrated as needed                                        |
+----------------+------------------------------------------------------------------------------------------------------------+
| systemc        | SystemC 2.3.4 header files and static libraries, which are integrated as needed                            |
+----------------+------------------------------------------------------------------------------------------------------------+
| cycle          | The near cycle lib file, must be integrated                                                                |
+----------------+------------------------------------------------------------------------------------------------------------+
| profiling      | The xlmodel profiling lib file, which is integrated as needed                                              |
+----------------+------------------------------------------------------------------------------------------------------------+
| xlspike        | xlspike header files and library files, must be fully integrated                                           |
+----------------+------------------------------------------------------------------------------------------------------------+
| tests          | simple test codes                                                                                          |
+----------------+------------------------------------------------------------------------------------------------------------+
| nice           | header and source files for the NICE interface, must be fully integrated                                   |
+----------------+------------------------------------------------------------------------------------------------------------+
| CMakeLists.txt | CMake file required for compilation                                                                        |
+----------------+------------------------------------------------------------------------------------------------------------+

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

     * Configure the number of external interrupts by updating ``ext_irq_num`` during Cluster instantiation.

     * Bind your device's interrupt socket to the CPU.

     * Use the device socket's ``b_transport`` method to pass the **irq_id** to the CPU.

Changelog
=========

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

