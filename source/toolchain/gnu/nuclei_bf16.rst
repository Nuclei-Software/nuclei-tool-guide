.. _toolchain_gnu_nuclei_bf16:

Nuclei Custom BFloat16 Extension
====================================

Introduction
**************

在众多机器学习与人工智能应用中，矩阵计算往往对精度的要求并不高，但计算量却极为庞大。传统的 32 位浮点数(FP32)在存储和计算速度方面存在明显瓶颈，不仅效率低下，还造成了资源的浪费。而 BF16(Brain Floating-Point 16)作为一种新兴的 16 位数据类型，能够在计算性能与精度之间取得更优的平衡，从而更好地满足这些应用的需求。

然而，目前 RISC-V 上游仅支持了 BF16 的部分转换指令和向量乘加指令，这远远无法满足将 BF16 应用于人工智能、机器学习等场景的完整需求。

为了填补这一空白, Nuclei GCC 工具链与 Nuclei 硬件设计紧密配合，在兼容上游已支持的 BF16 指令的基础上，全面支持了 BF16 相关的运算及转换操作，充分发挥了 BF16 的潜力，使其能够更好地服务于各类高性能计算场景。


寄存器配置
***********

硬件自定义寄存器mmisc_ctl1的第1位为fp16mode来控制16位FPU寄存器中存储数据的格式:

- **fp16mode = 0**: fp16 mode

- **fp16mode = 1**: bf16 mode

所以在使用Nuclei bf16的运算操作时, 需要先将mmisc_ctl1的寄存器fp16mode位置为1

.. note::
    Nuclei bf16的运算操作,复用的是fp16的相关指令,这里的开关是用来决定复用的指令是做fp16运算还是bf16运算.

设置代码如下：

.. code-block:: c

    #include "nuclei_sdk_soc.h" //需要包含该头文件

    __RV_CSR_SET(CSR_MFP16MODE, 0x1); //打开Nuclei bf16

    __RV_CSR_CLEAR(CSR_MFP16MODE, 0x1); //关闭Nuclei bf16


BF16 标量的支持
****************

扩展
++++++

Nuclei bf16 标量的运算操作,需要开启 ``xxlfbf`` 扩展.

示例：`-march=rv64imafdc_xxlfbf`

支持的指令
+++++++++++

* ``fadd.h/fsub.h/fmul.h/fdiv.h``
* ``fmadd.h/fmsub.h/fnmadd.h/fnmsub.h``
* ``fsqrt.h``
* ``fcvt.bf16.s/fcvt.s.bf16`` (兼容zfbfmin扩展的指令)
* ``fcvt.h.w[u]/fcvt.w[u].h`` (int32 <---> bf16)
* ``fcvt.h.l[u]/fcvt.l[u].h`` (int64 <---> bf16)
* ``fmin.h/fmax.h``
* ``flt.h/fle.h/feq.h``
* ``fclass.h``

Examples
+++++++++

.. code-block:: c
   :caption: 标量bf16 的加减乘除运算

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

BF16 向量的支持(rvv intrinsic)
********************************

扩展
+++++

Nuclei bf16 rvv intrinsic的使用,需要开启 ``V`` 扩展以及 ``xxlvfbf`` 扩展.

示例：`-march=rv64imafdcv_xxlvfbf`

Nuclei bf16 rvv intrinsic nameing scheme
+++++++++++++++++++++++++++++++++++++++++

rvv intrinsic 命名规则: https://github.com/riscv-non-isa/rvv-intrinsic-doc/releases/tag/v1.0.0-rc7 ``v-intrinsic-spec.pdf``-> **Chapter 6**.

我们的命名规则遵循上述的命名规则,并在此基础上为了区分我们自定义的intrinsic,在前缀处添加了 ``_xl`` 示例如下：

float16的vfadd运算的intrinsic 命名：

``vfloat16mf4_t __riscv_vfadd_vv_f16mf4(vfloat16mf4_t vs2, vfloat16mf4_t vs1, size_t vl);``

``vfloat16mf4_t`` vfloat16的数据类型

``__riscv_``      intrinsic 名称前缀

``vfadd``         intrinsic 所代表的操作的名字（此处为向量的加法运算）

``vv``            intrinsic 函数所代表的操作的操作数类型(v代表向量类型,详细信息查看上述rvv intrinsic 命令规则)

``f16``           float16 数据类型的缩写

``mf4``           lmul的值

Nuclei 自定义的bfloat16 intrinsic 也遵循rvv intrinsic 命名的基础规则，只是添加了前缀，如下：

``vbfloat16mf4_t __riscv_xl_vfadd_vv_bf16mf4(vbfloat16mf4_t vs2, vbfloat16mf4_t vs1, size_t vl);``

``vbfloat16mf4_t`` vbfloat16的数据类型

``__riscv_xl_``    Nuclei 自定义 intrinsic 名称前缀

``vfadd``          intrinsic 所代表的操作的名字

``vv``             intrinsic 函数所代表的操作的操作数类型

``bf16``           bfloat16 数据类型的缩写

``mf4``            lmul的值

.. note::
    bfloat16 的向量数据类型,参考 `vector-bfloat16-spec.adoc <https://github.com/riscv-non-isa/rvv-intrinsic-doc/blob/9328aba3fca494717de08502ff32819a7c168daa/doc/vector-bfloat16-spec.adoc>`_.


Nuclei bf16 支持的rvv 指令
+++++++++++++++++++++++++++

Nuclei 自定义的指令
####################

* Vector Single-Width Floating-Point Add/Subtract Instructions
    - ``vfadd.vv/vfadd.vf``
    - ``vfsub.vv/vfsub.vf``
    - ``vfrsub.vf``
* Vector Widening Floating-Point Add/Subtract Instructions
    - ``vfwadd.vv/vfwadd.vf``
    - ``vfwsub.vv/vfwsub.vf``
    - ``vfwadd.wv/vfwadd.vf``
    - ``vfwsub.wv/vfwsub.vf``
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
    - ``vfsqrt7.v``
* Vector Floating-Point Reciprocal Estimate Instruction
    - ``vfrec7.c``
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

与上游兼容的指令
#################

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
    Zvfbfmin、Zvfbfwma 扩展支持的指令 https://github.com/riscv/riscv-bfloat16/releases ``riscv-bfloat16.pdf`` 和我们自定义的Xxlvfbf扩展不兼容.

    其功能已在vfncvt.f.f.w、vfncvt.f.f.f、vfwmacc.vv/vfwmacc.vf中实现.

Nuclei bf16 支持的rvv intrinsic
++++++++++++++++++++++++++++++++++++


Nuclei 自定义的 intrinsic
##########################

参考 https://github.com/riscv-non-isa/rvv-intrinsic-doc/releases/tag/v1.0.0-rc7 ``v-intrinsic-spec.pdf`` -> **Appendix A**.

Nuclei 自定义支持的指令所对应的rvv intrinsic,与上述文档中float16对应的rvv intrinsic只有名字的区别,区别请参考 `Nuclei bf16 rvv intrinsic nameing scheme`_

.. note::

    目前只全面支持Appendix A, Appendix B、C、D中的intrinsic暂时未全面覆盖测试.

示例：

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

与上游兼容的intrinsic
######################

这部分intrinsic 所对应的命名与 https://github.com/riscv-non-isa/rvv-intrinsic-doc/releases/tag/v1.0.0-rc7 ``v-intrinsic-spec.pdf`` -> **Appendix A** 文档中float16对应的rvv intrinsic也只有名字的区别.

区别只需要将float16相关数据类型替换为bfloat16数据类型

示例:

* Vector Unit-Stride Load Intrinsics

    - Float16

        ``vfloat16mf4_t __riscv_vle16_v_f16mf4(const _Float16 *rs1, size_t vl);``

    - Bfloat16

        ``vbfloat16mf4_t __riscv_vle16_v_bf16mf4(const __bf16 *rs1, size_t vl);``

详细的intrinsic api 可参考 `bfloat16 intrinsic_funcs <https://github.com/riscv-non-isa/rvv-intrinsic-doc/tree/9328aba3fca494717de08502ff32819a7c168daa/auto-generated/bfloat16/intrinsic_funcs>`_.

.. note::

    1、部分上游支持的指令对应的 intrinsic `bfloat16 intrinsic_funcs <https://github.com/riscv-non-isa/rvv-intrinsic-doc/tree/9328aba3fca494717de08502ff32819a7c168daa/auto-generated/bfloat16/intrinsic_funcs>`_ 中并未全部列出,但依然可以使用,具体如下:

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

    对应的 intrisic 名字请参考 `与上游兼容的intrinsic`_

    2、 上述bfloat16 intrinsic_funcs `03_bfloat16_arithmetic_intrinsics.adoc <https://github.com/riscv-non-isa/rvv-intrinsic-doc/blob/9328aba3fca494717de08502ff32819a7c168daa/auto-generated/bfloat16/intrinsic_funcs/03_bfloat16_arithmetic_intrinsics.adoc>`_ 文件中的

    * Vector BFloat16 Move Intrinsics

    * Vector BFloat16 Merge Intrinsics

    已被Nuclei BFloat16 重新定义,使用时请参考 `Nuclei 自定义的 intrinsic`_

Examples
+++++++++

.. attention::
    使用Nuclei bf16 rvv intrinsic 需要在配置寄存器的基础上添加以下头文件:

    ``#include<riscv_vector.h>``

.. code-block:: c
   :caption: An implementation of the add function Nuclei Bfloat16 RVV intrinsics.

    #include <stdio.h>
    #include "nuclei_sdk_soc.h"
    #include <riscv_vector.h>

    void csr_set_bf16_mode(void)
    {
        __RV_CSR_SET(CSR_MFP16MODE, 0x1);
    } //打开nuclei bf16


    void csr_clr_bf16_mode(void)
    {
        __RV_CSR_CLEAR(CSR_MFP16MODE, 0x1);
    } //关闭nuclei bf16

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
