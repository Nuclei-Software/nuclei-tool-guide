.. _projectnew: 

Nuclei Studio 创建工程
======================

这里以开发板为Nuclei FPGA Evaluation Board，评估处理器内核为N300FD(rv32imafdc)为例，详细介绍Nuclei Studio中创建项目的常见方式。

在Nuclei Studio IDE创建项目可以有以下几种常见方式：

**使用NPK模板工程自动创建项目**：

这是最简单快捷的方式，目前模板项目功能依赖于Nuclei Studio NPK功能，在导入对应的SDK NPK Zip包，即可在Nuclei Studio上进行模板工程的创建。芯来科技提供了Nuclei SDK、HBird SDK、SoC IP SDK的NPK Zip包，均可导入到IDE中进行工程的创建和使用。

**从已有项目直接导入创建新项目**：

这是最常见的方式，譬如，用户A可以将已有项目的文件夹直接进行打包保存，然后进行分享传播，用户B可以在另外的电脑上直接导入该项目，从而以此为基础创建新的项目，在此基础上直接使用或者开发修改。

**无模板手动创建项目**：

这是最繁琐的方式，该方法除了创建项目之外，还需要手动设置各种选项和路径。由于该方式比较繁琐，所以在实际工作中较少使用，但是通过该方式的详细讲解，用户可以详细了解如何配置各中选项和路径。

**基于已有的Makefile创建项目**：

这种方式比较适合于已经采用Makefile或者其他编译工具的项目，提供一种在IDE中编译工程，清理工程，调试工程的方式。在不修改编译系统的基础上，提供良好的IDE调试环境。

下文将对这几种方式分别进行介绍。

通过NPK模板工程自动创建项目
---------------------------

本节将介绍如何使用模板自动创建项目的方式，在Nuclei Studio IDE创建一个简单的Hello World项目，详细步骤如下。

新建一个工程，可以在菜单栏中，选择 ``File --> New --> New Nuclei RISC-V C/C++ Project`` 。

|image1|


也可以在Project Explorer视图中选中 ``New Nuclei RISC-V C/C++ Project`` 。

|image2|

在弹出的窗口中选择项目类型，这里我们在Nuclei FPGA板，内核是N300FD，SDK为nuclei_sdk@0.8.0 版本来做一个测试开发，选对对应的Board下的SDK, 点击 ``Next`` 进入下一步。

|image3|

在弹出的窗口中设定如下参数。

   -  Project name：项目命名。这里设置为 ``1_helloworld`` 

   -  Project Example：选 ``Simple Helloworld Demo`` 。

   -  Toolchains：我们使用 ``RISC-V GCC/Newlib`` 。

.. note::

   **注意** ：此页面是通过NPK Configuration字段自动解析并生成的页面，不同的SDK或者不同的开发板或者不同的例子都可能会有不同的选项页面，请注意。

我们的内核是N300FD，所以 ``Core`` 选择 ``N300FD`` 。

蜂鸟开发板支持三种下载模式，以下为每种下载模式的简介，这里我们选择ILM模式。

* **ILM**

ILM下载模式程序将被直接下载在MCU的ILM中，并从ILM开始执行。ILM由SRAM组成，会掉电丢失。

* **FLASH**

FLASH下载模式程序代码段的物理地址约束Flash区间，将代码段的逻辑地址约束在ILM的地址区间，意味着程序将被直接下载在MCU的Flash中，但是上电后要通过引导程序将代码段搬运到ILM中，然后从ILM中开始执行。程序被烧写在Flash中，不会掉电丢失。

* **FLASHXIP**

FLASHXIP下载模式程序代码段约束Flash区间，意味着程序将被直接下载在MCU的Flash中，并直接从Flash开始执行。程序被烧写在Flash中，不会掉电丢失。

其他各项可以按需进行配置，点击 ``Finish`` 完成工程创建。

|image4|

使用模板自动创建Hello World项目已经完成。

|image5|

用户可以直接使用菜单栏 ``Project—> Build Project`` 或 |image51| 按钮，来对该项目进行编译。

|image6|

在Hello World项目自动生成过程中，其对应的OpenOCD配置已经同步完成。在项目编译完毕后，用户可以右键点击项目列表 ``Hello  World`` ，点击 ``Debug As —>Debug Configurations`` 开启调试配置面板进行查看。Debug与Run使用相同的配置文件，所以也可通过 ``Run As —>Run Configurations`` 打开。

|image7|

用于调试使用的配置文件 ``Hello World_Debug_OpenOCD`` 已经自动生成。关于使用芯来蜂鸟调试器结合OpenOCD进行下载和调试的方法，可以查看 :ref:`使用蜂鸟调试器结合OpenOCD调试运行项目 <ide_projectrun_3>` 进行详细了解。

|image8|

.. _ide_projectnew_8:

通过应用关联文件导入工程
------------------------

本节将介绍如何通过Nuclei Studio IDE的关联文件，将一个Hello World项目导入到IDE中。Nuclei Studio IDE 2022.12版中，新增了应用文件关联的支持，可以将IDE的启动路径注册到系统注册表中，然后通过特定的文件，可以实现IDE的启动、工程导入等功能，极大的方便了Nuclei Studio IDE用户在使用过程中，对工程的分享和快速导入。

将Nuclei Studio IDE写入到注册表
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

在Nuclei Studio IDE 2022.12及之后的版本，在安装包中多了两个文件 ``install.bat/install.sh`` ,在windows系统下，双击 ``install.bat`` ,因为这里需要写入注册表，所以需要一个用户授权,授权后安装成功；在linux系统下，需要在shell命令下执行 ``install.sh`` 文件。

|image9|

``install.sh`` 文件在运行后，有一个用户授权的界面，同意授权。

|image10|

通过应用关联文件导入工程
~~~~~~~~~~~~~~~~~~~~~~~~

使用Nuclei Studio IDE 2022.12及之后的版本创建工程 ``test`` ，在工程中会有一应用关联文件 ``test.nuproject`` ，如果ide的启动路径已写入注册表，双点 ``test.nuproject`` 文件，系统会自动启动Nuclei Studio IDE并将test工程导入到IDE中。

|image11|


从已有项目直接导入创建新项目
----------------------------

本节将介绍如何使用IDE从已有项目直接导入创建新项目，本文以N307的项目包为例进行导入，项目包存放在（\ https://github.com/riscv-mcu/Nuclei-Studio_IDE-Project-Package\ ）。如需其它项目包请与芯来科技联系。

在基于Windows的Nuclei Studio IDE开发环境中，如果用户使用 ``无模板手动创建工程`` ，也需要加载此项目包中的nuclei-sdk文件夹，相关内容会在 :ref:`无模板手动创建项目 <ide_projectnew_16>` 中具体介绍。

|image12|

将nuclei-eclipse_demo.rar压缩包下载解压后，内容分别为：

|image13|

-  项目包的描述文件 ``.setting`` ， ``.project`` 和 ``.cproject`` 

-  项目包的Debug设置文件 ``*.launch`` 

-  nuclei_sdk文件夹

该文件夹下存放部分SDK源代码。

-  application文件夹

此文件夹包含hello_world样例程序的main函数源代码。

下一步导入下载好的项目包，导入步骤如下：

-  在菜单栏中选择 ``File—>import`` 。

-  如图所示，选择 ``Existing Project into WorkSpace`` 后，点击 ``Next`` 。

|image14|


-  点击 ``Browse`` ，选择需要导入的项目路径，如图所示。

|image15|


-  需要的导入的项目成功被IDE识别，点击 ``Finish`` 。

|image16|

-  在IDE的项目资源管理器中显示导入项目的目录结构如下图所示。已有项目默认为N307的编译选项，Nuclei SDK仅包含helloworld使用到的文件。需要更多的Nuclei SDK源码请访问Github（https://github.com/riscv-mcu/hbird-sdk）获取源码。

|image17|

.. _ide_projectnew_16:

无模板手动创建项目
------------------

本节将介绍如何使用手动方式在Nuclei Studio IDE创建一个用户自定义的Hello World项目。开发板为Nuclei FPGA Evaluation
Board，内核为N307。该方法除了创建项目之外，还需要手动设置各种选项和路径，详细步骤如下。

.. note::
    不建议使用，建议使用NPK模板的方式创建工程

手动创建项目
~~~~~~~~~~~~

在Nuclei Studio的主菜单栏中，依次选择 ``File—> New —> C/C++ Project`` 。

|image18|



然后在弹出的窗口中设定如下参数。

   -  Project name：项目命名。

   -  Use default
      location：如果勾选了此选项，则会使用默认Workspace文件夹存放此项目。

   -  Project type：选择 ``Hello World RISC-V C Project`` 。
   
|image19|


然后点击Next进入下一步，在弹出的窗口中设置Hello World项目的基本信息。确保 ``Source`` 选项内容为空，直接单击 ``Next`` 进入下一步。

|image20|

在弹出的窗口中设置项目的调试或者发布属性。该步骤可以使用默认信息不做任何修改，直接单击 ``Next`` 进入下一步。

|image21|

在弹出的窗口中设置项目所使用的RISC-V工具链。此处不要配置，直接选择 ``Finish`` ，至此便完成了HelloWorld项目的创建。

|image22|

创建完成，Hello World项目的展示界面如下。

|image23|

新建一个application文件夹。在工程处右击选择 ``New —> Folder`` ，输入application，点击 ``Finish`` 完成新建工程。将main.c拖入application文件夹完成文件分类。

|image24|


配置项目的nuclei_sdk
~~~~~~~~~~~~~~~~~~~~

本节介绍如何将nuclei_sdk加入到项目中，SDK的具体内容本文不做详细介绍，可以参考\ https://doc.nucleisys.com/nuclei_sdk/index.html\ 。如果需要使用SDK的其他源文件，请到Github获取全部的Nuclei
SDK源码（这里以0.3.9版本为例），链接如下：\ https://github.com/Nuclei-Software/nuclei-sdk/releases
。本节仅介绍将nuclei_sdk中helloworld需要的文件加入到项目的步骤，如果使用新版本的SDK，对应的目录结构可能有所调整，请自行解决，具体步骤如下：

进入Nuclei Studio的 ``2_helloworld`` 项目，按照如下步骤添加nuclei_sdk源文件。

在Project Explorer栏中选中 ``2_helloworld`` 项目，单击鼠标右键，选择 ``Properties`` 打开工程设置页面。

|image26|

在弹出的窗口中单击 ``Resource`` ，在右侧的Location栏目中单击其最右侧的箭头图标\ |image25|\ ，则会弹出文件窗口进入 ``2_helloworld`` 项目的文件夹位置。

|image26|

将nuclei-eclipse_demo.rar压缩包中的nuclei_sdk文件夹复制放于 ``2_helloworld`` 项目的目录下。

|image27|

回到Nuclei Studio，在Project Explorer栏中选中 ``2_helloworld`` 项目，单击鼠标右键，选择 ``Refresh`` 。

|image29|

Refresh之后 ``2_helloworld`` 项目的下便可以看到nuclei_sdk文件夹，至此便完成了nuclei_sdk源文件的导入。

|image30|

配置项目的编译和链接选项
~~~~~~~~~~~~~~~~~~~~~~~~

为了使项目源代码能够被正确编译，需要配置编译和链接选项。

.. note::
    注意：本节中设置的编译与链接选项均为GCC工具链的常用选项，与在Linux环境中使用时的同名选项含义一致，本节在此不做赘述介绍。

配置编译与连接选项的步骤如下：

在Project Explorer栏中选中hello_world项目，单击鼠标右键，选择 ``Properties`` 。

在弹出的窗口中，展开C/C++ Build菜单，单击 ``Setting`` ，在右侧的Tool Settings栏目中进行设置。

选中Target Processor，我们的内核是N307，因此需要按照图所示勾选配置选项，分别如下。

   -  Architecture：选择 ``RV32I`` 。

   -  Multiply extension（RVM）：需勾选。

   -  Atomic extension（RVA）：需勾选。

   -  Compressed extension（RVC）：需勾选。

   -  Integer API：选择 ``ILP32`` 。

   -  Floting Point ABI：选择 ``single precision`` 

   -  Code model：选择 ``Medium Any`` 。

   -  单击右下角的 ``Apply`` 按钮。
   
|image31|


选中 ``Optimization`` ，按照图所示勾选配置选项。

   -  Optimization Level：选择 ``Optimization Most (-O2)`` 。

.. note::
    注意：在NucleiStudio 2024.06版本中新增了 ``-Oz``，用来优化编译后程序的尺寸。

依次勾选：

   -  Function Sections (-ffunction-sections)

   -  Data Sections (-fdata-sections)

   -  No common unitialized (-fno-common)

.. note::
    注意：上述选项均为通用的GCC编译优化选项，请用户自行查阅GCC手册了解其含义。

单击右下角的 ``Apply`` 按钮。

|image32|


选中Debugging，按照图中所示勾选配置选项，分别为：

   -  Debug Level：选择 ``Default (-g)`` 。

   -  单击右下角的 ``Apply`` 按钮。

|image33|



选中GNU RISC-V Cross C Linker的General。按照如下步骤设置链接器的所需的链接脚本。

  -  选中右上角的加号按键。

  -  在弹出的窗口中单击 ``Workspace`` 按钮。

  -  这里我们使用HummingBird评估板，所以可以选择ILM下载模式对应的 ``gcc_hbird_ilm.ld`` 文件。在弹出的窗口中选择Nuclei Studio文件包中的 ``nuclei_sdk/SoC/hbird/Board/hbird_eval/Source/GCC`` 文件夹下 ``gcc_hbird_ilm.ld`` 文件。其他下载模式切换此处文件，各文件详细介绍如下，可根据自己的实际情况选择。

     -  ``gcc_hbird_ilm.ld`` 脚本将程序代码段约束在ILM的地址区间，意味着程序将被直接下载在MCU的ILM中，并从ILM开始执行。ILM由SRAM组成，会掉电丢失。

     -  ``gcc_hbird_flash.ld`` 脚本程序代码段的物理地址约束Flash区间，将代码段的逻辑地址约束在ILM的地址区间，意味着程序将被直接下载在MCU的Flash中，但是上电后要通过引导程序将代码段搬运到ILM中，然后从ILM中开始执行。

     -  ``gcc_hbird_flashxip.ld`` 
        脚本程序代码段约束Flash区间，意味着程序将被直接下载在MCU的Flash中，并直接从Flash开始执行。程序被烧写在Flash中，不会掉电丢失。

     -  用户可以按照自己的需求选择合适的链接脚本。本节示例选择 ``gcc_hbird_ilm.ld`` 作为演示。

  -  设置完毕请单击右下角的 ``Apply`` 按钮。

|image34|

按下图所示勾选配置选项，分别如下。

   -  Do not use standard start files (-nostartfiles) 。

   -  Remove unused sections (--gc-sections)。

   -  单击右下角的 ``Apply`` 按钮。

.. note:: 注意：上述选项均为通用的GCC链接选项，请用户自行查阅GCC手册了解其含义。

|image35|

.. note::
    注意：在NucleiStudio 2024.06版本中Libraries支持Group功能，如果勾选了Group功能，所有的Libraries在编译时会用 ``-wl,--start-group,……,--end-group,`` ，能解决Libraries内相互依赖的问题。

|image36|

选中GNU RISC-V Cross C Linker的Miscellaneous，按照下图所示勾选配置选项。

   -  勾选 ``Use newlib-nano`` 。

   -  因为Hello World程序的Printf不需要打印浮点数，所以不要勾选 ``Use float with nano printf`` 。

   -  单击右下角的 ``Apply`` 按钮。

|image37|

配置项目的包含路径和文件
~~~~~~~~~~~~~~~~~~~~~~~~

为了能够正确编译nuclei_sdk文件夹中的源文件，需要按照如下步骤配置项目的包含路径和包含文件。

在Project Explorer栏中选中hello_world项目，点击鼠标右键，选择 ``Properties`` 。
   
|image26|

在弹出的窗口中，展开C/C++ Build菜单，单击 ``Setting`` ，在右侧的Tool Settings栏目中进行设置。

选中GNU RISC-V Cross C Assembler的Includes，按照图中所示配置包含文件，步骤如下。
   
|image38|

   -  在Include paths栏目单击加号键。

   -  在弹出的窗口中单击 ``Workspace`` ，弹出Folder selection窗口。

   -  在Folder selection窗口中选择项目的nuclei_sdk目录下的NMSIS>Core>Include文件夹。

   -  在右下角单击 ``Apply`` 完成配置。

采用上述方法，依次添加nuclei_sdk目录下的 ``SoC>hbird>Board>hbird_eval>Include`` ， ``SoC>hbird>Common>Include`` 和 ``SoC>hbird>Common>Source>Stubs`` 文件夹作为包含路径，并采用同样的方法为 ``GNU RISC-V Cross C  Compiler`` 的 ``Includes`` 栏目设置包含路径。设置完成后的界面如下图所示。

|image39|

基于已有的Makefile创建项目
--------------------------

本节将介绍如何使用已有的Makefile在Nuclei Studio IDE创建一个使用Makefile的Hello World项目。开发板为Nuclei FPGA Evaluation Board，内核为N307。请先下载Nuclei SDK，Github链接为：\ https://github.com/Nuclei-Software/nuclei-sdk\ 。该方法除了创建项目之外，还需要手动设置各种选项和路径，这里以helloworld为例，详细步骤如下。

手动新建项目
~~~~~~~~~~~~

在菜单栏中选择 ``File—> New —> Makefile Project with Existing Code`` 。

|image40|

在图标1处输入工程名，这里我们命名为nuclei-sdk。在图标2处输入SDK的实际路径。在图标3处选择 ``RISC-V Cross GCC`` 。点击图标4完成新建项目。

|image41|

设置Makefile路径和Build选项
~~~~~~~~~~~~~~~~~~~~~~~~~~~

右击新建好的工程，选择 ``Properties`` 打开设置页面，选择 ``C/C++ uild`` ，在 ``Build Location`` 中选择 ``Workspace`` 。在弹出的弹窗中选择 ``application –> baremetal –> helloworld`` 点击 ``OK`` 再点击 ``Apply`` 保存。

|image42|

在 ``C/C++ Build`` 中选择 ``Behavior`` 栏目，确保勾选 ``Build（Incremental Build）`` 选项并输入 ``all CORE=n307 DOWNLOAD=ilm`` 。其中 ``CORE`` 选项根据实际的内核变化，这里以n307为例。 ``DOWNLOAD`` 选项可以修改不同的下载模式，详细请参考5.1节，这里以ilm模式为例。因为例程使用HummingBird
Evaluation Board，所以SoC和Board都不必修改，如果使用其他开发板，以RVSTAR为例，请在此处设置增加 ``SOC=gd32vf103 BOARD=gd32vf103v_rvstar`` ，并且由于RVSTAR仅支持FLASHXIP模式，需要将 ``DOWNLOAD`` 设置为 ``flashxip`` ，同时 ``CORE`` 修改为 ``n205`` 。完成后点击 ``Apply`` 保存修改。

|image43|

在完成上述操作后，打开工具链配置页，点击 ``Apply`` 保存修改。

|image44|

.. |image1| image:: /asserts/nucleistudio/projectnew/image2.png


.. |image2| image:: /asserts/nucleistudio/projectnew/image3.png


.. |image3| image:: /asserts/nucleistudio/projectnew/image4.png


.. |image4| image:: /asserts/nucleistudio/projectnew/image5.png


.. |image5| image:: /asserts/nucleistudio/projectnew/image6.png


.. |image51| image:: /asserts/nucleistudio/projectnew/image7.png


.. |image6| image:: /asserts/nucleistudio/projectnew/image8.png


.. |image7| image:: /asserts/nucleistudio/projectnew/image9.png


.. |image8| image:: /asserts/nucleistudio/projectnew/image10.png


.. |image9| image:: /asserts/nucleistudio/projectnew/image11.png


.. |image10| image:: /asserts/nucleistudio/projectnew/image12.png


.. |image11| image:: /asserts/nucleistudio/projectnew/image13.png


.. |image12| image:: /asserts/nucleistudio/projectnew/image14.png


.. |image13| image:: /asserts/nucleistudio/projectnew/image15.png


.. |image14| image:: /asserts/nucleistudio/projectnew/image16.png


.. |image15| image:: /asserts/nucleistudio/projectnew/image17.png


.. |image16| image:: /asserts/nucleistudio/projectnew/image18.png


.. |image17| image:: /asserts/nucleistudio/projectnew/image19.png


.. |image18| image:: /asserts/nucleistudio/projectnew/image20.png


.. |image19| image:: /asserts/nucleistudio/projectnew/image21.png


.. |image20| image:: /asserts/nucleistudio/projectnew/image22.png


.. |image21| image:: /asserts/nucleistudio/projectnew/image23.png


.. |image22| image:: /asserts/nucleistudio/projectnew/image24.png


.. |image23| image:: /asserts/nucleistudio/projectnew/image25.png


.. |image24| image:: /asserts/nucleistudio/projectnew/image26.png


.. |image25| image:: /asserts/nucleistudio/projectnew/image27.png


.. |image26| image:: /asserts/nucleistudio/projectnew/image28.png


.. |image27| image:: /asserts/nucleistudio/projectnew/image29.png


.. |image28| image:: /asserts/nucleistudio/projectnew/image30.png


.. |image29| image:: /asserts/nucleistudio/projectnew/image31.png


.. |image30| image:: /asserts/nucleistudio/projectnew/image32.png


.. |image31| image:: /asserts/nucleistudio/projectnew/image33.png


.. |image32| image:: /asserts/nucleistudio/projectnew/image34.png


.. |image33| image:: /asserts/nucleistudio/projectnew/image35.png


.. |image34| image:: /asserts/nucleistudio/projectnew/image36.png


.. |image35| image:: /asserts/nucleistudio/projectnew/image37.png


.. |image36| image:: /asserts/nucleistudio/projectnew/image38.png


.. |image37| image:: /asserts/nucleistudio/projectnew/image39.png


.. |image38| image:: /asserts/nucleistudio/projectnew/image40.png


.. |image39| image:: /asserts/nucleistudio/projectnew/image41.png


.. |image40| image:: /asserts/nucleistudio/projectnew/image42.png


.. |image41| image:: /asserts/nucleistudio/projectnew/image43.png


.. |image42| image:: /asserts/nucleistudio/projectnew/image44.png


.. |image43| image:: /asserts/nucleistudio/projectnew/image45.png


.. |image44| image:: /asserts/nucleistudio/projectnew/image46.png


