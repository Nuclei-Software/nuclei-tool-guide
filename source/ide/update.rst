.. _ide_update: 

Nuclei Studio 升级更新
======================

在线更新
-----------

.. note::
   Nuclei Studio 2025.10 版本及以后的版本可以使用以下方法对IDE进行在线更新升级。

当 Nuclei Studio 发布新版本后，若检测到用户当前使用的 IDE、插件（Plugin）或配套工具链（如编译器、调试器等）存在可用的更新版本，IDE 在启动时将自动弹出版本升级提示。

Nuclei Studio IDE的安装
~~~~~~~~~~~~~~~~~~~~~~~~~

在 Nuclei Studio 2025.10 之前的版本中，当有新版本 Nuclei Studio 发布时，仅会提示用户手动下载最新版安装包，升级过程需用户自行完成。自 Nuclei Studio 2025.10 版本起，我们引入了全新的在线升级机制：用户可通过内置的升级工具，直接在线下载并自动完成解压与安装，实现 IDE 的一键升级。该改进显著简化了升级流程，提升了操作便捷性与用户体验。

Nuclei Studio启动时，会检测是否存在新版 Nuclei Studio可供下载升级，如若存在将会弹出升级提示框，用户可以选择需要升级的版本以及新版本安装的路径进行升级安装，也可以设置升级提示的频率。

|image5|

-  Updated version 可选升级的Nuclei Studio的版本。

-  Check Frequency 是启动时检测新版本的频率，默认为Every Start。

-  Installation Path 为新版本IDE的安装路径。

除了Nuclei Studio启动时检测到新版本并自动弹窗外，用户也可以通过菜单栏选择 ``Help 🡪 Check for IDE updates`` 来检查IDE的更新。


工具链和插件的安装
~~~~~~~~~~~~~~~~~~~

工具链和插件是 Nuclei Studio 中的重要组成部分，工具链 包括 GCC 编译器、QEMU 模拟器、Nuclei Model 等核心开发组件；插件则用于扩展 Nuclei Studio 功能，支持新特性与调试能力的持续集成。它们的实时更新能带来更好的用户体验。

在 Nuclei Studio 2025.10 之前的版本中，当有新版本工具链和插件发布时，也无法做到在线升级。自 Nuclei Studio 2025.10 版本起，我们引入了全新的在线升级机制：用户可通过内置的升级工具，直接在线下载并自动完成升级与安装。

Nuclei Studio启动时，会检测是否存在新版工具链或插件，如若存在将会弹出升级提示框，用户可以选择需要升级的工具链或插件版本并点击升级，就可以实现自动升级工具链和插件了。

|image6|

-  Name 对应需要升级的工具链或者插件名称。

-  Description 对应需要升级的工具链或者插件的描述。

-  Type 只有Plugin和Toolchain，分别对应为插件和工具链类型。

-  在选中某一项时，Changelog会显示对应需要升级的工具链或者插件的更新日志。

除了Nuclei Studio启动时检测到新版本工具链和插件并自动弹窗外，用户也可以通过菜单栏选择 ``Help 🡪 Check for component updates`` 来检查IDE的更新。


手动更新
-----------

.. note::
   Nuclei Studio 2025.10 之前的版本可以使用以下方法对IDE进行手动更新升级。

当在线更新无法完成时，用户可以手动下载最新的GNU工具链以及其他相关工具和升级IDE Plugins的方式来完成。

工具链的安装
~~~~~~~~~~~~~~~

Nuclei Studio已经把工具链集成在IDE内部，工具链存放在Nuclei Studio_IDE_XXX文件夹内，路径为： ``Nuclei Studio_IDE_XXX\\NucleiStudio\\toolchain`` 。IDE默认使用此路径的工具链，所以请不要移动 ``toolchain`` 此文件夹，使用IDE创建工程后也不需要进行工具链的相关配置。

由于工具链升级的速度会比IDE快，所以后期需要用户手动升级工具链，工具链升级方法如下：

-  首先删除需要更新的GCC或者OpenOCD文件内的内容，然后在芯来科技官网下载最新版本的GCC或者OpenOCD。

-  将GCC或者OpenOCD的内容复制到对应的文件夹下，即可完成IDE工具链的更新，IDE自带的工具链的版本号记录在ReadMe.txt中。

.. note::

   注意：要保证gcc所在的这一级目录文件夹名字不变，替换后保证bin文件夹所在层级是图中文件夹的子目录，中间不要有其他文件夹。

|image1|


IDE Plugins升级
~~~~~~~~~~~~~~~~~

Nuclei Studio支持IDE内在线升级，步骤如下。

打开安装软件弹窗，在菜单栏选择 ``Help 🡪 Install New Software`` 。

|image2|

点击 ``already installed`` 打开已安装界面。

|image3|

选择 ``Nuclei Studio`` ，点击 ``update`` 即可自动完成在线更新。

|image4|

.. |image1| image:: /asserts/nucleistudio/update/image2.png


.. |image2| image:: /asserts/nucleistudio/update/image3.png


.. |image3| image:: /asserts/nucleistudio/update/image4.png


.. |image4| image:: /asserts/nucleistudio/update/image5.png


.. |image5| image:: /asserts/nucleistudio/update/image6.png


.. |image6| image:: /asserts/nucleistudio/update/image7.png


