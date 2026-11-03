.. _vscode_update:

Nuclei Studio VSCode Update and Upgrade
=======================================

Update the Extension
--------------------

If the extension is installed from the VS Code Marketplace, it is updated automatically by VS Code; you can also check for updates manually in the Extensions view. If the extension is installed from a local ``nucleistudio.vsix`` package, install the newer package with ``Install from VSIX...`` in the same way as the initial installation (see :ref:`vscode_install`). The extension settings and workspaces are preserved across updates.

Update the Nuclei Studio IDE and Tools
--------------------------------------

The build tools, toolchains, OpenOCD, and Nuclei Model used by the extension come from the Nuclei Studio IDE installation; their versions follow the Nuclei Studio release version (such as 2026.10), not the extension version. To upgrade these tools, upgrade the Nuclei Studio IDE itself; see :ref:`ide_update`.

If the IDE is installed to a new folder, update the ``nucleiStudio.installFolder`` setting to the new installation folder; the paths of the build tools, toolchains, OpenOCD, Nuclei Model, and NPK packages are then derived again automatically (see :ref:`vscode_install_folder`). A warning lists any derived path that does not exist.

Update NPK Packages
-------------------

Open the NPK Package Management page and click ``Refresh`` to get the latest package list from the cloud, then download the new versions of the packages you need; see :ref:`vscode_npk`. Old versions can be removed with ``Remove``.

Update the RISC-V Extension Data
--------------------------------

The extension data used by the RISC-V ISA Extension Selector (see :ref:`vscode_extension_selector`) is updated automatically: the extension checks for new extension data in the background at most once every 7 days, and updates the local cache silently. No manual operation is required; the bundled data is used when offline.
