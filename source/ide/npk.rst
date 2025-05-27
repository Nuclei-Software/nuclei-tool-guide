.. _npk:

Nuclei Studio NPK 应用
=======================

Nuclei Studio 中内建了对Nuclei Package（NPK）功能的完整支持，方便开发者或者创建不同的软件开发包，并且通过Nuclei Package Management方式导入到Nuclei Studio中使用，如果是CPU IP客户，可以将自己的芯片SDK略作改造以支持NPK，并导入到Nuclei Studio中使用，如果是SoC IP客户，可以将提供的SDK打包成Zip包，导入使用，如果是开发者，也可以依赖某个特定的NPK，创建对应的BSP包或者APP包并提供给第三方使用，关于NPK功能的详细介绍，以及后续更新说明参见 https://github.com/Nuclei-Software/nuclei-sdk/wiki/Nuclei-Studio-NPK-Introduction 。通过在原有的SDK中引入npk功能，编写npk.yml可以达到Project Wizard功能的部分定制化。

开发者要使用Nuclei Studio进行工程的创建，需先将对应的SDK NPK Zip包安装到IDE中，方可根据不同的开发板快速新建不同的模板工程，并根据不同的模板添加需要的SDK源码，根据选项生成不同的编译链接选项设置。

.. _npk_package_management:

.. _ide_npk_package_management:

NPK软件包管理
-------------

.. _npk_import_local_package:

导入本地NPK软件包
~~~~~~~~~~~~~~~~~

**导入zip软件包**

当用户拿到一个zip格式的软件包时，可以通过Nuclei Package Management导入一个zip格式的软件包，你可以按照以下的步骤操作：

首先，点击Nuclei Studio IDE工具栏上的 **Nuclei Package Management** 按钮，这将打开npk软件包管理页面。在这个页面上，你可以管理和浏览已安装的软件包，以及导入新的软件包。在这里，我们找到并点击 **Import** 选项。这个选项用于从本地文件系统选择zip类型的软件包。

|image19|

在点击 **Import** 后，系统会提示你选择一个要导入的软件包文件。此时，你需要浏览到你的zip格式软件包所在的目录，并选中它。确保选中的是一个有效的zip包,点击 **打开** ,系统会开始处理并导入这个软件包。

|image20|

|image21|

导入完成后，你应该能够在Nuclei Studio IDE的Package Management页面中看到新导入的软件包。

|image22|

**导入未压缩的npk软件包**

当用户拿到一个未压缩的npk软件包工程时，如果想将它导入到NucleiStudio中，最简单的方式就是通过压缩软件，将其压缩成为一个.zip压缩包，然后通过上述操作导入到NucleiStudio中，如果想一边修改这个npk软件包工程，修改完后快速导入到NucleiStudio中进行测试，可以通过如下操作实现。

直接导入未压缩的软件包，先要将软件包导入到Project Exlorer视图中。点击菜单栏上的File选项，在下拉菜单中，找到并点击 **Import...** 选项。这将打开导入向导，帮助你从本地文件系统或其他来源导入新的项目或文件。

|image23|

然后选择General下的 **Projects from Folder or Archive** 选项,点击Next按钮。

|image24|

接下来，点击 **Directory...** ，这里浏览到你的软件包所在的目录，并选择要导入的文件或文件夹。确保你选择了正确的路径和文件，然后点击 **Finish** 按钮。

|image25|

此时软件包已导入到 **Project Explorer** 视图中，右键点击这个文件夹（代表你的软件包），在弹出的上下文菜单中选择 **Export to Package Management** 并点击，系统会开始处理并导入这个软件包。

|image26|

|image27|

导入过程中，会自动打开Package Management页面。待导入完成后，你应该能够在Nuclei Studio IDE的Package Management页面中看到新导入的软件包。

|image28|


.. _npk_download_cloud_package:

下载云端NPK软件包
~~~~~~~~~~~~~~~~~

在Nuclei Studio中最大的更新，就是将npk云端化，用户直接在Nuclei Studio中就可以下查看到所有的npk并自行安装，在菜单栏选择 ``RV-Tools-->Nuclei Package Management`` 在弹出的 **Nuclei Package Management** 管理页进行npk管理。

|image1|

在Nuclei Package Management页面，先点击一下Refresh获取最新的npk信息，npk安装前状态为Not Installed。

|image2|

然后选中自己想要安装的npk,点击Download进行安装，本教程安装sdk-nuclei_sdk的0.8.0版本，请使用最新版本的NucleiStudio进行安装，最新版本支持gcc14工具链，之前的版本有支持gcc13/gcc10。

|image3|

安装完成后npk状态变为Installed。

|image4|

在NucleiStudio 2024.06及后续的版本中，升级了Nuclei Package Management管理页中关于依赖的管理，大大简化了使用者关于NPK包依赖的问题。

|image5|

当用户在下载/安装某个NPK包时，NucleiStudio会根据当前NPK包信息的依赖关系，再结合本地已安装的包信息及云端共享的NPK信息，给出其的所有依赖，并提示用户进行关联下载安装。

|image6|

当NPK包安装完成后，会提示用户，此安共计安装了多少个NPK包，每个NPK包安装的后状态以及出错的原因。方便用户排查问题。极大的解决的之前版中用户因NPK包依赖的不正确而无法使用的问题。

|image7|

通过NPK创建工程
---------------

本章将在RVSTAR开发板上，以新建和修改GD32VF103的工程为例快速介绍Nuclei Studio功能，RVSTAR开发板开发需要使用nuclei_sdk的npk包，详细的流程请参考之后的章节。

.. _npk_create_project:

创建NPK示例工程
~~~~~~~~~~~~~~~

新建一个工程，可以在菜单栏中，选择 ``File --> New --> New Nuclei RISC-V C/C++ Project`` 。

|image8|

也可以在Project Explorer视图中选中 ``New Nuclei RISC-V C/C++ Project`` 。

|image9|

在弹出的窗口中可以不同的厂商提供的不同版本的SDK,选种某一Board下的SDK,看到相关SoC及Board的介绍。这里以RVSTAR开发板为例，所以这一项选择 ``GigaDevice->GD32VF103->Nuclei GD32VF103 RVSTAR Board->sdk-nuclei_sdk@0.5.0``  。点击 ``Next`` 进入下一步。

.. note::
    **注意**：这里的sdk版本号会随着版本迭代做相应的更新，并且也可能依赖特定版本的Nuclei Studio使用
    
|image10|

进入具体的项目配置页如图所示，因为RVSTAR的内核是固定的N205，其对应的arch和abi分别是rv32imac和ilp32，所以Core选项不能修改。同样，RVSTAR开发板仅支持一种FLASHXIP下载模式，所以DOWNLOAD这一选项也不能修改。点击 ``Finish`` 完成工程创建。在2023.10版本，增加了对Arm项目的支持。

|image11|

Nuclei Studio可以根据不同的工程模板添加不同的SDK源码，例如FreeRTOS模板工程会添加对应的OS内容，Demo_dsp模板工程可以添加NMSIS库文件。关于NMSIS详细信息请参考（\ https://doc.nucleisys.com/nmsis/index.html\ ）。这里以Demo_dsp为例， ``Project Example`` 选择 ``Nuclei NMSIS DSP Library Demo`` 。因为使用dsp工程，需要添加NMSIS库，所以 ``Libraries`` 选择 ``NMSIS DSP Library`` 。

Nuclei Studio可以根据新建工程时的选项自动设置工程的选项。这里选择使用浮点打印，所以 ``NEWLIB`` 选择 ``newlib nano with printf float`` 。之后一直选择 ``Next`` 直到 ``Finish`` 。

.. _npk_sdk_config_tool:

SDK Configuration Tools更改工程配置
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

在Nuclei Studio可以快速修改工程的设置选项，提供了 ``SDK Configuration Tools`` 工具，Nuclei Studio IDE 2022.12版后，对 ``SDK Configuration Tools`` 工具进行了重构，变更为用户体验更好的Nuclei Settings菜单。

新建好的工程，单击要修改的工程名，右击打开右键菜单，选择 ``SDK Configuration Tools`` 打开设置选项工具。

|image12|


如果要修改编译优化等级，修改 ``Optimization Level`` 为 ``None（-O0）`` ，点击 ``Save`` 修改选项。

|image13|

修改成功后在修改后的工程处右击打开右键菜单，选择 ``clean`` 清除一下工程，再点击锤子图标编译工程。

|image14|

.. note::

    - **注意：** SDK Configuration Tools修改编译配置后对调试配置（Debug Configurations）不生效，请手动修改对应的调试配置。

    - **注意：** 后续版本中，将不再维护 ``SDK Configuration Tools`` 功能，由Nuclei Settings菜单功能替代。


为了更好的用户使用体验，Nuclei Studio IDE 2022.12版对 ``SDK Configuration Tools`` 进行了重构，新创建的工程中会多一个Nuclei Settings菜单，双击Nuclei Settings菜单，将打开工程配置工具其在功能上与 ``SDK Configuration Tools`` 无异，在2023.10版本及其后续版本，SDK Configuration
Tools将直接打开这个Nuclei Settings界面。

|image15|

.. _npk_import_tool_package:

通过NPK导入工具
---------------

NPK包除了可以导入SDK,还可以方便的导入各种工具包，来扩展Nuclei Studio的能力，2022.08版本的Nuclei Studio增加NPK Tools的支持，为增加组件包的可扩展性，以及在编译和调试上使用更便捷，增加类型为tool的npk组件包。tool组件包可包含gcc,qemu,cmlink-gdb等内容，以zip包的形式导入到IDE去使用。

以tool-cmlink包为例，一个工具包中有该工具的执行文件及npk.yml，开发者在npk.yml文件中对该工具做了一些简单的描述，如工具包的开发者、版本、支持的操作系统、可执行文件的路径等，包结构和npk.yml内容如下示例。然后将工具包压缩成一个zip文件，可以参考 :ref:`npk_import_local_package` 的内容，将npk tools导入到ide中，或共享到\ `www.rvmcu.com <http://www.rvmcu.com>`__\ 网站上。

- ``bin``

- ``bin\cmlink_gdbserver.exe``

- ``npk.yml``

|image16|


在Nuclei Package Management管理页中同样可以对npk tools进行管理，下载该组件包后，打开任意调试界面，点击 Variables可以查看到该npk tools对应的参数，直接选中对应的参数就可以使用该工具了。

|image17|


一般我们在npk tool中为该组件包扩展变量有4个，每个包存在一个包路径，引用为npk名称-版本号，例如 ``${tool-cmlink-1.0.0}`` ,其他变量的引用为npk名称-版本号-变量名，例如 ``${tool-cmlink-1.0.0-proxy}``, ``${tool-cmlink-1.0.0-system_proxy}`` ,当变量的system值为true时，额外新增一个不带版本号的变量，取最高版 本的该变量，例如 ``${tool-cmlink-system_proxy}`` 。

|image18|


.. |image1| image:: /asserts/nucleistudio/npk/image2.png


.. |image2| image:: /asserts/nucleistudio/npk/image3.png


.. |image3| image:: /asserts/nucleistudio/npk/image4.png


.. |image4| image:: /asserts/nucleistudio/npk/image5.png


.. |image5| image:: /asserts/nucleistudio/npk/image6.png


.. |image6| image:: /asserts/nucleistudio/npk/image7.png


.. |image7| image:: /asserts/nucleistudio/npk/image8.png


.. |image8| image:: /asserts/nucleistudio/npk/image9.png


.. |image9| image:: /asserts/nucleistudio/npk/image10.png


.. |image10| image:: /asserts/nucleistudio/npk/image11.png


.. |image11| image:: /asserts/nucleistudio/npk/image12.png


.. |image12| image:: /asserts/nucleistudio/npk/image13.png


.. |image13| image:: /asserts/nucleistudio/npk/image14.png


.. |image14| image:: /asserts/nucleistudio/npk/image15.png


.. |image15| image:: /asserts/nucleistudio/npk/image16.png


.. |image16| image:: /asserts/nucleistudio/npk/image17.png


.. |image17| image:: /asserts/nucleistudio/npk/image18.png


.. |image18| image:: /asserts/nucleistudio/npk/image19.png

.. |image19| image:: /asserts/nucleistudio/npk/image20.png

.. |image20| image:: /asserts/nucleistudio/npk/image21.png

.. |image21| image:: /asserts/nucleistudio/npk/image22.png

.. |image22| image:: /asserts/nucleistudio/npk/image23.png

.. |image23| image:: /asserts/nucleistudio/npk/image24.png

.. |image24| image:: /asserts/nucleistudio/npk/image25.png

.. |image25| image:: /asserts/nucleistudio/npk/image26.png

.. |image26| image:: /asserts/nucleistudio/npk/image27.png

.. |image27| image:: /asserts/nucleistudio/npk/image28.png

.. |image28| image:: /asserts/nucleistudio/npk/image29.png
