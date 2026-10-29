.. _toolchain_gnu_nuclei_vpu:

Nuclei Custom VPU Extension
===========================

Introduction
*************

To accelerate matrix computations, the Nuclei GCC toolchain provides the custom VPU extension ``Xxlvqmacc``, which introduces integer matrix multiply-accumulate instructions that widen 8-bit integer input values to 32 bits.

Extension
*************

Using this extension requires the ``V`` extension and the ``xxlvqmacc`` extension to be enabled.

Example: ``-march=rv64imafdcv_xxlvqmacc``

.. attention::

    To use the intrinsics of this extension, the following header file must be included:

    ``#include <riscv_vector.h>``

Supported Instructions
**********************

* ``xl.vqmacc.vv``
* ``xl.vqmaccu.vv``
* ``xl.vqmaccus.vv``
* ``xl.vqmaccsu.vv``

.. note::

    These instructions perform signed or unsigned integer matrix multiply-accumulate operations and widen 8-bit integer inputs to 32 bits.

    Their functionality is illustrated by the following examples:

    # Dest (C) += Input (A) * Input (B)

    int32 += int8   *  int8     //xl.vqmacc.vv vd, vs2, vs1

    int32 += uint8  *  uint8     //xl.vqmaccu.vv vd, vs2, vs1

    int32 += uint8  *  int8     //xl.vqmaccus.vv vd, vs2, vs1

    int32 += int8   *  uint8     //xl.vqmaccsu.vv vd, vs2, vs1

    where the (u)int8 matrices A and B and the int32 matrix C are all 4x4.

    These instructions are designed to process 8-bit integer matrix operations efficiently while preventing overflow of intermediate results through widening to 32 bits.

Intrinsic Naming Convention
***************************

RVV intrinsic naming convention: **Chapter 6** of ``v-intrinsic-spec.pdf`` in https://github.com/riscv-non-isa/rvv-intrinsic-doc/releases/tag/v1.0.0-rc7.

Our naming convention follows the above specification with some modifications to distinguish our custom intrinsics. For example:

``vint32m1_t __riscv_xl_vqmacc_4x4x4_i32m1(vint32m1_t vd, vint8m1_t vs1, vint8mf4_t vs2, size_t vl);``

``vint32m1_t``   data type of int32_t

``__riscv_xl``   prefix for Nuclei custom intrinsics

``vqmacc``       name of the operation performed by the intrinsic

``4x4x4``        dimensions of the input/output matrices: input matrix A is ``4x4``, input matrix B is ``4x4``, and output matrix C is ``4x4``

``i32``          abbreviation of the int32 data type

``m1``           LMUL value

Nuclei Custom Intrinsics
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
    :caption: Example of using the intrinsic functions corresponding to ``xl.vqmacc.vv``

    #include <stdio.h>
    #include <riscv_vector.h>


    #define MATRIX_SIZE (4 * 4)
    #define ARRAY_CNT   (4)
    #define DATA_CNT    (ARRAY_CNT * MATRIX_SIZE)

    /* Case does matrix multiply-add like below:
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
