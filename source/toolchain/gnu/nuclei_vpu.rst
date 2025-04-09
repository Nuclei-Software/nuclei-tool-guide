.. _toolchain_gnu_nuclei_vpu:

Nuclei Custom VPU Extension
===========================

Introduction
*************

为了加快矩阵运算,Nuclei GCC 工具链添加了自定义的VPU 扩展 ``Xxlvqmacc``, 引入了整数矩阵乘加指令,可以将8位整数输入值扩展为32位。

扩展
*****

使用该扩展时,需要打开 ``V`` 扩展和 ``xxlvqmacc`` 扩展

示例：`-march=rv64imafdcv_xxlvqmacc`

.. attention::

    使用该扩展的相关 intrinsic 时，需要添加以下头文件:

    ``#include<riscv_vector.h>``

支持的指令
**********

* ``xl.vqmacc.vv``
* ``xl.vqmaccu.vv``
* ``xl.vqmaccus.vv``
* ``xl.vqmaccsu.vv``

.. note::

    这些指令是有符号或无符号整数矩阵乘加指令，可将 8 位整数输入值扩展至 32 位。

    为了更好的理解这些指令的功能,示例如下:

    # Dest (C) += Input (A) * Input (B)

    int32 += int8   *  int8     //xl.vqmacc.vv vd, vs2, vs1

    int32 += uint8  *  uint8     //xl.vqmaccu.vv vd, vs2, vs1

    int32 += uint8  *  int8     //xl.vqmaccus.vv vd, vs2, vs1

    int32 += int8   *  uint8     //xl.vqmaccsu.vv vd, vs2, vs1

    其中(u)int8 矩阵 A 和 B 和 int32 矩阵 C 均为 4x4。

    这些指令的设计旨在高效地处理8位整数的矩阵运算,同时通过扩展到32位来避免中间结果的溢出。

intrinsic 命名规则    
*******************

rvv intrinsic 命名规则: https://github.com/riscv-non-isa/rvv-intrinsic-doc/releases/tag/v1.0.0-rc7 ``v-intrinsic-spec.pdf``-> **Chapter 6**.

我们的命名规则遵循上述的命名规则,并在此基础上为了区分我们自定义的intrinsic,对名字进行了一些更改。示例如下:

``vint32m1_t __riscv_xl_vqmacc_4x4x4_i32m1(vint32m1_t vd, vint8m1_t vs1, vint8mf4_t vs2, size_t vl);``

``vint32m1_t`` int32_t的数据类型

``__riscv_xl`` Nuclei 自定义 intrinsic 名称前缀

``vqmacc`` intrinsic 所代表的操作的名字

``4x4x4``  输入输出矩阵的维度,输入矩阵A是 ``4x4``,输入矩阵B是 ``4x4``,输出矩阵C是 ``4x4``

``i32``    int32 数据类型的缩写

``m1``     lmul的值

Nuclei 自定义的 intrinsic
**************************

* ``xl.vqmacc.vv``

.. code-block:: c

    vint32m1_t __riscv_xl_vqmacc_4x4x4_i32m1(vint32m1_t vd, vint8m1_t vs1, vint8mf4_t vs2, size_t vl);
    vint32m2_t __riscv_xl_vqmacc_4x4x4_i32m2(vint32m2_t vd, vint8m1_t vs1, vint8mf2_t vs2, size_t vl);
    vint32m4_t __riscv_xl_vqmacc_4x4x4_i32m4(vint32m4_t vd, vint8m1_t vs1, vint8m1_t vs2, size_t vl);
    vint32m8_t __riscv_xl_vqmacc_4x4x4_i32m8(vint32m8_t vd, vint8m1_t vs1, vint8m2_t vs2, size_t vl);
    vint32m1_t __riscv_xl_vqmacc_4x4x4(vint32m1_t vd, vint8m1_t vs1, vint8mf4_t vs2, size_t vl);
    vint32m2_t __riscv_xl_vqmacc_4x4x4(vint32m2_t vd, vint8m1_t vs1, vint8mf2_t vs2, size_t vl);
    vint32m4_t __riscv_xl_vqmacc_4x4x4(vint32m4_t vd, vint8m1_t vs1, vint8m1_t vs2, size_t vl);
    vint32m8_t __riscv_xl_vqmacc_4x4x4(vint32m8_t vd, vint8m1_t vs1, vint8m2_t vs2, size_t vl);
    vint32m1_t __riscv_xl_vqmacc_4x4x4_i32m1_tu(vint32m1_t vd, vint8m1_t vs1, vint8mf4_t vs2, size_t vl);
    vint32m2_t __riscv_xl_vqmacc_4x4x4_i32m2_tu(vint32m2_t vd, vint8m1_t vs1, vint8mf2_t vs2, size_t vl);
    vint32m4_t __riscv_xl_vqmacc_4x4x4_i32m4_tu(vint32m4_t vd, vint8m1_t vs1, vint8m1_t vs2, size_t vl);
    vint32m8_t __riscv_xl_vqmacc_4x4x4_i32m8_tu(vint32m8_t vd, vint8m1_t vs1, vint8m2_t vs2, size_t vl);
    vint32m1_t __riscv_xl_vqmacc_4x4x4_tu(vint32m1_t vd, vint8m1_t vs1, vint8mf4_t vs2, size_t vl);
    vint32m2_t __riscv_xl_vqmacc_4x4x4_tu(vint32m2_t vd, vint8m1_t vs1, vint8mf2_t vs2, size_t vl);
    vint32m4_t __riscv_xl_vqmacc_4x4x4_tu(vint32m4_t vd, vint8m1_t vs1, vint8m1_t vs2, size_t vl);
    vint32m8_t __riscv_xl_vqmacc_4x4x4_tu(vint32m8_t vd, vint8m1_t vs1, vint8m2_t vs2, size_t vl);

* ``xl.vqmaccu.vv``

.. code-block:: c

    vint32m1_t __riscv_xl_vqmaccu_4x4x4_i32m1(vint32m1_t vd, vuint8m1_t vs1, vuint8mf4_t vs2, size_t vl);
    vint32m2_t __riscv_xl_vqmaccu_4x4x4_i32m2(vint32m2_t vd, vuint8m1_t vs1, vuint8mf2_t vs2, size_t vl);
    vint32m4_t __riscv_xl_vqmaccu_4x4x4_i32m4(vint32m4_t vd, vuint8m1_t vs1, vuint8m1_t vs2, size_t vl);
    vint32m8_t __riscv_xl_vqmaccu_4x4x4_i32m8(vint32m8_t vd, vuint8m1_t vs1, vuint8m2_t vs2, size_t vl);
    vint32m1_t __riscv_xl_vqmaccu_4x4x4(vint32m1_t vd, vuint8m1_t vs1, vuint8mf4_t vs2, size_t vl);
    vint32m2_t __riscv_xl_vqmaccu_4x4x4(vint32m2_t vd, vuint8m1_t vs1, vuint8mf2_t vs2, size_t vl);
    vint32m4_t __riscv_xl_vqmaccu_4x4x4(vint32m4_t vd, vuint8m1_t vs1, vuint8m1_t vs2, size_t vl);
    vint32m8_t __riscv_xl_vqmaccu_4x4x4(vint32m8_t vd, vuint8m1_t vs1, vuint8m2_t vs2, size_t vl);
    vint32m1_t __riscv_xl_vqmaccu_4x4x4_i32m1_tu(vint32m1_t vd, vuint8m1_t vs1, vuint8mf4_t vs2, size_t vl);
    vint32m2_t __riscv_xl_vqmaccu_4x4x4_i32m2_tu(vint32m2_t vd, vuint8m1_t vs1, vuint8mf2_t vs2, size_t vl);
    vint32m4_t __riscv_xl_vqmaccu_4x4x4_i32m4_tu(vint32m4_t vd, vuint8m1_t vs1, vuint8m1_t vs2, size_t vl);
    vint32m8_t __riscv_xl_vqmaccu_4x4x4_i32m8_tu(vint32m8_t vd, vuint8m1_t vs1, vuint8m2_t vs2, size_t vl);
    vint32m1_t __riscv_xl_vqmaccu_4x4x4_tu(vint32m1_t vd, vuint8m1_t vs1, vuint8mf4_t vs2, size_t vl);
    vint32m2_t __riscv_xl_vqmaccu_4x4x4_tu(vint32m2_t vd, vuint8m1_t vs1, vuint8mf2_t vs2, size_t vl);
    vint32m4_t __riscv_xl_vqmaccu_4x4x4_tu(vint32m4_t vd, vuint8m1_t vs1, vuint8m1_t vs2, size_t vl);
    vint32m8_t __riscv_xl_vqmaccu_4x4x4_tu(vint32m8_t vd, vuint8m1_t vs1, vuint8m2_t vs2, size_t vl);

* ``xl.vqmaccus.vv``

.. code-block:: c

    vint32m1_t __riscv_xl_vqmaccus_4x4x4_i32m1(vint32m1_t vd, vuint8m1_t vs1, vint8mf4_t vs2, size_t vl);
    vint32m2_t __riscv_xl_vqmaccus_4x4x4_i32m2(vint32m2_t vd, vuint8m1_t vs1, vint8mf2_t vs2, size_t vl);
    vint32m4_t __riscv_xl_vqmaccus_4x4x4_i32m4(vint32m4_t vd, vuint8m1_t vs1, vint8m1_t vs2, size_t vl);
    vint32m8_t __riscv_xl_vqmaccus_4x4x4_i32m8(vint32m8_t vd, vuint8m1_t vs1, vint8m2_t vs2, size_t vl);
    vint32m1_t __riscv_xl_vqmaccus_4x4x4(vint32m1_t vd, vuint8m1_t vs1, vint8mf4_t vs2, size_t vl);
    vint32m2_t __riscv_xl_vqmaccus_4x4x4(vint32m2_t vd, vuint8m1_t vs1, vint8mf2_t vs2, size_t vl);
    vint32m4_t __riscv_xl_vqmaccus_4x4x4(vint32m4_t vd, vuint8m1_t vs1, vint8m1_t vs2, size_t vl);
    vint32m8_t __riscv_xl_vqmaccus_4x4x4(vint32m8_t vd, vuint8m1_t vs1, vint8m2_t vs2, size_t vl);
    vint32m1_t __riscv_xl_vqmaccus_4x4x4_i32m1_tu(vint32m1_t vd, vuint8m1_t vs1, vint8mf4_t vs2, size_t vl);
    vint32m2_t __riscv_xl_vqmaccus_4x4x4_i32m2_tu(vint32m2_t vd, vuint8m1_t vs1, vint8mf2_t vs2, size_t vl);
    vint32m4_t __riscv_xl_vqmaccus_4x4x4_i32m4_tu(vint32m4_t vd, vuint8m1_t vs1, vint8m1_t vs2, size_t vl);
    vint32m8_t __riscv_xl_vqmaccus_4x4x4_i32m8_tu(vint32m8_t vd, vuint8m1_t vs1, vint8m2_t vs2, size_t vl);
    vint32m1_t __riscv_xl_vqmaccus_4x4x4_tu(vint32m1_t vd, vuint8m1_t vs1, vint8mf4_t vs2, size_t vl);
    vint32m2_t __riscv_xl_vqmaccus_4x4x4_tu(vint32m2_t vd, vuint8m1_t vs1, vint8mf2_t vs2, size_t vl);
    vint32m4_t __riscv_xl_vqmaccus_4x4x4_tu(vint32m4_t vd, vuint8m1_t vs1, vint8m1_t vs2, size_t vl);
    vint32m8_t __riscv_xl_vqmaccus_4x4x4_tu(vint32m8_t vd, vuint8m1_t vs1, vint8m2_t vs2, size_t vl);

* ``xl.vqmaccsu.vv``

.. code-block:: c

    vint32m1_t __riscv_xl_vqmaccsu_4x4x4_i32m1(vint32m1_t vd, vint8m1_t vs1, vuint8mf4_t vs2, size_t vl);
    vint32m2_t __riscv_xl_vqmaccsu_4x4x4_i32m2(vint32m2_t vd, vint8m1_t vs1, vuint8mf2_t vs2, size_t vl);
    vint32m4_t __riscv_xl_vqmaccsu_4x4x4_i32m4(vint32m4_t vd, vint8m1_t vs1, vuint8m1_t vs2, size_t vl);
    vint32m8_t __riscv_xl_vqmaccsu_4x4x4_i32m8(vint32m8_t vd, vint8m1_t vs1, vuint8m2_t vs2, size_t vl);
    vint32m1_t __riscv_xl_vqmaccsu_4x4x4(vint32m1_t vd, vint8m1_t vs1, vuint8mf4_t vs2, size_t vl);
    vint32m2_t __riscv_xl_vqmaccsu_4x4x4(vint32m2_t vd, vint8m1_t vs1, vuint8mf2_t vs2, size_t vl);
    vint32m4_t __riscv_xl_vqmaccsu_4x4x4(vint32m4_t vd, vint8m1_t vs1, vuint8m1_t vs2, size_t vl);
    vint32m8_t __riscv_xl_vqmaccsu_4x4x4(vint32m8_t vd, vint8m1_t vs1, vuint8m2_t vs2, size_t vl);
    vint32m1_t __riscv_xl_vqmaccsu_4x4x4_i32m1_tu(vint32m1_t vd, vint8m1_t vs1, vuint8mf4_t vs2, size_t vl);
    vint32m2_t __riscv_xl_vqmaccsu_4x4x4_i32m2_tu(vint32m2_t vd, vint8m1_t vs1, vuint8mf2_t vs2, size_t vl);
    vint32m4_t __riscv_xl_vqmaccsu_4x4x4_i32m4_tu(vint32m4_t vd, vint8m1_t vs1, vuint8m1_t vs2, size_t vl);
    vint32m8_t __riscv_xl_vqmaccsu_4x4x4_i32m8_tu(vint32m8_t vd, vint8m1_t vs1, vuint8m2_t vs2, size_t vl);
    vint32m1_t __riscv_xl_vqmaccsu_4x4x4_tu(vint32m1_t vd, vint8m1_t vs1, vuint8mf4_t vs2, size_t vl);
    vint32m2_t __riscv_xl_vqmaccsu_4x4x4_tu(vint32m2_t vd, vint8m1_t vs1, vuint8mf2_t vs2, size_t vl);
    vint32m4_t __riscv_xl_vqmaccsu_4x4x4_tu(vint32m4_t vd, vint8m1_t vs1, vuint8m1_t vs2, size_t vl);
    vint32m8_t __riscv_xl_vqmaccsu_4x4x4_tu(vint32m8_t vd, vint8m1_t vs1, vuint8m2_t vs2, size_t vl);

Examples
**********

.. code-block:: c 
    :caption: xl.vqmacc.vv 所对应的intrinsic函数使用样例

    #include <stdio.h>
    #include <riscv_vector.h>


    #define MATRIX_SIZE (4 * 4)
    #define ARRAY_CNT   (4)
    #define DATA_CNT    (ARRAY_CNT * MATRIX_SIZE)

    /* Case dose matrix multiply-add like below:
    *   C[j] += A * B[j], for j in [0, vl/16)
    */

    void normal_case(int8_t *addr_in1, int8_t *addr_in2, int32_t *addr_out, int32_t data_cnt)
    {
        int8_t *pin1 = addr_in1;
        int8_t *pin2 = addr_in2;
        int32_t *pout = addr_out;
        int sum;
        int array_cnt = 0;
    
        while (data_cnt)
        {
            for (int32_t ii = 0; ii < 4; ii++)
            {
                for (int32_t jj = 0; jj < 4; jj++)
                {
                    sum = 0;
                    for (int32_t kk = 0; kk < 4; kk++)
                    {
                        sum += pin1[ii * 4 + kk] * pin2[kk * 4 + jj];
                    }
                    pout[ii * 4 + jj] += sum;
                }
            }
            pin2 += 16;
            pout += 16;
            data_cnt -= 16;
        }
    }

    void vpu_case(int8_t *addr_in1, int8_t *addr_in2, int32_t *addr_out, int32_t data_cnt)
    {
        int8_t *pin1 = addr_in1;
        int8_t *pin2 = addr_in2;
        int32_t *pout = addr_out;
        size_t vl;

        vint8m1_t vin1;
        vint8m2_t vin2;
        vint32m8_t vout;
        for (; (vl = __riscv_vsetvl_e8m1(data_cnt)) > 0; data_cnt -= vl) {
            vin1 = __riscv_vle8_v_i8m1(pin1, vl);
            vin2 = __riscv_vle8_v_i8m2(pin2, vl);
            vout = __riscv_vle32_v_i32m8(pout, vl);
            vout = __riscv_xl_vqmacc_4x4x4_i32m8(vout, vin1, vin2, vl);
            __riscv_vse32_v_i32m8(pout, vout, vl);
            pin2 += vl;
            pout += vl;
        }
    }

    int compare_result(int32_t* normal_out, int32_t* vpu_out, int32_t data_cnt)
    {
        int i, ret = 0;

        for (i = 0; i < data_cnt; i++) {
            if (normal_out[i] != vpu_out[i]) {
                printf("num %d not match: %d vs %d\r\n", i, normal_out[i], vpu_out[i]);
                ret = -1;
            }
        }
        return ret;
    }


    int main(void)
    {
        int ret = 0;

        int8_t Input_A[MATRIX_SIZE] = {0};
        int8_t Input_B[DATA_CNT] = {0};
        int32_t Dest_C1[DATA_CNT] = {0};
        int32_t Dest_C2[DATA_CNT] = {0};


        printf("1. Arrays Init\r\n");
        // Input_A
        for (int i = 0; i < MATRIX_SIZE; i++) {
            Input_A[i] = i;
        }

        // Input_B, Dest_C1, Dest_C2
        for (int i = 0; i < ARRAY_CNT; i++) {
            for (int j = 0; j < MATRIX_SIZE; j++) {
                Input_B[i * 16 + j] = j * 2;
            }
        }

        printf("TEST xl.vqmacc\r\n");

        printf("2. Do normal matrix multiply-add\r\n");
        normal_case(Input_A, Input_B, Dest_C1, DATA_CNT);

        printf("3. Do vpu matrix multiply-add\r\n");
        vpu_case(Input_A, Input_B, Dest_C2, DATA_CNT);

        printf("4. Compare results: ");
        if (compare_result(Dest_C1, Dest_C2, DATA_CNT) == 0) {
            printf("PASS\r\n");
        } else {
            printf("FAIL\r\n");
            ret = 1;
        }


        return ret;
    }
