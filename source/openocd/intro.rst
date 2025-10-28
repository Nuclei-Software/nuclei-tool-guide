.. _openocd_intro:

Introduction to OpenOCD
=======================

Repositories and Documentation
------------------------------

**OpenOCD Repositories**

`GitHub (RISC-V OpenOCD) Repository <https://github.com/riscv-mcu/riscv-openocd>`_.

`Gitee  (RISC-V OpenOCD) Repository <https://gitee.com/riscv-mcu/riscv-openocd>`_.

**OpenFlashLoader**

.. note::

   The OpenOCD Flashloader enables support for various customized flash programming implementations
   without requiring modifications to OpenOCD itself. For detailed usage instructions,
   please refer to the documentation in the source code repository.

`GitHub (OpenFlashLoader) Repository <https://github.com/riscv-mcu/openflashloader>`_.

`Gitee  (OpenFlashLoader) Repository <https://gitee.com/riscv-mcu/openflashloader>`_.

**OpenOCD User Guide Location**: ``openocd/doc/pdf/openocd.pdf``

Getting Started
===============

Checking OpenOCD Version
------------------------

To determine the installed OpenOCD version:

1. Open a command prompt (Windows) or terminal (Linux)
2. Execute the command: ``openocd -v``

.. image:: /asserts/images/openocd-v.png
    :width: 900px

.. note::

   Current Version Information:
   - Git Commit ID: 787e48e66
   - Compile Date: 2022-12-29 08:49

Running OpenOCD
---------------

.. rubric:: Common Command Line Parameters

+------------+-------------------------------------------+
| Parameter  | Description                               |
+============+===========================================+
| -v         | Display version information               |
+------------+-------------------------------------------+
| -d         | Set debug level to 3                      |
+------------+-------------------------------------------+
| -d0        | Error messages only                       |
+------------+-------------------------------------------+
| -d1        | Error and warning messages                |
+------------+-------------------------------------------+
| -d2        | Error, warning, and info (default)        |
+------------+-------------------------------------------+
| -d3        | Error, warning, info, and debug messages  |
+------------+-------------------------------------------+
| -d4        | All messages including low-level debug    |
+------------+-------------------------------------------+
| -f file    | Use specified configuration file          |
+------------+-------------------------------------------+
| -s dir     | Directory to search for config files      |
+------------+-------------------------------------------+
| -l logfile | Redirect log output to specified file     |
+------------+-------------------------------------------+

Nuclei-Specific Features
========================

CPU Information Display
-----------------------

The ``nuclei cpuinfo`` command provides detailed information about the CPU's capabilities, including:

- Supported instruction sets
- Available functional components
- Component configurations

This command simplifies the process of querying CPU features by automatically reading and interpreting the relevant CSR (Control and Status Register) values, eliminating the need for manual register inspection and calculation.

This command implementation are updated with latest nuclei sdk 0.9.0 ``cpuinfo.c/h`` to provide same analysis using same source code from 2025.10 release.

NUSPI (Nuclei SPI) Driver
-------------------------

The NUSPI driver provides support for Nuclei's SPI controller, which is utilized in Nuclei RISC-V FPGA evaluation boards and other compatible hardware.

Usage:

``flash bank name nuspi base size chip_width bus_width target spi_base [simulation]``

Custom Driver with OpenFlashLoader
----------------------------------

The custom driver provides compatibility with various SPI controllers and flash memory types. When using this driver, it must be combined with the OpenFlashLoader to achieve optimal functionality.

Usage:

``flash bank name custom base size chip_width bus_width target spi_base flashloader_path [simulation] [sectorsize=]``

**flashloader_path** could be one the following:

.. note::

   This require **2025.10** version to provide correct path search handling.

- Abosulte path: eg. ``C:\\flashloader\\loader.bin`` or ``/home/loader/loader.bin``
- Relative path: eg. ``loader.bin``, it wil search under where openocd executed, and ``scripts`` folder of where openocd installed such as ``toolchain/openocd/scripts``

Nuclei-Specific CSRs
--------------------

The Nuclei version of OpenOCD supports several custom CSRs (Control and Status Registers). For a complete list and detailed information, refer to:

`GitHub (src/target/riscv/encoding.h) <https://github.com/riscv-mcu/riscv-openocd/blob/nuclei/2024/src/target/riscv/encoding.h#L3109>`_.

`Gitee  (src/target/riscv/encoding.h) <https://gitee.com/riscv-mcu/riscv-openocd/blob/nuclei/2024/src/target/riscv/encoding.h#L3109>`_.

Embedded Trace (ETrace) Support
-------------------------------

.. note::

   The ETrace feature is currently in the experimental stage and should not be used in production environments.

Some Nuclei CPUs include embedded trace support, enabling detailed examination of instruction execution. The trace functionality is managed through an Embedded Trace (ETrace) module integrated into the CPU's scan chains.

Current Implementation:
- RISC-V ETrace Instruction Trace (available)
- Data Trace (not yet implemented)

ETrace Commands:

1. Configuration:
   ``nuclei etrace config etrace-addr buffer-addr buffer-size wrap``
   - Initializes ETrace and configures operational parameters

2. Control:
   - ``nuclei etrace enable``: Activates ETrace functionality
   - ``nuclei etrace disable``: Deactivates ETrace functionality
   - ``nuclei etrace start``: Begins trace data collection
   - ``nuclei etrace stop``: Stops trace data collection

3. Data Management:
   - ``nuclei etrace dump filename``: Exports captured trace data to a file
   - ``nuclei etrace clear``: Resets trace buffer pointers
   - ``nuclei etrace info``: Displays current ETrace status

.. note::

   - For detailed command documentation, please refer to ``openocd.pdf``
   - The ETrace feature is also available in Nuclei Studio IDE. Refer to the :ref:`ide_etrace` for how to use.

Debug Map Feature
-----------------

.. note::

   The debug map for each hardware thread (hart) is automatically read and displayed during OpenOCD initialization.
   Alternatively, you can access the debug map at runtime using the ``examine_cpu_core`` command.

For detailed documentation about the Nuclei debug map feature, please contact your application engineer.

Commands:

- ``nuclei expose_cpu_core``
  - Configures the list of indices for ``nuclei_examine_cpu_core``
  - Must be executed before the ``init`` command

- ``nuclei examine_cpu_core``
  - Returns a 64-bit value combining ``dm-custom1`` and ``dm-custom2`` registers
  - Value calculation: ``(dm-custom2 << 32) + dm-custom1``

Cross-Trigger Interface
-----------------------

The Cross-Trigger Interface (CTI) provides an advanced debugging mechanism that enables developers to:

- Trigger specific debugging actions
- Synchronize multiple debugging-related events

Available Commands:

- ``nuclei cti halt_group on/off target_name0 target_name1 ...``
  - Controls halt group triggers

- ``nuclei cti resume_group on/off target_name0 target_name1 ...``
  - Controls resume group triggers

Debug with Hypervisor
---------------------

Need **2025.10** version to work with, only work with ``riscv virt2phys_mode sw``, see https://github.com/riscv-collab/riscv-openocd/issues/1278#issuecomment-3166660685

Reset and Halt Command
----------------------

The ``init resethalt`` command addresses situations where:

- The CPU becomes unresponsive due to software issues
- The debugger loses connection with the development board
- Power cycling is ineffective (particularly when code is running from flash)

This command provides a software-based solution to reset and halt the CPU without requiring physical power cycling.

FTDI nSCAN1 Mode Command
------------------------

The ``ftdi nscan1_mode`` command controls Nuclei's Compact JTAG (cJTAG) mode functionality.

Usage:
``ftdi nscan1_mode on|off``

.. note::

   This command follows the same syntax and behavior as the standard ``ftdi oscan1_mode`` command.

Configuration File Overview
===========================

The OpenOCD configuration file defines how to establish a connection with the development board through the debug interface. Nuclei provides a sample configuration file that can be adapted to specific hardware requirements.

Example Configuration:

- Using Nuclei HBird Debugger (FTDI-based)

`Reference implementation <https://github.com/Nuclei-Software/nuclei-sdk/blob/master/SoC/evalsoc/Board/nuclei_fpga_eval/openocd_evalsoc.cfg>`_.

Debugger Speed Configuration
----------------------------

To adjust the debugger communication speed:

- ``adapter_khz 1000``
- ``adapter speed 1000``

Both commands set the debugger speed to 1000 kHz.

Debugger Interface Configuration
--------------------------------

The following configuration selects and initializes the FTDI debugger interface:

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

Configuration Details:
- FTDI chip VID/PID must match the connected hardware
- JTAG transport protocol selected
- Signal layout configured for HBird Debugger compatibility

Debugger Mode Configuration
---------------------------

OpenOCD supports two debugging modes:

- **JTAG Mode**: Enabled with ``ftdi nscan1_mode off``
- **Compact JTAG (cJTAG) Mode**: Enabled with ``ftdi nscan1_mode on``

JTAG Link Configuration
-----------------------

The JTAG link configuration varies depending on the system architecture:

**Single Core System**

.. code-block:: c

    set _CHIPNAME0 riscv0
    jtag newtap $_CHIPNAME0 cpu -irlen 5 -expected-id 0x10900a6d

    set _TARGETNAME0 $_CHIPNAME0.cpu
    target create $_TARGETNAME0 riscv -chain-position $_TARGETNAME0 -coreid 0

**SMP (Symmetric Multiprocessing) System**

.. code-block:: c

    set _CHIPNAME0 riscv0
    jtag newtap $_CHIPNAME0 cpu -irlen 5 -expected-id 0x10900a6d

    set _TARGETNAME0 $_CHIPNAME0.cpu
    target create $_TARGETNAME0.0 riscv -chain-position $_TARGETNAME0 -coreid 0 -rtos hwthread
    target create $_TARGETNAME0.1 riscv -chain-position $_TARGETNAME0 -coreid 1
    target create $_TARGETNAME0.2 riscv -chain-position $_TARGETNAME0 -coreid 2
    target smp $_TARGETNAME0.0 $_TARGETNAME0.1 $_TARGETNAME0.2

**AMP (Asymmetric Multiprocessing) System**

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

   The ``-rtos hwthread`` option enables OpenOCD's pseudo RTOS functionality, which:

   - Presents CPU cores ("hardware threads") as threads to GDB
   - Allows inspection of SMP system state through GDB commands
   - Enables core-specific debugging operations:
     - ``info threads`` lists active CPU cores
     - ``thread`` switches between CPU core views
     - ``step`` and ``stepi`` operate on individual cores

Work Area Configuration
------------------------

The work area is a dedicated memory region that accelerates various operations, including:

- Memory read/write operations
- Execution of small program fragments
- Flash memory operations

Configuration Example:

.. code-block:: c

    $_TARGETNAME0 configure -work-area-phys 0x08000000 -work-area-size 0x10000 -work-area-backup 1

.. note::

   Work Area Requirements:
   - Must be a readable, writable, and executable memory region
   - Base address (0x08000000) and size (0x10000) should be adjusted according to system requirements

NOR Flash Configuration
------------------------

The NOR flash configuration specifies the memory mapping and controller settings:

.. code-block:: c

    set _FLASHNAME0 $_CHIPNAME0.flash
    flash bank $_FLASHNAME0 nuspi 0x20000000 0 0 0 $_TARGETNAME0.0 0x10180000

.. note::

   Configuration Parameters:
   - ``nuspi``: Flash driver type (adjust as needed)
   - ``0x20000000``: QSPI XIP address (adjust as needed)
   - ``0x10180000``: QSPI controller base address (adjust as needed)

Debugger Connection Specification
---------------------------------

When multiple debuggers are present in the debugging environment, you can specify which debugger to connect to using:

.. code-block:: c

    ftdi_serial FT4YR31I

Replace "FT4YR31I" with the actual serial number of your debugger.

Debugging Service Ports
-----------------------

OpenOCD provides three debugging service ports:

1. **GDB Port** (default: 3333)
2. **Telnet Port** (default: 4444)
3. **TCL Port** (default: 6666)

Configuration Example:

.. code-block:: c

    gdb_port 3333
    telnet_port 4444
    tcl_port 6666

.. note::

   - Port numbers can be customized if the default ports are unavailable
   - To disable a service, set its port to ``disable``
   - Ensure port numbers don't conflict with other services

Semihosting Support
-------------------

OpenOCD supports ARM semihosting, which allows target programs to use host system resources. To enable:

.. code-block:: c

    arm semihosting enable

.. note::

   Semihosting provides access to:
   - File I/O operations
   - Console input/output
   - System clock information
   - Other host system services


For more detailed information about how to use openocd, please check the ``openocd.pdf`` distributed in openocd release.


Target Defer Examine
--------------------

In some multicore systems, the slave-target is not debuggable and needs to be unlocked by the host-target before it can be used, in which case the -defer-examine parameter is needed.

.. code-block:: c

    # Configuring the “-defer-examine” parameter
    $SLAVE_TARGETNAME configure -defer-examine

    # Override events, the following events will trigger reset, slave-target needs to be initialized manually after reset
    $_TARGETNAME1_0 configure -event gdb-flash-erase-start {
      init
    }
    $_TARGETNAME1_0 configure -event gdb-flash-write-end {
      init
    }

    # Initialization, since the slave-target specifies the “-defer-examine” parameter, only the other targets will be initialized.
    init

    # The host-target unlocks the slave-target with the command configuration registers
    $HOST_TARGETNAME dmi_write/dm_write
    $HOST_TARGETNAME dmi_read/dm_read

    # Manually initialize slave-target
    $SLAVE_TARGETNAME arp_examine

Frequently Asked Questions
==========================

For additional troubleshooting and common issues, refer to:

- `GitHub FAQ <https://github.com/riscv-mcu/riscv-openocd/wiki>`_.

- `Gitee FAQ <https://gitee.com/riscv-mcu/riscv-openocd/wikis>`_.

Low-Cost Debugger Solution
==========================

Nuclei provides an affordable debugging solution for RISC-V CPUs:

- Supports both JTAG and cJTAG protocols
- Fully compatible with Nuclei Studio
- Open-source implementation available

`Dlink Repository <https://github.com/Nuclei-Software/nuclei-dlink>`_.

Changelog
=========

.. _openocd_changelog_202510:

Version 2025.10
---------------

This release is based on 2025.02 version with some new features and bug fixes introduced.

* Update ``nuclei cpuinfo`` command implementation using nuclei sdk 0.9.0 cpuinfo same source code to provide same behavior
* Correct custom flashloader binary file location search rules, where openocd executed, openocd ``scripts`` folder, and absolute path
* Sync nuclei custom CSRs support
* Optimize flash probe process, when no flash probed, it will exit with error instead of hang on it
* Support debug for hypervisor mode
* Fix debug ``Assertion failed!`` on HBird opensource cpu
* Fix nuclei riscv cross trigger command implementation ``nuclei cti xxx``
* Clear ``haltreq`` signal when openocd connect failed
* Fix segmentation fault issue when debug level set to 3 or 4
* When debug on FPGA CPU MHz is very slow such as **5MHz**, openocd may work not correctly, it will be fixed by make CPU run faster such as **10MHz**

.. _openocd_changelog_202502:

Version 2025.02
---------------

In this release, Nuclei OpenOCD bump openocd code base from 0.11 to 0.12,
with this base changes, a lot of new features supported by upstream will
be taken into Nuclei OpenOCD.

**Known Issues:**

- There is a probability that writing flash under smp multi-core architecture will fail,
  which can be solved by clarifying the number of SMP cores or reducing the JTAG frequency.

**New Features:**

- Live watch feature implementation, see :ref:`ide_live_watch`
- Nuclei CTI command group support
- Enhanced ETrace command group functionality, see :ref:`ide_etrace`
- Optimized CPU information command

**Improvements:**

- Continuous integration and documentation enhancements
- Code organization: consolidated Nuclei commands into ``nuclei_riscv.c``
- Register access optimization: replaced ``vslide1down_vx`` with direct ``vx`` register access for lite vpu case

**CSR Updates:**

New Custom CSRs:

+--------------+---------------+
| Address Range| CSR Name      |
+==============+===============+
| 0x1a4~0x1af  | smpuaddr4~15  |
+--------------+---------------+
| 0x1c0~0x1ef  | smpuaddr16~63 |
+--------------+---------------+

CSR Renaming:

+--------------+---------------+
| Old Name     | New Name      |
+==============+===============+
| spmpcfg0~3   | smpucfg0~3    |
+--------------+---------------+
| spmpaddr0~15 | smpuaddr0~15  |
+--------------+---------------+
| mfp16mode    | mmisc_ctl1    |
+--------------+---------------+
| mecc_ctrl    | mecc_ctl      |
+--------------+---------------+
| mstack_ctrl  | mstack_ctl    |
+--------------+---------------+

**Base Version:**

- Changes based on `riscv-collab/riscv-openocd@f82c5a7 <https://github.com/riscv-collab/riscv-openocd/commit/f82c5a7>`_.
