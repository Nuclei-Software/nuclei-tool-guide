.. _projectrun: 

Nuclei Studio 调试运行工程
==========================

.. _ide_projectrun_1:

调试模式管理
------------

在NucleiStudio中，使用Launch Bar管理不同的调试器，默认情况下，NucleiStudio会为OpenOCD、Jlink、Qemu生成对应的 ``*.launch`` 调试文件，NucleiStudio识别到 ``*.launch`` 文件后，会将其加入到Launch Bar中进行管理，用户可以通过以下三种方式来使用指定的调试模式。

|image1|

通过点击工程中的 ``*.launch`` 文件切换不同的调试模式,当用户单击工程中的某一个 ``*.launch`` 文件时，NucleiStudio会将该文件设置为Launch Bar中的选中文件，然后就可以通过Launch Bar执行Run/Debug操作。

|image2|

在工程展开文件，找到 ``*.launch`` 文件并在 ``*.launch`` 文件上点击鼠标右键，在弹出菜单中选中 ``Debug As/Run As`` ,在下一级菜单中点对应的模式开始 ``Run/Debug`` 操作。

|image3|

用户可以通过Launch Bar中的下接框，来切换成不同的调试模式，在Launch Bar中点击展开按钮，然后选中对应的调试模式，并执行 ``Run/Debug`` 操作。

|image4|

.. _ide_projectrun_3:

使用蜂鸟调试器结合OpenOCD调试运行项目
-------------------------------------

安装蜂鸟调试器驱动
~~~~~~~~~~~~~~~~~~

.. note::
    Nuclei Studio自2021.02版本起openocd实现windows免驱功能，使用此版本及以上windows环境的用户可跳过此节，Linux环境仍需配置驱动。低于此版本的用户需按照以下方法安装驱动。

在Windows系统中安装驱动
^^^^^^^^^^^^^^^^^^^^^^^

程序编译成功后，便可以将程序下载到FPGA原型开发板运行。首先将原型开发板与主机PC进行连接，步骤如下。

将蜂鸟调试器的一端插入主机PC的USB接口，另一端与原型开发板连接。由于蜂鸟调试器还包含了 ``将原型开发板输出的UART转换成USB`` 的功能，因此如果蜂鸟调试器被主机PC识别成功（且驱动安装成功），那么将能够被主机识别成为一个COM串口。在主机PC的设备管理器中的 ``端口（COM和LPT）栏目`` 中可以查询到该COM的串口号（譬如COM11）。此串口在后续的程序运行过程中将充当原型开发板运行程序的printf输出显示接口。

|image5|

.. note::
   注意：如果使用蜂鸟调试器，主机PC的Windows系统不能够识别蜂鸟调试器的USB，需要安装驱动，可以在https://www.nucleisys.com/developboard.php#debuggerkit 下载驱动程序并安装。
   
.. note::
   注意：在通过 ``蜂鸟调试器`` 下载之前，需要注意 ``蜂鸟调试器`` 被Windows正确识别，检验的标准即为本节中所述正确地安装了HBird-Driver.exe的驱动，且能够在设备管理器中查询到COM的串口号。

在Linux系统中安装驱动
^^^^^^^^^^^^^^^^^^^^^

在Linux环境下安装驱动步骤如下：

-  1：连接开发板到Linux中，确保USB被Linux识别出来。如果使用虚拟机，确保开发板连到了虚拟机当中。

   |image6|

-  2：在控制台中使用lsusb指令查看信息，参考的打印信息如下：

.. code-block:: shell

   Bus 001 Device 010: ID 0403:6010 Future Technology Devices International, Ltd FT2232xxxx

-  3：控制台中输入sudo vi
   /etc/udev/rules.d/99-openocd.rules指令打开99-openocd.rules文件，输入如下内容，保存退出。

.. code-block:: shell

   SUBSYSTEM=="usb", ATTR{idVendor}=="0403",

   ATTR{idProduct}=="6010", MODE="664", GROUP="plugdev"

   SUBSYSTEM=="tty", ATTRS{idVendor}=="0403",

   ATTRS{idProduct}=="6010", MODE="664", GROUP="plugdev"

-  4：断开调试器再重新连接到Linux系统中。

-  5：使用 ``ls /dev/ttyUSB*`` 命令查看 ``ttyUSB`` 信息，参考输出如下：

   .. code-block:: shell
      
      /dev/ttyUSB0
      
      /dev/ttyUSB1

-  6：使用ls -l /dev/ttyUSB1命令查看分组信息，参考输出如下: 

   .. code-block:: shell

       crw-rw-r-- 1 root plugdev 188, 1 Nov 28 12:53 /dev/ttyUSB1

..

   可以看到ttyUSB1已经加入 ``plugdev`` 组，接下来我们要将自己添加到plugdev组（不同环境可能名字不同，请根据实际情况修改）。使用whoami命令查看当前用户名，我们将其记录为 ``<
   your_user_name >`` 。

-  7：使用 ``sudo usermod -a -G plugdev <your_user_name>`` 命令将自己添加进plugdev组。加入以后一定要重启或者注销操作系统。

-  8：再次确认当前用户名已属于 ``plugdev`` 组，使用 ``groups`` 命令，可以看到打印信息中有 ``plugdev`` 即成功将当前用户添加至plugdev组。如果没有可以尝试重启。

-  9：查看gcc的依赖是否完整,如果有依赖需要安装，可以执行 ``sudo apt install libncursesw5libtinfo5`` 进行安装

.. code-block:: shell

   cd Nuclei Studio/toolchain/gcc/bin/

   ldd ./riscv-nuclei-elf-gdb

|image7|

Debug Configuration
~~~~~~~~~~~~~~~~~~~

使用Nuclei Studio生成的Debug Configuration
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

为了方便用户调试，Nuclei Studio在创建工程时，会根据NPK的配置，默认的生成Debug Configurations的Launch文件。

|image8|

用户可以展开工程，选中对应的 ``test_debug_openocd.launch`` 文件，在右键菜单中，可以 ``Run as/Debug as->test_debug_openocd`` ,就可以按照对应的Debug Configurations操作工程程了。

|image9|

.. note::
   注意：配图可能没有及时更新，导致图文不一致，以文字为准，结合对应版本进行使用。

具体的Debug Configurations的内容可以在Launch Bar中进行详情查看。

|image10|

|image11|


新建并配置Debug Configuration
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

通过Nuclei Studio新建并配置Debug Configuration内容的步骤如下。

在Nuclei Studio的主菜单栏中选择 ``Run—>Debug Configurations`` 。

|image12|

在弹出的窗口中，如果没有当前工程的调试设置内容，右键单击 ``GDB OpenOCD Debugging`` ，选择 ``New`` ，将会为本项目新建出一个调试项目 ``hello_world_demo Debug`` 。确保 ``Project`` 是当前需要调试的工程， ``C/C++ Application`` 中选择了正确的需要调试的ELF文件。
   
|image13|

选择调试项目 ``hello_world_demo Debug`` 的Debugger菜单，在Config options栏目中填入 ``-f "nuclei_sdk/SoC/evalsoc/Board/nuclei_fpga_eval/openocd_evalsoc.cfg"`` ，以确保OpenOCD使用正确的配置文件。这里的配置文件(*nuclei_sdk/SoC/evalsoc/Board/nuclei_fpga_eval/openocd_evalsoc.cfg*)根据实际工程中openocd的配置文件路径而定。例如：如果使用makefile方式导入工程，修改此处的内容为 ``-f "SoC/evalsoc/Board/nuclei_fpga_eval/openocd_evalsoc.cfg"`` 。

如果当前内核是RISC-V 32位内核，请确保Commands内容包含 ``set arch riscv:rv32`` 

如果当前内核为64位，应确保替换为 ``set arch riscv:rv64`` 

|image14|

选择调试项目 ``hello_world_demo Debug`` 的Startup菜单，确保 ``Debug in RAM`` , ``Pre-run/Restart reset`` , ``Set Breakpoint at Main`` 和 ``Continue`` 被勾选。

|image15|

完成配置后点击右下方 ``Apply`` 保存设置。

|image16|

关于Debug Configuration 中Startup 各项设置的具体含义，详细说明一下。首先这里的设定内容都是给GDB 来使用的，所以GDB 执行后做的事情也是按这个页面的顺序来执行。

**Initial Reset** 

可以设定一些让GDB 做init 的命令，具体可以参考GDB init command 的一些用法， 不过因为已经使用IDE了，这里一般不需要勾选。

**Enable semithost** 

这个feature就是semihost， 目前RISC-V OpenOCD 暂时还不支持semihost 功能 （使用J-link 和GDB J-link 调试 可以实现，具体参考IDE 的user guide），所以这里不用勾选。

**Load symbols** 

使用GDB的 ``file`` 命令，让GDB 读取elf 的debug information，这样GDB 才能方便和正确的debug， 这里需要勾选。

**Load executable** 

使用GDB的 ``load`` 命令，让GDB 下载程序到target 端 （这里提醒一下，GDB 做load ，会下载内容到target 端，且会把target 端CPU 的pc 改成当前elf 的entry 位置），这里如果是用调试RAM（比如LM） 的程序，就默认勾选；如果是调试Flash 的程序，这里要看openocd 是否支持flash 的烧写和当前这次调试是否要重新做flash 烧写，如果支持且需要烧写，这里就勾选， 否则不勾选； 如果是ROM 的代码，
这里不要勾选。

**Debug in Ram** 

如果GDB 在load excutable 之后做了reset 等动作，避免cpu 的启动地址和elf 的启动地址不一样或者RAM 的程序因为reset 后不见，就每次在GDB reset 后再load elf 。所以如果是在RAM 里调试，就一定要勾选。

**Pre-run/Reset** 

使用GDB的 ``monitor reset`` 命令， 它给openocd 发reset 命令，openocd 会按RISC-V Debug Spec去驱动nReset信号，这个信号会让core和peripherals都reset （这里也要看具体实现，不过RISC-V Debug Spec 推荐如此，且如果是Nuclei做的example SoC 或者FPGA ，都是follow 这个Spec ），执行reset 后，CPU 的PC 就是reset_vector 地址，然后因为外设都reset，所以RAM 的内容也都清掉。 如果是在RAM里debug，且勾选了这里，那么一定要勾选 ``Debug in RAM`` 。

**Halt** 

使用GDB的 ``monitor halt`` 命令，如后面的括号的注释，它实现的动作就是 OpenOCD 发 ``reset`` 命令后发 ``halt`` 命令，让CPU reset完马上halt住。 

**Set Program counter at** 

使用GDB的 ``set $pc`` 命令，可以再次修改target 端CPU 的PC 地址。

**Set breakpoint at** 

使用GDB的 ``break`` 命令，default 这里是main，如果是初次调试或者调试启动代码 ，建议修改这里，比如_start, 也比如某一个绝对的地址。 

**Continue** 

使用GDB的 ``continue`` 命令。

下图是RISC-V Debug Spec 关于nRESET 的说明。

|image61|


在原型开发板上调试程序
~~~~~~~~~~~~~~~~~~~~~~

在开发板上调试之前，需要打开串口以便观察Printf函数打印信息。

使用Windows系统打开串口的方法如下：

打开Nuclei Studio自带的串口打印通道，选择 ``Window>Show View>Terminal`` ，如图 7‑13所示，点击显示器图标打开串口设置选项。

|image17|

在其窗口中设置Choose terminal（选择串口，即Serial Terminal）、 ``串口号`` （这里以COM11为例）、 ``波特率（设置为115200）`` 等参数后，单击 ``OK`` 按钮。

|image18|

使用Linux系统打开串口方法如下：

打开Nuclei Studio自带的Terminal终端，选择 ``Window>Show View>Terminal`` ，点击显示器图标打开串口设置选项。choose terminal选择 ``Local Terminal`` ，点击OK打开Terminal终端。

|image19|

在框口中输入 ``minicom /dev/ttyUSB1 115200`` 打开串口，即可在Nuclei Studio中查看串口打印信息。
   
|image20|


如果程序员希望能够调试运行于原型开发板中程序，可以使用Nuclei Studio IDE进行调试。由于IDE运行于主机PC端，而程序运行于原型开发板上，因此这种调试也称为 ``在线调试`` 或者 ``远程调试`` 。

这里以1_helloworld为例，使用Nuclei Studio IDE对evalsoc原型开发板进行在线调试的步骤如下：

.. note:: 注意demosoc在Nuclei SDK .5.0中被移除，请使用evalsoc作为替代。

确保Debug设置内容正确，可以打开Debug设置选项确认。在1_helloworld工程处右击，选择 ``Debug As –>Debug Configuration`` 打开Debug设置页面选择之前新建的设置进行检查。

|image21|

确定设置无误后，在下拉框选中Debug，之后左侧图标会变为甲虫图标，单击即可进入调试模式并下载程序进入开发板中。

|image22|

切换至Debug模式，如果下载成功，则会启动调试界面。

   -  如图1号标注位置，这里功能包括单步，运行，汇编级调试等。

   -  如图2号标注位置，这个箭头表示当前程序运行位置。

   -  如图3号标注位置，在代码的左侧双击即可在该行设置断点，再次双击可以取消断点。

   -  如图4号标注位置，这里可以切换编辑模式和调试模式。

   -  如图5号标注位置，这里是函数内变量显示的位置。

   -  如图6号标注位置，这里是查看寄存器数值的位置。图中显示的是PC寄存器当前的数值。

   -  如图7号标注位置，点击这里红色按钮可以退出调试模式。

   -  如图8号标注位置的下方，这里可以使用GDB控制台指令进行调试。

|image23|


下载运行程序
~~~~~~~~~~~~

调试程序没有出现问题后，可以将程序下载进开发板。点击下拉框切换至运行模式，此时左侧图标会切换为绿色运行按键，单击即可将程序下载至开发板并运行。由于调试和下载运行使用相同的设置文件，所以不需要再次设置。

|image24|

程序正常运行后，可以看到串口正确打印出helloworld等信息。

|image25|

如果想要结束程序运行并需要断开连接，在console栏目下点击红色按钮断开连接。

|image26|

使用J-Link调试运行项目
----------------------

安装J-Link驱动并导入RTT文件
~~~~~~~~~~~~~~~~~~~~~~~~~~~

HummingBird Evaluation Board也支持使用J-Link调试。前往SEGGER官网J-Link页面(https://www.segger.com/downloads/jlink/#J-LinkSoftwareAndDocumentationPack)，根据自己的操作系统下载最新的J-Link驱动并安装。注意，J-Link的版本必须高于v6.62版本。

如果使用串口进行打印输出，则可以略过本节后续内容。如果想使用J-Link的RTT打印输出，请按照以下步骤配置。

打开当前工程的设置页面，在 ``Resource`` 选项点击红框标注的图标快速打开工程所在的目录。

|image27|

在 ``nuclei_sdk/SoC/evalsocsoc/Common/Source/Stubs`` 路径下新建一个 ``SEGGER`` 文件夹，此文件夹用来存放RTT相关文件。

|image28|

安装完成后打开J-Link驱动的根目录，将 ``Samples -> RTT`` 路径下的 ``SEGGER_RTT_V680d.zip`` 解压缩（具体压缩包名可能因版本不同而变化）。解压缩后文件内容，将RTT文件夹下的 ``SEGGER_RTT.c`` ， ``SEGGER_RTT.h`` 和 ``SEGGER_RTT_Conf.h`` 三个文件以及Syscalls文件夹下的 ``SEGGER_RTT_Syscalls_GCC.c`` 这些文件复制到之前新建的SEGGER文件夹中。

|image29|

|image30|

最后在IDE中打开 ``SEGGER_RTT_Syscalls_GCC.c`` ，注释 ``#include <reent.h>`` 所在的这一行。

|image31|


文件添加完成后添加SEGGER文件夹路径至include，打开当前工程的设置页面，添加SEGGER文件夹路径至include中。

|image32|


接下来移除原有的write函数。在 ``nuclei_sdk/SoC/evalsoc/Common/Source/Stubs`` 下的 ``write.c`` 文件处右击，选择 ``Resource Configurations –> Exclude from Build`` 。如图 7‑30，选择 ``Select All`` ，点击 ``OK`` 。

|image33|

以后如果想切换回使用串口打印，可以使用相同的方式移除SEGGER文件夹并把 ``write.c`` 文件添加回工程。

|image34|

.. _debug-configuration-1:

Debug Configuration
~~~~~~~~~~~~~~~~~~~~


使用Nuclei Studio生成的Debug Configuration
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

为了方便用户调试，Nuclei Studio在创建工程时，会根据NPK的配置，默认的生成Debug Configurations的Launch文件。

|image35|

用户可以展开工程，选中对应的 ``test_debug_jlink.launch`` 文件，在右键菜单中，可以 ``Run as/Debug as->test_debug_jlink`` ,就可以按照对应的Debug Configurations操作工程程了，

|image36|

具体的Debug Configurations的内容可以在Launch Bar中进行详情查看。

|image37|

|image38|


.. _新建并配置debug-configuration-1:

新建并配置Debug Configuration
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

新建并配置J-Link调试下载的Debug Configuration步骤如下：

在菜单栏中选择 ``Run—>Debug Configurations`` 。在弹出的窗口中，如果没有当前工程的调试设置内容，右键单击 ``GDB SEGGER J-Link Debugging`` ，选择 ``New Configuration`` ，将会为本项目新建出一个调试项目 ``1_helloworld Debug`` 。

|image39|

确保 ``Project`` 是当前需要调试的工程， ``C/C++ Application`` 中选择了正确的需要调试的ELF文件。

|image40|

打开Debugger栏目，确保1号位置 ``Start the J-Link GDB server locally`` 被选中。

2号位置正确指向JLinkGDBServerCL.exe的路径。

3号内是当前使用的内核，这里以N307为例，输入N307即可。如果使用RV-STAR开发板，这里输入GD32VF103VBT6。如果使用其他开发板请参考J-Link Support Device网页，链接如下：https://www.segger.com/downloads/supported-devices.php

4号选择 ``Interface`` 为JTAG， ``initial speed`` 为Auto。

5号确认与使用的GDB设置一致。

如果有修改的内容，点击6号位置 ``Apply`` 保存。

|image41|


打开 ``Startup`` 栏目，确保JTAG/SWD Speed为Auto， ``set Breakpoint at main`` ， ``Continue`` ， ``Pre-run/Restart reset`` 和 ``RAM application`` 选项被勾选，并且取消勾选 ``Initial Reset and Halt`` 选项。

|image42|

以上设置内容完成后，如果有变动需要点击右下角Apply保存设置，如果没有变动点击close即可。

.. _在原型开发板上调试程序-1:

在原型开发板上调试程序
~~~~~~~~~~~~~~~~~~~~~~

使用J-Link在HummingBird Evaluation Board调试需要连接跳线。红框标注的部分是J-Link需要连接到板子的部分。

|image43|

其中VTref连接到板子上 ``V3.3`` 的接口，其他部分连接到JTAG接口，各引脚的丝印就在旁边，一一对应连接即可，最后实物连接如下图。

|image431|


在开发板上调试之前，如果使用串口打印，需要连接JTAG上的串口引脚到自己的主机上，再打开串口以便观察Printf函数打印信息。如果使用RTT打印，需要打开 ``J-Link RTT Viewer`` 查看printf打印信息。按照图中内容设置，选择USB方式连接。Specify Target Device根据使用的内核来修改，这里以N307为例。Target Interface & Speed 设置为 ``1000kHz`` ，可根据实际使用情况来修改。RTT Control Block选择 ``Auto Detection`` 。

|image44|

在Launch Bar的下拉框选中Debug，之后左侧图标会变为甲虫图标，单击即可进入调试模式并下载程序进入开发板中。

|image45|

如果程序下载成功，并且Nuclei Studio会启动调试界面。

-  如图1号标注位置，这里功能包括单步，运行，汇编级调试等。

-  如图2号标注位置，这个箭头表示当前程序运行位置。

-  如图3号标注位置，在代码的左侧双击即可在该行设置断点，再次双击可以取消断点。

-  如图4号标注位置，这里可以切换编辑模式和调试模式。

-  如图5号标注位置，这里是函数内变量显示的位置。

-  如图6号标注位置，这里是查看寄存器数值的位置。

-  如图7号标注位置，点击这里红色按钮可以退出调试模式。

-  如图8号标注位置下方，这里可以使用GDB控制台指令进行调试。

|image46|


下载运行程序
~~~~~~~~~~~~

调试程序没有出现问题后，可以将程序下载进开发板，点击下拉框切换至运行模式，此时左侧图标会切换为绿色运行按键，单击即可将程序下载至开发板并运行。

|image47|

由于调试和下载使用相同的设置文件，所以不需要再次设置。可以看到RTT Viewer正确打印出helloworld等信息。

|image48|

如果需要断开连接，在console栏目下点击红色按钮即可断开连接。

|image49|

.. _ide_projectrun_50:

使用DLink调试运行项目
---------------------

DLink是芯来科技基于RV Link，并在其基础上做功能迭代升级后，所研发的RISC-V调试器，使之更适应于Nuclei Studio的应用场景。目前Dlink仅针对单核RISC-V工程实现调试运行，且已实现量产，具体实物如下,具体关于Dlink固件下载参见 https://github.com/Nuclei-Software/nuclei-dlink/wiki/upload-dlink-firmware。

.. note::
   
   在 **芯来科技视频号** 中有 **如何在Nuclei Studio中通过Dlink调试程** 的视频，您可以在微信中搜索 **芯来科技视频号** 点击查看相关内容。

|image50|

如需使用Dlink进行调试，可以在NucleiStudio菜单中 ``Run -> Run Configurations`` 打开Run Configurations的配置页面，并配置一个Dlink Debug Configuration，双击GDB Custom Debugging新建一个配置项，并在Main选项卡中配置内容如下：

|image51|

**在windows环境下安装驱动步骤如下** ：

   打开GB网站并搜索GD32VF1，在列表中打到GD 32 Dfu Drivers，下载并安装。

   地址：https://www.gd32mcu.com/en/download/7?kw=GD32VF1

   |image52|


**在Linux环境下安装驱动步骤如下** ：

-  1：连接开发板到Linux中，确保USB被Linux识别出来。

-  2：在控制台中使用lsusb指令查看信息，参考的打印信息如下：

.. code-block:: shell

   Bus 003 Device 057: ID 28e9:018a GDMicroelectronics Dlink Low Cost Scheme

-  3：控制台中输入 ``sudo vi /etc/udev/rules.d/50-dlink.rules`` 指令打开50-dlink.rules文件，输入如下内容，保存退出，并执行 ``sudo udevadm control --reload`` 。

.. code-block:: shell

   SUBSYSTEM=="usb", ATTR{idVendor}=="28e9",

   ATTR{idProduct}=="018a", MODE="664", GROUP="plugdev"

   SUBSYSTEM=="tty", ATTRS{idVendor}=="28e9",

   ATTRS{idProduct}=="018a", MODE="664", GROUP="plugdev"

-  4：断开调试器再重新连接到Linux系统中。

-  5：使用 ``ls /dev/ttyACM*`` 命令查看ttyACM信息，参考输出如下：

.. code-block:: shell
   
   /dev/ttyACM0 /dev/ttyACM1 

-  6：使用 ``ls -l /dev/ttyACM0`` 命令查看分组信息，参考输出如下, 可以看到ttyACM0已经被加入到dialout组，接下来我们要将自己添加到 ``dialout`` 组（不同环境可能名字不同，请根据实际情况修改）。使用whoami命令查看当前用户名，我们将其记录为 ``< your_user_name >`` 。

.. code-block:: 
   
   shell crw-rw-r-- 1 root dialout 166, 0 6月 28 15:25 /dev/ttyACM0

-  7：使用 ``sudo usermod -a -G dialout <your_user_name>`` 命令将自己添加进dialout组。加入以后一定要重启或者注销操作系统。

-  8：再次确认当前用户名已属于dialout组，使用groups命令，可以看到打印信息中有dialout即成功将当前用户添加至dialout组。如果没有可以尝试重启。

然后在Debugger选项卡内配置内容如下，因为在Custom Debugging中支持多种Mode，我们现在需要使用Dlink，所以选中Dlink； ``Server check flag`` 是在NucleiStudio中用以确认服务是否正常启动，在Custom GDB Server中如果服务正常启动，会输出一段字符串，NucleiStudio通过判断该字符串以确认Custom GDB Server正常启动，在使用Dlink时这里可以为空；在Config options中需要配置对应的链接文件 ``dlink_gdbserver.cfg`` ，参考配置文件可以在 ``<NucleiStudio>/toolchain/dlink`` 目录下找到。

|image53|

|image54|

在windows下，Dlink连接上PC和开发板后，亮一个绿色灯和一个蓝色灯，说明Dlink处理正常工作状态，否则不正常，可以安NRST键尝试复位。

|image55|

Dlink连接后，在串口工具下，可以看到两个COM口，一个COM串用于串口输出，一般情况下数字低的COM口是调试的，另一个用于串口数据交换，用户需要在dlink_gdbserver.cfg指明用于数据交互的COM口，并配置serial port和serial baud，例于在Windows下 ``serial port COM1`` 、 ``serial baud 115200`` ;在Linux下 ``serial port ttyACM0`` 、 ``serial baud 115200`` ，如果用户不配置，Dlink会使用COM口中编号较小的那个为serial port默认值，并且以其对应的设备号为serial baud默认值，以Windows下为例，可以参考配置如下：

|image56|

开始Debug，如果配置正确，则在Console中有输出如下，并且Dlink亮绿灯。

|image57|

通过串口工具，联接上另一个串口。

|image58|

并可以查看到串口中有正确的内容输出，与预期一致，则Dlink可以正常调试，其他操作步骤与OpenOCD大体一致。

|image59|

.. |image1| image:: /asserts/nucleistudio/projectrun/image2.png


.. |image2| image:: /asserts/nucleistudio/projectrun/image3.png


.. |image3| image:: /asserts/nucleistudio/projectrun/image4.png


.. |image4| image:: /asserts/nucleistudio/projectrun/image5.png


.. |image5| image:: /asserts/nucleistudio/projectrun/image6.png


.. |image6| image:: /asserts/nucleistudio/projectrun/image7.png


.. |image7| image:: /asserts/nucleistudio/projectrun/image8.png


.. |image8| image:: /asserts/nucleistudio/projectrun/image9.png


.. |image9| image:: /asserts/nucleistudio/projectrun/image10.png


.. |image10| image:: /asserts/nucleistudio/projectrun/image11.png


.. |image11| image:: /asserts/nucleistudio/projectrun/image12.png


.. |image12| image:: /asserts/nucleistudio/projectrun/image13.png


.. |image13| image:: /asserts/nucleistudio/projectrun/image14.png


.. |image14| image:: /asserts/nucleistudio/projectrun/image15.png


.. |image15| image:: /asserts/nucleistudio/projectrun/image16.png


.. |image16| image:: /asserts/nucleistudio/projectrun/image17.png


.. |image17| image:: /asserts/nucleistudio/projectrun/image18.png


.. |image18| image:: /asserts/nucleistudio/projectrun/image19.png


.. |image19| image:: /asserts/nucleistudio/projectrun/image20.png


.. |image20| image:: /asserts/nucleistudio/projectrun/image21.png


.. |image21| image:: /asserts/nucleistudio/projectrun/image22.png


.. |image22| image:: /asserts/nucleistudio/projectrun/image23.png


.. |image23| image:: /asserts/nucleistudio/projectrun/image24.png


.. |image24| image:: /asserts/nucleistudio/projectrun/image25.png


.. |image25| image:: /asserts/nucleistudio/projectrun/image26.png


.. |image26| image:: /asserts/nucleistudio/projectrun/image27.png


.. |image27| image:: /asserts/nucleistudio/projectrun/image28.png


.. |image28| image:: /asserts/nucleistudio/projectrun/image29.png


.. |image29| image:: /asserts/nucleistudio/projectrun/image30.png


.. |image30| image:: /asserts/nucleistudio/projectrun/image31.png


.. |image31| image:: /asserts/nucleistudio/projectrun/image32.png


.. |image32| image:: /asserts/nucleistudio/projectrun/image33.png


.. |image33| image:: /asserts/nucleistudio/projectrun/image34.png


.. |image34| image:: /asserts/nucleistudio/projectrun/image35.png


.. |image35| image:: /asserts/nucleistudio/projectrun/image36.png


.. |image36| image:: /asserts/nucleistudio/projectrun/image37.png


.. |image37| image:: /asserts/nucleistudio/projectrun/image38.png


.. |image38| image:: /asserts/nucleistudio/projectrun/image39.png


.. |image39| image:: /asserts/nucleistudio/projectrun/image40.png


.. |image40| image:: /asserts/nucleistudio/projectrun/image41.png


.. |image41| image:: /asserts/nucleistudio/projectrun/image42.png


.. |image42| image:: /asserts/nucleistudio/projectrun/image43.png


.. |image43| image:: /asserts/nucleistudio/projectrun/image44.png


.. |image431| image:: /asserts/nucleistudio/projectrun/image45.png


.. |image44| image:: /asserts/nucleistudio/projectrun/image46.png


.. |image45| image:: /asserts/nucleistudio/projectrun/image47.png


.. |image46| image:: /asserts/nucleistudio/projectrun/image24.png


.. |image47| image:: /asserts/nucleistudio/projectrun/image48.png


.. |image48| image:: /asserts/nucleistudio/projectrun/image49.png


.. |image49| image:: /asserts/nucleistudio/projectrun/image50.png


.. |image50| image:: /asserts/nucleistudio/projectrun/image51.png


.. |image51| image:: /asserts/nucleistudio/projectrun/image52.png


.. |image52| image:: /asserts/nucleistudio/projectrun/image53.png


.. |image53| image:: /asserts/nucleistudio/projectrun/image54.png


.. |image54| image:: /asserts/nucleistudio/projectrun/image55.png


.. |image55| image:: /asserts/nucleistudio/projectrun/image56.png


.. |image56| image:: /asserts/nucleistudio/projectrun/image57.png


.. |image57| image:: /asserts/nucleistudio/projectrun/image58.png


.. |image58| image:: /asserts/nucleistudio/projectrun/image59.png


.. |image59| image:: /asserts/nucleistudio/projectrun/image60.png

.. |image61| image:: /asserts/nucleistudio/projectrun/image61.png


