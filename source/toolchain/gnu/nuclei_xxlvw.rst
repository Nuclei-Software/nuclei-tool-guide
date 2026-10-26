.. _toolchain_gnu_nuclei_xxlvw:

Nuclei Custom Xxlvw Extension
================================

Introduction
*************

目前 RVV 1.0 向量扩展主要应用于 AI 与图像处理领域，其基础向量指令难以完全满足宽带无线信号处理的需求，例如 4G/5G 通信中的复数处理，以及高精度定点动态缩放（dynamic scaling）等场景。为此，需要在 RVV 基础上扩展面向无线通信领域的向量指令，以覆盖 4G、5G、Wi-Fi 等场景中大量的向量信号处理需求。

该指令集是 RISC-V RVV 1.0 的补充扩展，主要面向宽带无线通信信号处理。扩展以 ``w`` （Wireless）标识，基于基础的 ``V`` 扩展，在 Nuclei 工具链中以自定义扩展 ``xxlvw`` 的形式提供。

为无线信号处理新增的指令主要包括：

- 复数格式转换指令
- 定点动态缩放运算指令
- 复数动态缩放运算指令
- 动态缩放归约运算指令
- 元素间运算指令
- 快速非线性运算指令
- 格式转换指令

指令中的“运算”指对向量各元素的操作；循环次数遵循 RVV 规范中的 LMUL 与 VL；操作数宽度由 SEW 控制；各元素是否参与运算由 vm 控制；未参与运算元素的默认值由 mask agnostic 与 tail agnostic 机制决定。

本文主要介绍 Nuclei 工具链对该扩展的支持情况，包括使能方式、支持的指令以及对应的 intrinsic 用法。扩展的详细定义可参考 `riscv-vector4wireless-extension <https://github.com/gaoshanlee193/riscv-vector4wireless-extension#introduction>`_。



扩展
*****

使用该扩展时，需要启用 ``V`` 扩展和 ``xxlvw`` 扩展，同时该扩展只支持 RV32。

示例：``-march=rv32imafcv_xxlvw -mabi=ilp32f``

.. attention::

    使用该扩展的相关 intrinsic 时，需要添加以下头文件：

    ``#include <riscv_vector.h>``

支持的指令
**********

Complex number format conversion
 - ``vcpack.vv vd, vs2, vs1, vm``
 - ``vcunpackr.v vd, vs2, vm``
 - ``vcunpacki.v vd, vs2, vm``
Fixed-point dynamic scaling operations
 - ``vdsmul.vv/vs vd, vs2, vs1, vm``
 - ``vdsmacini.v vs2, vm``
 - ``vdsmacini.s rs1, vm``
 - ``vdsmacini.i uimm, vm``
 - ``vdsmac.vv/vs vs2, vs1, vm``
 - ``vdsmaco.vv/vs vd, vs2, vs1, vm``
 - ``vlsb.v vd, vs2, vm``
Complex dynamic scaling operations
 - ``vconj.v vd, vs2, vm``
 - ``vdscmul.vv/vs vd, vs2, vs1, vm``
 - ``vdscmulj.vv/vs vd, vs2, vs1, vm``
 - ``vdscredsum.v vd, vs2, vm``
 - ``vdscmac.vv/vs vs2, vs1, vm``
 - ``vdscmacj.vv/vs vs2, vs1, vm``
 - ``vdscmaco.vv/vs vd, vs2, vs1, vm``
 - ``vdscmacjo.vv/vs vd, vs2, vs1, vm``
 - ``vdscmacor.vv/vs vd, vs2, vs1, vm``
 - ``vdscmacoi.vv/vs vd, vs2, vs1, vm``
 - ``vdscmacjor.vv/vs vd, vs2, vs1, vm``
 - ``vdscmacjoi.vv/vs vd, vs2, vs1, vm``
 - ``vdscmulr.vv/vs vd, vs2, vs1, vm``
 - ``vdscmuli.vv/vs vd, vs2, vs1, vm``
 - ``vdscmuljr.vv/vs vd, vs2, vs1, vm``
 - ``vdscmulji.vv/vs vd, vs2, vs1, vm``
Dynamic scaling reduced operations
 - ``vdsredsum.v vd, vs2, vm``
 - ``vdsredsumn.vs vd, vs2, rs1``
 - ``vdsredsumn.vi vd, vs2, uimm``
 - ``vredmaxi.vv vd, vs2, vs1, vm``
 - ``vredmini.vv vd, vs2, vs1, vm``
Inter-element operation instructions
 - ``vperm.vi vd, vs2, uimm``
 - ``vfsl.vv vd, vs2, vs1``
 - ``vfsr.vv vd, vs2, vs1``
Fast non-linear operations
 - ``vlnlp0.v vnlpr0, vs2``
 - ``vlnlp1.v vnlpr1, vs2``
 - ``vnle.vv vd, vs2, vs1, vm``
 - ``vnle.vs vd, vs2, vs1, vm``
 - ``vnlm.vv vd, vs2, vs1, vm``
 - ``vnlm.vs vd, vs2, vs1, vm``
Format conversion instructions
 - ``vfcvt.b2h.v vd, vs2``
 - ``vfcvt.b2w.v vd, vs2``
 - ``vfcvt.h2w.v vd, vs2``
 - ``vfcvt.p2c.v vd, vs2``
 - ``vfcvt.h2b.v vd, vs2``
 - ``vfcvt.w2b.v vd, vs2``
 - ``vfcvt.w2h.v vd, vs2``
 - ``vfcvt.c2p.v vd, vs2``

.. note::

    格式转换指令用于不同数据宽度之间的转换，下文以 ``sew = 输入宽度→输出宽度`` 标注；各 intrinsic 的实际数据类型也可从其函数签名中看出。

    这些指令的详细信息，参考 https://github.com/gaoshanlee193/riscv-vector4wireless-extension/blob/Zvw/src/RISCV-Vector-Extension-for-Wireless.adoc

intrinsic 命名规则
*******************

rvv intrinsic 命名规则：https://github.com/riscv-non-isa/rvv-intrinsic-doc/releases/tag/v1.0.0-rc7 中的 ``v-intrinsic-spec.pdf`` -> **Chapter 6**。

我们的命名规则遵循上述规则，并在其基础上于前缀处添加了 ``_xl``。

Nuclei 自定义的 intrinsic
**************************

.. note::

    下文会给出每条指令对应的 intrinsic 示例；完整的 intrinsic 请参照上述命名规则推导。

    下文出现的 sew 指的是指令支持的数据类型的宽度，full_preds 指的是 intrinsic 函数支持的后缀形式。full 表示支持全部后缀形式，包括 none（无后缀）、_m、_tu、_tum、_tumu、_mu 共六种；none_m_preds[none,_m] 表示仅支持 none 和 _m 两种形式；none_tu_preds 表示仅支持 none 和 _tu 两种形式；none_preds 表示仅支持 none（无后缀）形式。

* ``vcpack.vv``   sew = 32 full_preds

.. code-block:: c

    vint32m1_t __riscv_xl_vcpack_vv_i32m1(vint32m1_t vs2, vint32m1_t vs1, size_t vl);
    vint32m1_t __riscv_xl_vcpack_vv_i32m1_m(vbool32_t vm, vint32m1_t vs2, vint32m1_t vs1, size_t vl);
    vint32m1_t __riscv_xl_vcpack_vv_i32m1_tu(vint32m1_t vd, vint32m1_t vs2, vint32m1_t vs1, size_t vl);
    vint32m1_t __riscv_xl_vcpack_vv_i32m1_tum(vbool32_t vm,vint32m1_t vd, vint32m1_t vs2, vint32m1_t vs1, size_t vl);
    vint32m1_t __riscv_xl_vcpack_vv_i32m1_tumu(vbool32_t vm,vint32m1_t vd, vint32m1_t vs2, vint32m1_t vs1, size_t vl);
    vint32m1_t __riscv_xl_vcpack_vv_i32m1_mu(vbool32_t vm,vint32m1_t vd, vint32m1_t vs2, vint32m1_t vs1, size_t vl);

.. note::

    后续指令对应的 intrinsic，只会给出 none（无后缀）的全部 intrinsic，其余后缀在使用时参考上面的构建规则。

* ``vcunpackr.v`` sew = 32  full_preds

.. code-block:: c

    vint32mf2_t __riscv_xl_vcunpackr_v_i32mf2(vint32mf2_t vs2, size_t vl);
    vint32m1_t __riscv_xl_vcunpackr_v_i32m1(vint32m1_t vs2, size_t vl);
    vint32m2_t __riscv_xl_vcunpackr_v_i32m2(vint32m2_t vs2, size_t vl);
    vint32m4_t __riscv_xl_vcunpackr_v_i32m4(vint32m4_t vs2, size_t vl);
    vint32m8_t __riscv_xl_vcunpackr_v_i32m8(vint32m8_t vs2, size_t vl);

* ``vcunpacki.v`` sew = 32 full_preds

.. code-block:: c

    vint32mf2_t __riscv_xl_vcunpacki_v_i32mf2(vint32mf2_t vs2, size_t vl);
    vint32m1_t  __riscv_xl_vcunpacki_v_i32m1(vint32m1_t vs2, size_t vl);
    vint32m2_t  __riscv_xl_vcunpacki_v_i32m2(vint32m2_t vs2, size_t vl);
    vint32m4_t  __riscv_xl_vcunpacki_v_i32m4(vint32m4_t vs2, size_t vl);
    vint32m8_t  __riscv_xl_vcunpacki_v_i32m8(vint32m8_t vs2, size_t vl);

* ``vdsmul.vv`` sew = 8/16/32  full_preds

.. code-block:: c

    vint8mf8_t __riscv_xl_vdsmul_vv_i8mf8(vint8mf8_t vs2, vint8mf8_t vs1, size_t vl);
    vint8mf4_t __riscv_xl_vdsmul_vv_i8mf4(vint8mf4_t vs2, vint8mf4_t vs1, size_t vl);
    vint8mf2_t __riscv_xl_vdsmul_vv_i8mf2(vint8mf2_t vs2, vint8mf2_t vs1, size_t vl);
    vint8m1_t __riscv_xl_vdsmul_vv_i8m1(vint8m1_t vs2, vint8m1_t vs1, size_t vl);
    vint8m2_t __riscv_xl_vdsmul_vv_i8m2(vint8m2_t vs2, vint8m2_t vs1, size_t vl);
    vint8m4_t __riscv_xl_vdsmul_vv_i8m4(vint8m4_t vs2, vint8m4_t vs1, size_t vl);
    vint8m8_t __riscv_xl_vdsmul_vv_i8m8(vint8m8_t vs2, vint8m8_t vs1, size_t vl);
    vint16mf4_t __riscv_xl_vdsmul_vv_i16mf4(vint16mf4_t vs2, vint16mf4_t vs1, size_t vl);
    vint16mf2_t __riscv_xl_vdsmul_vv_i16mf2(vint16mf2_t vs2, vint16mf2_t vs1, size_t vl);
    vint16m1_t __riscv_xl_vdsmul_vv_i16m1(vint16m1_t vs2, vint16m1_t vs1, size_t vl);
    vint16m2_t __riscv_xl_vdsmul_vv_i16m2(vint16m2_t vs2, vint16m2_t vs1, size_t vl);
    vint16m4_t __riscv_xl_vdsmul_vv_i16m4(vint16m4_t vs2, vint16m4_t vs1, size_t vl);
    vint16m8_t __riscv_xl_vdsmul_vv_i16m8(vint16m8_t vs2, vint16m8_t vs1, size_t vl);
    vint32mf2_t __riscv_xl_vdsmul_vv_i32mf2(vint32mf2_t vs2, vint32mf2_t vs1, size_t vl);
    vint32m1_t __riscv_xl_vdsmul_vv_i32m1(vint32m1_t vs2, vint32m1_t vs1, size_t vl);
    vint32m2_t __riscv_xl_vdsmul_vv_i32m2(vint32m2_t vs2, vint32m2_t vs1, size_t vl);
    vint32m4_t __riscv_xl_vdsmul_vv_i32m4(vint32m4_t vs2, vint32m4_t vs1, size_t vl);
    vint32m8_t __riscv_xl_vdsmul_vv_i32m8(vint32m8_t vs2, vint32m8_t vs1, size_t vl);

* ``vdsmul.vs`` sew = 8/16/32  full_preds

.. code-block:: c

    vint8mf8_t __riscv_xl_vdsmul_vs_i8mf8_i8mf8(vint8mf8_t vs2, vint8mf8_t vs1, size_t vl);
    vint8mf4_t __riscv_xl_vdsmul_vs_i8mf4_i8mf4(vint8mf4_t vs2, vint8mf4_t vs1, size_t vl);
    vint8mf2_t __riscv_xl_vdsmul_vs_i8mf2_i8mf2(vint8mf2_t vs2, vint8mf2_t vs1, size_t vl);
    vint8m1_t __riscv_xl_vdsmul_vs_i8m1_i8m1(vint8m1_t vs2, vint8m1_t vs1, size_t vl);
    vint8m2_t __riscv_xl_vdsmul_vs_i8m2_i8m2(vint8m2_t vs2, vint8m2_t vs1, size_t vl);
    vint8m4_t __riscv_xl_vdsmul_vs_i8m4_i8m4(vint8m4_t vs2, vint8m4_t vs1, size_t vl);
    vint8m8_t __riscv_xl_vdsmul_vs_i8m8_i8m8(vint8m8_t vs2, vint8m8_t vs1, size_t vl);
    vint16mf4_t __riscv_xl_vdsmul_vs_i16mf4_i16mf4(vint16mf4_t vs2, vint16mf4_t vs1, size_t vl);
    vint16mf2_t __riscv_xl_vdsmul_vs_i16mf2_i16mf2(vint16mf2_t vs2, vint16mf2_t vs1, size_t vl);
    vint16m1_t __riscv_xl_vdsmul_vs_i16m1_i16m1(vint16m1_t vs2, vint16m1_t vs1, size_t vl);
    vint16m2_t __riscv_xl_vdsmul_vs_i16m2_i16m2(vint16m2_t vs2, vint16m2_t vs1, size_t vl);
    vint16m4_t __riscv_xl_vdsmul_vs_i16m4_i16m4(vint16m4_t vs2, vint16m4_t vs1, size_t vl);
    vint16m8_t __riscv_xl_vdsmul_vs_i16m8_i16m8(vint16m8_t vs2, vint16m8_t vs1, size_t vl);
    vint32mf2_t __riscv_xl_vdsmul_vs_i32mf2_i32mf2(vint32mf2_t vs2, vint32mf2_t vs1, size_t vl);
    vint32m1_t __riscv_xl_vdsmul_vs_i32m1_i32m1(vint32m1_t vs2, vint32m1_t vs1, size_t vl);
    vint32m2_t __riscv_xl_vdsmul_vs_i32m2_i32m2(vint32m2_t vs2, vint32m2_t vs1, size_t vl);
    vint32m4_t __riscv_xl_vdsmul_vs_i32m4_i32m4(vint32m4_t vs2, vint32m4_t vs1, size_t vl);
    vint32m8_t __riscv_xl_vdsmul_vs_i32m8_i32m8(vint32m8_t vs2, vint32m8_t vs1, size_t vl);

* ``vdsmacini.v`` sew = 8/16/32  none_m_preds[none,_m]

.. code-block:: c

    vint8mf8_t __riscv_xl_vdsmacini_v_i8mf8(vint8mf8_t vs2, size_t vl);
    vint8mf4_t __riscv_xl_vdsmacini_v_i8mf4(vint8mf4_t vs2, size_t vl);
    vint8mf2_t __riscv_xl_vdsmacini_v_i8mf2(vint8mf2_t vs2, size_t vl);
    vint8m1_t __riscv_xl_vdsmacini_v_i8m1(vint8m1_t vs2, size_t vl);
    vint8m2_t __riscv_xl_vdsmacini_v_i8m2(vint8m2_t vs2, size_t vl);
    vint8m4_t __riscv_xl_vdsmacini_v_i8m4(vint8m4_t vs2, size_t vl);
    vint8m8_t __riscv_xl_vdsmacini_v_i8m8(vint8m8_t vs2, size_t vl);
    vint16mf4_t __riscv_xl_vdsmacini_v_i16mf4(vint16mf4_t vs2, size_t vl);
    vint16mf2_t __riscv_xl_vdsmacini_v_i16mf2(vint16mf2_t vs2, size_t vl);
    vint16m1_t __riscv_xl_vdsmacini_v_i16m1(vint16m1_t vs2, size_t vl);
    vint16m2_t __riscv_xl_vdsmacini_v_i16m2(vint16m2_t vs2, size_t vl);
    vint16m4_t __riscv_xl_vdsmacini_v_i16m4(vint16m4_t vs2, size_t vl);
    vint16m8_t __riscv_xl_vdsmacini_v_i16m8(vint16m8_t vs2, size_t vl);
    vint32mf2_t __riscv_xl_vdsmacini_v_i32mf2(vint32mf2_t vs2, size_t vl);
    vint32m1_t  __riscv_xl_vdsmacini_v_i32m1(vint32m1_t vs2, size_t vl);
    vint32m2_t  __riscv_xl_vdsmacini_v_i32m2(vint32m2_t vs2, size_t vl);
    vint32m4_t  __riscv_xl_vdsmacini_v_i32m4(vint32m4_t vs2, size_t vl);
    vint32m8_t  __riscv_xl_vdsmacini_v_i32m8(vint32m8_t vs2, size_t vl);

* ``vdsmacini.s``  sew = 8/16/32  none_m_preds[none,_m]

.. code-block:: c

    vint8mf8_t __riscv_xl_vdsmacini_x_i8mf8(int8_t rs1, size_t vl);
    vint8mf4_t __riscv_xl_vdsmacini_x_i8mf4(int8_t rs1, size_t vl);
    vint8mf2_t __riscv_xl_vdsmacini_x_i8mf2(int8_t rs1, size_t vl);
    vint8m1_t __riscv_xl_vdsmacini_x_i8m1(int8_t rs1, size_t vl);
    vint8m2_t __riscv_xl_vdsmacini_x_i8m2(int8_t rs1, size_t vl);
    vint8m4_t __riscv_xl_vdsmacini_x_i8m4(int8_t rs1, size_t vl);
    vint8m8_t __riscv_xl_vdsmacini_x_i8m8(int8_t rs1, size_t vl);
    vint16mf4_t __riscv_xl_vdsmacini_x_i16mf4(int16_t rs1, size_t vl);
    vint16mf2_t __riscv_xl_vdsmacini_x_i16mf2(int16_t rs1, size_t vl);
    vint16m1_t __riscv_xl_vdsmacini_x_i16m1(int16_t rs1, size_t vl);
    vint16m2_t __riscv_xl_vdsmacini_x_i16m2(int16_t rs1, size_t vl);
    vint16m4_t __riscv_xl_vdsmacini_x_i16m4(int16_t rs1, size_t vl);
    vint16m8_t __riscv_xl_vdsmacini_x_i16m8(int16_t rs1, size_t vl);
    vint32mf2_t __riscv_xl_vdsmacini_x_i32mf2(int32_t rs1, size_t vl);
    vint32m1_t __riscv_xl_vdsmacini_x_i32m1(int32_t rs1, size_t vl);
    vint32m2_t __riscv_xl_vdsmacini_x_i32m2(int32_t rs1, size_t vl);
    vint32m4_t __riscv_xl_vdsmacini_x_i32m4(int32_t rs1, size_t vl);
    vint32m8_t __riscv_xl_vdsmacini_x_i32m8(int32_t rs1, size_t vl);

.. note::

    2025.10 版本：

    虽然 ``vdsmacini.v`` 和 ``vdsmacini.s`` 指令没有 vd 参数，但是该指令的 intrinsic 会返回一个值，使用时不能忽略该返回值。

    目前没有 vd 参数的指令，其 intrinsic 均需要返回值。

    而且如果后续程序没有用到该返回值，需要用 ``volatile`` 关键字来声明该返回值，避免在 -O2 及更高优化级别下被优化器删除。

    2026.10 版本：

    没有 vd 参数的指令，其 intrinsic 使用时可以选择不使用返回值（有需要时也可以用），不再需要用 ``volatile`` 关键字来声明，使用方法参考 `Examples`_。

* ``vdsmac.vv/vs`` sew = 8/16/32  none_m_preds[none,_m]

.. tip::

    intrinsic 的名字参考 ``vdsmul.vv/vs`` intrinsic 的名字，只需要将 ``vdsmul`` 替换为 ``vdsmac`` 即可。

* ``vdsmaco.vv/vs`` sew = 8/16/32  full_preds

.. tip::

    同上，只需要将 ``vdsmul`` 替换为 ``vdsmaco`` 即可。

* ``vlsb.v`` sew = 8/16/32  full_preds

.. tip::

    intrinsic 的名字参考 ``vdsmacini.v`` intrinsic 的名字，只需要将 ``vdsmacini`` 替换为 ``vlsb`` 即可。

* ``vconj.v`` sew = 8/16/32  full_preds

.. tip::

    intrinsic 的名字参考 ``vdsmacini.v`` intrinsic 的名字，只需要将 ``vdsmacini`` 替换为 ``vconj`` 即可。

* ``vdscmul.vv/vs`` sew = 8/16/32  full_preds

.. tip::

    intrinsic 的名字参考 ``vdsmul.vv/vs`` intrinsic 的名字，只需要将 ``vdsmul`` 替换为 ``vdscmul`` 即可。

* ``vdscmulj.vv/vs`` sew = 8/16/32  full_preds

.. tip::

    intrinsic 的名字参考 ``vdsmul.vv/vs`` intrinsic 的名字，只需要将 ``vdsmul`` 替换为 ``vdscmulj`` 即可。

* ``vdscredsum.v`` sew = 8/16/32  full_preds

.. tip::

    intrinsic 的名字参考 ``vdsmacini.v`` intrinsic 的名字，只需要将 ``vdsmacini`` 替换为 ``vdscredsum`` 即可。

* ``vdscmac.vv/vs`` sew = 8/16/32 none_m_preds[none,_m]

.. tip::

    intrinsic 的名字参考 ``vdsmul.vv/vs`` intrinsic 的名字，只需要将 ``vdsmul`` 替换为 ``vdscmac`` 即可。

* ``vdscmacj.vv/vs`` sew = 8/16/32 none_m_preds[none,_m]

.. tip::

    intrinsic 的名字参考 ``vdsmul.vv/vs`` intrinsic 的名字，只需要将 ``vdsmul`` 替换为 ``vdscmacj`` 即可。

* ``vdscmaco.vv/vs`` sew = 8/16/32 full_preds

.. tip::

    intrinsic 的名字参考 ``vdsmul.vv/vs`` intrinsic 的名字，只需要将 ``vdsmul`` 替换为 ``vdscmaco`` 即可。

* ``vdscmacjo.vv/vs`` sew = 8/16/32 full_preds

.. tip::

    intrinsic 的名字参考 ``vdsmul.vv/vs`` intrinsic 的名字，只需要将 ``vdsmul`` 替换为 ``vdscmacjo`` 即可。

* ``vdscmacor.vv``  sew = 32 full_preds

.. code-block:: c

    vint32mf2_t __riscv_xl_vdscmacor_vv_i32mf2(vint32mf2_t vs2, vint32mf2_t vs1, size_t vl);
    vint32m1_t __riscv_xl_vdscmacor_vv_i32m1(vint32m1_t vs2, vint32m1_t vs1, size_t vl);
    vint32m2_t __riscv_xl_vdscmacor_vv_i32m2(vint32m2_t vs2, vint32m2_t vs1, size_t vl);
    vint32m4_t __riscv_xl_vdscmacor_vv_i32m4(vint32m4_t vs2, vint32m4_t vs1, size_t vl);
    vint32m8_t __riscv_xl_vdscmacor_vv_i32m8(vint32m8_t vs2, vint32m8_t vs1, size_t vl);

* ``vdscmacor.vs``  sew = 32 full_preds

.. code-block:: c

    vint32mf2_t __riscv_xl_vdscmacor_vs_i32mf2_i32mf2(vint32mf2_t vs2, vint32mf2_t vs1, size_t vl);
    vint32m1_t __riscv_xl_vdscmacor_vs_i32m1_i32m1(vint32m1_t vs2, vint32m1_t vs1, size_t vl);
    vint32m2_t __riscv_xl_vdscmacor_vs_i32m2_i32m2(vint32m2_t vs2, vint32m2_t vs1, size_t vl);
    vint32m4_t __riscv_xl_vdscmacor_vs_i32m4_i32m4(vint32m4_t vs2, vint32m4_t vs1, size_t vl);
    vint32m8_t __riscv_xl_vdscmacor_vs_i32m8_i32m8(vint32m8_t vs2, vint32m8_t vs1, size_t vl);

* ``vdscmacoi.vv/vs`` sew = 32 full_preds

.. tip::

    intrinsic 的名字参考 ``vdscmacor.vv/vs`` intrinsic 的名字，只需要将 ``vdscmacor`` 替换为 ``vdscmacoi`` 即可。

* ``vdscmacjor.vv/vs`` sew = 32 full_preds

.. tip::

    intrinsic 的名字参考 ``vdscmacor.vv/vs`` intrinsic 的名字，只需要将 ``vdscmacor`` 替换为 ``vdscmacjor`` 即可。

* ``vdscmacjoi.vv/vs`` sew = 32 full_preds

.. tip::

    intrinsic 的名字参考 ``vdscmacor.vv/vs`` intrinsic 的名字，只需要将 ``vdscmacor`` 替换为 ``vdscmacjoi`` 即可。

* ``vdscmulr.vv/vs`` sew = 8/16/32 full_preds

.. tip::

    intrinsic 的名字参考 ``vdsmul.vv/vs`` intrinsic 的名字，只需要将 ``vdsmul`` 替换为 ``vdscmulr`` 即可。

* ``vdscmuli.vv/vs`` sew = 8/16/32 full_preds

.. tip::

    intrinsic 的名字参考 ``vdsmul.vv/vs`` intrinsic 的名字，只需要将 ``vdsmul`` 替换为 ``vdscmuli`` 即可。

* ``vdscmuljr.vv/vs`` sew = 8/16/32 full_preds

.. tip::

    intrinsic 的名字参考 ``vdsmul.vv/vs`` intrinsic 的名字，只需要将 ``vdsmul`` 替换为 ``vdscmuljr`` 即可。

* ``vdscmulji.vv/vs`` sew = 8/16/32 full_preds

.. tip::

    intrinsic 的名字参考 ``vdsmul.vv/vs`` intrinsic 的名字，只需要将 ``vdsmul`` 替换为 ``vdscmulji`` 即可。

* ``vdsredsum.v``  sew = 8/16/32 full_preds

.. tip::

    intrinsic 的名字参考 ``vdsmacini.v`` intrinsic 的名字，只需要将 ``vdsmacini`` 替换为 ``vdsredsum`` 即可。

* ``vdsredsumn.vs vd, vs2, rs1`` sew = 8/16/32 none_tu_preds

.. code-block:: c

    vint8mf8_t __riscv_xl_vdsredsumn_vx_i8mf8(vint8mf8_t vs2, int8_t rs1, size_t vl);
    vint8mf4_t __riscv_xl_vdsredsumn_vx_i8mf4(vint8mf4_t vs2, int8_t rs1, size_t vl);
    vint8mf2_t __riscv_xl_vdsredsumn_vx_i8mf2(vint8mf2_t vs2, int8_t rs1, size_t vl);
    vint8m1_t __riscv_xl_vdsredsumn_vx_i8m1(vint8m1_t vs2, int8_t rs1, size_t vl);
    vint8m2_t __riscv_xl_vdsredsumn_vx_i8m2(vint8m2_t vs2, int8_t rs1, size_t vl);
    vint8m4_t __riscv_xl_vdsredsumn_vx_i8m4(vint8m4_t vs2, int8_t rs1, size_t vl);
    vint8m8_t __riscv_xl_vdsredsumn_vx_i8m8(vint8m8_t vs2, int8_t rs1, size_t vl);
    vint16mf4_t __riscv_xl_vdsredsumn_vx_i16mf4(vint16mf4_t vs2, int16_t rs1, size_t vl);
    vint16mf2_t __riscv_xl_vdsredsumn_vx_i16mf2(vint16mf2_t vs2, int16_t rs1, size_t vl);
    vint16m1_t __riscv_xl_vdsredsumn_vx_i16m1(vint16m1_t vs2, int16_t rs1, size_t vl);
    vint16m2_t __riscv_xl_vdsredsumn_vx_i16m2(vint16m2_t vs2, int16_t rs1, size_t vl);
    vint16m4_t __riscv_xl_vdsredsumn_vx_i16m4(vint16m4_t vs2, int16_t rs1, size_t vl);
    vint16m8_t __riscv_xl_vdsredsumn_vx_i16m8(vint16m8_t vs2, int16_t rs1, size_t vl);
    vint32mf2_t __riscv_xl_vdsredsumn_vx_i32mf2(vint32mf2_t vs2, int32_t rs1, size_t vl);
    vint32m1_t __riscv_xl_vdsredsumn_vx_i32m1(vint32m1_t vs2, int32_t rs1, size_t vl);
    vint32m2_t __riscv_xl_vdsredsumn_vx_i32m2(vint32m2_t vs2, int32_t rs1, size_t vl);
    vint32m4_t __riscv_xl_vdsredsumn_vx_i32m4(vint32m4_t vs2, int32_t rs1, size_t vl);
    vint32m8_t __riscv_xl_vdsredsumn_vx_i32m8(vint32m8_t vs2, int32_t rs1, size_t vl);

* ``vdsredsumn.vi vd, vs2, uimm`` sew = 8/16/32 none_tu_preds

.. tip::

    intrinsic 的名字参考 ``vdsredsumn.vs`` intrinsic 的名字，只需要将 ``_vx`` 替换为 ``_vi`` 即可。
    ``vdsredsumn.vs/vi`` 指令的 rs1 和 uimm 的值必须是 [1, 2, 3, 4] 范围内的整数。

* ``vredmaxi.vv`` sew = 8/16/32 full_preds

.. tip::

    intrinsic 的名字参考 ``vdsmul.vv`` intrinsic 的名字，只需要将 ``vdsmul`` 替换为 ``vredmaxi`` 即可。

* ``vredmini.vv`` sew = 8/16/32 full_preds

.. tip::

    intrinsic 的名字参考 ``vdsmul.vv`` intrinsic 的名字，只需要将 ``vdsmul`` 替换为 ``vredmini`` 即可。

* ``vperm.vi`` sew = 8/16/32 none_tu_preds

.. code-block:: c

    vint8mf8_t __riscv_xl_vperm_vi_i8mf8(vint8mf8_t vs2, int8_t rs1, size_t vl);
    vint8mf4_t __riscv_xl_vperm_vi_i8mf4(vint8mf4_t vs2, int8_t rs1, size_t vl);
    vint8mf2_t __riscv_xl_vperm_vi_i8mf2(vint8mf2_t vs2, int8_t rs1, size_t vl);
    vint8m1_t __riscv_xl_vperm_vi_i8m1(vint8m1_t vs2, int8_t rs1, size_t vl);
    vint8m2_t __riscv_xl_vperm_vi_i8m2(vint8m2_t vs2, int8_t rs1, size_t vl);
    vint8m4_t __riscv_xl_vperm_vi_i8m4(vint8m4_t vs2, int8_t rs1, size_t vl);
    vint8m8_t __riscv_xl_vperm_vi_i8m8(vint8m8_t vs2, int8_t rs1, size_t vl);
    vint16mf4_t __riscv_xl_vperm_vi_i16mf4(vint16mf4_t vs2, int16_t rs1, size_t vl);
    vint16mf2_t __riscv_xl_vperm_vi_i16mf2(vint16mf2_t vs2, int16_t rs1, size_t vl);
    vint16m1_t __riscv_xl_vperm_vi_i16m1(vint16m1_t vs2, int16_t rs1, size_t vl);
    vint16m2_t __riscv_xl_vperm_vi_i16m2(vint16m2_t vs2, int16_t rs1, size_t vl);
    vint16m4_t __riscv_xl_vperm_vi_i16m4(vint16m4_t vs2, int16_t rs1, size_t vl);
    vint16m8_t __riscv_xl_vperm_vi_i16m8(vint16m8_t vs2, int16_t rs1, size_t vl);
    vint32mf2_t __riscv_xl_vperm_vi_i32mf2(vint32mf2_t vs2, int32_t rs1, size_t vl);
    vint32m1_t __riscv_xl_vperm_vi_i32m1(vint32m1_t vs2, int32_t rs1, size_t vl);
    vint32m2_t __riscv_xl_vperm_vi_i32m2(vint32m2_t vs2, int32_t rs1, size_t vl);
    vint32m4_t __riscv_xl_vperm_vi_i32m4(vint32m4_t vs2, int32_t rs1, size_t vl);
    vint32m8_t __riscv_xl_vperm_vi_i32m8(vint32m8_t vs2, int32_t rs1, size_t vl);

* ``vfsl.vv`` sew = 8/16/32 none_tu_preds

.. tip::

    intrinsic 的名字参考 ``vdsmul.vv`` intrinsic 的名字，只需要将 ``vdsmul`` 替换为 ``vfsl`` 即可。

* ``vfsr.vv`` sew = 8/16/32 none_tu_preds

.. tip::

    intrinsic 的名字参考 ``vdsmul.vv`` intrinsic 的名字，只需要将 ``vdsmul`` 替换为 ``vfsr`` 即可。

* ``vlnlp0.v/vlnlp1.v`` sew = 8/16/32 none_preds

该指令对应 intrinsic 的使用需满足以下关系：

当 VLEN=128 时，LMUL=8

当 VLEN=256 时，LMUL=4

当 VLEN=512 时，LMUL=2

当 VLEN=1024 时，LMUL=1

编译器可通过 ``-march=*_zvl${vlen}b`` 来设置 VLEN 的取值，其中 ``vlen`` 可取 {128, 256, 512, 1024, ...}，若不指定则默认为 128。

* ``_zvl1024b`` （VLEN=1024）时可用的 intrinsic：

.. code-block:: c

    vint8m1_t __riscv_xl_vlnlp0_v_i8m1(vint8m1_t vs, size_t vl);

    vint16m1_t __riscv_xl_vlnlp0_v_i16m1(vint16m1_t vs, size_t vl);

    vint32m1_t __riscv_xl_vlnlp0_v_i32m1(vint32m1_t vs, size_t vl);

    vint8m1_t __riscv_xl_vlnlp1_v_i8m1(vint8m1_t vs, size_t vl);

    vint16m1_t __riscv_xl_vlnlp1_v_i16m1(vint16m1_t vs, size_t vl);

    vint32m1_t __riscv_xl_vlnlp1_v_i32m1(vint32m1_t vs, size_t vl);

* ``_zvl512b`` （VLEN=512）时可用的 intrinsic：

.. code-block:: c

    vint8m2_t __riscv_xl_vlnlp0_v_i8m2(vint8m2_t vs, size_t vl);

    vint16m2_t __riscv_xl_vlnlp0_v_i16m2(vint16m2_t vs, size_t vl);

    vint32m2_t __riscv_xl_vlnlp0_v_i32m2(vint32m2_t vs, size_t vl);

    vint8m2_t __riscv_xl_vlnlp1_v_i8m2(vint8m2_t vs, size_t vl);

    vint16m2_t __riscv_xl_vlnlp1_v_i16m2(vint16m2_t vs, size_t vl);

    vint32m2_t __riscv_xl_vlnlp1_v_i32m2(vint32m2_t vs, size_t vl);

* ``_zvl256b`` （VLEN=256）时可用的 intrinsic：

.. code-block:: c

    vint8m4_t __riscv_xl_vlnlp0_v_i8m4(vint8m4_t vs, size_t vl);

    vint16m4_t __riscv_xl_vlnlp0_v_i16m4(vint16m4_t vs, size_t vl);

    vint32m4_t __riscv_xl_vlnlp0_v_i32m4(vint32m4_t vs, size_t vl);

    vint8m4_t __riscv_xl_vlnlp1_v_i8m4(vint8m4_t vs, size_t vl);

    vint16m4_t __riscv_xl_vlnlp1_v_i16m4(vint16m4_t vs, size_t vl);

    vint32m4_t __riscv_xl_vlnlp1_v_i32m4(vint32m4_t vs, size_t vl);

* ``_zvl128b`` （VLEN=128）时可用的 intrinsic：

.. code-block:: c

    vint8m8_t __riscv_xl_vlnlp0_v_i8m8(vint8m8_t vs, size_t vl);

    vint16m8_t __riscv_xl_vlnlp0_v_i16m8(vint16m8_t vs, size_t vl);

    vint32m8_t __riscv_xl_vlnlp0_v_i32m8(vint32m8_t vs, size_t vl);

    vint8m8_t __riscv_xl_vlnlp1_v_i8m8(vint8m8_t vs, size_t vl);

    vint16m8_t __riscv_xl_vlnlp1_v_i16m8(vint16m8_t vs, size_t vl);

    vint32m8_t __riscv_xl_vlnlp1_v_i32m8(vint32m8_t vs, size_t vl);

.. tip::

    在使用上述 intrinsic 的时候，如果遇到以下这种 ``unrecognizable insn`` 错误：

    .. code-block:: text

        vlnlp_m1.c: In function 'test_vlnlp0_v_i8m1':
        vlnlp_m1.c:8:1: error: unrecognizable insn:
            8 | }
            | ^
        (insn 7 4 11 2 (set (reg:RVVM1QI 134 [ <retval> ])
                (if_then_else:RVVM1QI (unspec:RVVMF8BI [
                            (const_vector:RVVMF8BI repeat [
                                    (const_int 1 [0x1])
                                ])
                            (reg/v:SI 136 [ vl ])
                            (const_int 2 [0x2]) repeated x2
                            (const_int 0 [0])
                            (reg:SI 66 vl)
                            (reg:SI 67 vtype)
                        ] UNSPEC_VPREDICATE)
                    (unspec:RVVM1QI [
                            (reg/v:RVVM1QI 135 [ vs ])
                        ] UNSPEC_VLNLP0)
                    (unspec:RVVM1QI [
                            (reg:SI 0 zero)
                        ] UNSPEC_VUNDEF))) "vlnlp_m1.c":7:10 -1
            (nil))
        during RTL pass: vregs
        vlnlp_m1.c:8:1: internal compiler error: in extract_insn, at recog.cc:2812
        0x7f8636076082 __libc_start_main
                ../csu/libc-start.c:308
        Please submit a full bug report, with preprocessed source (by using -freport-bug).
        Please include the complete backtrace with any bug report.
        See <https://gcc.gnu.org/bugs/> for instructions.

    通常是由于 VLEN 与 intrinsic 所用的 LMUL 不匹配导致的。

* ``vnle.vv/vs`` sew = 8/16/32 full_preds

.. tip::

    intrinsic 的名字参考 ``vdsmul.vv/vs`` intrinsic 的名字，只需要将 ``vdsmul`` 替换为 ``vnle`` 即可。

* ``vnlm.vv/vs`` sew = 8/16/32 full_preds

.. tip::

    intrinsic 的名字参考 ``vdsmul.vv/vs`` intrinsic 的名字，只需要将 ``vdsmul`` 替换为 ``vnlm`` 即可。

* ``vfcvt.b2h.v`` sew = 8→16 none_tu_preds

.. code-block:: c

    vint16mf4_t __riscv_xl_vfcvt_b2h_v_i16mf4(vint8mf8_t vs2, size_t vl);
    vint16mf2_t __riscv_xl_vfcvt_b2h_v_i16mf2(vint8mf4_t vs2, size_t vl);
    vint16m1_t __riscv_xl_vfcvt_b2h_v_i16m1(vint8mf2_t vs2, size_t vl);
    vint16m2_t __riscv_xl_vfcvt_b2h_v_i16m2(vint8m1_t vs2, size_t vl);
    vint16m4_t __riscv_xl_vfcvt_b2h_v_i16m4(vint8m2_t vs2, size_t vl);
    vint16m8_t __riscv_xl_vfcvt_b2h_v_i16m8(vint8m4_t vs2, size_t vl);

* ``vfcvt.b2w.v`` sew = 8→32 none_tu_preds

.. code-block:: c

    vint32mf2_t __riscv_xl_vfcvt_b2w_v_i32mf2(vint8mf8_t vs2, size_t vl);
    vint32m1_t __riscv_xl_vfcvt_b2w_v_i32m1(vint8mf4_t vs2, size_t vl);
    vint32m2_t __riscv_xl_vfcvt_b2w_v_i32m2(vint8mf2_t vs2, size_t vl);
    vint32m4_t __riscv_xl_vfcvt_b2w_v_i32m4(vint8m1_t vs2, size_t vl);
    vint32m8_t __riscv_xl_vfcvt_b2w_v_i32m8(vint8m2_t vs2, size_t vl);

* ``vfcvt.h2w.v`` sew = 16→32 none_tu_preds

.. code-block:: c

    vint32mf2_t __riscv_xl_vfcvt_h2w_v_i32mf2(vint16mf4_t vs2, size_t vl);
    vint32m1_t __riscv_xl_vfcvt_h2w_v_i32m1(vint16mf2_t vs2, size_t vl);
    vint32m2_t __riscv_xl_vfcvt_h2w_v_i32m2(vint16m1_t vs2, size_t vl);
    vint32m4_t __riscv_xl_vfcvt_h2w_v_i32m4(vint16m2_t vs2, size_t vl);
    vint32m8_t __riscv_xl_vfcvt_h2w_v_i32m8(vint16m4_t vs2, size_t vl);

* ``vfcvt.p2c.v`` sew = 16→32 none_tu_preds

.. code-block:: c

    vint32mf2_t __riscv_xl_vfcvt_p2c_v_i32mf2(vint16mf4_t vs2, size_t vl);
    vint32m1_t __riscv_xl_vfcvt_p2c_v_i32m1(vint16mf2_t vs2, size_t vl);
    vint32m2_t __riscv_xl_vfcvt_p2c_v_i32m2(vint16m1_t vs2, size_t vl);
    vint32m4_t __riscv_xl_vfcvt_p2c_v_i32m4(vint16m2_t vs2, size_t vl);
    vint32m8_t __riscv_xl_vfcvt_p2c_v_i32m8(vint16m4_t vs2, size_t vl);

* ``vfcvt.h2b.v`` sew = 16→8 none_tu_preds

.. code-block:: c

    vint8mf8_t __riscv_xl_vfcvt_h2b_v_i8mf8(vint16mf4_t vs2, size_t vl);
    vint8mf4_t __riscv_xl_vfcvt_h2b_v_i8mf4(vint16mf2_t vs2, size_t vl);
    vint8mf2_t __riscv_xl_vfcvt_h2b_v_i8mf2(vint16m1_t vs2, size_t vl);
    vint8m1_t __riscv_xl_vfcvt_h2b_v_i8m1(vint16m2_t vs2, size_t vl);
    vint8m2_t __riscv_xl_vfcvt_h2b_v_i8m2(vint16m4_t vs2, size_t vl);
    vint8m4_t __riscv_xl_vfcvt_h2b_v_i8m4(vint16m8_t vs2, size_t vl);

* ``vfcvt.w2b.v`` sew = 32→8 none_tu_preds

.. code-block:: c

    vint8mf8_t __riscv_xl_vfcvt_w2b_v_i8mf8(vint32mf2_t vs2, size_t vl);
    vint8mf4_t __riscv_xl_vfcvt_w2b_v_i8mf4(vint32m1_t vs2, size_t vl);
    vint8mf2_t __riscv_xl_vfcvt_w2b_v_i8mf2(vint32m2_t vs2, size_t vl);
    vint8m1_t __riscv_xl_vfcvt_w2b_v_i8m1(vint32m4_t vs2, size_t vl);
    vint8m2_t __riscv_xl_vfcvt_w2b_v_i8m2(vint32m8_t vs2, size_t vl);

* ``vfcvt.w2h.v`` sew = 32→16 none_tu_preds

.. code-block:: c

    vint16mf4_t __riscv_xl_vfcvt_w2h_v_i16mf4(vint32mf2_t vs2, size_t vl);
    vint16mf2_t __riscv_xl_vfcvt_w2h_v_i16mf2(vint32m1_t vs2, size_t vl);
    vint16m1_t __riscv_xl_vfcvt_w2h_v_i16m1(vint32m2_t vs2, size_t vl);
    vint16m2_t __riscv_xl_vfcvt_w2h_v_i16m2(vint32m4_t vs2, size_t vl);
    vint16m4_t __riscv_xl_vfcvt_w2h_v_i16m4(vint32m8_t vs2, size_t vl);

* ``vfcvt.c2p.v`` sew = 32→16 none_tu_preds

.. code-block:: c

    vint16mf4_t __riscv_xl_vfcvt_c2p_v_i16mf4(vint32mf2_t vs2, size_t vl);
    vint16mf2_t __riscv_xl_vfcvt_c2p_v_i16mf2(vint32m1_t vs2, size_t vl);
    vint16m1_t __riscv_xl_vfcvt_c2p_v_i16m1(vint32m2_t vs2, size_t vl);
    vint16m2_t __riscv_xl_vfcvt_c2p_v_i16m2(vint32m4_t vs2, size_t vl);
    vint16m4_t __riscv_xl_vfcvt_c2p_v_i16m4(vint32m8_t vs2, size_t vl);

Examples
**********

.. code-block:: c

    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <riscv_vector.h>

    typedef union {
        struct {
            int16_t re;
            int16_t im;
        } sc16;
        int32_t i32;
    } cplx_sc16;

    cplx_sc16 src1[4];
    cplx_sc16 src2[4];
    cplx_sc16 dst_cmul[4];
    cplx_sc16 dst_mac[4];
    cplx_sc16 dst_cmac[4];

    void cplx_mul(const cplx_sc16 *src1, const cplx_sc16 *src2, cplx_sc16 *dst, int len) {
        for (int i = 0; i < len; ++i) {
            int64_t re = (int64_t)src1[i].sc16.re * src2[i].sc16.re - (int64_t)src1[i].sc16.im * src2[i].sc16.im;
            int64_t im = (int64_t)src1[i].sc16.re * src2[i].sc16.im + (int64_t)src1[i].sc16.im * src2[i].sc16.re;
            dst[i].sc16.re = re >> 15;
            dst[i].sc16.im = im >> 15;
        }
    }

    int main()
    {
        unsigned long vcsr = (0x0 << 8) | (0x1 << 3);
        asm volatile ("csrw 0xf,%0" : : "r"(vcsr));
        asm volatile("csrr %0,0xf" : "=r"(vcsr));
        printf("vcsr = %x\r\n", vcsr);

        memset(&src1[0], 0, sizeof(cplx_sc16) * 4);
        memset(&src2[0], 0, sizeof(cplx_sc16) * 4);
        memset(&dst_cmul[0], 0, sizeof(cplx_sc16) * 4);
        memset(&dst_mac[0], 0, sizeof(cplx_sc16) * 4);
        memset(&dst_cmac[0], 0, sizeof(cplx_sc16) * 4);

        for (int i = 0; i < 4; ++i) {
            src1[i].sc16.re = rand() % 32 - 16;
            src1[i].sc16.im = rand() % 32 - 16;
            src2[i].sc16.re = rand() % 32 - 16;
            src2[i].sc16.im = rand() % 32 - 16;
        }

        size_t vl = 4;

        vint32m1_t vs1 = __riscv_vle32_v_i32m1(&src1[0].i32, vl);
        vint32m1_t vs2 = __riscv_vle32_v_i32m1(&src2[0].i32, vl);
        vint32m1_t vd = __riscv_xl_vdscmul_vv_i32m1(vs2, vs1, vl);
        __riscv_vse32_v_i32m1(&dst_cmul[0].i32, vd, vl);

        // vint32m1_t tmp = __riscv_xl_vdsmacini_x_i32m1(1, vl); 需要返回值时的使用方法
        __riscv_xl_vdsmacini_x_i32m1(1, vl);

        vd = __riscv_xl_vdscmaco_vv_i32m1(vs2, vs1, vl);
        __riscv_vse32_v_i32m1(&dst_cmac[0].i32, vd, vl);
        return 0;
    }
