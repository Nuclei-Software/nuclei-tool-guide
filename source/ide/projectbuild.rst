.. _projectbuild: 

Nuclei Studio 编译工程
======================

在NucleiStudio中，支持多种Toolchain，以便用户在创建工程时，可以选择不同的Toolchain对工程进行编译。NucleiStudio中已经集成了GCC 13、Clang 17、ZCC Lite三款编译器，用户无需下载即可使用。

|image1|

* **RISC-V Nuclei GCC (riscv-nuclei-elf-gcc)**

早期NucleiStudio对GCC 10编译器的支持，Nuclei Studio 2023.10及之后版本弃用，如果用户需要对GCC 10的支持，需要自行下载Nuclei RISC-V Toolchain 2022.12(gcc10)并替换 ``<NucleiStudio>/toolchain/gcc10`` 目录内容。

* **RISC-V GCC/Newlib (riscv64-unknown-elf-gcc)**

Nuclei Studio 2023.10及之后对GCC 13编译器的支持，对应的软件包存放在 ``<NucleiStudio>/toolchain/gcc`` 目录。

* **RISC-V Clang/Newlib (riscv64-unknown-elf-clang)**

Nuclei Studio 2023.10及之后对Clang 17编译器的支持，对应的软件包存放在 ``<NucleiStudio>/toolchain/gcc`` 目录。

* **Terapines ZCC (zcc)**

Nuclei Studio 2024.06版本对ZCC编译器的支持，对应的软件包存放在 ``<NucleiStudio>/toolchain/zcc`` 目录。Terapines ZCC工具链工程的创建需要依赖Nuclei SDK **> 0.6.0之后** 的版本才可以,目前可以通过Nuclei SDK命令行的方式进行测试。

编译工具
--------

Nuclei GNU Toolchain
~~~~~~~~~~~~~~~~~~~~

GNU Toolchain 是由 GNU 项目提供的一套完整的软件开发工具链，它包括了编译器、调试器、链接器、库文件等一系列用于软件开发和构建的必需工具。GNU Toolchain 以其开源、跨平台、高度可定制和强大的功能特性，成为了全球开发者社区广泛使用的开发工具集。Nuclei Studio 2023.10之前的版本中集成了 ``GCC 10`` ；Nuclei Studio 2023.10及之后的版本中，集成了 ``GCC 13`` 。

在nuclei_sdk 0.5.0之后的版中，在创建工程时，用户可以选择Toolchain为 ``RISC-V GCC/Newlib（riscv64-unknown-elf-gcc）`` 则可以创建一个支持 ``GCC 13`` 编译的工程，NucleiStudio将默认将相对应的编译选项配置好。关于 ``GCC 10`` 与 ``GCC 13`` 工程的问题，可以参阅 :ref:`通过工具将工程转换成支持gcc 13的工程 <ide_advanceusage_3>` 。

|image2|

在工程上 ``右键->Properties->C/C++ Build->Setting->Toolchains`` 中可以看到工程所用到的Toolchains有一些工具，以及Toolchains所在的路径。

|image3|

Nuclei LLVM Toolchain
~~~~~~~~~~~~~~~~~~~~~

LLVM Toolchain是一套为C系列编程语言设计的完整工具链，旨在提供从源代码到可执行文件的编译和链接过程。LLVM Toolchain的核心组件包括Clang编译器、LLVM编译器基础设施以及相关的工具和库。LLVM Toolchain是一套功能强大、灵活可扩展的编译工具链，它采用了先进的编译技术和设计理念，为开发者提供了高效、便捷的编译和构建解决方案。Nuclei Studio 2023.10及之后的版本中，集成了LLVM Toolchain。

在nuclei_sdk 0.5.0之后的版中，在创建工程时，用户可以选择Toolchain为 ``RISC-V Clang/Newlib（riscv64-unknown-elf-clang）`` 则可以创建一个支持 ``Clang 17`` 编译的工程，NucleiStudio将默认将相对应的编译选项配置好。

|image4|

在工程上 ``右键->Properties->C/C++ Build->Setting->Toolchains`` 中可以看到工程所用到的Toolchains有一些工具，以及Toolchains所在的路径。

|image5|

Terapines ZCC
~~~~~~~~~~~~~

Terapines ZCC是兆松科技研发的高性能RISC-V编译器。Nuclei Studio 2024.06版中对Terapines ZCC进行支持， **集成了ZCC Lite版本的工具链** ，如果需要更新，可以自行下载好Terapines ZCC后，替换 ``<NucleiStudio>/toolchain/zcc`` 目录下的内容，可以在NucleiStudio中直接创建一个支持Terapines ZCC的工程，并使用Terapines ZCC进行编译。

关于Terapines ZCC参见：https://products.terapines.com/downloads

|image6|

在工程上 ``右键->Properties->C/C++ Build->Setting->Toolchains`` 中可以看到工程所用到的Toolchains有一些工具，以及Toolchains所在的路径。在这里可以配置用户所下载的ZCC编译器的路径。

|image7|

Nuclei SDK 工程设置工具
-----------------------

在Nuclei Studio中可以通过Nuclei SDK工程设置工具一键修改通过Nuclei SDK Project Wizard创建的工程的编译链接选项。

.. note::
    本工具目前仅支持Nuclei SDK，HBird SDK，Nuclei Subsystem SDK,不支持无模板手动创建的项目和基于Makefile创建的项目, 或者是自行创建维护的项目

单击选中需要修改的工程，之后如图 6‑1打开 ``RV-Tools>SDK Configuration Tools`` ，可以打开修改编译选项的弹窗， **在2023.10版本以后，将直接打开Nuclei Settings页面** 。也可以单击要修改的工程后，点击工具栏的工程设置工具图标。

|image8|

或者单击要修改的工程后，键盘按下 ``ctrl+6`` 。

|image9|

也可以单击要修改的工程后，右击打开右键菜单，选择SDK Configuration Tools。

|image10|

SDK Configuration Tools各选项详细功能如下：

|image11|

-  projectName为当前选中的工程名。

-  Core 为当前工程对应的内核。由于工具根据ARCH和ABI选项反推出对应的内核，而不同的内核可能有相同的ARCH和ABI选项，所以显示上可能会有所偏差，只要ARCH与ABI为正确的选项即可。此选项为方便快速切换内核选项使用。

-  四个勾选项： ``Bitmanipulation Extension(RVB)`` , ``Cryptography Extension(RVK)`` , ``Packed SIMD/DSP Extension`` , ``Vector Extension(RVV)`` 用于选择对应的扩展指令集 ``(B/K/P/V)`` 。
   
   .. note::
       
       本功能在2023.10版本中移除，使用 ``Other Extensions`` 输入框来制定额外的扩展。

-  ARCH对应的当前工程的arch选项, 根据Core和勾选项自动组合。

-  ABI对应的当前工程的abi选项。

-  Tuning根据不同级别处理器优化的gcc选项，选择Core会自动选择正确的Tuning选项，不建议自己调整。

-  Code Model针对RV32处理器，自动选择为 ``Medium Low`` ，而针对RV64处理器自动选择为 ``Medium High`` ，选择Core以后会自动选择合适的Code Model，其中RV64处理器必须使用 ``Medium High`` 。

-  Download对应当前工程的下载模式，可以切换选择不同的下载模式，目前仅Nuclei FPGA评估开发板支持切换下载模式，RVSTAR仅有 ``FLASHXIP`` 模式。其中切换到flash模式会额外定义 ``VECTOR_TABLE_REMAPPED`` 宏，其他模式不会定义这个宏

-  ``Select C Runtime Library`` 对应的使用标准C库， **本功能在2023.10版本中移除** 。在工程创建的时候，如果创建的工程采用的是Newlib，则这里只能进行newlib版本的切换，如果创建的工程才用的是 ``Nuclei C Runtime Library(libncrt)`` ，则这里只能进行libncrt版本的切换。

-  ``Optimization Level`` 对应编译的优化等级。

-  ``Extra Common Flags`` 对应的是额外的通用编译选项。可以添加额外的通用编译选项。

-  ``Extra C Flags`` 对应的是额外的C编译选项。可以添加额外的C编译选项。

-  ``Extra C++ Flags`` 对应的是额外的C++编译选项。可以添加额外的C++编译选项。

-  ``Extra ASM Flags`` 对应的是额外的汇编编译选项。可以添加额外的汇编编译选项。

-  ``Extra Link Flags`` 对应的是额外的链接选项。如果此选项已经有默认选项并且需要增加编译选项，可以在编译选项开头或结尾处相隔一个空格字符再增加编译选项。

根据需要修改以上的选项，这里我们修改优化等级为 ``-Os`` 优化生成可执行文件大小。点击 ``save`` 一键修改编译选项， ``save`` 以后一定要先 ``clean project`` ，之后右击修改后的工程打开右键菜单，选择 ``Clean Project`` 清理一下工程，再点击锤子图标即可完成修改编译选项后重新编译工程。

|image12|

这里的SDK Configuration Tool切换不会对Debug Configuration选项做任何改动，因此如果切换了Core以后，对应的调试配置(OpenOCD/QEMU/JLink)也需要手动修改。

需要注意的是如果要切换工程从32位变为64位，需要打开调试设置页面，修改 ``command`` 中 ``set arch riscv:rv32`` 为 ``set arch riscv:rv64`` ，从64位切换回32位也应当修改这里的参数为对应的数值。

.. _ide_projectbuild_13:

Nuclei Studio中编译Hello World项目
----------------------------------

在Nuclei Studio中编译Hello World项目的步骤如下。

在编译工程前，建议先将项目清理一下。在 ``Project Explorer`` 栏中选中 ``hello_world`` 项目，单击鼠标右键，选择 ``Clean Project`` 。

|image13|

单击Launch Bar菜单上的锤子按钮，开始对项目进行编译。如果编译成功，能够看到生成可执行文件的代码体积大小，包括text段、data段和bss段，以及总大小的十进制和十六进制数值。使用Makefile方式新建的工程需要在右键菜单中选择 ``Build Project`` 进行编译。

|image14|

编译成功后可以看到增加了Debug文件夹，各文件作用如下：

-  ``hello_world.elf`` 是生成的可执行文件。

-  ``hello_world.hex`` 是生成的Hex文件。

-  ``hello_world.lst`` 是生成的list文件，可以看到反汇编和简单的代码分部信息。

-  ``hello_world.map`` 是生成的map文件，可以详细的看到生成的代码分布情况。

|image15|

.. _ide_flash_programming:

Flash Programming
------------------

为了满足用户将编译好的二进制文件直接下载到硬件开发板的需求，Nuclei Studio 新增了 Flash Programming 功能。该功能允许用户快速、便捷地将编译好的二进制文件直接下载到硬件开发板中，极大提升了开发和调试的效率；简化操作流程，用户只需点击一次即可完成二进制文件的下载。工程编译好后，找到Flash Programming，并点击，即可完成二进制文件下载的下载。

|image17|

用户也可以修改其相关的配置信息，在Launch Bar中点击配置按钮，打开配置页面，然后选中Flash Programming选项卡。

|image18|

**Load Program Image**

Load的文件，默认的elf格试的文件，也可以支持 ``*.bin、*.hex、*.s19、*.srec、*.symbolsrec`` 等各种格式

|image19|

**Flash Programming Options**

Flash Programming的选项有以下三种

Verify Image：选中时，Download命令会带上 ``verify`` 参数，这条指令要求确认你要烧录的镜像文件是否匹配当前连接的目标设备上的闪存配置。

|image20|

Reset and Run：选中时，Download命令会带上 ``reset`` 参数，这条指令在执行完load后可能强制系统复位（SRST），并让目标设备运行。

|image21|

Load in Ram：选中时，需要指定Program Address，Download命令会带上 ``resume {Program Address}`` 参数，这条指令固件加载到内存中，而不是闪存中。

|image22|

**OpenOCD Flash Programming Command line**

这些参数最终会以命令行的形式通过 GDB 执行。用户也可以自定义所需的命令，只需勾选 ``Customize openocd flash programming command line`` ，即可在下方输入框中输入自定义命令。

|image23|

根据需求配置好参数后，点击Flash Programming就可以下载二进制代码到硬件中，下载成功的结果如下图。

|image24|



.. |image1| image:: /asserts/nucleistudio/projectbuild/image2.png

.. |image2| image:: /asserts/nucleistudio/projectbuild/image3.png

.. |image3| image:: /asserts/nucleistudio/projectbuild/image4.png

.. |image4| image:: /asserts/nucleistudio/projectbuild/image5.png

.. |image5| image:: /asserts/nucleistudio/projectbuild/image6.png

.. |image6| image:: /asserts/nucleistudio/projectbuild/image7.png

.. |image7| image:: /asserts/nucleistudio/projectbuild/image8.png

.. |image8| image:: /asserts/nucleistudio/projectbuild/image9.png

.. |image9| image:: /asserts/nucleistudio/projectbuild/image10.png

.. |image10| image:: /asserts/nucleistudio/projectbuild/image11.png

.. |image11| image:: /asserts/nucleistudio/projectbuild/image12.png

.. |image12| image:: /asserts/nucleistudio/projectbuild/image13.png

.. |image13| image:: /asserts/nucleistudio/projectbuild/image14.png

.. |image14| image:: /asserts/nucleistudio/projectbuild/image15.png

.. |image15| image:: /asserts/nucleistudio/projectbuild/image16.png

.. |image17| image:: /asserts/nucleistudio/projectbuild/image17.png

.. |image18| image:: /asserts/nucleistudio/projectbuild/image18.png

.. |image19| image:: /asserts/nucleistudio/projectbuild/image19.png

.. |image20| image:: /asserts/nucleistudio/projectbuild/image20.png

.. |image21| image:: /asserts/nucleistudio/projectbuild/image21.png

.. |image22| image:: /asserts/nucleistudio/projectbuild/image22.png

.. |image23| image:: /asserts/nucleistudio/projectbuild/image23.png

.. |image24| image:: /asserts/nucleistudio/projectbuild/image24.png