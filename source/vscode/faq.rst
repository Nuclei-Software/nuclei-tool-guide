.. _vscode_faq:

Nuclei Studio VSCode FAQ
========================

The Nuclei Studio VSCode Icon Does Not Appear in the Activity Bar
-----------------------------------------------------------------

The extension depends on the following companion extensions: Serial Monitor (``ms-vscode.vscode-serial-monitor``), CDT GDB Debug Adapter Extension (``eclipse-cdt.cdt-gdb-vscode``), Memory Inspector (``eclipse-cdt.memory-inspector``), and Peripheral Inspector (``eclipse-cdt.peripheral-inspector``). If any of them was installed before but is disabled, this extension cannot work properly. Enable them one by one in the Extensions view, then reload the window (``Ctrl+Shift+P`` -> ``Developer: Reload Window``).

VS Code Reports That the Workspace Is in Restricted Mode
--------------------------------------------------------

Click the ``Manage`` button in the notification and choose ``Trust`` for the workspace; otherwise the extension features will not work properly.

A "Configure Nuclei Studio Install Folder" Warning Is Shown in the WELCOME Panel
--------------------------------------------------------------------------------

The Nuclei Studio IDE installation folder is not configured. Click the warning item and select the folder where Nuclei Studio IDE is installed, or set ``nucleiStudio.installFolder`` in the VS Code Settings page. See :ref:`vscode_install_folder`.

"Please install the required NPK packages first." When Creating a Project
-------------------------------------------------------------------------

The project wizard requires at least the SSP and BSP packages of your target. Click ``Open NPK Package Management`` in the dialog to install the required NPK packages first; see :ref:`vscode_npk`.

"Current workspace differs from Nuclei Studio VSCode workspace."
----------------------------------------------------------------

The folder opened in VS Code is not the Nuclei Studio workspace. Click the ``Switch to Nuclei Studio VSCode workspace`` entry shown in the WORKSPACE view to switch.

Build Fails Because the Toolchain or ``make`` Cannot Be Found
-------------------------------------------------------------

The paths of the toolchain and build tools are derived from the Nuclei Studio IDE installation folder. Check that ``nucleiStudio.installFolder`` points to a complete Nuclei Studio IDE installation; when it is changed, a warning lists the derived paths that do not exist. See :ref:`vscode_install_folder`.

The Debug Session Does Not Start
--------------------------------

- The project is always built before debugging; if the build fails, the debug session is not started. Fix the build errors first; see :ref:`vscode_projectbuild`.

- If an error such as "GDB executable not found" or "GDB server executable not found" is reported, check the derived toolchain and debug server paths; see :ref:`vscode_install_folder`.

- If "No active Nuclei project found" is reported, select a project in the WORKSPACE view first.

Live Watch Reports That the Feature Is Not Supported
----------------------------------------------------

Live Watch requires a debug session based on Nuclei OpenOCD with the SBA feature, and the CPU must support SBA; it does not work with J-Link, QEMU, or Nuclei Model sessions. If "Unable to connect openocd telnet server" is reported, check the telnet port in the OpenOCD launch configuration. See :ref:`vscode_live_watch`.

Rebuild Index Reports That the C/C++ Extension Is Not Available
---------------------------------------------------------------

IntelliSense and Rebuild Index are implemented through the Microsoft C/C++ extension (``ms-vscode.cpptools``). Install it from the VS Code Marketplace. See :ref:`vscode_intellisense`.

"Debug As..." Is Not Available for a Launch File
------------------------------------------------

The graphical launch configuration editors only support OpenOCD, J-Link, QEMU, and Nuclei Model ``.launch`` files. Other ``.launch`` files (such as QEMU ARM/AArch64 or Custom) can still be used with ``F5`` / Debug Project. See :ref:`vscode_projectrun`.

Where Are the NPK Packages Installed
------------------------------------

Packages are installed under the user path (default: the user home directory) or the global path (default: the ``Packages`` folder of the Nuclei Studio IDE installation), which can be changed with ``nucleiStudio.npk.userPath`` and ``nucleiStudio.npk.globalPath``. See :ref:`vscode_npk`.
