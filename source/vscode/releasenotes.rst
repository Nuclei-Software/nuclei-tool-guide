.. _vscode_releasenotes:

Nuclei Studio VSCode Release Notes
==================================

2026.10 Release Notes
---------------------

This is the first official release of Nuclei Studio VSCode, a Visual Studio Code extension for developing, building, and debugging embedded applications on Nuclei RISC-V processors. The extension itself is versioned as **0.2.0**, and is released together with **Nuclei Studio 2026.10**, the version of the whole Nuclei Studio package, which integrates the Nuclei Studio IDE, Nuclei RISC-V Toolchain 2026.10, OpenOCD 2026.10, QEMU 2026.10, and Nuclei Near Cycle Model 2026.10.

Nuclei Studio VSCode works on top of the Nuclei Studio IDE and reuses its toolchains, OpenOCD, Nuclei Model, and NPK packages, and the projects it creates are Eclipse CDT compatible and interchangeable with Nuclei Studio IDE.

The main features of this release are as follows.

Project Management
~~~~~~~~~~~~~~~~~~

- New project wizard based on NPK packages: select the SoC/board from the installed SDK packages, choose an application example and the toolchain, and create a ready-to-use project

- Hello World RISC-V C/C++ project templates, usable without installing NPK packages

- Import and export projects; projects created by Nuclei Studio IDE can be imported directly

- Workspace management: switch workspaces, set the active project, rename, delete, and refresh projects

- Project content view with full file operations, keyboard shortcuts, Locate Active File, and Rebuild Index

Project Build
~~~~~~~~~~~~~

- Build, clean, and rebuild projects with the toolchains and build tools shipped with Nuclei Studio IDE, in a CDT compatible managed-build way

- Support for the RISC-V Big Endian GCC/Newlib toolchain, plus an Endian option (``-mbig-endian`` / ``-mlittle-endian``) in the Target Processor settings

- Debug/Release build configurations, with Set Active, Manage, Build All, Clean All, and Build Selected actions

- Build or clean selected source files, and exclude files or folders from the build per configuration

- Build output in the Nuclei Build channel with an error/warning summary

Project Debug and Run
~~~~~~~~~~~~~~~~~~~~~

- Debug schemes based on OpenOCD, J-Link, QEMU, and Nuclei Model, connected through the CDT GDB Debug Adapter

- Graphical editors for OpenOCD, J-Link, QEMU, and Nuclei Model ``.launch`` files, with Main, Debugger, Startup, and SVD Path tabs

- Multiple ways to start a session: Debug Project (``F5``), Debug Project (Select Server), and Debug As / Run As on ``.launch`` files; a debug configuration is generated automatically when no ``launch.json`` exists

- Integration with the Memory Inspector, Peripheral Inspector, and Serial Monitor companion extensions

- Live Watch for real-time variable monitoring without halting the target, with Live Plot curves and CSV export (requires Nuclei OpenOCD with the SBA feature)

NPK Package Management
~~~~~~~~~~~~~~~~~~~~~~

- Browse, download, import, and remove NPK component packages, with dependency resolution and IDE compatibility checks

- User/Global installation paths, derived automatically from the Nuclei Studio IDE installation folder

Project Configuration
~~~~~~~~~~~~~~~~~~~~~

- Nuclei Settings page for quick project configuration: core, RISC-V ISA extensions, tuning, code model, download mode, optimization level, and extra flags

- RISC-V ISA Extension Selector with dependency and conflict handling and ``-march``/``-mabi``/``-mtune`` preview

- Project Properties and Resource Properties pages for advanced project settings

Ease of Use
~~~~~~~~~~~

- Get Started walkthrough guiding through setup, package installation, project creation, build, and debug

- Tool paths derived automatically from the Nuclei Studio IDE installation folder

- IntelliSense support through the Microsoft C/C++ extension

- Nuclei Studio Terminal with the paths of all Nuclei tools set up automatically
