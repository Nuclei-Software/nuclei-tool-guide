.. _libncrt_compiler_support_api:

Compiler support API
--------------------

GNU library API
~~~~~~~~~~~~~~~

Integer arithmetic
^^^^^^^^^^^^^^^^^^

+--------------------+-----------------------------------------------------+
| Function           | Description                                         |
+====================+=====================================================+
| :ref:`mulsi3`      | Multiply, signed 32-bit integer.                    |
+--------------------+-----------------------------------------------------+
| :ref:`muldi3`      | Multiply, signed 64-bit integer.                    |
+--------------------+-----------------------------------------------------+
| :ref:`divsi3`      | Divide, signed 32-bit integer.                      |
+--------------------+-----------------------------------------------------+
| :ref:`divdi3`      | Divide, signed 64-bit integer.                      |
+--------------------+-----------------------------------------------------+
| :ref:`udivsi3`     | Divide, unsigned 32-bit integer.                    |
+--------------------+-----------------------------------------------------+
| :ref:`udivdi3`     | Divide, unsigned 64-bit integer.                    |
+--------------------+-----------------------------------------------------+
| :ref:`modsi3`      | Remainder after divide, signed 32-bit integer.      |
+--------------------+-----------------------------------------------------+
| :ref:`moddi3`      | Remainder after divide, signed 64-bit integer.      |
+--------------------+-----------------------------------------------------+
| :ref:`umodsi3`     | Remainder after divide, unsigned 32-bit integer.    |
+--------------------+-----------------------------------------------------+
| :ref:`umoddi3`     | Remainder after divide, unsigned 64-bit integer.    |
+--------------------+-----------------------------------------------------+
| :ref:`udivmodsi4`  | Divide with remainder, unsigned 32-bit integer.     |
+--------------------+-----------------------------------------------------+
| :ref:`udivmoddi4`  | Divide with remainder, unsigned 64-bit integer.     |
+--------------------+-----------------------------------------------------+
| :ref:`clzsi2`      | Count leading zeros, 32-bit integer.                |
+--------------------+-----------------------------------------------------+
| :ref:`clzdi2`      | Count leading zeros, 64-bit integer.                |
+--------------------+-----------------------------------------------------+
| :ref:`ctzsi2`      | Count trailing zeros, 32-bit integer.               |
+--------------------+-----------------------------------------------------+
| :ref:`ctzdi2`      | Count trailing zeros, 64-bit integer.               |
+--------------------+-----------------------------------------------------+
| :ref:`ffssi2`      | Find first set, 32-bit integer.                     |
+--------------------+-----------------------------------------------------+
| :ref:`ffsdi2`      | Find first set, 64-bit integer.                     |
+--------------------+-----------------------------------------------------+
| :ref:`bswapsi2`    | Byte swap, 32-bit integer.                          |
+--------------------+-----------------------------------------------------+
| :ref:`bswapdi2`    | Byte swap, 64-bit integer.                          |
+--------------------+-----------------------------------------------------+
| :ref:`popcountsi2` | Population count, 32-bit integer.                   |
+--------------------+-----------------------------------------------------+
| :ref:`popcountdi2` | Population count, 64-bit integer.                   |
+--------------------+-----------------------------------------------------+
| :ref:`paritysi2`   | Parity, 32-bit integer.                             |
+--------------------+-----------------------------------------------------+
| :ref:`paritydi2`   | Parity, 64-bit integer.                             |
+--------------------+-----------------------------------------------------+

.. _mulsi3:

\__mulsi3()
'''''''''''

Description

Multiply, signed 32-bit integer.

Prototype

::

   __SEGGER_RTL_U32 __mulsi3(__SEGGER_RTL_U32 a,
                             __SEGGER_RTL_U32 b);

Parameters

+-------------------------------+--------------------------------------+
| Parameter                     | Description                          |
+===============================+======================================+
| a                             | Multiplier.                          |
+-------------------------------+--------------------------------------+
| b                             | Multiplicand.                        |
+-------------------------------+--------------------------------------+

Return value

Product.

.. _muldi3:

\__muldi3()
'''''''''''

Description

Multiply, signed 64-bit integer.

Prototype

::

   __SEGGER_RTL_U64 __muldi3(__SEGGER_RTL_U64 a,
                             __SEGGER_RTL_U64 b);

Parameters

+-------------------------------+--------------------------------------+
| Parameter                     | Description                          |
+===============================+======================================+
| a                             | Multiplier.                          |
+-------------------------------+--------------------------------------+
| b                             | Multiplicand.                        |
+-------------------------------+--------------------------------------+

Return value

Product.

.. _divsi3:

\__divsi3()
'''''''''''

Description

Divide, signed 32-bit integer.

Prototype

::

   int32_t __divsi3(int32_t num,
                    int32_t den);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| num                             | Dividend.                          |
+---------------------------------+------------------------------------+
| den                             | Divisor.                           |
+---------------------------------+------------------------------------+

Return value

Quotient.

.. _divdi3:

\__divdi3()
'''''''''''

Description

Divide, signed 64-bit integer.

Prototype

::

   int64_t __divdi3(int64_t num,
                    int64_t den);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| num                             | Dividend.                          |
+---------------------------------+------------------------------------+
| den                             | Divisor.                           |
+---------------------------------+------------------------------------+

Return value

Quotient.

.. _udivsi3:

\__udivsi3()
''''''''''''

Description

Divide, unsigned 32-bit integer.

Prototype

::

   __SEGGER_RTL_U32 __udivsi3(__SEGGER_RTL_U32 num,
                              __SEGGER_RTL_U32 den);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| num                             | Dividend.                          |
+---------------------------------+------------------------------------+
| den                             | Divisor.                           |
+---------------------------------+------------------------------------+

Return value

Quotient.

.. _udivdi3:

\__udivdi3()
''''''''''''

Description

Divide, unsigned 64-bit integer.

Prototype

::

   __SEGGER_RTL_U64 __udivdi3(__SEGGER_RTL_U64 num,
                              __SEGGER_RTL_U64 den);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| num                             | Dividend.                          |
+---------------------------------+------------------------------------+
| den                             | Divisor.                           |
+---------------------------------+------------------------------------+

Return value

Quotient.

.. _modsi3:

\__modsi3()
'''''''''''

Description

Remainder after divide, signed 32-bit integer.

Prototype

::

   int32_t __modsi3(int32_t num,
                    int32_t den);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| num                             | Dividend.                          |
+---------------------------------+------------------------------------+
| den                             | Divisor.                           |
+---------------------------------+------------------------------------+

Return value

Remainder.

.. _moddi3:

\__moddi3()
'''''''''''

Description

Remainder after divide, signed 64-bit integer.

Prototype

::

   int64_t __moddi3(int64_t num,
                    int64_t den);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| num                             | Dividend.                          |
+---------------------------------+------------------------------------+
| den                             | Divisor.                           |
+---------------------------------+------------------------------------+

Return value

Remainder.

.. _umodsi3:

\__umodsi3()
''''''''''''

Description

Remainder after divide, unsigned 32-bit integer.

Prototype

::

   __SEGGER_RTL_U32 __umodsi3(__SEGGER_RTL_U32 num,
                              __SEGGER_RTL_U32 den);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| num                             | Dividend.                          |
+---------------------------------+------------------------------------+
| den                             | Divisor.                           |
+---------------------------------+------------------------------------+

Return value

Remainder.

.. _umoddi3:

\__umoddi3()
''''''''''''

Description

Remainder after divide, unsigned 64-bit integer.

Prototype

::

   __SEGGER_RTL_U64 __umoddi3(__SEGGER_RTL_U64 num,
                              __SEGGER_RTL_U64 den);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| num                             | Dividend.                          |
+---------------------------------+------------------------------------+
| den                             | Divisor.                           |
+---------------------------------+------------------------------------+

Return value

Remainder.

.. _udivmodsi4:

\__udivmodsi4()
'''''''''''''''

Description

Divide with remainder, unsigned 32-bit integer.

Prototype

::

   __SEGGER_RTL_U32 __udivmodsi4(__SEGGER_RTL_U32 num,
                                 __SEGGER_RTL_U32 den,
                                 __SEGGER_RTL_U32 *rem);

Parameters

+--------------+-------------------------------------------------------+
| Parameter    | Description                                           |
+==============+=======================================================+
| num          | Dividend.                                             |
+--------------+-------------------------------------------------------+
| den          | Divisor.                                              |
+--------------+-------------------------------------------------------+
| rem          | Pointer to object that receives the remainder.        |
+--------------+-------------------------------------------------------+

Return value

Quotient.

.. _udivmoddi4:

\__udivmoddi4()
'''''''''''''''

Description

Divide with remainder, unsigned 64-bit integer.

Prototype

::

   __SEGGER_RTL_U64 __udivmoddi4(__SEGGER_RTL_U64 num,
                                 __SEGGER_RTL_U64 den,
                                 __SEGGER_RTL_U64 *rem);

Parameters

+--------------+-------------------------------------------------------+
| Parameter    | Description                                           |
+==============+=======================================================+
| num          | Dividend.                                             |
+--------------+-------------------------------------------------------+
| den          | Divisor.                                              |
+--------------+-------------------------------------------------------+
| rem          | Pointer to object that receives the remainder.        |
+--------------+-------------------------------------------------------+

Return value

Quotient.

.. _clzsi2:

\__clzsi2()
'''''''''''

Description

Count leading zeros, 32-bit integer.

Prototype

::

   int __clzsi2(__SEGGER_RTL_U32 x);

Parameters

+-------------------+--------------------------------------------------+
| Parameter         | Description                                      |
+===================+==================================================+
| x                 | Argument; x must not be zero.                    |
+-------------------+--------------------------------------------------+

Return value

Number of leading zeros in x.

.. _clzdi2:

\__clzdi2()
'''''''''''

Description

Count leading zeros, 64-bit integer.

Prototype

::

   int __clzdi2(__SEGGER_RTL_U64 x);

Parameters

+-------------------+--------------------------------------------------+
| Parameter         | Description                                      |
+===================+==================================================+
| x                 | Argument; x must not be zero.                    |
+-------------------+--------------------------------------------------+

Return value

Number of leading zeros in x.

.. _ctzsi2:

\__ctzsi2()
'''''''''''

Description

Count trailing zeros, 32-bit integer.

Prototype

::

   int __ctzsi2(__SEGGER_RTL_U32 x);

Parameters

+-------------------+--------------------------------------------------+
| Parameter         | Description                                      |
+===================+==================================================+
| x                 | Argument; x must not be zero.                    |
+-------------------+--------------------------------------------------+

Return value

Number of trailing zeros in x.

.. _ctzdi2:

\__ctzdi2()
'''''''''''

Description

Count trailing zeros, 64-bit integer.

Prototype

::

   int __ctzdi2(__SEGGER_RTL_U64 x);

Parameters

+-------------------+--------------------------------------------------+
| Parameter         | Description                                      |
+===================+==================================================+
| x                 | Argument; x must not be zero.                    |
+-------------------+--------------------------------------------------+

Return value

Number of trailing zeros in x.

.. _ffssi2:

\__ffssi2()
'''''''''''

Description

Find first set, 32-bit integer.

Prototype

::

   int __ffssi2(__SEGGER_RTL_U32 x);

Parameters

+-------------------+--------------------------------------------------+
| Parameter         | Description                                      |
+===================+==================================================+
| x                 | Argument; Return value zero if x is zero.        |
+-------------------+--------------------------------------------------+

Return value

The index of the least significant 1-bit in x.

.. _ffsdi2:

\__ffsdi2()
'''''''''''

Description

Find first set, 64-bit integer.

Prototype

::

   int __ffsdi2(__SEGGER_RTL_U64 x);

Parameters

+-------------------+--------------------------------------------------+
| Parameter         | Description                                      |
+===================+==================================================+
| x                 | Argument; Return value zero if x is zero.        |
+-------------------+--------------------------------------------------+

Return value

The index of the least significant 1-bit in x.

.. _bswapsi2:

\__bswapsi2()
'''''''''''''

Description

Byte swap, 32-bit integer.

Prototype

::

   int __bswapsi2(__SEGGER_RTL_U32 x);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Argument.                          |
+---------------------------------+------------------------------------+

Return value

The result of byte swap in x.

.. _bswapdi2:

\__bswapdi2()
'''''''''''''

Description

Byte swap, 64-bit integer.

Prototype

::

   int __bswapdi2(__SEGGER_RTL_U64 x);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Argument.                          |
+---------------------------------+------------------------------------+

Return value

The result of byte swap in x.

.. _popcountsi2:

\__popcountsi2()
''''''''''''''''

Description

Population count, 32-bit integer.

Prototype

::

   int __popcountsi2(__SEGGER_RTL_U32 x);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Argument.                          |
+---------------------------------+------------------------------------+

Return value

Count of number of one bits in x.

.. _popcountdi2:

\__popcountdi2()
''''''''''''''''

Description

Population count, 64-bit integer.

Prototype

::

   int __popcountdi2(__SEGGER_RTL_U64 x);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Argument.                          |
+---------------------------------+------------------------------------+

Return value

Count of number of one bits in x.

.. _paritysi2:

\__paritysi2()
''''''''''''''

Description

Parity, 32-bit integer.

Prototype

::

   int __paritysi2(__SEGGER_RTL_U32 x);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Argument.                          |
+---------------------------------+------------------------------------+

Return value

+-----+----------------------------------------------------------------+
| 1   | number of one bits in x is odd.                                |
+-----+----------------------------------------------------------------+
| 0   | number of one bits in x is even.                               |
+-----+----------------------------------------------------------------+

.. _paritydi2:

\__paritydi2()
''''''''''''''

Description

Parity, 64-bit integer.

Prototype

::

   int __paritydi2(__SEGGER_RTL_U64 x);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Argument.                          |
+---------------------------------+------------------------------------+

Return value

+-----+----------------------------------------------------------------+
| 1   | number of one bits in x is odd.                                |
+-----+----------------------------------------------------------------+
| 0   | number of one bits in x is even.                               |
+-----+----------------------------------------------------------------+

Floating arithmetic
^^^^^^^^^^^^^^^^^^^

+---------------------+------------------------------------------------+
| Function            | Description                                    |
+=====================+================================================+
| :ref:`addsf3`       | Add, float.                                    |
+---------------------+------------------------------------------------+
| :ref:`adddf3`       | Add, double.                                   |
+---------------------+------------------------------------------------+
| :ref:`addtf3`       | Add, long double.                              |
+---------------------+------------------------------------------------+
| :ref:`subsf3`       | Subtract, float.                               |
+---------------------+------------------------------------------------+
| :ref:`subdf3`       | Subtract, double.                              |
+---------------------+------------------------------------------------+
| :ref:`subtf3`       | Subtract, long double.                         |
+---------------------+------------------------------------------------+
| :ref:`mulsf3`       | Multiply, float.                               |
+---------------------+------------------------------------------------+
| :ref:`muldf3`       | Multiply, double.                              |
+---------------------+------------------------------------------------+
| :ref:`multf3`       | Multiply, long double.                         |
+---------------------+------------------------------------------------+
| :ref:`divsf3`       | Divide, float.                                 |
+---------------------+------------------------------------------------+
| :ref:`divdf3`       | Divide, double.                                |
+---------------------+------------------------------------------------+
| :ref:`divtf3`       | Divide, long double.                           |
+---------------------+------------------------------------------------+

.. _addsf3:

\__addsf3()
'''''''''''

Description

Add, float.

Prototype

::

   float __addsf3(float x,
                  float y);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Augend.                            |
+---------------------------------+------------------------------------+
| y                               | Addend.                            |
+---------------------------------+------------------------------------+

Return value

Sum.

.. _adddf3:

\__adddf3()
'''''''''''

Description

Add, double.

Prototype

::

   double __adddf3(double x,
                   double y);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Augend.                            |
+---------------------------------+------------------------------------+
| y                               | Addend.                            |
+---------------------------------+------------------------------------+

Return value

Sum.

.. _addtf3:

\__addtf3()
'''''''''''

Description

Add, long double.

Prototype

::

   long double __addtf3(long double x,
                        long double y);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Augend.                            |
+---------------------------------+------------------------------------+
| y                               | Addend.                            |
+---------------------------------+------------------------------------+

Return value

Sum.

.. _subsf3:

\__subsf3()
'''''''''''

Description

Subtract, float.

Prototype

::

   float __subsf3(float x,
                  float y);

Parameters

+--------------------------------+-------------------------------------+
| Parameter                      | Description                         |
+================================+=====================================+
| x                              | Minuend.                            |
+--------------------------------+-------------------------------------+
| y                              | Subtrahend.                         |
+--------------------------------+-------------------------------------+

Return value

Difference.

.. _subdf3:

\__subdf3()
'''''''''''

Description

Subtract, double.

Prototype

::

   double __subdf3(double x,
                   double y);

Parameters

+--------------------------------+-------------------------------------+
| Parameter                      | Description                         |
+================================+=====================================+
| x                              | Minuend.                            |
+--------------------------------+-------------------------------------+
| y                              | Subtrahend.                         |
+--------------------------------+-------------------------------------+

Return value

Difference.

.. _subtf3:

\__subtf3()
'''''''''''

Description

Subtract, long double.

Prototype

::

   long double __subtf3(long double x,
                        long double y);

Parameters

+--------------------------------+-------------------------------------+
| Parameter                      | Description                         |
+================================+=====================================+
| x                              | Minuend.                            |
+--------------------------------+-------------------------------------+
| y                              | Subtrahend.                         |
+--------------------------------+-------------------------------------+

Return value

Difference.

.. _mulsf3:

\__mulsf3()
'''''''''''

Description

Multiply, float.

Prototype

::

   float __mulsf3(float x,
                  float y);

Parameters

+-------------------------------+--------------------------------------+
| Parameter                     | Description                          |
+===============================+======================================+
| x                             | Multiplicand.                        |
+-------------------------------+--------------------------------------+
| y                             | Multiplier.                          |
+-------------------------------+--------------------------------------+

Return value

Product.

.. _muldf3:

\__muldf3()
'''''''''''

Description

Multiply, double.

Prototype

::

   double __muldf3(double x,
                   double y);

Parameters

+-------------------------------+--------------------------------------+
| Parameter                     | Description                          |
+===============================+======================================+
| x                             | Multiplicand.                        |
+-------------------------------+--------------------------------------+
| y                             | Multiplier.                          |
+-------------------------------+--------------------------------------+

Return value

Product.

.. _multf3:

\__multf3()
'''''''''''

Description

Multiply, long double.

Prototype

::

   long double __multf3(long double x,
                        long double y);

Parameters

+-------------------------------+--------------------------------------+
| Parameter                     | Description                          |
+===============================+======================================+
| x                             | Multiplicand.                        |
+-------------------------------+--------------------------------------+
| y                             | Multiplier.                          |
+-------------------------------+--------------------------------------+

Return value

Product.

.. _divsf3:

\__divsf3()
'''''''''''

Description

Divide, float.

Prototype

::

   float __divsf3(float x,
                  float y);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Dividend.                          |
+---------------------------------+------------------------------------+
| y                               | Divisor.                           |
+---------------------------------+------------------------------------+

Return value

Quotient.

.. _divdf3:

\__divdf3()
'''''''''''

Description

Divide, double.

Prototype

::

   double __divdf3(double x,
                   double y);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Dividend.                          |
+---------------------------------+------------------------------------+
| y                               | Divisor.                           |
+---------------------------------+------------------------------------+

Return value

Quotient.

.. _divtf3:

\__divtf3()
'''''''''''

Description

Divide, long double.

Prototype

::

   long double __divtf3(long double x,
                        long double y);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Dividend.                          |
+---------------------------------+------------------------------------+
| y                               | Divisor.                           |
+---------------------------------+------------------------------------+

Return value

Quotient.

Floating conversions
^^^^^^^^^^^^^^^^^^^^

+-----------------------+----------------------------------------------------+
| Function              | Description                                        |
+=======================+====================================================+
| :ref:`fixsfsi`        | Convert float to int.                              |
+-----------------------+----------------------------------------------------+
| :ref:`fixdfsi`        | Convert double to int.                             |
+-----------------------+----------------------------------------------------+
| :ref:`fixtfsi`        | Convert long double to int.                        |
+-----------------------+----------------------------------------------------+
| :ref:`fixsfdi`        | Convert float to long long.                        |
+-----------------------+----------------------------------------------------+
| :ref:`fixdfdi`        | Convert double to long long.                       |
+-----------------------+----------------------------------------------------+
| :ref:`fixtfdi`        | Convert long double to long long.                  |
+-----------------------+----------------------------------------------------+
| :ref:`fixunssfsi`     | Convert float to unsigned.                         |
+-----------------------+----------------------------------------------------+
| :ref:`fixunsdfsi`     | Convert double to unsigned.                        |
+-----------------------+----------------------------------------------------+
| :ref:`fixunstfsi`     | Convert long double to int.                        |
+-----------------------+----------------------------------------------------+
| :ref:`fixunssfdi`     | Convert float to unsigned long long.               |
+-----------------------+----------------------------------------------------+
| :ref:`fixunsdfdi`     | Convert double to unsigned long long.              |
+-----------------------+----------------------------------------------------+
| :ref:`fixunstfdi`     | Convert long double to unsigned long long.         |
+-----------------------+----------------------------------------------------+
| :ref:`floatsisf`      | Convert int to float.                              |
+-----------------------+----------------------------------------------------+
| :ref:`floatsidf`      | Convert int to double.                             |
+-----------------------+----------------------------------------------------+
| :ref:`floatsitf`      | Convert int to long double.                        |
+-----------------------+----------------------------------------------------+
| :ref:`floatdisf`      | Convert long long to float.                        |
+-----------------------+----------------------------------------------------+
| :ref:`floatdidf`      | Convert long long to double.                       |
+-----------------------+----------------------------------------------------+
| :ref:`floatditf`      | Convert long long to long double.                  |
+-----------------------+----------------------------------------------------+
| :ref:`floatunsisf`    | Convert unsigned to float.                         |
+-----------------------+----------------------------------------------------+
| :ref:`floatunsidf`    | Convert unsigned to double.                        |
+-----------------------+----------------------------------------------------+
| :ref:`floatunsitf`    | Convert unsigned to long double.                   |
+-----------------------+----------------------------------------------------+
| :ref:`floatundisf`    | Convert unsigned long long to float.               |
+-----------------------+----------------------------------------------------+
| :ref:`floatundidf`    | Convert unsigned long long to double.              |
+-----------------------+----------------------------------------------------+
| :ref:`floatunditf`    | Convert unsigned long long to long double.         |
+-----------------------+----------------------------------------------------+
| :ref:`extendsfdf2`    | Extend float to double.                            |
+-----------------------+----------------------------------------------------+
| :ref:`extendsftf2`    | Extend float to long double.                       |
+-----------------------+----------------------------------------------------+
| :ref:`extenddftf2`    | Extend double to long double.                      |
+-----------------------+----------------------------------------------------+
| :ref:`truncdfsf2`     | Truncate double to float.                          |
+-----------------------+----------------------------------------------------+
| :ref:`trunctfsf2`     | Truncate long double to float.                     |
+-----------------------+----------------------------------------------------+
| :ref:`trunctfdf2`     | Truncate long double to double.                    |
+-----------------------+----------------------------------------------------+

.. _fixsfsi:

\__fixsfsi()
''''''''''''

Description

Convert float to int.

Prototype

::

   __SEGGER_RTL_I32 __fixsfsi(float x);

Parameters

+---------------------+------------------------------------------------+
| Parameter           | Description                                    |
+=====================+================================================+
| x                   | Floating value to convert.                     |
+---------------------+------------------------------------------------+

Return value

Integerized value.

.. _fixdfsi:

\__fixdfsi()
''''''''''''

Description

Convert double to int.

Prototype

::

   __SEGGER_RTL_I32 __fixdfsi(double x);

Parameters

+---------------------+------------------------------------------------+
| Parameter           | Description                                    |
+=====================+================================================+
| x                   | Floating value to convert.                     |
+---------------------+------------------------------------------------+

Return value

Integerized value.

.. _fixtfsi:

\__fixtfsi()
''''''''''''

Description

Convert long double to int.

Prototype

::

   __SEGGER_RTL_I32 __fixtfsi(long double x);

Parameters

+---------------------+------------------------------------------------+
| Parameter           | Description                                    |
+=====================+================================================+
| x                   | Floating value to convert.                     |
+---------------------+------------------------------------------------+

Return value

Integerized value.

.. _fixsfdi:

\__fixsfdi()
''''''''''''

Description

Convert float to long long.

Prototype

::

   __SEGGER_RTL_I64 __fixsfdi(float f);

Parameters

+---------------------+------------------------------------------------+
| Parameter           | Description                                    |
+=====================+================================================+
| f                   | Floating value to convert.                     |
+---------------------+------------------------------------------------+

Return value

Integerized value.

Notes

The RV32 compiler converts a float to a 64-bit integer by calling runtime support to handle it.

.. _fixdfdi:

\__fixdfdi()
''''''''''''

Description

Convert double to long long.

Prototype

::

   __SEGGER_RTL_I64 __fixdfdi(double x);

Parameters

+---------------------+------------------------------------------------+
| Parameter           | Description                                    |
+=====================+================================================+
| x                   | Floating value to convert.                     |
+---------------------+------------------------------------------------+

Return value

Integerized value.

Notes

RV32 always calls runtime for double to int64 conversion.

.. _fixtfdi:

\__fixtfdi()
''''''''''''

Description

Convert long double to long long.

Prototype

::

   __SEGGER_RTL_I64 __fixtfdi(long double x);

Parameters

+---------------------+------------------------------------------------+
| Parameter           | Description                                    |
+=====================+================================================+
| x                   | Floating value to convert.                     |
+---------------------+------------------------------------------------+

Return value

Integerized value.

.. _fixunssfsi:

\__fixunssfsi()
'''''''''''''''

Description

Convert float to unsigned.

Prototype

::

   __SEGGER_RTL_U32 __fixunssfsi(float x);

Parameters

+-----------------------+----------------------------------------------+
| Parameter             | Description                                  |
+=======================+==============================================+
| x                     | Float value to convert.                      |
+-----------------------+----------------------------------------------+

Return value

Integerized value.

.. _fixunsdfsi:

\__fixunsdfsi()
'''''''''''''''

Description

Convert double to unsigned.

Prototype

::

   __SEGGER_RTL_U32 __fixunsdfsi(double x);

Parameters

+-----------------------+----------------------------------------------+
| Parameter             | Description                                  |
+=======================+==============================================+
| x                     | Float value to convert.                      |
+-----------------------+----------------------------------------------+

Return value

Integerized value.

.. _fixunstfsi:

\__fixunstfsi()
'''''''''''''''

Description

Convert long double to int.

Prototype

::

   int __fixunstfsi(long double x);

Parameters

+-----------------------+----------------------------------------------+
| Parameter             | Description                                  |
+=======================+==============================================+
| x                     | Float value to convert.                      |
+-----------------------+----------------------------------------------+

Return value

Integerized value.

.. _fixunssfdi:

\__fixunssfdi()
'''''''''''''''

Description

Convert float to unsigned long long.

Prototype

::

   __SEGGER_RTL_U64 __fixunssfdi(float f);

Parameters

+-----------------------+----------------------------------------------+
| Parameter             | Description                                  |
+=======================+==============================================+
| f                     | Float value to convert.                      |
+-----------------------+----------------------------------------------+

Return value

Integerized value.

.. _fixunsdfdi:

\__fixunsdfdi()
'''''''''''''''

Description

Convert double to unsigned long long.

Prototype

::

   __SEGGER_RTL_U64 __fixunsdfdi(double x);

Parameters

+-----------------------+----------------------------------------------+
| Parameter             | Description                                  |
+=======================+==============================================+
| x                     | Float value to convert.                      |
+-----------------------+----------------------------------------------+

Return value

Integerized value.

.. _fixunstfdi:

\__fixunstfdi()
'''''''''''''''

Description

Convert long double to unsigned long long.

Prototype

::

   __SEGGER_RTL_U64 __fixunstfdi(long double x);

Parameters

+-----------------------+----------------------------------------------+
| Parameter             | Description                                  |
+=======================+==============================================+
| x                     | Float value to convert.                      |
+-----------------------+----------------------------------------------+

Return value

Integerized value.

.. _floatsisf:

\__floatsisf()
''''''''''''''

Description

Convert int to float.

Prototype

::

   float __floatsisf(__SEGGER_RTL_I32 x);

Parameters

+----------------------+-----------------------------------------------+
| Parameter            | Description                                   |
+======================+===============================================+
| x                    | Integer value to convert.                     |
+----------------------+-----------------------------------------------+

Return value

Floating value.

.. _floatsidf:

\__floatsidf()
''''''''''''''

Description

Convert int to double.

Prototype

::

   double __floatsidf(__SEGGER_RTL_I32 x);

Parameters

+----------------------+-----------------------------------------------+
| Parameter            | Description                                   |
+======================+===============================================+
| x                    | Integer value to convert.                     |
+----------------------+-----------------------------------------------+

Return value

Floating value.

.. _floatsitf:

\__floatsitf()
''''''''''''''

Description

Convert int to long double.

Prototype

::

   long double __floatsitf(__SEGGER_RTL_I32 x);

Parameters

+----------------------+-----------------------------------------------+
| Parameter            | Description                                   |
+======================+===============================================+
| x                    | Integer value to convert.                     |
+----------------------+-----------------------------------------------+

Return value

Floating value.

.. _floatdisf:

\__floatdisf()
''''''''''''''

Description

Convert long long to float.

Prototype

::

   float __floatdisf(__SEGGER_RTL_I64 x);

Parameters

+----------------------+-----------------------------------------------+
| Parameter            | Description                                   |
+======================+===============================================+
| x                    | Integer value to convert.                     |
+----------------------+-----------------------------------------------+

Return value

Floating value.

.. _floatdidf:

\__floatdidf()
''''''''''''''

Description

Convert long long to double.

Prototype

::

   double __floatdidf(__SEGGER_RTL_I64 x);

Parameters

+----------------------+-----------------------------------------------+
| Parameter            | Description                                   |
+======================+===============================================+
| x                    | Integer value to convert.                     |
+----------------------+-----------------------------------------------+

Return value

Floating value.

.. _floatditf:

\__floatditf()
''''''''''''''

Description

Convert long long to long double.

Prototype

::

   long double __floatditf(__SEGGER_RTL_I64 x);

Parameters

+----------------------+-----------------------------------------------+
| Parameter            | Description                                   |
+======================+===============================================+
| x                    | Integer value to convert.                     |
+----------------------+-----------------------------------------------+

Return value

Floating value.

.. _floatunsisf:

\__floatunsisf()
''''''''''''''''

Description

Convert unsigned to float.

Prototype

::

   float __floatunsisf(__SEGGER_RTL_U32 x);

Parameters

+----------------------+-----------------------------------------------+
| Parameter            | Description                                   |
+======================+===============================================+
| x                    | Integer value to convert.                     |
+----------------------+-----------------------------------------------+

Return value

Floating value.

.. _floatunsidf:

\__floatunsidf()
''''''''''''''''

Description

Convert unsigned to double.

Prototype

::

   double __floatunsidf(__SEGGER_RTL_U32 x);

Parameters

+---------------------+------------------------------------------------+
| Parameter           | Description                                    |
+=====================+================================================+
| x                   | Unsigned value to convert.                     |
+---------------------+------------------------------------------------+

Return value

Double value.

.. _floatunsitf:

\__floatunsitf()
''''''''''''''''

Description

Convert unsigned to long double.

Prototype

::

   long double __floatunsitf(__SEGGER_RTL_U32 x);

Parameters

+---------------------+------------------------------------------------+
| Parameter           | Description                                    |
+=====================+================================================+
| x                   | Unsigned value to convert.                     |
+---------------------+------------------------------------------------+

Return value

Long double value.

.. _floatundisf:

\__floatundisf()
''''''''''''''''

Description

Convert unsigned long long to float.

Prototype

::

   float __floatundisf(__SEGGER_RTL_U64 x);

Parameters

+----------------+-----------------------------------------------------+
| Parameter      | Description                                         |
+================+=====================================================+
| x              | Unsigned long long value to convert.                |
+----------------+-----------------------------------------------------+

Return value

Float value.

.. _floatundidf:

\__floatundidf()
''''''''''''''''

Description

Convert unsigned long long to double.

Prototype

::

   double __floatundidf(__SEGGER_RTL_U64 x);

Parameters

+----------------+-----------------------------------------------------+
| Parameter      | Description                                         |
+================+=====================================================+
| x              | Unsigned long long value to convert.                |
+----------------+-----------------------------------------------------+

Return value

Double value.

.. _floatunditf:

\__floatunditf()
''''''''''''''''

Description

Convert unsigned long long to long double.

Prototype

::

   long double __floatunditf(__SEGGER_RTL_U64 x);

Parameters

+----------------+-----------------------------------------------------+
| Parameter      | Description                                         |
+================+=====================================================+
| x              | Unsigned long long value to convert.                |
+----------------+-----------------------------------------------------+

Return value

Long double value.

.. _extendsfdf2:

\__extendsfdf2()
''''''''''''''''

Description

Extend float to double.

Prototype

::

   double __extendsfdf2(float x);

Parameters

+------------------------+---------------------------------------------+
| Parameter              | Description                                 |
+========================+=============================================+
| x                      | Float value to extend.                      |
+------------------------+---------------------------------------------+

Return value

Double value.

.. _extendsftf2:

\__extendsftf2()
''''''''''''''''

Description

Extend float to long double.

Prototype

::

   long double __extendsftf2(float x);

Parameters

+------------------------+---------------------------------------------+
| Parameter              | Description                                 |
+========================+=============================================+
| x                      | Float value to extend.                      |
+------------------------+---------------------------------------------+

Return value

Double value.

.. _extenddftf2:

\__extenddftf2()
''''''''''''''''

Description

Extend double to long double.

Prototype

::

   long double __extenddftf2(double x);

Parameters

+----------------------+-----------------------------------------------+
| Parameter            | Description                                   |
+======================+===============================================+
| x                    | Double value to extend.                       |
+----------------------+-----------------------------------------------+

Return value

Long double value.

.. _truncdfsf2:

\__truncdfsf2()
'''''''''''''''

Description

Truncate double to float.

Prototype

::

   float __truncdfsf2(double x);

Parameters

+---------------------+------------------------------------------------+
| Parameter           | Description                                    |
+=====================+================================================+
| x                   | Double value to truncate.                      |
+---------------------+------------------------------------------------+

Return value

Float value.

.. _trunctfdf2:

\__trunctfdf2()
'''''''''''''''

Description

Truncate long double to double.

Prototype

::

   double __trunctfdf2(long double x);

Parameters

+-------------------+--------------------------------------------------+
| Parameter         | Description                                      |
+===================+==================================================+
| x                 | Long double value to truncate.                   |
+-------------------+--------------------------------------------------+

Return value

Double value.

.. _trunctfsf2:

\__trunctfsf2()
'''''''''''''''

Description

Truncate long double to float.

Prototype

::

   float __trunctfsf2(long double x);

Parameters

+-------------------+--------------------------------------------------+
| Parameter         | Description                                      |
+===================+==================================================+
| x                 | Long double value to truncate.                   |
+-------------------+--------------------------------------------------+

Return value

Float value.

Floating comparisons
^^^^^^^^^^^^^^^^^^^^

+-------------------+------------------------------------------------------+
| Function          | Description                                          |
+===================+======================================================+
| :ref:`eqsf2`      | Equal, float.                                        |
+-------------------+------------------------------------------------------+
| :ref:`eqdf2`      | Equal, double.                                       |
+-------------------+------------------------------------------------------+
| :ref:`eqtf2`      | Equal, long double.                                  |
+-------------------+------------------------------------------------------+
| :ref:`nesf2`      | Not equal, float.                                    |
+-------------------+------------------------------------------------------+
| :ref:`nedf2`      | Not equal, double.                                   |
+-------------------+------------------------------------------------------+
| :ref:`netf2`      | Not equal, long double.                              |
+-------------------+------------------------------------------------------+
| :ref:`ltsf2`      | Less than, float.                                    |
+-------------------+------------------------------------------------------+
| :ref:`ltdf2`      | Less than, double.                                   |
+-------------------+------------------------------------------------------+
| :ref:`lttf2`      | Less than, long double.                              |
+-------------------+------------------------------------------------------+
| :ref:`lesf2`      | Less than or equal, float.                           |
+-------------------+------------------------------------------------------+
| :ref:`ledf2`      | Less than or equal, double.                          |
+-------------------+------------------------------------------------------+
| :ref:`letf2`      | Less than or equal, long double.                     |
+-------------------+------------------------------------------------------+
| :ref:`gtsf2`      | Greater than, float.                                 |
+-------------------+------------------------------------------------------+
| :ref:`gtdf2`      | Greater than, double.                                |
+-------------------+------------------------------------------------------+
| :ref:`gttf2`      | Greater than, long double.                           |
+-------------------+------------------------------------------------------+
| :ref:`gesf2`      | Greater than or equal, float.                        |
+-------------------+------------------------------------------------------+
| :ref:`gedf2`      | Greater than or equal, double.                       |
+-------------------+------------------------------------------------------+
| :ref:`getf2`      | Greater than or equal, long double.                  |
+-------------------+------------------------------------------------------+

.. _eqsf2:

\__eqsf2()
''''''''''

Description

Equal, float.

Prototype

::

   int __eqsf2(float x,
               float y);

Parameters

+------------------------+---------------------------------------------+
| Parameter              | Description                                 |
+========================+=============================================+
| x                      | Left-hand operand.                          |
+------------------------+---------------------------------------------+
| y                      | Right-hand operand.                         |
+------------------------+---------------------------------------------+

Return value

Return = 0 if both operands are non-NaN and a = b (GNU three-way boolean).

.. _eqdf2:

\__eqdf2()
''''''''''

Description

Equal, double.

Prototype

::

   int __eqdf2(double x,
               double y);

Parameters

+------------------------+---------------------------------------------+
| Parameter              | Description                                 |
+========================+=============================================+
| x                      | Left-hand operand.                          |
+------------------------+---------------------------------------------+
| y                      | Right-hand operand.                         |
+------------------------+---------------------------------------------+

Return value

Return = 0 if both operands are non-NaN and a = b (GNU three-way boolean).

.. _eqtf2:

\__eqtf2()
''''''''''

Description

Equal, long double.

Prototype

::

   int __eqtf2(long double x,
               long double y);

Parameters

+------------------------+---------------------------------------------+
| Parameter              | Description                                 |
+========================+=============================================+
| x                      | Left-hand operand.                          |
+------------------------+---------------------------------------------+
| y                      | Right-hand operand.                         |
+------------------------+---------------------------------------------+

Return value

Return = 0 if both operands are non-NaN and a = b (GNU three-way boolean).

.. _nesf2:

\__nesf2()
''''''''''

Description

Not equal, float.

Prototype

::

   int __nesf2(float x,
               float y);

Parameters

+------------------------+---------------------------------------------+
| Parameter              | Description                                 |
+========================+=============================================+
| x                      | Left-hand operand.                          |
+------------------------+---------------------------------------------+
| y                      | Right-hand operand.                         |
+------------------------+---------------------------------------------+

Return value

Return = 0 if both operands are non-NaN and a = b (GNU three-way boolean).

.. _nedf2:

\__nedf2()
''''''''''

Description

Not equal, double.

Prototype

::

   int __nedf2(double x,
               double y);

Parameters

+------------------------+---------------------------------------------+
| Parameter              | Description                                 |
+========================+=============================================+
| x                      | Left-hand operand.                          |
+------------------------+---------------------------------------------+
| y                      | Right-hand operand.                         |
+------------------------+---------------------------------------------+

Return value

Return = 0 if both operands are non-NaN and a = b (GNU three-way boolean).

.. _netf2:

\__netf2()
''''''''''

Description

Not equal, long double.

Prototype

::

   int __netf2(long double x,
               long double y);

Parameters

+------------------------+---------------------------------------------+
| Parameter              | Description                                 |
+========================+=============================================+
| x                      | Left-hand operand.                          |
+------------------------+---------------------------------------------+
| y                      | Right-hand operand.                         |
+------------------------+---------------------------------------------+

Return value

Return = 0 if both operands are non-NaN and a = b (GNU three-way boolean).

.. _ltsf2:

\__ltsf2()
''''''''''

Description

Less than, float.

Prototype

::

   int __ltsf2(float x,
               float y);

Parameters

+------------------------+---------------------------------------------+
| Parameter              | Description                                 |
+========================+=============================================+
| x                      | Left-hand operand.                          |
+------------------------+---------------------------------------------+
| y                      | Right-hand operand.                         |
+------------------------+---------------------------------------------+

Return value

Return < 0 if both operands are non-NaN and a < b (GNU three-way boolean).

.. _ltdf2:

\__ltdf2()
''''''''''

Description

Less than, double.

Prototype

::

   int __ltdf2(double x,
               double y);

Parameters

+------------------------+---------------------------------------------+
| Parameter              | Description                                 |
+========================+=============================================+
| x                      | Left-hand operand.                          |
+------------------------+---------------------------------------------+
| y                      | Right-hand operand.                         |
+------------------------+---------------------------------------------+

Return value

Return < 0 if both operands are non-NaN and a < b (GNU three-way boolean).

.. _lttf2:

\__lttf2()
''''''''''

Description

Less than, long double.

Prototype

::

   int __lttf2(long double x,
               long double y);

Parameters

+------------------------+---------------------------------------------+
| Parameter              | Description                                 |
+========================+=============================================+
| x                      | Left-hand operand.                          |
+------------------------+---------------------------------------------+
| y                      | Right-hand operand.                         |
+------------------------+---------------------------------------------+

Return value

Return < 0 if both operands are non-NaN and a < b (GNU three-way boolean).

.. _lesf2:

\__lesf2()
''''''''''

Description

Less than or equal, float.

Prototype

::

   int __lesf2(float x,
               float y);

Parameters

+------------------------+---------------------------------------------+
| Parameter              | Description                                 |
+========================+=============================================+
| x                      | Left-hand operand.                          |
+------------------------+---------------------------------------------+
| y                      | Right-hand operand.                         |
+------------------------+---------------------------------------------+

Return value

Return ≤ 0 if both operands are non-NaN and a < b (GNU three-way boolean).

.. _ledf2:

\__ledf2()
''''''''''

Description

Less than or equal, double.

Prototype

::

   int __ledf2(double x,
               double y);

Parameters

+------------------------+---------------------------------------------+
| Parameter              | Description                                 |
+========================+=============================================+
| x                      | Left-hand operand.                          |
+------------------------+---------------------------------------------+
| y                      | Right-hand operand.                         |
+------------------------+---------------------------------------------+

Return value

Return ≤ 0 if both operands are non-NaN and a < b (GNU three-way boolean).

.. _letf2:

\__letf2()
''''''''''

Description

Less than or equal, long double.

Prototype

::

   int __letf2(long double x,
               long double y);

Parameters

+------------------------+---------------------------------------------+
| Parameter              | Description                                 |
+========================+=============================================+
| x                      | Left-hand operand.                          |
+------------------------+---------------------------------------------+
| y                      | Right-hand operand.                         |
+------------------------+---------------------------------------------+

Return value

Return ≤ 0 if both operands are non-NaN and a < b (GNU three-way boolean).

.. _gtsf2:

\__gtsf2()
''''''''''

Description

Greater than, float.

Prototype

::

   int __gtsf2(float x,
               float y);

Parameters

+------------------------+---------------------------------------------+
| Parameter              | Description                                 |
+========================+=============================================+
| x                      | Left-hand operand.                          |
+------------------------+---------------------------------------------+
| y                      | Right-hand operand.                         |
+------------------------+---------------------------------------------+

Return value

Return > 0 if both operands are non-NaN and a > b (GNU three-way boolean).

.. _gtdf2:

\__gtdf2()
''''''''''

Description

Greater than, double.

Prototype

::

   int __gtdf2(double x,
               double y);

Parameters

+------------------------+---------------------------------------------+
| Parameter              | Description                                 |
+========================+=============================================+
| x                      | Left-hand operand.                          |
+------------------------+---------------------------------------------+
| y                      | Right-hand operand.                         |
+------------------------+---------------------------------------------+

Return value

Return > 0 if both operands are non-NaN and a > b (GNU three-way boolean).

.. _gttf2:

\__gttf2()
''''''''''

Description

Greater than, long double.

Prototype

::

   int __gttf2(long double x,
               long double y);

Parameters

+------------------------+---------------------------------------------+
| Parameter              | Description                                 |
+========================+=============================================+
| x                      | Left-hand operand.                          |
+------------------------+---------------------------------------------+
| y                      | Right-hand operand.                         |
+------------------------+---------------------------------------------+

Return value

Return > 0 if both operands are non-NaN and a > b (GNU three-way boolean).

.. _gesf2:

\__gesf2()
''''''''''

Description

Greater than or equal, float.

Prototype

::

   int __gesf2(float x,
               float y);

Parameters

+------------------------+---------------------------------------------+
| Parameter              | Description                                 |
+========================+=============================================+
| x                      | Left-hand operand.                          |
+------------------------+---------------------------------------------+
| y                      | Right-hand operand.                         |
+------------------------+---------------------------------------------+

Return value

Return ≥ 0 if both operands are non-NaN and a ≥ b (GNU three-way boolean).

.. _gedf2:

\__gedf2()
''''''''''

Description

Greater than or equal, double.

Prototype

::

   int __gedf2(double x,
               double y);

Parameters

+------------------------+---------------------------------------------+
| Parameter              | Description                                 |
+========================+=============================================+
| x                      | Left-hand operand.                          |
+------------------------+---------------------------------------------+
| y                      | Right-hand operand.                         |
+------------------------+---------------------------------------------+

Return value

Return ≥ 0 if both operands are non-NaN and a ≥ b (GNU three-way boolean).

.. _getf2:

\__getf2()
''''''''''

Description

Greater than or equal, long double.

Prototype

::

   int __getf2(long double x,
               long double y);

Parameters

+------------------------+---------------------------------------------+
| Parameter              | Description                                 |
+========================+=============================================+
| x                      | Left-hand operand.                          |
+------------------------+---------------------------------------------+
| y                      | Right-hand operand.                         |
+------------------------+---------------------------------------------+

Return value

Return ≥ 0 if both operands are non-NaN and a ≥ b (GNU three-way boolean).
