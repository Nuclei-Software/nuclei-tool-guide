.. _toolchain_gnu_nuclei_bf16:

Nuclei Custom BFloat16 Extension
====================================

Introduction
**************

Matrix computations in machine learning and AI applications often require high throughput but relatively low precision. The traditional 32-bit floating-point format (FP32) imposes clear bottlenecks on both storage and computation speed, resulting in low efficiency and wasted resources. BF16 (Brain Floating-Point 16), an emerging 16-bit data type, offers a better balance between computational performance and precision, making it well suited to these applications.

To date, however, upstream RISC-V support for BF16 covers only a subset of conversion instructions and vector multiply-accumulate instructions, which falls far short of the complete requirements for applying BF16 to artificial intelligence, machine learning, and similar scenarios.

To close this gap, the Nuclei GCC toolchain, developed in close coordination with the Nuclei hardware design, maintains compatibility with the upstream BF16 instructions while providing full support for BF16 arithmetic and conversion operations, unlocking the potential of BF16 for a wide range of high-performance computing scenarios.


Register Configuration
**********************

Bit 1 (``fp16mode``) of the hardware custom register ``mmisc_ctl1`` controls the data format stored in the 16-bit FPU registers:

- **fp16mode = 0**: fp16 mode

- **fp16mode = 1**: bf16 mode

Therefore, before using the Nuclei BF16 arithmetic operations, the ``fp16mode`` bit in ``mmisc_ctl1`` must be set to 1.

.. note::
    The Nuclei BF16 arithmetic operations reuse the fp16 instructions; this switch determines whether they execute in fp16 or bf16 mode.

The register configuration code is shown below:

.. code-block:: c

    #include "nuclei_sdk_soc.h" // This header file must be included

    __RV_CSR_SET(CSR_MFP16MODE, 0x1); // Enable Nuclei BF16

    __RV_CSR_CLEAR(CSR_MFP16MODE, 0x1); // Disable Nuclei BF16


BF16 Scalar Support
*******************

Extension
+++++++++

Nuclei BF16 scalar arithmetic requires the ``xxlfbf`` extension to be enabled.

Example: ``-march=rv64imafdc_xxlfbf``

Supported Instructions
++++++++++++++++++++++

* ``fadd.h/fsub.h/fmul.h/fdiv.h``
* ``fmadd.h/fmsub.h/fnmadd.h/fnmsub.h``
* ``fsqrt.h``
* ``fcvt.bf16.s/fcvt.s.bf16`` (compatible with the instructions of the Zfbfmin extension)
* ``fcvt.h.d/fcvt.d.h`` (added in the 2025.10 release)
* ``fcvt.h.w[u]/fcvt.w[u].h`` (int32 <---> bf16)
* ``fcvt.h.l[u]/fcvt.l[u].h`` (int64 <---> bf16)
* ``fmin.h/fmax.h``
* ``flt.h/fle.h/feq.h``
* ``fclass.h``

Examples
+++++++++

.. code-block:: c
   :caption: Basic arithmetic on scalar BF16 values

   #include <stdio.h>
   #include "nuclei_sdk_soc.h"

    __bf16 a = 1.11;
    __bf16 b = 11.8;
    const __bf16 c = 10.3;

    void test_add(){
        __bf16 sum = a + b;
        printf("%f\n",sum);
    }

    void test_sub(){
        __bf16 sum = a-c;
        printf("%f\n",sum);
    }

    void test_mul(){
        __bf16 sum = a * 5;
        printf("%f\n",sum);
    }

    void test_div(){
        __bf16 sum = a/(__bf16)3.5;
        printf("%f\n",sum);
    }

    int main(void)
    {
        __RV_CSR_SET(CSR_MFP16MODE, 0x1);
        test_add();
        test_sub();
        test_mul();
        test_div();

        return 0;
    }

BF16 Vector Support (RVV Intrinsics)
************************************

Extension
+++++++++

The Nuclei BF16 RVV intrinsics require the ``V`` extension and the ``xxlvfbf`` extension to be enabled.

Example: ``-march=rv64imafdcv_xxlvfbf``

Nuclei BF16 RVV Intrinsic Naming Scheme
+++++++++++++++++++++++++++++++++++++++++

RVV intrinsic naming convention: **Chapter 6** of ``v-intrinsic-spec.pdf`` in `rvv-intrinsic-doc`_.

Our naming convention follows the above specification, with the additional prefix ``_xl`` to distinguish our custom intrinsics. For example, the intrinsic for the float16 ``vfadd`` operation is named:

``vfloat16mf4_t __riscv_vfadd_vv_f16mf4(vfloat16mf4_t vs2, vfloat16mf4_t vs1, size_t vl);``

``vfloat16mf4_t``  data type of vfloat16

``__riscv_``       intrinsic name prefix

``vfadd``          name of the operation performed by the intrinsic (vector addition in this case)

``vv``             operand types of the operation (``v`` denotes a vector type; see the RVV intrinsic naming convention above for details)

``f16``            abbreviation of the float16 data type

``mf4``            LMUL value

Nuclei custom bfloat16 intrinsics follow the same RVV intrinsic naming convention, with an additional prefix, as shown below:

``vbfloat16mf4_t __riscv_xl_vfadd_vv_bf16mf4(vbfloat16mf4_t vs2, vbfloat16mf4_t vs1, size_t vl);``

``vbfloat16mf4_t``  data type of vbfloat16

``__riscv_xl_``     prefix for Nuclei custom intrinsics

``vfadd``           name of the operation performed by the intrinsic

``vv``              operand types of the operation

``bf16``            abbreviation of the bfloat16 data type

``mf4``             LMUL value

.. note::
    For the vector data types of bfloat16, refer to `vector-bfloat16-spec.adoc`_.


RVV Instructions Supported by Nuclei BF16
+++++++++++++++++++++++++++++++++++++++++

Nuclei Custom Instructions
##########################

* Vector Single-Width Floating-Point Add/Subtract Instructions
    - ``vfadd.vv/vfadd.vf``
    - ``vfsub.vv/vfsub.vf``
    - ``vfrsub.vf``
* Vector Widening Floating-Point Add/Subtract Instructions
    - ``vfwadd.vv/vfwadd.vf``
    - ``vfwsub.vv/vfwsub.vf``
    - ``vfwadd.wv/vfwadd.wf``
    - ``vfwsub.wv/vfwsub.wf``
* Vector Single-Width Floating-Point Multiply/Divide Instructions
    - ``vfmul.vv/vfmul.vf``
    - ``vfdiv.vv/vfdiv.vf``
    - ``vfrdiv.vf``
* Vector Widening Floating-Point Multiply
    - ``vfwmul.vv/vfwmul.vf``
* Vector Single-Width Floating-Point Fused Multiply-Add Instructions
    - ``vfmacc.vv/vfmacc.vf``
    - ``vfnmacc.vv/vfnmacc.vf``
    - ``vfmsac.vv/vfmsac.vf``
    - ``vfnmsac.vv/vfnmsac.vf``
    - ``vfmadd.vv/vfmadd.vf``
    - ``vfnmadd.vv/vfnmadd.vf``
    - ``vfmsub.vv/vfmsub.vf``
    - ``vfnmsub.vv/vfnmsub.vf``
* Vector Widening Floating-Point Fused Multiply-Add Instructions
    - ``vfwmacc.vv/vfwmacc.vf``
    - ``vfwnmacc.vv/vfwnmacc.vf``
    - ``vfwmsac.vv/vfwmsac.vf``
    - ``vfwnmsac.vv/vfwnmsac.vf``
* Vector Floating-Point Square-Root Instruction
    - ``vfsqrt.v``
* Vector Floating-Point Reciprocal Square-Root Estimate Instruction
    - ``vfrsqrt7.v``
* Vector Floating-Point Reciprocal Estimate Instruction
    - ``vfrec7.v``
* Vector Floating-Point MIN/MAX Instructions
    - ``vfmin.vv/vfmin.vf``
    - ``vfmax.vv/vfmax.vf``
* Vector Floating-Point Sign-Injection Instructions
    - ``vfsgnj.vv/vfsgnj.vf``
    - ``vfsgnjn.vv/vfsgnjn.vf``
    - ``vfsgnjx.vv/vfsgnjx.vf``
* Vector Floating-Point Compare Instructions
    - ``vmfeq.vv/vmfeq.vf``
    - ``vmfne.vv/vmfne.vf``
    - ``vmflt.vv/vmflt.vf``
    - ``vmfle.vv/vmfle.vf``
    - ``vmfgt.vf``
    - ``vmfge.vf``
* Vector Floating-Point Classify Instruction
    - ``vfclass.v``
* Vector Floating-Point Merge Instruction
    - ``vfmerge.vfm``
* Vector Floating-Point Move Instruction
    - ``vmv.v``
    - ``vfmv.v``
* Single-Width Floating-Point/Integer Type-Convert Instructions
    - ``vfcvt.xu.f.v``
    - ``vfcvt.x.f.v``
    - ``vfcvt.rtz.xu.f.v``
    - ``vfcvt.rtz.x.f.v``
    - ``vfcvt.f.xu.v``
    - ``vfcvt.f.x.v``
* Widening Floating-Point/Integer Type-Convert Instructions
    - ``vfwcvt.xu.f.v``
    - ``vfwcvt.x.f.v``
    - ``vfwcvt.rtz.xu.f.v``
    - ``vfwcvt.rtz.x.f.v``
    - ``vfwcvt.f.xu.v``
    - ``vfwcvt.f.x.v``
    - ``vfwcvt.f.f.v``
* Narrowing Floating-Point/Integer Type-Convert Instructions
    - ``vfncvt.xu.f.w``
    - ``vfncvt.x.f.w``
    - ``vfncvt.rtz.xu.f.w``
    - ``vfncvt.rtz.x.f.w``
    - ``vfncvt.f.xu.w``
    - ``vfncvt.f.x.w``
    - ``vfncvt.f.f.w``
    - ``vfncvt.rod.f.f.w``
* Vector Single-Width Floating-Point Reduction Instructions
    - ``vfredosum.vs``
    - ``vfredusum.vs``
    - ``vfredmax.vs``
    - ``vfredmin.vs``
* Vector Widening Floating-Point Reduction Instructions
    - ``vfwredosum.vs``
    - ``vfwredusum.vs``
* Vector Slideup Instructions
    - ``vslideup.vx``
* Vector Slidedown Instructions
    - ``vslidedown.vx``
* Vector Floating-Point Slide1up Instruction
    - ``vfslide1up.vf``
* Vector Floating-Point Slide1down Instruction
    - ``vfslide1down.vf``
* Vector Register Gather Instructions
    - ``vrgather.vv``
    - ``vrgatherei16.vv``
* Vector Compress Instruction
    - ``vcompress.vm``

Instructions Compatible with Upstream
#####################################

* Vector Unit-Stride Load Intrinsics
    - ``vle16.v``
* Vector Unit-Stride Store Intrinsics
    - ``vse16.v``
* Vector Strided Load Intrinsics
    - ``vlse16.v``
* Vector Strided Store Intrinsics
    - ``vsse16.v``
* Vector Indexed Load Intrinsics
    - ``vloxei[8/16/32/64].v``
    - ``vluxei[8/16/32/64].v``
* Vector Indexed Store Intrinsics
    - ``vsoxei[8/16/32/64].v``
    - ``vsuxei[8/16/32/64].v``
* Unit-stride Fault-Only-First Loads Intrinsics
    - ``vle16ff.v``
* Vector Unit-Stride Segment Load Intrinsics
    - ``vlseg[2-8]e16.v``
    - ``vlseg[2-8]e16ff.v``
* Vector Unit-Stride Segment Store Intrinsics
    - ``vsseg[2-8]e16.v``
* Vector Strided Segment Load Intrinsics
    - ``vlsseg[2-8]e16.v``
* Vector Strided Segment Store Intrinsics
    - ``vssseg[2-8]e16.v``
* Vector Indexed Segment Load Intrinsics
    - ``vloxseg[2-8]ei8.v``
    - ``vloxseg[2-8]ei16.v``
    - ``vloxseg[2-8]ei32.v``
    - ``vloxseg[2-8]ei64.v``
    - ``vluxseg[2-8]ei8.v``
    - ``vluxseg[2-8]ei16.v``
    - ``vluxseg[2-8]ei32.v``
    - ``vluxseg[2-8]ei64.v``
* Vector Indexed Segment Store Intrinsics
    - ``vsoxseg[2-8]ei8.v``
    - ``vsoxseg[2-8]ei16.v``
    - ``vsoxseg[2-8]ei32.v``
    - ``vsoxseg[2-8]ei64.v``
    - ``vsuxseg[2-8]ei8.v``
    - ``vsuxseg[2-8]ei16.v``
    - ``vsuxseg[2-8]ei32.v``
    - ``vsuxseg[2-8]ei64.v``

.. note::

    2025.02 release:

    The custom Xxlvfbf extension is incompatible with the Zvfbfmin and Zvfbfwma extensions defined in `riscv-bfloat16 release v1.0`_ (``riscv-bfloat16.pdf``). Their functionality is implemented by the ``vfncvt.f.f.w``, ``vfwcvt.f.f.v``, and ``vfwmacc.vv/vfwmacc.vf`` instructions; when using these operations, refer to the intrinsics of the corresponding instructions.

    If the Zvfbfmin/Zvfbfwma intrinsics are required, they must be used separately, i.e., without the Xxlvfbf extension.

    When both are present, the Zvfbfmin/Zvfbfwma intrinsics are mapped to ``vfncvt.f.f.w``, ``vfwcvt.f.f.v``, and ``vfwmacc.vv/vfwmacc.vf``, which may produce incorrect results.

    2025.10 release:

    The custom Xxlvfbf extension is now compatible with the Zvfbfmin and Zvfbfwma extensions.

    The intrinsics of the Zvfbfmin and Zvfbfwma extensions can be used correctly under Xxlvfbf and are properly mapped to the instructions defined by those extensions: ``vfncvtbf16.f.f.w``, ``vfwcvtbf16.f.f.v``, and ``vfwmaccbf16.vv/vfwmaccbf16.vf``. They can be used together with our custom intrinsics without producing errors.

RVV Intrinsics Supported by Nuclei BF16
+++++++++++++++++++++++++++++++++++++++


Nuclei Custom Intrinsics
##########################

Refer to **Appendix A** of ``v-intrinsic-spec.pdf`` in `rvv-intrinsic-doc`_.

The RVV intrinsics corresponding to the Nuclei custom instructions differ from the float16 RVV intrinsics in the above document only in their names; see `Nuclei BF16 RVV Intrinsic Naming Scheme`_ for details.

.. note::

    Currently only Appendix A is fully supported; the intrinsics in Appendices B, C, and D have not yet been fully tested.

Example:

* Vector Single-Width Floating-Point Add/Subtract Instructions

    - Float16

        ``vfloat16mf4_t __riscv_vfadd_vv_f16mf4(vfloat16mf4_t vs2, vfloat16mf4_t vs1, size_t vl);``

        ``vfloat16mf4_t __riscv_vfadd_vv_f16mf4_m(vbool64_t vm, vfloat16mf4_t vs2, vfloat16mf4_t vs1, size_t vl);``

    - Nuclei Bfloat16

        ``vbfloat16mf4_t __riscv_xl_vfadd_vv_bf16mf4(vbfloat16mf4_t vs2, vbfloat16mf4_t vs1, size_t vl);``

        ``vbfloat16mf4_t __riscv_xl_vfadd_vv_bf16mf4_m(vbool64_t vm, vbfloat16mf4_t vs2, vbfloat16mf4_t vs1, size_t vl);``

* Vector Widening Floating-Point Add/Subtract Instructions

    - Float16

        ``vfloat32mf2_t __riscv_vfwadd_vf_f32mf2(vfloat16mf4_t vs2, _Float16 rs1, size_t vl);``

    - Nuclei Bfloat16

        ``vfloat32mf2_t __riscv_xl_vfwadd_vf_f32mf2(vbfloat16mf4_t vs2, __bf16 rs1, size_t vl);``

Intrinsics Compatible with Upstream
###################################

The naming of these intrinsics also differs from that of the float16 RVV intrinsics in **Appendix A** of ``v-intrinsic-spec.pdf`` in `rvv-intrinsic-doc`_ only in the names themselves. To obtain the corresponding names, simply replace the float16 data types with the bfloat16 data types.

Example:

* Vector Unit-Stride Load Intrinsics

    - Float16

        ``vfloat16mf4_t __riscv_vle16_v_f16mf4(const _Float16 *rs1, size_t vl);``

    - Bfloat16

        ``vbfloat16mf4_t __riscv_vle16_v_bf16mf4(const __bf16 *rs1, size_t vl);``

For the detailed intrinsic APIs, refer to `bfloat16 intrinsic_funcs`_.

.. note::

    1. The intrinsics of some upstream-supported instructions are not listed in `bfloat16 intrinsic_funcs`_, but they remain available for use, as follows:

    * Vector Indexed Load Intrinsics
        - ``vloxei[8/32/64].v``
        - ``vluxei[8/32/64].v``
    * Vector Indexed Store Intrinsics
        - ``vsoxei[8/32/64].v``
        - ``vsuxei[8/32/64].v``
    * Vector Indexed Segment Load Intrinsics
        - ``vloxseg[2-8]ei8.v``
        - ``vloxseg[2-8]ei32.v``
        - ``vloxseg[2-8]ei64.v``
        - ``vluxseg[2-8]ei8.v``
        - ``vluxseg[2-8]ei32.v``
        - ``vluxseg[2-8]ei64.v``
    * Vector Indexed Segment Store Intrinsics
        - ``vsoxseg[2-8]ei8.v``
        - ``vsoxseg[2-8]ei32.v``
        - ``vsoxseg[2-8]ei64.v``
        - ``vsuxseg[2-8]ei8.v``
        - ``vsuxseg[2-8]ei32.v``
        - ``vsuxseg[2-8]ei64.v``

    For the corresponding intrinsic names, refer to `Intrinsics Compatible with Upstream`_.

    2. In `bfloat16 intrinsic_funcs`_, the following items in ``03_bfloat16_arithmetic_intrinsics.adoc``:

    * Vector BFloat16 Move Intrinsics

    * Vector BFloat16 Merge Intrinsics

    have been redefined by Nuclei BFloat16; when using them, refer to `Nuclei Custom Intrinsics`_.

Examples
+++++++++

.. attention::
    After completing the register configuration, the following header file must also be included to use the Nuclei BF16 RVV intrinsics:

    ``#include <riscv_vector.h>``

.. code-block:: c
   :caption: An implementation of the add function using Nuclei BFloat16 RVV intrinsics.

    #include <stdio.h>
    #include "nuclei_sdk_soc.h"
    #include <riscv_vector.h>

    void csr_set_bf16_mode(void)
    {
        __RV_CSR_SET(CSR_MFP16MODE, 0x1);
    } // Enable Nuclei BF16


    void csr_clr_bf16_mode(void)
    {
        __RV_CSR_CLEAR(CSR_MFP16MODE, 0x1);
    } // Disable Nuclei BF16

    typedef __bf16 bfloat16_t;

    void Add_bfloat16_rvv(bfloat16_t *pSrcA, bfloat16_t *pSrcB, bfloat16_t *pDst, uint32_t blockSize)
    {
        size_t blkCnt = blockSize; /* Loop counter */
        size_t vl;
        vbfloat16m1_t vx, vy;
        for (; (vl = __riscv_vsetvl_e16m1(blkCnt)) > 0; blkCnt -= vl) {
            vx = __riscv_vle16_v_bf16m1(pSrcA, vl);
            vy = __riscv_vle16_v_bf16m1(pSrcB, vl);
            pSrcA += vl;
            pSrcB += vl;
            __riscv_vse16_v_bf16m1(pDst, __riscv_xl_vfadd_vv_bf16m1(vx, vy, vl), vl);
            pDst += vl;
        }
    }


    int main()
    {
        csr_set_bf16_mode();
        bfloat16_t SrcA[8] = {5.312, 5.312, 5.312, 5.312, 5.312, 5.312, 5.312, 5.312};
        bfloat16_t SrcB[8] = {5.312, 5.312, 5.312, 5.312, 5.312, 5.312, 5.312, 5.312};
        bfloat16_t Dst[8];

        Add_bfloat16_rvv(SrcA, SrcB, Dst, 8);

        printf("Dst[3] = %f\n", (float)Dst[3]);

        csr_clr_bf16_mode();

        return 0;
    }


.. _rvv-intrinsic-doc: https://github.com/riscv-non-isa/rvv-intrinsic-doc/releases/tag/v1.0-ratified
.. _vector-bfloat16-spec.adoc: https://github.com/riscv-non-isa/rvv-intrinsic-doc/blob/9328aba3fca494717de08502ff32819a7c168daa/doc/vector-bfloat16-spec.adoc
.. _bfloat16 intrinsic_funcs: https://github.com/riscv-non-isa/rvv-intrinsic-doc/tree/9328aba3fca494717de08502ff32819a7c168daa/auto-generated/bfloat16/intrinsic_funcs
.. _riscv-bfloat16 release v1.0: https://github.com/riscv/riscv-bfloat16/releases
