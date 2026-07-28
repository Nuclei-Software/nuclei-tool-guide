.. _projectbuild:

Build a Project in Nuclei Studio
================================

Nuclei Studio supports multiple toolchains, so you can choose a different toolchain when creating a project. Nuclei Studio integrates three compilers—GCC 13, Clang 17, and ZCC Lite—which are ready to use without downloading.

|image1|

* **RISC-V Nuclei GCC (riscv-nuclei-elf-gcc)**

Early versions of Nuclei Studio supported the GCC 10 compiler, which has been deprecated since Nuclei Studio 2023.10. If you need GCC 10 support, download Nuclei RISC-V Toolchain 2022.12 (gcc10) yourself and replace the contents of the ``<NucleiStudio>/toolchain/gcc10`` directory.

* **RISC-V GCC/Newlib (riscv64-unknown-elf-gcc)**

Nuclei Studio 2023.10 and later supports the GCC 13 compiler. The corresponding package is stored in the ``<NucleiStudio>/toolchain/gcc`` directory.

* **RISC-V Clang/Newlib (riscv64-unknown-elf-clang)**

Nuclei Studio 2023.10 and later supports the Clang 17 compiler. The corresponding package is stored in the ``<NucleiStudio>/toolchain/gcc`` directory.

* **Terapines ZCC (zcc)**

Nuclei Studio 2024.06 supports the ZCC compiler. The corresponding package is stored in the ``<NucleiStudio>/toolchain/zcc`` directory. Creating a Terapines ZCC toolchain project requires Nuclei SDK **later than 0.6.0** and can currently be tested through the Nuclei SDK command line.

Build Tools
-----------

Nuclei GNU Toolchain
~~~~~~~~~~~~~~~~~~~~

The GNU Toolchain is a complete set of software development tools provided by the GNU project, including a compiler, debugger, linker, library files, and other essential tools for developing and building software. Thanks to its open-source, cross-platform, highly customizable, and powerful features, the GNU Toolchain is widely used in the global developer community. Versions of Nuclei Studio before 2023.10 integrated ``GCC 10``; Nuclei Studio 2023.10 and later integrates ``GCC 13``.

In nuclei_sdk versions later than 0.5.0, you can select ``RISC-V GCC/Newlib (riscv64-unknown-elf-gcc)`` as the toolchain when creating a project to enable ``GCC 13`` compilation, and Nuclei Studio configures the corresponding compile options by default. For issues with ``GCC 10`` and ``GCC 13`` projects, see :ref:`Converting a Project to Support GCC 13 Using the Tool <ide_advanceusage_3>`.

|image2|

Under ``right-click ->Properties->C/C++ Build->Setting->Toolchains`` on the project, you can see the tools used by the project's toolchain and the path where the toolchain is located.

|image3|

Nuclei LLVM Toolchain
~~~~~~~~~~~~~~~~~~~~~

The LLVM Toolchain is a complete toolchain designed for the C family of programming languages, covering the compilation and linking process from source code to executable files. Its core components include the Clang compiler, the LLVM compiler infrastructure, and related tools and libraries. Powerful, flexible, and extensible, the LLVM Toolchain adopts advanced compilation technologies and design concepts to provide developers with efficient compilation and build solutions. Nuclei Studio 2023.10 and later integrate the LLVM Toolchain.

In nuclei_sdk versions later than 0.5.0, you can select ``RISC-V Clang/Newlib (riscv64-unknown-elf-clang)`` as the toolchain when creating a project to enable ``Clang 17`` compilation, and Nuclei Studio configures the corresponding compile options by default.

|image4|

Under ``right-click ->Properties->C/C++ Build->Setting->Toolchains`` on the project, you can see the tools used by the project's toolchain and the path where the toolchain is located.

|image5|

Terapines ZCC
~~~~~~~~~~~~~

Terapines ZCC is a high-performance RISC-V compiler developed by Terapines Technology. Nuclei Studio 2024.06 supports Terapines ZCC and **integrates the ZCC Lite version of the toolchain**. If you need an update, download Terapines ZCC yourself and replace the contents of the ``<NucleiStudio>/toolchain/zcc`` directory. You can create a Terapines ZCC project directly in Nuclei Studio and build it with Terapines ZCC.

For Terapines ZCC, see: https://products.terapines.com/downloads

|image6|

Under ``right-click ->Properties->C/C++ Build->Setting->Toolchains`` on the project, you can see the tools used by the project's toolchain and the path where the toolchain is located. Here you can configure the path of a ZCC compiler you downloaded yourself.

|image7|

Nuclei SDK Project Settings Tool
--------------------------------

In Nuclei Studio, you can use the Nuclei SDK project settings tool to modify the compile and link options of a project created by the Nuclei SDK Project Wizard with one click.

.. note::
    This tool currently only supports Nuclei SDK, HBird SDK, and Nuclei Subsystem SDK. It does not support projects created manually without a template, Makefile-based projects, or projects created and maintained by yourself.

Click to select the project to modify, then open ``RV-Tools>SDK Configuration Tools`` as shown in Figure 6-1 to open the dialog for modifying compile options. **In versions after 2023.10, the Nuclei Settings page is opened directly**. Alternatively, click the project and then click the project settings tool icon in the toolbar.

|image8|

Alternatively, click the project and press ``ctrl+6`` on the keyboard.

|image9|

Alternatively, right-click the project and select SDK Configuration Tools from the context menu.

|image10|

The function of each option in SDK Configuration Tools is described below:

|image11|

-  projectName is the name of the currently selected project.

-  Core is the core corresponding to the current project. Because the tool infers the core from the ARCH and ABI options, and different cores may share the same ARCH and ABI options, the display may deviate slightly. As long as ARCH and ABI are correct, this is not a problem. Use this option to quickly switch core options.

-  Four checkboxes—``Bitmanipulation Extension(RVB)``, ``Cryptography Extension(RVK)``, ``Packed SIMD/DSP Extension``, and ``Vector Extension(RVV)``—are used to select the corresponding extension instruction sets ``(B/K/P/V)``.

   .. note::

       This feature was removed in version 2023.10. Use the ``Other Extensions`` input box to specify additional extensions.

-  ARCH corresponds to the arch option of the current project and is automatically combined according to Core and the checkboxes.

-  ABI corresponds to the abi option of the current project.

-  Tuning is the gcc option optimized for different processor levels. Selecting Core automatically selects the correct Tuning option; adjusting it yourself is not recommended.

-  Code Model is automatically set to ``Medium Low`` for RV32 processors and ``Medium High`` for RV64 processors. Selecting Core automatically selects the appropriate Code Model; RV64 processors must use ``Medium High``.

-  Download corresponds to the download mode of the current project. You can switch between download modes. Currently only the Nuclei FPGA evaluation board supports switching download modes; RVSTAR has only the ``FLASHXIP`` mode. Switching to flash mode additionally defines the ``VECTOR_TABLE_REMAPPED`` macro; other modes do not define this macro.

-  ``Select C Runtime Library`` corresponds to the standard C library used. **This feature was removed in version 2023.10**. If the project was created with Newlib, only the newlib version can be switched here; if the project was created with ``Nuclei C Runtime Library`` (:ref:`libncrt <libncrt_intro>`), only the libncrt version can be switched here.

-  ``Optimization Level`` corresponds to the compile optimization level.

-  ``Extra Common Flags`` corresponds to additional common compile options. You can add extra common compile options.

-  ``Extra C Flags`` corresponds to additional C compile options. You can add extra C compile options.

-  ``Extra C++ Flags`` corresponds to additional C++ compile options. You can add extra C++ compile options.

-  ``Extra ASM Flags`` corresponds to additional assembly compile options. You can add extra assembly compile options.

-  ``Extra Link Flags`` corresponds to additional link options. If this option already contains default options, add your new options at the beginning or end, separated by a space character.

Modify the options above as needed. This example changes the optimization level to ``-Os`` to reduce the size of the generated executable file. Click ``save`` to apply the compile options with one click. After ``save``, you must first clean the project: right-click the project, select ``Clean Project`` from the context menu, and then click the hammer icon to rebuild the project with the modified compile options.

|image12|

Changes made in SDK Configuration Tools do not affect the Debug Configuration options. Therefore, if you switch the Core, you must also modify the corresponding debug configuration (OpenOCD/QEMU/J-Link) manually.

Note that if you switch the project from 32-bit to 64-bit, you must open the debug settings page and change ``set arch riscv:rv32`` in ``command`` to ``set arch riscv:rv64``. When switching back from 64-bit to 32-bit, change this parameter back to the corresponding value.

.. _ide_projectbuild_13:

Build the Hello World Project in Nuclei Studio
----------------------------------------------

To build the Hello World project in Nuclei Studio, follow these steps:

Before building, clean the project first. In the ``Project Explorer`` view, select the ``hello_world`` project, right-click, and select ``Clean Project``.

|image13|

Click the hammer button on the Launch Bar to start building the project. If the build succeeds, you can see the code size of the generated executable file, including the text, data, and bss sections, as well as the total size in decimal and hexadecimal. For a project created with the Makefile method, select ``Build Project`` in the context menu to build it.

|image14|

After a successful build, a Debug folder is added. The function of each file is as follows:

-  ``hello_world.elf`` is the generated executable file.

-  ``hello_world.hex`` is the generated Hex file.

-  ``hello_world.lst`` is the generated list file, where you can see the disassembly and basic code distribution information.

-  ``hello_world.map`` is the generated map file, where you can see the generated code distribution in detail.

|image15|



.. |image1| image:: /asserts/nucleistudio/projectbuild/image2.png

.. |image2| image:: /asserts/nucleistudio/projectbuild/image3.png

.. |image3| image:: /asserts/nucleistudio/projectbuild/image4.png

.. |image4| image:: /asserts/nucleistudio/projectbuild/image5.png

.. |image5| image:: /asserts/nucleistudio/projectbuild/image6.png

.. |image6| image:: /asserts/nucleistudio/projectbuild/image7.png

.. |image7| image:: /asserts/nucleistudio/projectbuild/image8.png

.. |image8| image:: /asserts/nucleistudio/projectbuild/image9.png

.. |image9| image:: /asserts/nucleistudio/projectbuild/image10.png

.. |image10| image:: /asserts/nucleistudio/projectbuild/image11.png

.. |image11| image:: /asserts/nucleistudio/projectbuild/image12.png

.. |image12| image:: /asserts/nucleistudio/projectbuild/image13.png

.. |image13| image:: /asserts/nucleistudio/projectbuild/image14.png

.. |image14| image:: /asserts/nucleistudio/projectbuild/image15.png

.. |image15| image:: /asserts/nucleistudio/projectbuild/image16.png

.. |image17| image:: /asserts/nucleistudio/projectbuild/image17.png

.. |image18| image:: /asserts/nucleistudio/projectbuild/image18.png

.. |image19| image:: /asserts/nucleistudio/projectbuild/image19.png

.. |image20| image:: /asserts/nucleistudio/projectbuild/image20.png

.. |image21| image:: /asserts/nucleistudio/projectbuild/image21.png

.. |image22| image:: /asserts/nucleistudio/projectbuild/image22.png

.. |image23| image:: /asserts/nucleistudio/projectbuild/image23.png

.. |image24| image:: /asserts/nucleistudio/projectbuild/image24.png

.. |image25| image:: /asserts/nucleistudio/projectbuild/image25.png

.. |image26| image:: /asserts/nucleistudio/projectbuild/image26.png

.. |image27| image:: /asserts/nucleistudio/projectbuild/image27.png

.. |image28| image:: /asserts/nucleistudio/projectbuild/image28.png

.. |image29| image:: /asserts/nucleistudio/projectbuild/image29.png

.. |image30| image:: /asserts/nucleistudio/projectbuild/image30.png
