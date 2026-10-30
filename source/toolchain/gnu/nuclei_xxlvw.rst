.. _toolchain_gnu_nuclei_xxlvw:

Nuclei Custom Xxlvw Extension
================================

Introduction
*************

The RVV 1.0 vector extension is widely used in AI and image processing. However, its basic vector instructions cannot fully meet the demands of wideband wireless signal processing, such as complex-number processing in 4G/5G communications and high-precision fixed-point dynamic scaling. Vector instructions targeting wireless communications therefore need to be added on top of RVV to cover the extensive vector signal-processing requirements of 4G, 5G, and Wi-Fi scenarios.

This instruction set is a complementary extension to RISC-V RVV 1.0, targeting wideband wireless communication signal processing. It is identified by ``w`` (Wireless) and builds upon the base ``V`` extension; in the Nuclei toolchain it is provided as the custom extension ``xxlvw``.

The instructions added for wireless signal processing mainly include:

- Complex-number format conversion instructions
- Fixed-point dynamic scaling operation instructions
- Complex dynamic scaling operation instructions
- Dynamic scaling reduction operation instructions
- Inter-element operation instructions
- Fast non-linear operation instructions
- Format conversion instructions

In this context, "operations" act on the individual elements of a vector; the trip count follows the LMUL and VL rules of the RVV specification; the operand width is controlled by SEW; whether an element participates in the operation is controlled by vm; and the default values of inactive elements are determined by the mask-agnostic and tail-agnostic mechanisms.

This document describes the support for this extension in the Nuclei toolchain, including how to enable it, the supported instructions, and the usage of the corresponding intrinsics. For the detailed definition of the extension, refer to `riscv-vector4wireless-extension <https://github.com/gaoshanlee193/riscv-vector4wireless-extension#introduction>`_.



Extension
*********

Using this extension requires the ``V`` extension and the ``xxlvw`` extension to be enabled. Note that this extension supports RV32 only.

Example: ``-march=rv32imafcv_xxlvw -mabi=ilp32f``

.. attention::

    To use the intrinsics of this extension, the following header file must be included:

    ``#include <riscv_vector.h>``

Supported Instructions
**********************

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

    The format conversion instructions convert between different data widths; they are annotated below as ``sew = input width → output width``. The actual data types of each intrinsic can also be seen from its function signature.

    For detailed information about these instructions, refer to https://github.com/gaoshanlee193/riscv-vector4wireless-extension/blob/Zvw/src/RISCV-Vector-Extension-for-Wireless.adoc

Intrinsic Naming Convention
***************************

RVV intrinsic naming convention: **Chapter 6** of ``v-intrinsic-spec.pdf`` in https://github.com/riscv-non-isa/rvv-intrinsic-doc/releases/tag/v1.0.0-rc7.

Our naming convention follows the above specification and adds the ``_xl`` prefix.

Nuclei Custom Intrinsics
**************************

.. note::

    Example intrinsics are given below for each instruction; for the complete set of intrinsics, derive the names according to the naming convention above.

    In the following, ``sew`` denotes the width of the data types supported by the instruction, and ``full_preds`` denotes the set of suffix forms supported by the intrinsic. ``full`` means that all suffix forms are supported — none (no suffix), _m, _tu, _tum, _tumu, and _mu (six forms in total); ``none_m_preds[none,_m]`` means that only the none and _m forms are supported; ``none_tu_preds`` means that only the none and _tu forms are supported; ``none_preds`` means that only the none (unsuffixed) form is supported.

* ``vcpack.vv``   sew = 32 full_preds

.. code-block:: c

    vint32m1_t __riscv_xl_vcpack_vv_i32m1(vint32m1_t vs2, vint32m1_t vs1, size_t vl);
    vint32m1_t __riscv_xl_vcpack_vv_i32m1_m(vbool32_t vm, vint32m1_t vs2, vint32m1_t vs1, size_t vl);
    vint32m1_t __riscv_xl_vcpack_vv_i32m1_tu(vint32m1_t vd, vint32m1_t vs2, vint32m1_t vs1, size_t vl);
    vint32m1_t __riscv_xl_vcpack_vv_i32m1_tum(vbool32_t vm,vint32m1_t vd, vint32m1_t vs2, vint32m1_t vs1, size_t vl);
    vint32m1_t __riscv_xl_vcpack_vv_i32m1_tumu(vbool32_t vm,vint32m1_t vd, vint32m1_t vs2, vint32m1_t vs1, size_t vl);
    vint32m1_t __riscv_xl_vcpack_vv_i32m1_mu(vbool32_t vm,vint32m1_t vd, vint32m1_t vs2, vint32m1_t vs1, size_t vl);

.. note::

    For the intrinsics of the following instructions, only the full set of none (unsuffixed) intrinsics is listed; construct the other suffix forms according to the rules above.

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

    2025.10 release:

    Although the ``vdsmacini.v`` and ``vdsmacini.s`` instructions have no vd operand, the corresponding intrinsics return a value that must not be ignored.

    At present, the intrinsics of all instructions without a vd operand return a value.

    If the return value is not used by subsequent code, it must be declared ``volatile`` to prevent the optimizer from removing it at -O2 and higher optimization levels.

    2026.10 release:

    For instructions without a vd operand, the intrinsic return value may now be ignored (and used when needed); declaring it ``volatile`` is no longer required. See `Examples`_ for the usage.

* ``vdsmac.vv/vs`` sew = 8/16/32  none_m_preds[none,_m]

.. tip::

    See the intrinsic names listed under ``vdsmul.vv/vs``; simply replace ``vdsmul`` with ``vdsmac``.

* ``vdsmaco.vv/vs`` sew = 8/16/32  full_preds

.. tip::

    As above, simply replace ``vdsmul`` with ``vdsmaco``.

* ``vlsb.v`` sew = 8/16/32  full_preds

.. tip::

    See the intrinsic names listed under ``vdsmacini.v``; simply replace ``vdsmacini`` with ``vlsb``.

* ``vconj.v`` sew = 8/16/32  full_preds

.. tip::

    See the intrinsic names listed under ``vdsmacini.v``; simply replace ``vdsmacini`` with ``vconj``.

* ``vdscmul.vv/vs`` sew = 8/16/32  full_preds

.. tip::

    See the intrinsic names listed under ``vdsmul.vv/vs``; simply replace ``vdsmul`` with ``vdscmul``.

* ``vdscmulj.vv/vs`` sew = 8/16/32  full_preds

.. tip::

    See the intrinsic names listed under ``vdsmul.vv/vs``; simply replace ``vdsmul`` with ``vdscmulj``.

* ``vdscredsum.v`` sew = 8/16/32  full_preds

.. tip::

    See the intrinsic names listed under ``vdsmacini.v``; simply replace ``vdsmacini`` with ``vdscredsum``.

* ``vdscmac.vv/vs`` sew = 8/16/32 none_m_preds[none,_m]

.. tip::

    See the intrinsic names listed under ``vdsmul.vv/vs``; simply replace ``vdsmul`` with ``vdscmac``.

* ``vdscmacj.vv/vs`` sew = 8/16/32 none_m_preds[none,_m]

.. tip::

    See the intrinsic names listed under ``vdsmul.vv/vs``; simply replace ``vdsmul`` with ``vdscmacj``.

* ``vdscmaco.vv/vs`` sew = 8/16/32 full_preds

.. tip::

    See the intrinsic names listed under ``vdsmul.vv/vs``; simply replace ``vdsmul`` with ``vdscmaco``.

* ``vdscmacjo.vv/vs`` sew = 8/16/32 full_preds

.. tip::

    See the intrinsic names listed under ``vdsmul.vv/vs``; simply replace ``vdsmul`` with ``vdscmacjo``.

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

    See the intrinsic names listed under ``vdscmacor.vv/vs``; simply replace ``vdscmacor`` with ``vdscmacoi``.

* ``vdscmacjor.vv/vs`` sew = 32 full_preds

.. tip::

    See the intrinsic names listed under ``vdscmacor.vv/vs``; simply replace ``vdscmacor`` with ``vdscmacjor``.

* ``vdscmacjoi.vv/vs`` sew = 32 full_preds

.. tip::

    See the intrinsic names listed under ``vdscmacor.vv/vs``; simply replace ``vdscmacor`` with ``vdscmacjoi``.

* ``vdscmulr.vv/vs`` sew = 8/16/32 full_preds

.. tip::

    See the intrinsic names listed under ``vdsmul.vv/vs``; simply replace ``vdsmul`` with ``vdscmulr``.

* ``vdscmuli.vv/vs`` sew = 8/16/32 full_preds

.. tip::

    See the intrinsic names listed under ``vdsmul.vv/vs``; simply replace ``vdsmul`` with ``vdscmuli``.

* ``vdscmuljr.vv/vs`` sew = 8/16/32 full_preds

.. tip::

    See the intrinsic names listed under ``vdsmul.vv/vs``; simply replace ``vdsmul`` with ``vdscmuljr``.

* ``vdscmulji.vv/vs`` sew = 8/16/32 full_preds

.. tip::

    See the intrinsic names listed under ``vdsmul.vv/vs``; simply replace ``vdsmul`` with ``vdscmulji``.

* ``vdsredsum.v``  sew = 8/16/32 full_preds

.. tip::

    See the intrinsic names listed under ``vdsmacini.v``; simply replace ``vdsmacini`` with ``vdsredsum``.

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

    See the intrinsic names listed under ``vdsredsumn.vs``; simply replace ``_vx`` with ``_vi``.
    For the ``vdsredsumn.vs/vi`` instructions, the rs1 and uimm values must be integers in the range [1, 2, 3, 4].

* ``vredmaxi.vv`` sew = 8/16/32 full_preds

.. tip::

    See the intrinsic names listed under ``vdsmul.vv``; simply replace ``vdsmul`` with ``vredmaxi``.

* ``vredmini.vv`` sew = 8/16/32 full_preds

.. tip::

    See the intrinsic names listed under ``vdsmul.vv``; simply replace ``vdsmul`` with ``vredmini``.

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

    See the intrinsic names listed under ``vdsmul.vv``; simply replace ``vdsmul`` with ``vfsl``.

* ``vfsr.vv`` sew = 8/16/32 none_tu_preds

.. tip::

    See the intrinsic names listed under ``vdsmul.vv``; simply replace ``vdsmul`` with ``vfsr``.

* ``vlnlp0.v/vlnlp1.v`` sew = 8/16/32 none_preds

The intrinsics of these instructions must satisfy the following relation:

LMUL = 8 when VLEN = 128

LMUL = 4 when VLEN = 256

LMUL = 2 when VLEN = 512

LMUL = 1 when VLEN = 1024

The compiler sets the VLEN value through ``-march=*_zvl${vlen}b``, where ``vlen`` may be {128, 256, 512, 1024, ...}; if it is not specified, the default is 128.

* Intrinsics available with ``_zvl1024b`` (VLEN = 1024):

.. code-block:: c

    vint8m1_t __riscv_xl_vlnlp0_v_i8m1(vint8m1_t vs, size_t vl);

    vint16m1_t __riscv_xl_vlnlp0_v_i16m1(vint16m1_t vs, size_t vl);

    vint32m1_t __riscv_xl_vlnlp0_v_i32m1(vint32m1_t vs, size_t vl);

    vint8m1_t __riscv_xl_vlnlp1_v_i8m1(vint8m1_t vs, size_t vl);

    vint16m1_t __riscv_xl_vlnlp1_v_i16m1(vint16m1_t vs, size_t vl);

    vint32m1_t __riscv_xl_vlnlp1_v_i32m1(vint32m1_t vs, size_t vl);

* Intrinsics available with ``_zvl512b`` (VLEN = 512):

.. code-block:: c

    vint8m2_t __riscv_xl_vlnlp0_v_i8m2(vint8m2_t vs, size_t vl);

    vint16m2_t __riscv_xl_vlnlp0_v_i16m2(vint16m2_t vs, size_t vl);

    vint32m2_t __riscv_xl_vlnlp0_v_i32m2(vint32m2_t vs, size_t vl);

    vint8m2_t __riscv_xl_vlnlp1_v_i8m2(vint8m2_t vs, size_t vl);

    vint16m2_t __riscv_xl_vlnlp1_v_i16m2(vint16m2_t vs, size_t vl);

    vint32m2_t __riscv_xl_vlnlp1_v_i32m2(vint32m2_t vs, size_t vl);

* Intrinsics available with ``_zvl256b`` (VLEN = 256):

.. code-block:: c

    vint8m4_t __riscv_xl_vlnlp0_v_i8m4(vint8m4_t vs, size_t vl);

    vint16m4_t __riscv_xl_vlnlp0_v_i16m4(vint16m4_t vs, size_t vl);

    vint32m4_t __riscv_xl_vlnlp0_v_i32m4(vint32m4_t vs, size_t vl);

    vint8m4_t __riscv_xl_vlnlp1_v_i8m4(vint8m4_t vs, size_t vl);

    vint16m4_t __riscv_xl_vlnlp1_v_i16m4(vint16m4_t vs, size_t vl);

    vint32m4_t __riscv_xl_vlnlp1_v_i32m4(vint32m4_t vs, size_t vl);

* Intrinsics available with ``_zvl128b`` (VLEN = 128):

.. code-block:: c

    vint8m8_t __riscv_xl_vlnlp0_v_i8m8(vint8m8_t vs, size_t vl);

    vint16m8_t __riscv_xl_vlnlp0_v_i16m8(vint16m8_t vs, size_t vl);

    vint32m8_t __riscv_xl_vlnlp0_v_i32m8(vint32m8_t vs, size_t vl);

    vint8m8_t __riscv_xl_vlnlp1_v_i8m8(vint8m8_t vs, size_t vl);

    vint16m8_t __riscv_xl_vlnlp1_v_i16m8(vint16m8_t vs, size_t vl);

    vint32m8_t __riscv_xl_vlnlp1_v_i32m8(vint32m8_t vs, size_t vl);

.. tip::

    When using the above intrinsics, you may encounter an ``unrecognizable insn`` error similar to the following:

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

    This is usually caused by a mismatch between VLEN and the LMUL used by the intrinsic.

* ``vnle.vv/vs`` sew = 8/16/32 full_preds

.. tip::

    See the intrinsic names listed under ``vdsmul.vv/vs``; simply replace ``vdsmul`` with ``vnle``.

* ``vnlm.vv/vs`` sew = 8/16/32 full_preds

.. tip::

    See the intrinsic names listed under ``vdsmul.vv/vs``; simply replace ``vdsmul`` with ``vnlm``.

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

        // vint32m1_t tmp = __riscv_xl_vdsmacini_x_i32m1(1, vl); // Usage when the return value is needed
        __riscv_xl_vdsmacini_x_i32m1(1, vl);

        vd = __riscv_xl_vdscmaco_vv_i32m1(vs2, vs1, vl);
        __riscv_vse32_v_i32m1(&dst_cmac[0].i32, vd, vl);
        return 0;
    }
