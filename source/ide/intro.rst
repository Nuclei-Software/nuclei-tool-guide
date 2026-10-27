.. _intro:

Introduction to Nuclei Studio IDE
=================================

.. note::

   - Nuclei Studio now has video tutorials. Related content is continuously updated on the **Nuclei System Technology WeChat video channel**. Search for and follow the **Nuclei video channel** in WeChat to get the latest updates.
   - If you encounter problems while using Nuclei Studio or Nuclei Tools, check the content at https://doc.nucleisys.com/nuclei_studio_supply/, or submit an issue to us.

An efficient and easy-to-use Integrated Development Environment (IDE) is essential for any MCU; software developers need an IDE for day-to-day project development and debugging.
Many embedded software engineers in mainland China are familiar with ARM's commercial IDE, Keil. However, because commercial IDEs (such as Keil) involve licensing and cost issues, major MCU vendors also release their own
free IDEs, such as Renesas e2 studio and NXP LPCXpresso. These IDEs are all based on the open-source Eclipse framework, and Eclipse has become the mainstream choice for free, open-source MCU IDEs.

Nuclei Studio IDE is an Eclipse-based integrated development environment developed by Nuclei for its RISC-V processor IP core products.

The Eclipse platform is developed under an open-source model and provides a public license (with free source code) and worldwide distribution rights.
Eclipse itself is only a framework platform; apart from the runtime kernel of the Eclipse platform, all of its functionality resides in plugins.
Developers can extend the platform's functionality through plugins from the Eclipse project or through plugins provided by other developers.
One plugin can be plugged into another, enabling a maximum degree of integration.

Because the Eclipse IDE is already widely used in the community, for general Eclipse
IDE usage that is not tied to specific hardware or a CPU, you can refer to tutorials about the Eclipse
IDE written by others. The following tutorial websites are recommended:

-  https://help.eclipse.org/latest/index.jsp

-  https://eclipse-embed-cdt.github.io/

-  https://mcuoneclipse.com/

The Eclipse IDE platform has the following advantages.

-  **Large community**

   Since its launch in 2001, Eclipse has built a large community, which provides designers with many resources, including books, tutorials, and websites,
   to help them work more efficiently with the Eclipse platform and tools. The Eclipse platform and its related projects and plugins can be downloaded directly from the eclipse.org website.

-  **Continuous improvement**

   Eclipse's open-source platform helps developers continuously take full advantage of large-scale resources. Eclipse is continuously improved through the following projects.

   -  Platform project — focuses on Eclipse itself.

   -  CDT project — focuses on C/C++ development tooling.

   -  PDE project — focuses on the plug-in development environment.

-  **Open source code**

   Designers always have access to the source code and can fix tool errors themselves, which helps them save time and stay in control of their development work.

-  **Compatibility**

   The Eclipse platform is written in Java and can be used on various development workstations such as Windows and Linux. The open-source tools support multiple languages, multiple platforms, and multiple vendor environments.

-  **Extensibility**

   Eclipse adopts an open, extensible architecture. It can work with third-party extensions such as ClearCase, SlickEdit, Rational Rose, and other Unified Modeling Language (UML) suites. In addition, it works with various graphical user interface (GUI) editors and supports a wide range of plugins.


Nuclei Studio IDE takes full advantage of these Eclipse IDE strengths, combines mature community plugins such as Eclipse Embedded CDT and Linux Tools, and adds its own plugins to meet the daily needs of RISC-V embedded development:

- Project creation, management, build, and debug

- Multiple debugging solutions, including OpenOCD, J-Link, Nuclei DLink, and Nuclei QEMU

- Extensible debugging solutions, making it easy to extend support for more debuggers

- Multiple compilers, including gcc, clang, and zcc

- **Nuclei Settings**, a quick tool for common project settings

- On-Chip Trace based on the Nuclei ETrace hardware/software solution

- Enhanced profiling and code coverage solutions based on gprof and gcov

- The Nuclei Package (NPK) software package solution, which makes it easy to extend support for software development kits decoupled from Nuclei Studio,
  enabling a convenient **software package import** -> **Project Wizard** workflow. This approach has been widely adopted, for example by
  Nuclei's own **Nuclei SDK**.

- Faster ways to open projects and workspaces

- A more user-friendly Launch Bar


Nuclei Studio Release Notes
===========================

.. note::

   - To confirm the versions of the RISC-V Toolchain, OpenOCD, QEMU, and Nuclei Model integrated in the current Nuclei Studio, check the content of ``toolchain/ReadMe.txt``.

2026.10 Release Notes
---------------------

The 2026.10 version is developed based on Eclipse Cpp 2024-06 and upgrades Nuclei System Technology's tool versions to 2026.10. It adds debugging views and features such as the RISC-V extension selector, Flash Erase, Live Peripheral, CPU Information, MMU View, and RISC-V Reference; optimizes existing features such as Connect to Running Target, Trace, Flame View, and Live Watch; adds GDB breakpoint project filter options and the Memory view address exclusion feature (also applicable to Memory Browser) to the underlying Eclipse CDT; and fixes several known defects.

Upgrade RISC-V Toolchain, OpenOCD, and QEMU Versions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Nuclei Studio 2026.10 integrates Nuclei RISC-V Toolchain 2026.10. For details, see :ref:`toolchain_changelog_202610`.

- Nuclei Studio 2026.10 integrates OpenOCD 2026.10. For details, see :ref:`openocd_changelog_202610`.

- Nuclei Studio 2026.10 integrates Nuclei Qemu 2026.10. For details, see :ref:`qemu_changelog_202610`.

- Nuclei Studio 2026.10 integrates Nuclei Near Cycle Model 2026.10. For details, see :ref:`xlmodel_changelog_202610`.


Added RISC-V Extension Selector
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A graphical RISC-V extension selector has been added. You can select RISC-V ISA extensions in the project wizard or on the Settings page of project properties, and it generates the ``-march`` string automatically; debug and analysis extensions such as ``Live Watch`` and ``Trace`` are also selectable and usable in the extension selector. For details, see :ref:`Using the RISC-V Extension Selector <ide_extension_selector>`.

Added Flash Erase Feature
~~~~~~~~~~~~~~~~~~~~~~~~~~

The Flash Erase feature has been added; it can erase Flash up to a specified address. For details, see :ref:`Flash Erase <ide_flash_erase>`.


Added Live Peripheral Feature
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Live Peripheral is a real-time peripheral monitoring tool developed by Nuclei System Technology. It allows you to view and modify SVD peripheral registers in real time during debugging, and shares the same backend as Live Watch. For details, see :ref:`Live Peripheral <ide_live_peripheral>`.

Added CPU Information View
~~~~~~~~~~~~~~~~~~~~~~~~~~~

The CPU Information view has been added. During debugging, you can view information such as MARCHID/MHARTID/MIMPID/ISA per hart and decode Nuclei configuration CSRs, and use the CPU Fault Analysis tab to locate trap causes. For details, see :ref:`CPU Information <ide_cpu_information>`.

Added MMU View Feature
~~~~~~~~~~~~~~~~~~~~~~~

The RISC-V MMU view has been added. It can read ``satp``/``misa`` and walk Sv32/Sv39/Sv48/Sv57 page tables while the target is halted, providing virtual address translation, a complete memory map, and a page-table tree. For details, see :ref:`MMU View <ide_mmu_view>`.

Added RISC-V Reference Feature
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The RISC-V Reference view has been added. You can search instructions/CSRs/peripheral registers, encode and decode between machine code and assembly, and interpret register values by bit field. For details, see :ref:`RISC-V Reference <ide_riscv_reference>`.

Optimized Flame View Feature
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In the 2026.10 version, we further optimized Flame View by supporting the display of multi-level nested interrupt flame graphs and improving flame graph generation efficiency. Flame View is an intuitive and efficient performance analysis tool used to visualize program execution call stacks and time distribution in embedded systems, helping developers quickly identify hot functions, analyze execution paths, and locate performance bottlenecks.

For details, see :ref:`Using Flame View <ide_flame_view>`.

Optimized Trace Feature
~~~~~~~~~~~~~~~~~~~~~~~~

Based on earlier practical feedback, this release fixes several known defects of the Trace feature and optimizes its processing performance. When connected to a board, it can automatically read registers to fill in the default values of the Trace/Decode settings, and it adds or improves features such as interrupt queries based on Trace data and Flame View. The main enhancements are as follows:

- **Trace bundle (Trace 2.0)**: the Trace 2.0 transport type is supported, and parameters such as TS Size, Datatrace, Context Size, and Decode Mode are read from the CPU and filled in automatically. The raw data, decode results, and related configuration from one capture can be packaged into a single bundle file for easy saving and sharing, and can be replayed offline (with no board connected) in Nuclei Studio to reproduce the complete analysis process.

- **Headless Mode**: trace files can be decoded without opening the Nuclei Studio workbench, by running the built-in headless decoding application with options compatible with ``dqr``, which is suitable for batch decoding, scripts, and CI pipelines.

For details on the Trace feature, see :ref:`Using Trace <ide_advanceusage_43>`; for details on Headless Mode, see :ref:`Using Trace in Headless Mode <ide_ide_trace_headless>`.

Optimized Live Watch Feature
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Live Watch is a real-time monitoring tool developed by Nuclei System Technology to help developers debug and optimize code more efficiently. The main change for Live Watch in Nuclei Studio 2026.10 is support for obtaining variable values through the GDB channel, along with corresponding optimizations to the refresh and plotting experience.

For details, see :ref:`Live Watch <ide_live_watch>`.

ZCC Upgrade
~~~~~~~~~~~~

Nuclei Studio 2026.10 integrates ZCC 5.0.0. For details, see: https://www.terapines.com/products/zcc

Added GDB Breakpoint Project Filter Option
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

When debugging in a multi-project workspace, the breakpoints of all projects were previously installed to GDB, which could easily interfere with the current debugging session. To address this, a new GDB debug preference ``Only install breakpoints that belong to the launched project`` has been added, so that only the breakpoints of the currently debugged project are installed to GDB, while the breakpoints of other projects are automatically skipped.

For details, see :ref:`GDB Breakpoint Project Filter Option <ide_gdb_breakpoint_filter>`.

Added Memory View Address Exclusion
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The ``Address Exclusion Settings...`` item has been added to the Memory view (also applicable to Memory Browser), so you can configure memory address ranges that should not be read, avoiding errors when accessing inaccessible or protected regions.

For details, see :ref:`Memory View Address Exclusion <ide_memory_exclusion>`.

Fixed Known Bugs
~~~~~~~~~~~~~~~~~

- Fixed garbled Chinese characters under Chinese Windows systems, both in the debug console and build console (for example, messages such as "An existing connection was forcibly closed by the remote host.") and during compilation and at runtime;

- Fixed that GDB command history (history command recall) did not work in Debugger Console;

- Fixed the display of the command prompt and the response to specific commands in Debugger Console;

- Fixed the bug that Connect to Running Target would reset the CPU;

- Fixed that running clean on large projects failed because the generated command line (such as ``rm`` or compile commands) was too long;

- Fixed other known bugs.


.. _ide_changelog_202510:

2025.10 Release Notes
---------------------

Version 2025.10 is developed based on Eclipse Cpp 2024-06. It upgrades the Nuclei tools to version 2025.10, adds features such as code debugging, code performance analysis, and IDE online upgrade, optimizes several existing features, and fixes defects present in version 2025.02.

Upgraded RISC-V Toolchain, OpenOCD, and QEMU Versions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Nuclei Studio 2025.10 integrates Nuclei RISC-V Toolchain 2025.10; see :ref:`toolchain_changelog_202510` for details. In this release, the Windows version switches to Win64, replacing the previous Win32 version, to resolve the problem that large files could not be compiled.

- Nuclei Studio 2025.10 integrates OpenOCD 2025.10; see :ref:`openocd_changelog_202510` for details.

- Nuclei Studio 2025.10 integrates Nuclei QEMU 2025.10; see :ref:`qemu_changelog_202510` for details.

- Nuclei Studio 2025.10 integrates Nuclei Near Cycle Model 2025.10; see :ref:`xlmodel_changelog_202510` for details.


Added Support for More New Cores
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Added support for the N300E core.

Optimized Frequently Used Menus in Nuclei Studio
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Some frequently used menus in Nuclei Studio, such as ``New Nuclei RISC-V C/C++ Project``, were not shown in the Debug perspective, resulting in a poor user experience. To make them easier to use, the positions of these menus have been optimized.

See :ref:`No project creation menu in the Debug perspective <ide_faq_menu_add>` for details.

Added the IDE Online Upgrade Feature
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Added three upgrade features: online plugin upgrade, online toolchain upgrade, and online IDE upgrade. You can flexibly upgrade each component independently as needed, without replacing or reinstalling the whole package, greatly improving efficiency and system stability.

See :ref:`Nuclei Studio upgrade and update <ide_update>` for details.

Optimized the IDE Welcome Page
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The Welcome page has been optimized to provide quick entries to frequently used documents and tools, making them easier for users to consult and use.

See :ref:`Introduction to the Welcome page <ide_welcome>` for details.

Added the Connect to Running Target Feature
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To support connecting directly to a development board, Nuclei Studio added the Connect to Running Target feature. This feature allows users to connect directly to a hardware development board and read board-related information, greatly improving development efficiency.

See :ref:`Connect to Running Target feature <ide_connect_to_target>` for details.

Added the Flame View Feature
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The new Flame View (flame graph view) is an intuitive and efficient performance analysis tool used to visualize the execution call stack and time distribution of programs in embedded systems. By converting complex trace data into hierarchical stacked graphs, Flame View helps developers quickly identify hot functions, analyze execution paths, and locate performance bottlenecks.

See :ref:`Using the Flame View feature <ide_flame_view>` for details.

Added Support for Nuclei Model Debugging
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Nuclei Model, developed by Nuclei, is a dedicated tool for running the Nuclei Near Cycle Model. In this version update, the functionality of the Nuclei Near Cycle Model has been enhanced, and users can perform Debug/Run operations on projects with the Nuclei Near Cycle Model. A new Nuclei Model Debug Configuration view has been added to better support running and debugging.

For the Flame View content in the Nuclei Model Debugger, see :ref:`Using Flame View in Nuclei Model <ide_nuclei_model_flame>`.

See :ref:`Using the Nuclei Model Debugger feature <ide_nuclei_model_debugger>` for details.

Optimized the GDB Custom Debug Feature
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

GDB Custom is a simplified debug configuration developed by Nuclei to accommodate different debugging tools, allowing users to debug programs in Nuclei Studio with their own debugging tools. This version optimizes it on top of the original functionality for a better user experience.

See :ref:`GDB Custom debug feature <ide_nuclei_custom_debugger>` for details.

Optimized the Trace Feature
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Based on feedback from previous versions, known bugs in the Trace feature were fixed, the performance of the Trace tool was optimized so that it processes data faster and more stably, and features such as Trace-data-based interrupt query and Flame View were added.

For an introduction to interrupts in the Trace feature, see :ref:`Querying interrupts in Trace <ide_ide_trace_exceptions>`.

For the Flame View content in the Trace feature, see :ref:`Using Flame View in Trace <ide_ide_trace_flame>`.

For details on the Trace feature, see :ref:`Using the Trace feature <ide_advanceusage_43>`.

Optimized the Live Watch Feature
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Live Watch is a real-time monitoring tool developed by Nuclei, designed to help developers debug and optimize code more efficiently. In Nuclei Studio 2025.10, the Live Watch feature has been optimized, with a higher sampling frequency and drag-to-add-variable support.

See :ref:`Using the Live Watch feature <ide_live_watch>` for details.

Optimized and Improved the RVProf Feature
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

RVProf is a performance analysis tool developed by Nuclei based on the CPU cycle model. Starting with version 2025.10, RVProf can be used on Windows. For details, see :ref:`Using the RVProf feature <ide_adv_rvprof>`. This feature requires support from the corresponding NPK package; to try it, please contact us.

ZCC Upgrade
~~~~~~~~~~~

Nuclei Studio 2025.10 integrates ZCC 4.1.7 and includes software libraries supported by Nuclei. For more information, see https://www.terapines.com/products/zcc.

Fixed Known Bugs
~~~~~~~~~~~~~~~~

- Fixed an issue where opening a file in Lst View could cause the IDE to freeze in certain scenarios;
- Fixed an issue where opening or deleting ``*.elf, *.o`` files incorrectly reported that the file was in use;
- Fixed an issue where Coverage data was empty in the Linux version of Nuclei Studio;
- Fixed an issue in Flash Programming where binary files outside the current project could not be selected;
- Fixed an error reported when debugging HummingBird projects with OpenOCD;
- Fixed other known bugs.


.. _ide_changelog_202502:

2025.02 Release Notes
---------------------

Version 2025.02 is developed based on Eclipse Cpp 2024-06, with the CDT version updated to Eclipse CDT 2024-06. It upgrades the Nuclei tools to version 2025.02, optimizes several existing features, adds features such as debugging and code performance analysis, and fixes defects present in version 2024.06.

Upgraded the Eclipse Cpp Version
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Nuclei Studio 2025.02 is developed based on Eclipse Cpp 2024-06. The base CDT version has been upgraded to 11.6.1.

Upgraded RISC-V Toolchain, OpenOCD, and QEMU Versions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Nuclei Studio 2025.02 integrates Nuclei RISC-V Toolchain 2025.02; see https://github.com/riscv-mcu/riscv-gnu-toolchain/releases/tag/nuclei-2025.02 for details.

Nuclei Studio 2025.02 integrates OpenOCD 2025.02; see https://github.com/riscv-mcu/riscv-openocd/releases/tag/nuclei-2025.02 for details.

Nuclei Studio 2025.02 integrates Nuclei QEMU 2025.02; see https://github.com/riscv-mcu/qemu/releases/tag/nuclei-2025.02 for details.

Added Support for More New Cores
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Added support for the N200E, N202, N202E, NX1000, NX1000F, NX1000FD, UX1000, and UX1000F CPU cores.

Added the Flash Programming Feature
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To support downloading compiled binary files directly to a hardware development board, Nuclei Studio added the Flash Programming feature. This feature allows users to quickly and conveniently download compiled binary files directly to a hardware development board, greatly improving development and debugging efficiency.

See :ref:`Flash Programming feature <ide_flash_programming>` for details.

Added the Nuclei NICE Wizard
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Nuclei NICE Wizard is a tool integrated into Nuclei Studio that aims to simplify and accelerate the creation of NICE (custom instruction extensions) and VNICE (vectorized custom instruction extensions) instructions.

See :ref:`Nuclei NICE Wizard <ide_nuclei_nice_wizard>` for details.

Added Nuclei Model Support
~~~~~~~~~~~~~~~~~~~~~~~~~~

Nuclei Model, developed by Nuclei, is a dedicated tool for running the Nuclei Near Cycle Model. To provide a simpler and more efficient user experience, the new Model tool was introduced with functionality simplified from RVProf.

See :ref:`Nuclei Model <ide_nuclei_model>` for details.


Upgraded the Nuclei Near Cycle Model Version
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Nuclei Near Cycle Model is a simulation testing and performance analysis tool independently developed by Nuclei. It helps developers perform the necessary simulation testing and program performance analysis in the early stages of a project. This version fully supports the Nuclei CPU 200, 300, 600, 900, and 1000 series CPUs, on both Windows and Linux.

See :ref:`Nuclei Near Cycle Model <ide_nuclei_near_cycle_model>` for details.

Added the Live Watch Feature
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Live Watch is a real-time monitoring tool developed by Nuclei, designed to help developers debug and optimize code more efficiently.

See :ref:`Using the Live Watch feature <ide_live_watch>` for details.


ZCC Upgrade
~~~~~~~~~~~

Nuclei Studio 2025.02 integrates ZCC 3.2.5 and includes software libraries supported by Nuclei. For more information, see https://www.terapines.com/products/zcc.

.. _ide_changelog_202406:

2024.06 Release Notes
---------------------

This version is a relatively major upgrade. Version 2024.06 upgrades CDT to Eclipse CDT 2024-06, upgrades the Nuclei tools to version 2024.06, optimizes several existing features, adds features such as debugging and code performance analysis, and fixes defects present in version 2024.02.

Upgraded the Eclipse CDT Version
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In Nuclei Studio 2024.06, the base CDT version has been upgraded to 11.6.0, and this version is developed based on Eclipse CDT 2024-06.

Upgraded RISC-V Toolchain, OpenOCD, and QEMU Versions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Nuclei Studio 2024.06 integrates Nuclei RISC-V Toolchain 2024.06; see https://github.com/riscv-mcu/riscv-gnu-toolchain/releases/tag/nuclei-2024.06 for details.

Nuclei Studio 2024.06 integrates OpenOCD 2024.06; see https://github.com/riscv-mcu/riscv-openocd/releases/tag/nuclei-2024.06 for details.

Nuclei Studio 2024.06 integrates Nuclei QEMU 2024.06; see https://github.com/riscv-mcu/qemu/releases/tag/nuclei-2024.06 for details.

Added Support for U600 and UX1000
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Support for the U600 and UX1000 cores was added alongside the release of these cores.

Optimized NPK Package Management
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The management of NPK package dependencies in Nuclei Package Management was optimized to make it easier to use, and some NPK package installation prompts and logs were improved for a better NPK package management experience. See :ref:`NPK package management <ide_npk_package_management>` for details.

.. note::

   This version upgrade changed the configuration of NPK package management. NPK packages installed in version 2024.02 or earlier cannot be recognized by Nuclei Studio 2024.06; download and install the NPK packages again.

Added and Optimized Some Compiler Options
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In the Properties and Nuclei Settings pages, a new ``-Oz`` option was added to Optimization Level; support for group libraries was added to the Libraries page of GNU RISC-V Cross C++ Linker. See :ref:`Error about missing symbols when linking the C library during project build <ide_faq_36>`.

Optimized Debug Mode Switching
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Nuclei Studio supports multiple debug modes, such as OpenOCD, J-Link, DLink, and Custom, as well as simulators such as QEMU. Debug mode switching has been optimized to make it easier for users to switch between multiple projects and multiple modes. For details, see :ref:`Debug mode management <ide_projectrun_1>`.

Optimized and Improved DLink Debugging
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Nuclei DLink is a RISC-V debugger developed by Nuclei based on RV Link, with many features added on top of RV Link, making it better suited to Nuclei Studio use cases. For details, see :ref:`Debugging and running a project with DLink <ide_projectrun_50>`.

Integrated the Terapines ZCC Lite Compiler
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Terapines ZCC is a high-performance RISC-V compiler developed by Terapines. Nuclei Studio 2024.06 adds support for Terapines ZCC, which can be used directly in the IDE. See :ref:`Building the Hello World project in Nuclei Studio <ide_projectbuild_13>` for details.

Added the LST View Tool
~~~~~~~~~~~~~~~~~~~~~~~

LST View is an lst file viewer that makes it easy for users to view files in lst format and provides linkage between \*.lst files and source code. For details, see :ref:`LST View <ide_advanceusage_13>`.

Optimized and Improved the Gprof Feature
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Gprof is a powerful performance analysis tool that helps developers understand the runtime behavior of C/C++ programs. With Gprof, you can obtain call information, call counts, execution time, and more for each function in a program, which is highly valuable for optimizing programs and improving their runtime efficiency. For details, see :ref:`Code Coverage and Profiling features <ide_advanceusage_17>`.

Optimized and Improved the Gcov Feature
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Gcov is a tool for testing C/C++ code coverage. Released together with GCC, it works with GCC to test statement coverage, function coverage, and branch coverage of C/C++ files. For details, see :ref:`Code Coverage and Profiling features <ide_advanceusage_17>`.

Added the Call Graph Feature
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Call Graph is a tool for analyzing function call relationships. Used together with Gprof, it helps developers quickly understand a program's execution process and call relationships. For details, see :ref:`Code Coverage and Profiling features <ide_advanceusage_17>`.

Added Nuclei Near Cycle Model Support
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Nuclei Near Cycle Model is a simulation testing and performance analysis tool independently developed by Nuclei. It helps developers perform the necessary simulation testing and program performance analysis in the early stages of a project. For details, see :ref:`Simulation performance analysis with Nuclei Near Cycle Model <ide_advanceusage_71>`.

.. _ide_changelog_202402:

2024.02.dev Release Notes
-------------------------

This version is a development version (the content at the download link may change at any time). It fixes defects present in Nuclei Studio 2023.10, optimizes some existing features such as the ETrace feature, and adds some new features such as support for N100 and DLink, to better meet customer evaluation and update needs.

Upgraded the Eclipse CDT Version
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In Nuclei Studio 2024.02.dev, the base Eclipse CDT version has been upgraded to Eclipse CDT 2023.12.

Added Support for N100
~~~~~~~~~~~~~~~~~~~~~~

Support for N100 was added alongside the release of the N100 core.

Added a Batch GCC 13 Project Conversion Tool
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In Nuclei Studio 2023.10, after upgrading to GCC 13, converting a large number of projects one by one was inefficient. To make this easier for developers, a batch GCC 13 conversion tool is provided. For details, see :ref:`Batch converting projects to support gcc 13 <ide_advanceusage_4>`.

Optimized and Improved the Trace Feature
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The Trace feature in Nuclei Studio has been upgraded to support single-core applications, SMP multi-core applications, and AMP multi-core applications in OpenOCD mode; for details, see :ref:`Using the Trace feature <ide_advanceusage_43>`. In DLink mode, only single-core applications are supported. The Trace feature requires support from the corresponding CPU IP; to try it, please contact us.

Optimized and Improved the RVProf Feature
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

RVProf is a performance analysis tool developed by Nuclei based on the CPU cycle model. For details, see :ref:`Using the RVProf feature <ide_adv_rvprof>`. This feature requires support from the corresponding NPK package; to try it, please contact us.

Added Support for DLink Debug
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

DLink is a debugging solution independently developed by Nuclei and is supported in this version. This feature requires a DLink debugger; to try it, please contact us.

.. _ide_changelog_202310:

2023.10 Release Notes
---------------------

This version is a relatively major upgrade. It integrates the Nuclei 2023.10 versions of the Toolchain, QEMU, and OpenOCD; the Eclipse CDT version has been upgraded; and GCC has also undergone a major iteration to GCC 13. Many new features have been added to NPK to support project creation with GCC or Clang, and many new Configuration field types have been added to allow more flexible project configuration in the Project Wizard.

Upgraded the Eclipse CDT Version
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In Nuclei Studio 2023.10, the base Eclipse CDT version has been upgraded to Eclipse CDT 2023.06. Eclipse CDT 2023-06 is the Eclipse Foundation's second-quarter 2023 simultaneous release, with 64 participating projects, released on June 14, 2023.

Reference: `Eclipse IDE for C/C++ Developers <https://www.eclipse.org/downloads/packages/release/2023-06/r/eclipse-ide-cc-developers>`__

After the upgrade, opening a workspace created by a previous version displays an incompatibility warning, and anomalies may occur during use. Switching to a new workspace directory is recommended.

|image1|

Upgraded the build-tools Version
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In Nuclei Studio 2023.10, the build-tools in the toolchain have been updated to version 4.4, and the ``bash.exe``, ``cp.exe``, ``mv.exe``, and ``tar.exe`` tools have been added.

|IMG_256|


Support for GCC 13 and Clang 17
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Nuclei Studio 2023.10 adds support for GCC 13. Compared with the previous gcc10 version, GCC 13 provides more complete support for RISC-V instruction extensions, and the version maintained by Nuclei supports the full RVV Intrinsic API v0.12. Nuclei Studio 2023.10 also adds support for Clang 17 (reference: https://releases.llvm.org/17.0.1/docs/RISCVUsage.html). If you still want to use GCC 10 for project development, the related configuration has been kept, but the toolchain is not integrated into the IDE; download it yourself and place it in the gcc10 directory (see the README.txt inside). A migration path is also provided for upgrading projects created with older versions of Nuclei Studio that use gcc10 to the gcc13 toolchain; for details, see :ref:`Importing projects created by older versions of Nuclei Studio <ide_advanceusage_0>`. For a more detailed description of Nuclei RISC-V Toolchain 2023.10, see https://github.com/riscv-mcu/riscv-gnu-toolchain/releases/tag/nuclei-2023.10

|image2|

|image3|

|image4|

.. _ide_intro_4:

Changes in RISC-V Instruction Extension Usage
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Due to changes in GCC and Clang, extension usage has changed significantly. The mapping between the original bpkv extensions and the new rules is as follows. For a more detailed description, see https://doc.nucleisys.com/nuclei_sdk/develop/buildsystem.html#arch-ext


-  ``b`` -> ``_zba_zbb_zbc_zbs``

-  ``p`` -> rv64: ``_xxldsp``, rv32: ``_xxldspn3x`` for n300, ``_xxldspn1x`` for n900

-  ``k`` -> ``_zk_zks``

-  ``v`` -> rv32f/d: ``_zve32f``, rv64f: ``_zve64f``, rv64fd: ``v``

Take N307FD + B + V + Nuclei DSP with the N1 extension as an example: to create an application that uses extensions, enter the correct extension string in Nuclei ARCH Extensions in the project creation wizard. For example, to use the bpv extension, enter ``_zba_zbb_zbc_zbs_zve32f_xxldspn1x`` according to the rules above.

|image5|

In the generated project, you can view the project's **Nuclei Settings**.

|image7|

Similarly, the project properties also contain configuration items related to RISC-V instruction extensions under ``C/C++ Build->Settings->Target Processor``.

|image6|

The QEMU configuration also has corresponding RISC-V instruction extension configuration items.

|image8|

Changes in NPK Package Usage
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To support GCC 13 and Clang 17, the Nuclei SDK package has been upgraded to version 0.5.0. When creating a project with the SDK package, users can choose to create a GCC 13 or Clang 17 project as needed. Because the version changes are significant, some features of SDK versions earlier than 0.5.0 may not work properly in Nuclei Studio 2023.10, so a migration tool is provided to help you quickly migrate and upgrade your projects. **Back up your old projects first**. For details, see :ref:`Importing projects created by older versions of Nuclei Studio <ide_advanceusage_0>`.

|image9|

In addition, Nuclei Studio 2023.10 validates the compatible version of online NPK component packages (uploading a package requires specifying the Nuclei Studio version on which it was tested). The Nuclei Studio version that each component package is compatible with is shown on the Package Management page, and a prompt is displayed if the version does not match during download and installation. However, no prompt is given when importing offline packages; verify yourself whether the package is supported by the Nuclei Studio IDE version you are using, as shown below.

|image10|

Upgraded OpenOCD
~~~~~~~~~~~~~~~~

OpenOCD has been upgraded to version 2023.10, with some additional debugging features added, such as viewing CPU information and experimental etrace support. For a more detailed description of the OpenOCD changes, see https://github.com/riscv-mcu/riscv-openocd/releases/tag/nuclei-2023.10

Upgraded QEMU
~~~~~~~~~~~~~

Nuclei Studio 2023.10 integrates Nuclei QEMU 2023.10, which is developed based on QEMU 8.0 (reference: https://wiki.qemu.org/ChangeLog/8.0). This version of QEMU differs significantly from version 2022.10 in terms of usage: it no longer supports the ``gd32vf103_rvstar`` board and now supports only Nuclei EvalSoC, which can be configured to work seamlessly with Nuclei SDK/Nuclei Linux SDK. The supported machine has also been unified from ``nuclei_n``/``nuclei_u`` to ``nuclei_evalsoc``. For a more detailed description of Nuclei QEMU, see https://github.com/riscv-mcu/qemu/releases/tag/nuclei-2023.10

|image11|

.. _my_internal_link_label:

Added an ELF File Viewer
~~~~~~~~~~~~~~~~~~~~~~~~

Nuclei Studio 2023.10 adds an ELF file viewer, making it easy for users to view the compiled ``.elf`` and ``.o`` files.

|image12|

|image13|

Added Code Coverage and Profiling Features
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Nuclei Studio 2023.10 adds support for the Code Coverage and Profiling features. For details, see :ref:`Code Coverage and Profiling features <ide_advanceusage_17>`.

Added the Trace Feature
~~~~~~~~~~~~~~~~~~~~~~~

Nuclei Studio 2023.10 **experimentally** adds the Trace feature. Using this feature requires a CPU with Nuclei Trace IP; to try it, please contact us.

Nuclei Settings Feature Optimization
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To accommodate more personalized configuration, some Nuclei Settings functionality was modified.

Nuclei Studio 2023.10 removes the original B/P/K/V radio buttons and replaces them with an Other Extensions input box, which users can fill in according to their own needs. For the use of B/P/K/V, see :ref:`Changes in RISC-V instruction extension usage <ide_intro_4>`.

|image14|

Nuclei Studio 2023.10 removes the original Select C Runtime Library radio buttons. If a project needs this setting, use the ``--specs=`` option in the project configuration or the Libraries option instead.

|image15|

Nuclei Settings is now more versatile: in addition to quickly modifying Nuclei projects, it supports static and shared library projects created with generic RISC-V and Arm toolchains. The figure below shows the shared library case.

|image16|

|image17|

Added Quick Open for a Specified Workspace
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Similar to double-clicking a ``*.nuproject`` file in a project to quickly open Nuclei Studio and import that project, Nuclei Studio now creates a ``work.nuworkspace`` file in workspace directories that have been used. Double-clicking this file opens Nuclei Studio directly. This feature is currently supported only on Windows; to use it, run ``install.bat`` on Windows after extracting the IDE to set up the file association.

|image18|

.. _ide_changelog_202212:

2022.12 Release Notes
---------------------

Since version 2021.09, Nuclei Studio has completely separated the IDE from the SDK and adopted the brand-new Nuclei Package (NPK) package management approach to manage and use template projects, making it easy for users to import different SDKs and create example projects in the IDE. The SDKs for Nuclei SDK, HBird SDK, and Nuclei's SoC IP products can all be packaged as Zip files and imported through Nuclei Package Management.

Nuclei Studio Download and Installation
=======================================

Nuclei Studio IDE Download
--------------------------

To help users get started quickly, this document recommends using the pre-packaged Nuclei Studio IDE software archive, which Nuclei has uploaded to the company website at https://www.nucleisys.com/download.php.

Go to the Download Center on the Nuclei website and download the Nuclei Studio archive for Windows or Linux, according to your development environment (note: the content of the Download Center is continuously updated; you can use the latest version or continue using the current version).

Nuclei Studio has been verified and tested on 64-bit Windows 10, Ubuntu 18.04/20.04, and 64-bit Red Hat 7.6; these system versions are recommended.

|image19|

Nuclei Studio IDE Installation
------------------------------

After downloading the Nuclei Studio IDE archive, extract it; the extracted files are described below.

-  Nuclei Studio software package

   -  This package contains the Nuclei Studio IDE software. Note: The specific version and file name may change over time.

-  HBird_Driver.exe (no longer provided since version 2021.02)

   -  **Windows version only.** This file is the USB driver installer for the Nuclei HummingBird debugger.

   -  When using this debugger in a Windows environment, you need to install this driver so that the USB device can be recognized by the system.

   -  This is because the OpenOCD update in version 2021.02 introduced driver-free functionality.

-  SerialDebugging_Tool (no longer provided since version 2021.02)

   -  **Windows version only.** This file is a serial port debugging assistant tool. Use it to print information over the serial port when debugging the software examples later.

|image20|


Launching Nuclei Studio IDE
---------------------------

To launch Nuclei Studio (the same steps apply on both Windows and Linux):

Double-click the executable file under the Nuclei Studio folder in the Nuclei Studio IDE package to launch Nuclei Studio.

|image21|

When you launch Nuclei Studio for the first time, a dialog prompts you to set the Workspace directory path, which is used to store the project files created later.

|image22|

.. _ide_welcome:

After setting the Workspace directory, click the Launch button to launch Nuclei Studio.

.. note::
   Nuclei Studio 2025.10 has updated the content of the Welcome page.

When Nuclei Studio is launched for the first time, the ``Welcome`` page is displayed. This page provides quick entries to frequently used functions, including project creation, example project import, and software package (NPK) management, and integrates technical documentation links and tutorial videos provided by Nuclei to help developers get started quickly and master the development process.

To reopen the ``Welcome`` page later, select ``Help → Welcome`` from the menu bar.

|image23|


.. |image1| image:: /asserts/nucleistudio/intro/image2.png
   :alt: Incompatibility warning dialog when opening the workspace

.. |IMG_256| image:: /asserts/nucleistudio/intro/image3.png
   :alt: build-tools updated to version 4.4

.. |image2| image:: /asserts/nucleistudio/intro/image4.png
   :alt: Directory structure of GCC and Clang

.. |image3| image:: /asserts/nucleistudio/intro/image5.png
   :alt: Project support for GCC 13

.. |image4| image:: /asserts/nucleistudio/intro/image6.png
   :alt: Project support for Clang 17

.. |image5| image:: /asserts/nucleistudio/intro/image7.png
   :alt: Using RISC-V extensions when creating a project

.. |image6| image:: /asserts/nucleistudio/intro/image8.png
   :alt: RISC-V extension support in the project

.. |image7| image:: /asserts/nucleistudio/intro/image9.png
   :alt: RISC-V extension support in Nuclei Settings

.. |image8| image:: /asserts/nucleistudio/intro/image10.png
   :alt: RISC-V extension support in QEMU

.. |image9| image:: /asserts/nucleistudio/intro/image11.png
   :alt: Selecting the appropriate toolchain when creating a project

.. |image10| image:: /asserts/nucleistudio/intro/image12.png
   :alt: The Nuclei Studio version a component package is compatible with

.. |image11| image:: /asserts/nucleistudio/intro/image13.png
   :alt: The directory where QEMU 8.0 is located

.. |image12| image:: /asserts/nucleistudio/intro/image14.png
   :alt: Viewing a .elf file in the ELF file viewer

.. |image13| image:: /asserts/nucleistudio/intro/image15.png
   :alt: Viewing a .o file in the ELF file viewer

.. |image14| image:: /asserts/nucleistudio/intro/image16.png
   :alt: Changes to the Nuclei Settings page

.. |image15| image:: /asserts/nucleistudio/intro/image17.png
   :alt: Select C Runtime Library no longer exists in the new IDE

.. |image16| image:: /asserts/nucleistudio/intro/image18.png
   :alt: Nuclei Settings of a shared project (Arm)

.. |image17| image:: /asserts/nucleistudio/intro/image19.png
   :alt: Nuclei Settings of a shared project (RISC-V)

.. |image18| image:: /asserts/nucleistudio/intro/image20.png
   :alt: The work.nuworkspace file

.. |image19| image:: /asserts/nucleistudio/intro/image21.png
   :alt: Download page of the Nuclei Studio IDE package

.. |image20| image:: /asserts/nucleistudio/intro/image22.png
   :alt: Contents of the Nuclei Studio IDE archive

.. |image21| image:: /asserts/nucleistudio/intro/image23.png
   :alt: Double-click Nuclei Studio.exe to launch Nuclei Studio

.. |image22| image:: /asserts/nucleistudio/intro/image24.png
   :alt: Company logo

.. |image23| image:: /asserts/nucleistudio/intro/image25.png
   :alt: Nuclei Studio interface on first launch
