.. _toolchain_gnu_nuclei_xxlvw:

Nuclei Custom Xxlvw Extension
================================

Introduction
*************



扩展
*****

使用该扩展时,需要打开 ``V`` 扩展和 ``xxlvw`` 扩展,同时该扩展只支持rv32

示例：`-march=rv32imafcv_xxlvw -mabi=ilp32f`

.. attention::

    使用该扩展的相关 intrinsic 时，需要添加以下头文件:

    ``#include <riscv_vector.h>``

支持的指令
**********

Complex number format convert
 - ``vcpack.vv vd, vs2, vs1, vm``
 - ``vcunpackr.v vd, vs2, vm``
 - ``vcunpacki.v vd, vs2, vm``
Fix point dynamic scaling operations
 - ``vdsmul.vv/vs vd, vs2, vs1, vm``
 - ``vdsmacini.v vs2, vm``
 - ``vdsmacini.s rs1,vm``
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
Dynamic scaling Reduced operation
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

    这些指令的详细信息，参考 https://gitee.com/XinShengTech_riscv_xl_OpenSource/riscv-vector4wireless-extension/blob/Zvw/src/RISCV-Vector-Extension-for-Wireless.adoc

intrinsic 命名规则
*******************

rvv intrinsic 命名规则: https://github.com/riscv-non-isa/rvv-intrinsic-doc/releases/tag/v1.0.0-rc7 ``v-intrinsic-spec.pdf``-> **Chapter 6**.

我们的命名规则遵循上述的命名规则,并在此基础上在前缀处添加了 ``_xl``

Nuclei 自定义的 intrinsic
**************************

.. note::

    每一条指令对应的intrinsic,会给出示例,全部的intrinsic请参考rvv intrinsic 命名规则和示例进行构建。

    下文出现的sew指的是指令支持的数据类型的宽度,full_preds 指的是intrinsic函数支持的后缀形式, full 是全部都支持,包含 none(无后缀),_m,_tu,_tum,_tumu,_mu等六种形式。

* ``vcpack.vv``   sew = 32 full_preds

.. code-block:: c

    vint32m1_t __riscv_xl_vcpack_vv_i32m1(vint32m1_t vs2, vint32m1_t vs1, size_t vl);
    vint32m1_t __riscv_xl_vcpack_vv_i32m1_m(vbool32_t vm, vint32m1_t vs2, vint32m1_t vs1, size_t vl);
    vint32m1_t __riscv_xl_vcpack_vv_i32m1_tu(vint32m1_t vd, vint32m1_t vs2, vint32m1_t vs1, size_t vl);
    vint32m1_t __riscv_xl_vcpack_vv_i32m1_tum(vbool32_t vm,vint32m1_t vd, vint32m1_t vs2, vint32m1_t vs1, size_t vl);
    vint32m1_t __riscv_xl_vcpack_vv_i32m1_tumu(vbool32_t vm,vint32m1_t vd, vint32m1_t vs2, vint32m1_t vs1, size_t vl);
    vint32m1_t __riscv_xl_vcpack_vv_i32m1_mu(vbool32_t vm,vint32m1_t vd, vint32m1_t vs2, vint32m1_t vs1, size_t vl);

.. note::

    后续指令对应的intrinsic,只会给出none(无后缀)的全部intrinsic,其余后缀的需要使用时,参考上面的构建规则

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

.. note::

    虽然该指令没有 ``vd parameter``，但是该指令的intrinsic使用时是需要一个返回值的，其返回值不为空。

    暂时没有 ``vd parameter`` 的指令intrinsic，都需要一个返回值。

    而且如果后续程序没有用到该返回值，需要用 ``volatile`` 关键字来声明该返回值，防止开启 -O2 以及更高级别优化时被优化掉，示例可参考 `Examples`_ 部分。

    未来该类型指令的intrinsic的使用方法可能会有变化，目前只是一个workaround版本。


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

* ``vdsmac.vv/vs`` sew = 8/16/32  none_m_preds[none,_m]

.. tip::

    intrinsic 的名字 参考 `vdsmul.vv/vs` intrinsic 的名字,只需要将 `vdsmul` 替换为 `vdsmac` 即可。

* ``vdsmaco.vv/vs`` sew = 8/16/32  full_preds

.. tip::

    同上,只需要将 `vdsmul` 替换为 `vdsmaco` 即可

* ``vlsb.v`` sew = 8/16/32  full_preds

.. tip::

    intrinsic 的名字参考 `vdsmacini.v` intrinsic 的名字,只需要将 `vdsmacini` 替换为 `vlsb` 即可。

* ``vconj.v`` sew = 8/16/32  full_preds

.. tip::

    intrinsic 的名字参考 `vdsmacini.v` intrinsic 的名字,只需要将 `vdsmacini` 替换为 `vconj` 即可。

* ``vdscmul.vv/vs`` sew = 8/16/32  full_preds

.. tip::

    intrinsic 的名字 参考 `vdsmul.vv/vs` intrinsic 的名字,只需要将 `vdsmul` 替换为 `vdscmul` 即可。

* ``vdscmulj.vv/vs`` sew = 8/16/32  full_preds

.. tip::

    intrinsic 的名字 参考 `vdsmul.vv/vs` intrinsic 的名字,只需要将 `vdsmul` 替换为 `vdscmulj` 即可。

* ``vdscredsum.v`` sew = 8/16/32  full_preds

.. tip::

    intrinsic 的名字参考 `vdsmacini.v` intrinsic 的名字,只需要将 `vdsmacini` 替换为 `vdscredsum` 即可。

* ``vdscmac.vv/vs`` sew = 8/16/32 none_m_preds[none,_m]

.. tip::

    intrinsic 的名字 参考 `vdsmul.vv/vs` intrinsic 的名字,只需要将 `vdsmul` 替换为 `vdscmac` 即可。

* ``vdscmacj.vv/vs`` sew = 8/16/32 none_m_preds[none,_m]

.. tip::

    intrinsic 的名字 参考 `vdsmul.vv/vs` intrinsic 的名字,只需要将 `vdsmul` 替换为 `vdscmacj` 即可。

* ``vdscmaco.vv/vs`` sew = 8/16/32 full_preds

.. tip::

    intrinsic 的名字 参考 `vdsmul.vv/vs` intrinsic 的名字,只需要将 `vdsmul` 替换为 `vdscmaco` 即可。

* ``vdscmacjo.vv/vs`` sew = 8/16/32 full_preds

.. tip::

    intrinsic 的名字 参考 `vdsmul.vv/vs` intrinsic 的名字,只需要将 `vdsmul` 替换为 `vdscmacjo` 即可。

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

    intrinsic 的名字 参考 `vdscmacor.vv/vs` intrinsic 的名字,只需要将 `vdscmacor` 替换为 `vdscmacoi` 即可。

* ``vdscmacjor.vv/vs`` sew = 32 full_preds

.. tip::

    intrinsic 的名字 参考 `vdscmacor.vv/vs` intrinsic 的名字,只需要将 `vdscmacor` 替换为 `vdscmacjor` 即可。

* ``vdscmacjoi.vv/vs`` sew = 32 full_preds

.. tip::

    intrinsic 的名字 参考 `vdscmacor.vv/vs` intrinsic 的名字,只需要将 `vdscmacor` 替换为 `vdscmacjoi` 即可。

* ``vdscmulr.vv/vs`` sew = 8/16/32 full_preds

.. tip::

    intrinsic 的名字 参考 `vdsmul.vv/vs` intrinsic 的名字,只需要将 `vdsmul` 替换为 `vdscmulr` 即可。

* ``vdscmuli.vv/vs`` sew = 8/16/32 full_preds

.. tip::

    intrinsic 的名字 参考 `vdsmul.vv/vs` intrinsic 的名字,只需要将 `vdsmul` 替换为 `vdscmuli` 即可。

* ``vdscmuljr.vv/vs`` sew = 8/16/32 full_preds

.. tip::

    intrinsic 的名字 参考 `vdsmul.vv/vs` intrinsic 的名字,只需要将 `vdsmul` 替换为 `vdscmuljr` 即可。

* ``vdscmulji.vv/vs`` sew = 8/16/32 full_preds

.. tip::

    intrinsic 的名字 参考 `vdsmul.vv/vs` intrinsic 的名字,只需要将 `vdsmul` 替换为 `vdscmulji` 即可。

* ``vdsredsum.v``  sew = 8/16/32 full_preds

.. tip::

    intrinsic 的名字参考 `vdsmacini.v` intrinsic 的名字,只需要将 `vdsmacini` 替换为 `vdsredsum` 即可。

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

    intrinsic 的名字参考 `vdsredsumn.vs` intrinsic 的名字,只需要将 `_vx` 替换为 `_vi` 即可。
    `vdsredsumn.vs/vi`  指令的rs1和uimm的值必须是整数[1,2,3,4]之内的。

* ``vredmaxi.vv`` sew = 8/16/32 full_preds

.. tip::

    intrinsic 的名字 参考 `vdsmul.vv` intrinsic 的名字,只需要将 `vdsmul` 替换为 `vredmaxi` 即可。

* ``vredmini.vv`` sew = 8/16/32 full_preds

.. tip::

    intrinsic 的名字 参考 `vdsmul.vv` intrinsic 的名字,只需要将 `vdsmul` 替换为 `vredmini` 即可。

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

    intrinsic 的名字 参考 `vdsmul.vv` intrinsic 的名字,只需要将 `vdsmul` 替换为 `vfsl` 即可。

* ``vfsr.vv`` sew = 8/16/32 none_tu_preds

.. tip::

    intrinsic 的名字 参考 `vdsmul.vv` intrinsic 的名字,只需要将 `vdsmul` 替换为 `vfsr` 即可。

* ``vlnlp0.v/vlnlp1.v`` sew = 8/16/32 none_preds

该指令的intrinsic的使用需要满足以下关系

当VLEN=128时，LMUL=8

当VLEN=256时，LMUL=4

当VLEN=512时，LMUL=2

当VLEN=1024时，LMUL=1

编译器可通过  ``-march=*_zvl${vlen}b`` 来控制vlen的长度，其中 ``vlen`` 可取值{128，256，512，1024，...}等，默认不指定的情况下是128

_zvl1024b 以下intrinsic可以使用

.. code-block:: c

    vint8m1_t __riscv_xl_vlnlp0_v_i8m1(vint8m1_t vs, size_t vl);

    vint16m1_t __riscv_xl_vlnlp0_v_i16m1(vint16m1_t vs, size_t vl);

    vint32m1_t __riscv_xl_vlnlp0_v_i32m1(vint32m1_t vs, size_t vl);

    vint8m1_t __riscv_xl_vlnlp1_v_i8m1(vint8m1_t vs, size_t vl);

    vint16m1_t __riscv_xl_vlnlp1_v_i16m1(vint16m1_t vs, size_t vl);

    vint32m1_t __riscv_xl_vlnlp1_v_i32m1(vint32m1_t vs, size_t vl);

_zvl512b 以下intrinsic可以使用

.. code-block:: c

    vint8m2_t __riscv_xl_vlnlp0_v_i8m2(vint8m2_t vs, size_t vl);

    vint16m2_t __riscv_xl_vlnlp0_v_i16m2(vint16m2_t vs, size_t vl);

    vint32m2_t __riscv_xl_vlnlp0_v_i32m2(vint32m2_t vs, size_t vl);

    vint8m2_t __riscv_xl_vlnlp1_v_i8m2(vint8m2_t vs, size_t vl);

    vint16m2_t __riscv_xl_vlnlp1_v_i16m2(vint16m2_t vs, size_t vl);

    vint32m2_t __riscv_xl_vlnlp1_v_i32m2(vint32m2_t vs, size_t vl);

_zvl256b 以下intrinsic可以使用

.. code-block:: c

    vint8m4_t __riscv_xl_vlnlp0_v_i8m4(vint8m4_t vs, size_t vl);

    vint16m4_t __riscv_xl_vlnlp0_v_i16m4(vint16m4_t vs, size_t vl);

    vint32m4_t __riscv_xl_vlnlp0_v_i32m4(vint32m4_t vs, size_t vl);

    vint8m4_t __riscv_xl_vlnlp1_v_i8m4(vint8m4_t vs, size_t vl);

    vint16m4_t __riscv_xl_vlnlp1_v_i16m4(vint16m4_t vs, size_t vl);

    vint32m4_t __riscv_xl_vlnlp1_v_i32m4(vint32m4_t vs, size_t vl);

_zvl128b 以下intrinsic可以使用

.. code-block:: c

    vint8m8_t __riscv_xl_vlnlp0_v_i8m8(vint8m8_t vs, size_t vl);

    vint16m8_t __riscv_xl_vlnlp0_v_i16m8(vint16m8_t vs, size_t vl);

    vint32m8_t __riscv_xl_vlnlp0_v_i32m8(vint32m8_t vs, size_t vl);

    vint8m8_t __riscv_xl_vlnlp1_v_i8m8(vint8m8_t vs, size_t vl);

    vint16m8_t __riscv_xl_vlnlp1_v_i16m8(vint16m8_t vs, size_t vl);

    vint32m8_t __riscv_xl_vlnlp1_v_i32m8(vint32m8_t vs, size_t vl);

.. tip::

    在使用上述intrinsic的时候，如果遇到以下这种 ``unrecognizable insn`` 错误：

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

    可能就是vlen长度和intrinsic使用时的lmul没有对应导致的

* ``vnle.vv/vs`` sew = 8/16/32 full_preds

.. tip::

    intrinsic 的名字 参考 `vdsmul.vv/vs` intrinsic 的名字,只需要将 `vdsmul` 替换为 `vnle` 即可。

* ``vnlm.vv/vs`` sew = 8/16/32 full_preds

.. tip::

    intrinsic 的名字 参考 `vdsmul.vv/vs` intrinsic 的名字,只需要将 `vdsmul` 替换为 `vnlm` 即可。

* ``vfcvt_b2h.v``    none_tu_preds

.. code-block:: c

    vint16mf4_t __riscv_xl_vfcvt_b2h_v_i16mf4(vint8mf8_t vs2, size_t vl);
    vint16mf2_t __riscv_xl_vfcvt_b2h_v_i16mf2(vint8mf4_t vs2, size_t vl);
    vint16m1_t __riscv_xl_vfcvt_b2h_v_i16m1(vint8mf2_t vs2, size_t vl);
    vint16m2_t __riscv_xl_vfcvt_b2h_v_i16m2(vint8m1_t vs2, size_t vl);
    vint16m4_t __riscv_xl_vfcvt_b2h_v_i16m4(vint8m2_t vs2, size_t vl);
    vint16m8_t __riscv_xl_vfcvt_b2h_v_i16m8(vint8m4_t vs2, size_t vl);

* ``vfcvt_b2w.v`` none_tu_preds

.. code-block:: c

    vint32mf2_t __riscv_xl_vfcvt_b2w_v_i32mf2(vint8mf8_t vs2, size_t vl);
    vint32m1_t __riscv_xl_vfcvt_b2w_v_i32m1(vint8mf4_t vs2, size_t vl);
    vint32m2_t __riscv_xl_vfcvt_b2w_v_i32m2(vint8mf2_t vs2, size_t vl);
    vint32m4_t __riscv_xl_vfcvt_b2w_v_i32m4(vint8m1_t vs2, size_t vl);
    vint32m8_t __riscv_xl_vfcvt_b2w_v_i32m8(vint8m2_t vs2, size_t vl);

* ``vfcvt_h2w.v`` none_tu_preds

.. code-block:: c

    vint32mf2_t __riscv_xl_vfcvt_h2w_v_i32mf2(vint16mf4_t vs2, size_t vl);
    vint32m1_t __riscv_xl_vfcvt_h2w_v_i32m1(vint16mf2_t vs2, size_t vl);
    vint32m2_t __riscv_xl_vfcvt_h2w_v_i32m2(vint16m1_t vs2, size_t vl);
    vint32m4_t __riscv_xl_vfcvt_h2w_v_i32m4(vint16m2_t vs2, size_t vl);
    vint32m8_t __riscv_xl_vfcvt_h2w_v_i32m8(vint16m4_t vs2, size_t vl);

* ``vfcvt_p2c.v`` none_tu_preds

.. code-block:: c

    vint32mf2_t __riscv_xl_vfcvt_p2c_v_i32mf2(vint16mf4_t vs2, size_t vl);
    vint32m1_t __riscv_xl_vfcvt_p2c_v_i32m1(vint16mf2_t vs2, size_t vl);
    vint32m2_t __riscv_xl_vfcvt_p2c_v_i32m2(vint16m1_t vs2, size_t vl);
    vint32m4_t __riscv_xl_vfcvt_p2c_v_i32m4(vint16m2_t vs2, size_t vl);
    vint32m8_t __riscv_xl_vfcvt_p2c_v_i32m8(vint16m4_t vs2, size_t vl);

*  ``vfcvt.h2b.v`` none_tu_preds

.. code-block:: c

    vint8mf8_t __riscv_xl_vfcvt_h2b_v_i8mf8(vint16mf4_t vs2, size_t vl);
    vint8mf4_t __riscv_xl_vfcvt_h2b_v_i8mf4(vint16mf2_t vs2, size_t vl);
    vint8mf2_t __riscv_xl_vfcvt_h2b_v_i8mf2(vint16m1_t vs2, size_t vl);
    vint8m1_t __riscv_xl_vfcvt_h2b_v_i8m1(vint16m2_t vs2, size_t vl);
    vint8m2_t __riscv_xl_vfcvt_h2b_v_i8m2(vint16m4_t vs2, size_t vl);
    vint8m4_t __riscv_xl_vfcvt_h2b_v_i8m4(vint16m8_t vs2, size_t vl);

* ``vfcvt.w2b.v`` none_tu_preds

.. code-block:: c

    vint8mf8_t __riscv_xl_vfcvt_w2b_v_i8mf8(vint32mf2_t vs2, size_t vl);
    vint8mf4_t __riscv_xl_vfcvt_w2b_v_i8mf4(vint32m1_t vs2, size_t vl);
    vint8mf2_t __riscv_xl_vfcvt_w2b_v_i8mf2(vint32m2_t vs2, size_t vl);
    vint8m1_t __riscv_xl_vfcvt_w2b_v_i8m1(vint32m4_t vs2, size_t vl);
    vint8m2_t __riscv_xl_vfcvt_w2b_v_i8m2(vint32m8_t vs2, size_t vl);

* ``vfcvt.w2h.v`` none_tu_preds

.. code-block:: c

    vint16mf4_t __riscv_xl_vfcvt_w2h_v_i16mf4(vint32mf2_t vs2, size_t vl);
    vint16mf2_t __riscv_xl_vfcvt_w2h_v_i16mf2(vint32m1_t vs2, size_t vl);
    vint16m1_t __riscv_xl_vfcvt_w2h_v_i16m1(vint32m2_t vs2, size_t vl);
    vint16m2_t __riscv_xl_vfcvt_w2h_v_i16m2(vint32m4_t vs2, size_t vl);
    vint16m4_t __riscv_xl_vfcvt_w2h_v_i16m4(vint32m8_t vs2, size_t vl);

* ``vfcvt.c2p.v`` none_tu_preds

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

        // tmp值可以不被用到，但是需要有，才能保证vdsmacini指令正常使用，且需要用 volatile 修饰，防止被优化
        volatile vint32m1_t tmp = __riscv_xl_vdsmacini_x_i32m1(1, vl);

        vd = __riscv_xl_vdscmaco_vv_i32m1(vs2, vs1, vl);
        __riscv_vse32_v_i32m1(&dst_cmac[0].i32, vd, vl);
        return 0;
    }
