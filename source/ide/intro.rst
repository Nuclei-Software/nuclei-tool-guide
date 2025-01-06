.. _intro: 

Nuclei Studio IDE 简介
=======================

.. note::
   
   - Nuclei Studio出视频教程啦，相关内容在 **芯来科技视频号** 中持续更新中，您可以在微信中搜索 **芯来科技视频号** 并关注，以便获取到我们最新的更新内容。
   - 在使用Nuclei Studio, Nuclei Tools过程中，如查有问题，可以查阅 `https://github.com/Nuclei-Software/nuclei-studio <https://github.com/Nuclei-Software/nuclei-studio>`__\ 内容，也可以向我们提交相关Issue。

一款高效易用的集成开发环境（Integrated Development Environment，IDE）对于任何MCU都显得非常重要，软件开发人员需要借助IDE进行实际的项目开发与调试。
ARM的商业IDE软件Keil，在中国大陆很多嵌入式软件工程师均对其非常熟悉。但是商业IDE软件（譬如Keil）存在着授权以及收费的问题，各大MCU厂商也会推出自己
的免费IDE供用户使用，譬如瑞萨的e2studio和NXP的LPCXpresso等，这些IDE均是基于开源的Eclipse框架，Eclipse几乎成了开源免费MCU IDE的主流选择。

Nuclei Studio IDE正是芯来公司，基于Eclipse IDE开发的一款针对芯来RISC-V处理器IP核产品的集成开发环境工具。

Eclipse平台采用开放式源代码模式运作，并提供公共许可证（提供免费源代码）以及全球发布权利。
Eclipse本身只是一个框架平台，除了Eclipse平台的运行时内核之外，其所有功能均位于不同的插件中。
开发人员既可通过Eclipse项目的不同插件来扩展平台功能，也可利用其他开发人员提供的插件。
一个插件可以插入另一个插件，从而实现最大程度的集成。

由于Eclipse IDE已经在社区被大量使用，一些常见的使用方法在Eclipse
IDE里面，如果没有和硬件或者CPU绑定，一般情况下是可以借鉴其他人写的关于Eclipse
IDE的使用教程，这里推荐几个常用的教程网站：

-  https://help.eclipse.org/latest/index.jsp

-  https://eclipse-embed-cdt.github.io/

-  https://mcuoneclipse.com/

Eclipse IDE平台具备以下几方面的优势。

-  **社区规模大**

   Eclipse自2001年推出以来，已形成大规模社区，这为设计人员提供了许多资源，包括图书、教程和网站等，
   以帮助他们利用Eclipse平台与工具提高工作效率。Eclipse平台和相关项目、插件等都能直接从eclipse.org网站下载获得。

-  **持续改进**

   Eclipse的开放式源代码平台帮助开发人员持续充分发挥大规模资源的优势。Eclipse在以下多个项目上不断改进。

   -  平台项目 —— 侧重于Eclipse本身。

   -  CDT项目  —— 侧重于C/C++开发工具。

   -  PDE项目  —— 侧重于插件开发环境。

-  **源码开源**

   设计人员始终能获得源代码，总能修正工具的错误，它能帮助设计人员节省时间，自主控制开发工作。

-  **兼容性**

   Eclipse平台采用Java语言编写，可在Windows与Linux等多种开发工作站上使用。开放式源代码工具支持多种语言、多种平台以及多种厂商环境。

-  **可扩展性**

   Eclipse采用开放式、可扩展架构，它能够与ClearCase、SlickEdit、Rational Rose以及其他统一建模语言（UML）套件等第三方扩展协同工作。此外，它还能与各种图形用户接口（GUI）编辑器协同工作，并支持各种插件。


Nuclei Studio IDE充分利用上述Eclipse IDE优势，结合社区成熟的Eclipse embedded CDT, Linux Tools等插件，并研发自有插件满足RISC-V嵌入式开发的日常需求:

- 工程创建，管理，编译和调试

- 支持多种调试方案，例如OpenOCD，JLink，Nuclei DLink，Nuclei Qemu等

- 支持扩展调试方案，方便扩展支持更多调试器

- 支持多种编译器，包括gcc, clang, zcc

- 提供快捷的工程常用设置工具 **Nuclei Settings**

- 支持基于Nuclei ETrace软硬件方案的Onchip Trace

- 支持基于gprof、gcov的大幅增强profiling和code coverage方案

- 支持Nuclei PacKage(NPK)软件包方案，可以便捷的扩展支持软件开发包和Nuclei Studio解耦，
  实现 **软件包导入** -> **Project Wizard** 的便捷方案, 这种方案已经得到广泛的应用，例如
  芯来科技自有的 **Nuclei SDK**.

- 更快捷的工程和工作空间的打开方式

- 更好用的Launchbar功能


Nuclei Studio 更新说明
=======================

2024.12版更新说明
-----------------

2024.12版本是基于eclipse Cpp 2024-12开发，CDT版本到Eclipse CDT 2024-09（2024-12版本暂末发布），升级了芯来科技的工具版本至2024.12，优化了部分原有功能，新增了调试及代码性能分析等功能，以及解决了2024.06版中存在的缺陷。

升级Eclipse Cpp版本
~~~~~~~~~~~~~~~~~~~

在Nuclei Studio 2024.12基于Eclipse Cpp 2024-12版本开发此版本。基础的CDT版本，升级到了11.6.1。

升级RISC-V Toolchain、OpenOCD、QEMU版本
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

在Nuclei Studio 2024.12版本中集成了Nuclei RISC-V Toolchain 2024.12版，具体信息可以查看：https://github.com/riscv-mcu/riscv-gnu-toolchain/releases/tag/nuclei-2024.12 。

在Nuclei Studio 2024.12版本中集成了OpenOCD 2024.012版，具体信息可以查看：https://github.com/riscv-mcu/riscv-openocd/releases/tag/nuclei-2024.12 。

在Nuclei Studio 2024.12版本中集成了Nuclei Qemu 2024.12版，具体信息可以查看：https://github.com/riscv-mcu/qemu/releases/tag/nuclei-2024.12 。

新增对更多新核的支持
~~~~~~~~~~~~~~~~~~~~

增加了对N200E、N202、N202E、NX1000、NX1000F、NX1000FD、UX1000、UX1000F CPU的核配套支持。

新增Flash Programming功能
~~~~~~~~~~~~~~~~~~~~~~~~~~~

为了满足用户将编译好的二进制文件直接下载到硬件开发板的需求，Nuclei Studio 新增了 Flash Programming 功能。该功能允许用户快速、便捷地将编译好的二进制文件直接下载到硬件开发板中，极大提升了开发和调试的效率。

具体参见 :ref:`Flash Programming功能 <ide_flash_programming>` 。

新增了Nuclei NICE Wizard
~~~~~~~~~~~~~~~~~~~~~~~~~

Nuclei NICE Wizard 是一个集成在 Nuclei Studio 上的工具，旨在简化和加速 NICE (自定义指令扩展) 和 VNICE (向量化自定义指令扩展) 指令的创建过程。

具体参见 :ref:`Nuclei NICE Wizard <ide_nuclei_nice_wizard>` 。

新增Nuclei Model功能的使用
~~~~~~~~~~~~~~~~~~~~~~~~~~

Nuclei Model是芯来科技为 Nuclei Near Cycle Model 开发了专门的运行工具，为了提供更简洁高效的用户体验，在 RVProf 的基础上进行了功能简化，推出了新的 Model 工具。

具体参见 :ref:`Nuclei Model <ide_nuclei_model>` 。


优化Nuclei Near Cycle Model
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Nuclei Near Cycle Model，是由芯来科技自主研发的仿真测试和性能分析工具，可以帮助研发人员在项目初期进行一些必要的仿真测试和程序性能分析。在此版本中实现了Windows和Linux下的支持。

具体参见 :ref:`Nuclei Near Cycle Model <ide_nuclei_near_cycle_model>` 。

新增Live Watch功能
~~~~~~~~~~~~~~~~~~~~

Live Watch 是芯来科技研发的实时监控工具，专为开发者设计，旨在帮助开发者更高效地调试和优化代码。

具体参见 :ref:`Live Watch功能的使用 <ide_live_watch>` 。


ZCC升级
~~~~~~~~~

在Nuclei Studio 2024.12版本中集成了ZCC 3.2.5版，并加入芯来科技支持的软件库。具体信息可以查看：https://www.terapines.com/products/zcc

2024.06版更新说明
-----------------

本版本是一次比较重大的版本升级，2024.06版本升级了CDT版本到Eclipse CDT 2024-06，升级了芯来科技的工具版本至2024.06，优化了部分原有功能，新增了调试及代码性能分析等功能，以及解决了2024.02版中存在的缺陷。

升级Eclipse CDT版本
~~~~~~~~~~~~~~~~~~~

在Nuclei Studio 2024.06版本中基础的CDT版本，升级到了11.6.0，并基于Eclipse CDT 2024-06版本开发此版本。

升级RISC-V Toolchain、OpenOCD、QEMU版本
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

在Nuclei Studio 2024.06版本中集成了Nuclei RISC-V Toolchain 2024.06版，具体信息可以查看：https://github.com/riscv-mcu/riscv-gnu-toolchain/releases/tag/nuclei-2024.06 。

在Nuclei Studio 2024.06版本中集成了OpenOCD 2024.06版，具体信息可以查看：https://github.com/riscv-mcu/riscv-openocd/releases/tag/nuclei-2024.06 。

在Nuclei Studio 2024.06版本中集成了Nuclei Qemu 2024.06版，具体信息可以查看：https://github.com/riscv-mcu/qemu/releases/tag/nuclei-2024.06 。

新增对U600和UX1000的支持
~~~~~~~~~~~~~~~~~~~~~~~~

配合U600和UX1000核的发布，同步增加了对U600和UX1000核配套支持。

优化NPK软件包管理
~~~~~~~~~~~~~~~~~

优化Nuclei Package Management中对NPK包依赖的管理，使其更易使用；优化了部分NPK包安装的提示信息及日志，提高NPK包管理的使用体验。具体参见 :ref:`NPK软件包管理 <ide_npk_package_management>` 。

.. note::

   注意：本次版本升级，变更了NPK包管理的配置，在2024.02版及之前版本中安装的NPK包在2024.06版NucleiStudio无法识别，用户需重新下载安装NPK包。

增加和优化部分编译选项
~~~~~~~~~~~~~~~~~~~~~~

在Properties 和 Nuclei Settings页面内，在Optimization Level中新增 -Oz选项；在GNU RISC-V Cross C++ Linker的Libraries页新增对group libraries的支持, 参见 :ref:`工程编译链接C库找不到符号报错 <ide_faq_36>` 。

优化调式模式切换
~~~~~~~~~~~~~~~~

NucleiStudio支持多种调试模式，如OpenOCD、Jlink、Dlink、Custom等，同时还有Qemu等仿真器，为了方便用户在多工程多种模式之间切换，优化了调式模式的切换，具体内容参见 :ref:`调试模式管理 <ide_projectrun_1>` 。

优化和完善DLink Debug调试
~~~~~~~~~~~~~~~~~~~~~~~~~

Nuclei DLink是芯来科技基于RV Link，并在RV Link的基础上做了许多功能增加后，所研发的RISC-V调试器，使之更适应于Nuclei Studio的应用场景。具体内容可以查看 :ref:`使用DLink调试运行项目 <ide_projectrun_50>` 。

集成Terapines ZCC Lite编译器
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Terapines ZCC是兆松科技研发的高性能RISC-V编译器。Nuclei Studio 2024.06版中对Terapines ZCC进行支持，用户可以在Nuclei Studio中直接使用。具体参见 :ref:`Nuclei Studio中编译Hello World项目 <ide_projectbuild_13>` 。

新增LST View工具 
~~~~~~~~~~~~~~~~~

LST View 是一个lst文件查看器，可以方便用户查看lst格式的文件，并实现\*.lst文件与源代码的联动，具体请参见 :ref:`LST View <ide_advanceusage_13>` 。

优化和完善Gprof功能
~~~~~~~~~~~~~~~~~~~

Gprof是一个强大的性能分析工具，可以帮助开发者理解C/C++程序的运行情况，通过Gprof可以获取到程序中各个函数的调用信息、调用次数、执行时间等，对优化程序、提升程序运行效率具有重要的意义。具体请参见 :ref:`Code Coverage和Profiling功能 <ide_advanceusage_17>` 。

优化和完善Gcov功能
~~~~~~~~~~~~~~~~~~

Gcov是一个测试C/C++代码覆盖率的工具，伴随GCC发布，配合GCC共同实现对C/C++文件的语句覆盖、功能函数覆盖和分支覆盖测试。具体请参见 :ref:`Code Coverage和Profiling功能 <ide_advanceusage_17>` 。

新增Call Graph功能
~~~~~~~~~~~~~~~~~~

Call Graph是分析函数调用关系图的工具，结合Gprof使用，便于开发者快速了解程序执行的过程及调用关系。具体请参见 :ref:`Code Coverage和Profiling功能 <ide_advanceusage_17>` 。

新增Nuclei Near Cycle Model支持
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Nuclei Near Cycle Model，它是由芯来科技自主研发的仿真测试和性能分析工具，可以帮助研发人员在项目初期进行一些必要的仿真测试和程序性能分析，具体请参见 :ref:`使用Nuclei Near Cycle Model仿真性能分析 <ide_advanceusage_71>` 。

2024.02.dev版更新说明
---------------------

本版本是开发版本（您下载到的链接内容随时可能会变更），本版本解决了Nuclei Studio 2023.10版中存在的缺陷，并优化了部分原有功能如ETrace特性，新增了一些功能如对N100的支持、Dlink的支持等，更好为满足客户评估和更新使用。

升级Eclipse CDT版本
~~~~~~~~~~~~~~~~~~~

在Nuclei Studio 2024.02.dev版本中基础的Eclipse CDT版本，升级到了Eclipse CDT 2023.12版。

新增对N100的支持
~~~~~~~~~~~~~~~~

配合N100核的发布，同步增加了对N100的配套支持。

新增批量转换Gcc13工程工具
~~~~~~~~~~~~~~~~~~~~~~~~~

在2023.10版Nuclei Studio中，升级GCC 13后，当有大量工程需要转换时，单个转换效率低，为方便开发者，提供了一个批量转换GCC 13工具。具体内容参见 :ref:`批量将工程转换成支持gcc 13的工程 <ide_advanceusage_4>` 。

优化和完善Trace功能
~~~~~~~~~~~~~~~~~~~

Nuclei Studio中Trace功能升级，实现了在OpenOCD模式下对单核应用、SMP多核应用、AMP多核应用的支持，具体内容参见 :ref:`Trace功能的使用 <ide_advanceusage_43>` ；在Dlink模式下，仅对单核应用支持。Trace功能需要有对应CPU IP的支持，如需体验此功能，请与我们联系。

优化和完善RVProf功能
~~~~~~~~~~~~~~~~~~~~

RVProf是芯来科技基于CPU cycle model开发的性能分析工具，具体内容参见第 :ref:`RVProf功能的使用 <ide_advanceusage_61>` 。此功能需要有相应的NPK软件包支持，如需体验此功能，请与我们联系。

新增对DLlink Debug的支持
~~~~~~~~~~~~~~~~~~~~~~~~

Dlink是芯来自主研发的调试解决方案，在本次版本中得到支持。此功能需要有相应的Dlink调试器的支持，如需体验此功能，请与我们联系。

2023.10版更新说明
-----------------

本版本是一次比较重大的版本升级，集成了Nuclei 2023.10版本的Toolchain, QEMU, OpenOCD, 且Eclipse CDT版本进行了升级，GCC版本也做了重大迭代，升级到了GCC 13, NPK部分也做了大量的新功能的增加以支持GCC或者CLANG的工程创建，并且增加很多新的Configuration字段类型，方便在Project Wizard中更灵活的进行工程配置。

升级Eclipse CDT版本
~~~~~~~~~~~~~~~~~~~

在Nuclei Studio 2023.10版本中基础的Eclipse CDT版本，升级到了Eclipse CDT 2023.06版; Eclipse CDT 2023-06 版本是 Eclipse 基金会 2023 年第二个季度同步版本，有 64 个参与项目，于 2023 年 6 月 14 日发布。

参考地址：\ `Eclipse IDE for C/C++ Developers <https://www.eclipse.org/downloads/packages/release/2023-06/r/eclipse-ide-cc-developers>`__

升级后打开之前版本创建的workspace,会弹出不兼容的警告，使用时可能会有异常，建议更换新的workspace目录。

|image1|

升级build-tools版本
~~~~~~~~~~~~~~~~~~~

在Nuclei Studio 2023.10版将toolchain中的build-tools更新到4.4版本，并额外增加了bash.exe、cp.exe、mv.exe、tar.exe工具。

|IMG_256|


支持GCC 13和Clang 17
~~~~~~~~~~~~~~~~~~~~

在Nuclei Studio 2023.10版本中实现了对GCC 13的支持，相对于之前的gcc10版本GCC 13在对RISC-V指令扩展的支持更加完备，且在我们维护的版本中，支持完整的RVV Intrinsic API v0.12版本。同时Nuclei Studio 2023.10版本中也实现了对Clang 17的支持（参考地址：\ https://releases.llvm.org/17.0.1/docs/RISCVUsage.html\ ）。当然，如果有用户依然想使用GCC 10时行项目开发，我们也保留了相关的配置，但是工具链并没有集成到IDE中，用户需要自行下载并放置在gcc10目录中，参见里面的README.txt，并且我们也提供了老版本采用gcc10的Nuclei Studio创建的工程升级到gcc13工具链上，具体使用可以参考 :ref:`导入旧版本Nuclei Studio创建的工程 <ide_advanceusage_0>` 。Nuclei RISC-V Toolchain 2023.10更详细的说明，请参阅: https://github.com/riscv-mcu/riscv-gnu-toolchain/releases/tag/nuclei-2023.10

|image2|

|image3|

|image4|

.. _ide_intro_4:

RISC-V指令扩展使用变更
~~~~~~~~~~~~~~~~~~~~~~~

因gcc和clang的变更，在扩展的使用上，有了较大的变化。原来的bpkv扩展与新的规则对应关系如下，更详细的说明，请参阅\ https://doc.nucleisys.com/nuclei_sdk/develop/buildsystem.html#arch-ext


-  ``b`` -> ``_zba_zbb_zbc_zbs``

-  ``p`` -> rv64: ``_xxldsp``, rv32: ``_xxldspn3x`` for n300, ``_xxldspn1x`` for n900

-  ``k`` -> ``_zk_zks``

-  ``v`` -> rv32f/d : ``_zve32f``, rv64f: ``_zve64f``, rv64fd: ``v``

以N307FD + B + V + Nuclei DSP with N1 extension为例，创建一个使用扩展的应用，在创建工程的引导中，需要Nuclei ARCH Extensions中填入对的扩展字段，如需要使用bpv扩展，根据以上规则，需要填入 ``_zba_zbb_zbc_zbs_zve32f_xxldspn1x`` 。

|image5|

生成的工程中，可以看到在工程的 **Nuclei Settings** 。

|image7|

同样的查看工程的属性，在 ``C/C++ Build->Settings->Target Processor`` 中也是有关于RISC-V指令扩展的配置项。

|image6|

同时在QEMU的配置中也会有相对应的RISC-V指令扩展的配置项。

|image8|

NPK包的使用变更
~~~~~~~~~~~~~~~

为了支持GCC 13和Clang 17，Nuclei SDK包升级到了0.5.0版本，使用SDK包创建工程时，用户可以根据需要，选择创建一个GCC 13或者Clang 17的工程。因为版本变动较大，0.5.0之前的sdk可能有部分功能在Nuclei Studio 2023.10版中使用异常，所我们提供了工具帮助您快速进行工程迁移和升级， **请自行备份老版本的工程** ，具体可能参考 :ref:`导入旧版本Nuclei Studio创建的工程 <ide_advanceusage_0>` 。

|image9|

另外Nuclei Studio 2023.10中会对npk在线组件包做适配版本的校验（上传阶段需要填写测在什么版本的Nuclei Studio上测试使用），不同的组件包所适配的Nuclei Studio版本号会在Package Management页面展示，在下载安装的时候如果版本不匹配，会给与提示，但是导入离线包不会有任何提示，请自行甄别是否被所使用的Nuclei Studio IDE版本所支持，具体如下。

|image10|

升级OpenOCD
~~~~~~~~~~~

OpenOCD版本升级至2023.10版，增加了一些额外的调试特性，例如查看cpu信息，etrace实验性的支持。关于OpenOCD变更更详细的说明，请参阅：\ https://github.com/riscv-mcu/riscv-openocd/releases/tag/nuclei-2023.10

升级QEMU
~~~~~~~~

在Nuclei Studio 2023.10中集成Nuclei QEMU 2023.10版本，而Nuclei QEMU 2023.10基于QEMU 8.0进行二次开发（参考地址：https://wiki.qemu.org/ChangeLog/8.0）。本版本的QEMU和2022.10版本使用方面有比较大的变化，不再支持gd32vf103_rvstar这块开发板，转而只支持Nuclei EvalSoC, 可以配置Nuclei SDK/Nuclei Linux SDK无缝使用。且支持的machine由nuclei_n/nuclei_u 转而统一变为 nuclei_evalsoc。关于详细Nuclei QEMU更详细的说明，请参阅：https://github.com/riscv-mcu/qemu/releases/tag/nuclei-2023.10

|image11|

.. _my_internal_link_label: 

新增了elf文件查看器
~~~~~~~~~~~~~~~~~~~

在Nuclei Studio 2023.10新增elf文件编辑器，方便用户查看编译后产生 ``.elf`` 、 ``.o`` 文件。

|image12|

|image13|

新增Code Coverage和Profiling功能
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

在Nuclei Studio 2023.10新增了对Code Coverage和Profiling功能的支持，具体参考 :ref:`Code Coverage和Profiling功能 <ide_advanceusage_17>` 。

新增trace功能
~~~~~~~~~~~~~

在Nuclei Studio 2023.10 **实验性** 新增了trace功能，因使用此功能需要带有Nuclei Trace IP的CPU，如需体验此功能，请与我们联系。

Nuclei Settings功能优化 
~~~~~~~~~~~~~~~~~~~~~~~~

为了应对更个性化的配置，我们修改了Nuclei Settings部分功能。

Nuclei Studio 2023.10去掉了原来的B/P/K/V的单选框，换成Other Extensions输入框，用户可以根据自己的需求自定义填写。而关于B/P/K/V的使用，可以参考 :ref:`RISC-V指令扩展使用变更 <ide_intro_4>` 。

|image14|

Nuclei Studio 2023.10去掉了原来的Select C Runtime Library单选框，在项目中如果需要使用，可能过项目配置传入的 ``--specs=`` 选项，或者Libraries选项,来实现。

|image15|

Nuclei Settings增强了其通用性，使它不仅仅能对Nuclei的工程进行快速修改，也新增以对通用riscv和arm创建的static和shared的library工程的支持。下面为shared对应示图。

|image16|

|image17|

新增指定工作空间快速打开 
~~~~~~~~~~~~~~~~~~~~~~~~~

类似双击项目下的 ``*.nuproject`` 文件可快速打开Nuclei Studio并导入该项目，现在Nuclei Studio会在使用过的工作空间目录下创建 ``work.nuworkspace`` 文件，双击该文件可以直接打开Nuclei Studio，但该功能暂时只支持windows版本。这个功能需要解压IDE后，在windows上执行 ``install.bat`` 来设置文件关联。

|image18|

2022.12版更新说明
-----------------

Nuclei Studio自2021.09版后，将IDE与SDK完全分离，将采用全新的Nuclei Package(NPK)的包管理的方式进行模板工程的管理和使用，方便用户进行不同SDK的导入并且在IDE上创建示例工程并使用，针对Nuclei SDK和HBird SDK以及我们公司的SoC IP产品提供的SDK，均可以打包成Zip包的方式以通过Nuclei Package Management方式进行导入使用。

Nuclei Studio 下载与安装
=========================

Nuclei Studio IDE 下载
----------------------

为了方便用户快速上手使用，本文档推荐使用预先整理好的Nuclei Studio IDE软件压缩包。芯来公司已经将该软件压缩包上传至公司网站，具体地址为\ https://www.nucleisys.com/download.php\ 。

用户可以在芯来科技公司网站的“下载中心”，根据用户开发环境，下载对应Windows或Linux的Nuclei Studio压缩包（注意：芯来科技公司网站的下载中心，其内容会不断更新，用户请自行选择使用最新版本或继续使用当前版本）。

目前已在Win 10 64位系统，Ubuntu 18.04/20.04和 Redhat7.6 64位版本上验证测试，推荐使用以上版本的系统。

|image19|

Nuclei Studio IDE 安装
----------------------

当完成Nuclei Studio IDE压缩软件包下载，解压后包含若干文件，分别介绍如下。

-  Nuclei Studio软件包

   -  该软件包中包含了Nuclei Studio IDE的软件。注意：具体版本以及文件名可能会不断更新。

-  HBird_Driver.exe（2021.02版本起不再提供）

   -  **仅Windows版提供，** 此文件为芯来蜂鸟调试器的USB驱动安装文件。

   -  当在Windows环境下，使用该调试器时，需要安装此驱动使该USB设备能够被系统识别。

   -  由于2021.02版本中更新的openocd引入了免驱功能。

-  SerialDebugging_Tool（2021.02版本起不再提供）

   -  **仅Windows版提供** ，此文件为“串口调试助手”软件。此软件可以用于后续软件示例调试时通过串口打印信息。

|image20|


Nuclei Studio IDE 启动
----------------------

启动Nuclei Studio的要点如下（windows和linux均按照如下操作）：

直接双击Nuclei Studio IDE文件包中Nuclei Studio文件夹下面的可执行文件，即可启动Nuclei Studio。

|image21|

第一次启动Nuclei Studio后，将会弹出对话框要求设置Workspace目录路径，该目录将用于存放后续创建的项目工程文件。

|image22|

设置好Workspace目录之后，单击“Launch”按钮，将会启动Nuclei Studio。第一次启动后的Nuclei Studio。

|image23|

.. note::
   2021.02版本Nuclei Studio默认关闭了Launch Bar，请参照10.10.1开启Nuclei Studio中的Launch Bar功能，方便快速编译调试和下载。



.. |image1| image:: /asserts/nucleistudio/intro/image2.png
   :alt: workspace弹出不兼容的警告 

.. |IMG_256| image:: /asserts/nucleistudio/intro/image3.png
   :alt: build-tools更新到4.4版
   
.. |image2| image:: /asserts/nucleistudio/intro/image4.png
   :alt: GCC和Clang的目录结构
   
.. |image3| image:: /asserts/nucleistudio/intro/image5.png
   :alt: 工程对GCC 13的支持

.. |image4| image:: /asserts/nucleistudio/intro/image6.png
   :alt: 项目对Clang 17的支持
   
.. |image5| image:: /asserts/nucleistudio/intro/image7.png
   :alt: 创建工程时使用RISC-V扩展
   
.. |image6| image:: /asserts/nucleistudio/intro/image8.png
   :alt: 项目中对RISC-V扩展的支持
   
.. |image7| image:: /asserts/nucleistudio/intro/image9.png
   :alt: Nuclei Settings中对RISC-V扩展的支持
   
.. |image8| image:: /asserts/nucleistudio/intro/image10.png
   :alt: QEMU中对RISC-V扩展的支持
   
.. |image9| image:: /asserts/nucleistudio/intro/image11.png
   :alt: 创建工程时选择合适的工具链
   
.. |image10| image:: /asserts/nucleistudio/intro/image12.png
   :alt: 组件包所适配的Nuclei Studio版本号 
   
.. |image11| image:: /asserts/nucleistudio/intro/image13.png
   :alt: QEMU 8.0所在的目录  
   
.. |image12| image:: /asserts/nucleistudio/intro/image14.png
   :alt: elf文件编辑器查看.elf文件 
   
.. |image13| image:: /asserts/nucleistudio/intro/image15.png
   :alt: elf文件编辑器查看.o文件
   
.. |image14| image:: /asserts/nucleistudio/intro/image16.png
   :alt: Nuceli Settings页面修改 
   
.. |image15| image:: /asserts/nucleistudio/intro/image17.png
   :alt: Select C Runtime Library在新版IDE中已不存在
   
.. |image16| image:: /asserts/nucleistudio/intro/image18.png
   :alt: Shared 项目Nuclei Settings(Arm)
   
.. |image17| image:: /asserts/nucleistudio/intro/image19.png
   :alt: Shared 项目Nuclei Settings(Riscv)
   
.. |image18| image:: /asserts/nucleistudio/intro/image20.png
   :alt: work.nuworkspace文件
   
.. |image19| image:: /asserts/nucleistudio/intro/image21.png
   :alt: Nuclei Studio IDE软件包的下载界面
   
.. |image20| image:: /asserts/nucleistudio/intro/image22.png
   :alt: Nuclei Studio IDE压缩包文件内容
   
.. |image21| image:: /asserts/nucleistudio/intro/image23.png
   :alt: 双击“Nuclei Studio.exe”启动Nuclei Studio
   
.. |image22| image:: /asserts/nucleistudio/intro/image24.png
   :alt: 公司Logo  
   
.. |image23| image:: /asserts/nucleistudio/intro/image25.png
   :alt: 第一次启动Nuclei Studio界面
   
