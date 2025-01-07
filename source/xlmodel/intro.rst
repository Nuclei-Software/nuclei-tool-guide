.. _xlmodel_intro:

About Nuclei Near Cycle Model
=============================

The ``Nuclei Near Cycle Model`` (referred to as `xlmodel`) is a co-simulation using **SystemC TLM-2 combined with xlspike**. Xlspike uses spike as the RISC-V ISA simulator and adds support for Nuclei's N/NX/UX RISC-V processors.
SystemC establishes the TLM 2.0 interaction relationships among the components under **Nuclei EvalSoC**.

- The `xlmodel` can be obtained in **Nuclei Studio 2024.12**.
- The `xlmodel` is supported on both **Linux and Windows** system.
- The `xlmodel` is a **near cycle model** that can test the performance of firmware with different ISA configurations.
- The `xlmodel` has SystemC built-in and uses version 2.3.4 by default.
- The `xlmodel` has built-in **gprof** functionality, allowing for a more intuitive display of the function call stack, the cycle count proportion of each function within the test code.
- The `xlmodel` can easily extend **user-defined** instructions, namely **Nuclei NICE instructions**.
- Xlspike supports RV32IMAFDCBPV and RV64IMAFDCBPV ISA.

Design and Architecture
=======================

SystemC components
------------------

Brief description of the `xlmodel` SystemC components:

* Top: Top-level entity that builds & starts the SystemC simulation
* Cluster: Cluster contains multiple cores and can be used to start xlspike for co-simulation
* Bus: Simple bus manager
* Memory: Memory comprises both instruction memory and data memory, as well as the loading of ELF sections
* EvalUart: Nuclei EvalSoC uart
* EvalQspi: Nuclei EvalSoC qspi

Address Allocation of Evalsoc in xlmodel
----------------------------------------

For the sake of generality, some Nuclei IP cores have been mapped and implemented in `xlmodel`. Some of these IP cores use fixed addresses, while others are dynamically initialized based on iregion information.

  ``Fixed``: The address is fixed by default in `xlmodel`.

  ``Offset``: The address is equal to iregion base address plus the corresponding offset.

  +---------------------+-----------------------+-----------------------+-----------------------+---------------------------------------+
  |                     | Component             | Base Address          | Size                  | Description                           |
  +=====================+=======================+=======================+=======================+=======================================+
  | Memory Resource     | XIP                   | 0x20000000            | 0x02000000            | XIP address space.                    |
  +---------------------+-----------------------+-----------------------+-----------------------+---------------------------------------+
  |                     | DDR                   | 0x80000000            | 0x04000000            | DDR address space.                    |
  +---------------------+-----------------------+-----------------------+-----------------------+---------------------------------------+
  |                     | ILM                   | 0x80000000            | 0x00800000            | ILM address space.                    |
  +---------------------+-----------------------+-----------------------+-----------------------+---------------------------------------+
  |                     | DLM                   | 0x90000000            | 0x00800000            | DLM address space.                    |
  +---------------------+-----------------------+-----------------------+-----------------------+---------------------------------------+
  |                     | SRAM                  | 0xA0000000            | 0x20000000            | SRAM address space.                   |
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
  |                     | PLIC                  | 0x4000000             | 0x4000000             | PLIC address space.                   |
  +---------------------+-----------------------+-----------------------+-----------------------+---------------------------------------+

In addition, Evalsoc's address mapping can be customized and configured through the ``--mem=<str>`` parameter. Regarding the usage of this parameter, please see :ref:`Description_of_Parameters`.

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
  |CIDU                 | Not supported                                         |
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

Now `xlmodel` have been equipped with ECLIC, which is optimized based on the RISC-V standard CLIC, to manage all interrupt sources. The ECLIC interrupt architecture supports M-mode and S-mode, but it only supports single-core mode and does not support multi-core mode.


Nuclei SDK Cases Supported in xlmodel
-------------------------------------

  ``Y`` - Successfully run and consistent with hardware

  ``N`` - Successfully run but inconsistent with hardware

  ``F`` - Failed

+-----------------------+---------------+---------------+-----------------------------------------------+-----------------------------------------------+
| Cases                 | SMP=1         | SMP>1         | Additional compilation parameters             | Running Status                                |
+=======================+===============+===============+===============================================+===============================================+
| benchmark/coremark/   | Y             |               |                                               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+-----------------------------------------------+
| benchmark/dhrystone/  | Y             |               |                                               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+-----------------------------------------------+
| benchmark/whetstone/  | Y             |               |                                               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+-----------------------------------------------+
| cpuinfo/              | N             |               |                                               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+-----------------------------------------------+
| demo_cache/           | F             |               | XLCFG_CCM, eg:XLCFG_CCM=1                     | xlmodel does not support cache emulation.     |
+-----------------------+---------------+---------------+-----------------------------------------------+-----------------------------------------------+
| demo_cidu/            | F             | F             | SMP,XLCFG_CIDU, eg:SMP=1 XXLCFG_CIDU=1        | xlmodel does not support cidu.                |
+-----------------------+---------------+---------------+-----------------------------------------------+-----------------------------------------------+
| demo_clint_timer/     | Y             |               |                                               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+-----------------------------------------------+
| demo_dsp/             | Y             |               |                                               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+-----------------------------------------------+
| demo_eclic/           | Y             |               |                                               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+-----------------------------------------------+
| demo_nice/            | Y             |               |                                               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+-----------------------------------------------+
| demo_plic/            | F             | F             | XLCFG_PLIC, eg:XLCFG_PLIC=1                   | xlmodel PLIC interrupt for UART fail.         |
+-----------------------+---------------+---------------+-----------------------------------------------+-----------------------------------------------+
| demo_pmp/             | Y             |               |                                               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+-----------------------------------------------+
| demo_profiling/       | F             |               |                                               | xlmodel already implements its own profiling, |
|                       |               |               |                                               | so there is no need to run this case.         |
+-----------------------+---------------+---------------+-----------------------------------------------+-----------------------------------------------+
| demo_smode_eclic/     | Y             |               | XLCFG_TEE, eg:XLCFG_TEE=1                     |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+-----------------------------------------------+
| demo_smpu/            | Y             |               | XLCFG_SMPU, eg:XLCFG_SMPU=1                   |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+-----------------------------------------------+
| demo_stack_check/     | N             |               |                                               | xlmodel only implements CSR read and write.   |
+-----------------------+---------------+---------------+-----------------------------------------------+-----------------------------------------------+
| demo_timer/           | Y             |               |                                               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+-----------------------------------------------+
| demo_vnice/           | Y             |               |                                               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+-----------------------------------------------+
| helloworld/           | Y             |               |                                               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+-----------------------------------------------+
| lowpower/             | Y             |               |                                               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+-----------------------------------------------+
| smphello/             |               | Y             | SMP, eg:SMP=4                                 |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+-----------------------------------------------+
| freertos/demo/        | Y             |               |                                               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+-----------------------------------------------+
| freertos/smpdemo/     |               | F             | SMP, eg:SMP=4, all tasks run on core0.        | xlmodel does not support SMP ECLIC.           |
+-----------------------+---------------+---------------+-----------------------------------------------+-----------------------------------------------+
| rtthread/demo/        | Y             |               |                                               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+-----------------------------------------------+
| rtthread/msh/         | Y             |               |                                               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+-----------------------------------------------+
| threadx/demo/         | Y             |               |                                               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+-----------------------------------------------+
| ucosii/demo/          | Y             |               |                                               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+-----------------------------------------------+

And `xlmodel` and Nuclei SDK are deeply integrated in Nuclei Studio, you can run Nuclei SDK test code using `xlmodel` in Nuclei Studio, please refer to the :ref:`ide_nuclei_near_cycle_model`.

.. _Description_of_Parameters:

Description of Parameters
=========================

model help
----------

.. rubric:: Frequently used command line parameters

+--------------------+-------------------------------------------------------------------------------------------------+
| parameter          | description                                                                                     |
+====================+=================================================================================================+
| ``--version``      | display version info                                                                            |
+--------------------+-------------------------------------------------------------------------------------------------+
| ``--machine=<str>``| machine type config, defaults to 'nuclei_evalsoc'                                               |
+--------------------+-------------------------------------------------------------------------------------------------+
| ``--cpu=<str>``    | core config, defaults to 'n300fd'                                                               |
+--------------------+-------------------------------------------------------------------------------------------------+
| ``--ext=<str>``    | RISC-V arch extensions config, defaults to NULL                                                 |
+--------------------+-------------------------------------------------------------------------------------------------+
| ``--mem=<str>``    | memory map config, --mem="start_addr0:size0,start_addr1:size1..."                               |
+--------------------+-------------------------------------------------------------------------------------------------+
| ``--timeout=<n>``  | expected real execution time(s); otherwise, it is unlimited                                     |
+--------------------+-------------------------------------------------------------------------------------------------+
| ``--bpu=<str>``    | core bpu type config, defaults to ``--bpu=n300`` and can be set to ``n900``                     |
+--------------------+-------------------------------------------------------------------------------------------------+
| ``--smp=<n>``      | SMP system core number configuration, with a maximum of 16                                      |
+--------------------+-------------------------------------------------------------------------------------------------+
| ``--trace=<n>``    | whether generate the trace file, ``--trace=1`` means generating                                 |
+--------------------+-------------------------------------------------------------------------------------------------+
| ``--gprof=<n>``    | whether to use profiling, ``--gprof=1`` means using profiling                                   |
+--------------------+-------------------------------------------------------------------------------------------------+
| ``--varch=<str>``  | RISCV Vector uArch config, defaults to ``--varch=vlen:128,elen:64``                             |
+--------------------+-------------------------------------------------------------------------------------------------+
| ``--funcmode=<n>`` | Whether to only use the function model which instructions do not have cycle count in            |
+--------------------+-------------------------------------------------------------------------------------------------+
| ``--log=<str>``    | logging system level, defaults to ``--log=info`` and can be set to ``error``, ``tlm``, ``debug``|
+--------------------+-------------------------------------------------------------------------------------------------+
| ``--logdir=<str>`` | the directory to save trace and gprof files                                                     |
+--------------------+-------------------------------------------------------------------------------------------------+

You need to pass the different parameters above based on the results you want to obtain and the specific test code you are running.

parameter usage
---------------

When you want to use the model, you can select the executable file as follows:

- For Linux: :file:`bin/xl_cpumodel`
- For Windows: :file:`bin/xl_cpumodel.exe`

The following parameter examples are based on a Linux system. If you are using a Windows system, simply replace :command:`xl_cpumodel` with :command:`xl_cpumodel.exe`.

The default test code ELF files are provided in the :file:`tests` directory.

* ``--cpu=<core_type>``: Each test code needs to be run with this parameter. To see all Nuclei cores that are supported by `xlmodel`, refer to the `Supported Nuclei Processor Cores section <https://doc.nucleisys.com/nuclei_sdk/develop/buildsystem.html#core>`__. This is an example of running an ELF file with `nx900` core using the `xlmodel`::

    ./xl_cpumodel --cpu=nx900 ../tests/demotimer/demotimer_nx900.elf

.. image:: /asserts/images/xlmodel/demotimer.png

* ``--ext=``: This parameter is used to pass different riscv extension, the way to enable different extensions is to add them inside it. For example, ``_xxldsp`` represents enable the nuclei DSP extension, ``v`` represents enable RISC-V V Extension. Currently, `xlmodel` supports the following common RISC-V instruction set extension types:

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

    ./xl_cpumodel --cpu=n300fd --ext=_zba_zbb_zbc_zbs_xxldspn1x ../tests/demodsp/demo_dsp_n300fd.elf

* ``--varch=vlen:n,elen:n``: The VLEN and ELEN are only effective when the V extension instructions of RISC-V are enabled. Note that VLEN and ELEN must comply with the RISC-V Vector specifications. Example::

    ./xl_cpumodel --cpu=ux900fd --ext=v --varch=vlen:128,elen:64 ../tests/rvv_conv_f32/rvv_conv_f32.elf
    ./xl_cpumodel --cpu=ux900fd --ext=v --varch=vlen:256,elen:64 ../tests/rvv_conv_f32/rvv_conv_f32.elf
    ./xl_cpumodel --cpu=ux900fd --ext=v --varch=vlen:512,elen:64 ../tests/rvv_conv_f32/rvv_conv_f32.elf
    ./xl_cpumodel --cpu=ux900fd --ext=v --varch=vlen:1024,elen:64 ../tests/rvv_conv_f32/rvv_conv_f32.elf

* ``--smp=n``: `xlmodel` currently supports up to 16 CPUs. If this parameter is not set, then uses 1 CPU. Running the 4-core SMP example is as follows::

    ./xl_cpumodel --cpu=nx900 --smp=4 ../tests/smphello_4core/smphello_nx900.elf

* ``--mem=start_addr0:size0,start_addr1:size1...``: when you compile the test code using custom sections, you need to pass the memory map of the SoC, i.e., the starting address and sizes of each section, as parameters to the `xlmodel`. Example::

    ./xl_cpumodel --cpu=nx900 --mem="0x70000000:0x90000000,0x20000000:0x10000000" ../tests/demoeclic_swirq_high/demo_eclic_swirq_high.elf

* ``--bpu=xxx``: The `xlmodel` can select different **BPU strategies** based on Nuclei core types, which will affect the cycle count of branch and jump instructions. `xlmodel` currently supports the ``--bpu=n300`` and ``--bpu=n900`` parameters.

    * The ``--bpu=n300`` parameter is applicable to Nuclei cores up to and including N300 (<= N300)::

        ./xl_cpumodel --cpu=n300fd --ext=_zba_zbb_zbc_zbs_xxldspn1x --bpu=n300 ../tests/demodsp/demo_dsp_n300fd.elf

    * The ``--bpu=n900`` parameter is applicable to Nuclei cores from N300 onwards (> N300)::

        ./xl_cpumodel --cpu=nx900 --bpu=n900 ../tests/demotimer/demotimer_nx900.elf

*  ``--trace=1``: `xlmodel` currently supports outputting instruction trace streams during execution, The :file:`<elf-name>.rvtrace` file will be generated in the path specified by the ``--logdir=<path>`` parameter. If ``--logdir=<path>`` is not configured, it will be generated in the current execution path. Example::

    ./xl_cpumodel --cpu=nx900 --trace=1 ../tests/demoeclic_swirq_low/demo_eclic_swirq_low.elf                       // rvtrace file in current execution path
    ./xl_cpumodel --cpu=nx900 --trace=1 --logdir=../log ../tests/demoeclic_swirq_low/demo_eclic_swirq_low.elf       // rvtrace file in User-defined path

You can obtain information such as the instruction count, cycle count, the associated hart, pc, opcode, disassembly code for each instruction in generated :file:`<elf-name>.rvtrace` file.

*  ``--gprof=1``: This parameter is used to enable the built-in **gprof** functionality of `xlmodel`. The :file:`gprof<n>.gmon` and :file:`gprof<n>.log` files will be generated in the path specified by the ``--logdir=<path>`` parameter. If ``--logdir=<path>`` is not configured, it will be generated in the current execution path. Example::

    ./xl_cpumodel --cpu=nx900 --gprof=1 ../tests/whet/whet_nx900.elf                        // gprof files in current execution path
    ./xl_cpumodel --cpu=nx900 --gprof=1 --logdir=../log ../tests/whet/whet_nx900.elf        // gprof files in User-defined path

You can obtain the :file:`gprof<n>.gmon` and :file:`gprof<n>.log` files when the simulation is complete, where n represents the hart ID.

To use them further, you need to import them into the IDE, then you can refer to the model usage guide in the Nuclei Studio for detailed instructions on using **gprof**.

* ``--timeout=<n>``: You can pass this parameter to set the real execution duration for `xlmodel`. When the timeout period is reached or when `xlmodel` finishes running the test code, the :file:`gprof<n>.gmon` and :file:`gprof<n>.log` files will be generated if the ``--gprof=1`` parameter is enabled. An example of specifying a 20-second simulation is as follows::

    ./xl_cpumodel --cpu=nx900 --timeout=20 --gprof=1 ../tests/cmk/cmk_nx900.elf

* ``--log=xxx``: The `xlmodel` has multiple log levels, listed from least to most detailed as `error`, `info`, `debug`, `tlm`. By default, it provides basic log information at the `info` level, which can be changed by passing ``--log=xxx``.

    When ``--log=error`` is selected, it only outputs error messages generated during the xlmodel runtime::

        ./xl_cpumodel --cpu=nx900 --log=error ../tests/demotimer/demotimer_nx900.elf

    When ``--log=debug`` is selected, the following options provide additional detailed information:

        * ``--trace=1``: The :file:`<elf-name>.rvtrace` file will contain detailed trace information, including register updates, exceptions, and CSRs::

            ./xl_cpumodel --cpu=nx900 --log=debug --trace=1 ../tests/demotimer/demotimer_nx900.elf

        * ``--gprof=1``: It will output pc jump information for jump instructions, exceptions, and interrupts to the terminal::

            ./xl_cpumodel --cpu=nx900 --log=debug --gprof=1 ../tests/demotimer/demotimer_nx900.elf

    When ``--log=tlm`` is selected, it includes all the features of ``--log=debug`` and additionally outputs TLM bus read and write information to the terminal::

        ./xl_cpumodel --cpu=nx900 --log=tlm ../tests/demotimer/demotimer_nx900.elf

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
    # Configure the cluster num based on the SoC system using -DCLUSTER_NUM=xxx
    # The following is the configuration with cluster number 1, which is the default.
    cmake -DCMAKE_BUILD_TYPE=Release -DCLUSTER_NUM=1 ..
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
    # Configure the cluster num based on the SoC system using -DCLUSTER_NUM=xxx
    # The following is the configuration with cluster number 1, which is the default.
    cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Rlease -DCLUSTER_NUM=1 ..
    make -j$(nproc)


NICE example
------------

If you are unfamiliar with how to implement the NICE instruction, refer to the implementation in `xlmodel_nice/nice/nice.cc` for custom **Nuclei NICE/VNICE** instructions.

The test example for Nuclei NICE instruction features are located in `tests/demonice`::

    ./xl_cpumodel --cpu=nx900 ../tests/demonice/demonice_nx900.elf

The test example for Nuclei VNICE instruction features are located in `tests/demovnice`::

    ./xl_cpumodel --cpu=nx900fd --ext=v ../tests/demovnice/demovnice_nx900fd.elf
