.. _update: 

Nuclei Studio 升级
==================

一般情况下，如果Nuclei Studio没有大的版本变动，Nuclei Studio升级工作可以由用户下载最新的GNU工具链以及其他相关工具和升级IDE Plugins的方式来完成。

GCC/OpenOCD等工具链的安装
-------------------------

Nuclei Studio已经把工具链集成在IDE内部，工具链存放在Nuclei Studio_IDE_XXX文件夹内，路径为： ``Nuclei Studio_IDE_XXX\\NucleiStudio\\toolchain`` 。IDE默认使用此路径的工具链，所以请不要移动 ``toolchain`` 此文件夹，使用IDE创建工程后也不需要进行工具链的相关配置。

由于工具链升级的速度会比IDE快，所以后期需要用户手动升级工具链，工具链升级方法如下：

-  首先删除需要更新的GCC或者OpenOCD文件内的内容，然后在芯来科技官网下载最新版本的GCC或者OpenOCD。

-  将GCC或者OpenOCD的内容复制到对应的文件夹下，即可完成IDE工具链的更新，IDE自带的工具链的版本号记录在ReadMe.txt中。

.. note::

   注意：要保证gcc所在的这一级目录文件夹名字不变，替换后保证bin文件夹所在层级是图中文件夹的子目录，中间不要有其他文件夹。

|image1|


IDE Plugins升级
---------------

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


