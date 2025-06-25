.. _faq: 

Nuclei Studio 常见问题
======================

Nuclei Studio启动慢
-------------------

Nuclei Studio是基于eclipse进行开发，继承了eclipse的可扩展性的特点的是同时，也存在着启动较慢的问题，第一次启动时，软件需要验证环境；生成常用的缓存文件；创建Workspace.在2021.09版的Nuclei Studio中，我们针对启动做了优化，在电脑性能足够的前提下，第一次启动Nuclei Studio能在一分钟内完成。

Nuclei Studio最佳运行环境：

-  Windows 10操作系统

-  4G以上内存（2G可以被Nuclei Studio分配使用）

Nuclei Studio编译程序很慢
-------------------------

在测试使用过程中，我们发现Nuclei Studio在编译项目时会出现很慢的现像，经过排查发现，当电脑安装360杀毒软件时，编译指令执行很慢，退出360杀毒软件时，编译指令可以按正常速度执行。为了保障Nuclei Studio的正常使用，建议在使用时退出360等杀毒软件。

找不到New Nuclei RISC-V C/C++ Project菜单
-----------------------------------------

New Nuclei RISC-V C/C++ Project是创建工程的快捷入口，有时候如果找到不到New Nuclei RISC-V C/C++ Project菜单。

|image1|

可以在菜单 ``Window->Perspective->Reset Perspective`` 里进行视图重置， ``New Nuclei RISC-V C/C++ Project`` 就会重新出现。

|image2|

或者将当前视图切换到C/C++视图。

|image3|

打开/关闭Launch Bar
-------------------

Nuclei Studio2022.12及以后的版本中，默认是开户启了Launch Bar功能。打开菜单栏 ``Window -> Preferences`` ，搜索 ``bar`` ，取消勾选第一个选项即可关闭Launch Bar。同理，想要使用Launch
Bar功能，请勾选此选项。

|image4|

使用Launch Bar
--------------

Nuclei Studio的Launch Bar（下图中蓝色框内标注部分）是对后边下拉框中选中的调试配置对应的工程进行编译、调试和下载等操作，如需使用此部分请注意，图标是与下拉框中调试配置内容相绑定。下面详细介绍Launch Bar各部分功能：

|image5|


图标1：编译选中的调试配置对应的工程。此处选中的工程为5号下拉框选中的调试配置对应工程，并非Project Explorer中选中的工程。

图标2：运行/调试选中的调试配置对应的工程。此处图标会根据下拉框4的内容变化。

图标3：退出下载/调试模式。

下拉框4：切换选择下载/调试模式。切换后会改变图标2的显示内容。

下拉框5：选中调试配置文件。此处的内容会影响图标1、2、3对应的工程。

齿轮图标6：打开当前选中的调试配置页面，可直接进行修改保存。

不使用Launch Bar进行运行/调试
-----------------------------

对于初次新建的工程，如果不使用Launch Bar功能，可以右键工程，选择 ``Debug As -> Debug Configurations`` 。在弹窗中选择工程对应的设置选项，这里以helloworld工程为例，选择 ``helloworld_debug_openocd`` ，之后选择 ``Debug`` 开始调试。

同理，初次运行需要右击工程，选择 ``Run As -> Run Configurations`` 。在弹窗中选择工程对应的设置选项，之后选择 ``Run`` 开始运行。

|image6|


若当前工程已按以上方式进行过调试或运行操作，可在上方按键中选择\ |image7|\ 的下拉选项，快速选择对应的工程设置进行调试。对于运行，可以在\ |image8|\ 的下拉选项，快速选择对应的设置。

Debug页面查看寄存器
-------------------

进入Debug模式后，可能有些页面并不能第一时间找到，这里以查看寄存器栏目为例。在菜单栏选择 ``Window -> Show View -> Registers`` 打开寄存器栏目，在Register页面可以通过 ``Ctrl–F`` 来查找寄存器。同样，如果想查看内存，可以选择 ``Window -> Show View -> Memory`` ，想打开调试控制台，可以选择 ``Window -> Show View -> Debugger Console`` ，其他页面此处不做过多介绍，请用户自行体验。

Debug页面结束进程
-----------------

在Debug页面要退出调试，可点击\ |image9|\ 退出调试。为防止打开多个进程导致报错，在Debug页面，右击Debug栏目中的进程，选择 ``Terminate / Disconnect All`` 关闭所有Debug进程。

Nuclei Studio工具栏中各按键功能
-------------------------------

在Nuclei Studio中，常见的工具栏图标如下，本节将依次介绍各按键的功能。

|image10|

新建按键\ |image11|\ ，包括新建各种文件和工程。

保存当前文件\ |image12|\ 和保存所有未保存文件\ |image13|\ 。

切换编译设置\ |image14|\ ，默认只有Debug和Release，用户可自行添加，这里不做介绍。

编译工程\ |image15|\ ，可以在下拉选项中编译Project Explorer中选中的工程。

编译所有工程\ |image16|\ ，一次性编译所有Project Explorer中的工程。

新建功能\ |image17|\ ，包含工程创建，目录创建，文件创建和类创建。

调试\ |image18|\ ，可根据下拉选项选择不同调试设置来调试不同的工程。

运行\ |image19|\ ，可根据下拉选项选择不同的设置来选择不同的工程。

Profile |image20|\ ，使用Profile功能，暂不支持，此处不做介绍。

用户自定义工具\ |image21|\ ，此处不做介绍，用户可自己深入研究。

搜索工具\ |image22|\ ，可搜索任务，文本等。

文本阅读工具\ |image23|\ ，可以展开或折叠文本等功能。

控制台工具\ |image24|\ ，可选择打开各种控制台或串口等。

Debug用\ |image25|\ ，前者跳过所有断点，后者实现Restart功能。

查看CMSIS |image26|\ ，eclipse自带功能，暂不支持。

Nuclei SDK工程设置工具\ |image27|\ ，参见6.6.1。

文本阅读工具\ |image28|\ ，可设置快速跳转，具体功能此处不作过多介绍。

显示其他窗口
------------

在IDE的右上角\ |image29|\ 按键可以切换不同的显示模式，常用的是C/C++页面和Debug页面。其中，在进入Debug模式时，若不在Debug页面，会有弹窗提示，此时点击 ``Switch`` 选项可以切换至Debug页面。在菜单栏中选择 ``Window -> Perspective -> Open Perspective`` 可以快速切换显示窗口。

在不同的窗口下， ``Window -> Show View`` 显示的内容也不尽相同。在Debug窗口中可以选择显示如寄存器（Registers），内存（Memory）和调试控制台（Debugger
Console）。

|image30|

恢复默认窗口布局
----------------

在菜单栏中选择 ``Window -> Perspective -> Reset Perspective`` ，在弹窗中选择 ``Reset Perspective`` 可以恢复窗口默认布局。

对比历史文件
------------

右击要查看历史的文件，选择 ``Compare With -> Local History`` 打开历史记录。在打开的History栏目双击选择要对比的文件历史版本，可以查看文件变动历史。

|image31|

新建工程时可能出现报错
----------------------

新建工程时IDE需要索引整个工程，根据主机性能其所用时间不同。如果主机性能较差，可能会看到索引时产生error，索引结束后error会消失。如出现以上现象，请以编译时是否报错为准。

新增Include路径出现缓存
-----------------------

在include页面新增路径时，可能会出现缓存的路径内容，此时点击Workspace或File System选中后可覆盖其内容。

设置页面栏目找不到
------------------

有时可能因为弹窗大小，部分设置栏目被隐藏起来，可点击红框中左右方向图标显示隐藏栏目。

|image32|

开发板下载速度很慢
------------------

如果遇到开发板下载速度很慢，甚至出现超时的报错，请切换至使用USB3.0接口，如果使用虚拟机开发，也请同时将USB接口设置为3.0。

Linux环境下多用户使用Nuclei Studio
----------------------------------

如果需要多用户同时使用Nuclei Studio（不推荐），用户在运行Nuclei Studio时首先要打开菜单栏的 ``Window->Preferences`` 。在弹窗中需要修改三个地方：

打开 ``MCU->Global OpenOCD Path`` ， ``Executable`` 输入 ``openocd`` ， ``Folder`` 输入 ``${eclipse_home}/toolchain/openocd/bin`` 。

打开 ``MCU->Global QEMU Path`` ， ``Executable`` 输入 ``qemu-system-riscv32`` ， ``Folder`` 输入 ``${eclipse_home}/tools/qemu`` 。

打开 ``MCU->Global RISC-V Toolchains Paths`` ， ``Default toolchain`` 选中 ``RISC-V Nuclei GCC`` ， ``Toolchain folder`` 输入 ``${eclipse_home}/toolchain/gcc/bin`` 。

修改后点击 ``Apply and Close`` 保存并关闭设置弹窗。

设备管理器中识别出两个串口
--------------------------

可能连接设备后在任务管理器中识别出两个串口，其中COM编号较大的是串口打印使用，可以使用串口调试助手等工具连接查看打印信息，但是请不要占用COM编号较小的串口。

|image33|

Linux下使用时报Could not determine GDB version after sending:riscv-nuclei-elf-gdb –version,response:的错误
----------------------------------------------------------------------------------------------------------

第一次在linux下使用Nuclei Studio时，会报错 ``Could not determine GDB version after sending:riscv-nuclei-elf-gdb –version,response:`` .

|image34|

riscv-nuclei-elf-gdb在Nuclei studio 2023.10及之后的版本变更为riscv64-unknown-elf-gdb。

可以使用命令 ``ldd $(which riscv-nuclei-elf-gdb)`` 查看，依赖缺失

|image35|


使用命令 ``sudo apt install libncursesw5 libtinfo5`` 安装相关依赖后，ide运行正常，具体可以参考https://github.com/riscv-mcu/riscv-gnu-toolchain/issues/9

在linux下使用QEMU时报错
-----------------------

例如在Ubuntu 20.04上使用QEMU时，可能会报错：

.. code-block:: shell

    error while loading shared libraries: libfdt.so.1: cannot open shared object file: No such file or directory，

这是因为缺少libfdt.so等依赖所致，只需要在对应版本的linux上安装对应的依赖。例如针对Ubuntu 20.04可以使用如下命令:

安装 libfdt等依赖： ``sudo apt install libfdt1 libpixman-1-0 libpng16-16 libasound2 libglib2.0-0`` 

工程编译链接C库找不到符号报错
-----------------------------

.. _ide_faq_36:

这个问题在Nuclei Studio 2024.06可以得到解决，只需要在 Linker -> Libraries页面勾选 Group Libraries即可。

|image36|

因为在对Libraries的处理中，没有能很好的处理链接之间的内部依赖关系，当使用的链接之前互相有依赖时，可能会导至编译不通过，详细参见\ *https://github.com/eclipse-embed-cdt/eclipse-plugins/issues/592*\ 。解决这个问题，可以有两种办法。

|image37|


通过调整Libraries的顺序或者添加多个链接来实现

|image38|

打开 ``C/C++ Build -> Settings -> Tool Settings ->GUN RISC-V Cross C++ Linker`` ,并修改Command line paatern内容，将其修改为

.. code-block:: shell

   ${COMMAND}
   ${cross_toolchain_flags} ${FLAGS} ${OUTPUT_FLAG}
   ${OUTPUT_PREFIX}${OUTPUT} ${OBJS}${USER_OBJS} -Wl,--start-group
   $(LIBS)
   -Wl,--end-group，

IDE就会将Libraries内的内容以group的方式处理。

|image39|

|image40|


编译工程报错fatal error: rvintrin.h: No such file or directory
--------------------------------------------------------------

在Nuclei Studio
2023.10中，如果使用旧的sdk所创建的工程，如果编译时报错 ``fatal error: rvintrin.h: No such file or directory`` ，是因为在GCC 10时，工程中 ``#include <rvintrin.h>`` ，而在GCC 13中，不需要再 ``#include <rvintrin.h>`` ，只需要删除此行，即可编译通过。

|image41|

Debug时报错Error: Couldn't find an available hardware trigger.
--------------------------------------------------------------

在Nuclei Studio环境中，当工程在没有硬件断点的CPU硬件上运行时，且选择程序下载到Flash中运行以Nuclei SDK/Nuclei N100 SDK为例就是(flash/flashxip DOWNLOAD模式)，可能会遇到程序Debug无法停住的问题，并收到错误提示： ``Error: Couldn't find an available hardware trigger`` 。这是因为程序运行在Flash上，软件断点无法被成功写入，而CPU上又没有硬件断点可以被使用，从而导致报错。

|image43|

这种情况下需要将程序编译到RAM上才可以支持IDE上进行调试（软件断点），如果需要调试则暂时只能通过命令行的方式进行调试。

Debug工程时查看GDB Trace
-------------------------

在Nuclei Studio环境中，GDB Trace功能详细记录了在调试程序过程中使用的GDB命令，默认情况下该功能是关闭，如需要查看GDB Trace，可以开启该功能。在NucleiStudio的菜单中依次点击 ``Window -> Preferences`` ，在弹出的Preferences窗口中依次选择 ``C/C++ -> Debug -> GDB`` ，找到 ``Show the GDB traces consoles with character limit`` 选项并勾选。

|image44|

在Debug时，可以在 ``Console`` 窗口中,点击 ``Display Selected Console`` 切换到GDB Trace Console，就可以查看到GDB Trace，用以帮助分析调试过程中的问题。

|image45|

Debug工程时链接到运行中的Target
--------------------------------

在Nuclei Studio环境中使用OpenOCD Debug工程时，链接到运行中的Target，可以通过如下操作实现。打开Debug_openocd的配置文件，选中 ``Startup`` 页并修改配置如下图：

- Init reset 去掉勾选，避免发 monitor reset 之类的命令导致cpu复位；
- Load executable 去掉勾选，避免重新下载elf；
- Pre-run/restart commands 去掉勾选，避免发 monitor reset 之类的命令导致cpu复位；
- Continue 去掉勾选，当OpenOCD连上去以后，直接进入调试状态且运行暂停。

|image46|

点击Debug按钮，可以看到已经连接到运行中的Target。

|image47|

使用Jlink Debug工程时，链接到运行中的target，可以通过如下操作实现。打开Debug_jlink的配置文件，选中 ``Debugger`` 页并修改配置如下图，点击Debug按钮，可以看到已经连接到运行中的Target。

|image48|

Flash Programming中已知缺陷
--------------------------------

在选中需要使用Flash Programming功能时，如果通过 ``File System`` 选择Load的文件，因代码缺陷会导致命令不完整。为规避此类问题，尽量将需要选择的文件放在工程目录下

|image49|

Flash Programming依赖OpenOCD，当在Nuclei Studio中配置了不启动OpenOCD的前提下使用Flash Programming，会导致Nuclei Studio卡死，如出现上述情况，请确认配置是否正确。

|image50|

.. _faq_27: 

Nuclei Studio调试工程前的硬件检测
---------------------------------

在使用 **Nuclei Studio IDE** 进行软件开发和调试之前，必须确保目标硬件（如基于 FPGA 的 RISC-V 系统）已正确配置并稳定运行。以下步骤可用于验证硬件平台是否具备进行正常软件调试的条件。

检查 OpenOCD 配置文件 `openocd.cfg` 是否正确
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

OpenOCD 是用于与 FPGA 上的 RISC-V 核进行 JTAG 调试的重要工具。要启动调试会话，需准备一个正确的 `.cfg` 配置文件。通过以下步骤以确认`openocd.cfg`文件是否正确。


- 使用 Nuclei Studio 安装目录下的 OpenOCD 工具：
    - Windows：`NucleiStudio/toolchain/openocd/bin/openocd.exe`
    - Linux：`NucleiStudio/toolchain/openocd/bin/openocd`
- 将配置文件（如 `openocd_demosoc.cfg`）复制到 OpenOCD 的 bin 目录中。
- 执行命令启动 OpenOCD：

.. code-block::

    openocd -f openocd.cfg


如果 OpenOCD 成功启动并显示连接信息，则表示 FPGA 板上的 JTAG 接口和 CPU 正常工作。

|image51|

**注意事项：**

- 若 FPGA 上没有 SPI Flash 或无需烧录 Flash，可删除 `.cfg` 文件中关于 Flash 的配置项。
- 确保配置文件中的 JTAG 引脚、CPU 类型、频率等参数与你的硬件一致。

|image52|

使用命令行确认 GDB 与 OpenOCD 能正常通信
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

为了进一步验证硬件状态，可以使用 GDB 命令行工具与 OpenOCD 建立连接。

- 启动 OpenOCD（见上一步）

- 新开终端，进入 GDB 工具路径：
   
   - Windows：`NucleiStudio/toolchain/gcc/bin/riscv-nuclei-elf-gdb.exe`
   - Linux：`NucleiStudio/toolchain/gcc/bin/riscv-nuclei-elf-gdb`

- 启动 GDB，并执行以下命令：

.. code-block:: console

  (gdb) set arch riscv:rv32     # 或 rv64，根据 CPU 架构选择
  (gdb) set remotetimeout 240   # 设置远程连接超时时间
  (gdb) target remote :3333     # 连接 OpenOCD 默认端口


若能成功连接，则表明 FPGA 上的 JTAG 接口和 RISC-V Core 正常运行。

|image53|

**可能问题：**

- FPGA 上的 CPU 主频较低 → 首次连接可能会超时，建议提前设置 `set remotetimeout 240` 。具体可以参考 :ref:`CPU主频比较低导致Nuclei Studio无法调试 <faq_28>` 。 

使用 GDB 命令检查底层硬件功能
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

一旦 GDB 成功连接，可以通过一系列命令验证 CPU、SRAM 和外设寄存器的功能。

|image55|

测试项目及命令：

**读写通用寄存器（GPR）**

.. code-block:: console

    (gdb) p/x $pc        # 查看当前 PC 值
    (gdb) p/x $a0        # 查看 a0 寄存器值


**读写 CSR 寄存器**

.. code-block:: console

    (gdb) info reg $mstatus    # 查看 mstatus 寄存器
    (gdb) info reg $misa       # 查看支持的指令集架构


**读写 SRAM 内存（验证内存稳定性）**

- 准备一个测试 bin 文件，加载到 SRAM：

.. code-block:: console

    (gdb) restore test.bin binary 0x80000000


- 从内存 dump 出来并比对：

.. code-block:: console

    (gdb) dump binary memory dump.bin 0x80000000 0x80001000


- 检查 `test.bin` 和 `dump.bin` 是否完全一致。

如果数据不一致，说明 SRAM 可能存在时序或接口问题。

**8bit/16bit 数据访问测试**

- 验证是否支持字节级访问：

.. code-block:: console

    (gdb) x/1bx 0x80000000      # 读取单个字节
    (gdb) x/1hx 0x80000000      # 读取半字（16位）


**读写 SOC 外设寄存器**

- 对映射在外设地址空间的寄存器进行读写测试：

.. code-block:: console

    (gdb) p/x *(int *)0x10000000   # 读取某个外设寄存器
    (gdb) set *(int *)0x10000000 = 0x1  # 写入值

|image54|

.. _faq_28: 

CPU主频比较低导致Nuclei Studio无法调试
--------------------------------------

如果 CPU 主频较低，可能导致 Nuclei Studio 调试失败或不稳定。此时建议在 OpenOCD 配置文件中降低 JTAG 主频，一般应小于 CPU 主频的一半，推荐设置为 CPU 主频的 1/4 左右。在Nuclei Studio中使用时也需要修改 `set remotetimeout 250` 命令，将超时时间设为较大的值（单位为秒），以提升连接成功率。

|image56|

其他未注明版本问题
==================

如本文档中有疏漏的地方，请关注 `https://www.rvmcu.com/NucleiStudio-faq.html <https://www.rvmcu.com/nucleistudio-faq.html>`__
这里将列出不同版本后续遇到的常见问题。

.. |image1| image:: /asserts/nucleistudio/faq/image2.png


.. |image2| image:: /asserts/nucleistudio/faq/image3.png


.. |image3| image:: /asserts/nucleistudio/faq/image4.png


.. |image4| image:: /asserts/nucleistudio/faq/image5.png


.. |image5| image:: /asserts/nucleistudio/faq/image6.png


.. |image6| image:: /asserts/nucleistudio/faq/image7.png


.. |image7| image:: /asserts/nucleistudio/faq/image8.png


.. |image8| image:: /asserts/nucleistudio/faq/image9.png


.. |image9| image:: /asserts/nucleistudio/faq/image10.png


.. |image10| image:: /asserts/nucleistudio/faq/image11.png


.. |image11| image:: /asserts/nucleistudio/faq/image12.png


.. |image12| image:: /asserts/nucleistudio/faq/image13.png


.. |image13| image:: /asserts/nucleistudio/faq/image14.png


.. |image14| image:: /asserts/nucleistudio/faq/image15.png


.. |image15| image:: /asserts/nucleistudio/faq/image16.png


.. |image16| image:: /asserts/nucleistudio/faq/image17.png


.. |image17| image:: /asserts/nucleistudio/faq/image18.png


.. |image18| image:: /asserts/nucleistudio/faq/image19.png


.. |image19| image:: /asserts/nucleistudio/faq/image20.png


.. |image20| image:: /asserts/nucleistudio/faq/image21.png


.. |image21| image:: /asserts/nucleistudio/faq/image22.png


.. |image22| image:: /asserts/nucleistudio/faq/image23.png


.. |image23| image:: /asserts/nucleistudio/faq/image24.png


.. |image24| image:: /asserts/nucleistudio/faq/image25.png


.. |image25| image:: /asserts/nucleistudio/faq/image26.png


.. |image26| image:: /asserts/nucleistudio/faq/image27.png


.. |image27| image:: /asserts/nucleistudio/faq/image28.png


.. |image28| image:: /asserts/nucleistudio/faq/image29.png


.. |image29| image:: /asserts/nucleistudio/faq/image30.png


.. |image30| image:: /asserts/nucleistudio/faq/image31.png


.. |image31| image:: /asserts/nucleistudio/faq/image32.png


.. |image32| image:: /asserts/nucleistudio/faq/image33.png


.. |image33| image:: /asserts/nucleistudio/faq/image34.png


.. |image34| image:: /asserts/nucleistudio/faq/image35.png


.. |image35| image:: /asserts/nucleistudio/faq/image36.png


.. |image36| image:: /asserts/nucleistudio/faq/image37.png


.. |image37| image:: /asserts/nucleistudio/faq/image38.png


.. |image38| image:: /asserts/nucleistudio/faq/image39.png


.. |image39| image:: /asserts/nucleistudio/faq/image40.png


.. |image40| image:: /asserts/nucleistudio/faq/image41.png


.. |image41| image:: /asserts/nucleistudio/faq/image42.png


.. |image43| image:: /asserts/nucleistudio/faq/image43.png

.. |image44| image:: /asserts/nucleistudio/faq/image44.png

.. |image45| image:: /asserts/nucleistudio/faq/image45.png

.. |image46| image:: /asserts/nucleistudio/faq/image46.png

.. |image47| image:: /asserts/nucleistudio/faq/image47.png

.. |image48| image:: /asserts/nucleistudio/faq/image48.png

.. |image49| image:: /asserts/nucleistudio/faq/image49.png

.. |image50| image:: /asserts/nucleistudio/faq/image50.png

.. |image51| image:: /asserts/nucleistudio/faq/image51.png

.. |image52| image:: /asserts/nucleistudio/faq/image52.png

.. |image53| image:: /asserts/nucleistudio/faq/image53.png

.. |image54| image:: /asserts/nucleistudio/faq/image54.png

.. |image55| image:: /asserts/nucleistudio/faq/image55.png

.. |image56| image:: /asserts/nucleistudio/faq/image56.png

