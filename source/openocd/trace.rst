.. _openocd_capture_trace_data:

OpenOCD Capture Trace Data
==========================

This document guides users on how to use the OpenOCD tool to capture Trace data via command line.

Table of Contents
-----------------

- `Tool Installation and Environment Setup`_
- `Etrace Command Reference`_
- `Trace Command Reference`_

Tool Installation and Environment Setup
---------------------------------------

Download and install the latest version of the OpenOCD tool from the Nuclei official website: https://nucleisys.com/download.php

After downloading and extracting to the installation directory, add the following directory to the PATH environment variable:

- ``Nuclei\OpenOCD\xxx\bin``

ETrace Version Overview
-----------------------

Nuclei processors support different versions of ETrace functionality. The command group you should use depends on the ETrace version implemented in your Core:

- **ETrace-v1.x**: Uses the ATB2AXI component as the SoC system bridge. This version supports instruction Trace capture only. If your Core implements etrace-v1.x, see :ref:`etrace_command_reference`.
- **ETrace-v2.x**: Uses the TraceBundle component as the SoC system bridge. This version supports both instruction Trace and data Trace capture. If your Core implements etrace-v2.x, see :ref:`trace_command_reference`.

To determine which ETrace version your Core supports, check the processor documentation or the Trace module configuration in your SoC.

.. _etrace_command_reference:

Etrace Command Reference
------------------------

This command group is for Cores with etrace-v1.x version Trace functionality, where the SoC system component is ATB2AXI. It is used for instruction Trace capture on such systems.

.. note::
    The commands in this section are OpenOCD commands executed in the OpenOCD Tcl shell.
    If you are accessing these commands from GDB, please add the ``monitor`` prefix,
    for example: ``monitor nuclei etrace config <atb2axi-addr> <buffer-addr> <buffer-size> <wrap>``

etrace config
~~~~~~~~~~~~~

Configure the ETrace system.

**Syntax:**

``etrace config <atb2axi-addr> <buffer-addr> <buffer-size> <wrap>``

**Parameters:**

+--------------+-----------------------------------------------------+---------------------------------+
| Parameter    | Description                                         | Range/Values                    |
+==============+=====================================================+=================================+
| atb2axi-addr | Base address of the ATB2AXI configuration registers | Physical address                |
+--------------+-----------------------------------------------------+---------------------------------+
| buffer-addr  | Start address of the trace buffer                   | Physical address                |
+--------------+-----------------------------------------------------+---------------------------------+
| buffer-size  | Size of the trace buffer                            | In bytes, e.g., 0x10000         |
+--------------+-----------------------------------------------------+---------------------------------+
| wrap         | Buffer mode                                         | 0 = compact mode, 1 = wrap mode |
+--------------+-----------------------------------------------------+---------------------------------+

**Buffer Modes:**

- **Wrap mode (wrap=1)**: When the buffer is full, new trace data wraps around to overwrite old data
- **Compact mode (wrap=0)**: Trace data is compacted to save space, and stops when the buffer is full

**Notes:**

- ETrace must be stopped before reconfiguration
- If ETrace is running, an error will be reported

etrace enable
~~~~~~~~~~~~~

Enable ETrace for the current target Core.

**Syntax:**

``etrace enable``

**Notes:**

- Uses hardware trigger to set trace-on action at the current PC address
- An error will be reported if no hardware trigger is available

etrace disable
~~~~~~~~~~~~~~

Disable ETrace for the current target Core.

**Syntax:**

``etrace disable``

**Notes:**

- Uses hardware trigger to set trace-off action at the current PC address
- An error will be reported if no hardware trigger is available

etrace start
~~~~~~~~~~~~

Configure ATB2AXI to start capturing Trace data.

**Syntax:**

``etrace start``

etrace stop
~~~~~~~~~~~

Configure ATB2AXI to stop capturing Trace data.

**Syntax:**

``etrace stop``

etrace dump
~~~~~~~~~~~

Read the ATB2AXI register status and save the captured Trace data to the specified file.

**Syntax:**

``etrace dump <filename>``

**Notes:**

- Filename must be a valid path to a writable file
- If the file already exists, it will be overwritten
- If the file is not writable, an error will be reported

etrace clear
~~~~~~~~~~~~

Stop capturing Trace data and clear the ATB2AXI register status.

**Syntax:**

``etrace clear``

etrace info
~~~~~~~~~~~

Display configuration information and show the current data capture status.

**Syntax:**

``etrace info``

Preparation
~~~~~~~~~~~

Connect to the development board using OpenOCD + GDB to enter debug mode, load the ELF file to be debugged into the development board, and run the program to the position where Trace data capture needs to start. The following commands are all executed in GDB.

.. code-block::

    PS D:\Git\nuclei-sdk> make CORE=n900 run_openocd
    make -C application/baremetal/helloworld run_openocd
    make[1]: Entering directory 'D:/Git/nuclei-sdk/application/baremetal/helloworld'
    "Start openocd server"
    openocd -c "set BOOT_HARTID 0;; gdb_port 3333"  -f ../../../SoC/evalsoc/Board/nuclei_fpga_eval/openocd_evalsoc.cfg
    Open On-Chip Debugger 0.12.0+dev-03629-g3a2163834-dirty (2026-05-21-00:06)
    Licensed under GNU GPL v2
    For bug reports, read
            http://openocd.org/doc/doxygen/bugs.html
    DEPRECATED! use 'gdb port', not 'gdb_port'
    boot hart id expected to be 0
    Set default SMP CPU count to default 1
    Info : libusb_open() failed with LIBUSB_ERROR_NOT_FOUND
    Info : no device found, trying D2xx driver
    Info : D2xx device count: 2
    Info : Connecting to "FTDI JTAG" using D2xx mode...
    Info : clock speed 1000 kHz
    Info : JTAG tap: riscv.cpu tap/device found: 0x10600a6d (mfg: 0x536 (Nuclei System Technology Co Ltd), part: 0x0600, ver: 0x1)
    Info : coreid=0, nuclei debug map reg 00: 0x200001ec, 16: 0x0, 32: 0x20000900
    Info : [riscv.cpu] datacount=4 progbufsize=8
    Info : [riscv.cpu] Nuclei CPU Detected: mhartid-0x0 marchid-0x0600 v4.6.0, ISA: RV32ABCDFIMPU, Feature: ECLIC, PPI, NICE, CMO, ILM-256K, DLM-256K, IC-32K, DC-32K
    Info : [riscv.cpu] Examined RISC-V core
    Info : [riscv.cpu]  XLEN=32, misa=0x4010912f
    [riscv.cpu] Target successfully examined.
    Info : [riscv.cpu] Examination succeed
    Info : [riscv.cpu] starting gdb server on 3333
    Info : Listening on port 3333 for gdb connections
    riscv.cpu halted due to debug-request.
    Info : Valid NUSPI on device Nuclei SoC SPI Flash at address 0x20000000 with spictrl regbase at 0x10014000
    Info : Nuclei SPI controller version 0xee010102
    Info : Found flash device 'win w25q256fv/jv' (ID 0x001940ef)
    semihosting is enabled
    Info : Listening on port 6666 for tcl connections
    Info : Listening on port 4444 for telnet connections

.. code-block::

    PS D:\Git\nuclei-sdk\application\baremetal\demo_eclic> make CORE=n900 run_gdb
    "Run gdb to connect openocd server and debug"
    riscv64-unknown-elf-gdb demo_eclic.elf  -ex "set remotetimeout 240" -ex "target extended-remote localhost:3333"
    GNU gdb (GDB) 16.2.90.20250210-git
    Copyright (C) 2024 Free Software Foundation, Inc.
    License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
    This is free software: you are free to change and redistribute it.
    There is NO WARRANTY, to the extent permitted by law.
    Type "show copying" and "show warranty" for details.
    This GDB was configured as "--host=x86_64-w64-mingw32 --target=riscv64-unknown-elf".
    Type "show configuration" for configuration details.
    For bug reporting instructions, please see:
    <https://www.gnu.org/software/gdb/bugs/>.
    Find the GDB manual and other documentation resources online at:
        <http://www.gnu.org/software/gdb/documentation/>.

    For help, type "help".
    Type "apropos word" to search for commands related to "word"...
    Reading symbols from demo_eclic.elf...
    Remote debugging using localhost:3333
    0x200001f0 in ?? ()
    (gdb) load
    Loading section .init, size 0x248 lma 0x80000000
    Loading section .text, size 0x2db8 lma 0x80000280
    Loading section .data, size 0x628 lma 0x90000000
    Start address 0x80000100, start size 13864
    Transfer rate: 76 KB/sec, 4621 bytes/write.
    (gdb) b main
    Breakpoint 1 at 0x80001aae: file demo_eclic.c, line 93.
    (gdb) c
    Continuing.

    Breakpoint 1, main (argc=0, argv=0x0) at demo_eclic.c:93
    93          mcfg_info.d = __RV_CSR_READ(CSR_MCFG_INFO);
    (gdb) b demo_eclic.c:142
    Breakpoint 2 at 0x80001b72: file demo_eclic.c, line 142.
    (gdb)

Usage Example
~~~~~~~~~~~~~

.. code-block:: tcl

    # Configure ETrace with 64KB buffer in wrap mode
    monitor nuclei etrace config 0x10020000 0x90000000 0x10000 1

    # Enable ETrace
    monitor nuclei etrace enable

    # Start tracing
    monitor nuclei etrace start

    # Run your application
    continue

    # Press Ctrl+C or stop at breakpoint

    # Disable ETrace
    monitor nuclei etrace disable

    # Stop tracing
    monitor nuclei etrace stop

    # View trace info (optional)
    monitor nuclei etrace info

    # Dump trace data
    monitor nuclei etrace dump /tmp/trace.bin

    # Clear trace status (optional)
    monitor nuclei etrace clear

Common Problem Troubleshooting and Solutions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- When wrap=0, ATB2AXI's compact mode is enabled, and tdasize is fixed at 8 bits. TraceDecoder needs to specify tdasize as 8 bits during decoding.
- In heterogeneous multi-core systems (AMP) where Trace data is captured simultaneously, you need to use ``monitor nuclei etrace enable/disable`` in respective GDB terminals to enable and disable ETrace separately. Other commands can be executed in any GDB terminal corresponding to any Core.
- In homogeneous multi-core systems (SMP) where Trace data is captured simultaneously, you need to use the ``thread`` command in the GDB terminal to switch to the specified Core, and then use ``monitor nuclei etrace enable/disable`` to enable and disable ETrace separately. Other commands can be executed in any thread.

.. _trace_command_reference:

Trace Command Reference
-----------------------

This command group is for Cores with etrace-v2.x version Trace functionality, where the SoC system component is TraceBundle. It is used for instruction Trace or data Trace capture on such systems.

.. note::
    The commands in this section are OpenOCD commands executed in the OpenOCD Tcl shell.
    If you are accessing these commands from GDB, please add the ``monitor`` prefix,
    for example: ``monitor nuclei trace config <tracebundle-addr> <buffer-addr> <buffer-size> <wrap> <core-mask> <timestamp> <datatrace>``

trace config
~~~~~~~~~~~~

Configure the trace system before starting trace collection.

**Syntax:**

``trace config <tracebundle-addr> <buffer-addr> <buffer-size> <wrap> <core-mask> <timestamp> <datatrace>``

**Parameters:**

+------------------+--------------------------------------------+--------------------------------------------+
| Parameter        | Description                                | Range/Values                               |
+==================+============================================+============================================+
| tracebundle-addr | Base address of the trace bundle registers | Physical address                           |
+------------------+--------------------------------------------+--------------------------------------------+
| buffer-addr      | Start address of the trace buffer in RAM   | Physical address                           |
+------------------+--------------------------------------------+--------------------------------------------+
| buffer-size      | Size of the trace buffer in bytes          | Power of 2, e.g., 0x10000 (64KB)           |
+------------------+--------------------------------------------+--------------------------------------------+
| wrap             | Wrap mode enable                           | 0 = stop on full, 1 = wrap around          |
+------------------+--------------------------------------------+--------------------------------------------+
| core-mask        | Bitmask of cores to trace                  | Bit i = core i (e.g., 0x3 = cores 0 and 1) |
+------------------+--------------------------------------------+--------------------------------------------+
| timestamp        | Timestamp configuration                    | See Timestamp Configuration section below  |
+------------------+--------------------------------------------+--------------------------------------------+
| datatrace        | Data trace configuration                   | See Data Trace Configuration section below |
+------------------+--------------------------------------------+--------------------------------------------+

**Timestamp Configuration:**

The ``timestamp`` parameter is an 8-bit value:

- Bits [7:4]: ``timestamp-div`` - Divider for timestamp counter
- Bits [3:0]: ``timestamp-src`` - Timestamp source

  - 0: No timestamp
  - 1: CPU timestamp, support divider (from each core)
  - 2: Funnel timestamp, support divider (shared)
  - 3: External timestamp

**Data Trace Configuration:**

The ``datatrace`` parameter is a 5-bit value:

- Bit [4]: ``has-store`` - Enable store tracing, when datatrace-en is 1
- Bit [3]: ``has-load`` - Enable load tracing, when datatrace-en is 1
- Bit [2]: ``has-value`` - Include data value in trace, when datatrace-en is 1
- Bit [1]: ``has-addr`` - Include data address in trace, when datatrace-en is 1
- Bit [0]: ``datatrace-en`` - Enable data tracing

**Notes:**

- The trace system must be configured before starting trace collection
- Buffer size should be aligned to power of 2
- When wrap mode is disabled (wrap=0), tracing stops when buffer is full
- When multiple cores are enabled (core-mask has multiple bits), srcid is automatically configured

trace start
~~~~~~~~~~~

Start trace collection.

**Syntax:**

``trace start``

trace stop
~~~~~~~~~~

Stop trace collection.

**Syntax:**

``trace stop``

trace dump
~~~~~~~~~~

Dump trace data to a file.

**Syntax:**

``trace dump <filename>``

trace info
~~~~~~~~~~

Show trace configuration and status.

**Syntax:**

``trace info``

Preparation
~~~~~~~~~~~

Connect to the development board using OpenOCD + GDB to enter debug mode, load the ELF file to be debugged into the development board, and run the program to the position where Trace data capture needs to start. The following commands are all executed in GDB.

Usage Example
~~~~~~~~~~~~~

.. code-block:: tcl

    # Configure TraceBundle with 64KB buffer in wrap mode, trace core0, enable CPU timestamp (no divider), disable data trace
    monitor nuclei trace config 0x10060000 0x90000000 0x10000 1 1 1 0

    # Start tracing
    monitor nuclei trace start

    # Run your application
    continue

    # Press Ctrl+C or stop at breakpoint

    # Stop tracing
    monitor nuclei trace stop

    # View trace info (optional)
    monitor nuclei trace info

    # Dump trace data
    monitor nuclei trace dump /tmp/trace.bin

Common Problem Troubleshooting and Solutions
--------------------------------------------

- Trace capture is triggered by configuring TraceBundle registers, so hardware trigger resources are no longer occupied
- In multi-core systems where Trace is captured simultaneously, you need to specify the core-mask parameter in trace config. For example, core-mask=0x3 means capturing Trace data from Core 0 and Core 1. Whether it is Core 0 or Core 1 is distinguished by the TraceBundle module interface signals.
