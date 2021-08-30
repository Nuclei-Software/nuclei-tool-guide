插入图片
--------

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


Test Wavedrom
---------------

.. wavedrom::

        { "signal": [
                { "name": "clk",  "wave": "P......" },
                { "name": "bus",  "wave": "x.==.=x", "data": ["head", "body", "tail", "data"] },
                { "name": "wire", "wave": "0.1..0." }
        ]}



Test Drawio
---------------

.. drawio-image:: /asserts/drawio/box.drawio
    :export-width: 100
    :align: center

.. drawio-figure:: /asserts/drawio/box.drawio



.. drawio-image:: /asserts/drawio/box.drawio
   :align: center


.. drawio-figure:: /asserts/drawio/flow.drawio
   :align: center


.. drawio-image:: /asserts/drawio/flow.drawio
    :height: 100
    :align: center

.. drawio-figure:: /asserts/drawio/flow.drawio
   :align: center
   :alt: CPU Release Flow

   CPU Release Flow