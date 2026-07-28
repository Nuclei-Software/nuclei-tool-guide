.. _ide_update:

Nuclei Studio Update and Upgrade
================================

Online Update
-------------

.. note::
   Nuclei Studio 2025.10 and later can use the following methods to update and upgrade the IDE online.

When a new version of Nuclei Studio is released and the IDE detects that a newer version is available for the IDE, plugins, or accompanying toolchains (such as compilers and debuggers) currently in use, it automatically displays a version upgrade prompt at startup.

Installing Nuclei Studio IDE
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In versions before Nuclei Studio 2025.10, when a new version of Nuclei Studio was released, users had to manually download the latest installation package and perform the upgrade themselves. Starting with Nuclei Studio 2025.10, a brand-new online upgrade mechanism is available: the built-in upgrade tool downloads the new version online and automatically completes extraction and installation, upgrading the IDE with one click. This significantly simplifies the upgrade process and improves the user experience.

When Nuclei Studio starts, it checks whether a new version is available for download and upgrade. If so, an upgrade prompt dialog pops up in which you can select the version to upgrade to and the installation path of the new version, and set the frequency of upgrade prompts.

|image5|

-  Updated version: the Nuclei Studio versions available for upgrade.

-  Check Frequency: the frequency of checking for new versions at startup; the default is Every Start.

-  Installation Path: the installation path of the new IDE version.

In addition to the automatic pop-up at startup when Nuclei Studio detects a new version, you can also select ``Help -> Check for IDE updates`` in the menu bar to check for IDE updates.


Installing Toolchains and Plugins
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Toolchains and plugins are important components of Nuclei Studio. Toolchains include core development components such as the GCC compiler, the QEMU simulator, and Nuclei Model; plugins extend Nuclei Studio functionality and support the continuous integration of new features and debugging capabilities. Keeping them up to date provides a better user experience.

In versions before Nuclei Studio 2025.10, toolchains and plugins could not be upgraded online either. Starting with Nuclei Studio 2025.10, a brand-new online upgrade mechanism is available: the built-in upgrade tool downloads new versions online and automatically completes the upgrade and installation.

When Nuclei Studio starts, it checks whether new versions of toolchains or plugins are available. If so, an upgrade prompt dialog pops up. Select the toolchain or plugin version to upgrade to, then click Upgrade to update the toolchains and plugins automatically.

|image6|

-  Name: the name of the toolchain or plugin to be upgraded.

-  Description: the description of the toolchain or plugin to be upgraded.

-  Type: only Plugin and Toolchain, corresponding to the plugin and toolchain types respectively.

-  When an item is selected, Changelog displays the changelog of the corresponding toolchain or plugin to be upgraded.

In addition to the automatic pop-up at startup when Nuclei Studio detects new versions of toolchains and plugins, you can also select ``Help -> Check for component updates`` in the menu bar to check for component updates.


Manual Update
-------------

.. note::
   Versions before Nuclei Studio 2025.10 can use the following methods to update and upgrade the IDE manually.

When an online update cannot be completed, you can manually download the latest GNU toolchain and other related tools and upgrade the IDE plugins.

Installing the Toolchain
~~~~~~~~~~~~~~~~~~~~~~~~

Nuclei Studio integrates the toolchain inside the IDE. The toolchain is stored in the Nuclei Studio_IDE_XXX folder at the path ``Nuclei Studio_IDE_XXX\\NucleiStudio\\toolchain``. The IDE uses the toolchain at this path by default, so do not move the ``toolchain`` folder. After you create a project with the IDE, no toolchain-related configuration is required.

Because the toolchain is upgraded faster than the IDE, you may need to upgrade the toolchain manually later. To upgrade the toolchain:

-  Delete the contents of the GCC or OpenOCD folder to be updated, then download the latest version of GCC or OpenOCD from the Nuclei System Technology official website.

-  Copy the contents of GCC or OpenOCD into the corresponding folder to complete the IDE toolchain update. The version numbers of the toolchain bundled with the IDE are recorded in ReadMe.txt.

.. note::

   Note: Keep the name of the directory containing gcc unchanged. After replacement, make sure the bin folder is a direct subdirectory of the folder shown in the figure, with no other folders in between.

|image1|


Upgrading IDE Plugins
~~~~~~~~~~~~~~~~~~~~~

Nuclei Studio supports online upgrades within the IDE, as follows.

Open the software installation dialog by selecting ``Help -> Install New Software`` in the menu bar.

|image2|

Click ``already installed`` to open the installed software page.

|image3|

Select ``Nuclei Studio`` and click ``update`` to automatically complete the online update.

|image4|

.. |image1| image:: /asserts/nucleistudio/update/image2.png


.. |image2| image:: /asserts/nucleistudio/update/image3.png


.. |image3| image:: /asserts/nucleistudio/update/image4.png


.. |image4| image:: /asserts/nucleistudio/update/image5.png


.. |image5| image:: /asserts/nucleistudio/update/image6.png


.. |image6| image:: /asserts/nucleistudio/update/image7.png
