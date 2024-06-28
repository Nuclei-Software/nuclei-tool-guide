.. _openocd_intro:

About OpenOCD
=============

Repository and Doc
------------------

**openocd**

- github riscv-openocd: https://github.com/riscv-mcu/riscv-openocd/tree/nuclei/2024.06

- gitee riscv-openocd: https://gitee.com/riscv-mcu/riscv-openocd/tree/nuclei/2024.06

**openflashloader**

.. note::

   OpenOCD Flashloader is developed to support various different customized flash programming
   without modify openocd and rebuilt it, please check the source code repo's doc.

- github openflashloader: https://github.com/riscv-mcu/openflashloader

- gitee openflashloader: https://gitee.com/riscv-mcu/openflashloader

**openocd doc path**: ``openocd/doc/pdf/openocd.pdf``

How to Use
==========

How to determine the version of OpenOCD
---------------------------------------

* start a cmd(Windows)/terminal(Linux)
* run the *openocd -v* command

.. image:: /asserts/images/openocd-v.png
    :width: 900px

.. note::

    git commit id: 787e48e66

    compile date: (2022-12-29-08:49)

Start OpenOCD
-------------

.. rubric:: Frequently used command line parameters

+------------+-------------------------------------------+
| parameter  | description                               |
+============+===========================================+
| -v         | display version info                      |
+------------+-------------------------------------------+
| -d         | set debug level to 3                      |
+------------+-------------------------------------------+
| -d0        | error messages only                       |
+------------+-------------------------------------------+
| -d1        | error warning                             |
+------------+-------------------------------------------+
| -d2        | error warning info (default)              |
+------------+-------------------------------------------+
| -d3        | error warning info debug                  |
+------------+-------------------------------------------+
| -d4        | error warning info debug  low-level-debug |
+------------+-------------------------------------------+
| -f file    | use configuration file                    |
+------------+-------------------------------------------+
| -s dir     | dir to search for config files            |
+------------+-------------------------------------------+
| -l logfile | redirect log output to logfile            |
+------------+-------------------------------------------+

Nuclei Customized Features
==========================

.. rubric:: Display CPU information

Usually we don't know what instruction sets a CPU supports, what functional components it contains, and the various
configurations of the components. The only way to get the desired information is to read the corresponding CSR
registers and then do the math. It would be a pain in the ass to do this for every function point that needs to be known.

This command is designed to solve this problem by automatically reading the CSRs and doing the cpu feature probing, and then formatting the output.

``nuclei cpuinfo``

.. rubric:: Nuspi(nucle spi) driver

Nuclei's SPI controller, used in Nuclei RISC-V fpga evaluation board and other boards.

``flash bank name nuspi base size chip_width bus_width target spi_base [simulation]``

.. rubric:: Custom driver and open-flashloader

Custom exists for compatibility with any SPI controller and any Flash. It also needs to be used in conjunction with
openflashloader to achieve the desired results.

``flash bank name custom base size chip_width bus_width target spi_base flashloader_path [simulation] [sectorsize=]``

.. rubric:: Nuclei Customized CSRs

Nuclei released openocd supports a number of nuclei customized CSRs, please check here https://github.com/riscv-mcu/riscv-openocd/blob/nuclei/2024.06/src/target/riscv/encoding.h#L3109-L3223

.. rubric:: Nuclei embedded trace

.. note::

    Still in experiment stage, not for production usage.

Some Nuclei cpus are equipped with trace support, which permits examination of the instruction activity. Trace
activity is controlled through an Embedded Trace(Etrace) Module on the core's scan chains. The following
commands are for etrace.

``nuclei etrace config etrace-addr buffer-addr buffer-size wrap``

This command is used to initialize Etrace and configure related parameters.

``nuclei etrace enable``

This command triggers the Etrace enable signal by setting the Core internal trigger.

``nuclei etrace disable``

This command triggers the Etrace disable signal by setting the Core internal trigger.

``nuclei etrace start``

This command is used to enable Etrace data collection.

``nuclei etrace stop``

This command is used to disable Etrace data collection.

``nuclei etrace dump filename``

This command is used to dump the data captured by Etrace.

``nuclei etrace clear``

This command is used to clear the read and write pointers for Etrace.

``nuclei etrace info``

This command displays the current Etrace status.

.. rubric:: Init resethalt command

In practice, usually encountered due to software problems caused by the CPU stuck, then the debugger will not
be connected to the development board, only to the development board power off. If your code is running in
flash, powering down the board will not solve the problem. resethalt is designed to solve this problem.

``init resethalt``

.. rubric:: Ftdi nscan1_mode command

Enable or disable Nuclei CJTAG mode. Usage is the same as ftdi oscan1_mode.

``ftdi nscan1_mode on|off``

About the configuration file
============================

The openocd configuration file is used to configure how to connect to the development board's window
through the Debug interface. nuclei provides an example of the openocd configuration file, which can
be modified based on the example.

Here we take example using Nuclei HBird Debugger(FTDI based) as to explain this openocd configuration file.

Here is an working example for openocd configuration file https://github.com/Nuclei-Software/nuclei-sdk/blob/master/SoC/evalsoc/Board/nuclei_fpga_eval/openocd_evalsoc.cfg

.. rubric:: Modify debugger rate

``adapter_khz 1000`` or ``adapter speed 1000``

.. rubric:: Select debugger interface

.. code-block:: c

    adapter driver ftdi
    ftdi vid_pid 0x0403 0x6010

    transport select jtag

    ftdi layout_init 0x0008 0x001b
    ftdi layout_signal nSRST -oe 0x0020 -data 0x0020
    ftdi layout_signal TCK -data 0x0001
    ftdi layout_signal TDI -data 0x0002
    ftdi layout_signal TDO -input 0x0004
    ftdi layout_signal TMS -data 0x0008
    ftdi layout_signal JTAG_SEL -data 0x0100 -oe 0x0100

The above code are used to select fdti debugger, the ftdi chip pid/vid must match selected id,
transport is selected as JTAG, and ftdi layout is setup to match HBird Debugger hardware settings.

.. rubric:: Modify debugger mode

There are two debugging modes JTAG and cJTAG.

* JTAG <-> ``ftdi nscan1_mode off``

* cJTAG <-> ``ftdi nscan1_mode on``

.. rubric:: Describe the JTAG link

* single core

.. code-block:: c

    set _CHIPNAME0 riscv0
    jtag newtap $_CHIPNAME0 cpu -irlen 5 -expected-id 0x10900a6d

    set _TARGETNAME0 $_CHIPNAME0.cpu
    target create $_TARGETNAME0 riscv -chain-position $_TARGETNAME0 -coreid 0

* smp system

.. code-block:: c

    set _CHIPNAME0 riscv0
    jtag newtap $_CHIPNAME0 cpu -irlen 5 -expected-id 0x10900a6d

    set _TARGETNAME0 $_CHIPNAME0.cpu
    target create $_TARGETNAME0.0 riscv -chain-position $_TARGETNAME0 -coreid 0 -rtos hwthread
    target create $_TARGETNAME0.1 riscv -chain-position $_TARGETNAME0 -coreid 1
    target create $_TARGETNAME0.2 riscv -chain-position $_TARGETNAME0 -coreid 2
    target smp $_TARGETNAME0.0 $_TARGETNAME0.1 $_TARGETNAME0.2

* amp system

.. code-block:: c

    set _CHIPNAME0 riscv0
    jtag newtap $_CHIPNAME0 cpu -irlen 5 -expected-id 0x10900a6d

    set _CHIPNAME1 riscv1
    jtag newtap $_CHIPNAME1 cpu -irlen 5 -expected-id 0x10300a6d

    set _TARGETNAME0 $_CHIPNAME0.cpu
    target create $_TARGETNAME0 riscv -chain-position $_TARGETNAME0 -coreid 0

    set _TARGETNAME1 $_CHIPNAME1.cpu
    target create $_TARGETNAME1.0 riscv -chain-position $_TARGETNAME0 -coreid 0 -rtos hwthread
    target create $_TARGETNAME1.1 riscv -chain-position $_TARGETNAME0 -coreid 1
    target smp $_TARGETNAME1.0 $_TARGETNAME1.1

.. note::

    * ``-rtos hwthread``

    OpenOCD includes a pseudo RTOS called hwthread that presents CPU cores ("hardware
    threads") in an SMP system as threads to GDB. With this extension, GDB can be used to
    inspect the state of an SMP system in a natural way. After halting the system, using the
    GDB command info threads will list the context of each active CPU core in the system.
    GDB's thread command can be used to switch the view to a different CPU core. The step
    and stepi commands can be used to step a specific core while other cores are free-running
    or remain halted, depending on the scheduler-locking mode configured in GDB.

.. rubric:: Describe the workarea

workarea is mainly used to speed up certain operations, such as reading and writing large
chunks of memory, running small program fragments, reading and writing flash, and so on.

.. code-block:: c

    $_TARGETNAME0 configure -work-area-phys 0x08000000 -work-area-size 0x10000 -work-area-backup 1

.. note::

    The workarea should be a readable, writable, and executable area of memory.

    ``0x08000000`` workarea base address, modified according to the actual situation.

    ``0x10000`` workarea size of byte, modified according to the actual situation.

.. rubric:: Describe the nor flash

.. code-block:: c

    set _FLASHNAME0 $_CHIPNAME0.flash
    flash bank $_FLASHNAME0 nuspi 0x20000000 0 0 0 $_TARGETNAME0.0 0x10180000

.. note::

    ``nuspi`` openocd flash drivers type, modified according to the actual situation.

    ``0x20000000`` qspi-xip address, modified according to the actual situation.

    ``0x10180000`` qspi controller base address, modified according to the actual situation.

.. rubric:: Connect to the specified debugger

When there is more than one debugger in a debugging environment, we need to connect to
specify the debugger, in this case you can use the following command to specify.

.. code-block:: c

    ftdi_serial FT4YR31I

.. rubric:: How to set up gdb/telnet/tcl ports

openocd provides three kinds of debugging service ports are gdb/telnet/tcl, choose
the appropriate service according to the situation, and set the port number of the
corresponding service by the following command.

.. code-block:: c

    gdb_port 3333
    telnet_port 4444
    tcl_port 6666

.. note::

    The above shows the default port number, you are free to change the port number
    if it is free. Of course we can also disable the port numbers we don't need, it's
    easy just change the port number to `disable`.

.. rubric:: semihosting

OpenOCD also supports the ARM semihosting feature, use the following command to enable it.

.. code-block:: c

    arm semihosting enable


For more detailed information about how to use openocd, please check the ``openocd.pdf`` distributed in openocd release.


Frequently asked questions
==========================

There are a few more FAQs please see: https://github.com/riscv-mcu/riscv-openocd/wiki


Low-cost debugger solution
==========================

We also provided a low cost mcu solution to debug RISC-V CPU, which support JTAG and cJTAG, please check the following
repo to learn more about it.

Nuclei Dlink: https://github.com/Nuclei-Software/nuclei-dlink
