.. _advanceusage:

Nuclei Studio Advanced Features
===============================

At https://doc.nucleisys.com/nuclei_studio_supply we maintain an extensive and continuously growing collection of usage questions and case studies for Nuclei Studio and Nuclei Tools to help you use them more effectively. Feel free to take a look.

.. _ide_advanceusage_0:

Importing Projects Created by Older Versions
--------------------------------------------

Importing Old Projects Into Nuclei Studio 2023.10
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In Nuclei Studio 2023.10, the toolchain, SDK, and other components have changed significantly. To use a project created with an older version of Nuclei Studio, or an older SDK, in the new Nuclei Studio, follow the instructions in this section.

When you import a project created with an older version of Nuclei Studio into Nuclei Studio 2023.10 (for the detailed import procedure, see :ref:`Importing Old Projects in Nuclei Studio 2022.12 and Later <ide_advanceusage_7>`), or use a project created with an older SDK (that is, any SDK released before the Nuclei Studio 2023.10 release), the project is configured to use GCC 10. If the corresponding toolchain cannot be found, build errors and other problems occur, and the project does not work normally.

|image1|

There are two solutions: manually import the GCC 10 toolchain, or convert the project with the conversion tool shipped with Nuclei Studio 2023.10. The second solution is recommended because it converts the project more thoroughly to a format supported by Nuclei Studio 2023.10 and lets you use its latest features.



Manually Importing the GCC 10 Toolchain
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

For convenience, Nuclei Studio 2023.10 retains the GCC 10 configuration, but GCC 10 is not packaged with the IDE. To continue developing with GCC 10, import GCC manually.

Locate GCC 10 in the ``toolchain\gcc\`` directory of the old Nuclei Studio installation and copy its contents into the ``toolchain\gcc10\`` directory under the Nuclei Studio 2023.10 installation directory, then rebuild the project. The project should now build normally. However, Nuclei QEMU does not work with this method; if your project requires Nuclei QEMU, manually modify the corresponding QEMU debug configuration.

|image2|

.. _ide_advanceusage_3:

Converting a Project to Support GCC 13 with the Tool
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Nuclei Studio 2023.10 provides a quick conversion tool, ``Convert GCC 10 Project to GCC 13``, that makes it easier to import old projects. Right-click the project and select ``Convert GCC 10 Project to GCC 13`` from the context menu.

|image3|

After the project is converted, rebuild it. Nuclei Studio then builds the project with GCC 13, and features such as QEMU work normally.

|image4|

.. _ide_advanceusage_4:

Batch Converting Projects to Support GCC 13
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

You can also batch convert projects to support GCC 13 in Nuclei Studio 2023.10 and later versions.

|image5|

Open the conversion tool, select the projects you want to convert, and start the conversion.

|image6|

When the conversion is complete, the page displays the conversion results for each project.

|image7|

.. _ide_advanceusage_7:

Importing Old Projects in Nuclei Studio 2022.12 and Later
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Nuclei Studio 2022.12 optimized project import to make project sharing easier. After a project is exported from the IDE, double-click the ``.nuproject`` file to quickly import and open it in Nuclei Studio.

First, export the project in Nuclei Studio 2022.12: right-click the project and select Export.

|image8|

In the Export dialog, select ``General->File System`` and follow the wizard to export the project to the specified folder.

|image9|


|image10|


Next, import the project. The exported project contains a test.nuproject file; click this file to import the project into Nuclei Studio. For details, see :ref:`Import a Project via an Application Association File <ide_projectnew_8>`.

|image11|

Importing Old Projects in Versions Earlier Than Nuclei Studio 2022.12
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In Nuclei Studio 2023.10, the toolchain name was changed from ``riscv-nuclei-elf-gcc`` to ``riscv64-unknown-elf-gcc``, and the GCC version was upgraded from GCC 10 to GCC 13.

Starting with version 2020.08, Nuclei Studio upgraded its official toolchain from ``RISC-V Nuclei GCC (riscv-nuclei-elf-gcc)`` to ``GNU MCU RISC-V GCC (riscv-none-embed-gcc)``. Because the compiler prefix changed, projects created with IDE version 201909 or earlier must have their settings adjusted before they can be used in the new IDE. The following example uses a helloworld project generated with Nuclei Studio 201909 to describe the import procedure and the required settings changes:

-  Import the helloworld project generated with version 201909. For the detailed import procedure, see Section 5.2.

-  After importing the project, right-click it and select ``Properties`` to open the settings page. Select ``C/C++ Build -> Settings``, open the Toolchains tab, and change the Name drop-down option to ``RISC-V Nuclei GCC (riscv-nuclei-elf-gcc)``. Click Apply to save the change.

|image12|

-  Right-click the project again and select ``Clean Project``, then ``Build Project``.

.. _ide_extension_selector:

Extension Selector
--------------------

Overview
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Extension Selector is a modal dialog (1200x800) used to visually pick RISC-V ISA extensions, finally producing a ``-march`` string. It **does not compile**; it is only responsible for producing the march string, and whether the string is legal is ultimately decided by the compiler.
* It is a native UI implemented purely with SWT/JFace, not a browser shell.

How to Open
~~~~~~~~~~~

On the **Settings page** of the project wizard or project properties, click the **Select Extensions** button.

|image131|

.. Screenshot placeholder: location of the Select Extensions button on the Settings page

UI Composition
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The dialog is divided into left and right parts:

Left panel:

.. list-table::
   :header-rows: 1

   * - Area
     - Function
   * - Core selector
     - Select the target core. This is the only architecture-driven entry and determines RV32/RV64 and which extensions are available
   * - Search box
     - Search extensions by name or mnemonic
   * - Extension tree / card area
     - Show all extensions grouped by category; click to check
   * - Action buttons
     - Clear, select all, OK, Cancel, etc.

Right panel:

.. list-table::
   :header-rows: 1

   * - Area
     - Function
   * - ARCH preview
     - Shows in real time the ``-march`` / ``-mabi`` / ``-mtune`` produced by the current selection
   * - Full GCC Options
     - The complete GCC command line, which can be copied directly

|image132|

.. Screenshot placeholder: overall layout of the Extension Selector dialog (left: core selection and extension tree, right: ARCH preview)

- **Card colors and states**

Extension cards use colors to distinguish types:

.. list-table::
   :header-rows: 1

   * - Color
     - Type
   * - Blue
     - standard (standard extension)
   * - Orange
     - custom (custom/vendor extension)
   * - Purple
     - composite (composite extension, such as B, Zk, Zce)

A card has three states: unselected, selected, and **grayed out (not selectable)**.

Selecting Extensions
~~~~~~~~~~~~~~~~~~~~

1. **Select the core**: select the target core in the core selector on the left. This step determines the available range of all subsequent extensions.
2. **Browse and search**: browse in the extension area, or use the search box to locate by name.
3. **Check extensions**: click a card to check it. Checking triggers automatic propagation (see `Automatic propagation rules for selection`_).
4. **Check the preview**: observe whether the ``-march`` / ``-mabi`` / ``-mtune`` on the right meet expectations.
5. **Confirm**: click OK, and the result is written back to the project configuration.


.. note::

   When the Core Series is changed manually, the tool first **clears the extensions selected for the previous core**, then re-applies them according to the new core; if a preselected core is brought in from the Settings page when the dialog opens, the original extension combination of that core is retained.

- **Mutually exclusive groups (single choice)**

Some extensions are naturally mutually exclusive; only one in the same group can be kept, and selecting another prompts a replacement. The following three pairs of mutual exclusion are fixed at the code level:

.. list-table::
   :header-rows: 1

   * - Mutually exclusive group
     - Options (only one can be selected)
   * - Vector base
     - ``zve32x`` ``zve32f`` ``zve64x`` ``zve64f`` ``zve64d`` ``v``
   * - Vector length
     - ``zvl128b`` ``zvl256b`` ``zvl512b`` ``zvl1024b``
   * - DSP
     - ``xxldsp`` ``xxldspn1x`` ``xxldspn2x`` ``xxldspn3x``

There is also a **Clear Extensions** button: it keeps the base architecture letters (such as ``rv32i`` / ``rv64imac``) and clears all other extensions, making it easy to select again from scratch.

.. _automatic propagation rules for selection:

- **Automatic propagation rules for selection**

When you check an extension, the tool automatically handles its relationship with other extensions — this is the core value of this dialog. Understanding the following four rules will keep you from being confused by "I didn't check this, how did it get checked by itself":

.. list-table::
   :header-rows: 1

   * - Rule
     - Behavior
   * - **Dependency auto-check**
     - Selecting an item automatically brings in the extensions it depends on. For example, selecting Zcb / Zcmp / Zcmt automatically brings in Zca, because all three declare ``dependencies: ['zca']``
   * - **Composite extension expansion**
     - Selecting a composite extension expands it into its sub-extensions. For example, Zce expands into Zca, Zcb, Zcmp, Zcmt; on RV32 with ``f`` in the base architecture, Zcf is also added dynamically
   * - **Mutual exclusion and replacement**
     - Options within a mutually exclusive group exclude each other. When a conflicting item is selected, a **Replace** option is provided, and you decide whether to replace
   * - **Reverse dependency cascade on uncheck**
     - When you uncheck an item, other extensions that depend on it are unchecked as well. For example, unchecking the last vector compute extension (V or Zve*) cascades to uncheck vector crypto and the Zvl*b series, otherwise march would become an illegal combination

- **Filtering**

The UI provides triple filtering to quickly locate among the 80+ extensions:

.. list-table::
   :header-rows: 1

   * - Filter dimension
     - Description
   * - **Architecture**
     - Filter by RV32 / RV64. Some extensions are architecture-specific (for example, Zcf, Zclsd, Zilsd are RV32-only)
   * - **Series**
     - Filter by core series: N100 / N200 / N300 / N600 / N900 / N1000
   * - **Search**
     - Search by name or mnemonic

- **Why an extension card is not selectable**

A card is grayed out usually for the following reasons; hover the mouse over the card to see the specific reason:

.. list-table::
   :header-rows: 1

   * - Reason
     - Example
   * - Not applicable to the current architecture
     - Zcf, Zclsd, Zilsd, etc. are RV32-only
   * - Architecture prerequisite dependency not met
     - Zcd requires ``d`` in the base architecture; Zcf requires ``f``
   * - Not part of the current core series
     - The extension is not supported by the series of the current core
   * - Mutually exclusive with a selected item
     - Another item in the mutually exclusive group is already selected

- **march generation rules**

The ``-march`` previewed on the right is not a simple concatenation; it is folded and suppressed according to the specification. Understanding these rules explains why some checked extensions do not appear in the result:

1. **Base letters are ordered per the specification**: e.g. ``rv32imaf``.
2. **When zcmp / zcmt are selected, ``c`` is removed from the base architecture**: because the Zcm* series does not coexist with the C extension.
3. **Composite folding**: composite extensions such as B, Zk, Zkn, Zks, Zvkn, Zvks are folded for display.
4. **Implicit C suppression**: when the base architecture still contains ``c``, ``zca`` / ``zcf`` / ``zcd`` do not appear again.

**About rule 4**: on RV32+F, ``C`` itself equals all the instructions of Zca + ZCF, so writing ``zca`` or ``zcf`` again when the base architecture already contains ``c`` is redundant, not a missing feature.

**The actual effect of rule 2**: when Zce is checked on N300F (base architecture ``rv32imafc``), the result is

::

   rv32imaf_zca_zcb_zcf_zcmp_zcmt

That is, the ``c`` in the base architecture is removed and expressed explicitly by Zca, and Zcf is also explicitly kept. This is exactly the design intent of Zce — to replace the full C with the Zca subset.


Quick Start
~~~~~~~~~~~

From opening to generating the march string

1. Open the **Settings page** in the project properties: find it in the project → go directly to the **Nuclei Settings** page.
2. Click the **Select Extensions** button.
3. Select the target core in the **core selector** on the left — this step determines RV32/RV64 and which extensions are available.
4. Browse or search in the extension area and click a card to check it; to save effort, you can directly use the **Core Series** drop-down at the top to apply a preset.
5. Observe whether the **-march / -mabi / -mtune** preview on the right meets expectations (checking automatically propagates dependencies and expands composite extensions).
6. Click **OK**; the result is written back to the project configuration, which is equivalent to passing ``--config nuclei_archext=...`` on the command line.

Afterwards, the selected extensions are applied when building the project.

|image133|


.. _ide_advanceusage_13:

LST View
--------

Nuclei Studio 2024.06 integrates the LST View tool. LST View can be used on its own or invoked from the Trace tool or the GProf tool. It helps you view LST files and link them with the source code.

In Nuclei Studio, go to ``Window -> Show View -> Other`` and search for ``LST View`` in the Show View dialog.

|image13|

Open the LST View tool.

|image14|

LST View has a toolbar at the top with a search drop-down box for entering an Addr to search for, an Open File menu that opens a file selector for choosing the ``.lst`` file to open, and a Find menu for searching within LST View.

|image15|

Use the Open File menu to locate the lst file in the file selector. The file is usually located in the Debug directory after the project is built.

|image16|

After opening the file, you can search within it. When you select a line of text that contains a valid Addr, LST View uses that Addr to locate the corresponding source file and line number, opens the source file in the editor, and places the cursor on the corresponding line. This links the source file to the lst file so you can view the two together.

|image17|

.. _ide_advanceusage_17:

Code Coverage and Profiling
---------------------------

Nuclei Studio 2023.10 and later integrates `Eclipse Linux
Tools <https://github.com/eclipse-linuxtools/org.eclipse.linuxtools/blob/master/RELEASE_NOTES.md#eclipse-linux-tools-release-notes>`__, whose features have been partially optimized so that Nuclei
Studio projects can use the Code Coverage and Profiling related features. In Nuclei Studio
2024.06, these features were further optimized and upgraded to make them easier to use.

For tutorials on using Coverage, Profiling, and Call Graph, see :ref:`Using Coverage, Profiling, and Call Graph <ide_advanceusage_21>`.

For details about Eclipse Linux Tools, see
`Eclipse Linux Tools <https://github.com/eclipse-linuxtools/org.eclipse.linuxtools/blob/master/RELEASE_NOTES.md#eclipse-linux-tools-release-notes>`__

If you encounter any problems during use, check `https://github.com/Nuclei-Software/nuclei-studio <https://github.com/Nuclei-Software/nuclei-studio>`__ or submit an issue.

.. note::

   The **Nuclei System Technology WeChat Channel** contains a video on **How to Use Code Coverage and Profiling in Nuclei Studio**. Search for the **Nuclei System Technology WeChat Channel** in WeChat to view it.

About Code Coverage
~~~~~~~~~~~~~~~~~~~

The Code Coverage feature in Nuclei Studio relies on the gcov tool provided by the GCC compiler to view the code coverage of specified source files. It helps developers determine whether their test cases are sufficient and cover all branches and paths of the code under test.

In Nuclei Studio, build the file or folder you want to analyze with the ``--coverage`` or ``-coverage`` compile option. When the program runs on a real development board, the semihost feature reads and writes files on the host computer, so the required coverage files (gcda/gcno files) can be collected. Alternatively, use the `profiling library provided by Nuclei SDK <https://github.com/Nuclei-Software/nuclei-sdk/tree/master/Components/profiling>`__ to print the coverage data to the serial port; the IDE then parses the data and saves it to the host.

.. caution::
   - The compile option ``--coverage`` or ``-coverage`` should only be added to a specific application directory or source file, not to the entire project. Otherwise, the program consumes a large amount of memory at runtime and fails to run.
   - When the 2025.02-gcc 14.x or later compilers are used together with the Nuclei SDK Profiling library (<=0.8.0), the coverage feature does not work properly and no coverage information is produced. For the fix, see https://github.com/Nuclei-Software/nuclei-sdk/commit/5aaae0d5a7629013a235657ed3bce3dce18e8e0b

.. note::

   As of the Nuclei Studio 2025.10 release, the library implementation of Nuclei SDK 0.9.0 `Profiling/Coverage <https://github.com/Nuclei-Software/nuclei-sdk/tree/master/Components/profiling>`__ does not yet support the clang compiler. If you use the clang compiler for testing, an error is reported. This should work normally once Nuclei SDK adds the related support in a future release.

.. note::

   Due to the GCC version upgrade, projects created with the latest SDK may behave abnormally when the Code Coverage feature is enabled. This issue has been fixed in Nuclei Studio 2025.10.

   **Note**: This fix only supports SDK version 0.8.1 and above and is not backward compatible with older projects. For projects created with an older SDK, manually modify the configuration to adapt to the new version. Refer to the changes in the following GitHub commit and adjust your project accordingly: https://github.com/Nuclei-Software/nuclei-sdk/commit/5aaae0d5a7629013a235657ed3bce3dce18e8e0b

-  The ``.gcno`` file is generated when source code is compiled with the ``-ftest-coverage`` option of the GCC compiler. It contains information for reconstructing the basic block graph and assigning source line numbers to blocks.

-  The ``.gcda`` file is generated when an object file compiled with the ``-fprofile-arcs`` option of the GCC compiler runs. A separate ``.gcda`` file is generated for each object file compiled with this option. It contains arc transition counts, value profile counts, and some summary information.

In general, the ``--coverage`` or ``-coverage`` option alone instructs the compiler to produce the files described above. Note that ``*.gcda`` files are produced at runtime, so the runtime environment must support file reading and writing. Here we use semihosting: the files are written to the host through the semihost feature of OpenOCD.

.. note::

   When collecting coverage, compile with ``O0`` so that the coverage information is as accurate as possible.

For details about the Code Coverage feature, see

-  `Gcov Intro (Using the GNU Compiler Collection
   (GCC)) <https://gcc.gnu.org/onlinedocs/gcc/Gcov-Intro.html>`__

-  `Gcov Data Files (Using the GNU Compiler Collection
   (GCC)) <https://gcc.gnu.org/onlinedocs/gcc/Gcov-Data-Files.html>`__

-  `Code Coverage for Embedded Target with Eclipse, gcc and gcov \| MCU
   on
   Eclipse <https://mcuoneclipse.com/2014/12/26/code-coverage-for-embedded-target-with-eclipse-gcc-and-gcov/>`__

About Profiling
~~~~~~~~~~~~~~~

The Profiling feature in Nuclei Studio relies on the gprof tool in the GCC compiler and binutils to view the running time and call counts of functions in a specified file, as well as their call relationships. gprof helps identify program bottlenecks for performance optimization. It collects data while the program runs and generates a report showing the percentage of CPU time each function occupies and the call relationships between functions.

In Nuclei Studio, build the specified source files with the ``-pg`` compile option. When the program runs on a real development board, the semihost feature reads and writes files on the host computer, so the required coverage files (gcda/gcno files) can be collected. Alternatively, use the `profiling library provided by Nuclei SDK <https://github.com/Nuclei-Software/nuclei-sdk/tree/master/Components/profiling>`__ to print the coverage data to the serial port; the IDE then parses the data and saves it to the host.

.. note::
   The compile option ``-pg`` should only be added to a specific application directory or source file, not to the entire project. Otherwise, the program consumes a large amount of memory at runtime and fails to run.

Producing the ``gmon.out`` file requires compiler support, and the program must actually run on a board whose runtime environment supports file reading and writing before Profiling can produce useful results.

For details about the Profiling feature, see

-  `Introduction (GNU
   gprof) <https://sourceware.org/binutils/docs/gprof/Introduction.html>`__

-  `Using GNU Profiling (gprof) With ARM Cortex-M -
   DZone <https://dzone.com/articles/using-gnu-profiling-gprof-with-arm-cortex-m>`__

.. _ide_advanceusage_18:

About Call Graph
~~~~~~~~~~~~~~~~

Call Graph is a powerful tool that gives developers an intuitive view of the call relationships between functions or methods in a program. With Call Graph, developers can quickly identify frequently called functions, key entry points, and dependencies between functions. In Nuclei Studio, Call Graph obtains the program's call relationships mainly by analyzing Profiling data.

In Nuclei Studio, go to ``Window -> Show View -> Other``, search for ``Call Graph`` in the Show View dialog, and open the ``Call Graph`` tool. The ``Call Graph`` tool provides multiple views; the most commonly used are described below.

Radial View
^^^^^^^^^^^

This view shows the call relationships of the program. Double-click a parent node in the menu on the left, and the area on the right displays all call relationships starting from that parent node. You can also use the menu to view the selected call relationship in the other views.

|image18|

Tree View
^^^^^^^^^

Shows the call relationships, time consumption percentages, call counts, and other information for the program selected in Radial View. Select a function to view its parent nodes, child nodes, and other information.

|image19|

Level View
^^^^^^^^^^

Similar to Tree View, it shows the call relationships and call counts of the program.

|image20|

Aggregate View
^^^^^^^^^^^^^^

Shows the program's time consumption visually as a square diagram.

|image21|

.. _ide_advanceusage_21:

.. _ide_advanceusage_profiling:

Using Coverage, Profiling, and Call Graph
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Using Coverage, Profiling, and Call Graph in Nuclei Studio 2024.06 is straightforward. The following examples use Nuclei Studio 2024.06 and nuclei_sdk 0.6.0 to demonstrate two ways of using the Coverage, Profiling, and Call Graph tools.

Using via Serial Port
^^^^^^^^^^^^^^^^^^^^^

nuclei_sdk 0.6.0 and later versions include a ``Profiling demo to show how to use gprof and gcov`` test project. After installing nuclei_sdk 0.6.0 in Nuclei Studio, you can create this test project. For details about the ``Profiling demo to show how to use gprof and gcov`` test project, see `demo_profiling <https://doc.nucleisys.com/nuclei_sdk/design/app.html#demo-profiling>`__.

|image22|

After the project is created, set the ``-pg``, ``--coverage``, or ``-coverage`` compile option for the files or folders you want to analyze, then build the project.

.. note::
   The compile options ``-pg``, ``--coverage``, or ``-coverage`` should only be added to a specific application directory or source file, not to the entire project. Otherwise, the program consumes a large amount of memory at runtime and fails to run.

|profiling_options_in_ide|

In the Debug directory of the successfully built project, you can see that several ``.gcno`` files have been generated.

|image23|

After the project is built, run it under QEMU or debug it on a real development board. This example runs the program under QEMU; the Profiling information is output in the Nuclei Studio Console window. When debugging on a development board, the Profiling information appears in the serial port output.

|image24|

The output Profiling information must be parsed before Nuclei Studio can read it. Right-click in the Console window and select Select All from the context menu to select all output, then right-click again and select ``Parse and Generate HexDump``.

|image25|

Nuclei Studio then analyzes the output and stores the results in the corresponding files.

|image26|

Check the Debug directory of the project again; the corresponding ``.gcda`` files have been produced.

|image27|

Double-click a ``.gcda`` file to open the Gcov tool and view the analysis results for the application. The results show whether each file or method was executed during program execution, as well as data such as the code execution coverage ratio.

|image28|

Double-click a row in Gcov, and Nuclei Studio automatically opens the corresponding file and colors its code: green indicates code that was executed during program execution, and red indicates code that was not. Use the Gcov results to optimize the code accordingly.

|image29|

Code coverage also provides a histogram view of the data. Select the data item you want to view, click the histogram menu item, and configure it as needed.

|image30|

The code coverage histogram is then displayed in Nuclei Studio.

|image31|

Double-click the ``gmon.out`` file. A file selection dialog pops up, prompting you to select the elf file and ``*.lst`` file related to the ``gmon.out`` file. By default, the ``elf file`` and ``*.lst`` file in the corresponding project are filled in automatically based on the current ``gmon.out``. Click OK.

|image32|

The Gprof tool starts and shows the analysis results for the application, including the call relationships of files and methods.

Double-click a row in Gprof, and Nuclei Studio automatically opens the corresponding source file at the corresponding line. It also opens the LST View tool and locates the line by addr, linking Gprof, the source code, and the disassembly code so you can quickly understand the program structure and call relationships.

|image33|

Likewise, you can view a histogram of the profiling data in Nuclei Studio.

|image34|

When Gprof is opened, Nuclei Studio parses the program's call graph from the gmon.out file and generates a ``callgraph.out`` file. Double-click the ``callgraph.out`` file, or click the ``Open Call Graph View`` button in the Gprof toolbar, to start the Call Graph tool. For details on using Call Graph, see :ref:`About Call Graph <ide_advanceusage_18>`.

|image35|

Using via Semihosting
^^^^^^^^^^^^^^^^^^^^^

After installing nuclei_sdk 0.6.0 in Nuclei Studio, create a ``Profiling demo to show how to use gprof and gcov`` test project, this time selecting ``Enable Semihosting``. For details about the ``Profiling demo to show how to use gprof and gcov`` test project, see `demo_profiling <https://doc.nucleisys.com/nuclei_sdk/design/app.html#demo-profiling>`__.

|image36|

After the project is created, set the ``-pg --coverage`` compile option for the files or folders you want to analyze, then build the project.

|profiling_options_in_ide|

Also change ``gprof_collect(2);`` to ``gprof_collect(1);`` and ``gcov_collect(2);`` to ``gcov_collect(1);`` in the program (at the end of the main function in the test project). During execution, the results are then output as files through Semihosting.

|image37|

Build the project. In the Debug directory of the successfully built project, you can see that several ``.gcno`` files have been generated.

|image38|

After the project is built, run it under QEMU or debug it on a real development board.

|image39|

This example runs the program under QEMU. After the program finishes running, refresh the project; several new files appear under the project: ``*.gcda`` files and ``*.out`` files. View the results as described above.

|image40|

View the Code Coverage information of the application with the gcov tool in Nuclei Studio.

|image41|

View the Profiling information of the application with the gprof tool in Nuclei Studio.

|image42|

View the call relationship information with Call Graph in Nuclei Studio.

|image43|

.. _ide_advanceusage_43:

.. _ide_etrace:

Trace
-----

Trace is a powerful debugging technology that helps developers track and record key information during program execution, so they can effectively diagnose problems, optimize performance, and improve system stability.

Nuclei Studio integrates a Trace tool. Combined with the corresponding hardware and Nuclei OpenOCD, it lets you view Trace logs while debugging a project and troubleshoot problems together with the source code.

.. note::

   The **Nuclei System Technology WeChat Channel** contains a video on **How to Use the Trace Feature in Nuclei Studio**. Search for the **Nuclei System Technology WeChat Channel** in WeChat to view it.

.. note::

   For the Nuclei ETrace commands of OpenOCD, see the openocd.pdf manual under OpenOCD.

.. note::

   Nuclei Studio **2026.10** adds the **Trace bundle (Trace 2.0)** transport type, and adds the ability to **automatically read parameters from the CPU and fill them in**: when Trace Setting is opened, the plug-in automatically detects the Trace type; after acquisition (clicking Start Trace), the relevant Decode parameters (TS Size / Datatrace / Context Size / Decode Mode, etc.) are automatically read from the registers and filled in, usually without manual modification. See the relevant descriptions at the beginning of Trace Configuration and Trace Decoder Configuration below.

If you have problems during use, you can check the relevant content at `https://github.com/Nuclei-Software/nuclei-studio <https://github.com/Nuclei-Software/nuclei-studio>`__, or submit an issue to us.

Trace UI Overview
~~~~~~~~~~~~~~~~~

.. rubric:: Trace View

In Nuclei Studio, open the Show View dialog via ``Window->Show View->Other``, find the RV Trace->Trace menu item, and click it to open the Trace view.

|image44|

The Trace view consists of two parts: the Trace toolbar on top and the Trace record table below. The Trace toolbar provides the following items:

- **Trace setting**

Opens the trace configuration, where you configure Trace ATB2AXI Config Addr, Trace Buffer Base Addr, Trace Buffer Size in Bytes, and Trace Wrap.

- **Start trace/stop trace**

Starts or stops trace recording.

- **Trace clear**

Clears all trace settings on the hardware.

- **Dump trace file**

Dumps the trace file from the hardware.

- **Reload trace file**

Reloads the contents of the trace record table locally.

- **Clear viewer**

Clears the contents of the trace record table, as well as Trace Decode related configuration, such as the relationship between HartID and Thread.

- **Save trace log**

Saves the trace record table as a CSV file.

- **Toggle instruction stepping**

Opens the source code and disassembly code corresponding to the selected record.

- **Decode trace into flame**

Parses flame graph information from the Trace records.

- **step into previous line**

When a record is selected, jumps to the previous record and locates the corresponding source code and disassembly code.

- **step into next line**

When a record is selected, jumps to the next record and locates the corresponding source code and assembly code.

- **Search for Addr**

A search box for finding the trace record row with a given Addr.

- **search backward**

Views the previous result when there are multiple search results.

- **search forward**

Views the next result when there are multiple search results.

- **search exceptions or interruptions**

Views the next result when there are multiple search results.

- **Page**

Pagination controls. When there are many trace records, they are displayed across multiple pages for easier viewing.

The Trace record table displays the records generated after Nuclei Studio decodes the dumped trace file. When you click a record, Nuclei Studio automatically locates the corresponding source code and disassembly code.

- **Record:** record ID

- **CoreId:** Core ID, mainly used to distinguish between different Cores in multi-core scenarios

- **Addr:** instruction address

- **CPU Clock:** clock cycle count

- **Clock Diff:** clock cycle difference

- **Instruction Code:** instruction code in hexadecimal

- **Instruction:** instruction code

- **File:** the file where the source code corresponding to the instruction code is located

- **File Line:** the line number in the file where the source code corresponding to the instruction code is located

.. rubric:: Trace Configuration

Click trace setting on the Trace toolbar, and the Set Trace Configuration dialog pops up. The **Trace Mode** radio box at the top of the dialog is used to select the Trace type; the **Settings** area below holds checkboxes common to both modes; the remaining configuration items differ according to the selected mode and are introduced respectively below.

.. note::

   In Nuclei Studio 2026.10 and later, Trace supports two transport types, **Bundle (Trace 2.0)** and the traditional **ATB2AXI (Trace 1.0)**, and adds the ability to **automatically read parameters from the CPU and fill them in**. When the Trace Setting dialog is opened and the debug session is connected to the target (the target is in the halt state), the plug-in reads registers such as ``mcfg_info`` / ``etrace_info`` through GDB to automatically detect the Trace type supported by the current CPU: the **Trace Mode** radio box is selected automatically based on the detection result — ``mcfg_info`` bit 20 = 1 means ATB2AXI is supported; otherwise it is judged based on ``etrace_info`` bit[8:1]: 0x20 → Bundle, 0x00 → ATB2AXI. If no development board is connected, the software default value is used.

   (Here "Bundle" refers to the Trace 2.0 transport type; the usage of packaging one acquisition result into a single bundle file for offline playback is described in the Trace bundle entry of the 2026.10 release notes.)

   For Bundle mode, the Decode parameters required for acquisition, such as TS Size / Datatrace / Context Size / Decode Mode, are automatically read from the registers and filled in by the plug-in after clicking **Start Trace** to send the configuration command (see Trace Decoder Configuration below for details).

**Common settings (Settings, identical for both modes)**

- **Check core support for Trace:** if checked, whether the CPU supports the Trace feature is checked before sending Trace commands; if not checked, whether the CPU supports Trace is ignored when sending Trace commands.

- **Trace need to be configured:** check this if the Trace module needs to be configured. If it has already been configured elsewhere, do not check it. For example, in the multicore SMP/AMP case, there is only one Trace module on the SoC; assuming one core has already checked and configured it, the other cores must not check it, or if the configuration was done in C code or somewhere else, do not check it either.

**ATB2AXI Trace (Trace 1.0)**

When Trace Mode selects ATB2AXI Trace, you only need to configure the Trace Module Configuration area:

|tracecfg-atb|

- **Trace ATB2AXI Config Addr:** the base address of the ATB2AXI module controller, e.g. 0x10000000.

- **Trace Buffer Base Addr:** the start address for storing trace records. For example, for a certain SoC: in flashxip mode, ilm (0x1c000000) is used as the cache buffer; in sramxip mode, dlm (0x08010000) is used as the cache buffer.

- **Trace Buffer Size in Bytes:** the size of the Buffer storing trace records, in bytes, e.g. 0x10000.

- **Trace Wrap:** when checked, it shows "Trace will be wrap back from Trace Base Address", meaning automatic overwrite is allowed; when the Buffer is full, records are overwritten again from the beginning.

**Trace bundle（Trace 2.0）**

When Trace Mode selects Trace bundle, the Trace Module Configuration area uses the Bundle base address instead, and an additional Trace Bundle Configuration area appears:

|tracecfg-bundle|

- **Trace Bundle Config Addr:** the base address of the configuration registers in Bundle mode, e.g. 0x10060000.

- **Trace Buffer Base Addr:** the start address for storing trace records; the meaning is the same as in ATB2AXI mode.

- **Trace Buffer Size in Bytes:** the size of the Buffer storing trace records, in bytes; the meaning is the same as in ATB2AXI mode.

- **Trace Wrap:** allows automatic overwrite; when the Buffer is full, records are overwritten again from the beginning; the meaning is the same as in ATB2AXI mode.

- **Core Mask:** (Trace Bundle Configuration area) core mask; bits 16~1 correspond to the respective cores. Check the cores for which Trace needs to be collected (for single core, check bit 1).

- **Timestamp Src:** timestamp source, e.g. 0: none-timestamp means no timestamp; **Div:** timestamp division, e.g. 0: 1x.

- **Datatrace:** data trace feature configuration, including has-store, has-load, has-value, has-addr, and the datatrace-en enable checkbox.

.. rubric:: Trace Decoder Configuration

After clicking Dump trace file, the Set current debug hart configuration dialog pops up, used to configure the trace decoder parameters. The Local trace related files area in the upper part of the dialog is common to both modes, and the Hart decoding configuration area in the lower part differs by mode; they are introduced respectively below.

.. note::

   Starting from Nuclei Studio 2026.10, parameters such as **TS Size**, **Datatrace**, **Context Size**, and **Decode Mode** in Hart decoding configuration support **automatic reading from the CPU and filling in** (that is, the "automatically read from the CPU and fill in parameters" feature):

   - **ATB2AXI (Trace 1.0)**: they are read from the ATB2AXI registers and filled in during the Trace Setting detection phase; among them Context Size is fixed to 0 and Decode Mode is fixed to ``0x00: etrace-v1.0``.
   - **Trace bundle (Trace 2.0)**: after clicking **Start Trace** to send the trace config command, the plug-in reads them from the Bundle configuration registers and fills them in; Decode Mode is also selected automatically according to the Bundle version number: v1.0.0 → ``0x10``, v1.1.0 / v1.2.0 / v1.3.0 → ``0x11``, v1.4.0 and newer → ``0x12``.

   When no development board is connected, the software default values are used. Manual modification is generally unnecessary; if fine-tuning is needed, you can override it directly in the UI.

**Local trace related files (identical for both modes)**

- **ELF File Path:** the path of the elf file executed when the trace is produced.

- **Trace File Path:** the path of the trace file to be parsed.

- **Objdump Path:** the trace decode process needs the objdump tool, so the path of the objdump tool to be used must be specified here.

**ATB2AXI Trace（Trace 1.0）**

|tracedec-atb|

- **Selected Project:** the current project name and its Trace mode, e.g. u900_helloworld [ATB2AXI Trace].

- **SrcID/CoreID(-srcid=):** corresponds to the HartID to which the trace belongs; the default is 0 for a single-core project.

- **Trace Data Align Size(-tdasize=):** trace data alignment size, generally aligned with the trace output bit width of the hardware; the defaults are 8, 32, 64 (64 in the figure).

- **Decode Mode(-decodemode=):** fixed to ``0x00: etrace-v1.0`` for ATB2AXI (Trace 1.0).

- **Decode Limit:** the limit on the number of trace decode records, ranging from 1 to 5000000, with a default of 5 million; the more records, the higher the requirements on the user's PC.

**Trace bundle（Trace 2.0）**



|tracedec-bundle|

- **Selected Project:** the current project name and its Trace mode, e.g. u900_helloworld [Trace bundle].

- **SrcID(-srcid=):** corresponds to the HartID to which the trace belongs; the default is 0 for a single-core project.

- **Trace Data Align Size(-tdasize=):** in Bundle mode it is filled in automatically by the plug-in (8 in the figure) and cannot be modified.

- **Decode Mode(-decodemode=):** the default is 0; since 2026.10 it is selected automatically according to the Bundle version number (``TRTRACEBUNDLEVERSION`` at Trace Config + 0xE00): v1.0.0 selects ``0x10`` (tracebundle-v1.0.0), v1.1.0 / v1.2.0 / v1.3.0 select ``0x11``, v1.4.0 and newer select ``0x12``; it can be overridden manually.

- **Feature checkboxes (has-srcid / has-timestamp / has-store / has-load / has-value / has-addr / has-csr / has-amo / has-zcmp):** used to mark the features contained in the trace data; among them has-store / has-load / has-value / has-addr are determined automatically by the Datatrace configuration in Trace Bundle Configuration during acquisition.

- **TS Size(-tssize=):** timestamp width, from ``trTimestampWidth`` (bit[7:0]) at Trace Config + 0x4E04; when it is 0, it falls back to bit[29:24] at +0x4040; the default is 64.

- **Datatrace(-datatrace=):** data trace width, from ``trIndexWidth`` (bit[31:16]) at Trace Config + 0x4E00; the default is 0.

- **Context Size(-contextsize=, the 10th parameter of decode):** context width, from ``trContextWidth`` (bit[15:8]) at Trace Config + 0x4E04; the default is 0.

- **Decode Limit:** the limit on the number of trace decode records, ranging from 1 to 5000000, with a default of 5 million; the more records, the higher the requirements on the user's PC.

Using Trace
~~~~~~~~~~~

.. note::

   Whether you use **ATB2AXI (Trace 1.0)** or **Bundle (Trace 2.0)**, the following acquisition / Dump / Decode flow is the same; the differences only lie in the configuration and decoding parameters:

   - In Trace Configuration: select Trace bundle as the Trace Mode, fill in **Trace Bundle Config Addr** (replacing Trace ATB2AXI Config Addr in ATB2AXI mode), and configure Core Mask, Timestamp Src, Datatrace, etc. in the Trace Bundle Configuration area as needed; the remaining configurations such as Buffer and Wrap are the same.
   - In Trace Decoder Configuration: the decode parameter UI differs by mode — ATB2AXI mode has SrcID/CoreID, Trace Data Align Size, and Decode Mode; Bundle mode adds feature checkboxes and parameters such as **TS Size** / **Datatrace** / **Context Size**, most of which are filled in automatically by the plug-in (see the per-mode descriptions above for details).

   Therefore, the operation steps below, which use a single core as an example, apply to both modes.

When using the trace feature, you must send the Trace commands to the hardware through Nuclei OpenOCD or Dlink while the project is being debugged. Currently, with OpenOCD, Trace recording can be performed for single-core, multicore SMP, and multicore AMP applications, while Dlink only supports trace recording for single-core applications.

The following example uses OpenOCD to demonstrate the Trace feature.

Using Trace in a Single-Core Application
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This document does not describe how to obtain the Nuclei-licensed CPU and the related supporting hardware or how to set up the hardware environment. Create the corresponding project and make sure it can run and debug on the hardware. The following example illustrates the process in a test environment we built ourselves.

In this example, we create a U900 single-core application named test from the demo timer template project and run it in FLASHXIP mode.

|image47|

You can record the trace of the entire application run, or only the trace between two Debug breakpoints. After entering Debug mode, open the Trace view.

|image48|

Open the Trace Configuration, configure the trace information, and click Save. If you do not want to save the configuration, close the window.

|image49|

After Trace is configured, set two breakpoints, one as the Trace start point and one as the Trace end point. When the program stops at the start-point breakpoint, click the ``start trace`` button and continue debugging (such as stepping or running). When the program stops at the end-point breakpoint, click the ``stop trace`` button to end Trace.
This is only one way to use Start/Stop Trace; adapt it to your needs. When the trace ends (in multi-core scenarios, make sure Trace has ended on every CPU), click the ``Dump trace file`` button to download the trace file from the hardware to the local machine. By default, the downloaded trace file is stored in the debug directory under the project directory as ``<projectname>.trace``.

|image50|

After the trace file is downloaded, Nuclei Studio pops up a ``Set current debug hart configuration`` dialog.

|image51|

Fill in the correct information in the dialog (the HartID must be the hartid of the corresponding Thread) and confirm. Nuclei Studio then parses the trace file and generates the trace record table. Select any record in the table, and Nuclei Studio automatically finds the source code and disassembly code and locates the corresponding line (because the disassembly code and the source code open in the same view, move the disassembly code to another view yourself).

|image52|

.. _ide_ide_trace_exceptions:

.. note::

   Querying interrupts and exceptions is a new feature in Nuclei Studio 2025.10.

If a record in the Trace list contains an interrupt, the background color of that record turns green; if it contains an exception, the background color turns yellow. This helps you quickly distinguish interrupts from exceptions.

|image122|

Click search exceptions or interruptions to view all interrupts or exceptions in the current project.

|image123|

Double-click an interrupt or exception, and the Trace list automatically jumps to that record. Hover the mouse over the record to display its detailed information.

|image124|

You can also double-click the ``<projectname>.trace`` file to view the trace file as text.

|image53|


Using Trace in an SMP Multi-Core Application
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Using trace in an SMP multi-core application is similar to the single-core case. The difference is that in an SMP multi-core Debug session, all threads share one Trace Configuration, and you must select different Threads to ``start trace/stop trace`` for the individual CPU harts. In the Debug view, click a Thread, then click ``trace setting`` in the Trace toolbar to set up the Trace Configuration.

|image54|

In the Debug view, switch between Cores by clicking different Threads. As shown below, clicking Thread #1 or the function name under Thread #1 selects Core 0 in the SMP multi-core application, and you can enable or disable Trace for Core
0. Once any Core has performed the start trace operation, the Trace Configuration is set in the hardware, and the other cores do not set it again when they perform ``start trace``.

|image55|

Similarly, click Thread #2 or the function name under Thread #2 in the Debug view to switch to Core 1 and perform the ``start trace/stop trace`` operations.

|image56|

In an SMP multi-core application, the ``dump trace file`` command succeeds only after all Cores have performed ``stop trace``. Only one copy of the Trace file needs to be downloaded. When decoding the trace file, set the Hart ID correctly to parse the trace record table for each core. As shown below, when ``HartID=0``, you can view the Trace records corresponding to Core 0.

|image57|

Similarly, when ``HartID=1``, you can view the Trace records corresponding to Core 1.

|image58|

Using Trace in an AMP Multi-Core Application
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Using trace in an AMP multi-core application is also similar, and the trace configuration is shared as well: different threads share one trace configuration, but you can ``start trace/stop trace`` for each core individually through its thread. As shown below, in the Debug view, click ``Thread #1`` or the function name under ``Thread #1`` to switch to ``Core 0`` in the AMP multi-core application, then click ``trace setting`` in the Trace toolbar to set up the Trace Configuration for Core 0.

|image59|

In the Debug view, click ``Thread #2`` or the function name under ``Thread #2`` to switch to ``Core 1`` in the AMP multi-core application, then click ``trace setting`` in the Trace toolbar to set up the Trace Configuration for ``Core 1``. Because the trace configuration is shared in an AMP multi-core application, uncheck ``Trace need to be configured`` here so that the trace feature is used without applying new settings.

|image60|

After the Trace Configuration is set, switch between Cores through the Threads in the Debug view to perform the ``start trace/stop trace/dump trace file`` operations. Note that the Core for which the Trace Configuration is set must ``start trace`` first, so that the configuration is written to the hardware; only then can the other Cores perform the ``start trace/stop trace/dump trace file`` operations normally.

In an AMP multi-core application, make sure all Cores have performed ``stop trace`` before executing ``dump trace file``. Otherwise, one Core may dump the trace file while the other Cores are still recording, and the resulting Trace file will not match expectations. Each project application must dump its own copy of the trace file, although the contents of the dumped files are identical. When decoding the trace file, also set the ``Core Hart ID`` correctly so that the corresponding trace record table can be parsed. The remaining operations are the same as described above.

Viewing Offline Trace
^^^^^^^^^^^^^^^^^^^^^

If you have obtained a trace file through the command line or other means, open ``Set Current Debug hart Configuration``, configure the parameters as required, and the trace tool in Nuclei Studio parses the trace file.

|image61|

.. _ide_ide_trace_headless:

Using Trace in Headless Mode
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Besides decoding trace in the Trace view, Nuclei Studio also provides a headless trace decoding application, ``org.riscvstudio.ide.tools.trace.headless``. It uses the same options as ``dqr`` (see :ref:`TraceDecoder Decoding Trace Data <tracedecoder_decoding_trace_data>`), but it does not open the Nuclei Studio workbench, so it can be used in scripts and CI pipelines to decode trace files in batch.

Run the following command in the Nuclei Studio installation directory. On Windows:

.. code-block::

    <NucleiStudio>\eclipsec.exe -noSplash -data <workspace> ^
        -application org.riscvstudio.ide.tools.trace.headless ^
        -t <projectname>.trace -e <projectname>.elf -decodemode=0x11

On Linux:

.. code-block::

    <NucleiStudio>/eclipse -noSplash -data <workspace> \
        -application org.riscvstudio.ide.tools.trace.headless \
        -t <projectname>.trace -e <projectname>.elf -decodemode=0x11

The commonly used options are as follows. They are the same as the items in the ``Set current debug hart configuration`` dialog, so fill them in the same way as in the IDE:

.. list-table::
   :header-rows: 1

   * - Option
     - Description
   * - ``-t <tracefile>``
     - Trace file to be decoded, for example ``<projectname>.trace``
   * - ``-e <elffile>``
     - ELF file executed when the trace is produced, for example ``<projectname>.elf``
   * - ``-od <objdump>``
     - Objdump tool used for decoding; point it to ``<NucleiStudio>/toolchain/gcc/bin/riscv64-unknown-elf-objdump``
   * - ``-srcid=<n>``
     - Hart ID to be decoded; the default is 0
   * - ``-tdasize=<n>``
     - Trace Data Align Size in bits: 8, 32, or 64; the default is 8
   * - ``-tssize=<n>``
     - TS Size, that is, the timestamp width in bits; the default is 13
   * - ``-decodemode=<n>``
     - Decode Mode, for example ``0x00`` for ATB2AXI (Trace 1.0) and ``0x11`` for Trace bundle; the default is 0
   * - ``-datatrace=<n>``
     - Datatrace, that is, the data trace index width; the default is 0
   * - ``-contextsize=<n>``
     - Context Size in bits; the default is 0
   * - ``-freq=<n>``
     - CPU frequency in Hz; the default is 0
   * - ``-o <outfile>``
     - Write the decoding result to a file instead of printing it to the console
   * - ``-analytics``
     - Print the decode statistics, such as the number of decoded instructions

For example:

.. code-block::

    <NucleiStudio>\eclipsec.exe -noSplash -data D:/ws_trace ^
        -application org.riscvstudio.ide.tools.trace.headless ^
        -t D:/work/test/Debug/test.trace ^
        -e D:/work/test/Debug/test.elf ^
        -od <NucleiStudio>\toolchain\gcc\bin\riscv64-unknown-elf-objdump ^
        -tdasize=8 -tssize=13 -srcid=0 -decodemode=0x11 ^
        -o D:/work/test/Debug/trace.txt

The decoding result is printed as text, the same as the text exported by the IDE; with ``-o <outfile>``, it is written to the specified file instead.

.. note::

   - The application always returns the exit code 0, so check the output instead: the decoding succeeds when the output contains ``Trace:`` / ``File:`` / disassembly lines and contains no ``Error:``.
   - If the trace format of the board is unknown, try the decode modes in turn (``0``, ``0x11``, ``0x10``, ``0x12``, ``1``, ``2``, ``3``) and use the first one that produces records.
   - The headless application outputs text only. To obtain a flame graph, use the IDE (see :ref:`Using Flame View with Trace <ide_ide_trace_flame>`).

.. _ide_ide_trace_flame:

Using Flame View with Trace
~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. note::

   In Nuclei Studio 2025.10, we introduced the Flame View feature, which clearly presents the call stack and time consumption during program execution through a visual flame graph, enabling developers to analyze performance hotspots more efficiently and accelerate troubleshooting.

Trace inherently records the program execution process, so it is well suited for parsing into a flame graph. Assuming you have already obtained the ``<projectname>.trace`` file, click the ``Decode trace into flame`` button.

If the ``<projectname>.trace`` file has not been parsed yet, the Trace parsing configuration page pops up first (see the previous sections for the configuration items). Complete the configuration and click ``Decode`` to start parsing.

|image125|

At the same time, the IDE opens the Flame View import wizard, which prompts that the corresponding ``<projectname>.trace`` file is about to be generated. Once the file is generated, double-click it to import it into Flame View for visual analysis. The wizard asks you to enter the current CPU operating frequency (for example, 50 MHz in this test) so that the timing information can be restored accurately.

|image126|

If the ``<projectname>.trace`` file has already been parsed, the corresponding trace data is extracted directly from the existing Trace list, and the Flame View import wizard pops up immediately, skipping the repeated parsing step.

|image127|

After the Trace list is parsed and the ``<projectname>.gtef`` file is generated, the IDE automatically prompts that the operation is complete.

|image128|

A ``<projectname>.gtef`` file now exists in the Debug directory. Double-click the file to view the flame graph of the project. **Note**: if the ``<projectname>.gtef`` file is updated, double-click the file again to re-import it into Flame View. For details about the Flame View feature, see :ref:`Using Flame View <ide_flame_view>`.

|image129|

.. _ide_flame_view:

Flame View
------------

Flame View is an intuitive and efficient performance analysis tool used to visualize the execution call stack and time distribution of programs in embedded systems. By converting complex trace data into a hierarchical stacked graph, Flame View helps developers quickly identify hotspot functions, analyze execution paths, and locate performance bottlenecks.

The ``*.gtef`` file is a file format defined by us in the IDE specifically for the Flame View tool. Currently, in the IDE, a ``*.gtef`` file can be parsed from Trace data (see :ref:`Using Flame View in Trace <ide_ide_trace_flame>`), and a ``*.gtef`` file can also be produced directly by Nuclei Model (see :ref:`Using Flame View in Nuclei Model <ide_nuclei_model_flame>`).

If you already have a ``*.gtef`` file, you only need to double-click the file to start the Flame View tool. First, a guide prompt pops up, informing the user that the IDE will import the ``*.gtef`` file into the Traces directory.

|image115|

At the same time, the IDE opens the Flame Chart view and the Flame Graph view.

|image116|

The Flame Chart view shows function-related information in list form, such as start time and execution time consumption.

|image117|

The Flame Graph view shows data such as the execution time, call hierarchy, and execution time consumption of each function in the program in the form of a flame graph. In the Flame Graph view, users can use ``A D W S`` to zoom the flame graph in and out to view more detailed information.

|image118|

When the mouse clicks a segment in the flame graph, more detailed information about that segment is displayed.

|image119|

Through the flame graph, users can understand the execution and time consumption of the program, and quickly identify hotspot functions, analyze execution paths, and locate performance bottlenecks.

The ``*.gtef`` file can also be displayed with Google's open-source tool Perfetto Trace Viewer. Open ``https://ui.perfetto.dev/``, click ``Open trace file``, find the ``*.gtef`` file generated in the project, and manually load the json file into Perfetto.

|image120|

In the generated flame graph, users can use ``A D W S`` to zoom the flame graph in and out to view more detailed information.

|image121|


.. _ide_adv_rvprof:

Using RVProf
------------

.. note::

   Starting with Nuclei Studio 2025.10, the RVProf feature is supported on Windows, with the same usage as on Linux.

RVProf is a performance analysis tool developed by Nuclei System Technology for the CPU cycle model. Nuclei Studio has supported RVProf since version 2024.02.dev. Using RVProf involves three steps: the Cycle model tool runs the code and produces a ``.rvtrace`` file; the RVProf tool parses the ``.rvtrace`` file into a ``.json`` file; and Google's open-source Perfetto Trace Viewer parses and displays the ``.json`` file. Because the CPU cycle model is currently only available for Linux, this document demonstrates the feature in a Linux environment.

If you encounter any problems during use, check `https://github.com/Nuclei-Software/nuclei-studio <https://github.com/Nuclei-Software/nuclei-studio>`__ or submit an issue.

Test Environment
~~~~~~~~~~~~~~~~

The CPU cycle model places high demands on the hardware at runtime. It runs better on systems with four or more cores, and using it in a virtual machine is generally not recommended. For a better experience, this test was performed on a workstation.

|image62|

Preparing the Test NPK Packages
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Currently, this feature requires test packages in Nuclei Package (NPK) format. Install the related packages into Nuclei Studio; for the installation procedure, see the NPK package sections of the Nuclei Studio manual. Because the RVProf test packages are not public, contact us to obtain them.

-  cymodel.zip: the NPK Tools package for cymodel

-  rvprof.zip: the NPK Tools package for RVProf

-  Rvprof helloworld.zip: the test demo NPK App package

Creating the RVProf Test Project
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Before creating a project, check in Nuclei Package Management that the NPKs are installed correctly. Because the test demo depends on nuclei_sdk, sdk-nuclei_sdk must also be installed first, as shown below:

|image63|

Then create a test project. In the project creation wizard, go through ``New Nuclei RISC-V C/C++ Project -> sdk-nuclei_sdk@0.5.0 -> next``. On the project configuration page, enter the project name, select Project Example ``rvprof helloworld@app-nsdkrvprof_helloworld``, and set Nuclei RISC-V Core to ``N307FD`` (the core must match the CPU cycle model).

|image64|

Under Project Example, select the Rvprof helloworld project from the imported demo NPK App, then click Next to complete the project creation.

|image65|

The created test project contains an additional ``test_debug_rvprof.launch`` file with the RVProf configuration, as shown below. The Cycle Model timeout value sets the Cycle Model timeout. Because Cycle Model takes a long time to run, set a short timeout for a relatively simple project so that the Cycle Model run is interrupted promptly when the time is up. The timeout in RVProf serves a similar purpose.

|image66|

Viewing the RVProf Results
~~~~~~~~~~~~~~~~~~~~~~~~~~

After the project is created, select ``test_debug_rvprof.launch`` in the Launch Bar and click the run button in the toolbar. Nuclei Studio then completes the following tasks in sequence and displays the final results in Perfetto Trace Viewer.

-  Build the project code

-  Start Cycle Model and produce the trace file

-  Start RVProf to parse the trace file and generate the json file

-  Start Perfetto Trace Viewer to display the results

Cycle Model startup and log output

|image67|

perfetto starting the local service

|image68|

The official address of Perfetto Trace Viewer is https://ui.perfetto.dev/. By default, Nuclei Studio tries to open https://ui.perfetto.dev/ and automatically loads and parses the json file. If the site cannot be opened due to network issues (it is an overseas server), Nuclei Studio starts a local Perfetto Trace Viewer service and automatically opens localhost:5000/. In this case, manually load the ``Debug/test.json`` file under the project directory. The trace results are then displayed in Perfetto Trace Viewer.

Nuclei Studio starts a web service locally and opens Perfetto Trace Viewer at the same time.

|image69|

Click Open trace file, locate the json file generated in the project, and load it manually into Perfetto Trace Viewer.

|image70|

You can now view the RVProf trace results in Perfetto Trace Viewer. Use the ``W/A/S/D`` keys to navigate and view more detailed information.

|image71|

.. _ide_nuclei_nice_wizard:

Nuclei NICE Wizard
------------------

.. note::

   The **Nuclei System Technology WeChat Channel** contains a video on **Nuclei NICE Wizard**. Search for the **Nuclei System Technology WeChat Channel** in WeChat to view it.

Nuclei NICE Wizard is a tool integrated into Nuclei Studio that simplifies and accelerates the creation of NICE (custom instruction extensions) and VNICE (vectorized custom instruction extensions) instructions. Through a graphical interface, you can quickly configure custom instructions and generate the required code framework, enabling hardware acceleration of specific application algorithms:

- **Simplified development process**: reduces the time from concept to implementation of custom instructions.

- **Improved efficiency**: improves the execution efficiency of applications by generating optimized instruction code.

- **Easy integration**: the generated code can be integrated directly into existing projects.


Creating a .nice File and Opening Nuclei NICE Wizard
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Open the target project in Nuclei Studio, create a ``*.nice`` file (for example aicc.nice) in the project root directory, and double-click it to open Nuclei NICE Wizard.

|image-nice-1|

|image-nice-2|

Adding an Instruction
~~~~~~~~~~~~~~~~~~~~~

Click ``Add...``, modify the instruction content as needed, and click ``save`` in the upper right corner.

The following example creates two instructions. The instruction selected on the left turns gray, and its content is displayed on the right.

|image-nice-3|

Deleting an Instruction
~~~~~~~~~~~~~~~~~~~~~~~

Select the instruction on the left, click Remove, and confirm the deletion.

|image-nice-4|

Modifying an Instruction
~~~~~~~~~~~~~~~~~~~~~~~~

Select the instruction on the left. After you modify the instruction content, the save and discard buttons in the upper right corner turn red; click them to save or discard the changes.

|image-nice-5|

File Generation
~~~~~~~~~~~~~~~

Define the save locations of the insn.h file (the inline assembly header) and the nice.cc file (the instruction implementation logic), then click Save and Generate File to generate the files.

|image-nice-6|

|image-nice-7|

|image-nice-8|

NICE Instruction Template Description
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

|image-nice-9|

A single instruction template is shown in the figure above:
 * opcode: custom-0, custom-1, custom-2, or custom-3
 * funct3: 3-bit function field, usually used to distinguish between different types of instructions.
 * funct7: 7-bit function field, which can be used to further subdivide instruction types or provide additional function options.
 * rd: return value register or type (for example void, int, vint8m8_t, etc.).
 * rs1, rs2: input source registers or types.

Instruction Content Editing Description
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

|image-nice-10|

As shown above, the Instruction content area displays the default content.

  * **Instruction name**: the instruction name. The naming rules are as follows:

      * **Letters and digits**: the function name can contain letters ``(A-Z, a-z)`` and digits ``(0-9)``, but cannot start with a digit.

      * **Underscore**: underscores ``_`` can be used in the function name to improve readability, especially in multi-word combinations. For example, ``get_user_name`` is a valid function name; ``<  , >  , ...  , ?  , /`` are not allowed in a function name.

      * **Special characters**: except for the underscore, other special characters such as ``! , @ , # , $ , % , ^ , & , * , ( , ) , { , } , [ , ] , \ , : , ; ,`` are not allowed.

      * **Keywords**: the function name cannot be a C language keyword or reserved word, such as ``int , char , float , double , if , else , while , for , return``.

  * **Function name**: the function name. When not checked, the generated function name is the instruction name. The naming rules are the same as for ``Instruction name``.

  * **funct7**: corresponds to the ``funct7`` of the template, and can be set by checking the corresponding Binary items.

  * **funct3**: corresponds to the ``funct3`` of the template, and can be set by checking the corresponding Binary items.

  * **Return Value Type**: corresponds to the rd of the template. Click Edit Type to set it, for example to void.

  * **Number of Function Parameters**: the number of parameters. You can set the types of the input parameters rs1, rs2, and rs3 (rs3 serves as both a parameter and a return value).

      * When the number of parameters is 0, Edit Type cannot be set. rs1 and rs2 can be assigned registers below; if rd is of void type, rd can also be assigned a register below.

      * When the number of parameters is 1, Edit Type can set the rs1 type. rs2 can be assigned a register below; if rd is of void type, rd can also be assigned a register below.

      * When the number of parameters is 2, Edit Type can set the rs1 and rs2 types. If rd is of void type, rd can also be assigned a register below.

      * When the number of parameters is 3, Edit Type can set the rs1, rs2, and rs3 types.

.. _ide_nuclei_model_debugger:

Using Nuclei Model Debugger
-------------------------------

Nuclei Model Debugger is a debugging and running tool developed for the upgraded Nuclei Near Cycle Model.

Starting with Nuclei Studio 2025.10, Nuclei Near Cycle Model provides richer features: it can debug and run programs and accepts custom parameters. To make these features easier to use, the Nuclei Model Debugger was developed based on the QEMU Debugger feature.

Create a test project and build it. In the Nuclei Studio main menu, click ``Run``, then ``Run Configurations`` or ``Debug Configurations``. This example uses Debug: click ``Debug Configurations``.

|image104|

In the ``Debug Configurations`` dialog, find ``GDB Nuclei Model riscv Debugging``.

|image105|

Double-click ``GDB Nuclei Model riscv Debugging``, and Nuclei Studio creates a new Nuclei Model Debugger configuration page where you can configure the command parameters for Model Debug.

|image106|

The values configured on the ``Debugger`` page must match the project.

|image107|

- **Nuclei RISC-V Core** The CPU core, which must match the program
- **Download** Program download mode
- **Nuclei SMP Count CPU** Number of cores
- **RVV length** RISC-V vector extension
- **Other Extensions** Other extensions

If ``Enable Nuclei Model RVTrace`` is checked and its path is configured, a ``*.rvtrace`` file is generated when the program runs.

In ``More options``, you can add parameters supported by Nuclei Model. In this example, ``--gprof=1 --flame=1`` is configured in Config options: ``--gprof=1`` enables the gprof-based Profiling feature, so a gprof file is produced when the program runs, and ``--flame=1`` enables the Flamegraph feature.

For details about the parameters of Nuclei Near Cycle Model, see :ref:`Description of Parameters <xlmodel_description_of_parameters>`.

For the gprof Profiling feature, see :ref:`Code Coverage and Profiling <ide_advanceusage_17>`.

For the Flamegraph feature, see :ref:`Using Flame View <ide_flame_view>`.

After configuring and saving the parameters, click ``Debug`` to enter the Nuclei Model Debug mode.

|image108|

The program runs successfully in Nuclei Near Cycle Model and outputs the corresponding log information.

|image77|

In the Debug directory of the project, you can see that the ``.rvtrace`` file and the ``.gmon`` file have been generated.

|image78|

Nuclei Near Cycle Model supports analyzing programs with gprof. Therefore, when ``--gprof`` is configured, a ``.gmon`` file is also produced in the Debug directory (the directory configured with ``--logdir=XX``) while the program runs. Double-click the ``.gmon`` file to invoke the gprof tool and analyze the number of cycles consumed by program execution and the call relationships; a corresponding ``callgraph.out`` file is also produced. Double-click the ``callgraph.out`` file to view the program's call relationships with Call Graph.

The gprof tool displays the contents of the generated ``.gmon`` file.

|image80|

While viewing the ``.gmon`` file, the gprof tool parses the program's call relationships based on its contents and generates a ``callgraph.out`` file. Double-click ``callgraph.out`` to view it with the Call Graph tool.

|image43|

.. _ide_nuclei_model_flame:

Because ``--flame=1`` is configured, an ``xlmodel_flame_0.gtef`` file is produced in the project root directory. Double-click the file to invoke the Flame View tool to parse it and generate a flame graph.

|image114|

The same configuration supports both Debug and Run. To execute the program directly, switch in the Launch Bar.

|image109|

Click Run to enter Nuclei Model Run mode; the program executes directly to completion.

|image110|

You can also export the configuration file to the project root directory so that it can be shared with other users.

Open the Debug Configurations page, right-click the configuration just created, and select `` Export... `` from the context menu.

|image111|

In the ``Export Launch Configurations`` page, select the configuration to export and the export location, and click ``Finish`` to complete the export.

|image112|

Refresh the project. A ``*.launch`` file exists under the project, and the corresponding configuration also appears in the Launch Bar. You can now use this configuration for Debug/Run operations on the program.

|image113|


.. _ide_nuclei_model:

Using Nuclei Model
------------------

Nuclei has developed a dedicated running tool for Nuclei Near Cycle Model called Model. In Nuclei Studio 2024.06, Nuclei Near Cycle Model was originally run through the RVProf tool. As Nuclei Near Cycle Model continued to evolve, we simplified the RVProf-based functionality and launched the new Model tool to provide a simpler, more efficient user experience.

The main features of the new tool include:

**Simplified functionality**: removes unnecessary complex features so you can focus on the core functionality of Nuclei Near Cycle Model.

**Improved efficiency**: optimizes the operation flow and reduces configuration time.

**Good compatibility**: ensures seamless integration with existing workflows while supporting the latest Nuclei Near Cycle Model features.

With these improvements, you can use Nuclei Near Cycle Model for development and debugging more efficiently. Open Run Configuration via the Nuclei Studio menu ``Run -> Run Configuration``, find ``Nuclei Model``, and double-click it to generate the configuration for the project.

|image82|

The use of Nuclei Model is described in detail in the Nuclei Near Cycle Model chapter.

.. _ide_nuclei_near_cycle_model:

.. _ide_advanceusage_71:

Nuclei Near Cycle Model
-----------------------

Nuclei Studio 2024.06 integrates Nuclei Near Cycle Model, a simulation testing and performance analysis tool independently developed by Nuclei. It helps R&D personnel perform simulation testing and program performance analysis in the early stages of a project.

Nuclei Near Cycle Model is only available for Linux in Nuclei Studio 2024.06; Windows support was added in version 2025.02. For a detailed introduction and command line usage, see https://doc.nucleisys.com/nuclei_tools/xlmodel/intro.html. The following sections demonstrate how to use Nuclei Near Cycle Model for simulation and performance analysis in Nuclei Studio.

.. note::

   Nuclei Near Cycle Model now supports both Windows and Linux. The tests in this document were all performed with the Windows version of Nuclei Studio IDE 2025.02.

If you encounter any problems during use, check `https://github.com/Nuclei-Software/nuclei-studio <https://github.com/Nuclei-Software/nuclei-studio>`__ or submit an issue.

Creating a Test Project
~~~~~~~~~~~~~~~~~~~~~~~

Nuclei Near Cycle Model supports all types of Nuclei cores. Create any demo project and build it.

|image72|

Nuclei Near Cycle Model runs tests using the Model run configuration in Nuclei Studio. Select the built test project, and then open Run Configurations in Nuclei Studio.

|image73|

Create a Nuclei Near Cycle Model configuration. The configuration parameters are described below.

|image74|

In this example, ``--trace=1 --gprof=1 --logdir=Debug --cpu=n300fd`` is configured in Config options: ``--trace=1`` enables rvtrace, ``--gprof=1`` enables the gprof feature, ``--logdir=Debug`` stores the generated ``.rvtrace`` and ``.gmon`` files in the Debug directory under the current project, and ``--cpu=n300fd`` sets the simulated CPU core to n300fd.

.. note::

   ``--cpu=<core type>`` must be configured and must be consistent with the Core value configured in Nuclei Setting.

   ``--ext=<extension type>`` must be consistent with the Other extensions value configured in Nuclei Setting.

For details about the parameters of Nuclei Near Cycle Model, see :ref:`Description of Parameters <xlmodel_description_of_parameters>`.

Running the Project and Generating Profiling Results
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Click the Run button to run the program. The program runs successfully in Nuclei Near Cycle Model and outputs the corresponding log information.

|image77|

In the Debug directory of the project, you can see that the ``.rvtrace`` file and the ``.gmon`` file have been generated.

|image78|

Nuclei Near Cycle Model supports analyzing programs with gprof. Therefore, when ``--gprof`` is configured, a ``.gmon`` file is also produced in the Debug directory (the directory configured with ``--logdir=XX``) while the program runs. Double-click the ``.gmon`` file to invoke the gprof tool and analyze the number of cycles consumed by program execution and the call relationships; a corresponding ``callgraph.out`` file is also produced. Double-click the ``callgraph.out`` file to view the program's call relationships with Call Graph.

The gprof tool displays the contents of the generated ``.gmon`` file.

|image80|

While viewing the ``.gmon`` file, the gprof tool parses the program's call relationships based on its contents and generates a ``callgraph.out`` file. Double-click ``callgraph.out`` to view it with the Call Graph tool.

|image43|


.. _ide_nuclei_custom_debugger:

Using GDB Custom Debugger
------------------------------

GDB Custom is a simplified debug configuration developed by Nuclei to accommodate different debugging tools. It lets you debug programs in Nuclei Studio with your own custom debugging tools. GDB Custom supports debugging projects through Commands, Generic Serial, and DLink; choose the method that fits your setup.

The GDB Custom debugging feature is illustrated with DLink, a debugging tool developed by Nuclei. For details, see :ref:`Debugging and Running a Project with DLink <ide_projectrun_50>`.

.. _ide_live_watch:

Using Live Watch
----------------

Live Watch is a real-time monitoring tool that helps you debug and optimize code more efficiently. With Live Watch, you can view variable changes instantly while the program is running, without interrupting execution or adding log statements manually. Live Watch was introduced in Nuclei Studio 2025.02. It refreshes variable values automatically so that you always see the latest data, and its intuitive graphical interface makes it easy to manage the variables you want to monitor.

.. note::

   By default, Live Watch reads data through the **Telnet/SBA channel**, which relies on the Nuclei-customized OpenOCD (it must provide the ``mbatch`` command, supported since 2025.02) and requires the CPU to support RISC-V SBA.

   Starting from Nuclei Studio 2026.10, a **GDB channel** is added as another data source: it polls through GDB MI commands (such as ``-var-update``), with lower latency and no dependence on SBA, but it **requires GDB non-stop mode to be enabled**. The trade-offs between the two channels and their relationship with non-stop are described below under "Getting Live Watch Data via the GDB Channel".

Live Watch Introduction
~~~~~~~~~~~~~~~~~~~~~~~~~

Open the Live Watch view via the Nuclei Studio menu ``Window -> Show View -> Live Watch``.

|image83|

The Live Watch view provides several function menus to help you manage and monitor variables:

|image84|

**Remove**

   - Deletes the selected variable row from the Live Watch view.

**Remove All**

   - Clears all variables added to the Live Watch view.

**Show Live Plot**

   - Shows the Live Plot view, which plots the sampled data in real time.


The hidden menu bar contains two settings menus for configuring global properties:

|image85|

**Live Watch Settings**

|image86|

 - Common settings in Live Watch:

     - The following settings are available:

        - Live Watch Speed : sets the sampling frequency of Live Watch, up to once every 1 ms. A sampling period of 5 ms or longer is recommended; if the sampling frequency is too high, Live Plot may draw abnormally.

        - Live Watch Variable Limit : limits the number of variables sampled at the same time, up to 10.

        - Live Plot Limit : sets the maximum number of samples that Live Plot draws at the same time, up to 10.

        - Save Data Path : specifies the path where the data sampled by Live Watch is automatically saved, for subsequent analysis.

        - Save Data Speed : sets the frequency at which Live Watch data is automatically saved. The default is once every 10 minutes.

**Number Format**

   - Sets the display format of variable values in the Live Watch view.


Getting Live Watch Data via the GDB Channel
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In Nuclei Studio 2026.10, support for getting Live Watch data via the **GDB channel** was added, as another data source besides the original Telnet/SBA channel. Its characteristics are lower latency and **no dependence on RISC-V SBA** — which is especially critical for targets that do not support SBA; the cost is that GDB's **non-stop mode** must be used.

**Trade-offs between the two channels**

.. list-table::
   :header-rows: 1

   * - Channel
     - Prerequisites
     - Main commands
     - Timeout / retry
     - Depends on SBA
   * - GDB channel
     - Enable non-stop + newer GDB
     - ``-var-update`` / ``-data-read-memory``
     - 20 ms
     - No
   * - Telnet channel (default fallback)
     - Nuclei-customized OpenOCD (provides ``mbatch``) + CPU supports SBA
     - ``mbatch r:<addr>:<size>:<count>``
     - 5 s, retry 3 times
     - Yes

**Why is non-stop mode required?**

**What non-stop decides is "whether the GDB channel can be used", not "whether the feature can be used".**

In GDB's **all-stop mode (default)**, once the target starts running, it refuses to process MI queries and reports ``Selected thread is running`` — that is, when the program runs at full speed, GDB simply cannot read variables, so real-time polling is impossible. In **non-stop mode**, each thread can run independently, and GDB still accepts MI commands while the target is running, allowing Live Watch to keep polling with ``-var-update`` without pausing the target.

Therefore:

- **Enable non-stop** → uses the GDB channel, with good real-time performance and no SBA dependency;
- **Non-stop not enabled** → the GDB channel is unavailable, and Live Watch automatically falls back to the Telnet/SBA channel. The feature still works, but goes through the slower ``mbatch`` + SBA path that also requires SBA.

"non-stop must be enabled to use Live Watch" only holds under the premise of "using the GDB channel"; without non-stop, Live Watch simply switches to another channel and keeps working.



**How to enable non-stop**

Check the option in the **OpenOCD debug configuration page** of Nuclei Studio:

``Enable GDB non-stop mode to support Live Watch``

This checkbox writes the launch attribute ``GDB_NONSTOP`` (``ATTR_DEBUGGER_NON_STOP``); its tooltip text is literally *"You must enable this option to use Live Watch."* After checking it and launching the debug session, Live Watch uses the GDB channel.




.. note::

   If Live Watch still cannot read data after enabling non-stop, first confirm: ① the debug configuration has the option above checked; ② the GDB version meets the non-stop threshold (the launch side validates this, and will report an error at launch if not); ③ the CDT DSF service is available. If necessary, refer to "Summary of Live Watch Issues" to confirm whether the target supports SBA.


Live Watch Usage Demo
~~~~~~~~~~~~~~~~~~~~~~~

Create a test project and implement a sine calculation in it. Open the Live Watch view, find Live Watch Settings, and set the related parameters as needed (or keep the default values).

|image87|

.. code-block:: c

   #include <stdio.h>
   #include "nuclei_sdk_soc.h"
   #include <math.h>

   #define PI 3.14159265358979323846
   /**
   * Get a sine wave variable that varies with time
   */
   double get_sine_wave_value(double amplitude, double frequency) {
      // Get the value of the current cycle counter
      uint64_t current_cycle = __get_rv_cycle();

      // Calculate the current time (in seconds)
      double currentTime = (double)current_cycle / SystemCoreClock;

      // Precompute the frequency-related factor
      double omega = frequency * 2 * PI;

      // Calculate the phase
      double phase = currentTime * omega;

      // Return the sine value
      return sin(phase) * amplitude;
   }

   int main(void)
   {

      double amplitude = 100.0; // amplitude of the waveform

      double frequency = 0.1;  // frequency of the waveform (cycles per second)

      double sine_value = 0;

      printf("Enter to task_2\r\n");
      while (1) {

         sine_value = get_sine_wave_value(amplitude, frequency);

      }

      return 0;
   }

The test demo uses math functions, so you need to add ``-lm`` to the linker options. In the project properties, go to ``Settings -> GNU RISC-V Cross C++ Linker -> Libraries`` and add ``-lm``.

|image99|

Open the Live Watch view via ``Windows -> Show View -> Live Watch``.

|image88|

After building the project and running the program in Debug mode, add the variables you want to view in the Live Watch view. There are two ways to add variables: click ``add new variable`` in the Live Watch window to add them manually, or select a variable in the project and drag it into the Live Watch window with the left mouse button.

|image89|

When the program runs at full speed, the variable values change at the configured Live Watch Speed. To view a variable's change curve with Live Plot, select the record, right-click, and select ``Toggle Live Plot`` from the context menu. The Live Plot tool opens and draws the variable's change curve.

|image90|

The curve drawn by Live Plot is shown below.

|image91|

Right-click in Live Plot to open a menu with two items, ``Suspend`` and ``Continue``. Click ``Suspend`` to pause drawing.

|image92|

Scroll the mouse wheel to zoom in on the curve and view data details; click ``Continue`` to resume drawing.

|image93|


If you no longer want to view the change curve of a variable, click ``Toggle Live Plot`` again to remove the variable from Live Plot.

|image94|

Right-click a variable in the Live Watch view to modify the display format of its data.

|image97|

Right-click a variable in the Live Watch view to save its sampled results as a CSV file for later use.

|image96|

Live Watch also automatically saves the sampled data to ``Save Data Path``, where you can find the corresponding CSV files.

|image98|

To stop watching a variable, select the record, right-click, and select ``Toggle Live Watch`` from the context menu. Live Watch then stops querying the variable's value in real time.

|image95|

Troubleshooting Live Watch
~~~~~~~~~~~~~~~~~~~~~~~~~~

**Dependency on RISC-V SBA**

As mentioned earlier, Live Watch depends on RISC-V SBA. If Live Watch cannot obtain a variable's value, the current CPU may not support RISC-V SBA. Use the following method to confirm whether the CPU supports RISC-V SBA.

While the project is in the Debug state, obtain the address of the variable in Live Watch, as shown below.

|image100|

Open the telnet tool, configure it, and connect. If the connection fails, check whether the OpenOCD service has started properly and whether the telnet port is open.

|image101|

While still in the Debug state, use the command ``riscv set_mem_access sysbus`` in the telnet tool to set the riscv memory access mode to sysbus (SBA), and try to read the value of the variable.

.. code-block:: c

   > riscv set_mem_access sysbus
   > mdw 0x9000ffd8 4
   0x9000ffd8: 000ab156 404e8df0 9999999a 3fb99999 

If the operation above reads the variable's value, run the program at full speed and read the value again. If no error is reported and the value can be read, the current CPU supports the SBA feature.

.. code-block:: c

   > mdw 0x9000ffd8 4
   0x9000ffd8: 000ab156 404e8df0 9999999a 3fb99999 
   > mdw 0x9000ffd8 4
   0x9000ffd8: d0b53424 c0510557 9999999a 3fb99999 
   > mdw 0x8000ffd8 4
   0x8000ffd8: 00000000 00000000 00000000 00000000 
   > mdw 0x9000ffd8 4
   0x9000ffd8: b169d356 c0580176 9999999a 3fb99999 
   > mdw 0x9000ffd8 4
   0x9000ffd8: a69861c1 c056547d 9999999a 3fb99999 
   > mdw 0x9000ffd8 4
   0x9000ffd8: 4dbf49f2 404022d3 9999999a 3fb99999 
   > mdw 0x9000ffd8 4


**Live Watch Cannot Read Variable Values When the Optimization Level Is Too High**

When the project's optimization level is high, Live Watch may not be able to obtain the values of some variables, as demonstrated below.

.. code-block:: c

   int test()
   {
      uint32_t live_watch = 0;
      while(1){
         live_watch += 1;
         delay_ms(100U);
      }
   }

When the project's optimization level is set to O3 or higher, Live Watch cannot obtain the value of ``live_watch``. You can lower the project's optimization level, or declare the monitored variable as a global or static variable so that it is not optimized away by the compiler. Modify the project code as follows.

.. code-block:: c

   int test()
   {
      static uint32_t live_watch = 0;
      while(1){
         live_watch += 1;
         delay_ms(100U);
      }
   }


.. _ide_live_peripheral:

Live Peripheral
--------------------------

Live Peripheral displays the chip peripherals, registers, and bit fields in a tree, and can periodically refresh register values during program execution, and also allows directly writing registers. Its biggest difference from the traditional Peripherals view is "real-time": you can see register values change as the program runs without pausing it. It shares the same backend data service (GDB channel and OpenOCD Telnet channel) with Live Watch; see :ref:`Live Watch <ide_live_watch>`.

Overview
~~~~~~~~

Live Peripheral senses "which peripherals, register addresses, and bit-field meanings" through the SVD file, presents them as a three-level tree of peripheral → register → bit field, and supports real-time refresh and writing during program execution.

**Prerequisites**


1. The SVD Path must be configured. Live Peripheral knows the peripheral and register layout only through the SVD file; without it, the view cannot be opened. The SVD is usually provided by the NPK device package, and the configuration location is the SVD Path input box in the debug configuration under ``Run -> Debug Configurations...`` (in most cases it is automatically written when the NPK creates the project). If the SVD Path is not set or the file is invalid, an error prompt will pop up when opening the view.
2. Real-time sampling requires SBA: the data source can be GDB or Telnet; if an old GDB is detected, it automatically falls back to Telnet.
3. QEMU limitation: under QEMU, only paused-state ordinary register reads are possible; real-time sampling is not supported.

Live Peripheral Introduction
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Menu ``Window -> Show View -> Debug -> Live Peripheral``. The view is visible by default in the Debug perspective, stacked with the Variables view; in the C/C++ perspective only a shortcut is registered.

|image162|

The main body is a tree with the hierarchy peripheral → register → bit field. The toolbar provides real-time sampling control (``Start`` / ``Suspend All Live Watch``).

**View registers**

Expand the target peripheral in the tree; after expansion, the current values of each register under that peripheral are read immediately; expanding a register further shows the values and meanings of each bit field.

|image163|

**Real-time sampling**

1. Make sure the SVD is configured and the backend supports SBA.
2. Enable Live Watch for the register(s) of interest.
3. Click ``Start`` on the toolbar to start sampling; register values are refreshed periodically during program execution.
4. Click ``Suspend All Live Watch`` when you need to pause sampling.

Note: adding new sampling items is not supported in non-stop mode.

|image164|

**Write registers**

Select a writable register and write a new value directly. Note: registers marked read-only cannot be written; the Number Format menu can switch the Hex / Binary / Dec / Oct display format, and writes are parsed according to the current format.

**Favorites grouping and export**

Add to Group: gather commonly used registers into a dedicated tab to avoid flipping back and forth in the big tree. Select the target register in the register tree (or multi-select multiple registers on a peripheral), right-click (or use the toolbar) and choose ``Add to Group``, select an existing group or enter a new group name; after confirmation, the view generates a new tab named after that group.

Save as CSV: export all sampling history of a certain register as a CSV file. Select a register in the register tree (CSV export only takes effect on register nodes), right-click and choose ``Save as CSV``; the default file name is ``<project name>_<register name>_register.csv``. The CSV contains the following columns:

.. list-table::
   :header-rows: 1

   * - Column
     - Meaning
   * - requestId
     - The request sequence number of each sampling
   * - Register Name
     - Register name
   * - Address
     - Register address (hexadecimal)
   * - Value
     - The register value read in that sampling
   * - Hexdata
     - Raw hexadecimal data
   * - Time (s)
     - Elapsed time relative to the first sampling (seconds, format second.millisecond)

Tip: the CSV records historical sampling values; you must have enabled Live Watch sampling and accumulated data first, otherwise the export is empty.

|image165|

**Live Peripheral Settings**


View menu → ``Live Peripheral Settings``:

.. list-table::
   :header-rows: 1

   * - Setting item
     - Description
   * - Data source
     - GDB or Telnet. When an old GDB is detected, it is forced to fall back to Telnet
   * - Speed
     - Sampling speed, range 0–99999, default 10000
   * - CSV save path
     - The location where sampling data is written to disk
   * - Save frequency
     - The time interval for automatic saving

The menu also has ``Refresh SVD data``, used to reload after the SVD file is updated.

|image166|


Using Live Peripheral
~~~~~~~~~~~~~~~~~~~~~~

1. Confirm the SVD Path: open ``Run -> Debug Configurations...`` and check in the debug configuration that the SVD Path is filled in (most NPK projects fill it in automatically). A missing SVD causes an error when opening the view.
2. Start debugging and enter the Debug perspective.
3. Open the view: menu ``Window -> Show View -> Debug -> Live Peripheral``.
4. Expand the peripheral tree; expanding a peripheral immediately reads the current values of the registers under it.
5. Enable Live Watch for the register(s) of interest and click ``Start`` on the toolbar to start real-time sampling; register values are refreshed periodically as the program runs.
6. Click ``Suspend All Live Watch`` when you need to pause sampling.
7. To watch certain registers for a long time: select them and use ``Add to Group`` to gather them into a dedicated tab; for trend analysis: right-click a register and use ``Save as CSV`` to export the sampling history.

|image167|


Flash Programming
-----------------

Nuclei Studio provides the Flash Programming feature for downloading compiled binary files directly to hardware development boards quickly and conveniently, greatly improving development and debugging efficiency. The operation flow is simple: after the project is built, click Flash Programming to download the binary file in one step.

For details, see :ref:`Flash Programming <ide_flash_programming>`.

|image102|


.. _ide_flash_erase:

Flash Erase
------------

In real development there is often a need to erase Flash independently **without starting a full debug or download session**: for example, to let the chip restart from a blank state to rule out interference from old firmware/residual data, to clear a write-protected region so it can be programmed again, or to erase only a certain sector / address range while keeping the rest. If every erase required first establishing a GDB debug connection and then exiting, it would be cumbersome and could introduce unnecessary side effects, so it is provided as an independent entry point that can be triggered from the toolbar or the right-click menu.

Flash Erase provides an entry point independent of the debug session, driving OpenOCD directly to erase the target chip's Flash, and exiting immediately after the erase completes (no GDB start, no program download).

See :ref:`Flash Erase <projectrun_flash_erase>` for details.

|image134|


Connect to Running Target
-------------------------

Nuclei Studio provides the Connect to Running Target feature for connecting directly to a running development board. It connects to the running board and reads board information, greatly improving development efficiency.

For details, see :ref:`Connect to Running Target <ide_connect_to_target>`.

|image103|

.. _ide_nuclei_qemu_customize_evalsoc:

Updating evalsoc in Nuclei QEMU
-----------------------------------

To let you quickly modify the addresses and sizes of peripherals and the interrupt numbers in the Nuclei QEMU evalsoc — without modifying the Nuclei QEMU source code — and thus adapt to different evalsoc versions, Nuclei QEMU extends the ``-M`` option with the :ref:`soc-cfg <qemu_opt_soc_cfg>` option. You write a json configuration file and pass an option such as ``-M nuclei_evalsoc,download=ddr,soc-cfg=evalsoc.json,debug=1`` on the QEMU command line to modify the evalsoc peripheral configuration.

In Nuclei Studio, place the ``evalsoc.json`` file in the root directory of your project, then modify ``Extra Board Options(-M)`` on the **Debugger Tab** of the **Nuclei QEMU Debug Configuration** page. Change it to ``,soc-cfg=${project_loc}/evalsoc.json,debug=1`` and save the debug configuration.

You can then debug Nuclei QEMU features according to the new evalsoc configuration.

|image130|

Switching from GCC to Clang/ZCC
-----------------------------------

Nuclei Studio IDE supports three toolchains: ``RISC-V GCC/Newlib``, ``RISC-V Clang/Newlib``, and ``Terapines ZCC``.
When creating a project, select the desired toolchain in the ``Toolchain`` drop-down box.

|image-gcc2llvm-1|

If the current project uses the GCC toolchain and you want to switch to the Clang or ZCC toolchain, you can complete the migration with the following steps:

1. :ref:`Switching the Toolchain <change_toolchain>`;
2. :ref:`Adjusting Compile and Link Options <adjust_flags>`;
3. :ref:`Adjusting Linked Libraries <adjust_libs>`;

.. _change_toolchain:

Switching the Toolchain
~~~~~~~~~~~~~~~~~~~~~~~

Select the project in ``Project Explorer``, right-click and select ``Properties`` to open the project properties, then go to ``C/C++ Build -> Settings -> Toolchains`` and select the target toolchain in the ``Name`` drop-down box.

|image-gcc2llvm-2|

.. _adjust_flags:

Adjusting Compile and Link Options
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

RISC-V Clang/Newlib
^^^^^^^^^^^^^^^^^^^

If you switch to the Clang toolchain, you need to adjust the compile and link options accordingly, because Clang is not fully compatible with all GCC parameters.

Taking the CoreMark project as an example, the parameters used by different CPU series may vary slightly, but the following adjustments are generally recommended:

1. Change ``Optimization Level`` from ``-Ofast`` to ``-O3``;
2. Replace ``Extra Common Flags`` with ``-flto``;
3. Remove ``-Wl,--no-warn-rwx-segments`` from the link options.

|image-gcc2llvm-3|

Terapines ZCC
^^^^^^^^^^^^^

If you switch to the ZCC toolchain, it is recommended to adjust the compile and link options as follows:

1. Change ``Optimization Level`` from ``-Ofast`` to ``-O3``;
2. Replace ``Extra Common Flags`` with ``-flto -falign-functions=4 -falign-loops=4 -flate-loop-unroll -malign-branch``;
3. Remove ``-Wl,--no-warn-rwx-segments`` from the link options;
4. Change the link options to ``-Wl,-mllvm,--align-all-nofallthru-blocks=2``.

|image-gcc2llvm-4|

.. _adjust_libs:

Adjusting Linked Libraries
~~~~~~~~~~~~~~~~~~~~~~~~~~

Different toolchains may depend on different libraries, so you also need to check and adjust the linked libraries after switching. The linked libraries can be modified in the project properties under ``C/C++ Build -> Settings -> Tool Settings -> GNU RISC-V Cross C++ Linker -> Libraries``.

|image-gcc2llvm-5|

For the Clang toolchain, Nuclei Studio still uses the same C standard library, and generally no additional modification of the linked libraries is required. Therefore, when migrating from GCC to Clang, you usually only need to complete the previous two steps, :ref:`Switching the Toolchain <change_toolchain>` and :ref:`Adjusting Compile and Link Options <adjust_flags>`, and then try to rebuild the project.

For the ZCC toolchain, the linked library names must also be adjusted. ZCC only supports the ``newlib_small`` library, so whether the current GCC project uses ``newlib_small`` or ``libncrt_small``, change the linked libraries to ``c_small`` and ``clang_rt.builtins_small``.

|image-gcc2llvm-6|

If the current project links ``libncrt_small``, you also need to replace ``stubs.c`` with the newlib version; if the project originally uses the newlib library, this step is not needed.

For example, in an EvalSoC project created based on Nuclei SDK, first exclude the libncrt version of ``stubs.c`` from the build: select ``SoC\evalsoc\Common\Source\Stubs\libncrt``, right-click and select ``Resource Configurations -> Exclude from Build...``, then copy a newlib version of ``stubs.c`` from another project that uses the newlib library into the ``Stubs`` directory.

|image-gcc2llvm-7|

After completing the ``stubs.c`` adjustment, the migration from GCC to ZCC is complete, and you can try to rebuild the project.

Converting Between newlib_small and libncrt_small
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

As mentioned earlier, ZCC does not support ``libncrt_small``. Therefore, when switching the toolchain from GCC to ZCC, a project that originally uses ``libncrt_small`` must also be switched to ``newlib_small``.

When ``newlib_small`` is selected in Nuclei Studio, the actual linked library is ``c_nano`` and floating-point printing is supported. ``-u _printf_float`` is added to the link options by default. You can check whether this option has been added as shown in the figure below.

|image-gcc2llvm-8|

The table below summarizes the supported toolchain and C library combinations. When adjusting the toolchain or linked libraries, also check that the ``Library List``, ``Link Options``, and ``stubs File`` match.

+------------+----------------+---------------+---------------------------+------------------+-----------------+
| Toolchain  | Linked Library | Supported     | Library List              | Link Options     | stubs File      |
+============+================+===============+===========================+==================+=================+
| GCC/Clang  | newlib_small   | Supported     | - c++                     | -u _printf_float | newlib/stubs.c  |
|            |                |               | - c_nano                  |                  |                 |
|            |                |               | - gcc                     |                  |                 |
+------------+----------------+---------------+---------------------------+------------------+-----------------+
| GCC/Clang  | libncrt_small  | Supported     | - ncrt_small              |                  | libncrt/stubs.c |
|            |                |               | - heapops_basic           |                  |                 |
|            |                |               | - fileops_uart            |                  |                 |
+------------+----------------+---------------+---------------------------+------------------+-----------------+
| ZCC        | newlib_small   | Supported     | - c_small                 |                  | newlib/stubs.c  |
|            |                |               | - clang_rt.builtins_small |                  |                 |
+------------+----------------+---------------+---------------------------+------------------+-----------------+
| ZCC        | libncrt_small  | Not Supported |                           |                  |                 |
+------------+----------------+---------------+---------------------------+------------------+-----------------+

Common Issues
~~~~~~~~~~~~~

Clang/ZCC Incompatibility with GCC
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The Clang/ZCC toolchain is not fully compatible with GCC compile options. If errors are reported during compilation, refer to :ref:`Adjusting Compile and Link Options <adjust_flags>` for adjustments.

.. code-block:: console

    riscv64-unknown-elf-clang: error: unknown argument: '-fno-code-hoisting'
    riscv64-unknown-elf-clang: error: unknown argument: '-fno-if-conversion'
    riscv64-unknown-elf-clang: error: unknown argument: '-fno-if-conversion2'
    riscv64-unknown-elf-clang: error: unknown argument: '-fselective-scheduling'
    riscv64-unknown-elf-clang: error: unknown argument: '-fno-tree-loop-distribute-patterns'
    riscv64-unknown-elf-clang: error: unknown argument: '-mbranch-cost=1'

The Clang/ZCC toolchain does not support the ``-Wl,--no-warn-rwx-segments`` link option. If errors are reported during linking, refer to :ref:`Adjusting Compile and Link Options <adjust_flags>` for adjustments.

.. code-block:: console

    ld.lld: error: unknown argument '--no-warn-rwx-segments'
    riscv64-unknown-elf-clang++: error: ld command failed with exit code 1 (use -v to see invocation)
    make: *** [makefile:92: coremark.elf] Error 1

ZCC Link Failures
^^^^^^^^^^^^^^^^^

When switching from GCC to the ZCC toolchain, the following problems may occur if the linked libraries are not adjusted correctly. Refer to :ref:`Adjusting Linked Libraries <adjust_libs>` for modifications.

If the original project uses ``newlib_small`` but the linked libraries are not modified, the following error may occur:

.. code-block:: console

    ld.lld: error: unable to find library -lstdc++
    z++: error: ld command failed with exit code 1 (use -v to see invocation)
    make: *** [makefile:92: coremark.elf] Error 1

If the original project uses ``libncrt_small`` but the linked libraries are not modified, the following error may occur:

.. code-block:: console

    ld.lld: error: unable to find library -lncrt_small
    ld.lld: error: unable to find library -lheapops_basic
    ld.lld: error: unable to find library -lfileops_uart
    ld.lld: error: unable to find library -lncrt_small
    z++: error: ld command failed with exit code 1 (use -v to see invocation)
    make: *** [makefile:92: coremark.elf] Error 1

If the original project uses ``libncrt_small`` and the linked libraries have been modified, but ``stubs.c`` has not been replaced accordingly, the following error may occur:

.. code-block:: console

    ld.lld: error: undefined symbol: _read
    >>> referenced by ld-temp.o
    >>>               coremark.elf.lto.o:(sys_semihost_getc)
    
    ld.lld: error: undefined symbol: _write
    >>> referenced by ld-temp.o
    >>>               coremark.elf.lto.o:(sys_semihost_putc)
    z++: error: ld command failed with exit code 1 (use -v to see invocation)
    make: *** [makefile:92: coremark.elf] Error 1



.. _ide_cpu_information_brief:

CPU Information
---------------

CPU Information targets Nuclei-series RISC-V cores and provides two tabs, CPU Information and CPU Fault Analysis. It lets you inspect ``MARCHID / MHARTID / MIMPID / ISA / Version`` per hart, and decodes the ``MISA`` extension bits and Nuclei configuration CSRs (``mcfg_info`` / ``micfg_info`` / ``mdcfg_info``) bit by bit; CPU Fault Analysis can also locate the cause of a trap (current mode, ``mcause`` / ``scause``, trap vector, M/S-mode CSRs, page faults, etc.).

See :ref:`CPU Information <projectrun_cpu_information>` for details.

.. _ide_mmu_view:

MMU View
---------

The RISC-V MMU View is a view under the debug perspective, used to read the ``satp`` / ``misa`` CSRs and walk the page table while the target is halted, providing:

1. Address Translation: virtual address → physical address translation, showing the page-table walk path level by level;
2. Memory Map: folding the whole page table into a series of VA→PA ranges;
3. Page Tables: expanding page-table descriptors as a multi-level tree;
4. MMU Settings dialog: it can follow the hardware ``satp``, or inject a custom ``satp`` for offline analysis.

This view is read-only and writes no registers. The only hardware prerequisite: the core must implement S-mode (supervisor mode); otherwise the ``satp`` register does not exist at all. There are three ways to tell, which can corroborate each other:

- Whether the ISA string contains S (e.g., ``RV64ABCDFIMSU`` contains S);
- More reliably: look at bit18 of ``misa``;
- The Feature list explicitly shows SMODE.

Important reminder: none of the above three is a sufficient condition. In real tests there have been cases where the ISA contains S and misa bit18 is also 1, but ``csrw satp`` still triggers an illegal instruction exception (the hardware satp is always 0). Ultimately, the criterion is whether ``satp`` can be successfully read and written. If bit18 = 0 (for example, Nuclei N300, an MCU core that defaults to M/U + PMP), there is no software way to enable the MMU; you can only switch cores (such as UX600 / UX900) or change the bitstream to enable SMODE.

In the menu ``Window -> Show View -> Other...``, search for ``MMU`` to open the view.

|image135|

.. list-table::
   :header-rows: 1

   * - Control
     - Function
   * - Refresh
     - Read satp / misa and load the root page table
   * - Settings...
     - Open the MMU Settings dialog
   * - Linked
     - hart drop-down selection. On multicore it shows hart N (GDB Thread M); switching hart clears and refreshes again
   * - Address
     - Address input box, accepts a hexadecimal address or a GDB-evaluable expression
   * - Direction drop-down
     - Virtual to Physical or Physical to Virtual
   * - Translate
     - Execute the translation
   * - statusLabel
     - Shows the current status or error message

|image136|

The buttons remain clickable in all states; on failure a clear error message is given (for example, if the target is running, it prompts "please suspend first").

MMU View Introduction
~~~~~~~~~~~~~~~~~~~~~~~

Address Translation
^^^^^^^^^^^^^^^^^^^^

|image137|

.. list-table::
   :header-rows: 1

   * - Direction
     - Behavior
   * - Virtual to Physical
     - Enter a VA (or GDB expression) → page-table walk runs in the background → the result area shows the level-by-level walk path + translation result + Access Check (whether fetch/read/write are OK or FAULT, with the effect of MXR noted)
   * - Physical to Virtual
     - Enter a PA → full-table scan runs in the background → lists all VAs mapped to that PA (including VA range, PA range, page size, level, flags), up to 512 results

For both directions, you can right-click in the result area and choose Open PA in Memory View to jump to the physical address. The address input supports expressions; you can directly fill in a symbol name.

Memory Map
^^^^^^^^^^^

|image138|

After clicking ``Load Memory Map``, the full table is built in the background. Table columns: VA Start / VA End / Size / PA Start / PA End / Attributes. Unmapped ranges are shown as gray ``<unmapped>`` rows. The status bar shows statistics such as entries / tables / truncated / cancelled / readErrors.

Merge rule: two adjacent items are merged into one row only when they simultaneously satisfy VA continuity, PA continuity, same level, same permission flags, and same memory attributes (PBMT/N/RSW). The unit of the Size column is the largest readable unit (an integer for whole multiples, one decimal place for non-whole multiples).

Page Tables
^^^^^^^^^^^^

|image139|

The page table is expanded as a tree, with columns Input Address / Type / Output Address / Attributes. The next level is read in the background when a node is expanded.

Type is divided into three kinds:

.. list-table::
   :header-rows: 1

   * - Type
     - Meaning
   * - Page Table
     - Page-table pointer, pointing to the next level
   * - N Page
     - Leaf page-table entry, the actual mapping
   * - Fault (xN)
     - Fault node aggregated from consecutive invalid PTEs

The Output Address column has different meaning by node type: a leaf (N Page) shows the physical base address of that mapping; a pointer (Page Table) shows ``-> 0x...`` (the next-level page-table address, prefixed with ``->`` to avoid being misread as translation output); a root node / Fault shows ``-``.

After selecting a node in the tree, the lower panel shows the descriptor details (Descriptor Type / Address / Value / Input Address Range / Next-level Table Address / Output Attributes).

MMU Settings Dialog
^^^^^^^^^^^^^^^^^^^^

|image140|

.. list-table::
   :header-rows: 1

   * - Option
     - Description
   * - Use current translation settings
     - Read the hardware satp (default)
   * - Use custom translation settings
     - Inject a custom satp for offline analysis, without modifying the hardware CSR

After switching, the view is cleared and refreshed again.

Practical tip: when the target firmware does not enable paging (``satp.MODE = Bare``), this dialog is the main means to make the view work — as long as a valid page table exists in memory, filling in the corresponding ``satp`` value lets you traverse it completely, without the hardware actually enabling the MMU.


MMU View Usage Example
~~~~~~~~~~~~~~~~~~~~~~~~~

Before using MMU View, confirm that the core supports S-mode and that satp can be read and written successfully. The runtime verification of MMU View was done on a Nuclei UX900 (RV64) + OpenOCD.


1. Confirm the core supports S-mode (it is recommended to verify read/write with ``csrw satp``). MCU cores like N300 that are only M/U + PMP have no MMU and cannot be used.

|image141|

2. Start debugging and let the target halt.

|image142|

3. Open the view: menu ``Window -> Show View -> Other... -> MMU``. The view automatically reads satp / misa and loads the root page table.

|image143|

4. Look up a single address: fill the virtual address (supports symbol name / GDB expression) in the top Address input box, choose Virtual to Physical as the direction, and click Translate; the result area shows the level-by-level page-table walk path and Access Check.

|image144|

5. View the overall mapping: switch to the Memory Map tab and click Load Memory Map.

|image145|

6. View the page-table structure: switch to the Page Tables tab and expand level by level; select a node to see Descriptor Details; note that the ``->`` prefix on a pointer node indicates the next-level page-table address.

|image146|

**Troubleshooting**


.. list-table::
   :header-rows: 1

   * - Symptom
     - Cause and handling
   * - Prompt "please suspend first"
     - The target is running. MMU View only reads while halted; Suspend first or hit a breakpoint
   * - Pop-up "MMU View Unavailable" dialog
     - Runtime authoritative criterion: the current core misa bit 18 (S-mode) is 0, meaning the core has no MMU (e.g., N300 / N200 series are only M/U + PMP). Switch to a core that implements S-mode (such as N900 / UX900). The "custom satp offline analysis" in MMU Settings can still be used
   * - Debug launch immediately prompts "project core N300 typically has no MMU"
     - Project-level soft hint (non-blocking): an early warning when the core selected by the project belongs to a known MMU-less series; ultimately the runtime misa S bit is still authoritative
   * - Cannot read satp / view is empty
     - The core does not implement S-mode, or the hardware satp is always 0
   * - Many Fault nodes in the page-table tree
     - The corresponding range being unmapped is normal; you can turn off Coalesce Invalid Entries to inspect entry by entry


.. _ide_riscv_reference:

RISC-V Reference
-----------------

RISC-V Reference is a tool view that combines four capabilities:

1. Instruction / CSR / iRegion reference browser: search by extension, opcode, mnemonic, address, or name;
2. On-demand disassembly / decoding: decode hexadecimal machine code or assembly mnemonic into assembly and show it bit by bit, supporting both single and batch;
3. Register value bit-field interpretation: select a register from the Registers / Variables view to back-fill its current value, and break it down by bit field;
4. Remote data update: incrementally pull instruction/CSR/iRegion data from the server and cache it locally.

From the menu ``Window -> Show View -> Other...``, search for ``RISC-V Reference``. It is stacked by default in the Debug and C/C++ perspectives (in the same stack as the Console view).

RISC-V Reference Introduction
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

|image147|

.. list-table::
   :header-rows: 1

   * - Tab
     - Purpose
     - Description
   * - Instruction Query
     - Query instructions
     - Search by extension / opcode / mnemonic. Columns include Mnemonic / Arch / Extension / Mask / Match / Unratified / Format / Disassembly
   * - CSR Query
     - Query CSRs
     - Search by address or name. Upper and lower lists + bit-field table; you can enter the current value and non-zero fields are highlighted
   * - iRegion Query
     - Query peripheral registers
     - Search memory-mapped registers by module / register name and do bit-field decomposition
   * - Batch Import
     - Batch import
     - Paste name=value text, parse and match to CSR / iRegion, then jump to or import per checked item
   * - Decoder
     - Decode machine code
     - Hexadecimal machine code (or assembly) → decode table, 13 columns in total (see below for the meaning of each column)

Using RISC-V Reference
~~~~~~~~~~~~~~~~~~~~~~~~

Query Instructions
^^^^^^^^^^^^^^^^^^

1. Switch to the Instruction Query tab.
2. Enter a mnemonic (such as ``addi``) or an opcode fragment in the search box.
3. In the result table, view the instruction architecture, extension, Mask/Match, format, and disassembly form.

|image148|

Query CSR and Interpret by Bit Field
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

1. Switch to the CSR Query tab.
2. Search by address (such as ``0x300`` for mstatus) or name.
3. Select the target CSR; its bit-field table is shown below.
4. Enter the actually-read value in the "current value" input box; the bit-field table decomposes according to that value, and non-zero fields are highlighted.

|image149|

Decode Machine Code
^^^^^^^^^^^^^^^^^^^^

1. Switch to the Decoder tab.
2. Enter hexadecimal machine code (you can also enter an assembly mnemonic for a reverse lookup).
3. The view outputs a decode table (13 columns), where you can see the meaning of each bit.
4. Batch is supported: multiple lines of input are decoded one by one.

|image150|

The decode table has 13 columns, with the following meanings:

.. list-table::
   :header-rows: 1

   * - Column
     - Meaning
   * - Input
     - The raw content you entered (hexadecimal machine code or assembly text), echoed as-is
   * - Assembly
     - Disassembly result, mnemonic + operands, e.g. ``add a1, a5, a4``
   * - Hex
     - Normalized hexadecimal machine code (0x prefix, left-padded with zeros to 32 bits)
   * - Binary
     - 32-bit binary expansion, bit-by-bit against the encoding
   * - Mnemonic
     - Instruction mnemonic
   * - Arch
     - Belonging architecture, e.g. RV32I / RV64I
   * - Extension
     - Belonging extension, e.g. I / M / C / F ...
   * - Mask
     - Encoding mask (works with Match to identify the instruction format)
   * - Match
     - Encoding match value
   * - Unratified
     - Whether unratified (draft extensions are marked true)
   * - Format
     - Instruction format type, e.g. R / I / S / B / U / J
   * - Disassembly
     - Disassembly form (full form, can be compared with Assembly)
   * - Description
     - Textual description of the instruction

Batch Decode supports pasting a whole block of machine code / assembly, one per line; it also supports formats copied directly from LST / disassembly windows such as ``address: machine code``, ``address <symbol>: machine code``, ``0x80000000: 00000033``.

Analyze from Editor or Console via Right-click
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The view contributes right-click menu commands to the following places: Analyze Instructions / Analyze Selection, used after selecting text in the Console, text editor, Terminal, or LST view.

|image151|

Analyze Instructions sends the result to the Decoder tab; Analyze Selection sends the result to the Batch Import tab. The benefit is: when you see a block of machine code in a log or disassembly window, you can select it directly and right-click to decode, without manually copying and pasting.

|image152|

Decode Register Values from the Registers View
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

1. Open the Registers or Variables view during debugging.
2. Select a register (or multi-select several lines in ``name=value`` form).
3. Right-click and use ``Decode Register``.
4. The register's current value is back-filled into Batch Import and interpreted by bit field.

|image153|

|image154|

.. _ide_gdb_breakpoint_filter:

GDB Breakpoint Project Filter Option
------------------------------------

In native Eclipse, when a project is debugged, all breakpoints are installed; if a breakpoint or its file does not exist, an error is reported. The GDB breakpoint project filter is a new GDB debug preference based on the underlying Eclipse CDT, which lets you install only the breakpoints of the currently debugged project to GDB in a multi-project workspace.

``Preferences > C/C++ > Debug > GDB``, under the General Behavior group, the option is named ``Only install breakpoints that belong to the launched project``.

|image155|

**Behavior Notes**

- This is a global workspace preference, off by default; when off, the behavior is the same as before (install breakpoints of all projects);
- After checking it, when installing breakpoints the debugger compares the breakpoint owning project with the launched project, and only installs to GDB the breakpoints belonging to the debugged project; breakpoints of other projects are skipped in this debug session;
- Breakpoints without a project set on files outside the workspace are still installed normally, to avoid accidentally dropping legitimate breakpoints.

This option changes the breakpoints actually installed to GDB — from the very beginning only the current project breakpoints are installed.

Before setting it, the IDE installs all breakpoints, so error messages appear.

|image156|

After setting it, there are no error messages; especially when debugging multicore or multiple projects, it reduces error messages.

|image157|


.. _ide_memory_exclusion:

Memory View Address Exclusion
------------------------------

The Memory view adds an address exclusion setting, which lets you configure memory address ranges that the Memory view should not read, avoiding errors when reading inaccessible or protected memory regions; this feature also applies to the Memory Browser.

The Memory view is the standard Eclipse memory view. Nuclei Studio registers a Peripheral render type for it: it shows a memory block per peripheral register, colored by register/bit field, with read-only fields grayed out. Compared with looking at the raw hexadecimal dump directly, the Peripheral render breaks a block of memory into "which register, which bit field, what meaning", making peripheral state reading more intuitive.

The ``Address Exclusion Settings...`` item is in the Memory view menu (toolbar).

|image158|

In the pop-up dialog, check ``Enable address exclusion`` to enable exclusion, and use ``Add...`` to add an excluded range (``Start Address`` / ``End Address``, hexadecimal without the ``0x`` prefix); ``Remove`` and ``Clear All`` are supported to manage the configured ranges.

|image159|

Memory within the excluded address range is not read/installed, and the debugger skips these regions, thereby avoiding errors or session anomalies caused by accessing illegal addresses. This exclusion setting also applies to the Memory Browser, avoiding errors when reading inaccessible regions across projects or sessions.

|image160|

.. |image1| image:: /asserts/nucleistudio/advanceusage/image2.png

.. |image2| image:: /asserts/nucleistudio/advanceusage/image3.png

.. |image3| image:: /asserts/nucleistudio/advanceusage/image4.png

.. |image4| image:: /asserts/nucleistudio/advanceusage/image5.png

.. |image5| image:: /asserts/nucleistudio/advanceusage/image6.png

.. |image6| image:: /asserts/nucleistudio/advanceusage/image7.png

.. |image7| image:: /asserts/nucleistudio/advanceusage/image8.png

.. |image8| image:: /asserts/nucleistudio/advanceusage/image9.png

.. |image9| image:: /asserts/nucleistudio/advanceusage/image10.png

.. |image10| image:: /asserts/nucleistudio/advanceusage/image11.png

.. |image11| image:: /asserts/nucleistudio/advanceusage/image12.png

.. |image12| image:: /asserts/nucleistudio/advanceusage/image13.png

.. |image13| image:: /asserts/nucleistudio/advanceusage/image14.png

.. |image14| image:: /asserts/nucleistudio/advanceusage/image15.png

.. |image15| image:: /asserts/nucleistudio/advanceusage/image16.png

.. |image16| image:: /asserts/nucleistudio/advanceusage/image17.png

.. |image17| image:: /asserts/nucleistudio/advanceusage/image18.png

.. |image18| image:: /asserts/nucleistudio/advanceusage/image19.png

.. |image19| image:: /asserts/nucleistudio/advanceusage/image20.png

.. |image20| image:: /asserts/nucleistudio/advanceusage/image21.png

.. |image21| image:: /asserts/nucleistudio/advanceusage/image22.png

.. |image22| image:: /asserts/nucleistudio/advanceusage/image23.png

.. |profiling_options_in_ide| image:: /asserts/nucleistudio/advanceusage/image24.png

.. |image23| image:: /asserts/nucleistudio/advanceusage/image25.png

.. |image24| image:: /asserts/nucleistudio/advanceusage/image26.png

.. |image25| image:: /asserts/nucleistudio/advanceusage/image27.png

.. |image26| image:: /asserts/nucleistudio/advanceusage/image28.png

.. |image27| image:: /asserts/nucleistudio/advanceusage/image29.png

.. |image28| image:: /asserts/nucleistudio/advanceusage/image30.png

.. |image29| image:: /asserts/nucleistudio/advanceusage/image31.png

.. |image30| image:: /asserts/nucleistudio/advanceusage/image32.png

.. |image31| image:: /asserts/nucleistudio/advanceusage/image33.png

.. |image32| image:: /asserts/nucleistudio/advanceusage/image34.png

.. |image33| image:: /asserts/nucleistudio/advanceusage/image35.png

.. |image34| image:: /asserts/nucleistudio/advanceusage/image36.png

.. |image35| image:: /asserts/nucleistudio/advanceusage/image37.png

.. |image36| image:: /asserts/nucleistudio/advanceusage/image38.png

.. |image37| image:: /asserts/nucleistudio/advanceusage/image39.png

.. |image38| image:: /asserts/nucleistudio/advanceusage/image25.png

.. |image39| image:: /asserts/nucleistudio/advanceusage/image40.png

.. |image40| image:: /asserts/nucleistudio/advanceusage/image41.png

.. |image41| image:: /asserts/nucleistudio/advanceusage/image42.png

.. |image42| image:: /asserts/nucleistudio/advanceusage/image43.png

.. |image43| image:: /asserts/nucleistudio/advanceusage/image44.png

.. |image44| image:: /asserts/nucleistudio/advanceusage/image45.png

.. |image45| image:: /asserts/nucleistudio/advanceusage/image46.png

.. |image46| image:: /asserts/nucleistudio/advanceusage/image47.png

.. |image47| image:: /asserts/nucleistudio/advanceusage/image48.png

.. |image48| image:: /asserts/nucleistudio/advanceusage/image49.png

.. |image49| image:: /asserts/nucleistudio/advanceusage/image50.png

.. |image50| image:: /asserts/nucleistudio/advanceusage/image51.png

.. |image51| image:: /asserts/nucleistudio/advanceusage/image52.png

.. |image52| image:: /asserts/nucleistudio/advanceusage/image53.png

.. |image53| image:: /asserts/nucleistudio/advanceusage/image54.png

.. |image54| image:: /asserts/nucleistudio/advanceusage/image55.png

.. |image55| image:: /asserts/nucleistudio/advanceusage/image56.png

.. |image56| image:: /asserts/nucleistudio/advanceusage/image57.png

.. |image57| image:: /asserts/nucleistudio/advanceusage/image58.png

.. |image58| image:: /asserts/nucleistudio/advanceusage/image59.png

.. |image59| image:: /asserts/nucleistudio/advanceusage/image60.png

.. |image60| image:: /asserts/nucleistudio/advanceusage/image61.png

.. |image61| image:: /asserts/nucleistudio/advanceusage/image47.png

.. |image62| image:: /asserts/nucleistudio/advanceusage/image62.png

.. |image63| image:: /asserts/nucleistudio/advanceusage/image63.png

.. |image64| image:: /asserts/nucleistudio/advanceusage/image64.png

.. |image65| image:: /asserts/nucleistudio/advanceusage/image65.png

.. |image66| image:: /asserts/nucleistudio/advanceusage/image66.png

.. |image67| image:: /asserts/nucleistudio/advanceusage/image67.png

.. |image68| image:: /asserts/nucleistudio/advanceusage/image68.png

.. |image69| image:: /asserts/nucleistudio/advanceusage/image69.png

.. |image70| image:: /asserts/nucleistudio/advanceusage/image70.png

.. |image71| image:: /asserts/nucleistudio/advanceusage/image71.png

.. |image72| image:: /asserts/nucleistudio/advanceusage/image72.png

.. |image73| image:: /asserts/nucleistudio/advanceusage/image73.png

.. |image74| image:: /asserts/nucleistudio/advanceusage/image74.png

.. |image75| image:: /asserts/nucleistudio/advanceusage/image75.png

.. |image76| image:: /asserts/nucleistudio/advanceusage/image76.png

.. |image77| image:: /asserts/nucleistudio/advanceusage/image77.png

.. |image78| image:: /asserts/nucleistudio/advanceusage/image78.png

.. |image79| image:: /asserts/nucleistudio/advanceusage/image79.png

.. |image80| image:: /asserts/nucleistudio/advanceusage/image80.png

.. |image81| image:: /asserts/nucleistudio/advanceusage/image81.png

.. |image82| image:: /asserts/nucleistudio/advanceusage/image82.png

.. |image83| image:: /asserts/nucleistudio/advanceusage/image83.png

.. |image84| image:: /asserts/nucleistudio/advanceusage/image84.png

.. |image85| image:: /asserts/nucleistudio/advanceusage/image85.png

.. |image86| image:: /asserts/nucleistudio/advanceusage/image86.png

.. |image87| image:: /asserts/nucleistudio/advanceusage/image87.png

.. |image88| image:: /asserts/nucleistudio/advanceusage/image88.png

.. |image89| image:: /asserts/nucleistudio/advanceusage/image89.png

.. |image90| image:: /asserts/nucleistudio/advanceusage/image90.png

.. |image91| image:: /asserts/nucleistudio/advanceusage/image91.png

.. |image92| image:: /asserts/nucleistudio/advanceusage/image92.png

.. |image93| image:: /asserts/nucleistudio/advanceusage/image93.png

.. |image94| image:: /asserts/nucleistudio/advanceusage/image94.png

.. |image95| image:: /asserts/nucleistudio/advanceusage/image95.png

.. |image96| image:: /asserts/nucleistudio/advanceusage/image96.png

.. |image97| image:: /asserts/nucleistudio/advanceusage/image97.png

.. |image98| image:: /asserts/nucleistudio/advanceusage/image98.png

.. |image99| image:: /asserts/nucleistudio/advanceusage/image99.png

.. |image100| image:: /asserts/nucleistudio/advanceusage/image100.png

.. |image101| image:: /asserts/nucleistudio/advanceusage/image101.png

.. |image102| image:: /asserts/nucleistudio/advanceusage/image102.png

.. |image103| image:: /asserts/nucleistudio/advanceusage/image103.png

.. |image104| image:: /asserts/nucleistudio/advanceusage/image104.png

.. |image105| image:: /asserts/nucleistudio/advanceusage/image105.png

.. |image106| image:: /asserts/nucleistudio/advanceusage/image106.png

.. |image107| image:: /asserts/nucleistudio/advanceusage/image107.png

.. |image108| image:: /asserts/nucleistudio/advanceusage/image108.png

.. |image109| image:: /asserts/nucleistudio/advanceusage/image109.png

.. |image110| image:: /asserts/nucleistudio/advanceusage/image110.png

.. |image111| image:: /asserts/nucleistudio/advanceusage/image111.png

.. |image112| image:: /asserts/nucleistudio/advanceusage/image112.png

.. |image113| image:: /asserts/nucleistudio/advanceusage/image113.png

.. |image114| image:: /asserts/nucleistudio/advanceusage/image114.png

.. |image115| image:: /asserts/nucleistudio/advanceusage/image115.png

.. |image116| image:: /asserts/nucleistudio/advanceusage/image116.png

.. |tracecfg-atb| image:: /asserts/nucleistudio/advanceusage/image170.png

.. |tracecfg-bundle| image:: /asserts/nucleistudio/advanceusage/image171.png

.. |tracedec-atb| image:: /asserts/nucleistudio/advanceusage/image172.png

.. |tracedec-bundle| image:: /asserts/nucleistudio/advanceusage/image173.png

.. |image117| image:: /asserts/nucleistudio/advanceusage/image117.png

.. |image118| image:: /asserts/nucleistudio/advanceusage/image118.png

.. |image119| image:: /asserts/nucleistudio/advanceusage/image119.png

.. |image120| image:: /asserts/nucleistudio/advanceusage/image120.png

.. |image121| image:: /asserts/nucleistudio/advanceusage/image121.png

.. |image122| image:: /asserts/nucleistudio/advanceusage/image122.png

.. |image123| image:: /asserts/nucleistudio/advanceusage/image123.png

.. |image124| image:: /asserts/nucleistudio/advanceusage/image124.png

.. |image125| image:: /asserts/nucleistudio/advanceusage/image125.png

.. |image126| image:: /asserts/nucleistudio/advanceusage/image126.png

.. |image127| image:: /asserts/nucleistudio/advanceusage/image127.png

.. |image128| image:: /asserts/nucleistudio/advanceusage/image128.png

.. |image129| image:: /asserts/nucleistudio/advanceusage/image129.png

.. |image130| image:: /asserts/nucleistudio/advanceusage/image130.png

.. |image131| image:: /asserts/nucleistudio/advanceusage/image131.png

.. |image132| image:: /asserts/nucleistudio/advanceusage/image132.png

.. |image133| image:: /asserts/nucleistudio/advanceusage/image133.png

.. |image134| image:: /asserts/nucleistudio/advanceusage/image134.png

.. |image135| image:: /asserts/nucleistudio/advanceusage/image135.png

.. |image136| image:: /asserts/nucleistudio/advanceusage/image136.png

.. |image137| image:: /asserts/nucleistudio/advanceusage/image137.png

.. |image138| image:: /asserts/nucleistudio/advanceusage/image138.png

.. |image139| image:: /asserts/nucleistudio/advanceusage/image139.png

.. |image140| image:: /asserts/nucleistudio/advanceusage/image140.png

.. |image141| image:: /asserts/nucleistudio/advanceusage/image141.png

.. |image142| image:: /asserts/nucleistudio/advanceusage/image142.png

.. |image143| image:: /asserts/nucleistudio/advanceusage/image143.png

.. |image144| image:: /asserts/nucleistudio/advanceusage/image144.png

.. |image145| image:: /asserts/nucleistudio/advanceusage/image145.png

.. |image146| image:: /asserts/nucleistudio/advanceusage/image146.png

.. |image147| image:: /asserts/nucleistudio/advanceusage/image147.png

.. |image148| image:: /asserts/nucleistudio/advanceusage/image148.png

.. |image149| image:: /asserts/nucleistudio/advanceusage/image149.png

.. |image150| image:: /asserts/nucleistudio/advanceusage/image150.png

.. |image151| image:: /asserts/nucleistudio/advanceusage/image151.png

.. |image152| image:: /asserts/nucleistudio/advanceusage/image152.png

.. |image153| image:: /asserts/nucleistudio/advanceusage/image153.png

.. |image154| image:: /asserts/nucleistudio/advanceusage/image154.png

.. |image155| image:: /asserts/nucleistudio/advanceusage/image155.png

.. |image156| image:: /asserts/nucleistudio/advanceusage/image156.png

.. |image157| image:: /asserts/nucleistudio/advanceusage/image157.png

.. |image158| image:: /asserts/nucleistudio/advanceusage/image158.png

.. |image159| image:: /asserts/nucleistudio/advanceusage/image159.png

.. |image160| image:: /asserts/nucleistudio/advanceusage/image160.png

.. |image161| image:: /asserts/nucleistudio/advanceusage/image161.png

.. |image162| image:: /asserts/nucleistudio/advanceusage/image162.png

.. |image163| image:: /asserts/nucleistudio/advanceusage/image163.png

.. |image164| image:: /asserts/nucleistudio/advanceusage/image164.png

.. |image165| image:: /asserts/nucleistudio/advanceusage/image165.png

.. |image166| image:: /asserts/nucleistudio/advanceusage/image166.png

.. |image167| image:: /asserts/nucleistudio/advanceusage/image167.png

.. |image-nice-1| image:: /asserts/nucleistudio/advanceusage/nice-1.png

.. |image-nice-2| image:: /asserts/nucleistudio/advanceusage/nice-2.png

.. |image-nice-3| image:: /asserts/nucleistudio/advanceusage/nice-3.png

.. |image-nice-4| image:: /asserts/nucleistudio/advanceusage/nice-4.png

.. |image-nice-5| image:: /asserts/nucleistudio/advanceusage/nice-5.png

.. |image-nice-6| image:: /asserts/nucleistudio/advanceusage/nice-6.png

.. |image-nice-7| image:: /asserts/nucleistudio/advanceusage/nice-7.png

.. |image-nice-8| image:: /asserts/nucleistudio/advanceusage/nice-8.png

.. |image-nice-9| image:: /asserts/nucleistudio/advanceusage/nice-9.png

.. |image-nice-10| image:: /asserts/nucleistudio/advanceusage/nice-10.png

.. |image-gcc2llvm-1| image:: /asserts/nucleistudio/advanceusage/gcc2llvm-1.png

.. |image-gcc2llvm-2| image:: /asserts/nucleistudio/advanceusage/gcc2llvm-2.png

.. |image-gcc2llvm-3| image:: /asserts/nucleistudio/advanceusage/gcc2llvm-3.png

.. |image-gcc2llvm-4| image:: /asserts/nucleistudio/advanceusage/gcc2llvm-4.png

.. |image-gcc2llvm-5| image:: /asserts/nucleistudio/advanceusage/gcc2llvm-5.png

.. |image-gcc2llvm-6| image:: /asserts/nucleistudio/advanceusage/gcc2llvm-6.png

.. |image-gcc2llvm-7| image:: /asserts/nucleistudio/advanceusage/gcc2llvm-7.png

.. |image-gcc2llvm-8| image:: /asserts/nucleistudio/advanceusage/gcc2llvm-8.png
