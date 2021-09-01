Test Chinese Support
====================

图片请放在 ``source/asserts/images`` 目录下，插入图片的方法如下：

.. code-block:: rst

   .. _fig_clkdiag1:

   .. figure:: /asserts/images/soc_clock_diagram.png
      :width: 80 %
      :align: center
      :alt: SoC时钟结构图

      SoC时钟结构图

注意一定要带上 ``_fig_clkdiag1`` , 这里的 ``clkdiag1`` 换成唯一的id， 后面的figure放置图片路径。
``:alt:`` 放置图片的标题，下面空一行，写图片的标题。引用这张图片的方法是 ``:ref:`fig_clkdiag1``` 。

这里引用 图片 :numref:`fig_clkdiag1`


效果如下：


.. _fig_clkdiag1:

.. figure:: /asserts/images/soc_clock_diagram.png
   :width: 80 %
   :align: center
   :alt: SoC时钟结构图

   SoC时钟结构图


SRV300SoC特性概述如下
---------------------

-  使用Nuclei内核，基于RISC-V架构的32位精简指令集。可配置为双核锁步。
-  配备片上SRAM作为LM：

   -  32KB紧耦合指令存储器
   -  32KB紧耦合数据存储器

-  配备自定义的SoC总线。
-  配备多种外设IP

   -  3路RS422异步串行收发接口（默认波特率38400bps）
   -  1路定时器，可配置为中断。
   -  通用GPIO: 支持16路通用输入输出。
   -  专用IO口3路:

      -  1个System复位接口;
      -  1个POR复位接口;
      -  1个系统启动配置管脚;

   -  QSPI Flash/PSRAM

      -  支持通过XIP方式进行SPI FLASH启动

   -  可通过1个专用GPIO配置管脚选择从外部FLASH(默认), 或者偏移地址启动

芯片电气特性如下
~~~~~~~~~~~~~~~~

-  工作电压：3.3V（±0.3V）
-  核电压：1.2V（±0.1V）
-  主频：≥200 MHz
-  抗静电指标：≥2000V
-  工作温度：-55℃~+125℃

芯片物理特性如下
~~~~~~~~~~~~~~~~

-  封装形式/外形尺寸：
-  LQFP64

SRV300 SoC的框图如下
--------------------

.. _fig_socdiag:

.. figure:: /asserts/images/soc_diag.png
   :width: 80 %
   :align: center
   :alt: SRV300SoC框图

   SRV300SoC框图

框图对SoC的架构进行了初步描述，该系统包含一个SRV300的内核，8K的Icache，8K的Dcache，
通过MBF连接I-RAM、D-RAM、SystemRAM、ROM、以及Peripheral Bus。
其中Peripheral Bus用于连接各个外设IP。

SRV300 SoC的时钟结构如图
------------------------

.. _fig_clkdiag:

.. figure:: /asserts/images/soc_clock_diagram.png
   :width: 80 %
   :align: center
   :alt: SoC时钟结构图

   SoC时钟结构图

注意：rtc_clk为系统时钟sys_clk的8分频

SRV300 系统总线
---------------

SRV300SoC定义了一种自定义总线协议ICB（Internal Chip Bus）。
ICB总线的初衷是为了能够尽可能地结合AXI总线和AHB总线的优点，兼具高速性和易用性，它具有如下特性：

- 相比AXI和AHB而言，ICB的协议控制更加简单，仅有两个独立的通道，如 :ref:`fig_socbus` 所示，读和写操作共用地址通道，共用结果返回通道。 
- 与AXI总线一样采用分离的地址和数据阶段。
- 与AXI总线一样采用地址区间寻址，支持任意的主从数目，譬如一主一从，一主多从，多主一从，多主多从等拓扑结构。
- 与AHB总线一样每个读或者写操作都会在地址通道上产生地址，而非像AXI中只产生起始地址。
- 与AXI总线一样支持地址非对齐的数据访问，使用字节掩码（Write Mask）来控制部分写操作。 
- 与AXI总线一样支持多个滞外交易（Multiple Oustanding Transaction）。 
- 与AHB总线一样不支持乱序返回乱序完成。反馈通道必须按顺序返回结果。 
- 与AXI总线一样非常容易添加流水线级数以获得高频的时序。 
- 协议非常简单，易于桥接转换成其他总线类型，譬如AXI，AHB，APB或者TileLink等总线。

.. _fig_socbus:

.. figure:: /asserts/images/soc_bus.png
   :width: 60 %
   :align: center
   :alt: SRV300SoC总线

   SRV300SoC总线


Test tables
------------

.. _table_core_csr_1:
.. table:: CSR supported in the Nuclei processor core
   :widths: 40,30,30,50,200

   +------------+---------+-------+---------------+-------------------------------------------------------------------------------------------------------+
   | Type       | Address | R & W | Name          | Description                                                                                           |
   +------------+---------+-------+---------------+-------------------------------------------------------------------------------------------------------+
   | | RISC-V   || These CSRs are following RISC-V standard privileged architecture specification.                                                        |
   | | Standard || This document will not repeat its content here,                                                                                        |
   | | CSRs     || please refer to RISC-V standard privileged architecture specification for more details.                                                |
   +------------+---------+-------+---------------+-------------------------------------------------------------------------------------------------------+
   || Nuclei    | 0x307   | MRW   | mtvt          | ECLIC Interrupt Vector Table Base Address                                                             |
   || Customized+---------+-------+---------------+-------------------------------------------------------------------------------------------------------+
   || CSRs      | Ox345   | MRW   | mnxti         | Used to enable taking the next interrupt and return the entry address of the next interrupt handler.  |
   |            +---------+-------+---------------+-------------------------------------------------------------------------------------------------------+
   |            | 0x346   | MRO   | mintstatus    | Current Interrupt Levels                                                                              |
   |            +---------+-------+---------------+-------------------------------------------------------------------------------------------------------+
   |            | 0x348   | MRW   | mscratchcsw   | Scratch swap register for privileged mode.                                                            |
   |            +---------+-------+---------------+-------------------------------------------------------------------------------------------------------+
   |            | 0x349   | MRW   | mscratchcswl  | Scratch swap register for interrupt levels.                                                           |
   |            +---------+-------+---------------+-------------------------------------------------------------------------------------------------------+
   |            | 0x320   | MRW   | mcountinhibit | Customized register used to control the on & off of counters                                          |
   |            +---------+-------+---------------+-------------------------------------------------------------------------------------------------------+
   |            | 0x7c0   | MRW   | milm_ctl      | Enable/Disable the ILM address space.                                                                 |
   |            +---------+-------+---------------+-------------------------------------------------------------------------------------------------------+
   |            | 0x7c1   | MRW   | mdlm_ctl      | Enable/Disable the DLM address space.                                                                 |
   |            +---------+-------+---------------+-------------------------------------------------------------------------------------------------------+
   |            | 0x7c2   | MRW   | mecc_code     | ECC code injection register, can be used to simulate ECC error                                        |
   |            +---------+-------+---------------+-------------------------------------------------------------------------------------------------------+
   |            | 0x7c3   | MRO   | mnvec         | Customized register used to indicate the NMI handler entry address                                    |
   |            +---------+-------+---------------+-------------------------------------------------------------------------------------------------------+
   |            | 0x7c4   | MRW   | msubm         | Customized register storing current trap type and the previous trap type before trapped.              |
   |            +---------+-------+---------------+-------------------------------------------------------------------------------------------------------+
   |            | 0x7c9   | MRW   | mdcause       | Customized register storing current trap's detailed cause.                                            |
   |            +---------+-------+---------------+-------------------------------------------------------------------------------------------------------+
   |            | 0x7ca   | MRW   | mcache_ctl    | Customized register to control the cache features.                                                    |
   |            +---------+-------+---------------+-------------------------------------------------------------------------------------------------------+
   |            | 0x7d0   | MRW   | mmisc_ctl     | Customized register controlling the selection of the NMI Handler Entry Address.                       |
   |            +---------+-------+---------------+-------------------------------------------------------------------------------------------------------+
   |            | 0x7d6   | MRW   | msavestatus   | Customized register storing the value of mstatus.                                                     |
   |            +---------+-------+---------------+-------------------------------------------------------------------------------------------------------+
   |            | 0x7d7   | MRW   | msaveepc1     | Customized register storing the value of mepc for the first-level preempted NMI or Exception.         |
   |            +---------+-------+---------------+-------------------------------------------------------------------------------------------------------+
   |            | 0x7d8   | MRW   | msavecause1   | Customized register storing the value of mcause for the first-level preempted NMI or Exception.       |
   |            +---------+-------+---------------+-------------------------------------------------------------------------------------------------------+
   |            | 0x7d9   | MRW   | msaveepc2     | Customized register storing the value of mepc for the second-level preempted NMI or Exception.        |
   |            +---------+-------+---------------+-------------------------------------------------------------------------------------------------------+
   |            | 0x7da   | MRW   | msavecause2   | Customized register storing the value of mcause for the second-level preempted NMI or Exception.      |
   |            +---------+-------+---------------+-------------------------------------------------------------------------------------------------------+
   |            | 0x7dd   | MRW   | mtlb_ctl      | TLB control register                                                                                  |
   |            +---------+-------+---------------+-------------------------------------------------------------------------------------------------------+
   |            | 0x7de   | MRW   | mecc_lock     | To lock ECC configure registers, then all the ECC related CSRs cannot be modified, unless by reset    |
   |            +---------+-------+---------------+-------------------------------------------------------------------------------------------------------+
   |            | 0x7eb   | MRW   | pushmsubm     | Customized register used to push the value of msubm into the stack memory.                            |
   |            +---------+-------+---------------+-------------------------------------------------------------------------------------------------------+
   |            | 0x7ec   | MRW   | mtvt2         | Customized register used to indicate the common handler entry address of non-vectored interrupts.     |
   |            +---------+-------+---------------+-------------------------------------------------------------------------------------------------------+
   |            | 0x7ed   | MRW   | jalmnxti      | | Customized register used to enable the ECLIC interrupt.                                             |
   |            |         |       |               | | The read operation of this register will take the next interrupt, return the entry address of next  |
   |            |         |       |               | | interrupt handler, and jump to the corresponding handler at the same time.                          |
   |            +---------+-------+---------------+-------------------------------------------------------------------------------------------------------+
   |            | 0x7ee   | MRW   | pushmcause    | Customized register used to push the value of mcause into the stack memory.                           |
   |            +---------+-------+---------------+-------------------------------------------------------------------------------------------------------+
   |            | 0x7ef   | MRW   | pushmepc      | Customized register used to push the value of mepc into the stack memory.                             |
   |            +---------+-------+---------------+-------------------------------------------------------------------------------------------------------+
   |            | 0x7f0   | MRO   | mppicfg_info  | PPI configuration information.                                                                        |
   |            +---------+-------+---------------+-------------------------------------------------------------------------------------------------------+
   |            | 0x7f1   | MRO   | mfiocfg_info  | FIO configuration information.                                                                        |
   |            +---------+-------+---------------+-------------------------------------------------------------------------------------------------------+
   |            | 0x811   | MRW   | sleepvalue    | Customized register used to indicate the WFI sleep mode.                                              |
   |            +---------+-------+---------------+-------------------------------------------------------------------------------------------------------+
   |            | 0x812   | MRW   | txevt         | Customized register used to send an event.                                                            |
   |            +---------+-------+---------------+-------------------------------------------------------------------------------------------------------+
   |            | 0x810   | MRW   | wfe           | Customized register used to control the WFE mode.                                                     |
   |            +---------+-------+---------------+-------------------------------------------------------------------------------------------------------+
   |            | 0xfc0   | MRO   | micfg_info    | ILM and I-Cache configuration information.                                                            |
   |            +---------+-------+---------------+-------------------------------------------------------------------------------------------------------+
   |            | 0xfc1   | MRO   | mdcfg_info    | DLM and D-Cache configuration information.                                                            |
   |            +---------+-------+---------------+-------------------------------------------------------------------------------------------------------+
   |            | 0xfc2   | MRO   | mcfg_info     | Processor configuration information.                                                                  |
   |            +---------+-------+---------------+-------------------------------------------------------------------------------------------------------+
   |            | 0xfc3   | MRO   | mtlbcfg_info  | TLB configuration info.                                                                               |
   +------------+---------+-------+---------------+-------------------------------------------------------------------------------------------------------+

.. table:: mcause register
   :widths: 50,30,110,150

   ============= ======= =================================== ====================================================
   **Field**     **Bit** **Description**                     **Note**
   **INTERRUPT** 31      Current trap type:

                         - 0: Exception or NMI
                         - 1: Interrupt
   **MINHV**     30      | Indicate processer is reading     | Note: These fields are only effect in CLIC mode.
                         | interrupt vector table            | When in CLINT mode, these field is masked read
                                                             | as zero, write ignored.
   **MPP**       29:28   privilege mode before interrupt
   **MPIE**      27      Interrupt enable before interrupt
   **Reserved**  26:24   Reserved 0
   **MPIL**      23:16   Previous interrupt level
   **Reserved**  15:12   Reserved 0
   **EXCCODE**   11:0    Exception/Interrupt Encoding
   ============= ======= =================================== ====================================================


.. table:: msubm register
   :widths: 50,30,160

   ============ ======= ==========================================
   **Field**    **Bit** **Description**
   **Reserved** 31:10   Reserved 0
   **PTYP**     9:8     Machine sub-mode before entering the trap:

                        -  0: Normal machine mode
                        -  1: Interrupt handling mode
                        -  2: Exception handling mode
                        -  3: NMI handling mode
   **TYP**      7:6     Current machine sub-mode:

                        -  0: Normal machine mode
                        -  1: Interrupt handling mode
                        -  2: Exception handling mode
                        -  3: NMI handling mode
   **Reserved** 5:0     Reserved 0
   ============ ======= ==========================================


.. list-table:: Make targets supported by Nuclei SDK Build System
   :widths: 20 80
   :header-rows: 1
   :align: center

   * - target
     - description
   * - help
     - display help message of Nuclei SDK build system
   * - info
     - display selected configuration information
   * - all
     - build application with selected configuration
   * - clean
     - clean application with selected configuration
   * - dasm
     - build and dissemble application with selected configuration
   * - bin
     - build and generate application binary with selected configuration
   * - upload
     - build and upload application with selected configuration
   * - run_openocd
     - run openocd server with selected configuration
   * - run_gdb
     - build and start gdb process with selected configuration
   * - debug
     - build and debug application with selected configuration
   * - size
     - show program size

.. csv-table:: Balance Sheet
   :header: Description,In,Out,Balance
   :widths: 20, 10, 10, 10
   :stub-columns: 1

   Travel,,230.00,-230.00
   Fees,,400.00,-630.00
   Grant,700.00,,70.00
   Train Fare,,70.00,**0.00**