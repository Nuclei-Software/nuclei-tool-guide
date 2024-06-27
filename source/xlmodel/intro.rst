.. _xlmodel_intro:

About Nuclei Near Cycle Model
=============================

The ``Nuclei Near Cycle Model`` (referred to as `xlmodel`) is a co-simulation using **SystemC TLM-2 combined with xlspike**. Xlspike uses spike as the RISC-V ISA simulator and adds support for Nuclei's N/NX/UX RISC-V processors.
SystemC establishes the TLM 2.0 interaction relationships among the components under **Nuclei EvalSoC**.

- The `xlmodel` can be obtained in **Nuclei Studio 2024.06**.
- The `xlmodel` is only supported on Linux system.
- The `xlmodel` is a **near cycle model** that can test the performance of firmware with different ISA configurations.
- The `xlmodel` has SystemC built-in and uses version 2.3.4 by default.
- The `xlmodel` has built-in **gprof** functionality, allowing for a more intuitive display of the function call stack, the cycle count proportion of each function within the test code.
- The `xlmodel` can easily extend **user-defined** instructions, namely **Nuclei NICE instructions**.
- Xlspike supports RV32IMAFDCBPV and RV64IMAFDCBPV ISA.

SystemC components
==================

Brief description of the `xlmodel` SystemC components:

* Top: Top-level entity that builds & starts the SystemC simulation
* Cluster: Cluster contains multiple cores and can be used to start xlspike for co-simulation
* Bus: Simple bus manager
* Memory: Memory comprises both instruction memory and data memory, as well as the loading of ELF sections
* Timer: Nuclei timer unit
* EvalUart: Nuclei EvalSoC uart
* EvalQspi: Nuclei EvalSoC qspi

How to run
==========

model help
----------

.. rubric:: Frequently used command line parameters

+--------------------+-------------------------------------------------------------------------------------------------+
| parameter          | description                                                                                     |
+====================+=================================================================================================+
| ``--version``      | display version info                                                                            |
+--------------------+-------------------------------------------------------------------------------------------------+
| ``--time=<n>``     | set simulation time(us); otherwise, it is unlimited                                             |
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
| ``--log=<str>``    | logging system level, defaults to ``--log=info`` and can be set to ``error``, ``tlm``, ``debug``|
+--------------------+-------------------------------------------------------------------------------------------------+
| ``--logdir=<str>`` | the directory to save trace and gprof files                                                     |
+--------------------+-------------------------------------------------------------------------------------------------+

You need to pass the different parameters above based on the results you want to obtain and the specific test code. In most cases, you only need to pass the path of the ELF file.

normal test case
----------------

When you want to use the model, you can select the `bin/xl_cpumodel` as the executable file.

The default test codes ELF files are provided in the `tests` directory, this is an example of demo timer test code below::

    ./xl_cpumodel ../tests/demotimer/demotimer_nx900.elf

.. image:: /asserts/images/xlmodel/demotimer.png

The `xlmodel` can select different **BPU strategies** based on Nuclei core types, which will affect the cycle count of branch and jump instructions.

You can pass the parameter `--bpu=n300`, which is applicable to Nuclei cores up to and including N300 (<= N300). You can also pass the parameter `--bpu=n900`, which is applicable to Nuclei cores from N300 onwards (> N300)::

    ./xl_cpumodel ../tests/demotimer/demotimer_nx900.elf --bpu=n300

.. image:: /asserts/images/xlmodel/bpu.png

When testing an SMP system case, you need to pass the parameter `--smp=n`, specifying the number of cores, to the command line::

    ./xl_cpumodel ../tests/smphello_nx900/smphello_nx900.elf --smp=4

.. image:: /asserts/images/xlmodel/smphello.png

If you need to test Vector extension case and specify vlen or elen, you need to pass the parameter `--varch=vlen:n,elen:n`. Note that vlen and elen must comply with the RISC-V Vector specifications::

    ./xl_cpumodel ../tests/rvv_conv_f32/rvv_conv_f32.elf --varch=vlen:1024,elen:64

.. image:: /asserts/images/xlmodel/rvv_conv_f32.png

test case with trace
--------------------

When you want to see the complete trace of the firmware elf, you need to pass the parameter `--trace=1` in the command line::

    ./xl_cpumodel ../tests/rvv_conv_f32/rvv_conv_f32.elf --varch=vlen:1024,elen:64 --trace=1

You can obtain information such as the pc, opcode, disassembly, and others for each instruction in generated `<elf-name>.rvtrace` file:

.. image:: /asserts/images/xlmodel/trace.png

test case with log
------------------

The `xlmodel` has multiple log levels, listed from least to most detailed as `error`, `info`, `tlm`, `debug`. By default, it provides log information at the `info` level, which can be changed by passing `--log=xxx`.

When `--log=tlm` is selected, logs related to all TLM memory reads and writes can be printed:

.. image:: /asserts/images/xlmodel/logtlm.png

When `--log=debug` is selected, TLM information and more detailed instruction trace information, including register updates, exceptions, and CSRs, will be printed:

.. image:: /asserts/images/xlmodel/logdebug.png

test case with gprof
--------------------

If you want to use the model's built-in **gprof** functionality, you need to pass `--gprof=1` to the command line::

    ./xl_cpumodel ../tests/whet/whet_nx900.elf --gprof=1

.. image:: /asserts/images/xlmodel/gprof.png

You can obtain the `gprof<n>.gmon` and `gprof<n>.log` files when the simulation is complete, where n represents the hart ID:

.. image:: /asserts/images/xlmodel/gmonglog.png

To use them further, you need to import them into the IDE, then you can refer to the model usage guide in the **Nuclei Studio** for detailed instructions on using **gprof**.

NICE support
============

The current **NICE** example in `tests/demonice` demonstrates how to use Nuclei **NICE** feature::

    ./xl_cpumodel ../tests/demonice/demonice_nx900.elf

.. image:: /asserts/images/xlmodel/nice.png

If you need to validate your custom **NICE** instructions, you need to contact Nuclei Support to obtain software package of model.

The directory structure of the package is as follows:

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
| tests              | test codes                                                     |
+--------------------+----------------------------------------------------------------+
| CMakeLists.txt     | CMake file required for compilation                            |
+--------------------+----------------------------------------------------------------+

