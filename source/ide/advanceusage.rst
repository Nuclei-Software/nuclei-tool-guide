.. _advanceusage:

Nuclei Studio 高级功能
======================

我们在 https://doc.nucleisys.com/nuclei_studio_supply 这里提供了很多且不断完善的Nuclei Studio和Nuclei Tools使用问题和案例，帮助你更好的使用Nuclei Studio以及Tools，可以点进去了解下。

.. _ide_advanceusage_0:

导入旧版本创建的工程
---------------------

Nuclei Studio 2023.10版导导入旧工程
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

在Nuclei Studio 2023.10版本中，因为工具链、sdk等增均做了较大的修改，如果用户在新的Nuclei Studio中想要使用旧版的Nuclei Studio创建的工程，或者使用旧的sdk，需要参考本章节内容进行操作。

将旧的Nuclei Studio中的工程导入到Nuclei Studio 2023.10中时（具体导入工程的方法，可以阅读 :ref:`Nuclei Studio 2022.12之后版本导入旧工程 <ide_advanceusage_7>` ），或者使用旧的sdk（旧的sdk指的是在Nuclei Studio 2023.10发布之前所发布的sdk）所创建的工程，因为工程配置使用使用的是gcc 10，当找不到对应的工具链，会出现编译报错等问题，导致工程无法正常使用。

|image1|

我们提供了两种解决方案，第一种方案是手动导入gcc 10工具链，第二种方案是通过Nuclei Studio 2023.10所带的转换工具进行转换。在此推荐使用第二种方案，能比较好的将工程转换成Nuclei Studio 2023.10所支持的工程，并能使用其最新特性。



手动导入GCC 10工具链
^^^^^^^^^^^^^^^^^^^^

为了方便用户使用，在Nuclei Studio 2023.10中保留了GCC 10相关的配置，但没有将GCC 10打包到IDE中，如果用户想要继续在GCC 10下进行开发，可以手动将GCC导入进来。

首先，在旧版Nuclei Studio的安装目录中的 ``toolchain\gcc\`` 目录找到GCC 10 ,并将其中内容复制到Nuclei Studio 2023.10的安装目录下的 ``toolchain\gcc10\`` 内。然后重新编译工程，工程可以正常编译，但这种方法，Nuclei QEMU是无法正常使用，如果有Nuclei QEMU需求的项目，需要收到修改下QEMU对应的调试配置。

|image2|

.. _ide_advanceusage_3:

通过工具将工程转换成支持GCC 13的工程
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

为了方便用户导入旧的工程，并能正常使用Nuclei Studio 2023.10特性，我们提供了快速转换工具 ``Convert GCC 10 Project to GCC 13`` ，选中工程点击鼠标右键，在弹出的菜单中找到 ``Convert GCC 10 Project to GCC 13`` 并点击。

|image3|

工程转换成功后，重新编译工程，此时Nuclei Studio将调用GCC 13编译工程，并且QEMU等功能也能正常使用。

|image4|

.. _ide_advanceusage_4:

批量将工程转换成支持GCC 13的工程
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

为了方便用户导入旧的工程，并能正常使用Nuclei Studio 2023.10以上版本的特性，批量将工程转换成支持GCC 13的工程。

|image5|

打开转换工具，然后选择需要转换的工程，开始转换。

|image6|

工程转换完成后，页面会显示工程转换成GCC 13后的结果。

|image7|

.. _ide_advanceusage_7:

Nuclei Studio 2022.12之后版本导入旧工程
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

为了方便工程共享，Nuclei Studio 2022.12版对工程的导入做了优化，在IDE中将一个工程导出后，可以双击打开 ``.nuproject`` 的方式，快速将工程在Nuclei Studio中导入并打开。

首先，在Nuclei Studio 2022.12版中导出一个工程，在需要导出的工程上右键，选中Export。

|image8|

在弹出的Export对话框中 ``General->File System`` ,按向导依次操作，可以把工程导出到指定文件夹。

|image9|


|image10|


其次，导入工程。查看导出的工程，可以看到工程中有一个test.nuproject文件，点击这个文件，就可以将工程导入到Nuclei Studio中去了，具体的可以参考 :ref:`通过应用关联文件导入工程 <ide_projectnew_8>` 。

|image11|

Nuclei Studio 2022.12之前版本导入旧工程
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Nuclei Studio 2023.10版本工具链名称从 ``riscv-nuclei-elf-gcc`` 更名为 ``riscv64-unknown-elf-gcc`` ,且gcc版本从gcc10升级到gcc13。

Nuclei Studio从2020.08版本开始，官方工具链从 ``RISC-V Nuclei GCC (riscv-nuclei-elf-gcc)`` 升级到 ``GNU MCU RISC-V GCC (riscv-none-embed-gcc)`` ，因为编译前缀发生变化，所以使用201909及其之前版本的IDE生成的工程，经过调整设置后才可以在新版本IDE中使用。这里以201909版本的Nuclei Studio生成的helloworld工程为例，其导入及修改设置的详细步骤如下：

-  导入201909版本生成的helloworld工程，详细的导入方式请参考5.2节，这里不做赘述。

-  导入工程后右击选择 ``Properties`` 打开设置页面，选择 ``C/C++ Build ?? Settings`` ，打开Toolchains栏目然后修改Name下拉选项为 ``RISC-V Nuclei GCC (riscv-nuclei-elf-gcc)`` 。修改后点击Apply保存修改。

|image12|

-  修改后右击工程选择 ``Clean Project`` 再选择 ``Build Project`` 即可。

.. _ide_advanceusage_13:

LST View
--------

在Nuclei Studio 2024.06版本中，集成了LST View工具，LST View可以单独使用，也可以在Trace工具或GProf工具中被呼起，主要功能，是帮助用户方便的查看LST文件，并实现LST文件与源码的联动。

在Nuclei Studio中依次 ``Window -> Show View -> Other`` ，在弹出的Show View中搜索 ``LST View`` 。

|image13|

打开LST View工具。

|image14|

LST View的顶部有一个工具栏，在工具栏中有搜索下接框，可以输入您想要搜索的Addr；Open File菜单，点击会弹出一个文件选择器，可以选择想要打开的 ``.lst`` 文件；Find菜单，可以查找任意您想从LST View中查找的内容。

|image15|

Open File菜单，在弹出的文件选择器中，找到我们想要查看的lst文件，一般在工程编译后的Debug目录。

|image16|

打开文件后，可以进行查找操作，同时，当我们选中某行文字，并且文字中包含一个正确的Addr时，LST View会通过这个Addr定位到对应的源码所在的文件及行数，并通过程序打开对应的源码文件，并将光标定位到对应的行，通过lst文件反定位的源文件，实现两种文件的联动查看。

|image17|

.. _ide_advanceusage_17:

Code Coverage和Profiling功能
----------------------------

在Nuclei Studio 2023.10版以上版本中，集成了\ `Eclipse Linux
Tools <https://github.com/eclipse-linuxtools/org.eclipse.linuxtools/blob/master/RELEASE_NOTES.md#eclipse-linux-tools-release-notes>`__\ ，并对\ `Eclipse
Linux
Tools <https://github.com/eclipse-linuxtools/org.eclipse.linuxtools/blob/master/RELEASE_NOTES.md#eclipse-linux-tools-release-notes>`__\ 工具进行了部分优化，使其可以支持Nuclei
Studio工程使用Code Coverage和Profiling相关功能。在Nuclei Studio
2024.06版本中对\ `Eclipse Linux
Tools <https://github.com/eclipse-linuxtools/org.eclipse.linuxtools/blob/master/RELEASE_NOTES.md#eclipse-linux-tools-release-notes>`__\ 的功能做了进一步的优化和升级，使其更容使用。

关于Coverage、Profiling和Call Graph的使用教程请查看 :ref:`Coverage、Profiling和Call Graph使用 <ide_advanceusage_21>` 。

关于Eclipse Linux Tools的详细参见
`Eclipse Linux Tools <https://github.com/eclipse-linuxtools/org.eclipse.linuxtools/blob/master/RELEASE_NOTES.md#eclipse-linux-tools-release-notes>`__\

在使用过程，如有问题，可以查看 `https://github.com/Nuclei-Software/nuclei-studio <https://github.com/Nuclei-Software/nuclei-studio>`__  相关内容，也可以向我们提交相关issue。

.. note::

   在 **芯来科技视频号** 中有 **如何在Nuclei Studio中使用Code Coverage和Profiling功能** 的视频，您可以在微信中搜索 **芯来科技视频号** 点击查看相关内容。

关于Code Coverage功能
~~~~~~~~~~~~~~~~~~~~~

Nuclei Studio中的Code Coverage功能是借助于gcc编译器提供gcov工具来查看指定源码文件的代码覆盖率，可以帮助开发人员确定他们的测试用例是否足够充分，是否覆盖了被测代码的所有分支和路径。

在Nuclei Studio中，通过给工程中的文件或者文件夹添加 ``--coverage`` 或者 ``-coverage`` 编译选项编译，在实际开发板上运行时，可以配合semihost功能实现文件读写到主机电脑上，就可以收集到需要的coverage文件(gcda/gcno文件)，或者通过 `Nuclei SDK提供的profiling库 <https://github.com/Nuclei-Software/nuclei-sdk/tree/master/Components/profiling>`__ 来实现将coverage数据打印到串口上，然后通过IDE来解析并保存到主机上。

.. note::
   注意：此处只需要将编译选项 ``--coverage`` 或者 ``-coverage``  加到特定的应用目录或者源码文件上，而不能加到整个工程，否则在程序运行时将会消耗大量内存，导致运行失败。

-  ``.gcno`` 文件是在使用 GCC 编译器的 ``-ftest-coverage`` 选项编译源代码时生成的。它包含了重构基本块图和为块分配源代码行号的信息。

-  ``.gcda`` 文件是在使用 GCC 编译器的 ``-fprofile-arcs`` 选项编译的目标文件运行时生成的。每个使用该选项编译的目标文件都会生成一个单独的 ``.gcda`` 文件。它包含了弧转移计数、值分布计数以及一些摘要信息。

而一般情况下直接使用 ``--coverage`` 或者 ``-coverage``  选项就可以让指示编译器产生上述文件，注意 ``*.gcda`` 文件是运行时产生的，也就是说需要实际运行的环境支持文件的读写才可以产生这样的文件，这里我们采用的是semihost技术，通过openocd的semihost功能，将文件写到主机上。

.. note::

   注意：进行coverage的时候，建议是使用 ``O0`` 编译，这样coverage的信息才会尽可能的准确。

关于Code Coverage的功能详细参见

-  `Gcov Intro (Using the GNU Compiler Collection
   (GCC)) <https://gcc.gnu.org/onlinedocs/gcc/Gcov-Intro.html>`__

-  `Gcov Data Files (Using the GNU Compiler Collection
   (GCC)) <https://gcc.gnu.org/onlinedocs/gcc/Gcov-Data-Files.html>`__

-  `Code Coverage for Embedded Target with Eclipse, gcc and gcov \| MCU
   on
   Eclipse <https://mcuoneclipse.com/2014/12/26/code-coverage-for-embedded-target-with-eclipse-gcc-and-gcov/>`__

关于Profiling功能
~~~~~~~~~~~~~~~~~

Nuclei Studio中的Profiling功能是借助于gcc编译器和binutils中的gprof工具，来查看指定文件中函数的运行时间和调用次数，以及调用关系。gprof可以用来确定程序的瓶颈，以便进行性能优化。gprof通过在程序运行时收集数据来工作，然后生成一个报告，该报告显示每个函数在程序中占用CPU时间的百分比以及函数之间的调用关系。

在Nuclei Studio中，通过带特定的编译选项 ``-pg`` 编译指定源码文件，在实际开发板上运行时，可以配合semihost功能实现文件读写到主机电脑上，就可以收集到需要的coverage文件(gcda/gcno文件)，或者通过 `Nuclei SDK提供的profiling库 <https://github.com/Nuclei-Software/nuclei-sdk/tree/master/Components/profiling>`__ 来实现将coverage数据打印到串口上，然后通过IDE来解析并保存到主机上。

.. note::
   注意：此处只需要将编译选项 ``-pg`` 加到特定的应用目录或者源码文件上，而不能加到整个工程，否则在程序运行时将会消耗大量内存，导致运行失败。

产生这个 ``gmon.out`` 文件需要配合编译器并且实际上板运行，并且运行环境支持文件的读写，才可以进行有效的Profiling功能。

关于Profiling的功能详细参见

-  `Introduction (GNU
   gprof) <https://sourceware.org/binutils/docs/gprof/Introduction.html>`__

-  `Using GNU Profiling (gprof) With ARM Cortex-M -
   DZone <https://dzone.com/articles/using-gnu-profiling-gprof-with-arm-cortex-m>`__

.. _ide_advanceusage_18:

关于Call Graph功能
~~~~~~~~~~~~~~~~~~

Call Graph（调用图）是一个强大的工具，它允许开发人员直观地理解程序中函数或方法之间的调用关系。通过Call Graph，开发人员可以迅速识别出哪些函数被频繁调用，哪些函数是关键的入口点，以及函数之间的依赖关系。Nuclei Studio中Call Graph主要是通过分析Profiling的数据，来获取到程序的调用关系。

在NucleiStudio中依次 ``Window -> Show View -> Other`` ，在弹出的Show View中搜索 ``Call Graph`` ，打开 ``Call Graph`` 工具。 ``Call Graph`` 工具中提供了多处视图，其中常用到的视图有以下几个。

Radial View
^^^^^^^^^^^

本视图中展示了程序的调用关系，在左侧的菜点中，双击选中某个父节点，在右侧的区域将显示以这个父节点开始的所有的调用关系，也可以通过菜单在其他视图中以不同的方式查看所选中的调用关系。

|image18|

Tree View
^^^^^^^^^

展示了Radial View中所选中的程序的调用关系、耗时所占比率、调用次数等信息；选中某一个函数，可以查看到它的父节点以及子节点等信息。

|image19|

Level View
^^^^^^^^^^

与Tree View有点类似，展示了程序的调用关系以及调用次数。

|image20|

Aggregate View
^^^^^^^^^^^^^^

以方图的方式，非常直观的展示了程序的耗时关系。

|image21|

.. _ide_advanceusage_21:

.. _ide_advanceusage_profiling:

Coverage、Profiling和Call Graph使用
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

在NucleiSudio 2024.06版中使用Coverage、Profiling和Call Graph方法很简单，下面以NucleiSudio 2024.06、nuclei_sdk 0.6.0为例，通过两种方式分别演示如何使用Coverage、Profiling和Call Graph工具。

通过串口使用
^^^^^^^^^^^^

nuclei_sdk 0.6.0及以上版本的nuclei_sdk中，包含一个 ``Profiling demo to show how to use gprof and gcov`` 测试工程，在NucleiSudio安装了nuclei_sdk 0.6.0后，可以创建此测试工程。关于 ``Profiling demo to show how to use gprof and gcov`` 测试工程,可参考 `demo_profiling <https://doc.nucleisys.com/nuclei_sdk/design/app.html#demo-profiling>`__ 。

|image22|

工程创建后，需要对想要进行代码分析的文件或文件夹设置一个 ``-pg`` 、 ``--coverage`` 或者 ``-coverage``  的编译选项，然后编译工程。

.. note::
   注意：此处只需要将编译选项  ``-pg`` 、 ``--coverage`` 或者 ``-coverage``   加到特定的应用目录或者源码文件上，而不能加到整个工程，否则在程序运行时将会消耗大量内存，导致运行失败。

|profiling_options_in_ide|

在编译通过的工程的Debug目录中，可以看到，已经生成了几个 ``.gcno`` 的文件。

|image23|

工程编译完后，可以运行或调试工程，我们可以选择在QEMU下进行，也可以调试实际的开发板。本例以QEMU为例进行运行程序，在NucleiStudio的Console窗口中可以看到Profiling信息输出，如果是在开发板上调试，则是在串口输出中可以找到Profiling信息输出。

|image24|

输出的Profiling信息需要解析后NucleiStudio才可以正确读取，在Console框内点击鼠标右键，然后在弹出的菜单中点击Select All，来选中所有输出，再次击鼠标右键，在弹出菜单中选择 ``Parse and Generate HexDump`` 菜单。

|image25|

此时NucleiStudio会对输出的文件进行分析，并将结果分别存放在对应的文件中。

|image26|

再次查看工程的Debug目录，可以看到产生了对应的 ``.gcda`` 文件。

|image27|

双击 ``.gcda`` 文件，打开Gcov工具，就可以看到对应用程序的分析结果，在结果中显示了某个文件或某个方法在程序执行过程中是否执行到，以及代码执行覆盖比等数据。

|image28|

双击Gcov中的某一行，NucleiStudio就会自动打开对应的文，并对文件中的代码着色，绿色表示在程序执行过程中有执行到，红色代表在程序过程中没有被执行到。开发者可以参考Gcov的结果，并对代码做出相应的优化。

|image29|

code coverage也提供了以直方图的方式查看数据，选中想要查看的数据项，点击菜单中的直方图菜单，并按需求配置。

|image30|

就可以在Nuclei Studio中查看code coverage直方图信息了。

|image31|

双击 ``gmon.out`` 文件，弹出一个文件选择框，提示填写与选中与 ``gmon.out`` 文件相关的elf文件和 ``*.lst`` 文件，默认会根据当 ``gmon.out`` ，自动填入对应的工程内的 ``elf文件`` 和 ``*.lst`` 文件，点击OK按钮。

|image32|

Gprof工具会启动，就可以看到对应用程序的分析结果，显示了文件、方法的调用关系等。

双击Gprof中的某一行，NucleiStudio就会自动打开对应的源文件并定位到对应的行，同时打开LST View工具，并根据addr定位那一行，实现Gprof、源代码、反汇编码的联系，帮用户快速了解程序结构及调用关系。

|image33|

同样在Nuclei Studio中，可以查看profiling数据的直方图信息。

|image34|

打开Gprof的同时，NucleiStudio会根据gmon.out文件解析出程序的Call Graph并生成 ``callgraph.out`` 文件。双击 ``callgraph.out`` 文件，也可以点击Gprof工具的菜单栏中 ``Open Call Graph View`` 按钮，来启动Call Graph工具。关于Call Graph的具体使用，可以参考 :ref:`关于Call Graph功能 <ide_advanceusage_18>` 。

|image35|

通过Semihosting使用
^^^^^^^^^^^^^^^^^^^

NucleiSudio安装了nuclei_sdk 0.6.0后，可以创建一个 ``Profiling demo to show how to use gprof and gcov`` 的测试工程，此时需要选中 ``Enable Semihosting`` 。关于 ``Profiling demo to show how to use gprof and gcov`` 测试工程,可参考 `demo_profiling <https://doc.nucleisys.com/nuclei_sdk/design/app.html#demo-profiling>`__ 。

|image36|

工程创建后，需要对想要进行代码分析的文件或者文件夹设置一个 ``-pg --coverage`` 的编译选项，然后编译工程。

|profiling_options_in_ide|

同时，需要修改程序中 ``gprof_collect(2);`` 为 ``gprof_collect(1);`` 、 ``gcov_collect(2);`` 为 ``gcov_collect(1);`` （测试工程中在main函数的最后），则在运行过程中，将会通过Semihosting将结果输出为文件。

|image37|

开始编译工程，在编译通过的工程的Debug目录中，可以看到，已经生成了几个 ``.gcno`` 的文件。

|image38|

工程编译完成后，可以运行或调试工程，我们可以选择在QEMU下进行，也可以调试实际的开发板。

|image39|

本例以QEMU为例进行运行程序，程序运行结束后，刷新工程，可以看到工程下多出了几个文件， ``*.gcda`` 文件以及 ``*.out`` 文件。至此，后面查看结果与上面类似。

|image40|

在Nuclei Studio中通过gcov工具查看应用程序的Code Coverage信息。

|image41|

在Nuclei Studio中通过gprof工具查看应用程序的Profiling信息。

|image42|

在Nuclei Studio中通过Call Graph查看调用关系信息。

|image43|

.. _ide_advanceusage_43:

.. _ide_etrace:

Trace功能的使用
---------------

Trace技术是一种强大的调试工具，它能够帮助开发人员跟踪和记录程序执行过程中的关键信息，从而有效地诊断问题、优化性能和提升系统的稳定性。

Nuclei Studio集成了Trace工具，结合相应硬件和Nuclei OpenOCD，用户在工程Debug时可查看Trace日志，并结合源码进行问题排查。

.. note::

   在 **芯来科技视频号** 中有 **如何在Nuclei Studio中使用Trace功能** 的视频，您可以在微信中搜索 **芯来科技视频号** 点击查看相关内容。

.. note::

   关于OpenOCD的Nuclei ETrace的一些命令，请参加OpenOCD下的openocd.pdf手册。

在使用过程，如有问题，可以查看 `https://github.com/Nuclei-Software/nuclei-studio <https://github.com/Nuclei-Software/nuclei-studio>`__  相关内容，也可以向我们提交相关issue。

Trace界面介绍
~~~~~~~~~~~~~

.. rubric:: Trace View

在Nuclei Studio中，通过菜单 ``Window->Show View->Other`` 打开View管理器，在里面找到RV Trace->Trace菜单，点击打开Trace菜单。

|image44|

Trace的视图分两部分，上面为Trace工具栏，下面是Trace记录表格。Trace工具栏的介绍和功能分别如下：

- **Trace setting**

trace的配置信息，在这里配置Trace ATB2AXI Config Addr、Trace Buffer Base Addr、Trace Buffer Size in Bytes、Trace Wrap

- **Start trace/stop trace**

设置开始/停止trace操作。

- **Trace clear**

清空硬件上的所有的trace设置。

- **Dump trace file**

从硬件上Dump trace文件。

- **Reload trace file**

本地重新加载trace记录表内容。

- **Clear viewer**

清空trace记录表内容，以及Trace Decode相关的配置，如HartID和Thread的关系等。

- **Save trace log**

将trace记录表保存为csv表格。

- **Toggle instruction stepping**

当选种某条记录时，可以打开并定位到该条记录所对应的源码和反汇编码。

- **step into previous line**

当选种某条记录时，跳转到该条记录的上一条记录，并定位到所对应的源码和反汇编码。

- **step into next line**

当选种某条记录时，跳转到该条记录的下一条记录，并定位到所对应的源码和汇编码。

- **Search for Addr**

搜索框，可以通过Addr 搜索到对应的那一行trace记录。

- **search backward**

搜索结果的记录是多条时，可以查看上一条搜索结果。

- **search forward**

搜索结果的记录是多条时，可以查看下一条搜索结果。

- **Page**

多页的翻页，trace如果条数很多时，为了方便查看，会采用多页显示。

Trace记录表格，是Nuclei Studio将dump到的trace文件进行解密之后，生成的记录进行展示，并且当用户点击某条记录时，会自动定位到对应的源代码和反汇编代码的行数。

- **Record：** 记录id

- **CoreId：** Coreid，主要是在多核时可以用于区分不同的Core

- **Addr：** 指令地址

- **CPU Clock：** 时钟Cycle计数

- **Clock Diff：** 时钟Cycle差

- **Instruction Code：** 十六进制表示的指令码

- **Instruction：** 指令码

- **File：** 指令码对应的源码所在的文件

- **File Line：** 指令码对应的源码所在的文件的行数

.. rubric:: Trace Configuration

用户可以在这里配置Trace的Trace ATB2AXI Config Addr、Trace Buffer Base Addr、Trace Buffer Size in Bytes、Trace Wrap。具体的信息，根据不同的硬件而不同。

|image45|

- **Trace need to be configured:** 如果需要配置Trace模块就勾选，如果其他地方已经配置过了，就千万不要勾选了，例如多核SMP/AMP的情况下，SoC上只有一个Trace模块，假设其中一个核心已经勾选配置了，其他的核心就不能勾选了，或者是配置是在C代码中或者其他地方做了，也千万不要勾选。

- **Trace ATB2AXI Config Addr：** ATB2AXI模块控制器的基地址。

- **Trace Buffer Base Addr：** 存放trace记录的开始地址，例如：针对某个SoC, 举例如下在flashxip模式，使用ilm（0x1c000000）作为缓存buffer；在sramxip模式，使用dlm（0x08010000）作为缓存buffer。

- **Trace Buffer Size in Bytes：** 存放trace记录的Buffer大小，单位为字节。

- **Trace Wrap：** 是否允许自动复盖，允许则在Buffer满时，将再次从头开始覆盖记录。

.. rubric:: Trace Decoder Configuration

Set Current Debug hart Configuration弹框中，用户可以自定义trace decoder的参数，具体如下。

|image46|

- **ELF File Path：** trace生产时执行的elf文件的地址。

- **Trace File Path：** 需要解析的trace文件的地址。

- **Objdump Path：** trace decode过程中，需要用到objdump工具，所以这里需要指定所使用到的objdump工具的地址。

- **HartID：** trace decode时需要指定当前需要查看的trace对应的HartID，单核工程默认HartID=0。

- **Trace Data Align Size：** 跟踪数据对齐大小，一般与硬件的trace输出位宽对齐，默认有8、32、64。

- **Display Address Bits：** trace decode后显示地址的位数，一般是32、64、128位。

Trace的使用
~~~~~~~~~~~

在使用trace功能时，必须在工程Debug时，通过Nuclei OpenOCD或者Dlink将Trace命令下发到硬件，目前通过OpenOCD，可以实现在单核、多核SMP和多核AMP应用下进行Trace记录，而Dlink仅支持在单核应用下的trace记录。

下面我们以OpenOCD为例，演示如何使用Trace功能。

在单核应用中使用Trace
^^^^^^^^^^^^^^^^^^^^^

如果您已获取到芯来授权的CPU和相关配套硬件并准备好硬件环境，这里不详细说明。然后创建好对应工程并确保它能在硬件上运行和调试。以下示例是在我们自己构建的一个测试环境上的流程举例说明。

我们在这里创建了一个N900的单核应用helloworld，并让它跑在FLASHXIP模式下。

|image47|

我们可以记录整个应用运行完的trace，也可以记录某一段Debug断点之间的trace。进入Debug模式后，打开Trace视图。

|image48|

设置Trace Configuration，设置trace配置信息并保存(Save)，如果不想保存，就关闭窗口。

|image49|

Trace配置完毕后，可以设置两个断点，一个断点用于Trace开始点，一个断点用于Trace结束点，在开始点断点停下后就可以点击 ``start trace`` 按钮，就可以继续debug操作(如单步或者运行等)了，在结束点断电停下后，就可以点击 ``stop trace`` 按钮来结束Trace。
上面只是Start/Stop
Trace的一种使用示例，也可以更灵活一些，请根据自己需要进行使用。当trace结束时（多核情况下请确保每个CPU的Trace都结束了），就可以点 ``Dump trace file`` 按钮，将trace文件从硬件上下载到本地，默认下载的trace文件存在工程目下的debug目录下，有一个 ``工程名.trace`` 的文件。

|image50|

Trace文件下载完后，Nuclei Studio会弹出一个 ``Set current debug hart configuration`` 框。

|image51|

在框中填写确正信息（这里的HartID指的是对应的Thread的hartid，请不要填错了）并确认，Nuclei Studio对trace文件开始解析，并生成trace记录表格。在trace记录表格，选中任意一条记录，Nuclei Studio会自动找到源码和反汇编码，并定位那对应的那一行（因反汇编码与源码在同一个视图中打开，需要用户自己把反汇编码移到另一个视图中）。

|image52|

也可以双击 ``工程名.trace`` 文件，以文本的方式查看trace文件。

|image53|

在SMP多核应用中使用Trace
^^^^^^^^^^^^^^^^^^^^^^^^

在SMP多核应用中使用trace与单核大体相似，差别在于SMP多核在Debug时，不同的thread共用一个Trace Configuration， 且需要通过选择不同的Thread来对不同的CPU Hart核心单独 ``start trace/stop trace`` 。在Debug视图中，点击任意一个Thread,然后点击Trace工具栏中的 ``trace setting`` 来设置Trace Configuration。

|image54|

在Debug视图中，可以通过点击不同的Thread,来切换不同的Core,如下图点击Thread #1或者Thread #1下对应的函数名来选中对应的是SMP多核应用中的Core 0,可以对Core
0开启或者关闭Trace，在SMP多核应用中，只要有一个Core在完成start trace操作时,Trace Configuration中的信息就会在硬件中设置好，其他的core在 ``start trace`` 操作时，就不会重复设置trace Configuration。

|image55|

同理，在Debug视图中点击Thread #2或者Thread #2下对应的函数名，来切换到Core 1上进行 ``start trace/stop trace`` 的操作。

|image56|

在 ``dump trace file`` 操作时，在SMP多核应用中，只有当所有的Core都 ``stop trace`` ，才可以执行 ``dump trace file`` 的指令并成功下载Trace文件。Trace文件的下载，在SMP多核应用中，只需要下载一份，在对trace文件进行decode时，注意设置Hart ID，就可以解析出不同的trace记录表，如下图，当 ``HardID=0`` 时，就可以查看到Core 0对应的Trace记录。

|image57|

同理当 ``HardID=1`` 时，就可以查看到Core 1对应的Trace记录。

|image58|

在AMP多核应用中使用Trace
^^^^^^^^^^^^^^^^^^^^^^^^

在AMP多核应用中使用trace也类似，trace配置也是共享。不同的thread共用一个trace configuration，但可以通过不同的thread，对不同的核单独 ``start trace/stop trace`` 。如下图，在Debug视图，点击 ``Thread #1`` 或者 ``Thread #1`` 下的函数名，切换到AMP多核应用中 ``Core 0`` ，然后点击Trace工具栏中的 ``trace setting`` 来设置Core 0对应的Trace Configuration。

|image59|

在Debug视图，点击 ``Thread #2`` 或者 ``Thread #2`` 下的函数名，切换到AMP多核应用中 ``Core 1`` ，然后点击Trace工具栏中的 ``trace setting`` 来设置 ``Core 1`` 对应的Trace Configuration，因为在AMP多核应用中trace配置是共用，所以此处设置需要将 ``Trace need to be configured`` 的勾去掉，表示可以使用trace功能，但不需要有任何设置。

|image60|

Trace Configuration设置完成后，同样的通过Debug视图的Thread来切换不同的Core，进行 ``start trace/stop trace/dump trace file`` 操作,注意，设置了Trace Configuration的Core需要优先于其它Core开始 ``start trace`` ，并将Trace Configuration的信息设置好，其他的Core才可以正常的 ``start trace/stop trace/dump trace file`` 操作。

在 ``dump trace file`` 操作时，在AMP多核应用中，请确定所有的Core都 ``stop trace`` ，才执行 ``dump trace file`` 的指令，否则可能在某一下Core在 ``dump trace file`` ，其他的Core还在记录trace，最后得到的Trace文件并与预期不符。Trace文件下载，在AMP多核应用中，需要每一个工程应用单独dump一份trace文件，其实dump到的trace文件内容是一样的，在对trace文件进行decoder时，同样需要注意设置 ``Core Hart ID`` ，就可以解析出对应的trace记录表。其他操作与上文内容中所述类似。

查看脱机Trace
^^^^^^^^^^^^^

在某些场景下，用户可能通过命令行或其他方式，得到了一个trace文件，这时只需打开 ``Set Current Debug hart Configuration``，并按要求配置好参数，即可通过NucleiStudio的trace工具解析这个trace文件了。

|image61|

.. _ide_advanceusage_61:

RVProf功能的使用
----------------

RVProf是芯来科技针对cpu cycle model开发的性能分析工具，Nuclei Studio在2024.02.dev版本中，完成对RVProf的支持。在实际使用中，RVProf功能分三步完成，首先通过Cycle model工具，运行代码，产生 ``.rvtrace`` 文件，然后RVProf工具，将 ``.rvtrace`` 解析成对应的 ``.json`` 文件，最后通过google的开源工具Perfetto Trace Viewer对 ``.json`` 文件进行解析并展示。因为cpu cycle model当前仅提供了linux版本，所以本文档均是在linux环境下演示此功能。

在使用过程，如有问题，可以查看 `https://github.com/Nuclei-Software/nuclei-studio <https://github.com/Nuclei-Software/nuclei-studio>`__  相关内容，也可以向我们提交相关issue。

测试环境
~~~~~~~~~

cpu cycle model在运行过程中，对硬件环境的性能要求较高，在实际使用，四核及以上的系统中运行效果较好，一般不建议在虚拟机环境下使用。为了较好的体验效果，本测试在工作站上进行。

|image62|

准备测试NPK软件或者工具包
^^^^^^^^^^^^^^^^^^^^^^^^^^

目前此功能仅提供测试用的NPK包，将相关的包安装到Nuclei Studio中，关于安装NPK包，可以查看Nuclei Studio手册中相关章节，因为RVProf测试包没有公开，请联系我们索取。

-  cymodel.zip cymodel的NPK Tools包

-  rvprof.zip RVProf的NPK Tools包

-  Rvprof helloworld.zip 测试demo NPK App包

创建rvprof测试工程
^^^^^^^^^^^^^^^^^^^

创建工程前，先查看Nuclei Package Management中NPK是否安装正确，因为测试demo是依赖于nuclei_sdk，所以也要先安装sdk-nuclei_sdk，具体如下：

|image63|

然后创建一个test测试工程,在创建工程的向导中，依次 ``New Nuclei RISC-V C/C++ Project -> sdk-nuclei_sdk@0.5.0 -> next`` ,在工程配置页面，依次填写工程名、选择Project Example： ``rvprof helloworld@app-nsdkrvprof_helloworld`` ,Nuclei RISC-V Core: ``N307FD`` （这里的code要跟cpu cycle model对应）。

|image64|

在Project Example可以看到我们导入的demo NPK App中的Rvprof helloworld工程，选择此工程，然后下一步，完成工程的创建。

|image65|

在创建的test工程中，可以看到多了一个 ``test_debug_rvprof.launch`` 文件，rvprof相关的配置在此文件中，可以查看内容如下。其中Cycle Model的time out时间，用来设置Cycle Model超时时间，因为Cycle Model运行时比较耗时，如果工程比较简单，可以设置一个较短的起始时间，到时间后，可以及时中断Cycle Model的运行；RVProf中的超时时间的功能也是类似。

|image66|

查看rvprof的结果
~~~~~~~~~~~~~~~~~

创建完工程后，在Nuclei Studio的launch bar上，选中 ``test_debug_rvprof.launch`` ，并点击工具栏中的运行按钮，Nuclei Studio依次完成以下任务，并将最终的结果在在Perfetto Trace Viewer中展示。

-  编译工程代码

-  启动Cycle Model并产生trace文件

-  启动RVProf解析trace文件生成json文件

-  启动Perfetto Trace Viewer展示结果

Cycle Model启动及log输出

|image67|

perfetto启动本地服务

|image68|

Perfetto Trace Viewer的官方地址是https://ui.perfetto.dev/ 。Nuclei Studio默认会尝试打开https://ui.perfetto.dev/ ，同时自动载入json文件并解析。如果因为网络原因（国外服务器）打开失败，Nuclei Studio会在本地启一个Perfetto Trace Viewer本地服务，并自动打开本地localhost:5000/，此时需要用户手动载入工程目录下的 ``Debug/test.json`` 文件。在Perfetto Trace Viewer中可以看到trace的展示结果。

Nuclei Studio会在本地启一个web服务，同时打开Perfetto Trace Viewer。

|image69|

点击Open trace file，找到工程中生成的json文件，手动将json文件load到Perfetto Trace Viewer中。

|image70|

些时，在Perfetto Trace Viewer就可以查看到rvprof trace结果展示了，用户可以通过键盘的 ``W/A/S/D`` 按键查看更详细的信息。

|image71|

.. _ide_nuclei_nice_wizard:

Nuclei NICE Wizard
---------------------

.. note::

   在 **芯来科技视频号** 中有 **Nuclei NICE Wizard** 的视频，您可以在微信中搜索 **芯来科技视频号** 点击查看相关内容。

Nuclei NICE Wizard 是一个集成在 Nuclei Studio 上的工具，旨在简化和加速 NICE (自定义指令扩展) 和 VNICE (向量化自定义指令扩展) 指令的创建过程。它允许用户通过图形界面快速配置并生成自定义指令所需的代码框架，从而实现对特定应用算法的硬件加速。具体来说：

- **简化开发流程**：减少从构思到实现自定义指令的时间。

- **提高效率**：通过生成优化后的指令代码，提高应用程序的执行效率。

- **易于集成**：生成的代码可以直接整合到现有项目中，减少了额外的工作量。


创建.nice文件，打开Nuclei NICE Wizard
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

在 Nuclei Studio 中打开目标工程，并在项目根目录下创建一个 ``*.nice`` 文件（例如 aicc.nice），双击打开Nuclei NICE Wizard。

|image-nice-1|

|image-nice-2|

新增指令
~~~~~~~~

点击 ``Add...`` ,根据需要修改指令内容后，点击右上角 ``save`` 即可。

这里举例先创建两条指令，同时左侧被选中的指令会变灰，对应内容显示在右侧。

|image-nice-3|

删除指令
~~~~~~~~~

左侧选择对应指令，点击Remove，确认后删除对应指令。

|image-nice-4|

修改指令
~~~~~~~~

左侧选择对应指令，修改指令内容后，右上save和discard按钮变红，可保存修改或放弃修改。

|image-nice-5|

文件生成
~~~~~~~~

可定义insn.h（包含内嵌汇编头文件）和 nice.cc（包含指令实现逻辑）文件的保存地址，点击Save and Generate File，会生成对应文件。

|image-nice-6|

|image-nice-7|

|image-nice-8|

NICE指令模板说明
~~~~~~~~~~~~~~~~

|image-nice-9|

单个指令模板如上图所示，
 * opcode: 可选custome-0,custome-1,custome-2,custome-3
 * funct3: 3位功能字段，通常用来区分不同类型的指令。
 * funct7: 7 位功能字段，可以用来进一步细分指令类型或提供额外的功能选项。
 * rd: 返回值寄存器或类型（例如 void, int, vint8m8_t 等）。
 * rs1, rs2: 输入源寄存器或类型。

指令内容编辑说明
~~~~~~~~~~~~~~~~

|image-nice-10|

如上图，Instruction content显示默认内容。

  * **Instruction name** ：指令名称，具体定义规范如下

      * **字母和数字** ：函数名可以包含字母 ``(A-Z，a-z)`` 和数字 ``(0-9)`` ，但是不能以数字开头。

      * **下划线** ：函数名中可以使用下划线 ``_`` 来提高可读性，尤其是在多单词组合的情况下。例如，``get_user_name`` 是一个有效的函数名， ``<  ， >  ， …  ， ?  ， /`` 都不允许出现在函数名中。

      * **特殊字符** ：除了下划线以外，其他特殊字符如 ``! ， @ ， # ， $ ， % ， ^ ， & ， * ， ( ， ) ， { ， } ， [ ， ] ， \ ， : ， ; ，`` 。

      * **关键字** ：函数名不能是C语言的关键字或保留字，比如 ``int ， char ， float ， double ， if ， else ， while ， for , return``  等等。

  * **Function name** ：函数名称，在不勾选的情况下生成的对应函数名为指令名称，命名规范与 ``Instruction name`` 相同。

  * **funct7** ：对应模板的 ``funct7`` ，可通过勾选Binary对应项设置。

  * **funct3** ：对应模板的 ``funct3`` ，可通过勾选Binary对应项设置。

  * **Return Value Type** ：对应模板的rd，可点击Edit Type进行设置，如果rd为void。

  * **Number of Function Parameters** ：参数个数，可设置传入参数rs1、rs2以及rs3（rs3既为参数也为返回值）的对应类型。

      * 参数为0时，Edit Type不可设置，rs1和rs2可在下方指定寄存器，如rd为void类型，rd也可在下方指定寄存器。

      * 参数为1时，Edit Type可设置rs1类型，rs2可在下方指定寄存器，如rd为void类型，rd也可在下方指定寄存器。

      * 参数为2时，Edit Type可设置rs1、rs2类型，如rd为void类型，rd也可在下方指定寄存器。

      * 参数为3时，Edit Type可设置rs1、rs2、rs3类型。


.. _ide_nuclei_model:

Nuclei Model功能的使用
----------------------

芯来科技为 Nuclei Near Cycle Model 开发了专门的运行工具——Model。自 Nuclei Studio 2024.06 版本起，Nuclei Near Cycle Model最初是通过 RVProf 工具运行的。随着 Nuclei Near Cycle Model 的不断迭代和发展，为了提供更简洁高效的用户体验，我们在 RVProf 的基础上进行了功能简化，推出了新的 Model 工具。

新工具的主要特点包括：

**简化功能** ：移除不必要的复杂功能，使用户能够更专注于 Nuclei Near Cycle Model 的核心功能。

**提升效率** ：优化操作流程，减少用户配置和使用的时间成本。

**兼容性好** ：确保与现有工作流无缝集成，同时支持最新的 Nuclei Near Cycle Model 特性。

通过这些改进，用户可以更加高效地利用 Nuclei Near Cycle Model 进行开发和调试。通过Nuclei Studio菜单 ``Run -> Run Configuration`` 打开Run Configuration，然找后到 ``Nuclei Model`` ,双击 ``Nuclei Model`` 菜单，就会生成对应工程的配置。

|image82|

关于Nuclei Model的使用，将在Nuclei Near Cycle Model章节中详细介绍。

.. _ide_nuclei_near_cycle_model:

.. _ide_advanceusage_71:

Nuclei Near Cycle Model
------------------------

在Nuclei Studio 2024.06版中，集成了Nuclei Near Cycle Model，它是由芯来科技自主研发的仿真测试和性能分析工具，可以帮助研发人员在项目初期进行一些必要的仿真测试和程序性能分析。

Nuclei Near Cycle Model在Nuclei Studio 2024.06版中只有Linux版本，从2025.02版开始，已实现对Windows的支持。其具体介绍和命令行上使用参见 （https://doc.nucleisys.com/nuclei_tools/xlmodel/intro.html ） ，下面将在Nuclei Studio上演示如何使用Nuclei Near Cycle Model进行仿真和性能分析。

.. note::

   Nuclei Near Cycle Model 已支持 Windows/Linux 版本，此文档测试都是基于 Nuclei Studio IDE 2025.02的 Windows 版本完成的。

在使用过程，如有问题，可以查看 `https://github.com/Nuclei-Software/nuclei-studio <https://github.com/Nuclei-Software/nuclei-studio>`__  相关内容，也可以向我们提交相关issue。

创建测试工程
~~~~~~~~~~~~

Nuclei Near Cycle Model对芯来全类型的Core都有支持，可以创建任意一个demo工程并编译。创建任意一个demo工程并编译。

|image72|

Nuclei Near Cycle Model采用Nuclei Studio中的Model运行配置来进行运行测试，选中编译好的测试工程，然后打开NucleiStudio的Run Configurations。

|image73|

并创建一个Nuclei Near Cycle Model的配置，具体的配置及参数说明如下。

|image74|

在演示示例的Config options中配置了 ``--trace=1 --gprof=1 --logdir=Debug --cpu=n300fd`` , ``--trace=1`` 表示开启rvtrace， ``--gprof=1`` 表示开启gprof功能， ``--logdir=Debug`` 则表示最终生成的 ``.rvtrace`` 文件、 ``.gmon`` 文件存放的路径为当前工程下的Debug目录, ``--cpu=n300fd`` 表示当前模拟的cpu核是n300fd。

.. note::

   ``--cpu=<core type>`` 必须配置且与Nuclei Setting中配置的Core的值一致。

   ``--ext=<extension type>`` 与Nuclei Setting中配置的Other extensions的值一致。

关于Nuclei Near Cycle Model的参数具体说明，请参见 :ref:`Description of Parameters <xlmodel_description_of_parameters>` 。

运行工程并生成性能分析结果
~~~~~~~~~~~~~~~~~~~~~~~~~~

点击Run按钮，开始运行程序。程序在Nuclei Near Cycle Model中成功执行，输出了对应的Log信息。

|image77|

在工程的Debug目录中可以查看到已经生成 ``.rvtrace`` 文件、 ``.gmon`` 文件。

|image78|

Nuclei Near Cycle Model中支持通过gprof来分析程序，所以当我们配置了 ``--gprof`` ，在程序运行时，也会在Debug目录（ ``--logdir=XX`` 所配置的目录）下同步产生一个 ``.gmon`` 文件，双击 ``.gmon`` 文件，将调用gprof工具来分析程序执行所消耗的cycle数及调用关系；同时也会产生对应的 ``callgraph.out`` 文件，双击 ``callgraph.out`` 文件，调用Call Graph查看程序的调用关系。

调用gprof工具，可以查看生成的 ``.gmon`` 文件中的内容。

|image80|

gprof工具在查看 ``.gmon`` 文件的同时，会根据其内容，解析出程序的调用关系，并生成 ``callgraph.out`` 文件，双击 ``callgraph.out`` 调用Call Graph工具查看。

|image43|

.. _ide_live_watch:

Live Watch功能的使用
---------------------

Live Watch 是一款强大的实时监控工具，专为开发者设计，旨在帮助您更高效地调试和优化代码。通过 Live Watch，您可以即时查看程序运行过程中变量的变化情况，无需打断执行流程或手动添加日志语句。在Nuclei Studio 2025.02版中实现了Live Watch 功能，它支持自动刷新变量值，确保始终看到最新的数据变化。直观的图形化界面，能轻松管理需要监控的变量。

.. note::

   Live Watch功能依赖Nuclei OpenOCD >= 2025.02版本。仅支持Nuclei CPU配置了RISC-V SBA功能。

Live Watch功能介绍
~~~~~~~~~~~~~~~~~~

通过Nuclei Studio菜单 ``Window -> Show View -> Live Watch`` 可以打开Live Watch视图。

|image83|

Live Watch 视图提供了一系列功能菜单，帮助用户更高效地管理和监控变量：

|image84|

**Remove**

   - 删除 Live Watch 视图中指定的变量行。

**Remove All**

   - 清除 Live Watch 视图中所有添加的变量。

**Show Live Plot**

   - 显示 Live Plot 视图，用于对采样的数据进行实时绘图。


在隐藏的菜单栏中，有两个设置菜单用于配置全局属性：

|image85|

**Live Watch Settings**

|image86|

 - Live Watch中的一些常用设置，包含：

     - 包含以下常用设置：

        - Live Watch Speed : 设定 Live Watch 的采样频率,最快为100 ms每次。

        - Live Watch Varible Limit : 限制同时采样的变量数量，最多为10个。

        - Live Plot Limit : 设定 Live Plot 同时绘制的最大样本数，最多同时绘制10个样本。

        - Save Data Path : 指定 Live Watch 采样的数据自动保存路径，供后续分析使用。

        - Save Data Speed : 设定 Live Watch 数据自动保存的频率，默认为每10分钟保存一次。

**Number Format**

   - Live Watch视图变量的值的显示方式。


Live Watch使用演示
~~~~~~~~~~~~~~~~~~

创建一个测试工程，并在工程内实现一个正弦计算。打开Live Watch视图，找到Live Watch Settings并根据需要设置相关参数（无可不设置，直接使用默认值）。

|image87|

.. code-block:: c

   #include <stdio.h>
   #include "nuclei_sdk_soc.h"
   #include <math.h>

   #define PI 3.14159265358979323846
   /**
   * 获取随时间变化的正弦波形变量
   */
   double get_sine_wave_value(double amplitude, double frequency) {
      // 获取当前周期计数器的值
      uint64_t current_cycle = __get_rv_cycle();

      // 计算当前时间（单位：秒）
      double currentTime = (double)current_cycle / SystemCoreClock;

      // 提前计算频率相关的因子
      double omega = frequency * 2 * PI;

      // 计算相位
      double phase = currentTime * omega;

      // 返回正弦值
      return sin(phase) * amplitude;
   }

   int main(void)
   {

      double amplitude = 100.0; // 波形的振幅

      double frequency = 0.1;  // 波形的频率（每秒周期数）

      double sine_value = 0;

      printf("Enter to task_2\r\n");
      while (1) {

         sine_value = get_sine_wave_value(amplitude, frequency);

      }

      return 0;
   }

测试demo中运用了数学函数，所以需要在编译选项中添加 ``-lm`` ，在工程的属性中，找到 ``Settings -> GNU RISC-V Cross C++ Linker -> Libraries``，并添加 ``-lm`` 。

|image99|

通过菜单 ``Windows -> Show VIew -> Live Watch`` ，打开Live Watch视图。

|image88|

编译工程后，Debug运行程序，在Live Watch视图中添加需要查看的变量。

|image89|

让工程全速运行时，可以看到变量的值，以设定的Live Watch Speed变化，如果想要通过Live Plot查看变量的变化曲线，可以选中该条记录，并点击鼠标右键，在弹出的菜单中选中 ``Toggle Live Plot`` ,Live Plot工具就会弹出，并适应的画出变量的变化曲线。

|image90|

Live Plot绘制的曲线图如下

|image91|

在Live Plot中点击鼠标右键弹出菜单，有 ``Suspend``、``Continue`` 两个功能菜单，点击 ``Suspend``，Live Plot会暂停画图。

|image92|

用户可以通过滚动鼠标放大曲线，查看数据详情；点击 ``Continue`` Live Plot会继续绘制曲线。

|image93|


如果不想查看该变量的变化曲线，可以再次点击 ``Toggle Live Plot`` ，将该变量从Live Plot踢除。

|image94|

Live Watch视图中的某个变量，点击鼠标右键，可以修改数据显示的格式。

|image97|

Live Watch视图中的某个变量，点击鼠标右键，将该变量的结果存存为CSV格式文件，方便查阅和使用。

|image96|

Live Watch也会自动将查询到的数据结果保存到 ``Save Data Path`` 中，用户可以在Save Data Path找到对应的CSV格式的数据文件。

|image98|

如果不想继续查看该变量的值，也可以选中该条记录，并点击鼠标右键，在弹出的菜单中选中 ``Toggle Live Watch`` ,Live Watch就不再适时查询该变量的值。

|image95|

Live Watch使用时的一些问题总结
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**对RISC-V SBA的依赖**

前文已经提到，Live Watch对RISC-V SBA的依赖，如果在使用Live Watch时，无法获取到对应的值，有可能是当前CPU不支持RISC-V SBA，如何确认当前CPU是否支持RISC-V SBA，可以尝试以下方法。

在工程处理Debug状态时，获取到将要在Live Watch查看的变量的地址。可以参考如下图。

|image100|

打开telnet工具，配置并连接。如无法连接，请检查OpenOCD服务是否启功正常，telnet端口是否正常开启。

|image101|

依然是在Debug状态下，在telnet工具中，使用命令 ``riscv set_mem_access sysbus`` 将riscv的memory access设置为sysbus(SBA)访问模式，并且尝试读取变量的值。

.. code-block:: c

   > riscv set_mem_access sysbus
   > mdw 0x9000ffd8 4
   0x9000ffd8: 000ab156 404e8df0 9999999a 3fb99999 

如果上述操作能读取到变量的值，那么在全速运行程序的状态下，再次尝试读取变量的值，如果没有报错并且能读取到变量的值，说明当前CPU是支持SBA功能。

.. code-block:: c

   > mdw 0x9000ffd8 4
   0x9000ffd8: 000ab156 404e8df0 9999999a 3fb99999 
   > mdw 0x9000ffd8 4
   0x9000ffd8: d0b53424 c0510557 9999999a 3fb99999 
   > mdw 0x8000ffd8 4
   0x8000ffd8: 00000000 00000000 00000000 00000000 
   > mdw 0x9000ffd8 4
   0x9000ffd8: b169d356 c0580176 9999999a 3fb99999 
   > mdw 0x9000ffd8 4
   0x9000ffd8: a69861c1 c056547d 9999999a 3fb99999 
   > mdw 0x9000ffd8 4
   0x9000ffd8: 4dbf49f2 404022d3 9999999a 3fb99999 
   > mdw 0x9000ffd8 4


**优化级别太高Live Watch读取不到变量的值**

当工程优化级别较高时，Live Watch可能无法获取到某些变量的值，有demo如下。

.. code-block:: c

   int test()
   {
      uint32_t live_watch = 0;
      while(1){
         live_watch += 1;
         delay_ms(100U);
      }
   }

当工程的优化级变为O3或其他更高级别的，Live Watch无法获取到 ``live_watch`` 的值。可以调整工程的优化等级；也可以将需要监控的变量设置为全局变量或者static静态变量，且需要避免被编译器优化，工程代码修改如下。

.. code-block:: c

   int test()
   {
      static uint32_t live_watch = 0;
      while(1){
         live_watch += 1;
         delay_ms(100U);
      }
   }

Flash Programming
------------------

为了满足用户将编译好的二进制文件直接下载到硬件开发板的需求，Nuclei Studio 新增了 Flash Programming 功能。该功能允许用户快速、便捷地将编译好的二进制文件直接下载到硬件开发板中，极大提升了开发和调试的效率；简化操作流程，用户只需点击一次即可完成二进制文件的下载。工程编译好后，找到Flash Programming，并点击，即可完成二进制文件的下载。

具体参见 :ref:`Flash Programming功能 <ide_flash_programming>` 。

|image102|


.. |image1| image:: /asserts/nucleistudio/advanceusage/image2.png

.. |image2| image:: /asserts/nucleistudio/advanceusage/image3.png

.. |image3| image:: /asserts/nucleistudio/advanceusage/image4.png

.. |image4| image:: /asserts/nucleistudio/advanceusage/image5.png

.. |image5| image:: /asserts/nucleistudio/advanceusage/image6.png

.. |image6| image:: /asserts/nucleistudio/advanceusage/image7.png

.. |image7| image:: /asserts/nucleistudio/advanceusage/image8.png

.. |image8| image:: /asserts/nucleistudio/advanceusage/image9.png

.. |image9| image:: /asserts/nucleistudio/advanceusage/image10.png

.. |image10| image:: /asserts/nucleistudio/advanceusage/image11.png

.. |image11| image:: /asserts/nucleistudio/advanceusage/image12.png

.. |image12| image:: /asserts/nucleistudio/advanceusage/image13.png

.. |image13| image:: /asserts/nucleistudio/advanceusage/image14.png

.. |image14| image:: /asserts/nucleistudio/advanceusage/image15.png

.. |image15| image:: /asserts/nucleistudio/advanceusage/image16.png

.. |image16| image:: /asserts/nucleistudio/advanceusage/image17.png

.. |image17| image:: /asserts/nucleistudio/advanceusage/image18.png

.. |image18| image:: /asserts/nucleistudio/advanceusage/image19.png

.. |image19| image:: /asserts/nucleistudio/advanceusage/image20.png

.. |image20| image:: /asserts/nucleistudio/advanceusage/image21.png

.. |image21| image:: /asserts/nucleistudio/advanceusage/image22.png

.. |image22| image:: /asserts/nucleistudio/advanceusage/image23.png

.. |profiling_options_in_ide| image:: /asserts/nucleistudio/advanceusage/image24.png

.. |image23| image:: /asserts/nucleistudio/advanceusage/image25.png

.. |image24| image:: /asserts/nucleistudio/advanceusage/image26.png

.. |image25| image:: /asserts/nucleistudio/advanceusage/image27.png

.. |image26| image:: /asserts/nucleistudio/advanceusage/image28.png

.. |image27| image:: /asserts/nucleistudio/advanceusage/image29.png

.. |image28| image:: /asserts/nucleistudio/advanceusage/image30.png

.. |image29| image:: /asserts/nucleistudio/advanceusage/image31.png

.. |image30| image:: /asserts/nucleistudio/advanceusage/image32.png

.. |image31| image:: /asserts/nucleistudio/advanceusage/image33.png

.. |image32| image:: /asserts/nucleistudio/advanceusage/image34.png

.. |image33| image:: /asserts/nucleistudio/advanceusage/image35.png

.. |image34| image:: /asserts/nucleistudio/advanceusage/image36.png

.. |image35| image:: /asserts/nucleistudio/advanceusage/image37.png

.. |image36| image:: /asserts/nucleistudio/advanceusage/image38.png

.. |image37| image:: /asserts/nucleistudio/advanceusage/image39.png

.. |image38| image:: /asserts/nucleistudio/advanceusage/image25.png

.. |image39| image:: /asserts/nucleistudio/advanceusage/image40.png

.. |image40| image:: /asserts/nucleistudio/advanceusage/image41.png

.. |image41| image:: /asserts/nucleistudio/advanceusage/image42.png

.. |image42| image:: /asserts/nucleistudio/advanceusage/image43.png

.. |image43| image:: /asserts/nucleistudio/advanceusage/image44.png

.. |image44| image:: /asserts/nucleistudio/advanceusage/image45.png

.. |image45| image:: /asserts/nucleistudio/advanceusage/image46.png

.. |image46| image:: /asserts/nucleistudio/advanceusage/image47.png

.. |image47| image:: /asserts/nucleistudio/advanceusage/image48.png

.. |image48| image:: /asserts/nucleistudio/advanceusage/image49.png

.. |image49| image:: /asserts/nucleistudio/advanceusage/image50.png

.. |image50| image:: /asserts/nucleistudio/advanceusage/image51.png

.. |image51| image:: /asserts/nucleistudio/advanceusage/image52.png

.. |image52| image:: /asserts/nucleistudio/advanceusage/image53.png

.. |image53| image:: /asserts/nucleistudio/advanceusage/image54.png

.. |image54| image:: /asserts/nucleistudio/advanceusage/image55.png

.. |image55| image:: /asserts/nucleistudio/advanceusage/image56.png

.. |image56| image:: /asserts/nucleistudio/advanceusage/image57.png

.. |image57| image:: /asserts/nucleistudio/advanceusage/image58.png

.. |image58| image:: /asserts/nucleistudio/advanceusage/image59.png

.. |image59| image:: /asserts/nucleistudio/advanceusage/image60.png

.. |image60| image:: /asserts/nucleistudio/advanceusage/image61.png

.. |image61| image:: /asserts/nucleistudio/advanceusage/image47.png

.. |image62| image:: /asserts/nucleistudio/advanceusage/image62.png

.. |image63| image:: /asserts/nucleistudio/advanceusage/image63.png

.. |image64| image:: /asserts/nucleistudio/advanceusage/image64.png

.. |image65| image:: /asserts/nucleistudio/advanceusage/image65.png

.. |image66| image:: /asserts/nucleistudio/advanceusage/image66.png

.. |image67| image:: /asserts/nucleistudio/advanceusage/image67.png

.. |image68| image:: /asserts/nucleistudio/advanceusage/image68.png

.. |image69| image:: /asserts/nucleistudio/advanceusage/image69.png

.. |image70| image:: /asserts/nucleistudio/advanceusage/image70.png

.. |image71| image:: /asserts/nucleistudio/advanceusage/image71.png

.. |image72| image:: /asserts/nucleistudio/advanceusage/image72.png

.. |image73| image:: /asserts/nucleistudio/advanceusage/image73.png

.. |image74| image:: /asserts/nucleistudio/advanceusage/image74.png

.. |image75| image:: /asserts/nucleistudio/advanceusage/image75.png

.. |image76| image:: /asserts/nucleistudio/advanceusage/image76.png

.. |image77| image:: /asserts/nucleistudio/advanceusage/image77.png

.. |image78| image:: /asserts/nucleistudio/advanceusage/image78.png

.. |image79| image:: /asserts/nucleistudio/advanceusage/image79.png

.. |image80| image:: /asserts/nucleistudio/advanceusage/image80.png

.. |image81| image:: /asserts/nucleistudio/advanceusage/image81.png

.. |image82| image:: /asserts/nucleistudio/advanceusage/image82.png

.. |image83| image:: /asserts/nucleistudio/advanceusage/image83.png

.. |image84| image:: /asserts/nucleistudio/advanceusage/image84.png

.. |image85| image:: /asserts/nucleistudio/advanceusage/image85.png

.. |image86| image:: /asserts/nucleistudio/advanceusage/image86.png

.. |image87| image:: /asserts/nucleistudio/advanceusage/image87.png

.. |image88| image:: /asserts/nucleistudio/advanceusage/image88.png

.. |image89| image:: /asserts/nucleistudio/advanceusage/image89.png


.. |image90| image:: /asserts/nucleistudio/advanceusage/image90.png

.. |image91| image:: /asserts/nucleistudio/advanceusage/image91.png

.. |image92| image:: /asserts/nucleistudio/advanceusage/image92.png

.. |image93| image:: /asserts/nucleistudio/advanceusage/image93.png

.. |image94| image:: /asserts/nucleistudio/advanceusage/image94.png

.. |image95| image:: /asserts/nucleistudio/advanceusage/image95.png

.. |image96| image:: /asserts/nucleistudio/advanceusage/image96.png

.. |image97| image:: /asserts/nucleistudio/advanceusage/image97.png

.. |image98| image:: /asserts/nucleistudio/advanceusage/image98.png

.. |image99| image:: /asserts/nucleistudio/advanceusage/image99.png

.. |image100| image:: /asserts/nucleistudio/advanceusage/image100.png

.. |image101| image:: /asserts/nucleistudio/advanceusage/image101.png

.. |image102| image:: /asserts/nucleistudio/advanceusage/image102.png

.. |image-nice-1| image:: /asserts/nucleistudio/advanceusage/nice-1.png

.. |image-nice-2| image:: /asserts/nucleistudio/advanceusage/nice-2.png

.. |image-nice-3| image:: /asserts/nucleistudio/advanceusage/nice-3.png

.. |image-nice-4| image:: /asserts/nucleistudio/advanceusage/nice-4.png

.. |image-nice-5| image:: /asserts/nucleistudio/advanceusage/nice-5.png

.. |image-nice-6| image:: /asserts/nucleistudio/advanceusage/nice-6.png

.. |image-nice-7| image:: /asserts/nucleistudio/advanceusage/nice-7.png

.. |image-nice-8| image:: /asserts/nucleistudio/advanceusage/nice-8.png

.. |image-nice-9| image:: /asserts/nucleistudio/advanceusage/nice-9.png

.. |image-nice-10| image:: /asserts/nucleistudio/advanceusage/nice-10.png



