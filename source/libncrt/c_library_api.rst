.. _libncrt_c_library_api:

C library API
-------------

<assert.h>
~~~~~~~~~~

Assertion functions
^^^^^^^^^^^^^^^^^^^

+--------------------------+-------------------------------------------+
| Function                 | Description                               |
+==========================+===========================================+
| assert                   | Place assertion.                          |
+--------------------------+-------------------------------------------+

assert
''''''

Description

Place assertion.

Definition

::

   #define assert(e)    ...

Additional information

If NDEBUG is defined as a macro name at the point in the source file where <assert.h> is included, the assert() macro is defined as:

::

   #define assert(ignore) ((void)0)    ...

If NDEBUG is not defined as a macro name at the point in the source file where <assert.h> is included, the assert() macro expands to a void expression that calls \__SEGGER_RTL_X_assert().

When such an assert is executed and e is false, assert() calls the function \__SEGGER_RTL_X_assert() with information about the particular call that failed: the text of the argument, the name of the source file, and the source line number. These are the stringized expression and the values of the preprocessing macros \__FILE\_\_ and \__LINE\_\_.

Notes

The assert() macro is redefined according to the current state of NDEBUG each time that <assert.h> is included.

<complex.h>
~~~~~~~~~~~

``Nuclei C Runtime Library`` provides complex math library functions, including all of those required by ISO C99. These functions are implemented to balance performance with correctness. Because producing the correctly rounded result may be prohibitively expensive, these functions are designed to efficiently produce a close approximation to the correctly rounded result. In most cases, the result produced is within +/-1 ulp of the correctly rounded result, though there may be cases where there is greater inaccuracy.

Manipulation functions
^^^^^^^^^^^^^^^^^^^^^^

+-------------+--------------------------------------------------------+
| Function    | Description                                            |
+=============+========================================================+
| `cabs()`_   | Compute magnitude, double complex.                     |
+-------------+--------------------------------------------------------+
| `cabsf()`_  | Compute magnitude, float complex.                      |
+-------------+--------------------------------------------------------+
| `cabsl()`_  | Compute magnitude, long double complex.                |
+-------------+--------------------------------------------------------+
| `carg()`_   | Compute phase, double complex.                         |
+-------------+--------------------------------------------------------+
| `cargf()`_  | Compute phase, float complex.                          |
+-------------+--------------------------------------------------------+
| `cargl()`_  | Compute phase, long double complex.                    |
+-------------+--------------------------------------------------------+
| `cimag()`_  | Imaginary part, double complex.                        |
+-------------+--------------------------------------------------------+
| `cimagf()`_ | Imaginary part, float complex.                         |
+-------------+--------------------------------------------------------+
| `cimagl()`_ | Imaginary part, long double complex.                   |
+-------------+--------------------------------------------------------+
| `creal()`_  | Real part, double complex.                             |
+-------------+--------------------------------------------------------+
| `crealf()`_ | Real part, float complex.                              |
+-------------+--------------------------------------------------------+
| `creall()`_ | Real part, long double complex.                        |
+-------------+--------------------------------------------------------+
| `cproj()`_  | Project, double complex.                               |
+-------------+--------------------------------------------------------+
| `cprojf()`_ | Project, float complex.                                |
+-------------+--------------------------------------------------------+
| `cprojl()`_ | Project, long double complex.                          |
+-------------+--------------------------------------------------------+
| `conj()`_   | Conjugate, double complex.                             |
+-------------+--------------------------------------------------------+
| `conjf()`_  | Conjugate, float complex.                              |
+-------------+--------------------------------------------------------+
| `conjl()`_  | Conjugate, long double complex.                        |
+-------------+--------------------------------------------------------+

cabs()
''''''

Description

Compute magnitude, double complex.

Prototype

::

   double cabs(__SEGGER_RTL_FLOAT64_C_COMPLEX x);

Parameters

+------------------+---------------------------------------------------+
| Parameter        | Description                                       |
+==================+===================================================+
| x                | Value to compute magnitude of.                    |
+------------------+---------------------------------------------------+

Return value

The magnitude of x, \|x\|.

cabsf()
'''''''

Description

Compute magnitude, float complex.

Prototype

::

   float cabsf(__SEGGER_RTL_FLOAT32_C_COMPLEX x);

Parameters

+------------------+---------------------------------------------------+
| Parameter        | Description                                       |
+==================+===================================================+
| x                | Value to compute magnitude of.                    |
+------------------+---------------------------------------------------+

Return value

The magnitude of x, \|x\|.

cabsl()
'''''''

Description

Compute magnitude, long double complex.

Prototype

::

   long double cabsl(__SEGGER_RTL_LDOUBLE_C_COMPLEX x);

Parameters

+------------------+---------------------------------------------------+
| Parameter        | Description                                       |
+==================+===================================================+
| x                | Value to compute magnitude of.                    |
+------------------+---------------------------------------------------+

Return value

The magnitude of x, \|x\|.

carg()
''''''

Description

Compute phase, double complex.

Prototype

::

   double carg(__SEGGER_RTL_FLOAT64_C_COMPLEX x);

Parameters

+--------------------+-------------------------------------------------+
| Parameter          | Description                                     |
+====================+=================================================+
| x                  | Value to compute phase of.                      |
+--------------------+-------------------------------------------------+

Return value

The phase of x.

cargf()
'''''''

Description

Compute phase, float complex.

Prototype

::

   float cargf(__SEGGER_RTL_FLOAT32_C_COMPLEX x);

Parameters

+--------------------+-------------------------------------------------+
| Parameter          | Description                                     |
+====================+=================================================+
| x                  | Value to compute phase of.                      |
+--------------------+-------------------------------------------------+

Return value

The phase of x.

cargl()
'''''''

Description

Compute phase, long double complex.

Prototype

::

   long double cargl(__SEGGER_RTL_LDOUBLE_C_COMPLEX x);

Parameters

+--------------------+-------------------------------------------------+
| Parameter          | Description                                     |
+====================+=================================================+
| x                  | Value to compute phase of.                      |
+--------------------+-------------------------------------------------+

Return value

The phase of x.

cimag()
'''''''

Description

Imaginary part, double complex.

Prototype

::

   double cimag(__SEGGER_RTL_FLOAT64_C_COMPLEX x);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Argument.                          |
+---------------------------------+------------------------------------+

Return value

The imaginary part of the complex value.

cimagf()
''''''''

Description

Imaginary part, float complex.

Prototype

::

   float cimagf(__SEGGER_RTL_FLOAT32_C_COMPLEX x);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Argument.                          |
+---------------------------------+------------------------------------+

Return value

The imaginary part of the complex value.

cimagl()
''''''''

Description

Imaginary part, long double complex.

Prototype

::

   long double cimagl(__SEGGER_RTL_LDOUBLE_C_COMPLEX x);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Argument.                          |
+---------------------------------+------------------------------------+

Return value

The imaginary part of the complex value.

creal()
'''''''

Description

Real part, double complex.

Prototype

::

   double creal(__SEGGER_RTL_FLOAT64_C_COMPLEX x);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Argument.                          |
+---------------------------------+------------------------------------+

Return value

The real part of the complex value.

crealf()
''''''''

Description

Real part, float complex.

Prototype

::

   float crealf(__SEGGER_RTL_FLOAT32_C_COMPLEX x);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Argument.                          |
+---------------------------------+------------------------------------+

Return value

The real part of the complex value.

creall()
''''''''

Description

Real part, long double complex.

Prototype

::

   long double creall(__SEGGER_RTL_LDOUBLE_C_COMPLEX x);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Argument.                          |
+---------------------------------+------------------------------------+

Return value

The real part of the complex value.

cproj()
'''''''

Description

Project, double complex.

Prototype

::

   __SEGGER_RTL_FLOAT64_C_COMPLEX cproj(__SEGGER_RTL_FLOAT64_C_COMPLEX x);

Parameters

+----------------------------+-----------------------------------------+
| Parameter                  | Description                             |
+============================+=========================================+
| x                          | Value to project.                       |
+----------------------------+-----------------------------------------+

Return value

The projection of x to the Reimann sphere.

Additional information

x projects to x, except that all complex infinities (even those with one infinite part and one NaN part) project to positive infinity on the real axis. If x has an infinite part, then cproj(x) is be equivalent to:

- INFINITY + I \* copysign(0.0, cimag(x))

cprojf()
''''''''

Description

Project, float complex.

Prototype

::

   __SEGGER_RTL_FLOAT32_C_COMPLEX cprojf(__SEGGER_RTL_FLOAT32_C_COMPLEX x);

Parameters

+----------------------------+-----------------------------------------+
| Parameter                  | Description                             |
+============================+=========================================+
| x                          | Value to project.                       |
+----------------------------+-----------------------------------------+

Return value

The projection of x to the Reimann sphere.

Additional information

x projects to x, except that all complex infinities (even those with one infinite part and one NaN part) project to positive infinity on the real axis. If x has an infinite part, then cproj(x) is be equivalent to:

- INFINITY + I \* copysign(0.0, cimag(x))

cprojl()
''''''''

Description

Project, long double complex.

Prototype

::

   __SEGGER_RTL_LDOUBLE_C_COMPLEX cprojl(__SEGGER_RTL_LDOUBLE_C_COMPLEX x);

Parameters

+----------------------------+-----------------------------------------+
| Parameter                  | Description                             |
+============================+=========================================+
| x                          | Value to project.                       |
+----------------------------+-----------------------------------------+

Return value

The projection of x to the Reimann sphere.

Additional information

x projects to x, except that all complex infinities (even those with one infinite part and one NaN part) project to positive infinity on the real axis. If x has an infinite part, then cproj(x) is be equivalent to:

- INFINITY + I \* copysignl(0.0, cimagl(x))

conj()
''''''

Description

Conjugate, double complex.

Prototype

::

   __SEGGER_RTL_FLOAT64_C_COMPLEX conj(__SEGGER_RTL_FLOAT64_C_COMPLEX x);

Parameters

+--------------------------+-------------------------------------------+
| Parameter                | Description                               |
+==========================+===========================================+
| x                        | Value to conjugate.                       |
+--------------------------+-------------------------------------------+

Return value

The complex conjugate of x.

conjf()
'''''''

Description

Conjugate, float complex.

Prototype

::

   __SEGGER_RTL_FLOAT32_C_COMPLEX conjf(__SEGGER_RTL_FLOAT32_C_COMPLEX x);

Parameters

+--------------------------+-------------------------------------------+
| Parameter                | Description                               |
+==========================+===========================================+
| x                        | Value to conjugate.                       |
+--------------------------+-------------------------------------------+

Return value

The complex conjugate of x.

conjl()
'''''''

Description

Conjugate, long double complex.

Prototype

::

   __SEGGER_RTL_LDOUBLE_C_COMPLEX conjl(__SEGGER_RTL_LDOUBLE_C_COMPLEX x);

Parameters

+--------------------------+-------------------------------------------+
| Parameter                | Description                               |
+==========================+===========================================+
| x                        | Value to conjugate.                       |
+--------------------------+-------------------------------------------+

Return value

The complex conjugate of x.

Trigonometric functions
^^^^^^^^^^^^^^^^^^^^^^^

+-------------+---------------------------------------------------------+
| Function    | Description                                             |
+=============+=========================================================+
| `csin()`_   | Compute sine, double complex.                           |
+-------------+---------------------------------------------------------+
| `csinf()`_  | Compute sine, float complex.                            |
+-------------+---------------------------------------------------------+
| `csinl()`_  | Compute sine, long double complex.                      |
+-------------+---------------------------------------------------------+
| `ccos()`_   | Compute cosine, double complex.                         |
+-------------+---------------------------------------------------------+
| `ccosf()`_  | Compute cosine, float complex.                          |
+-------------+---------------------------------------------------------+
| `ccosl()`_  | Compute cosine, long double complex.                    |
+-------------+---------------------------------------------------------+
| `ctan()`_   | Compute tangent, double complex.                        |
+-------------+---------------------------------------------------------+
| `ctanf()`_  | Compute tangent, float complex.                         |
+-------------+---------------------------------------------------------+
| `ctanl()`_  | Compute tangent, long double complex.                   |
+-------------+---------------------------------------------------------+
| `casin()`_  | Compute inverse sine, double complex.                   |
+-------------+---------------------------------------------------------+
| `casinf()`_ | Compute inverse sine, float complex.                    |
+-------------+---------------------------------------------------------+
| `casinl()`_ | Compute inverse sine, long double complex.              |
+-------------+---------------------------------------------------------+
| `cacos()`_  | Compute inverse cosine, double complex.                 |
+-------------+---------------------------------------------------------+
| `cacosf()`_ | Compute inverse cosine, float complex.                  |
+-------------+---------------------------------------------------------+
| `cacosl()`_ | Compute inverse cosine, long double complex.            |
+-------------+---------------------------------------------------------+
| `catan()`_  | Compute inverse tangent, double complex.                |
+-------------+---------------------------------------------------------+
| `catanf()`_ | Compute inverse tangent, float complex.                 |
+-------------+---------------------------------------------------------+
| `catanl()`_ | Compute inverse tangent, long double complex.           |
+-------------+---------------------------------------------------------+

csin()
''''''

Description

Compute sine, double complex.

Prototype

::

   __SEGGER_RTL_FLOAT64_C_COMPLEX csin(__SEGGER_RTL_FLOAT64_C_COMPLEX x);

Parameters

+---------------------+------------------------------------------------+
| Parameter           | Description                                    |
+=====================+================================================+
| x                   | Value to compute sine of.                      |
+---------------------+------------------------------------------------+

Return value

The sine of x.

csinf()
'''''''

Description

Compute sine, float complex.

Prototype

::

   __SEGGER_RTL_FLOAT32_C_COMPLEX csinf(__SEGGER_RTL_FLOAT32_C_COMPLEX x);

Parameters

+---------------------+------------------------------------------------+
| Parameter           | Description                                    |
+=====================+================================================+
| x                   | Value to compute sine of.                      |
+---------------------+------------------------------------------------+

Return value

The sine of x.

csinl()
'''''''

Description

Compute sine, long double complex.

Prototype

::

   __SEGGER_RTL_LDOUBLE_C_COMPLEX csinl(__SEGGER_RTL_LDOUBLE_C_COMPLEX x);

Parameters

+---------------------+------------------------------------------------+
| Parameter           | Description                                    |
+=====================+================================================+
| x                   | Value to compute sine of.                      |
+---------------------+------------------------------------------------+

Return value

The sine of x.

ccos()
''''''

Description

Compute cosine, double complex.

Prototype

::

   __SEGGER_RTL_FLOAT64_C_COMPLEX ccos(__SEGGER_RTL_FLOAT64_C_COMPLEX x);

Parameters

+--------------------+-------------------------------------------------+
| Parameter          | Description                                     |
+====================+=================================================+
| x                  | Value to compute cosine of.                     |
+--------------------+-------------------------------------------------+

Return value

The cosine of x.

ccosf()
'''''''

Description

Compute cosine, float complex.

Prototype

::

   __SEGGER_RTL_FLOAT32_C_COMPLEX ccosf(__SEGGER_RTL_FLOAT32_C_COMPLEX x);

Parameters

+--------------------+-------------------------------------------------+
| Parameter          | Description                                     |
+====================+=================================================+
| x                  | Value to compute cosine of.                     |
+--------------------+-------------------------------------------------+

Return value

The cosine of x.

ccosl()
'''''''

Description

Compute cosine, long double complex.

Prototype

::

   __SEGGER_RTL_LDOUBLE_C_COMPLEX ccosl(__SEGGER_RTL_LDOUBLE_C_COMPLEX x);

Parameters

+--------------------+-------------------------------------------------+
| Parameter          | Description                                     |
+====================+=================================================+
| x                  | Value to compute cosine of.                     |
+--------------------+-------------------------------------------------+

Return value

The cosine of x.

ctan()
''''''

Description

Compute tangent, double complex.

Prototype

::

   __SEGGER_RTL_FLOAT64_C_COMPLEX ctan(__SEGGER_RTL_FLOAT64_C_COMPLEX x);

Parameters

+--------------------+-------------------------------------------------+
| Parameter          | Description                                     |
+====================+=================================================+
| x                  | Value to compute tangent of.                    |
+--------------------+-------------------------------------------------+

Return value

The tangent of x.

ctanf()
'''''''

Description

Compute tangent, float complex.

Prototype

::

   __SEGGER_RTL_FLOAT32_C_COMPLEX ctanf(__SEGGER_RTL_FLOAT32_C_COMPLEX x);

Parameters

+--------------------+-------------------------------------------------+
| Parameter          | Description                                     |
+====================+=================================================+
| x                  | Value to compute tangent of.                    |
+--------------------+-------------------------------------------------+

Return value

The tangent of x.

ctanl()
'''''''

Description

Compute tangent, long double complex.

Prototype

::

   __SEGGER_RTL_LDOUBLE_C_COMPLEX ctanl(__SEGGER_RTL_LDOUBLE_C_COMPLEX x);

Parameters

+--------------------+-------------------------------------------------+
| Parameter          | Description                                     |
+====================+=================================================+
| x                  | Value to compute tangent of.                    |
+--------------------+-------------------------------------------------+

Return value

The tangent of x.

casin()
'''''''

Description

Compute inverse sine, double complex.

Prototype

::

   __SEGGER_RTL_FLOAT64_C_COMPLEX casin(__SEGGER_RTL_FLOAT64_C_COMPLEX x);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Argument.                          |
+---------------------------------+------------------------------------+

Return value

Inverse sine of x.

Notes

casin(z) = -i casinh(i.z)

casinf()
''''''''

Description

Compute inverse sine, float complex.

Prototype

::

   __SEGGER_RTL_FLOAT32_C_COMPLEX casinf(__SEGGER_RTL_FLOAT32_C_COMPLEX x);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Argument.                          |
+---------------------------------+------------------------------------+

Return value

Inverse sine of x.

Notes

casin(z) = -i casinh(i.z)

casinl()
''''''''

Description

Compute inverse sine, long double complex.

Prototype

::

   __SEGGER_RTL_LDOUBLE_C_COMPLEX casinl(__SEGGER_RTL_LDOUBLE_C_COMPLEX x);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Argument.                          |
+---------------------------------+------------------------------------+

Return value

Inverse sine of x.

Notes

casinl(z) = -i casinhl(i.z)

cacos()
'''''''

Description

Compute inverse cosine, double complex.

Prototype

::

   __SEGGER_RTL_FLOAT64_C_COMPLEX cacos(__SEGGER_RTL_FLOAT64_C_COMPLEX x);

Parameters

+-----------------+----------------------------------------------------+
| Parameter       | Description                                        |
+=================+====================================================+
| x               | Value to compute inverse cosine of.                |
+-----------------+----------------------------------------------------+

Return value

The inverse cosine of x.

cacosf()
''''''''

Description

Compute inverse cosine, float complex.

Prototype

::

   __SEGGER_RTL_FLOAT32_C_COMPLEX cacosf(__SEGGER_RTL_FLOAT32_C_COMPLEX x);

Parameters

+-----------------+----------------------------------------------------+
| Parameter       | Description                                        |
+=================+====================================================+
| x               | Value to compute inverse cosine of.                |
+-----------------+----------------------------------------------------+

Return value

The inverse cosine of x.

cacosl()
''''''''

Description

Compute inverse cosine, long double complex.

Prototype

::

   __SEGGER_RTL_LDOUBLE_C_COMPLEX cacosl(__SEGGER_RTL_LDOUBLE_C_COMPLEX x);

Parameters

+-----------------+----------------------------------------------------+
| Parameter       | Description                                        |
+=================+====================================================+
| x               | Value to compute inverse cosine of.                |
+-----------------+----------------------------------------------------+

Return value

The inverse cosine of x.

catan()
'''''''

Description

Compute inverse tangent, double complex.

Prototype

::

   __SEGGER_RTL_FLOAT64_C_COMPLEX catan(__SEGGER_RTL_FLOAT64_C_COMPLEX x);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Argument.                          |
+---------------------------------+------------------------------------+

Return value

Inverse tangent of x.

Notes

catan(z) = -i catanh(i.z)

catanf()
''''''''

Description

Compute inverse tangent, float complex.

Prototype

::

   __SEGGER_RTL_FLOAT32_C_COMPLEX catanf(__SEGGER_RTL_FLOAT32_C_COMPLEX x);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Argument.                          |
+---------------------------------+------------------------------------+

Return value

Inverse tangent of x.

Notes

catan(z) = -i catanh(i.z)

catanl()
''''''''

Description

Compute inverse tangent, long double complex.

Prototype

::

   __SEGGER_RTL_LDOUBLE_C_COMPLEX catanl(__SEGGER_RTL_LDOUBLE_C_COMPLEX x);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Argument.                          |
+---------------------------------+------------------------------------+

Return value

Inverse tangent of x.

Notes

catanl(z) = -i catanhl(i.z)

Hyperbolic functions
^^^^^^^^^^^^^^^^^^^^

+--------------+-----------------------------------------------------------+
| Function     | Description                                               |
+==============+===========================================================+
| `csinh()`_   | Compute hyperbolic sine, double complex.                  |
+--------------+-----------------------------------------------------------+
| `csinhf()`_  | Compute hyperbolic sine, float complex.                   |
+--------------+-----------------------------------------------------------+
| `csinhl()`_  | Compute hyperbolic sine, long double complex.             |
+--------------+-----------------------------------------------------------+
| `ccosh()`_   | Compute hyperbolic cosine, double complex.                |
+--------------+-----------------------------------------------------------+
| `ccoshf()`_  | Compute hyperbolic cosine, float complex.                 |
+--------------+-----------------------------------------------------------+
| `ccoshl()`_  | Compute hyperbolic cosine, long double complex.           |
+--------------+-----------------------------------------------------------+
| `ctanh()`_   | Compute hyperbolic tangent, double complex.               |
+--------------+-----------------------------------------------------------+
| `ctanhf()`_  | Compute hyperbolic tangent, float complex.                |
+--------------+-----------------------------------------------------------+
| `ctanhl()`_  | Compute hyperbolic tangent, long double complex.          |
+--------------+-----------------------------------------------------------+
| `casinh()`_  | Compute inverse hyperbolic sine, double complex.          |
+--------------+-----------------------------------------------------------+
| `casinhf()`_ | Compute inverse hyperbolic sine, float complex.           |
+--------------+-----------------------------------------------------------+
| `casinhl()`_ | Compute inverse hyperbolic sine, long double complex.     |
+--------------+-----------------------------------------------------------+
| `cacosh()`_  | Compute inverse hyperbolic cosine, double complex.        |
+--------------+-----------------------------------------------------------+
| `cacoshf()`_ | Compute inverse hyperbolic cosine, float complex.         |
+--------------+-----------------------------------------------------------+
| `cacoshl()`_ | Compute inverse hyperbolic cosine, long double complex.   |
+--------------+-----------------------------------------------------------+
| `catanh()`_  | Compute inverse hyperbolic tangent, double complex.       |
+--------------+-----------------------------------------------------------+
| `catanhf()`_ | Compute inverse hyperbolic tangent, float complex.        |
+--------------+-----------------------------------------------------------+
| `catanhl()`_ | Compute inverse hyperbolic tangent, long double complex.  |
+--------------+-----------------------------------------------------------+

csinh()
'''''''

Description

Compute hyperbolic sine, double complex.

Prototype

::

   __SEGGER_RTL_FLOAT64_C_COMPLEX csinh(__SEGGER_RTL_FLOAT64_C_COMPLEX x);

Parameters

+----------------+-----------------------------------------------------+
| Parameter      | Description                                         |
+================+=====================================================+
| x              | Value to compute hyperbolic sine of.                |
+----------------+-----------------------------------------------------+

Return value

The hyperbolic sine of x according to the following table:

+---------------+------------------------------------------------------+
| Argument      | csinh(Argument)                                      |
+===============+======================================================+
| +0 + 0i       | +0 + 0i                                              |
+---------------+------------------------------------------------------+
| +0 + ∞i       | ±0 + NaNi, sign of real part unspecified             |
+---------------+------------------------------------------------------+
| +0 + NaNi     | ±0 + NaNi, sign of real part unspecified             |
+---------------+------------------------------------------------------+
| a + ∞i        | NaN + NaNi, for positive finite a                    |
+---------------+------------------------------------------------------+
| a + NaNi      | NaN + NaNi, for finite nonzero a                     |
+---------------+------------------------------------------------------+
| +∞ + 0i       | +∞ + 0i                                              |
+---------------+------------------------------------------------------+
| +∞ + bi       | +∞×cos(b) + +∞×sin(b).i for positive finite b        |
+---------------+------------------------------------------------------+
| +∞ + ∞i       | ±∞ + NaNi, sign of real part unspecified             |
+---------------+------------------------------------------------------+
| +∞ + NaNi     | ±∞ + NaNi, sign of real part unspecified             |
+---------------+------------------------------------------------------+
| NaN + 0i      | NaN + 0i                                             |
+---------------+------------------------------------------------------+
| NaN + bi      | NaN + NaNi, for all nonzero b                        |
+---------------+------------------------------------------------------+
| NaN + NaNi    | NaN + NaNi                                           |
+---------------+------------------------------------------------------+

For arguments with a negative imaginary component, use the equality:

- csinh(conj(z)) = conj(csinh(z)).

For arguments with a negative real component, use the equality:

- csinh(-z) = -csinh(z).

csinhf()
''''''''

Description

Compute hyperbolic sine, float complex.

Prototype

::

   __SEGGER_RTL_FLOAT32_C_COMPLEX csinhf(__SEGGER_RTL_FLOAT32_C_COMPLEX x);

Parameters

+----------------+-----------------------------------------------------+
| Parameter      | Description                                         |
+================+=====================================================+
| x              | Value to compute hyperbolic sine of.                |
+----------------+-----------------------------------------------------+

Return value

The hyperbolic sine of x according to the following table:

+---------------+------------------------------------------------------+
| Argument      | csinh(Argument)                                      |
+===============+======================================================+
| +0 + 0i       | +0 + 0i                                              |
+---------------+------------------------------------------------------+
| +0 + ∞i       | ±0 + NaNi, sign of real part unspecified             |
+---------------+------------------------------------------------------+
| +0 + NaNi     | ±0 + NaNi, sign of real part unspecified             |
+---------------+------------------------------------------------------+
| a + ∞i        | NaN + NaNi, for positive finite a                    |
+---------------+------------------------------------------------------+
| a + NaNi      | NaN + NaNi, for finite nonzero a                     |
+---------------+------------------------------------------------------+
| +∞ + 0i       | +∞ + 0i                                              |
+---------------+------------------------------------------------------+
| +∞ + bi       | +∞×cos(b) + +∞×sin(b).i for positive finite b        |
+---------------+------------------------------------------------------+
| +∞ + ∞i       | ±∞ + NaNi, sign of real part unspecified             |
+---------------+------------------------------------------------------+
| +∞ + NaNi     | ±∞ + NaNi, sign of real part unspecified             |
+---------------+------------------------------------------------------+
| NaN + 0i      | NaN + 0i                                             |
+---------------+------------------------------------------------------+
| NaN + bi      | NaN + NaNi, for all nonzero b                        |
+---------------+------------------------------------------------------+
| NaN + NaNi    | NaN + NaNi                                           |
+---------------+------------------------------------------------------+

For arguments with a negative imaginary component, use the equality:

- csinh(conj(z)) = conj(csinh(z)).

For arguments with a negative real component, use the equality:

- csinh(-z) = -csinh(z).

csinhl()
''''''''

Description

Compute hyperbolic sine, long double complex.

Prototype

::

   __SEGGER_RTL_LDOUBLE_C_COMPLEX csinhl(__SEGGER_RTL_LDOUBLE_C_COMPLEX x);

Parameters

+----------------+-----------------------------------------------------+
| Parameter      | Description                                         |
+================+=====================================================+
| x              | Value to compute hyperbolic sine of.                |
+----------------+-----------------------------------------------------+

Return value

The hyperbolic sine of x according to the following table:

+---------------+------------------------------------------------------+
| Argument      | csinh(Argument)                                      |
+===============+======================================================+
| +0 + 0i       | +0 + 0i                                              |
+---------------+------------------------------------------------------+
| +0 + ∞i       | ±0 + NaNi, sign of real part unspecified             |
+---------------+------------------------------------------------------+
| +0 + NaNi     | ±0 + NaNi, sign of real part unspecified             |
+---------------+------------------------------------------------------+
| a + ∞i        | NaN + NaNi, for positive finite a                    |
+---------------+------------------------------------------------------+
| a + NaNi      | NaN + NaNi, for finite nonzero a                     |
+---------------+------------------------------------------------------+
| +∞ + 0i       | +∞ + 0i                                              |
+---------------+------------------------------------------------------+
| +∞ + bi       | +∞×cos(b) + +∞×sin(b).i for positive finite b        |
+---------------+------------------------------------------------------+
| +∞ + ∞i       | ±∞ + NaNi, sign of real part unspecified             |
+---------------+------------------------------------------------------+
| +∞ + NaNi     | ±∞ + NaNi, sign of real part unspecified             |
+---------------+------------------------------------------------------+
| NaN + 0i      | NaN + 0i                                             |
+---------------+------------------------------------------------------+
| NaN + bi      | NaN + NaNi, for all nonzero b                        |
+---------------+------------------------------------------------------+
| NaN + NaNi    | NaN + NaNi                                           |
+---------------+------------------------------------------------------+

For arguments with a negative imaginary component, use the equality:

- csinh(conj(z)) = conj(csinh(z)).

For arguments with a negative real component, use the equality:

- csinh(-z) = -csinh(z).

ccosh()
'''''''

Description

Compute hyperbolic cosine, double complex.

Prototype

::

   __SEGGER_RTL_FLOAT64_C_COMPLEX ccosh(__SEGGER_RTL_FLOAT64_C_COMPLEX x);

Parameters

+----------------+-----------------------------------------------------+
| Parameter      | Description                                         |
+================+=====================================================+
| x              | Value to compute hyperbolic cosine of.              |
+----------------+-----------------------------------------------------+

Return value

The hyperbolic cosine of x according to the following table:

+---------------+------------------------------------------------------+
| Argument      | ccosh(Argument)                                      |
+===============+======================================================+
| +0 + 0i       | +1 + 0i                                              |
+---------------+------------------------------------------------------+
| +0 + ∞i       | NaN + ±0i, sign of imaginary part unspecified        |
+---------------+------------------------------------------------------+
| +0 + NaNi     | NaN + ±0i, sign of imaginary part unspecified        |
+---------------+------------------------------------------------------+
| a + ∞i        | NaN + NaNi, for finite nonzero a                     |
+---------------+------------------------------------------------------+
| a + NaNi      | NaN + NaNi, for finite nonzero a                     |
+---------------+------------------------------------------------------+
| +∞ + 0i       | +∞ + 0i                                              |
+---------------+------------------------------------------------------+
| +∞ + bi       | +∞×cos(b) + Inf×sin(b).i for finite nonzero b        |
+---------------+------------------------------------------------------+
| +∞ + ∞i       | +∞ + NaNi                                            |
+---------------+------------------------------------------------------+
| +∞ + NaNi     | +∞ + NaNi                                            |
+---------------+------------------------------------------------------+
| NaN + 0i      | NaN + ±0i, sign of imaginary part unspecified        |
+---------------+------------------------------------------------------+
| NaN + bi      | NaN + NaNi, for all nonzero b                        |
+---------------+------------------------------------------------------+
| NaN + NaNi    | NaN + NaNi                                           |
+---------------+------------------------------------------------------+

For arguments with a negative imaginary component, use the equality:

- ccosh(conj(z)) = conj(ccosh(z)).

ccoshf()
''''''''

Description

Compute hyperbolic cosine, float complex.

Prototype

::

   __SEGGER_RTL_FLOAT32_C_COMPLEX ccoshf(__SEGGER_RTL_FLOAT32_C_COMPLEX x);

Parameters

+----------------+-----------------------------------------------------+
| Parameter      | Description                                         |
+================+=====================================================+
| x              | Value to compute hyperbolic cosine of.              |
+----------------+-----------------------------------------------------+

Return value

The hyperbolic cosine of x according to the following table:

+---------------+------------------------------------------------------+
| Argument      | ccosh(Argument)                                      |
+===============+======================================================+
| +0 + 0i       | +1 + 0i                                              |
+---------------+------------------------------------------------------+
| +0 + ∞i       | NaN + ±0i, sign of imaginary part unspecified        |
+---------------+------------------------------------------------------+
| +0 + NaNi     | NaN + ±0i, sign of imaginary part unspecified        |
+---------------+------------------------------------------------------+
| a + ∞i        | NaN + NaNi, for finite nonzero a                     |
+---------------+------------------------------------------------------+
| a + NaNi      | NaN + NaNi, for finite nonzero a                     |
+---------------+------------------------------------------------------+
| +∞ + 0i       | +∞ + 0i                                              |
+---------------+------------------------------------------------------+
| +∞ + bi       | +∞×cos(b) + Inf×sin(b).i for finite nonzero b        |
+---------------+------------------------------------------------------+
| +∞ + ∞i       | +∞ + NaNi                                            |
+---------------+------------------------------------------------------+
| +∞ + NaNi     | +∞ + NaNi                                            |
+---------------+------------------------------------------------------+
| NaN + 0i      | NaN + ±0i, sign of imaginary part unspecified        |
+---------------+------------------------------------------------------+
| NaN + bi      | NaN + NaNi, for all nonzero b                        |
+---------------+------------------------------------------------------+
| NaN + NaNi    | NaN + NaNi                                           |
+---------------+------------------------------------------------------+

For arguments with a negative imaginary component, use the equality:

- ccosh(conj(z)) = conj(ccosh(z)).

ccoshl()
''''''''

Description

Compute hyperbolic cosine, long double complex.

Prototype

::

   __SEGGER_RTL_LDOUBLE_C_COMPLEX ccoshl(__SEGGER_RTL_LDOUBLE_C_COMPLEX x);

Parameters

+----------------+-----------------------------------------------------+
| Parameter      | Description                                         |
+================+=====================================================+
| x              | Value to compute hyperbolic cosine of.              |
+----------------+-----------------------------------------------------+

Return value

The hyperbolic cosine of x according to the following table:

+---------------+------------------------------------------------------+
| Argument      | ccosh(Argument)                                      |
+===============+======================================================+
| +0 + 0i       | +1 + 0i                                              |
+---------------+------------------------------------------------------+
| +0 + ∞i       | NaN + ±0i, sign of imaginary part unspecified        |
+---------------+------------------------------------------------------+
| +0 + NaNi     | NaN + ±0i, sign of imaginary part unspecified        |
+---------------+------------------------------------------------------+
| a + ∞i        | NaN + NaNi, for finite nonzero a                     |
+---------------+------------------------------------------------------+
| a + NaNi      | NaN + NaNi, for finite nonzero a                     |
+---------------+------------------------------------------------------+
| +∞ + 0i       | +∞ + 0i                                              |
+---------------+------------------------------------------------------+
| +∞ + bi       | +∞×cos(b) + Inf×sin(b).i for finite nonzero b        |
+---------------+------------------------------------------------------+
| +∞ + ∞i       | +∞ + NaNi                                            |
+---------------+------------------------------------------------------+
| +∞ + NaNi     | +∞ + NaNi                                            |
+---------------+------------------------------------------------------+
| NaN + 0i      | NaN + ±0i, sign of imaginary part unspecified        |
+---------------+------------------------------------------------------+
| NaN + bi      | NaN + NaNi, for all nonzero b                        |
+---------------+------------------------------------------------------+
| NaN + NaNi    | NaN + NaNi                                           |
+---------------+------------------------------------------------------+

For arguments with a negative imaginary component, use the equality:

- ccosh(conj(z)) = conj(ccosh(z)).

ctanh()
'''''''

Description

Compute hyperbolic tangent, double complex.

Prototype

::

   __SEGGER_RTL_FLOAT64_C_COMPLEX ctanh(__SEGGER_RTL_FLOAT64_C_COMPLEX x);

Parameters

+---------------+------------------------------------------------------+
| Parameter     | Description                                          |
+===============+======================================================+
| x             | Value to compute hyperbolic tangent of.              |
+---------------+------------------------------------------------------+

Return value

The hyperbolic tangent of x according to the following table:

+---------------+------------------------------------------------------+
| Argument      | ctanh(Argument)                                      |
+===============+======================================================+
| +0 + 0i       | +0 + 0i                                              |
+---------------+------------------------------------------------------+
| a + ∞i        | NaN + NaNi, for finite a                             |
+---------------+------------------------------------------------------+
| a + NaNi      | NaN + NaNi, for finite a                             |
+---------------+------------------------------------------------------+
| +∞ + bi       | +1 + sin(2b)×0i for positive-signed finite b         |
+---------------+------------------------------------------------------+
| +∞ + ∞i       | +1 + ±0i, sign of imaginary part unspecified         |
+---------------+------------------------------------------------------+
| +∞ + NaNi     | +1 + ±0i, sign of imaginary part unspecified         |
+---------------+------------------------------------------------------+
| NaN + 0i      | NaN + 0i                                             |
+---------------+------------------------------------------------------+
| NaN + bi      | NaN + NaNi, for all nonzero b                        |
+---------------+------------------------------------------------------+
| NaN + NaNi    | NaN + NaNi                                           |
+---------------+------------------------------------------------------+

For arguments with a negative imaginary component, use the equality:

- ctanh(conj(z)) = conj(ctanh(z)).

For arguments with a negative real component, use the equality:

- ctanh(-z) = -ctanh(z).

ctanhf()
''''''''

Description

Compute hyperbolic tangent, float complex.

Prototype

::

   __SEGGER_RTL_FLOAT32_C_COMPLEX ctanhf(__SEGGER_RTL_FLOAT32_C_COMPLEX x);

Parameters

+---------------+------------------------------------------------------+
| Parameter     | Description                                          |
+===============+======================================================+
| x             | Value to compute hyperbolic tangent of.              |
+---------------+------------------------------------------------------+

Return value

The hyperbolic tangent of x according to the following table:

+---------------+------------------------------------------------------+
| Argument      | ctanh(Argument)                                      |
+===============+======================================================+
| +0 + 0i       | +0 + 0i                                              |
+---------------+------------------------------------------------------+
| a + ∞i        | NaN + NaNi, for finite a                             |
+---------------+------------------------------------------------------+
| a + NaNi      | NaN + NaNi, for finite a                             |
+---------------+------------------------------------------------------+
| +∞ + bi       | +1 + sin(2b)×0i for positive-signed finite b         |
+---------------+------------------------------------------------------+
| +∞ + ∞i       | +1 + ±0i, sign of imaginary part unspecified         |
+---------------+------------------------------------------------------+
| +∞ + NaNi     | +1 + ±0i, sign of imaginary part unspecified         |
+---------------+------------------------------------------------------+
| NaN + 0i      | NaN + 0i                                             |
+---------------+------------------------------------------------------+
| NaN + bi      | NaN + NaNi, for all nonzero b                        |
+---------------+------------------------------------------------------+
| NaN + NaNi    | NaN + NaNi                                           |
+---------------+------------------------------------------------------+

For arguments with a negative imaginary component, use the equality:

- ctanhf(conj(z)) = conj(ctanhf(z)).

For arguments with a negative real component, use the equality:

- ctanhf(-z) = -ctanhf(z).

ctanhl()
''''''''

Description

Compute hyperbolic tangent, long double complex.

Prototype

::

   __SEGGER_RTL_LDOUBLE_C_COMPLEX ctanhl(__SEGGER_RTL_LDOUBLE_C_COMPLEX x);

Parameters

+---------------+------------------------------------------------------+
| Parameter     | Description                                          |
+===============+======================================================+
| x             | Value to compute hyperbolic tangent of.              |
+---------------+------------------------------------------------------+

Return value

The hyperbolic tangent of x according to the following table:

+---------------+------------------------------------------------------+
| Argument      | ctanh(Argument)                                      |
+===============+======================================================+
| +0 + 0i       | +0 + 0i                                              |
+---------------+------------------------------------------------------+
| a + ∞i        | NaN + NaNi, for finite a                             |
+---------------+------------------------------------------------------+
| a + NaNi      | NaN + NaNi, for finite a                             |
+---------------+------------------------------------------------------+
| +∞ + bi       | +1 + sin(2b)×0i for positive-signed finite b         |
+---------------+------------------------------------------------------+
| +∞ + ∞i       | +1 + ±0i, sign of imaginary part unspecified         |
+---------------+------------------------------------------------------+
| +∞ + NaNi     | +1 + ±0i, sign of imaginary part unspecified         |
+---------------+------------------------------------------------------+
| NaN + 0i      | NaN + 0i                                             |
+---------------+------------------------------------------------------+
| NaN + bi      | NaN + NaNi, for all nonzero b                        |
+---------------+------------------------------------------------------+
| NaN + NaNi    | NaN + NaNi                                           |
+---------------+------------------------------------------------------+

For arguments with a negative imaginary component, use the equality:

- ctanh(conj(z)) = conj(ctanh(z)).

For arguments with a negative real component, use the equality:

- ctanh(-z) = -ctanh(z).

casinh()
''''''''

Description

Compute inverse hyperbolic sine, double complex.

Prototype

::

   __SEGGER_RTL_FLOAT64_C_COMPLEX casinh(__SEGGER_RTL_FLOAT64_C_COMPLEX x);

Parameters

+--------------+-------------------------------------------------------+
| Parameter    | Description                                           |
+==============+=======================================================+
| x            | Value to compute inverse hyperbolic sineof.           |
+--------------+-------------------------------------------------------+

Return value

The inverse hyperbolic sine of x according to the following table:

+----------------+-----------------------------------------------------+
| Argument       | casinh(Argument)                                    |
+================+=====================================================+
| +0 + 0i        | +0 + 0i                                             |
+----------------+-----------------------------------------------------+
| +0 + ∞i        | +∞ + ½πi                                            |
+----------------+-----------------------------------------------------+
| a + NaNi       | NaN + NaNi                                          |
+----------------+-----------------------------------------------------+
| +∞ + bi        | +∞ + 0i, for positive-signed b                      |
+----------------+-----------------------------------------------------+
| +∞ + ∞i        | +Pi + 0i                                            |
+----------------+-----------------------------------------------------+
| +∞ + NaNi      | +∞ + NaNi                                           |
+----------------+-----------------------------------------------------+
| NaN + 0i       | NaN + 0i                                            |
+----------------+-----------------------------------------------------+
| NaN + bi       | NaN + NaNi, for finite nonzero b                    |
+----------------+-----------------------------------------------------+
| NaN + ∞i       | ±∞ + NaNi, sign of real part unspecified            |
+----------------+-----------------------------------------------------+
| NaN + NaNi     | NaN + NaNi                                          |
+----------------+-----------------------------------------------------+

For arguments with a negative imaginary component, use the equality:

- casinh(conj(z)) = conj(casinh(z)).

For arguments with a negative real component, use the equality:

- casinh(-z) = -casinh(z).

casinhf()
'''''''''

Description

Compute inverse hyperbolic sine, float complex.

Prototype

::

   __SEGGER_RTL_FLOAT32_C_COMPLEX casinhf(__SEGGER_RTL_FLOAT32_C_COMPLEX x);

Parameters

+--------------+-------------------------------------------------------+
| Parameter    | Description                                           |
+==============+=======================================================+
| x            | Value to compute inverse hyperbolic sineof.           |
+--------------+-------------------------------------------------------+

Return value

The inverse hyperbolic sine of x according to the following table:

+----------------+-----------------------------------------------------+
| Argument       | casinh(Argument)                                    |
+================+=====================================================+
| +0 + 0i        | +0 + 0i                                             |
+----------------+-----------------------------------------------------+
| +0 + ∞i        | +∞ + ½πi                                            |
+----------------+-----------------------------------------------------+
| a + NaNi       | NaN + NaNi                                          |
+----------------+-----------------------------------------------------+
| +∞ + bi        | +∞ + 0i, for positive-signed b                      |
+----------------+-----------------------------------------------------+
| +∞ + ∞i        | +Pi + 0i                                            |
+----------------+-----------------------------------------------------+
| +∞ + NaNi      | +∞ + NaNi                                           |
+----------------+-----------------------------------------------------+
| NaN + 0i       | NaN + 0i                                            |
+----------------+-----------------------------------------------------+
| NaN + bi       | NaN + NaNi, for finite nonzero b                    |
+----------------+-----------------------------------------------------+
| NaN + ∞i       | ±∞ + NaNi, sign of real part unspecified            |
+----------------+-----------------------------------------------------+
| NaN + NaNi     | NaN + NaNi                                          |
+----------------+-----------------------------------------------------+

For arguments with a negative imaginary component, use the equality:

- casinh(conj(z)) = conj(casinh(z)).

For arguments with a negative real component, use the equality:

- casinh(-z) = -casinh(z).

casinhl()
'''''''''

Description

Compute inverse hyperbolic sine, long double complex.

Prototype

::

   __SEGGER_RTL_LDOUBLE_C_COMPLEX casinhl(__SEGGER_RTL_LDOUBLE_C_COMPLEX x);

Parameters

+--------------+-------------------------------------------------------+
| Parameter    | Description                                           |
+==============+=======================================================+
| x            | Value to compute inverse hyperbolic sineof.           |
+--------------+-------------------------------------------------------+

Return value

The inverse hyperbolic sine of x according to the following table:

+----------------+-----------------------------------------------------+
| Argument       | casinh(Argument)                                    |
+================+=====================================================+
| +0 + 0i        | +0 + 0i                                             |
+----------------+-----------------------------------------------------+
| +0 + ∞i        | +∞ + ½πi                                            |
+----------------+-----------------------------------------------------+
| a + NaNi       | NaN + NaNi                                          |
+----------------+-----------------------------------------------------+
| +∞ + bi        | +∞ + 0i, for positive-signed b                      |
+----------------+-----------------------------------------------------+
| +∞ + ∞i        | +Pi + 0i                                            |
+----------------+-----------------------------------------------------+
| +∞ + NaNi      | +∞ + NaNi                                           |
+----------------+-----------------------------------------------------+
| NaN + 0i       | NaN + 0i                                            |
+----------------+-----------------------------------------------------+
| NaN + bi       | NaN + NaNi, for finite nonzero b                    |
+----------------+-----------------------------------------------------+
| NaN + ∞i       | ±∞ + NaNi, sign of real part unspecified            |
+----------------+-----------------------------------------------------+
| NaN + NaNi     | NaN + NaNi                                          |
+----------------+-----------------------------------------------------+

For arguments with a negative imaginary component, use the equality:

- casinh(conj(z)) = conj(casinh(z)).

For arguments with a negative real component, use the equality:

- casinh(-z) = -casinh(z).

cacosh()
''''''''

Description

Compute inverse hyperbolic cosine, double complex.

Prototype

::

   __SEGGER_RTL_FLOAT64_C_COMPLEX cacosh(__SEGGER_RTL_FLOAT64_C_COMPLEX x);

Parameters

+-------------+--------------------------------------------------------+
| Parameter   | Description                                            |
+=============+========================================================+
| x           | Value to compute inverse hyperbolic cosine of.         |
+-------------+--------------------------------------------------------+

Return value

The inverse hyperbolic cosine of x according to the following table:

+------------------+---------------------------------------------------+
| Argument         | cacosh(Argument)                                  |
+==================+===================================================+
| ±0 + 0i          | +0 + 0i                                           |
+------------------+---------------------------------------------------+
| a + ∞i           | +∞ + ½πi, for finite a                            |
+------------------+---------------------------------------------------+
| a + NaNi         | NaN + NaNi, for finite a                          |
+------------------+---------------------------------------------------+
| -∞ + bi          | +∞ + πi, for positive-signed finite b             |
+------------------+---------------------------------------------------+
| +∞ + bi          | +∞ + 0i, for positive-signed finite b             |
+------------------+---------------------------------------------------+
| -∞ + ∞i          | ±∞ + ¾πi                                          |
+------------------+---------------------------------------------------+
| +∞ + ∞i          | ±∞ + ¼πi                                          |
+------------------+---------------------------------------------------+
| ±∞ + NaNi        | +∞ + NaNi                                         |
+------------------+---------------------------------------------------+
| NaN + bi         | NaN + NaNi, for finite b                          |
+------------------+---------------------------------------------------+
| NaN + ∞i         | +∞ + NaNi                                         |
+------------------+---------------------------------------------------+
| NaN + NaNi       | NaN + NaNi                                        |
+------------------+---------------------------------------------------+

For arguments with a negative imaginary component, use the equality:

- cacosh(conj(z)) = conj(cacosh(z)).

cacoshf()
'''''''''

Description

Compute inverse hyperbolic cosine, float complex.

Prototype

::

   __SEGGER_RTL_FLOAT32_C_COMPLEX cacoshf(__SEGGER_RTL_FLOAT32_C_COMPLEX x);

Parameters

+-------------+--------------------------------------------------------+
| Parameter   | Description                                            |
+=============+========================================================+
| x           | Value to compute inverse hyperbolic cosine of.         |
+-------------+--------------------------------------------------------+

Return value

The inverse hyperbolic cosine of x according to the following table:

+------------------+---------------------------------------------------+
| Argument         | cacosh(Argument)                                  |
+==================+===================================================+
| ±0 + 0i          | +0 + 0i                                           |
+------------------+---------------------------------------------------+
| a + ∞i           | +∞ + ½πi, for finite a                            |
+------------------+---------------------------------------------------+
| a + NaNi         | NaN + NaNi, for finite a                          |
+------------------+---------------------------------------------------+
| -∞ + bi          | +∞ + πi, for positive-signed finite b             |
+------------------+---------------------------------------------------+
| +∞ + bi          | +∞ + 0i, for positive-signed finite b             |
+------------------+---------------------------------------------------+
| -∞ + ∞i          | ±∞ + ¾πi                                          |
+------------------+---------------------------------------------------+
| +∞ + ∞i          | ±∞ + ¼πi                                          |
+------------------+---------------------------------------------------+
| ±∞ + NaNi        | +∞ + NaNi                                         |
+------------------+---------------------------------------------------+
| NaN + bi         | NaN + NaNi, for finite b                          |
+------------------+---------------------------------------------------+
| NaN + ∞i         | +∞ + NaNi                                         |
+------------------+---------------------------------------------------+
| NaN + NaNi       | NaN + NaNi                                        |
+------------------+---------------------------------------------------+

For arguments with a negative imaginary component, use the equality:

- cacosh(conj(z)) = conj(cacosh(z)).

cacoshl()
'''''''''

Description

Compute inverse hyperbolic cosine, long double complex.

Prototype

::

   __SEGGER_RTL_LDOUBLE_C_COMPLEX cacoshl(__SEGGER_RTL_LDOUBLE_C_COMPLEX x);

Parameters

+-------------+--------------------------------------------------------+
| Parameter   | Description                                            |
+=============+========================================================+
| x           | Value to compute inverse hyperbolic cosine of.         |
+-------------+--------------------------------------------------------+

Return value

The inverse hyperbolic cosine of x according to the following table:

+------------------+---------------------------------------------------+
| Argument         | cacosh(Argument)                                  |
+==================+===================================================+
| ±0 + 0i          | +0 + 0i                                           |
+------------------+---------------------------------------------------+
| a + ∞i           | +∞ + ½πi, for finite a                            |
+------------------+---------------------------------------------------+
| a + NaNi         | NaN + NaNi, for finite a                          |
+------------------+---------------------------------------------------+
| -∞ + bi          | +∞ + πi, for positive-signed finite b             |
+------------------+---------------------------------------------------+
| +∞ + bi          | +∞ + 0i, for positive-signed finite b             |
+------------------+---------------------------------------------------+
| -∞ + ∞i          | ±∞ + ¾πi                                          |
+------------------+---------------------------------------------------+
| +∞ + ∞i          | ±∞ + ¼πi                                          |
+------------------+---------------------------------------------------+
| ±∞ + NaNi        | +∞ + NaNi                                         |
+------------------+---------------------------------------------------+
| NaN + bi         | NaN + NaNi, for finite b                          |
+------------------+---------------------------------------------------+
| NaN + ∞i         | +∞ + NaNi                                         |
+------------------+---------------------------------------------------+
| NaN + NaNi       | NaN + NaNi                                        |
+------------------+---------------------------------------------------+

For arguments with a negative imaginary component, use the equality:

- cacosh(conj(z)) = conj(cacosh(z)).

catanh()
''''''''

Description

Compute inverse hyperbolic tangent, double complex.

Prototype

::

   __SEGGER_RTL_FLOAT64_C_COMPLEX catanh(__SEGGER_RTL_FLOAT64_C_COMPLEX x);

Parameters

+-------------+--------------------------------------------------------+
| Parameter   | Description                                            |
+=============+========================================================+
| x           | Value to compute inverse hyperbolic tangent of.        |
+-------------+--------------------------------------------------------+

Return value

The inverse hyperbolic tangent of x according to the following table:

+-------------------+--------------------------------------------------+
| Argument          | catanh(Argument)                                 |
+===================+==================================================+
| +0 + 0i           | +0 + 0i                                          |
+-------------------+--------------------------------------------------+
| +0 + NaNi         | +0 + NaNi                                        |
+-------------------+--------------------------------------------------+
| +1 + 0i           | +∞ + 0i                                          |
+-------------------+--------------------------------------------------+
| a + ∞i            | +0 + ½πi for positive-signed a                   |
+-------------------+--------------------------------------------------+
| a + NaNi          | NaN + NaNi, for nonzero finite a                 |
+-------------------+--------------------------------------------------+
| +∞ + bi           | +0 + ½πi for positive-signed b                   |
+-------------------+--------------------------------------------------+
| +∞ + ∞i           | +0 + ½πi                                         |
+-------------------+--------------------------------------------------+
| +∞ + NaNi         | +0 + NaNi                                        |
+-------------------+--------------------------------------------------+
| NaN + bi          | NaN + NaNi, for finite b                         |
+-------------------+--------------------------------------------------+
| NaN + NaNi        | NaN + NaNi                                       |
+-------------------+--------------------------------------------------+

For arguments with a negative imaginary component, use the equality:

- catanh(conj(z)) = conj(catanh(z)).

For arguments with a negative real component, use the equality:

- catanh(-z) = -catanh(z).

catanhf()
'''''''''

Description

Compute inverse hyperbolic tangent, float complex.

Prototype

::

   __SEGGER_RTL_FLOAT32_C_COMPLEX catanhf(__SEGGER_RTL_FLOAT32_C_COMPLEX x);

Parameters

+-------------+--------------------------------------------------------+
| Parameter   | Description                                            |
+=============+========================================================+
| x           | Value to compute inverse hyperbolic tangent of.        |
+-------------+--------------------------------------------------------+

Return value

The inverse hyperbolic tangent of x according to the following table:

+-------------------+--------------------------------------------------+
| Argument          | catanh(Argument)                                 |
+===================+==================================================+
| +0 + 0i           | +0 + 0i                                          |
+-------------------+--------------------------------------------------+
| +0 + NaNi         | +0 + NaNi                                        |
+-------------------+--------------------------------------------------+
| +1 + 0i           | +∞ + 0i                                          |
+-------------------+--------------------------------------------------+
| a + ∞i            | +0 + ½πi for positive-signed a                   |
+-------------------+--------------------------------------------------+
| a + NaNi          | NaN + NaNi, for nonzero finite a                 |
+-------------------+--------------------------------------------------+
| +∞ + bi           | +0 + ½πi for positive-signed b                   |
+-------------------+--------------------------------------------------+
| +∞ + ∞i           | +0 + ½πi                                         |
+-------------------+--------------------------------------------------+
| +∞ + NaNi         | +0 + NaNi                                        |
+-------------------+--------------------------------------------------+
| NaN + bi          | NaN + NaNi, for finite b                         |
+-------------------+--------------------------------------------------+
| NaN + NaNi        | NaN + NaNi                                       |
+-------------------+--------------------------------------------------+

For arguments with a negative imaginary component, use the equality:

- catanh(conj(z)) = conj(catanh(z)).

For arguments with a negative real component, use the equality:

- catanh(-z) = -catanh(z).

catanhl()
'''''''''

Description

Compute inverse hyperbolic tangent, long double complex.

Prototype

::

   __SEGGER_RTL_LDOUBLE_C_COMPLEX catanhl(__SEGGER_RTL_LDOUBLE_C_COMPLEX x);

Parameters

+-------------+--------------------------------------------------------+
| Parameter   | Description                                            |
+=============+========================================================+
| x           | Value to compute inverse hyperbolic tangent of.        |
+-------------+--------------------------------------------------------+

Return value

The inverse hyperbolic tangent of x according to the following table:

+-------------------+--------------------------------------------------+
| Argument          | catanh(Argument)                                 |
+===================+==================================================+
| +0 + 0i           | +0 + 0i                                          |
+-------------------+--------------------------------------------------+
| +0 + NaNi         | +0 + NaNi                                        |
+-------------------+--------------------------------------------------+
| +1 + 0i           | +∞ + 0i                                          |
+-------------------+--------------------------------------------------+
| a + ∞i            | +0 + ½πi for positive-signed a                   |
+-------------------+--------------------------------------------------+
| a + NaNi          | NaN + NaNi, for nonzero finite a                 |
+-------------------+--------------------------------------------------+
| +∞ + bi           | +0 + ½πi for positive-signed b                   |
+-------------------+--------------------------------------------------+
| +∞ + ∞i           | +0 + ½πi                                         |
+-------------------+--------------------------------------------------+
| +∞ + NaNi         | +0 + NaNi                                        |
+-------------------+--------------------------------------------------+
| NaN + bi          | NaN + NaNi, for finite b                         |
+-------------------+--------------------------------------------------+
| NaN + NaNi        | NaN + NaNi                                       |
+-------------------+--------------------------------------------------+

For arguments with a negative imaginary component, use the equality:

- catanh(conj(z)) = conj(catanh(z)).

For arguments with a negative real component, use the equality:

- catanh(-z) = -catanh(z).

Power and absolute value
^^^^^^^^^^^^^^^^^^^^^^^^

+-------------+--------------------------------------------------------+
| Function    | Description                                            |
+=============+========================================================+
| `cabs()`_   | Compute magnitude, double complex.                     |
+-------------+--------------------------------------------------------+
| `cabsf()`_  | Compute magnitude, float complex.                      |
+-------------+--------------------------------------------------------+
| `cabsl()`_  | Compute magnitude, long double complex.                |
+-------------+--------------------------------------------------------+
| `cpow()`_   | Power, double complex.                                 |
+-------------+--------------------------------------------------------+
| `cpowf()`_  | Power, float complex.                                  |
+-------------+--------------------------------------------------------+
| `cpowl()`_  | Power, long double complex.                            |
+-------------+--------------------------------------------------------+
| `csqrt()`_  | Square root, double complex.                           |
+-------------+--------------------------------------------------------+
| `csqrtf()`_ | Square root, float complex.                            |
+-------------+--------------------------------------------------------+
| `csqrtl()`_ | Square root, long double complex.                      |
+-------------+--------------------------------------------------------+

.. _cabs-1:

cabs()
''''''

Description

Compute magnitude, double complex.

Prototype

::

   double cabs(__SEGGER_RTL_FLOAT64_C_COMPLEX x);

Parameters

+------------------+---------------------------------------------------+
| Parameter        | Description                                       |
+==================+===================================================+
| x                | Value to compute magnitude of.                    |
+------------------+---------------------------------------------------+

Return value

The magnitude of x, \|x\|.

.. _cabsf-1:

cabsf()
'''''''

Description

Compute magnitude, float complex.

Prototype

::

   float cabsf(__SEGGER_RTL_FLOAT32_C_COMPLEX x);

Parameters

+------------------+---------------------------------------------------+
| Parameter        | Description                                       |
+==================+===================================================+
| x                | Value to compute magnitude of.                    |
+------------------+---------------------------------------------------+

Return value

The magnitude of x, \|x\|.

.. _cabsl-1:

cabsl()
'''''''

Description

Compute magnitude, long double complex.

Prototype

::

   long double cabsl(__SEGGER_RTL_LDOUBLE_C_COMPLEX x);

Parameters

+------------------+---------------------------------------------------+
| Parameter        | Description                                       |
+==================+===================================================+
| x                | Value to compute magnitude of.                    |
+------------------+---------------------------------------------------+

Return value

The magnitude of x, \|x\|.

cpow()
''''''

Description

Power, double complex.

Prototype

::

   __SEGGER_RTL_FLOAT64_C_COMPLEX cpow(__SEGGER_RTL_FLOAT64_C_COMPLEX x,
                                       __SEGGER_RTL_FLOAT64_C_COMPLEX y);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Base.                              |
+---------------------------------+------------------------------------+
| y                               | Power.                             |
+---------------------------------+------------------------------------+

Return value

Return x raised to the power of y.

cpowf()
'''''''

Description

Power, float complex.

Prototype

::

   __SEGGER_RTL_FLOAT32_C_COMPLEX cpowf(__SEGGER_RTL_FLOAT32_C_COMPLEX x,
                                        __SEGGER_RTL_FLOAT32_C_COMPLEX y);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Base.                              |
+---------------------------------+------------------------------------+
| y                               | Power.                             |
+---------------------------------+------------------------------------+

Return value

Return x raised to the power of y.

cpowl()
'''''''

Description

Power, long double complex.

Prototype

::

   __SEGGER_RTL_LDOUBLE_C_COMPLEX cpowl(__SEGGER_RTL_LDOUBLE_C_COMPLEX x,
                                        __SEGGER_RTL_LDOUBLE_C_COMPLEX y);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Base.                              |
+---------------------------------+------------------------------------+
| y                               | Power.                             |
+---------------------------------+------------------------------------+

Return value

Return x raised to the power of y.

csqrt()
'''''''

Description

Square root, double complex.

Prototype

::

   __SEGGER_RTL_FLOAT64_C_COMPLEX csqrt(__SEGGER_RTL_FLOAT64_C_COMPLEX x);

Parameters

+------------------+---------------------------------------------------+
| Parameter        | Description                                       |
+==================+===================================================+
| x                | Value to compute squate root of.                  |
+------------------+---------------------------------------------------+

Return value

The square root of x according to the following table:

+--------------+-------------------------------------------------------+
| Argument     | csqrt(Argument)                                       |
+==============+=======================================================+
| ±0 + 0i      | +0 + 0i                                               |
+--------------+-------------------------------------------------------+
| a + ∞i       | +∞ + ∞i, for all a                                    |
+--------------+-------------------------------------------------------+
| a + NaNi     | +NaN + NaNi, for finite a                             |
+--------------+-------------------------------------------------------+
| -∞ + bi      | +0 + ∞i for finite positive-signed b                  |
+--------------+-------------------------------------------------------+
| +∞ + bi      | +∞ + 0i, for finite positive-signed b                 |
+--------------+-------------------------------------------------------+
| +∞ + ∞i      | +∞ + ¼πi                                              |
+--------------+-------------------------------------------------------+
| -∞ + NaNi    | +NaN + +/∞i, sign of imaginary part unspecified       |
+--------------+-------------------------------------------------------+
| +∞ + NaNi    | +∞ + NaNi                                             |
+--------------+-------------------------------------------------------+
| NaN + bi     | NaN + NaNi, for finite b                              |
+--------------+-------------------------------------------------------+
| NaN + ∞i     | +∞ + ∞i                                               |
+--------------+-------------------------------------------------------+
| NaN + NaNi   | NaN + NaNi                                            |
+--------------+-------------------------------------------------------+

For arguments with a negative imaginary component, use the equality:

- csqrt(conj(z)) = conj(csqrt(z)).

csqrtf()
''''''''

Description

Square root, float complex.

Prototype

::

   __SEGGER_RTL_FLOAT32_C_COMPLEX csqrtf(__SEGGER_RTL_FLOAT32_C_COMPLEX x);

Parameters

+------------------+---------------------------------------------------+
| Parameter        | Description                                       |
+==================+===================================================+
| x                | Value to compute squate root of.                  |
+------------------+---------------------------------------------------+

Return value

The square root of x according to the following table:

+--------------+-------------------------------------------------------+
| Argument     | csqrt(Argument)                                       |
+==============+=======================================================+
| ±0 + 0i      | +0 + 0i                                               |
+--------------+-------------------------------------------------------+
| a + ∞i       | +∞ + ∞i, for all a                                    |
+--------------+-------------------------------------------------------+
| a + NaNi     | +NaN + NaNi, for finite a                             |
+--------------+-------------------------------------------------------+
| -∞ + bi      | +0 + ∞i for finite positive-signed b                  |
+--------------+-------------------------------------------------------+
| +∞ + bi      | +∞ + 0i, for finite positive-signed b                 |
+--------------+-------------------------------------------------------+
| +∞ + ∞i      | +∞ + ¼πi                                              |
+--------------+-------------------------------------------------------+
| -∞ + NaNi    | +NaN + +/∞i, sign of imaginary part unspecified       |
+--------------+-------------------------------------------------------+
| +∞ + NaNi    | +∞ + NaNi                                             |
+--------------+-------------------------------------------------------+
| NaN + bi     | NaN + NaNi, for finite b                              |
+--------------+-------------------------------------------------------+
| NaN + ∞i     | +∞ + ∞i                                               |
+--------------+-------------------------------------------------------+
| NaN + NaNi   | NaN + NaNi                                            |
+--------------+-------------------------------------------------------+

For arguments with a negative imaginary component, use the equality:

- csqrt(conj(z)) = conj(csqrt(z)).

csqrtl()
''''''''

Description

Square root, long double complex.

Prototype

::

   __SEGGER_RTL_LDOUBLE_C_COMPLEX csqrtl(__SEGGER_RTL_LDOUBLE_C_COMPLEX x);

Parameters

+------------------+---------------------------------------------------+
| Parameter        | Description                                       |
+==================+===================================================+
| x                | Value to compute squate root of.                  |
+------------------+---------------------------------------------------+

Return value

The square root of x according to the following table:

+--------------+-------------------------------------------------------+
| Argument     | csqrt(Argument)                                       |
+==============+=======================================================+
| ±0 + 0i      | +0 + 0i                                               |
+--------------+-------------------------------------------------------+
| a + ∞i       | +∞ + ∞i, for all a                                    |
+--------------+-------------------------------------------------------+
| a + NaNi     | +NaN + NaNi, for finite a                             |
+--------------+-------------------------------------------------------+
| -∞ + bi      | +0 + ∞i for finite positive-signed b                  |
+--------------+-------------------------------------------------------+
| +∞ + bi      | +∞ + 0i, for finite positive-signed b                 |
+--------------+-------------------------------------------------------+
| +∞ + ∞i      | +∞ + ¼πi                                              |
+--------------+-------------------------------------------------------+
| -∞ + NaNi    | +NaN + +/∞i, sign of imaginary part unspecified       |
+--------------+-------------------------------------------------------+
| +∞ + NaNi    | +∞ + NaNi                                             |
+--------------+-------------------------------------------------------+
| NaN + bi     | NaN + NaNi, for finite b                              |
+--------------+-------------------------------------------------------+
| NaN + ∞i     | +∞ + ∞i                                               |
+--------------+-------------------------------------------------------+
| NaN + NaNi   | NaN + NaNi                                            |
+--------------+-------------------------------------------------------+

For arguments with a negative imaginary component, use the equality:

- csqrt(conj(z)) = conj(csqrt(z)).

Exponential and logarithm functions
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

+------------+----------------------------------------------------------+
| Function   | Description                                              |
+============+==========================================================+
| `clog()`_  | Compute natural logarithm, double complex.               |
+------------+----------------------------------------------------------+
| `clogf()`_ | Compute natural logarithm, float complex.                |
+------------+----------------------------------------------------------+
| `clogl()`_ | Compute natural logarithm, long double complex.          |
+------------+----------------------------------------------------------+
| `cexp()`_  | Compute base-e exponential, double complex.              |
+------------+----------------------------------------------------------+
| `cexpf()`_ | Compute base-e exponential, float complex.               |
+------------+----------------------------------------------------------+
| `cexpl()`_ | Compute base-e exponential, long double complex.         |
+------------+----------------------------------------------------------+

clog()
''''''

Description

Compute natural logarithm, double complex.

Prototype

::

   __SEGGER_RTL_FLOAT64_C_COMPLEX clog(__SEGGER_RTL_FLOAT64_C_COMPLEX x);

Parameters

+-------------------+--------------------------------------------------+
| Parameter         | Description                                      |
+===================+==================================================+
| x                 | Value to compute logarithm of.                   |
+-------------------+--------------------------------------------------+

Return value

The natural logarithm of x according to the following table:

+---------------------+------------------------------------------------+
| Argument            | clog(Argument)                                 |
+=====================+================================================+
| -0 + 0i             | -∞ + πi                                        |
+---------------------+------------------------------------------------+
| +0 + 0i             | -∞ + 0i                                        |
+---------------------+------------------------------------------------+
| a + ∞i              | +∞ + ½πi, for finite a                         |
+---------------------+------------------------------------------------+
| a + NaNi            | NaN + NaNi, for finite a                       |
+---------------------+------------------------------------------------+
| -∞ + bi             | +∞ + πi, for finite positive b                 |
+---------------------+------------------------------------------------+
| +∞ + bi             | +∞ + 0i, for finite positive b                 |
+---------------------+------------------------------------------------+
| -∞ + ∞i             | +∞ + ¾πi                                       |
+---------------------+------------------------------------------------+
| +∞ + ∞i             | +∞ + ¼πi                                       |
+---------------------+------------------------------------------------+
| ±∞ + NaNi           | +∞ + NaNi                                      |
+---------------------+------------------------------------------------+
| NaN + bi            | NaN + NaNi, for finite b                       |
+---------------------+------------------------------------------------+
| NaN + ∞i            | +∞ + NaNi                                      |
+---------------------+------------------------------------------------+
| NaN + NaNi          | NaN + NaNi                                     |
+---------------------+------------------------------------------------+

For arguments with a negative imaginary component, use the equality:

- clog(conj(z)) = conj(clog(z)).

clogf()
'''''''

Description

Compute natural logarithm, float complex.

Prototype

::

   __SEGGER_RTL_FLOAT32_C_COMPLEX clogf(__SEGGER_RTL_FLOAT32_C_COMPLEX x);

Parameters

+-------------------+--------------------------------------------------+
| Parameter         | Description                                      |
+===================+==================================================+
| x                 | Value to compute logarithm of.                   |
+-------------------+--------------------------------------------------+

Return value

The natural logarithm of x according to the following table:

+---------------------+------------------------------------------------+
| Argument            | clog(Argument)                                 |
+=====================+================================================+
| -0 + 0i             | -∞ + πi                                        |
+---------------------+------------------------------------------------+
| +0 + 0i             | -∞ + 0i                                        |
+---------------------+------------------------------------------------+
| a + ∞i              | +∞ + ½πi, for finite a                         |
+---------------------+------------------------------------------------+
| a + NaNi            | NaN + NaNi, for finite a                       |
+---------------------+------------------------------------------------+
| -∞ + bi             | +∞ + πi, for finite positive b                 |
+---------------------+------------------------------------------------+
| +∞ + bi             | +∞ + 0i, for finite positive b                 |
+---------------------+------------------------------------------------+
| -∞ + ∞i             | +∞ + ¾πi                                       |
+---------------------+------------------------------------------------+
| +∞ + ∞i             | +∞ + ¼πi                                       |
+---------------------+------------------------------------------------+
| ±∞ + NaNi           | +∞ + NaNi                                      |
+---------------------+------------------------------------------------+
| NaN + bi            | NaN + NaNi, for finite b                       |
+---------------------+------------------------------------------------+
| NaN + ∞i            | +∞ + NaNi                                      |
+---------------------+------------------------------------------------+
| NaN + NaNi          | NaN + NaNi                                     |
+---------------------+------------------------------------------------+

For arguments with a negative imaginary component, use the equality:

- clog(conj(z)) = conj(clog(z)).

clogl()
'''''''

Description

Compute natural logarithm, long double complex.

Prototype

::

   __SEGGER_RTL_LDOUBLE_C_COMPLEX clogl(__SEGGER_RTL_LDOUBLE_C_COMPLEX x);

Parameters

+-------------------+--------------------------------------------------+
| Parameter         | Description                                      |
+===================+==================================================+
| x                 | Value to compute logarithm of.                   |
+-------------------+--------------------------------------------------+

Return value

The natural logarithm of x according to the following table:

+---------------------+------------------------------------------------+
| Argument            | clog(Argument)                                 |
+=====================+================================================+
| -0 + 0i             | -∞ + πi                                        |
+---------------------+------------------------------------------------+
| +0 + 0i             | -∞ + 0i                                        |
+---------------------+------------------------------------------------+
| a + ∞i              | +∞ + ½πi, for finite a                         |
+---------------------+------------------------------------------------+
| a + NaNi            | NaN + NaNi, for finite a                       |
+---------------------+------------------------------------------------+
| -∞ + bi             | +∞ + πi, for finite positive b                 |
+---------------------+------------------------------------------------+
| +∞ + bi             | +∞ + 0i, for finite positive b                 |
+---------------------+------------------------------------------------+
| -∞ + ∞i             | +∞ + ¾πi                                       |
+---------------------+------------------------------------------------+
| +∞ + ∞i             | +∞ + ¼πi                                       |
+---------------------+------------------------------------------------+
| ±∞ + NaNi           | +∞ + NaNi                                      |
+---------------------+------------------------------------------------+
| NaN + bi            | NaN + NaNi, for finite b                       |
+---------------------+------------------------------------------------+
| NaN + ∞i            | +∞ + NaNi                                      |
+---------------------+------------------------------------------------+
| NaN + NaNi          | NaN + NaNi                                     |
+---------------------+------------------------------------------------+

For arguments with a negative imaginary component, use the equality:

- clog(conj(z)) = conj(clog(z)).

cexp()
''''''

Description

Compute base-e exponential, double complex.

Prototype

::

   __SEGGER_RTL_FLOAT64_C_COMPLEX cexp(__SEGGER_RTL_FLOAT64_C_COMPLEX x);

Parameters

+------------------+---------------------------------------------------+
| Parameter        | Description                                       |
+==================+===================================================+
| x                | Value to compute exponential of.                  |
+------------------+---------------------------------------------------+

Return value

The base-e exponential of x=a+bi according to the following table:

+----------------+-----------------------------------------------------+
| Argument       | cexp(Argument)                                      |
+================+=====================================================+
| -/-0 + 0i      | +1 + 0i                                             |
+----------------+-----------------------------------------------------+
| a + ∞i         | NaN + NaNi, for finite a                            |
+----------------+-----------------------------------------------------+
| a + NaNi       | NaN + NaNi, for finite a                            |
+----------------+-----------------------------------------------------+
| +∞ + 0i        | +∞ + 0i, for finite positive b                      |
+----------------+-----------------------------------------------------+
| -∞ + bi        | +0 cis(b) for finite b                              |
+----------------+-----------------------------------------------------+
| +∞ + bi        | +∞ cis(b) for finite nonzero b                      |
+----------------+-----------------------------------------------------+
| -∞ + ∞i        | ±∞ + ±0i, signs unspecified                         |
+----------------+-----------------------------------------------------+
| +∞ + ∞i        | ±∞ + i.NaN, sign of real part unspecified           |
+----------------+-----------------------------------------------------+
| -∞ + NaNi      | ±0 + ±0i, signs unspecified                         |
+----------------+-----------------------------------------------------+
| +∞ + NaNi      | ±∞ + NaNi, sign of real part unspecified            |
+----------------+-----------------------------------------------------+
| NaN + 0i       | NaN + 0i                                            |
+----------------+-----------------------------------------------------+
| NaN + bi       | NaN + NaNi, for nonzero b                           |
+----------------+-----------------------------------------------------+
| NaN + NaNi     | NaN + NaNi                                          |
+----------------+-----------------------------------------------------+

For arguments with a negative imaginary component, use the equality

- cexp(conj(x)) = conj(cexp(x)).

cexpf()
'''''''

Description

Compute base-e exponential, float complex.

Prototype

::

   __SEGGER_RTL_FLOAT32_C_COMPLEX cexpf(__SEGGER_RTL_FLOAT32_C_COMPLEX x);

Parameters

+------------------+---------------------------------------------------+
| Parameter        | Description                                       |
+==================+===================================================+
| x                | Value to compute exponential of.                  |
+------------------+---------------------------------------------------+

Return value

The base-e exponential of x=a+bi according to the following table:

+----------------+-----------------------------------------------------+
| Argument       | cexp(Argument)                                      |
+================+=====================================================+
| -/-0 + 0i      | +1 + 0i                                             |
+----------------+-----------------------------------------------------+
| a + ∞i         | NaN + NaNi, for finite a                            |
+----------------+-----------------------------------------------------+
| a + NaNi       | NaN + NaNi, for finite a                            |
+----------------+-----------------------------------------------------+
| +∞ + 0i        | +∞ + 0i, for finite positive b                      |
+----------------+-----------------------------------------------------+
| -∞ + bi        | +0 cis(b) for finite b                              |
+----------------+-----------------------------------------------------+
| +∞ + bi        | +∞ cis(b) for finite nonzero b                      |
+----------------+-----------------------------------------------------+
| -∞ + ∞i        | ±∞ + ±0i, signs unspecified                         |
+----------------+-----------------------------------------------------+
| +∞ + ∞i        | ±∞ + i.NaN, sign of real part unspecified           |
+----------------+-----------------------------------------------------+
| -∞ + NaNi      | ±0 + ±0i, signs unspecified                         |
+----------------+-----------------------------------------------------+
| +∞ + NaNi      | ±∞ + NaNi, sign of real part unspecified            |
+----------------+-----------------------------------------------------+
| NaN + 0i       | NaN + 0i                                            |
+----------------+-----------------------------------------------------+
| NaN + bi       | NaN + NaNi, for nonzero b                           |
+----------------+-----------------------------------------------------+
| NaN + NaNi     | NaN + NaNi                                          |
+----------------+-----------------------------------------------------+

For arguments with a negative imaginary component, use the equality

- cexp(conj(x)) = conj(cexp(x)).

cexpl()
'''''''

Description

Compute base-e exponential, long double complex.

Prototype

::

   __SEGGER_RTL_LDOUBLE_C_COMPLEX cexpl(__SEGGER_RTL_LDOUBLE_C_COMPLEX x);

Parameters

+------------------+---------------------------------------------------+
| Parameter        | Description                                       |
+==================+===================================================+
| x                | Value to compute exponential of.                  |
+------------------+---------------------------------------------------+

Return value

The base-e exponential of x=a+bi according to the following table:

+----------------+-----------------------------------------------------+
| Argument       | cexp(Argument)                                      |
+================+=====================================================+
| -/-0 + 0i      | +1 + 0i                                             |
+----------------+-----------------------------------------------------+
| a + ∞i         | NaN + NaNi, for finite a                            |
+----------------+-----------------------------------------------------+
| a + NaNi       | NaN + NaNi, for finite a                            |
+----------------+-----------------------------------------------------+
| +∞ + 0i        | +∞ + 0i, for finite positive b                      |
+----------------+-----------------------------------------------------+
| -∞ + bi        | +0 cis(b) for finite b                              |
+----------------+-----------------------------------------------------+
| +∞ + bi        | +∞ cis(b) for finite nonzero b                      |
+----------------+-----------------------------------------------------+
| -∞ + ∞i        | ±∞ + ±0i, signs unspecified                         |
+----------------+-----------------------------------------------------+
| +∞ + ∞i        | ±∞ + i.NaN, sign of real part unspecified           |
+----------------+-----------------------------------------------------+
| -∞ + NaNi      | ±0 + ±0i, signs unspecified                         |
+----------------+-----------------------------------------------------+
| +∞ + NaNi      | ±∞ + NaNi, sign of real part unspecified            |
+----------------+-----------------------------------------------------+
| NaN + 0i       | NaN + 0i                                            |
+----------------+-----------------------------------------------------+
| NaN + bi       | NaN + NaNi, for nonzero b                           |
+----------------+-----------------------------------------------------+
| NaN + NaNi     | NaN + NaNi                                          |
+----------------+-----------------------------------------------------+

For arguments with a negative imaginary component, use the equality

- cexp(conj(x)) = conj(cexp(x)).

<ctype.h>
~~~~~~~~~

Classification functions
^^^^^^^^^^^^^^^^^^^^^^^^

+-----------------+-------------------------------------------------------------+
| Function        | Description                                                 |
+=================+=============================================================+
| `iscntrl()`_    | Is character a control?                                     |
+-----------------+-------------------------------------------------------------+
| `iscntrl_l()`_  | Is character a control, per locale? (POSIX.1).              |
+-----------------+-------------------------------------------------------------+
| `isblank()`_    | Is character a blank?                                       |
+-----------------+-------------------------------------------------------------+
| `isblank_l()`_  | Is character a blank, per locale? (POSIX.1).                |
+-----------------+-------------------------------------------------------------+
| `isspace()`_    | Is character a whitespace character?                        |
+-----------------+-------------------------------------------------------------+
| `isspace_l()`_  | Is character a whitespace character, per locale? (POSIX.1). |
+-----------------+-------------------------------------------------------------+
| `ispunct()`_    | Is character a punctuation mark?                            |
+-----------------+-------------------------------------------------------------+
| `ispunct_l()`_  | Is character a punctuation mark, per locale? (POSIX.1).     |
+-----------------+-------------------------------------------------------------+
| `isdigit()`_    | Is character a decimal digit?                               |
+-----------------+-------------------------------------------------------------+
| `isdigit_l()`_  | Is character a decimal digit, per locale? (POSIX.           |
+-----------------+-------------------------------------------------------------+
| `isxdigit()`_   | Is character a hexadecimal digit?                           |
+-----------------+-------------------------------------------------------------+
| `isxdigit_l()`_ | Is character a hexadecimal digit, per locale? (POSIX.1).    |
+-----------------+-------------------------------------------------------------+
| `isalpha()`_    | Is character alphabetic?                                    |
+-----------------+-------------------------------------------------------------+
| `isalpha_l()`_  | Is character alphabetic, per locale? (POSIX.1).             |
+-----------------+-------------------------------------------------------------+
| `isalnum()`_    | Is character alphanumeric?                                  |
+-----------------+-------------------------------------------------------------+
| `isalnum_l()`_  | Is character alphanumeric, per locale? (POSIX.1).           |
+-----------------+-------------------------------------------------------------+
| `isupper()`_    | Is character an uppercase letter?                           |
+-----------------+-------------------------------------------------------------+
| `isupper_l()`_  | Is character an uppercase letter, per locale? (POSIX.1).    |
+-----------------+-------------------------------------------------------------+
| `islower()`_    | Is character a lowercase letter?                            |
+-----------------+-------------------------------------------------------------+
| `islower_l()`_  | Is character a lowercase letter, per locale? (POSIX.1).     |
+-----------------+-------------------------------------------------------------+
| `isprint()`_    | Is character printable?                                     |
+-----------------+-------------------------------------------------------------+
| `isprint_l()`_  | Is character printable, per locale? (POSIX.1).              |
+-----------------+-------------------------------------------------------------+
| `isgraph()`_    | Is character any printing character?                        |
+-----------------+-------------------------------------------------------------+
| `isgraph_l()`_  | Is character any printing character, per locale? (POSIX.1). |
+-----------------+-------------------------------------------------------------+

iscntrl()
'''''''''

Description

Is character a control?

Prototype

::

   int iscntrl(int c);

Parameters

+---------------------------+------------------------------------------+
| Parameter                 | Description                              |
+===========================+==========================================+
| c                         | Character to test.                       |
+---------------------------+------------------------------------------+

Return value

Returns nonzero (true) if and only if the value of the argument c is a control character in the current locale.

iscntrl_l()
'''''''''''

Description

Is character a control, per locale? (POSIX.1).

Prototype

::

   int iscntrl_l(int c,
                     locale_t loc);

Parameters

+------------------------+---------------------------------------------+
| Parameter              | Description                                 |
+========================+=============================================+
| c                      | Character to test.                          |
+------------------------+---------------------------------------------+
| loc                    | Locale used to test c.                      |
+------------------------+---------------------------------------------+

Return value

Returns nonzero (true) if and only if the value of the argument c is a control character in the locale loc.

Notes

Conforms to POSIX.1-2017.

isblank()
'''''''''

Description

Is character a blank?

Prototype

::

   int isblank(int c);

Parameters

+---------------------------+------------------------------------------+
| Parameter                 | Description                              |
+===========================+==========================================+
| c                         | Character to test.                       |
+---------------------------+------------------------------------------+

Return value

Returns nonzero (true) if and only if the value of the argument c is either a space character or tab character in the current locale.

isblank_l()
'''''''''''

Description

Is character a blank, per locale? (POSIX.1).

Prototype

::

   int isblank_l(int c,
                     locale_t loc);

Parameters

+------------------------+---------------------------------------------+
| Parameter              | Description                                 |
+========================+=============================================+
| c                      | Character to test.                          |
+------------------------+---------------------------------------------+
| loc                    | Locale used to test c.                      |
+------------------------+---------------------------------------------+

Return value

Returns nonzero (true) if and only if the value of the argument c is either a space character or the tab character in locale loc.

Notes

Conforms to POSIX.1-2017.

isspace()
'''''''''

Description

Is character a whitespace character?

Prototype

::

   int isspace(int c);

Parameters

+---------------------------+------------------------------------------+
| Parameter                 | Description                              |
+===========================+==========================================+
| c                         | Character to test.                       |
+---------------------------+------------------------------------------+

Return value

Returns nonzero (true) if and only if the value of the argument c is a standard white-space character in the current locale. The standard white-space characters are space, form feed, new-line, carriage return, horizontal tab, and vertical tab.

isspace_l()
'''''''''''

Description

Is character a whitespace character, per locale? (POSIX.1).

Prototype

::

   int isspace_l(int c, locale_t loc);

Parameters

+------------------------+---------------------------------------------+
| Parameter              | Description                                 |
+========================+=============================================+
| c                      | Character to test.                          |
+------------------------+---------------------------------------------+
| loc                    | Locale used to test c.                      |
+------------------------+---------------------------------------------+

Return value

Returns nonzero (true) if and only if the value of the argument c is a standard white-space character in the locale loc.

Notes

Conforms to POSIX.1-2017.

ispunct()
'''''''''

Description

Is character a punctuation mark?

Prototype

::

   int ispunct(int c);

Parameters

+---------------------------+------------------------------------------+
| Parameter                 | Description                              |
+===========================+==========================================+
| c                         | Character to test.                       |
+---------------------------+------------------------------------------+

Return value

Returns nonzero (true) for every printing character for which neither `isspace()`_ nor `isalnum()`_ is true in the current locale.

ispunct_l()
'''''''''''

Description

Is character a punctuation mark, per locale? (POSIX.1).

Prototype

::

   int ispunct_l(int c, locale_t loc);

Parameters

+------------------------+---------------------------------------------+
| Parameter              | Description                                 |
+========================+=============================================+
| c                      | Character to test.                          |
+------------------------+---------------------------------------------+
| loc                    | Locale used to test c.                      |
+------------------------+---------------------------------------------+

Return value

Returns nonzero (true) for every printing character for which neither `isspace()`_ nor `isalnum()`_ is true in the locale loc.

Notes

Conforms to POSIX.1-2017.

isdigit()
'''''''''

Description

Is character a decimal digit?

Prototype

::

   int isdigit(int c);

Parameters

+---------------------------+------------------------------------------+
| Parameter                 | Description                              |
+===========================+==========================================+
| c                         | Character to test.                       |
+---------------------------+------------------------------------------+

Return value

Returns nonzero (true) if and only if the value of the argument c is a digit in the current locale.

isdigit_l()
'''''''''''

Description

Is character a decimal digit, per locale? (POSIX.1)

Prototype

::

   int isdigit_l(int c, locale_t loc);

Parameters

+------------------------+---------------------------------------------+
| Parameter              | Description                                 |
+========================+=============================================+
| c                      | Character to test.                          |
+------------------------+---------------------------------------------+
| loc                    | Locale used to test c.                      |
+------------------------+---------------------------------------------+

Return value

Returns nonzero (true) if and only if the value of the argument c is a digit in the locale loc.

Notes

Conforms to POSIX.1-2017.

isxdigit()
''''''''''

Description

Is character a hexadecimal digit?

Prototype

::

   int isxdigit(int c);

Parameters

+---------------------------+------------------------------------------+
| Parameter                 | Description                              |
+===========================+==========================================+
| c                         | Character to test.                       |
+---------------------------+------------------------------------------+

Return value

Returns nonzero (true) if and only if the value of the argument c is a hexadecimal digit in the current locale.

isxdigit_l()
''''''''''''

Description

Is character a hexadecimal digit, per locale? (POSIX.1).

Prototype

::

   int isxdigit_l(int c, locale_t loc);

Parameters

+------------------------+---------------------------------------------+
| Parameter              | Description                                 |
+========================+=============================================+
| c                      | Character to test.                          |
+------------------------+---------------------------------------------+
| loc                    | Locale used to test c.                      |
+------------------------+---------------------------------------------+

Return value

Returns nonzero (true) if and only if the value of the argument c is a hexadecimal digit in the current locale.

Notes

Conforms to POSIX.1-2017.

isalpha()
'''''''''

Description

Is character alphabetic?

Prototype

::

   int isalpha(int c);

Parameters

+---------------------------+------------------------------------------+
| Parameter                 | Description                              |
+===========================+==========================================+
| c                         | Character to test.                       |
+---------------------------+------------------------------------------+

Return value

Returns true if the character c is alphabetic in the current locale. That is, any character for which `isupper()`_ or `islower()`_ returns true is considered alphabetic in addition to any of the locale-specific set of alphabetic characters for which none of `iscntrl()`_, `isdigit()`_, `ispunct()`_, or `isspace()`_ is true.

In the C locale, `isalpha()`_ returns nonzero (true) if and only if `isupper()`_ or `islower()`_ return true for value of the argument c.

isalpha_l()
'''''''''''

Description

Is character alphabetic, per locale? (POSIX.1).

Prototype

::

   int isalpha_l(int c, locale_t loc);

Parameters

+------------------------+---------------------------------------------+
| Parameter              | Description                                 |
+========================+=============================================+
| c                      | Character to test.                          |
+------------------------+---------------------------------------------+
| loc                    | Locale used to test c.                      |
+------------------------+---------------------------------------------+

Return value

Returns true if the character c is alphabetic in the locale loc. That is, any character for which `isupper()`_ or `islower()`_ returns true is considered alphabetic in addition to any of the locale-specific set of alphabetic characters for which none of `iscntrl_l()`_, `isdigit_l()`_, `ispunct_l()`_, or `isspace_l()`_ is true in the locale loc.

In the C locale, `isalpha_l()`_ returns nonzero (true) if and only if `isupper_l()`_ or `islower_l()`_ return true for value of the argument c.

Notes

Conforms to POSIX.1-2017.

isalnum()
'''''''''

Description

Is character alphanumeric?

Prototype

::

   int isalnum(int c);

Parameters

+---------------------------+------------------------------------------+
| Parameter                 | Description                              |
+===========================+==========================================+
| c                         | Character to test.                       |
+---------------------------+------------------------------------------+

Return value

Returns nonzero (true) if and only if the value of the argument c is an alphabetic or numeric character in the current locale.

isalnum_l()
'''''''''''

Description

Is character alphanumeric, per locale? (POSIX.1).

Prototype

::

   int isalnum_l(int c, locale_t loc);

Parameters

+------------------------+---------------------------------------------+
| Parameter              | Description                                 |
+========================+=============================================+
| c                      | Character to test.                          |
+------------------------+---------------------------------------------+
| loc                    | Locale used to test c.                      |
+------------------------+---------------------------------------------+

Return value

Returns nonzero (true) if and only if the value of the argument c is an alphabetic or numeric character in the locale loc.

Notes

Conforms to POSIX.1-2017.

isupper()
'''''''''

Description

Is character an uppercase letter?

Prototype

::

   int isupper(int c);

Parameters

+---------------------------+------------------------------------------+
| Parameter                 | Description                              |
+===========================+==========================================+
| c                         | Character to test.                       |
+---------------------------+------------------------------------------+

Return value

Returns nonzero (true) if and only if the value of the argument c is an uppercase letter in the current locale.

isupper_l()
'''''''''''

Description

Is character an uppercase letter, per locale? (POSIX.1).

Prototype

::

   int isupper_l(int c, locale_t loc);

Parameters

+------------------------+---------------------------------------------+
| Parameter              | Description                                 |
+========================+=============================================+
| c                      | Character to test.                          |
+------------------------+---------------------------------------------+
| loc                    | Locale used to test c.                      |
+------------------------+---------------------------------------------+

Return value

Returns nonzero (true) if and only if the value of the argument c is an uppercase letter in the locale loc.

Notes

Conforms to POSIX.1-2017.

islower()
'''''''''

Description

Is character a lowercase letter?

Prototype

::

   int islower(int c);

Parameters

+---------------------------+------------------------------------------+
| Parameter                 | Description                              |
+===========================+==========================================+
| c                         | Character to test.                       |
+---------------------------+------------------------------------------+

Return value

Returns nonzero (true) if and only if the value of the argument c is a lowercase letter in the current locale.

islower_l()
'''''''''''

Description

Is character a lowercase letter, per locale? (POSIX.1).

Prototype

::

   int islower_l(int c, locale_t loc);

Parameters

+------------------------+---------------------------------------------+
| Parameter              | Description                                 |
+========================+=============================================+
| c                      | Character to test.                          |
+------------------------+---------------------------------------------+
| loc                    | Locale used to test c.                      |
+------------------------+---------------------------------------------+

Return value

Returns nonzero (true) if and only if the value of the argument c is a lowercase letter in the locale loc.

Notes

Conforms to POSIX.1-2017.

isprint()
'''''''''

Description

Is character printable?

Prototype

::

   int isprint(int c);

Parameters

+---------------------------+------------------------------------------+
| Parameter                 | Description                              |
+===========================+==========================================+
| c                         | Character to test.                       |
+---------------------------+------------------------------------------+

Return value

Returns nonzero (true) if and only if the value of the argument c is any printing character including space in the current locale.

isprint_l()
'''''''''''

Description

Is character printable, per locale? (POSIX.1).

Prototype

::

   int isprint_l(int c, locale_t loc);

Parameters

+------------------------+---------------------------------------------+
| Parameter              | Description                                 |
+========================+=============================================+
| c                      | Character to test.                          |
+------------------------+---------------------------------------------+
| loc                    | Locale used to test c.                      |
+------------------------+---------------------------------------------+

Return value

Returns nonzero (true) if and only if the value of the argument c is any printing character including space in the locale loc.

Notes

Conforms to POSIX.1-2017.

isgraph()
'''''''''

Description

Is character any printing character?

Prototype

::

   int isgraph(int c);

Parameters

+---------------------------+------------------------------------------+
| Parameter                 | Description                              |
+===========================+==========================================+
| c                         | Character to test.                       |
+---------------------------+------------------------------------------+

Return value

Returns nonzero (true) if and only if the value of the argument c is any printing character except space in the current locale.

isgraph_l()
'''''''''''

Description

Is character any printing character, per locale? (POSIX.1).

Prototype

::

   int isgraph_l(int c, locale_t loc);

Parameters

+------------------------+---------------------------------------------+
| Parameter              | Description                                 |
+========================+=============================================+
| c                      | Character to test.                          |
+------------------------+---------------------------------------------+
| loc                    | Locale used to test c.                      |
+------------------------+---------------------------------------------+

Return value

Returns nonzero (true) if and only if the value of the argument c is any printing character except space in the locale loc.

Notes

Conforms to POSIX.1-2017.

Conversion functions
^^^^^^^^^^^^^^^^^^^^

+----------------+-----------------------------------------------------------------+
| Function       | Description                                                     |
+================+=================================================================+
| `toupper()`_   | Convert lowercase character to uppercase.                       |
+----------------+-----------------------------------------------------------------+
| `toupper_l()`_ | Convert lowercase character to uppercase, per locale (POSIX.1). |
+----------------+-----------------------------------------------------------------+
| `tolower()`_   | Convert uppercase character to lowercase.                       |
+----------------+-----------------------------------------------------------------+
| `tolower_l()`_ | Convert uppercase character to lowercase, per locale (POSIX.1). |
+----------------+-----------------------------------------------------------------+

toupper()
'''''''''

Description

Convert lowercase character to uppercase.

Prototype

::

   int toupper(int c);

Parameters

+------------------------+---------------------------------------------+
| Parameter              | Description                                 |
+========================+=============================================+
| c                      | Character to convert.                       |
+------------------------+---------------------------------------------+

Return value

Converted character.

Additional information

Converts a lowercase letter to a corresponding uppercase letter.

If the argument c is a character for which `islower()`_ is true and there are one or more corresponding characters, as specified by the current locale, for which `isupper()`_ is true, `toupper()`_ returns one of the corresponding characters (always the same one for any given locale); otherwise, the argument is returned unchanged.

Notes

Even though `islower()`_ can return true for some characters, `toupper()`_ may return that lowercase character unchanged as there are no corresponding uppercase characters in the locale.

toupper_l()
'''''''''''

Description

Convert lowercase character to uppercase, per locale (POSIX.1).

Prototype

::

   int toupper_l(int c, locale_t loc);

Parameters

+----------------------+-----------------------------------------------+
| Parameter            | Description                                   |
+======================+===============================================+
| c                    | Character to convert.                         |
+----------------------+-----------------------------------------------+
| loc                  | Locale used to convert c.                     |
+----------------------+-----------------------------------------------+

Return value

Converted character.

Additional information

Converts a lowercase letter to a corresponding uppercase letter in locale loc. If the argument c is a character for which `islower_l()`_ is true in locale loc, `tolower_l()`_ returns the corresponding uppercase letter; otherwise, the argument is returned unchanged.

Notes

Conforms to POSIX.1-2017.

tolower()
'''''''''

Description

Convert uppercase character to lowercase.

Prototype

::

   int tolower(int c);

Parameters

+------------------------+---------------------------------------------+
| Parameter              | Description                                 |
+========================+=============================================+
| c                      | Character to convert.                       |
+------------------------+---------------------------------------------+

Return value

Converted character.

Additional information

Converts an uppercase letter to a corresponding lowercase letter.

If the argument c is a character for which `isupper()`_ is true and there are one or more corresponding characters, as specified by the current locale, for which `islower()`_ is true, the `tolower()`_ function returns one of the corresponding characters (always the same one for any given locale); otherwise, the argument is returned unchanged.

Notes

Even though `isupper()`_ can return true for some characters, `tolower()`_ may return that uppercase character unchanged as there are no corresponding lowercase characters in the locale.

tolower_l()
'''''''''''

Description

Convert uppercase character to lowercase, per locale (POSIX.1).

Prototype

::

   int tolower_l(int c, locale_t loc);

Parameters

+----------------------+-----------------------------------------------+
| Parameter            | Description                                   |
+======================+===============================================+
| c                    | Character to convert.                         |
+----------------------+-----------------------------------------------+
| loc                  | Locale used to convert c.                     |
+----------------------+-----------------------------------------------+

Return value

Converted character.

Additional information

Converts an uppercase letter to a corresponding lowercase letter in locale loc. If the argument is a character for which `isupper_l()`_ is true in locale loc, `tolower_l()`_ returns the corresponding lowercase letter; otherwise, the argument is returned unchanged.

Notes

Conforms to POSIX.1-2017.

<errno.h>
~~~~~~~~~

Errors
^^^^^^

Error names
'''''''''''

Description

Symbolic error names for raised errors.

Definition

::

   #define EDOM      0x01
   #define EILSEQ    0x02
   #define ERANGE    0x03
   #define EHEAP     0x04
   #define ENOMEM    0x05
   #define EINVAL    0x06

Symbols

+---------------+------------------------------------------------------+
| Definition    | Description                                          |
+===============+======================================================+
| EDOM          | Domain error                                         |
+---------------+------------------------------------------------------+
| EILSEQ        | Illegal multibyte sequence in conversion             |
+---------------+------------------------------------------------------+
| ERANGE        | Range error                                          |
+---------------+------------------------------------------------------+
| EHEAP         | Heap is corrupt                                      |
+---------------+------------------------------------------------------+
| ENOMEM        | Out of memory                                        |
+---------------+------------------------------------------------------+
| EINVAL        | Invalid parameter                                    |
+---------------+------------------------------------------------------+

errno
'''''

Description

Macro returning the current error.

Definition

::

   #define errno    (*__SEGGER_RTL_X_errno_addr())

Additional information

The value in errno is significant only when the return value of the call indicated an error. A function that succeeds is allowed to change errno. The value of errno is never set to zero by a library function.

<fenv.h>
~~~~~~~~

Floating-point exceptions
^^^^^^^^^^^^^^^^^^^^^^^^^

+-------------------------+--------------------------------------------+
| Function                | Description                                |
+=========================+============================================+
| `feclearexcept()`_      | Clear floating-point exceptions.           |
+-------------------------+--------------------------------------------+
| `feraiseexcept()`_      | Raise floating-point exceptions.           |
+-------------------------+--------------------------------------------+
| `fegetexceptflag()`_    | Get floating-point exceptions.             |
+-------------------------+--------------------------------------------+
| `fesetexceptflag()`_    | Set floating-point exceptions.             |
+-------------------------+--------------------------------------------+
| `fetestexcept()`_       | Test floating-point exceptions.            |
+-------------------------+--------------------------------------------+

feclearexcept()
'''''''''''''''

Description

Clear floating-point exceptions.

Prototype

::

   int feclearexcept(int excepts);

Parameters

+--------------+-------------------------------------------------------+
| Parameter    | Description                                           |
+==============+=======================================================+
| excepts      | Bitmask of floating-point exceptions to clear.        |
+--------------+-------------------------------------------------------+

Return value

+-----+----------------------------------------------------------------+
| = 0 | Floating-point exceptions successfully cleared.                |
+-----+----------------------------------------------------------------+
| ≠ 0 | Floating-point exceptions not cleared or not supported.        |
+-----+----------------------------------------------------------------+

Additional information

This function attempts to clear the floating-point exceptions indicated by excepts.

Notes

This function has no return value in ISO C (1999) and an integer return value in ISO C (2008).

feraiseexcept()
'''''''''''''''

Description

Raise floating-point exceptions.

Prototype

::

   int feraiseexcept(int excepts);

Parameters

+--------------+-------------------------------------------------------+
| Parameter    | Description                                           |
+==============+=======================================================+
| excepts      | Bitmask of floating-point exceptions to raise.        |
+--------------+-------------------------------------------------------+

Return value

+-----+-------------------------------------------------------------------+
| = 0 | All floating-point exceptions successfully raised.                |
+-----+-------------------------------------------------------------------+
| ≠ 0 | Floating-point exceptions not successuly raised or not supported. |
+-----+-------------------------------------------------------------------+

Additional information

This function attempts to raise the floating-point exceptions indicated by excepts.

Notes

This function has no return value in ISO C (1999) and an integer return value in ISO C (2008).

fegetexceptflag()
'''''''''''''''''

Description

Get floating-point exceptions.

Prototype

::

   int fegetexceptflag(fexcept_t * flagp,
                       int         excepts);

Parameters

+-----------+---------------------------------------------------------------------+
| Parameter | Description                                                         |
+===========+=====================================================================+
| flagp     | Pointer to object that receives the floating-point exception state. |
+-----------+---------------------------------------------------------------------+
| excepts   | Bitmask of floating-point exceptions to store.                      |
+-----------+---------------------------------------------------------------------+

Return value

+------+---------------------------------------------------------------+
| = 0  | Floating-point exceptions correctly stored.                   |
+------+---------------------------------------------------------------+
| ≠ 0  | Floating-point exceptions not correctly stored.               |
+------+---------------------------------------------------------------+

Additional information

This function attempts to save the floating-point exceptions indicated by excepts to the object pointed to by flagp.

See also

`fesetexceptflag()`_.

fesetexceptflag()
'''''''''''''''''

Description

Set floating-point exceptions.

Prototype

::

   int fesetexceptflag(const fexcept_t * flagp,
                             int         excepts);

Parameters

+-----------+----------------------------------------------------------------------------------+
| Parameter | Description                                                                      |
+===========+==================================================================================+
| flagp     | Pointer to object containing a previously-stored floating-point exception state. |
+-----------+----------------------------------------------------------------------------------+
| excepts   | Bitmask of floating-point exceptions to restore.                                 |
+-----------+----------------------------------------------------------------------------------+

Return value

+-----+----------------------------------------------------------------+
| = 0 | Floating-point exceptions correctly restored.                  |
+-----+----------------------------------------------------------------+
| ≠ 0 | Floating-point exceptions not correctly restored.              |
+-----+----------------------------------------------------------------+

Additional information

This function attempts to restore the floating-point exceptions indicated by excepts from the object pointed to by flagp. The exceptions to restore as indicated by excepts must have at least been specified when storing the exceptions using `fegetexceptflag()`_.

See also

`fegetexceptflag()`_.

fetestexcept()
''''''''''''''

Description

Test floating-point exceptions.

Prototype

::

   int fetestexcept(int excepts);

Parameters

+--------------+-------------------------------------------------------+
| Parameter    | Description                                           |
+==============+=======================================================+
| excepts      | Bitmask of floating-point exceptions to test.         |
+--------------+-------------------------------------------------------+

Return value

The bitmask of all floating-point exceptions that are currently set and are specified in excepts.

Additional information

This function determines which of the floating-point exceptions indicated by excepts are currently set.

Floating-point rounding mode
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

+--------------------+-------------------------------------------------+
| Function           | Description                                     |
+====================+=================================================+
| `fegetround()`_    | Get floating-point rounding mode.               |
+--------------------+-------------------------------------------------+
| `fesetround()`_    | Set floating-point rounding mode.               |
+--------------------+-------------------------------------------------+

fegetround()
''''''''''''

Description

Get floating-point rounding mode.

Prototype

::

   int fegetround(void);

Return value

+-----+----------------------------------------------------------------+
| ≥ 0 | Current floating-point rounding mode.                          |
+-----+----------------------------------------------------------------+
| < 0 | Floating-point rounding mode cannot be determined.             |
+-----+----------------------------------------------------------------+

Additional information

This function attempts to read the current floating-point rounding mode.

See also

`fesetround()`_.

fesetround()
''''''''''''

Description

Set floating-point rounding mode.

Prototype

::

   int fesetround(int round);

Parameters

+-----------------------+----------------------------------------------+
| Parameter             | Description                                  |
+=======================+==============================================+
| round                 | Rounding mode to set.                        |
+-----------------------+----------------------------------------------+

Return value

+-----+----------------------------------------------------------------+
| = 0 | Current floating-point rounding mode is set to round.          |
+-----+----------------------------------------------------------------+
| ≠ 0 | Requested floating-point rounding mode cannot be set.          |
+-----+----------------------------------------------------------------+

Additional information

This function attempts to set the current floating-point rounding mode to round.

See also

`fegetround()`_.

Floating-point environment
^^^^^^^^^^^^^^^^^^^^^^^^^^

+-------------------+------------------------------------------------------------+
| Function          | Description                                                |
+===================+============================================================+
| `fegetenv()`_     | Get floating-point environment.                            |
+-------------------+------------------------------------------------------------+
| `fesetenv()`_     | Set floating-point environment.                            |
+-------------------+------------------------------------------------------------+
| `feupdateenv()`_  | Restore floating-point environment and reraise exceptions. |
+-------------------+------------------------------------------------------------+
| `feholdexcept()`_ | Save floating-point environment and set non-stop mode.     |
+-------------------+------------------------------------------------------------+

fegetenv()
''''''''''

Description

Get floating-point environment.

Prototype

::

   int fegetenv(fenv_t * envp);

Parameters

+-----------+-----------------------------------------------------------------+
| Parameter | Description                                                     |
+===========+=================================================================+
| envp      | Pointer to object that receives the floating-point environment. |
+-----------+-----------------------------------------------------------------+

Return value

+-----+-----------------------------------------------------------------+
| = 0 | Current floating-point environment successfully stored.         |
+-----+-----------------------------------------------------------------+
| ≠ 0 | Floating-point environment cannot be stored.                    |
+-----+-----------------------------------------------------------------+

Additional information

This function attempts to store the current floating-point environment to the object pointed to by envp.

Notes

This function has no return value in ISO C (1999) and an integer return value in ISO C (2008).

See also

`fesetenv()`_.

fesetenv()
''''''''''

Description

Set floating-point environment.

Prototype

::

   int fesetenv(const fenv_t * envp);

Parameters

+-----------+----------------------------------------------------------------------------+
| Parameter | Description                                                                |
+===========+============================================================================+
| envp      | Pointer to object containing previously-stored floating-point environment. |
+-----------+----------------------------------------------------------------------------+

Return value

+-----+-----------------------------------------------------------------+
| = 0 | Current floating-point environment successfully restored.       |
+-----+-----------------------------------------------------------------+
| ≠ 0 | Floating-point environment cannot be restored.                  |
+-----+-----------------------------------------------------------------+

Additional information

This function attempts to restore the floating-point environment from the object pointed to by envp.

Notes

This function has no return value in ISO C (1999) and an integer return value in ISO C (2008).

See also

`fegetenv()`_.

feupdateenv()
'''''''''''''

Description

Restore floating-point environment and reraise exceptions.

Prototype

::

   int feupdateenv(const fenv_t * envp);

Parameters

+-----------+----------------------------------------------------------------------------+
| Parameter | Description                                                                |
+===========+============================================================================+
| envp      | Pointer to object containing previously-stored floating-point environment. |
+-----------+----------------------------------------------------------------------------+

Return value

+-----+-----------------------------------------------------------------+
| = 0 | Environment restored and exceptions raised successfully.        |
+-----+-----------------------------------------------------------------+
| ≠ 0 | Failed to restore environment and raise exceptions.             |
+-----+-----------------------------------------------------------------+

Additional information

This function attempts to save the currently raised floating-point exceptions, restore the floating-point environment from the object pointed to by envp, and raise the saved exceptions.

Notes

This function has no return value in ISO C (1999) and an integer return value in ISO C (2008).

feholdexcept()
''''''''''''''

Description

Save floating-point environment and set non-stop mode.

Prototype

::

   int feholdexcept(fenv_t * envp);

Parameters

+-----------+-----------------------------------------------------------------+
| Parameter | Description                                                     |
+===========+=================================================================+
| envp      | Pointer to object that receives the floating-point environment. |
+-----------+-----------------------------------------------------------------+

Return value

+-----+-----------------------------------------------------------------+
| = 0 | Environment stored and non-stop mode set successfully.          |
+-----+-----------------------------------------------------------------+
| ≠ 0 | Failed to store environment or set non-stop mode.               |
+-----+-----------------------------------------------------------------+

Additional information

This function function saves the current floating-point environment to the object pointed to by envp, clears the floating-point status flags, and then installs a non-stop mode for all floating-point exceptions

<float.h>
~~~~~~~~~

Floating-point constants
^^^^^^^^^^^^^^^^^^^^^^^^

Common parameters
'''''''''''''''''

Description

Applies to single-precision and double-precision formats.

Definition

::

   #define FLT_ROUNDS         1
   #define FLT_EVAL_METHOD    0
   #define FLT_RADIX          2
   #define DECIMAL_DIG        17

Symbols

+-----------------+------------------------------------------------------------------------------------------------------+
| Definition      | Description                                                                                          |
+=================+======================================================================================================+
| FLT_ROUNDS      | Rounding mode of floating-point addition is round to nearest.                                        |
+-----------------+------------------------------------------------------------------------------------------------------+
| FLT_EVAL_METHOD | All operations and constants are evaluated to the range and precision of the type.                   |
+-----------------+------------------------------------------------------------------------------------------------------+
| FLT_RADIX       | Radix of the exponent representation.                                                                |
+-----------------+------------------------------------------------------------------------------------------------------+
| DECIMAL_DIG     | Number of decimal digits that can be rounded to a floating-point number without change to the value. |
+-----------------+------------------------------------------------------------------------------------------------------+

Float parameters
''''''''''''''''

Description

IEEE 32-bit single-precision floating format parameters.

Definition

::

   #define FLT_MANT_DIG      24
   #define FLT_EPSILON       1.19209290E-07f
   #define FLT_DIG           6
   #define FLT_MIN_EXP       -125
   #define FLT_MIN           1.17549435E-38f
   #define FLT_MIN_10_EXP    -37
   #define FLT_MAX_EXP       +128
   #define FLT_MAX           3.40282347E+38f
   #define FLT_MAX_10_EXP    +38

Symbols

+----------------+------------------------------------------------------------------+
| Definition     | Description                                                      |
+================+==================================================================+
| FLT_MANT_DIG   | Number of base FLT_RADIX digits in the mantissa part of a float. |
+----------------+------------------------------------------------------------------+
| FLT_EPSILON    | Minimum positive number such that 1.0f + FLT_EPSILON ≠ 1.0f.     |
+----------------+------------------------------------------------------------------+
| FLT_DIG        | Number of decimal digits of precision of a float.                |
+----------------+------------------------------------------------------------------+
| FLT_MIN_EXP    | Minimum value of base FLT_RADIX in the exponent part of a float. |
+----------------+------------------------------------------------------------------+
| FLT_MIN        | Minimum value of a float.                                        |
+----------------+------------------------------------------------------------------+
| FLT_MIN_10_EXP | Minimum value in base 10 of the exponent part of a float.        |
+----------------+------------------------------------------------------------------+
| FLT_MAX_EXP    | Maximum value of base FLT_RADIX in the exponent part of a float. |
+----------------+------------------------------------------------------------------+
| FLT_MAX        | Maximum value of a float.                                        |
+----------------+------------------------------------------------------------------+
| FLT_MAX_10_EXP | Maximum value in base 10 of the exponent part of a float.        |
+----------------+------------------------------------------------------------------+

Double parameters
'''''''''''''''''

Description

IEEE 64-bit double-precision floating format parameters.

Definition

::

   #define DBL_MANT_DIG      53
   #define DBL_EPSILON       2.2204460492503131E-16
   #define DBL_DIG           15
   #define DBL_MIN_EXP       -1021
   #define DBL_MIN           2.2250738585072014E-308
   #define DBL_MIN_10_EXP    -307
   #define DBL_MAX_EXP       +1024
   #define DBL_MAX           1.7976931348623157E+308
   #define DBL_MAX_10_EXP    +308

Symbols

+----------------+-------------------------------------------------------------------+
| Definition     | Description                                                       |
+================+===================================================================+
| DBL_MANT_DIG   | Number of base DBL_RADIX digits in the mantissa part of a double. |
+----------------+-------------------------------------------------------------------+
| DBL_EPSILON    | Minimum positive number such that 1.0 + DBL_EPSILON ≠ 1.0.        |
+----------------+-------------------------------------------------------------------+
| DBL_DIG        | Number of decimal digits of precision of a double.                |
+----------------+-------------------------------------------------------------------+
| DBL_MIN_EXP    | Minimum value of base DBL_RADIX in the exponent part of a double. |
+----------------+-------------------------------------------------------------------+
| DBL_MIN        | Minimum value of a double.                                        |
+----------------+-------------------------------------------------------------------+
| DBL_MIN_10_EXP | Minimum value in base 10 of the exponent part of a double.        |
+----------------+-------------------------------------------------------------------+
| DBL_MAX_EXP    | Maximum value of base DBL_RADIX in the exponent part of a double. |
+----------------+-------------------------------------------------------------------+
| DBL_MAX        | Maximum value of a double.                                        |
+----------------+-------------------------------------------------------------------+
| DBL_MAX_10_EXP | Maximum value in base 10 of the exponent part of a double.        |
+----------------+-------------------------------------------------------------------+

<iso646.h>
~~~~~~~~~~

The header <iso646.h> defines macros that expand to the corresponding tokens to ease writing C programs with keyboards that do not have keys for frequently-used operators.

Macros
^^^^^^

Replacement macros
''''''''''''''''''

Description

Standard replacement macros.

Definition

::

   #define and       &&
   #define and_eq    &=
   #define bitand    &
   #define bitor     |
   #define compl     ~
   #define not       !
   #define not_eq    !=
   #define or        ||
   #define or_eq     |=
   #define xor       ^
   #define xor_eq    ^=

<limits.h>
~~~~~~~~~~

Minima and maxima
^^^^^^^^^^^^^^^^^

Character minima and maxima
'''''''''''''''''''''''''''

Description

Minimum and maximum values for character types.

Definition

::

   #define CHAR_BIT     8
   #define CHAR_MIN     0
   #define CHAR_MAX     255
   #define SCHAR_MAX    127
   #define SCHAR_MIN    (-128)
   #define UCHAR_MAX    255

Symbols

+------------+--------------------------------------------------------------------+
| Definition | Description                                                        |
+============+====================================================================+
| CHAR_BIT   | Number of bits for smallest object that is not a bit-field (byte). |
+------------+--------------------------------------------------------------------+
| CHAR_MIN   | Minimum value of a plain character.                                |
+------------+--------------------------------------------------------------------+
| CHAR_MAX   | Maximum value of a plain character.                                |
+------------+--------------------------------------------------------------------+
| SCHAR_MAX  | Maximum value of a signed character.                               |
+------------+--------------------------------------------------------------------+
| SCHAR_MIN  | Minimum value of a signed character.                               |
+------------+--------------------------------------------------------------------+
| UCHAR_MAX  | Maximum value of an unsigned character.                            |
+------------+--------------------------------------------------------------------+

Short integer minima and maxima
'''''''''''''''''''''''''''''''

Description

Minimum and maximum values for short integer types.

Definition

::

   #define SHRT_MIN     (-32767 - 1)
   #define SHRT_MAX     32767
   #define USHRT_MAX    65535

Symbols

+----------------+-----------------------------------------------------+
| Definition     | Description                                         |
+================+=====================================================+
| SHRT_MIN       | Minimum value of a short integer.                   |
+----------------+-----------------------------------------------------+
| SHRT_MAX       | Maximum value of a short integer.                   |
+----------------+-----------------------------------------------------+
| USHRT_MAX      | Maximum value of an unsigned short integer.         |
+----------------+-----------------------------------------------------+

Integer minima and maxima
'''''''''''''''''''''''''

Description

Minimum and maximum values for integer types.

Definition

::

   #define INT_MIN     (-2147483647 - 1)
   #define INT_MAX     2147483647
   #define UINT_MAX    4294967295u

Symbols

+----------------+-----------------------------------------------------+
| Definition     | Description                                         |
+================+=====================================================+
| INT_MIN        | Minimum value of an integer.                        |
+----------------+-----------------------------------------------------+
| INT_MAX        | Maximum value of an integer.                        |
+----------------+-----------------------------------------------------+
| UINT_MAX       | Maximum value of an unsigned integer.               |
+----------------+-----------------------------------------------------+

Long integer minima and maxima (32-bit)
'''''''''''''''''''''''''''''''''''''''

Description

Minimum and maximum values for long integer types.

Definition

::

   #define LONG_MIN     (-2147483647L - 1)
   #define LONG_MAX     2147483647L
   #define ULONG_MAX    4294967295uL

Symbols

+----------------+-----------------------------------------------------+
| Definition     | Description                                         |
+================+=====================================================+
| LONG_MIN       | Maximum value of a long integer.                    |
+----------------+-----------------------------------------------------+
| LONG_MAX       | Minimum value of a long integer.                    |
+----------------+-----------------------------------------------------+
| ULONG_MAX      | Maximum value of an unsigned long integer.          |
+----------------+-----------------------------------------------------+

Long integer minima and maxima (64-bit)
'''''''''''''''''''''''''''''''''''''''

Description

Minimum and maximum values for long integer types.

Definition

::

   #define LONG_MIN     (-9223372036854775807L - 1)
   #define LONG_MAX     9223372036854775807L
   #define ULONG_MAX    18446744073709551615uL

Symbols

+----------------+-----------------------------------------------------+
| Definition     | Description                                         |
+================+=====================================================+
| LONG_MIN       | Minimum value of a long integer.                    |
+----------------+-----------------------------------------------------+
| LONG_MAX       | Maximum value of a long integer.                    |
+----------------+-----------------------------------------------------+
| ULONG_MAX      | Maximum value of an unsigned long integer.          |
+----------------+-----------------------------------------------------+

Long long integer minima and maxima
'''''''''''''''''''''''''''''''''''

Description

Minimum and maximum values for long integer types.

Definition

::

   #define LLONG_MIN     (-9223372036854775807LL - 1)
   #define LLONG_MAX     9223372036854775807LL
   #define ULLONG_MAX    18446744073709551615uLL

Symbols

+----------------+-----------------------------------------------------+
| Definition     | Description                                         |
+================+=====================================================+
| LLONG_MIN      | Minimum value of a long long integer.               |
+----------------+-----------------------------------------------------+
| LLONG_MAX      | Maximum value of a long long integer.               |
+----------------+-----------------------------------------------------+
| ULLONG_MAX     | Maximum value of an unsigned long long integer.     |
+----------------+-----------------------------------------------------+

Multibyte characters
''''''''''''''''''''

Description

Maximum number of bytes in a multi-byte character.

Definition

::

   #define MB_LEN_MAX    4

Symbols

+-------------------------------------+--------------------------------+
| Definition                          | Description                    |
+=====================================+================================+
| MB_LEN_MAX                          | Maximum                        |
+-------------------------------------+--------------------------------+

Additional information

The maximum number of bytes in a multi-byte character for any supported locale. Unicode (ISO 10646) characters between 0x000000 and 0x10FFFF inclusive are supported which convert to a maximum of four bytes in the UTF-8 encoding.

<locale.h>
~~~~~~~~~~

Data types
^^^^^^^^^^

\__SEGGER_RTL_lconv
'''''''''''''''''''

Type definition

::

   typedef struct {
     char * decimal_point;
     char * thousands_sep;
     char * grouping;
     char * int_curr_symbol;
     char * currency_symbol;
     char * mon_decimal_point;
     char * mon_thousands_sep;
     char * mon_grouping;
     char * positive_sign;
     char * negative_sign;
     char   int_frac_digits;
     char   frac_digits;
     char   p_cs_precedes;
     char   p_sep_by_space;
     char   n_cs_precedes;
     char   n_sep_by_space;
     char   p_sign_posn;
     char   n_sign_posn;
     char   int_p_cs_precedes;
     char   int_n_cs_precedes;
     char   int_p_sep_by_space;
     char   int_n_sep_by_space;
     char   int_p_sign_posn;
     char   int_n_sign_posn;
   } __SEGGER_RTL_lconv;

Structure members

+--------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------+
| Member             | Description                                                                                                                                           |
+====================+=======================================================================================================================================================+
| decimal_point      | Decimal point separator.                                                                                                                              |
+--------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------+
| thousands_sep      | Separators used to delimit groups of digits to the left of the decimal point for non-monetary quantities.                                             |
+--------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------+
| grouping           | Specifies the amount of digits that form each of the groups to be separated by thousands_sep separator for non-monetary quantities.                   |
+--------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------+
| int_curr_symbol    | International currency symbol.                                                                                                                        |
+--------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------+
| currency_symbol    | Local currency symbol.                                                                                                                                |
+--------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------+
| mon_decimal_point  | Decimal-point separator used for monetary quantities.                                                                                                 |
+--------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------+
| mon_thousands_sep  | Separators used to delimit groups of digits to the left of the decimal point for monetary quantities.                                                 |
+--------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------+
| mon_grouping       | Specifies the amount of digits that form each of the groups to be separated by mon_thousands_sep separator for monetary quantities.                   |
+--------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------+
| positive_sign      | Sign to be used for nonnegative (positive or zero) monetary quantities.                                                                               |
+--------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------+
| negative_sign      | Sign to be used for negative monetary quantities.                                                                                                     |
+--------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------+
| int_frac_digits    | Amount of fractional digits to the right of the decimal point for monetary quantities in the international format.                                    |
+--------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------+
| frac_digits        | Amount of fractional digits to the right of the decimal point for monetary quantities in the local format.                                            |
+--------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------+
| p_cs_precedes      | Whether the currency symbol should precede nonnegative (positive or zero) monetary quantities.                                                        |
+--------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------+
| p_sep_by_space     | Whether a space should appear between the currency symbol and nonnegative (positive or zero) monetary quantities.                                     |
+--------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------+
| n_cs_precedes      | Whether the currency symbol should precede negative monetary quantities.                                                                              |
+--------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------+
| n_sep_by_space     | Whether a space should appear between the currency symbol and negative monetary quantities.                                                           |
+--------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------+
| p_sign_posn        | Position of the sign for nonnegative (positive or zero) monetary quantities.                                                                          |
+--------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------+
| n_sign_posn        | Position of the sign for negative monetary quantities.                                                                                                |
+--------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------+
| int_p_cs_precedes  | Whether int_curr_symbol precedes or succeeds the value for a nonnegative internationally formatted monetary quantity.                                 |
+--------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------+
| int_n_cs_precedes  | Whether int_curr_symbol precedes or succeeds the value for a negative internationally formatted monetary quantity.                                    |
+--------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------+
| int_p_sep_by_space | Value indicating the separation of the int_curr_symbol, the sign string, and the value for a nonnegative internationally formatted monetary quantity. |
+--------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------+
| int_n_sep_by_space | Value indicating the separation of the int_curr_symbol, the sign string, and the value for a negative internationally formatted monetary quantity.    |
+--------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------+
| int_p_sign_posn    | Value indicating the positioning of the positive_sign for a nonnegative internationally formatted monetary quantity.                                  |
+--------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------+
| int_n_sign_posn    | Value indicating the positioning of the positive_sign for a negative internationally formatted monetary quantity.                                     |
+--------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------+

Locale management
^^^^^^^^^^^^^^^^^

+-------------------------+--------------------------------------------+
| Function                | Description                                |
+=========================+============================================+
| `setlocale()`_          | Set locale.                                |
+-------------------------+--------------------------------------------+
| `localeconv()`_         | Get current locale data.                   |
+-------------------------+--------------------------------------------+

setlocale()
'''''''''''

Description

Set locale.

Prototype

::

   char *setlocale(      int    category,
                   const char * loc);

Parameters

+-----------+-------------------------------------------------------------------+
| Parameter | Description                                                       |
+===========+===================================================================+
| category  | Category of locale to set, see below.                             |
+-----------+-------------------------------------------------------------------+
| loc       | Pointer to name of locale to set or, if NULL, the current locale. |
+-----------+-------------------------------------------------------------------+

Return value

Returns the name of the current locale.

Additional information

The category parameter can have the following values:

+-------------+--------------------------------------------------------------------------+
| Value       | Description                                                              |
+=============+==========================================================================+
| LC_ALL      | Entire locale.                                                           |
+-------------+--------------------------------------------------------------------------+
| LC_COLLATE  | Affects strcoll() and strxfrm().                                         |
+-------------+--------------------------------------------------------------------------+
| LC_CTYPE    | Affects character handling.                                              |
+-------------+--------------------------------------------------------------------------+
| LC_MONETARY | Affects monetary formatting information.                                 |
+-------------+--------------------------------------------------------------------------+
| LC_NUMERIC  | Affects decimal-point character in I/O and string formatting operations. |
+-------------+--------------------------------------------------------------------------+
| LC_TIME     | Affects `strftime()`_.                                                   |
+-------------+--------------------------------------------------------------------------+

localeconv()
''''''''''''

Description

Get current locale data.

Prototype

::

    localeconv(void);

Return value

Returns a pointer to a structure of type lconv with the corresponding values for the current locale filled in.

<math.h>
~~~~~~~~

.. _exponential-and-logarithm-functions-1:

Exponential and logarithm functions
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

+---------------+----------------------------------------------------------+
| Function      | Description                                              |
+===============+==========================================================+
| `sqrt()`_     | Compute square root, double.                             |
+---------------+----------------------------------------------------------+
| `sqrtf()`_    | Compute square root, float.                              |
+---------------+----------------------------------------------------------+
| `sqrtl()`_    | Compute square root, long double.                        |
+---------------+----------------------------------------------------------+
| `cbrt()`_     | Compute cube root, double.                               |
+---------------+----------------------------------------------------------+
| `cbrtf()`_    | Compute cube root, float.                                |
+---------------+----------------------------------------------------------+
| `cbrtl()`_    | Compute cube root, long double.                          |
+---------------+----------------------------------------------------------+
| `rsqrt()`_    | Compute reciprocal square root, double.                  |
+---------------+----------------------------------------------------------+
| `rsqrtf()`_   | Compute reciprocal square root, float.                   |
+---------------+----------------------------------------------------------+
| `rsqrtl()`_   | Compute reciprocal square root, long double.             |
+---------------+----------------------------------------------------------+
| `exp()`_      | Compute base-e exponential, double.                      |
+---------------+----------------------------------------------------------+
| `expf()`_     | Compute base-e exponential, float.                       |
+---------------+----------------------------------------------------------+
| `expl()`_     | Compute base-e exponential, long double.                 |
+---------------+----------------------------------------------------------+
| `expm1()`_    | Compute base-e exponential, modified, double.            |
+---------------+----------------------------------------------------------+
| `expm1f()`_   | Compute base-e exponential, modified, float.             |
+---------------+----------------------------------------------------------+
| `expm1l()`_   | Compute base-e exponential, modified, long double.       |
+---------------+----------------------------------------------------------+
| `exp2()`_     | Compute base-2 exponential, double.                      |
+---------------+----------------------------------------------------------+
| `exp2f()`_    | Compute base-2 exponential, float.                       |
+---------------+----------------------------------------------------------+
| `exp2l()`_    | Compute base-2 exponential, long double.                 |
+---------------+----------------------------------------------------------+
| `exp10()`_    | Compute base-10 exponential, double.                     |
+---------------+----------------------------------------------------------+
| `exp10f()`_   | Compute base-10 exponential, float.                      |
+---------------+----------------------------------------------------------+
| `exp10l()`_   | Compute base-10 exponential, long double.                |
+---------------+----------------------------------------------------------+
| `frexp()`_    | Split to significand and exponent, double.               |
+---------------+----------------------------------------------------------+
| `frexpf()`_   | Split to significand and exponent, float.                |
+---------------+----------------------------------------------------------+
| `frexpl()`_   | Split to significand and exponent, long double.          |
+---------------+----------------------------------------------------------+
| `hypot()`_    | Compute magnitude of complex, double.                    |
+---------------+----------------------------------------------------------+
| `hypotf()`_   | Compute magnitude of complex, float.                     |
+---------------+----------------------------------------------------------+
| `hypotl()`_   | Compute magnitude of complex, long double.               |
+---------------+----------------------------------------------------------+
| `log()`_      | Compute natural logarithm, double.                       |
+---------------+----------------------------------------------------------+
| `logf()`_     | Compute natural logarithm, float.                        |
+---------------+----------------------------------------------------------+
| `logl()`_     | Compute natural logarithm, long double.                  |
+---------------+----------------------------------------------------------+
| `log2()`_     | Compute base-2 logarithm, double.                        |
+---------------+----------------------------------------------------------+
| `log2f()`_    | Compute base-2 logarithm, float.                         |
+---------------+----------------------------------------------------------+
| `log2l()`_    | Compute base-2 logarithm, long double.                   |
+---------------+----------------------------------------------------------+
| `log10()`_    | Compute common logarithm, double.                        |
+---------------+----------------------------------------------------------+
| `log10f()`_   | Compute common logarithm, float.                         |
+---------------+----------------------------------------------------------+
| `log10l()`_   | Compute common logarithm, long double.                   |
+---------------+----------------------------------------------------------+
| `logb()`_     | Radix-indpendent exponent, double.                       |
+---------------+----------------------------------------------------------+
| `logbf()`_    | Radix-indpendent exponent, float.                        |
+---------------+----------------------------------------------------------+
| `logbl()`_    | Radix-indpendent exponent, long double.                  |
+---------------+----------------------------------------------------------+
| `ilogb()`_    | Radix-independent exponent, double.                      |
+---------------+----------------------------------------------------------+
| `ilogbf()`_   | Radix-independent exponent, float.                       |
+---------------+----------------------------------------------------------+
| `ilogbl()`_   | Radix-independent exponent, long double.                 |
+---------------+----------------------------------------------------------+
| `log1p()`_    | Compute natural logarithm plus one, double.              |
+---------------+----------------------------------------------------------+
| `log1pf()`_   | Compute natural logarithm plus one, float.               |
+---------------+----------------------------------------------------------+
| `log1pl()`_   | Compute natural logarithm plus one, long double.         |
+---------------+----------------------------------------------------------+
| `ldexp()`_    | Scale by power of two, double.                           |
+---------------+----------------------------------------------------------+
| `ldexpf()`_   | Scale by power of two, float.                            |
+---------------+----------------------------------------------------------+
| `ldexpl()`_   | Scale by power of two, long double.                      |
+---------------+----------------------------------------------------------+
| `pow()`_      | Raise to power, double.                                  |
+---------------+----------------------------------------------------------+
| `powf()`_     | Raise to power, float.                                   |
+---------------+----------------------------------------------------------+
| `powl()`_     | Raise to power, long double.                             |
+---------------+----------------------------------------------------------+
| `scalbn()`_   | Scale, double.                                           |
+---------------+----------------------------------------------------------+
| `scalbnf()`_  | Scale, float.                                            |
+---------------+----------------------------------------------------------+
| `scalbnl()`_  | Scale, long double.                                      |
+---------------+----------------------------------------------------------+
| `scalbln()`_  | Scale, double.                                           |
+---------------+----------------------------------------------------------+
| `scalblnf()`_ | Scale, float.                                            |
+---------------+----------------------------------------------------------+
| `scalblnl()`_ | Scale, long double.                                      |
+---------------+----------------------------------------------------------+

sqrt()
''''''

Description

Compute square root, double.

Prototype

::

   double sqrt(double x);

Parameters

+------------------+---------------------------------------------------+
| Parameter        | Description                                       |
+==================+===================================================+
| x                | Value to compute square root of.                  |
+------------------+---------------------------------------------------+

Return value

- If x is zero, return x.
- If x is infinite, return x.
- If x is NaN, return x.
- If x < 0, return NaN.
- Else, return square root of x.

Additional information

`sqrt()`_ computes the nonnegative square root of x. C90 and C99 require that a domain error occurs if the argument is less than zero, `sqrt()`_ deviates and always uses IEC 60559 semantics.

sqrtf()
'''''''

Description

Compute square root, float.

Prototype

::

   float sqrtf(float x);

Parameters

+------------------+---------------------------------------------------+
| Parameter        | Description                                       |
+==================+===================================================+
| x                | Value to compute square root of.                  |
+------------------+---------------------------------------------------+

Return value

- If x is zero, return x.
- If x is infinite, return x.
- If x is NaN, return x.
- If x < 0, return NaN.
- Else, return square root of x.

Additional information

`sqrt()`_ computes the nonnegative square root of x. C90 and C99 require that a domain error occurs if the argument is less than zero, `sqrt()`_ deviates and always uses IEC 60559 semantics.

sqrtl()
'''''''

Description

Compute square root, long double.

Prototype

::

   long double sqrtl(long double x);

Parameters

+------------------+---------------------------------------------------+
| Parameter        | Description                                       |
+==================+===================================================+
| x                | Value to compute square root of.                  |
+------------------+---------------------------------------------------+

Return value

- If x is zero, return x.
- If x is infinite, return x.
- If x is NaN, return x.
- If x < 0, return NaN.
- Else, return square root of x.

Additional information

`sqrtl()`_ computes the nonnegative square root of x. C90 and C99 require that a domain error occurs if the argument is less than zero, `sqrtl()`_ deviates and always uses IEC 60559 semantics.

cbrt()
''''''

Description

Compute cube root, double.

Prototype

::

   double cbrt(double x);

Parameters

+-------------------+--------------------------------------------------+
| Parameter         | Description                                      |
+===================+==================================================+
| x                 | Value to compute cube root of.                   |
+-------------------+--------------------------------------------------+

Return value

- If x is zero, return x.
- If x is infinite, return x.
- If x is NaN, return x.
- Else, return cube root of x.

cbrtf()
'''''''

Description

Compute cube root, float.

Prototype

::

   float cbrtf(float x);

Parameters

+-------------------+--------------------------------------------------+
| Parameter         | Description                                      |
+===================+==================================================+
| x                 | Value to compute cube root of.                   |
+-------------------+--------------------------------------------------+

Return value

- If x is zero, return x.
- If x is infinite, return x.
- If x is NaN, return x.
- Else, return cube root of x.

cbrtl()
'''''''

Description

Compute cube root, long double.

Prototype

::

   long double cbrtl(long double x);

Parameters

+-------------------+--------------------------------------------------+
| Parameter         | Description                                      |
+===================+==================================================+
| x                 | Value to compute cube root of.                   |
+-------------------+--------------------------------------------------+

Return value

- If x is zero, return x.
- If x is infinite, return x.
- If x is NaN, return x.
- Else, return cube root of x.

rsqrt()
'''''''

Description

Compute reciprocal square root, double.

Prototype

::

   double rsqrt(double x);

Parameters

+--------------+-------------------------------------------------------+
| Parameter    | Description                                           |
+==============+=======================================================+
| x            | Value to compute reciprocal square root of.           |
+--------------+-------------------------------------------------------+

Return value

- If x is +/-zero, return +/-infinity.
- If x is positively infinite, return 0.
- If x is NaN, return x.
- If x < 0, return NaN.
- Else, return reciprocal square root of x.

rsqrtf()
''''''''

Description

Compute reciprocal square root, float.

Prototype

::

   float rsqrtf(float x);

Parameters

+--------------+-------------------------------------------------------+
| Parameter    | Description                                           |
+==============+=======================================================+
| x            | Value to compute reciprocal square root of.           |
+--------------+-------------------------------------------------------+

Return value

- If x is +/-zero, return +/-infinity.
- If x is positively infinite, return 0.
- If x is NaN, return x.
- If x < 0, return NaN.
- Else, return reciprocal square root of x.

rsqrtl()
''''''''

Description

Compute reciprocal square root, long double.

Prototype

::

   long double rsqrtl(long double x);

Parameters

+--------------+-------------------------------------------------------+
| Parameter    | Description                                           |
+==============+=======================================================+
| x            | Value to compute reciprocal square root of.           |
+--------------+-------------------------------------------------------+

Return value

- If x is +/-zero, return +/-infinity.
- If x is positively infinite, return 0.
- If x is NaN, return x.
- If x < 0, return NaN.
- Else, return reciprocal square root of x.

exp()
'''''

Description

Compute base-e exponential, double.

Prototype

::

   double exp(double x);

Parameters

+---------------+------------------------------------------------------+
| Parameter     | Description                                          |
+===============+======================================================+
| x             | Value to compute base-e exponential of.              |
+---------------+------------------------------------------------------+

Return value

- If x is NaN, return x.
- If x is positively infinite, return x.
- If x is negatively infinite, return 0.
- Else, return base-e exponential of x.

expf()
''''''

Description

Compute base-e exponential, float.

Prototype

::

   float expf(float x);

Parameters

+---------------+------------------------------------------------------+
| Parameter     | Description                                          |
+===============+======================================================+
| x             | Value to compute base-e exponential of.              |
+---------------+------------------------------------------------------+

Return value

- If x is NaN, return x.
- If x is positively infinite, return x.
- If x is negatively infinite, return 0.
- Else, return base-e exponential of x.

expl()
''''''

Description

Compute base-e exponential, long double.

Prototype

::

   long double expl(long double x);

Parameters

+---------------+------------------------------------------------------+
| Parameter     | Description                                          |
+===============+======================================================+
| x             | Value to compute base-e exponential of.              |
+---------------+------------------------------------------------------+

Return value

- If x is NaN, return x.
- If x is positively infinite, return x.
- If x is negatively infinite, return 0.
- Else, return base-e exponential of x.

expm1()
'''''''

Description

Compute base-e exponential, modified, double.

Prototype

::

   double expm1(double x);

Parameters

+------------------+---------------------------------------------------+
| Parameter        | Description                                       |
+==================+===================================================+
| x                | Value to compute exponential of.                  |
+------------------+---------------------------------------------------+

Return value

- If x is NaN, return x.
- Else, return base-e exponential of x minus 1 (e**x - 1).

expm1f()
''''''''

Description

Compute base-e exponential, modified, float.

Prototype

::

   float expm1f(float x);

Parameters

+------------------+---------------------------------------------------+
| Parameter        | Description                                       |
+==================+===================================================+
| x                | Value to compute exponential of.                  |
+------------------+---------------------------------------------------+

Return value

- If x is NaN, return x.
- Else, return base-e exponential of x minus 1 (e**x - 1).

expm1l()
''''''''

Description

Compute base-e exponential, modified, long double.

Prototype

::

   long double expm1l(long double x);

Parameters

+------------------+---------------------------------------------------+
| Parameter        | Description                                       |
+==================+===================================================+
| x                | Value to compute exponential of.                  |
+------------------+---------------------------------------------------+

Return value

- If x is NaN, return x.
- Else, return base-e exponential of x minus 1 (e**x - 1).

exp2()
''''''

Description

Compute base-2 exponential, double.

Prototype

::

   double exp2(double x);

Parameters

+---------------+------------------------------------------------------+
| Parameter     | Description                                          |
+===============+======================================================+
| x             | Value to compute base-2 exponential of.              |
+---------------+------------------------------------------------------+

Return value

- If x is NaN, return x.
- If x is positively infinite, return x.
- If x is negatively infinite, return 0.
- Else, return base-e exponential of x.

exp2f()
'''''''

Description

Compute base-2 exponential, float.

Prototype

::

   float exp2f(float x);

Parameters

+---------------+------------------------------------------------------+
| Parameter     | Description                                          |
+===============+======================================================+
| x             | Value to compute base-e exponential of.              |
+---------------+------------------------------------------------------+

Return value

- If x is NaN, return x.
- If x is positively infinite, return x.
- If x is negatively infinite, return 0.
- Else, return base-e exponential of x.

exp2l()
'''''''

Description

Compute base-2 exponential, long double.

Prototype

::

   long double exp2l(long double x);

Parameters

+---------------+------------------------------------------------------+
| Parameter     | Description                                          |
+===============+======================================================+
| x             | Value to compute base-2 exponential of.              |
+---------------+------------------------------------------------------+

Return value

- If x is NaN, return x.
- If x is positively infinite, return x.
- If x is negatively infinite, return 0.
- Else, return base-e exponential of x.

exp10()
'''''''

Description

Compute base-10 exponential, double.

Prototype

::

   double exp10(double x);

Parameters

+---------------+------------------------------------------------------+
| Parameter     | Description                                          |
+===============+======================================================+
| x             | Value to compute base-e exponential of.              |
+---------------+------------------------------------------------------+

Return value

- If x is NaN, return x.
- If x is positively infinite, return x.
- If x is negatively infinite, return 0.
- Else, return base-e exponential of x.

exp10f()
''''''''

Description

Compute base-10 exponential, float.

Prototype

::

   float exp10f(float x);

Parameters

+---------------+------------------------------------------------------+
| Parameter     | Description                                          |
+===============+======================================================+
| x             | Value to compute base-e exponential of.              |
+---------------+------------------------------------------------------+

Return value

- If x is NaN, return x.
- If x is positively infinite, return x.
- If x is negatively infinite, return 0.
- Else, return base-e exponential of x.

exp10l()
''''''''

Description

Compute base-10 exponential, long double.

Prototype

::

   long double exp10l(long double x);

Parameters

+---------------+------------------------------------------------------+
| Parameter     | Description                                          |
+===============+======================================================+
| x             | Value to compute base-e exponential of.              |
+---------------+------------------------------------------------------+

Return value

- If x is NaN, return x.
- If x is positively infinite, return x.
- If x is negatively infinite, return 0.
- Else, return base-e exponential of x.

frexp()
'''''''

Description

Split to significand and exponent, double.

Prototype

::

   double frexp(double   x,
                int    * exp);

Parameters

+-----------+--------------------------------------------------------------+
| Parameter | Description                                                  |
+===========+==============================================================+
| x         | Floating value to operate on.                                |
+-----------+--------------------------------------------------------------+
| exp       | Pointer to integer receiving the power-of-two exponent of x. |
+-----------+--------------------------------------------------------------+

Return value

- If x is zero, infinite or NaN, return x and store zero into the integer pointed to by exp.
- Else, return the value f, such that f has a magnitude in the interval [0.5, 1) and x equals f \* pow(2, \*exp)

Additional information

Breaks a floating-point number into a normalized fraction and an integral power of two.

frexpf()
''''''''

Description

Split to significand and exponent, float.

Prototype

::

   float frexpf(float   x,
                int   * exp);

Parameters

+-----------+--------------------------------------------------------------+
| Parameter | Description                                                  |
+===========+==============================================================+
| x         | Floating value to operate on.                                |
+-----------+--------------------------------------------------------------+
| exp       | Pointer to integer receiving the power-of-two exponent of x. |
+-----------+--------------------------------------------------------------+

Return value

- If x is zero, infinite or NaN, return x and store zero into the integer pointed to by exp.
- Else, return the value f, such that f has a magnitude in the interval [0.5, 1) and x equals f \* pow(2, \*exp)

Additional information

Breaks a floating-point number into a normalized fraction and an integral power of two.

frexpl()
''''''''

Description

Split to significand and exponent, long double.

Prototype

::

   long double frexpl(long double   x,
                      int         * exp);

Parameters

+-----------+--------------------------------------------------------------+
| Parameter | Description                                                  |
+===========+==============================================================+
| x         | Floating value to operate on.                                |
+-----------+--------------------------------------------------------------+
| exp       | Pointer to integer receiving the power-of-two exponent of x. |
+-----------+--------------------------------------------------------------+

Return value

- If x is zero, infinite or NaN, return x and store zero into the integer pointed to by exp.
- Else, return the value f, such that f has a magnitude in the interval [0.5, 1) and x equals f \* pow(2, \*exp)

Additional information

Breaks a floating-point number into a normalized fraction and an integral power of two.

hypot()
'''''''

Description

Compute magnitude of complex, double.

Prototype

::

   double hypot(double x,
                double y);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Value #1.                          |
+---------------------------------+------------------------------------+
| y                               | Value #2.                          |
+---------------------------------+------------------------------------+

Return value

- If x or y are infinite, return infinity.
- If x or y is NaN, return NaN.
- Else, return sqrt(x*x + y*y).

Additional information

Computes the square root of the sum of the squares of x and y without undue overflow or underflow. If x and y are the lengths of the sides of a right-angled triangle, then this computes the length of the hypotenuse.

hypotf()
''''''''

Description

Compute magnitude of complex, float.

Prototype

::

   float hypotf(float x,
                float y);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Value #1.                          |
+---------------------------------+------------------------------------+
| y                               | Value #2.                          |
+---------------------------------+------------------------------------+

Return value

- If x or y are infinite, return infinity.
- If x or y is NaN, return NaN.
- Else, return sqrt(x*x + y*y).

Additional information

Computes the square root of the sum of the squares of x and y without undue overflow or underflow. If x and y are the lengths of the sides of a right-angled triangle, then this computes the length of the hypotenuse.

hypotl()
''''''''

Description

Compute magnitude of complex, long double.

Prototype

::

   long double hypotl(long double x,
                      long double y);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Value #1.                          |
+---------------------------------+------------------------------------+
| y                               | Value #2.                          |
+---------------------------------+------------------------------------+

Return value

- If x or y are infinite, return infinity.
- If x or y is NaN, return NaN.
- Else, return sqrtl(x*x + y*y).

Additional information

Computes the square root of the sum of the squares of x and y without undue overflow or underflow. If x and y are the lengths of the sides of a right-angled triangle, then this computes the length of the hypotenuse.

log()
'''''

Description

Compute natural logarithm, double.

Prototype

::

   double log(double x);

Parameters

+-------------------+--------------------------------------------------+
| Parameter         | Description                                      |
+===================+==================================================+
| x                 | Value to compute logarithm of.                   |
+-------------------+--------------------------------------------------+

Return value

- If x = NaN, return x.
- If x < 0, return NaN.
- If x = 0, return -∞.
- If x is +∞, return +∞.
- ELse, return base-e logarithm of x.

logf()
''''''

Description

Compute natural logarithm, float.

Prototype

::

   float logf(float x);

Parameters

+-------------------+--------------------------------------------------+
| Parameter         | Description                                      |
+===================+==================================================+
| x                 | Value to compute logarithm of.                   |
+-------------------+--------------------------------------------------+

Return value

- If x = NaN, return x.
- If x < 0, return NaN.
- If x = 0, return negative infinity.
- If x is positively infinite, return infinity.
- ELse, return base-e logarithm of x.

logl()
''''''

Description

Compute natural logarithm, long double.

Prototype

::

   long double logl(long double x);

Parameters

+-------------------+--------------------------------------------------+
| Parameter         | Description                                      |
+===================+==================================================+
| x                 | Value to compute logarithm of.                   |
+-------------------+--------------------------------------------------+

Return value

- If x = NaN, return x.
- If x < 0, return NaN.
- If x = 0, return -∞.
- If x is +∞, return +∞.
- ELse, return base-e logarithm of x.

log2()
''''''

Description

Compute base-2 logarithm, double.

Prototype

::

   double log2(double x);

Parameters

+-------------------+--------------------------------------------------+
| Parameter         | Description                                      |
+===================+==================================================+
| x                 | Value to compute logarithm of.                   |
+-------------------+--------------------------------------------------+

Return value

- If x = NaN, return x.
- If x < 0, return NaN.
- If x = 0, return negative infinity.
- If x is positively infinite, return infinity.
- ELse, return base-10 logarithm of x.

log2f()
'''''''

Description

Compute base-2 logarithm, float.

Prototype

::

   float log2f(float x);

Parameters

+-------------------+--------------------------------------------------+
| Parameter         | Description                                      |
+===================+==================================================+
| x                 | Value to compute logarithm of.                   |
+-------------------+--------------------------------------------------+

Return value

- If x = NaN, return x.
- If x < 0, return NaN.
- If x = 0, return negative infinity.
- If x is positively infinite, return infinity.
- ELse, return base-10 logarithm of x.

log2l()
'''''''

Description

Compute base-2 logarithm, long double.

Prototype

::

   long double log2l(long double x);

Parameters

+-------------------+--------------------------------------------------+
| Parameter         | Description                                      |
+===================+==================================================+
| x                 | Value to compute logarithm of.                   |
+-------------------+--------------------------------------------------+

Return value

- If x = NaN, return x.
- If x < 0, return NaN.
- If x = 0, return negative infinity.
- If x is positively infinite, return infinity.
- ELse, return base-10 logarithm of x.

log10()
'''''''

Description

Compute common logarithm, double.

Prototype

::

   double log10(double x);

Parameters

+-------------------+--------------------------------------------------+
| Parameter         | Description                                      |
+===================+==================================================+
| x                 | Value to compute logarithm of.                   |
+-------------------+--------------------------------------------------+

Return value

- If x = NaN, return x.
- If x < 0, return NaN.
- If x = 0, return negative infinity.
- If x is positively infinite, return infinity.
- ELse, return base-10 logarithm of x.

log10f()
''''''''

Description

Compute common logarithm, float.

Prototype

::

   float log10f(float x);

Parameters

+-------------------+--------------------------------------------------+
| Parameter         | Description                                      |
+===================+==================================================+
| x                 | Value to compute logarithm of.                   |
+-------------------+--------------------------------------------------+

Return value

- If x = NaN, return x.
- If x < 0, return NaN.
- If x = 0, return negative infinity.
- If x is positively infinite, return infinity.
- ELse, return base-10 logarithm of x.

log10l()
''''''''

Description

Compute common logarithm, long double.

Prototype

::

   long double log10l(long double x);

Parameters

+-------------------+--------------------------------------------------+
| Parameter         | Description                                      |
+===================+==================================================+
| x                 | Value to compute logarithm of.                   |
+-------------------+--------------------------------------------------+

Return value

- If x = NaN, return x.
- If x < 0, return NaN.
- If x = 0, return negative infinity.
- If x is positively infinite, return infinity.
- ELse, return base-10 logarithm of x.

logb()
''''''

Description

Radix-indpendent exponent, double.

Prototype

::

   double logb(double x);

Parameters

+--------------------+-------------------------------------------------+
| Parameter          | Description                                     |
+====================+=================================================+
| x                  | Floating value to operate on.                   |
+--------------------+-------------------------------------------------+

Return value

- If x is zero, return -∞.
- If x is infinite, return +∞.
- If x is NaN, return NaN.
- Else, return integer part of log\ :sub:`FLTRADIX`\ (x).

Additional information

Calculates the exponent of x, which is the integral part of the FLTRADIX-logarithm of x.

logbf()
'''''''

Description

Radix-indpendent exponent, float.

Prototype

::

   float logbf(float x);

Parameters

+--------------------+-------------------------------------------------+
| Parameter          | Description                                     |
+====================+=================================================+
| x                  | Floating value to operate on.                   |
+--------------------+-------------------------------------------------+

Return value

- If x is zero, return -∞.
- If x is infinite, return +∞.
- If x is NaN, return NaN.
- Else, return integer part of log\ :sub:`FLTRADIX`\ (x).

Additional information

Calculates the exponent of x, which is the integral part of the FLTRADIX-logarithm of x.

logbl()
'''''''

Description

Radix-indpendent exponent, long double.

Prototype

::

   long double logbl(long double x);

Parameters

+--------------------+-------------------------------------------------+
| Parameter          | Description                                     |
+====================+=================================================+
| x                  | Floating value to operate on.                   |
+--------------------+-------------------------------------------------+

Return value

- If x is zero, return -∞.
- If x is infinite, return +∞.
- If x is NaN, return NaN.
- Else, return integer part of log\ :sub:`FLTRADIX`\ (x).

Additional information

Calculates the exponent of x, which is the integral part of the FLTRADIX-logarithm of x.

ilogb()
'''''''

Description

Radix-independent exponent, double.

Prototype

::

   int ilogb(double x);

Parameters

+--------------------+-------------------------------------------------+
| Parameter          | Description                                     |
+====================+=================================================+
| x                  | Floating value to operate on.                   |
+--------------------+-------------------------------------------------+

Return value

- If x is zero, return FP_ILOGB0.
- If x is NaN, return FP_ILOGBNAN.
- If x is infinite, return MAX_INT.
- Else, return integer part of log\ :sub:`FLTRADIX`\ (x).

ilogbf()
''''''''

Description

Radix-independent exponent, float.

Prototype

::

   int ilogbf(float x);

Parameters

+--------------------+-------------------------------------------------+
| Parameter          | Description                                     |
+====================+=================================================+
| x                  | Floating value to operate on.                   |
+--------------------+-------------------------------------------------+

Return value

- If x is zero, return FP_ILOGB0.
- If x is NaN, return FP_ILOGBNAN.
- If x is infinite, return MAX_INT.
- Else, return integer part of log\ :sub:`FLTRADIX`\ (x).

ilogbl()
''''''''

Description

Radix-independent exponent, long double.

Prototype

::

   int ilogbl(long double x);

Parameters

+--------------------+-------------------------------------------------+
| Parameter          | Description                                     |
+====================+=================================================+
| x                  | Floating value to operate on.                   |
+--------------------+-------------------------------------------------+

Return value

- If x is zero, return FP_ILOGB0.
- If x is NaN, return FP_ILOGBNAN.
- If x is infinite, return MAX_INT.
- Else, return integer part of log\ :sub:`FLTRADIX`\ (x).

log1p()
'''''''

Description

Compute natural logarithm plus one, double.

Prototype

::

   double log1p(double x);

Parameters

+-------------------+--------------------------------------------------+
| Parameter         | Description                                      |
+===================+==================================================+
| x                 | Value to compute logarithm of.                   |
+-------------------+--------------------------------------------------+

Return value

- If x = NaN, return x.
- If x < 0, return NaN.
- If x = 0, return negative infinity.
- If x is positively infinite, return infinity.
- ELse, return base-e logarithm of x+1.

log1pf()
''''''''

Description

Compute natural logarithm plus one, float.

Prototype

::

   float log1pf(float x);

Parameters

+-------------------+--------------------------------------------------+
| Parameter         | Description                                      |
+===================+==================================================+
| x                 | Value to compute logarithm of.                   |
+-------------------+--------------------------------------------------+

Return value

- If x = NaN, return x.
- If x < 0, return NaN.
- If x = 0, return negative infinity.
- If x is positively infinite, return infinity.
- ELse, return base-e logarithm of x+1.

log1pl()
''''''''

Description

Compute natural logarithm plus one, long double.

Prototype

::

   long double log1pl(long double x);

Parameters

+-------------------+--------------------------------------------------+
| Parameter         | Description                                      |
+===================+==================================================+
| x                 | Value to compute logarithm of.                   |
+-------------------+--------------------------------------------------+

Return value

- If x = NaN, return x.
- If x < 0, return NaN.
- If x = 0, return negative infinity.
- If x is positively infinite, return infinity.
- ELse, return base-e logarithm of x+1.

ldexp()
'''''''

Description

Scale by power of two, double.

Prototype

::

   double ldexp(double x,
                int    n);

Parameters

+----------------------+-----------------------------------------------+
| Parameter            | Description                                   |
+======================+===============================================+
| x                    | Value to scale.                               |
+----------------------+-----------------------------------------------+
| n                    | Power of two to scale by.                     |
+----------------------+-----------------------------------------------+

Return value

- If x is ±0, return x;
- If x is ±∞, return x.
- If x is NaN, return x.
- Else, return x \* 2 ^ n.

Additional information

Multiplies a floating-point number by an integral power of two.

See also

`scalbn()`_

ldexpf()
''''''''

Description

Scale by power of two, float.

Prototype

::

   float ldexpf(float x,
                int   n);

Parameters

+----------------------+-----------------------------------------------+
| Parameter            | Description                                   |
+======================+===============================================+
| x                    | Value to scale.                               |
+----------------------+-----------------------------------------------+
| n                    | Power of two to scale by.                     |
+----------------------+-----------------------------------------------+

Return value

- If x is zero, return x;
- If x is infinite, return x.
- If x is NaN, return x.
- Else, return x \* 2^n.

Additional information

Multiplies a floating-point number by an integral power of two.

See also

`scalbnf()`_

ldexpl()
''''''''

Description

Scale by power of two, long double.

Prototype

::

   long double ldexpl(long double x,
                      int         n);

Parameters

+----------------------+-----------------------------------------------+
| Parameter            | Description                                   |
+======================+===============================================+
| x                    | Value to scale.                               |
+----------------------+-----------------------------------------------+
| n                    | Power of two to scale by.                     |
+----------------------+-----------------------------------------------+

Return value

- If x is ±0, return x;
- If x is ±∞, return x.
- If x is NaN, return x.
- Else, return x \* 2 ^ n.

Additional information

Multiplies a floating-point number by an integral power of two.

See also

`scalbn()`_

pow()
'''''

Description

Raise to power, double.

Prototype

::

   double pow(double x,
              double y);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Base.                              |
+---------------------------------+------------------------------------+
| y                               | Power.                             |
+---------------------------------+------------------------------------+

Return value

Return x raised to the power y.

powf()
''''''

Description

Raise to power, float.

Prototype

::

   float powf(float x,
              float y);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Base.                              |
+---------------------------------+------------------------------------+
| y                               | Power.                             |
+---------------------------------+------------------------------------+

Return value

Return x raised to the power y.

powl()
''''''

Description

Raise to power, long double.

Prototype

::

   long double powl(long double x,
                    long double y);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Base.                              |
+---------------------------------+------------------------------------+
| y                               | Power.                             |
+---------------------------------+------------------------------------+

Return value

Return x raised to the power y.

scalbn()
''''''''

Description

Scale, double.

Prototype

::

   double scalbn(double x,
                 int    n);

Parameters

+------------------+---------------------------------------------------+
| Parameter        | Description                                       |
+==================+===================================================+
| x                | Value to scale.                                   |
+------------------+---------------------------------------------------+
| n                | Power of DBL_RADIX to scale by.                   |
+------------------+---------------------------------------------------+

Return value

- If x is infinite, return x.
- If x is NaN, return x.
- Else, return x \* DBL_RADIX ^ n.

Additional information

Multiplies a floating-point number by an integral power of DBL_RADIX.

As floating-point arithmetic conforms to IEC 60559, DBL_RADIX is 2 and `scalbn()`_ is (in this implementation) identical to `ldexp()`_.

See also

`ldexp()`_

scalbnf()
'''''''''

Description

Scale, float.

Prototype

::

   float scalbnf(float x,
                 int   n);

Parameters

+------------------+---------------------------------------------------+
| Parameter        | Description                                       |
+==================+===================================================+
| x                | Value to scale.                                   |
+------------------+---------------------------------------------------+
| n                | Power of FLT_RADIX to scale by.                   |
+------------------+---------------------------------------------------+

Return value

- If x is infinite, return x.
- If x is NaN, return x.
- Else, return x \* FLT_RADIX ^ n.

Additional information

Multiplies a floating-point number by an integral power of FLT_RADIX.

As floating-point arithmetic conforms to IEC 60559, FLT_RADIX is 2 and `scalbnf()`_ is (in this implementation) identical to `ldexpf()`_.

See also

`ldexpf()`_

scalbnl()
'''''''''

Description

Scale, long double.

Prototype

::

   long double scalbnl(long double x,
                       int         n);

Parameters

+-----------------+----------------------------------------------------+
| Parameter       | Description                                        |
+=================+====================================================+
| x               | Value to scale.                                    |
+-----------------+----------------------------------------------------+
| n               | Power of LDBL_RADIX to scale by.                   |
+-----------------+----------------------------------------------------+

Return value

- If x is infinite, return x.
- If x is NaN, return x.
- Else, return x \* LDBL_RADIX ^ n.

Additional information

Multiplies a floating-point number by an integral power of LDBL_RADIX.

As floating-point arithmetic conforms to IEC 60559, LDBL_RADIX is 2 and `scalbnl()`_ is (in this implementation) identical to `ldexpl()`_.

See also

`ldexpl()`_

scalbln()
'''''''''

Description

Scale, double.

Prototype

::

   double scalbln(double x,
                  long   n);

Parameters

+------------------+---------------------------------------------------+
| Parameter        | Description                                       |
+==================+===================================================+
| x                | Value to scale.                                   |
+------------------+---------------------------------------------------+
| n                | Power of DBL_RADIX to scale by.                   |
+------------------+---------------------------------------------------+

Return value

- If x is infinite, return x.
- If x is NaN, return x.
- Else, return x \* DBL_RADIX ^ n.

Additional information

Multiplies a floating-point number by an integral power of DBL_RADIX.

As floating-point arithmetic conforms to IEC 60559, DBL_RADIX is 2 and `scalbln()`_ is (in this implementation) identical to `ldexp()`_.

See also

`ldexp()`_

scalblnf()
''''''''''

Description

Scale, float.

Prototype

::

   float scalblnf(float x,
                  long  n);

Parameters

+------------------+---------------------------------------------------+
| Parameter        | Description                                       |
+==================+===================================================+
| x                | Value to scale.                                   |
+------------------+---------------------------------------------------+
| n                | Power of FLT_RADIX to scale by.                   |
+------------------+---------------------------------------------------+

Return value

- If x is infinite, return x.
- If x is NaN, return x.
- Else, return x \* FLT_RADIX ^ n.

Additional information

Multiplies a floating-point number by an integral power of FLT_RADIX.

As floating-point arithmetic conforms to IEC 60559, FLT_RADIX is 2 and `scalbnf()`_ is (in this implementation) identical to `ldexpf()`_.

scalblnl()
''''''''''

Description

Scale, long double.

Prototype

::

   long double scalblnl(long double x,
                        long        n);

Parameters

+-----------------+----------------------------------------------------+
| Parameter       | Description                                        |
+=================+====================================================+
| x               | Value to scale.                                    |
+-----------------+----------------------------------------------------+
| n               | Power of LDBL_RADIX to scale by.                   |
+-----------------+----------------------------------------------------+

Return value

- If x is infinite, return x.
- If x is NaN, return x.
- Else, return x \* LDBL_RADIX ^ n.

Additional information

Multiplies a floating-point number by an integral power of LDBL_RADIX.

As floating-point arithmetic conforms to IEC 60559, LDBL_RADIX is 2 and `scalblnl()`_ is (in this implementation) identical to `ldexpl()`_.

See also

`ldexpl()`_

.. _trigonometric-functions-1:

Trigonometric functions
^^^^^^^^^^^^^^^^^^^^^^^

+-------------+--------------------------------------------------------+
| Function    | Description                                            |
+=============+========================================================+
| `sin()`_    | Calculate sine, double.                                |
+-------------+--------------------------------------------------------+
| `sinf()`_   | Calculate sine, float.                                 |
+-------------+--------------------------------------------------------+
| `sinl()`_   | Calculate sine, long double.                           |
+-------------+--------------------------------------------------------+
| `cos()`_    | Calculate cosine, double.                              |
+-------------+--------------------------------------------------------+
| `cosf()`_   | Calculate cosine, float.                               |
+-------------+--------------------------------------------------------+
| `cosl()`_   | Calculate cosine, long double.                         |
+-------------+--------------------------------------------------------+
| `tan()`_    | Compute tangent, double.                               |
+-------------+--------------------------------------------------------+
| `tanf()`_   | Compute tangent, float.                                |
+-------------+--------------------------------------------------------+
| `tanl()`_   | Compute tangent, long double.                          |
+-------------+--------------------------------------------------------+
| `sinh()`_   | Compute hyperbolic sine, double.                       |
+-------------+--------------------------------------------------------+
| `sinhf()`_  | Compute hyperbolic sine, float.                        |
+-------------+--------------------------------------------------------+
| `sinhl()`_  | Compute hyperbolic sine, long double.                  |
+-------------+--------------------------------------------------------+
| `cosh()`_   | Compute hyperbolic cosine, double.                     |
+-------------+--------------------------------------------------------+
| `coshf()`_  | Compute hyperbolic cosine, float.                      |
+-------------+--------------------------------------------------------+
| `coshl()`_  | Compute hyperbolic cosine, long double.                |
+-------------+--------------------------------------------------------+
| `tanh()`_   | Compute hyperbolic tangent, double.                    |
+-------------+--------------------------------------------------------+
| `tanhf()`_  | Compute hyperbolic tangent, float.                     |
+-------------+--------------------------------------------------------+
| `tanhl()`_  | Compute hyperbolic tangent, long double.               |
+-------------+--------------------------------------------------------+

sin()
'''''

Description

Calculate sine, double.

Prototype

::

   double sin(double x);

Parameters

+-----------------+----------------------------------------------------+
| Parameter       | Description                                        |
+=================+====================================================+
| x               | Angle to compute sine of, radians.                 |
+-----------------+----------------------------------------------------+

Return value

- If x is NaN, return x.
- If x is infinite, return NaN.
- Else, return circular sine of x.

sinf()
''''''

Description

Calculate sine, float.

Prototype

::

   float sinf(float x);

Parameters

+-----------------+----------------------------------------------------+
| Parameter       | Description                                        |
+=================+====================================================+
| x               | Angle to compute sine of, radians.                 |
+-----------------+----------------------------------------------------+

Return value

- If x is NaN, return x.
- If x is infinite, return NaN.
- Else, return circular sine of x.

sinl()
''''''

Description

Calculate sine, long double.

Prototype

::

   long double sinl(long double x);

Parameters

+-----------------+----------------------------------------------------+
| Parameter       | Description                                        |
+=================+====================================================+
| x               | Angle to compute sine of, radians.                 |
+-----------------+----------------------------------------------------+

Return value

- If x is NaN, return x.
- If x is infinite, return NaN.
- Else, return circular sine of x.

cos()
'''''

Description

Calculate cosine, double.

Prototype

::

   double cos(double x);

Parameters

+-----------------+----------------------------------------------------+
| Parameter       | Description                                        |
+=================+====================================================+
| x               | Angle to compute cosine of, radians.               |
+-----------------+----------------------------------------------------+

Return value

- If x is NaN, return x.
- If x is infinite, return NaN.
- Else, return circular cosine of x.

cosf()
''''''

Description

Calculate cosine, float.

Prototype

::

   float cosf(float x);

Parameters

+-----------------+----------------------------------------------------+
| Parameter       | Description                                        |
+=================+====================================================+
| x               | Angle to compute cosine of, radians.               |
+-----------------+----------------------------------------------------+

Return value

- If x is NaN, return x.
- If x is infinite, return NaN.
- Else, return circular cosine of x.

cosl()
''''''

Description

Calculate cosine, long double.

Prototype

::

   long double cosl(long double x);

Parameters

+-----------------+----------------------------------------------------+
| Parameter       | Description                                        |
+=================+====================================================+
| x               | Angle to compute cosine of, radians.               |
+-----------------+----------------------------------------------------+

Return value

- If x is NaN, return x.
- If x is infinite, return NaN.
- Else, return circular cosine of x.

tan()
'''''

Description

Compute tangent, double.

Prototype

::

   double tan(double x);

Parameters

+----------------+-----------------------------------------------------+
| Parameter      | Description                                         |
+================+=====================================================+
| x              | Angle to compute tangent of, radians.               |
+----------------+-----------------------------------------------------+

Return value

- If x is zero, return x.
- If x is infinite, return NaN.
- If x is NaN, return x.
- Else, return tangent of x.

tanf()
''''''

Description

Compute tangent, float.

Prototype

::

   float tanf(float x);

Parameters

+----------------+-----------------------------------------------------+
| Parameter      | Description                                         |
+================+=====================================================+
| x              | Angle to compute tangent of, radians.               |
+----------------+-----------------------------------------------------+

Return value

- If x is zero, return x.
- If x is infinite, return NaN.
- If x is NaN, return x.
- Else, return tangent of x.

tanl()
''''''

Description

Compute tangent, long double.

Prototype

::

   long double tanl(long double x);

Parameters

+----------------+-----------------------------------------------------+
| Parameter      | Description                                         |
+================+=====================================================+
| x              | Angle to compute tangent of, radians.               |
+----------------+-----------------------------------------------------+

Return value

- If x is zero, return x.
- If x is infinite, return NaN.
- If x is NaN, return x.
- Else, return tangent of x.

sinh()
''''''

Description

Compute hyperbolic sine, double.

Prototype

::

   double sinh(double x);

Parameters

+----------------+-----------------------------------------------------+
| Parameter      | Description                                         |
+================+=====================================================+
| x              | Value to compute hyperbolic sine of.                |
+----------------+-----------------------------------------------------+

Return value

- If x is NaN, return x.
- If x is infinite, return x.
- Else, return hyperbolic sine of x.

sinhf()
'''''''

Description

Compute hyperbolic sine, float.

Prototype

::

   float sinhf(float x);

Parameters

+----------------+-----------------------------------------------------+
| Parameter      | Description                                         |
+================+=====================================================+
| x              | Value to compute hyperbolic sine of.                |
+----------------+-----------------------------------------------------+

Return value

- If x is NaN, return x.
- If x is infinite, return x.
- Else, return hyperbolic sine of x.

sinhl()
'''''''

Description

Compute hyperbolic sine, long double.

Prototype

::

   long double sinhl(long double x);

Parameters

+----------------+-----------------------------------------------------+
| Parameter      | Description                                         |
+================+=====================================================+
| x              | Value to compute hyperbolic sine of.                |
+----------------+-----------------------------------------------------+

Return value

- If x is NaN, return x.
- If x is infinite, return x.
- Else, return hyperbolic sine of x.

cosh()
''''''

Description

Compute hyperbolic cosine, double.

Prototype

::

   double cosh(double x);

Parameters

+----------------+-----------------------------------------------------+
| Parameter      | Description                                         |
+================+=====================================================+
| x              | Value to compute hyperbolic cosine of.              |
+----------------+-----------------------------------------------------+

Return value

- If x is NaN, return x.
- If x is infinite, return +∞.
- Else, return hyperbolic cosine of x.

coshf()
'''''''

Description

Compute hyperbolic cosine, float.

Prototype

::

   float coshf(float x);

Parameters

+----------------+-----------------------------------------------------+
| Parameter      | Description                                         |
+================+=====================================================+
| x              | Value to compute hyperbolic cosine of.              |
+----------------+-----------------------------------------------------+

Return value

- If x is NaN, return x.
- If x is infinite, return +∞.
- Else, return hyperbolic cosine of x.

coshl()
'''''''

Description

Compute hyperbolic cosine, long double.

Prototype

::

   long double coshl(long double x);

Parameters

+----------------+-----------------------------------------------------+
| Parameter      | Description                                         |
+================+=====================================================+
| x              | Value to compute hyperbolic cosine of.              |
+----------------+-----------------------------------------------------+

Return value

- If x is NaN, return x.
- If x is infinite, return +∞.
- Else, return hyperbolic cosine of x.

tanh()
''''''

Description

Compute hyperbolic tangent, double.

Prototype

::

   double tanh(double x);

Parameters

+---------------+------------------------------------------------------+
| Parameter     | Description                                          |
+===============+======================================================+
| x             | Value to compute hyperbolic tangent of.              |
+---------------+------------------------------------------------------+

Return value

- If x is NaN, return x.
- Else, return hyperbolic tangent of x.

tanhf()
'''''''

Description

Compute hyperbolic tangent, float.

Prototype

::

   float tanhf(float x);

Parameters

+---------------+------------------------------------------------------+
| Parameter     | Description                                          |
+===============+======================================================+
| x             | Value to compute hyperbolic tangent of.              |
+---------------+------------------------------------------------------+

Return value

- If x is NaN, return x.
- Else, return hyperbolic tangent of x.

tanhl()
'''''''

Description

Compute hyperbolic tangent, long double.

Prototype

::

   long double tanhl(long double x);

Parameters

+---------------+------------------------------------------------------+
| Parameter     | Description                                          |
+===============+======================================================+
| x             | Value to compute hyperbolic tangent of.              |
+---------------+------------------------------------------------------+

Return value

- If x is NaN, return x.
- Else, return hyperbolic tangent of x.

Inverse trigonometric functions
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

+-------------+-----------------------------------------------------------+
| Function    | Description                                               |
+=============+===========================================================+
| `asin()`_   | Compute inverse sine, double.                             |
+-------------+-----------------------------------------------------------+
| `asinf()`_  | Compute inverse sine, float.                              |
+-------------+-----------------------------------------------------------+
| `asinl()`_  | Compute inverse sine, long double.                        |
+-------------+-----------------------------------------------------------+
| `acos()`_   | Compute inverse cosine, double.                           |
+-------------+-----------------------------------------------------------+
| `acosf()`_  | Compute inverse cosine, float.                            |
+-------------+-----------------------------------------------------------+
| `acosl()`_  | Compute inverse cosine, long double.                      |
+-------------+-----------------------------------------------------------+
| `atan()`_   | Compute inverse tangent, double.                          |
+-------------+-----------------------------------------------------------+
| `atanf()`_  | Compute inverse tangent, float.                           |
+-------------+-----------------------------------------------------------+
| `atanl()`_  | Compute inverse tangent, long double.                     |
+-------------+-----------------------------------------------------------+
| `atan2()`_  | Compute inverse tangent, with quadrant, double.           |
+-------------+-----------------------------------------------------------+
| `atan2f()`_ | Compute inverse tangent, with quadrant, float.            |
+-------------+-----------------------------------------------------------+
| `atan2l()`_ | Compute inverse tangent, with quadrant, long double.      |
+-------------+-----------------------------------------------------------+
| `asinh()`_  | Compute inverse hyperbolic sine, double.                  |
+-------------+-----------------------------------------------------------+
| `asinhf()`_ | Compute inverse hyperbolic sine, float.                   |
+-------------+-----------------------------------------------------------+
| `asinhl()`_ | Compute inverse hyperbolic sine, long double.             |
+-------------+-----------------------------------------------------------+
| `acosh()`_  | Compute inverse hyperbolic cosine, double.                |
+-------------+-----------------------------------------------------------+
| `acoshf()`_ | Compute inverse hyperbolic cosine, float.                 |
+-------------+-----------------------------------------------------------+
| `acoshl()`_ | Compute inverse hyperbolic cosine, long double.           |
+-------------+-----------------------------------------------------------+
| `atanh()`_  | Compute inverse hyperbolic tangent, double.               |
+-------------+-----------------------------------------------------------+
| `atanhf()`_ | Compute inverse hyperbolic tangent, float.                |
+-------------+-----------------------------------------------------------+
| `atanhl()`_ | Compute inverse hyperbolic tangent, long double.          |
+-------------+-----------------------------------------------------------+

asin()
''''''

Description

Compute inverse sine, double.

Prototype

::

   double asin(double x);

Parameters

+------------------+---------------------------------------------------+
| Parameter        | Description                                       |
+==================+===================================================+
| x                | Value to compute inverse sine of.                 |
+------------------+---------------------------------------------------+

Return value

- If x is NaN, return x.
- If \|x\| > 1, return NaN.
- Else, return inverse circular sine of x.

Additional information

Calculates the principal value, in radians, of the inverse circular sine of x. The principal value lies in the interval [-Pi/2, Pi/2] radians.

asinf()
'''''''

Description

Compute inverse sine, float.

Prototype

::

   float asinf(float x);

Parameters

+------------------+---------------------------------------------------+
| Parameter        | Description                                       |
+==================+===================================================+
| x                | Value to compute inverse sine of.                 |
+------------------+---------------------------------------------------+

Return value

- If x is NaN, return x.
- If \|x\| > 1, return NaN.
- Else, return inverse circular sine of x.

Additional information

Calculates the principal value, in radians, of the inverse circular sine of x. The principal value lies in the interval [-Pi/2, Pi/2] radians.

asinl()
'''''''

Description

Compute inverse sine, long double.

Prototype

::

   long double asinl(long double x);

Parameters

+------------------+---------------------------------------------------+
| Parameter        | Description                                       |
+==================+===================================================+
| x                | Value to compute inverse sine of.                 |
+------------------+---------------------------------------------------+

Return value

- If x is NaN, return x.
- If \|x\| > 1, return NaN.
- Else, return inverse circular sine of x.

Additional information

Calculates the principal value, in radians, of the inverse circular sine of x. The principal value lies in the interval [-Pi/2, Pi/2] radians.

acos()
''''''

Description

Compute inverse cosine, double.

Prototype

::

   double acos(double x);

Parameters

+-----------------+----------------------------------------------------+
| Parameter       | Description                                        |
+=================+====================================================+
| x               | Value to compute inverse cosine of.                |
+-----------------+----------------------------------------------------+

Return value

- If x is NaN, return x.
- If \|x\| > 1, return NaN.
- Else, return inverse circular cosine of x.

Additional information

Calculates the principal value, in radians, of the inverse circular cosine of x. The principal value lies in the interval [0, Pi] radians.

acosf()
'''''''

Description

Compute inverse cosine, float.

Prototype

::

   float acosf(float x);

Parameters

+-----------------+----------------------------------------------------+
| Parameter       | Description                                        |
+=================+====================================================+
| x               | Value to compute inverse cosine of.                |
+-----------------+----------------------------------------------------+

Return value

- If x is NaN, return x.
- If \|x\| > 1, return NaN.
- Else, return inverse circular cosine of x.

Additional information

Calculates the principal value, in radians, of the inverse circular cosine of x. The principal value lies in the interval [0, Pi] radians.

acosl()
'''''''

Description

Compute inverse cosine, long double.

Prototype

::

   long double acosl(long double x);

Parameters

+-----------------+----------------------------------------------------+
| Parameter       | Description                                        |
+=================+====================================================+
| x               | Value to compute inverse cosine of.                |
+-----------------+----------------------------------------------------+

Return value

- If x is NaN, return x.
- If \|x\| > 1, return NaN.
- Else, return inverse circular cosine of x.

Additional information

Calculates the principal value, in radians, of the inverse circular cosine of x. The principal value lies in the interval [0, Pi] radians.

atan()
''''''

Description

Compute inverse tangent, double.

Prototype

::

   double atan(double x);

Parameters

+----------------+-----------------------------------------------------+
| Parameter      | Description                                         |
+================+=====================================================+
| x              | Value to compute inverse tangent of.                |
+----------------+-----------------------------------------------------+

Return value

- If x is NaN, return x.
- Else, return inverse tangent of x.

Additional information

Calculates the principal value, in radians, of the inverse tangent of x. The principal value lies in the interval [-Pi/2, Pi/2] radians.

atanf()
'''''''

Description

Compute inverse tangent, float.

Prototype

::

   float atanf(float x);

Parameters

+----------------+-----------------------------------------------------+
| Parameter      | Description                                         |
+================+=====================================================+
| x              | Value to compute inverse tangent of.                |
+----------------+-----------------------------------------------------+

Return value

- If x is NaN, return x.
- Else, return inverse tangent of x.

Additional information

Calculates the principal value, in radians, of the inverse tangent of x. The principal value lies in the interval [-Pi/2, Pi/2] radians.

atanl()
'''''''

Description

Compute inverse tangent, long double.

Prototype

::

   long double atanl(long double x);

Parameters

+----------------+-----------------------------------------------------+
| Parameter      | Description                                         |
+================+=====================================================+
| x              | Value to compute inverse tangent of.                |
+----------------+-----------------------------------------------------+

Return value

- If x is NaN, return x.
- Else, return inverse tangent of x.

Additional information

Calculates the principal value, in radians, of the inverse tangent of x. The principal value lies in the interval [-Pi/2, Pi/2] radians.

atan2()
'''''''

Description

Compute inverse tangent, with quadrant, double.

Prototype

::

   double atan2(double y,
                double x);

Parameters

+--------------------------+-------------------------------------------+
| Parameter                | Description                               |
+==========================+===========================================+
| y                        | Rise value of angle.                      |
+--------------------------+-------------------------------------------+
| x                        | Run value of angle.                       |
+--------------------------+-------------------------------------------+

Return value

Inverse tangent of y/x.

Additional information

This calculates the value, in radians, of the inverse tangent of y divided by x using the signs of x and y to compute the quadrant of the return value. The principal value lies in the interval [-Pi, +Pi] radians.

atan2f()
''''''''

Description

Compute inverse tangent, with quadrant, float.

Prototype

::

   float atan2f(float y,
                float x);

Parameters

+--------------------------+-------------------------------------------+
| Parameter                | Description                               |
+==========================+===========================================+
| y                        | Rise value of angle.                      |
+--------------------------+-------------------------------------------+
| x                        | Run value of angle.                       |
+--------------------------+-------------------------------------------+

Return value

Inverse tangent of y/x.

Additional information

This calculates the value, in radians, of the inverse tangent of y divided by x using the signs of x and y to compute the quadrant of the return value. The principal value lies in the interval [-Pi, +Pi] radians.

atan2l()
''''''''

Description

Compute inverse tangent, with quadrant, long double.

Prototype

::

   long double atan2l(long double y,
                      long double x);

Parameters

+--------------------------+-------------------------------------------+
| Parameter                | Description                               |
+==========================+===========================================+
| y                        | Rise value of angle.                      |
+--------------------------+-------------------------------------------+
| x                        | Run value of angle.                       |
+--------------------------+-------------------------------------------+

Return value

Inverse tangent of y/x.

Additional information

This calculates the value, in radians, of the inverse tangent of y divided by x using the signs of x and y to compute the quadrant of the return value. The principal value lies in the interval [-Pi, +Pi] radians.

asinh()
'''''''

Description

Compute inverse hyperbolic sine, double.

Prototype

::

   double asinh(double x);

Parameters

+--------------+-------------------------------------------------------+
| Parameter    | Description                                           |
+==============+=======================================================+
| x            | Value to compute inverse hyperbolic sine of.          |
+--------------+-------------------------------------------------------+

Return value

- If x is infinite, return x.
- If x is NaN, return x.
- Else, return inverse hyperbolic sine of x.

asinhf()
''''''''

Description

Compute inverse hyperbolic sine, float.

Prototype

::

   float asinhf(float x);

Parameters

+--------------+-------------------------------------------------------+
| Parameter    | Description                                           |
+==============+=======================================================+
| x            | Value to compute inverse hyperbolic sine of.          |
+--------------+-------------------------------------------------------+

Return value

- If x is infinite, return x.
- If x is NaN, return x.
- Else, return inverse hyperbolic sine of x.

Additional information

Calculates the inverse hyperbolic sine of x.

asinhl()
''''''''

Description

Compute inverse hyperbolic sine, long double.

Prototype

::

   long double asinhl(long double x);

Parameters

+--------------+-------------------------------------------------------+
| Parameter    | Description                                           |
+==============+=======================================================+
| x            | Value to compute inverse hyperbolic sine of.          |
+--------------+-------------------------------------------------------+

Return value

- If x is infinite, return x.
- If x is NaN, return x.
- Else, return inverse hyperbolic sine of x.

acosh()
'''''''

Description

Compute inverse hyperbolic cosine, double.

Prototype

::

   double acosh(double x);

Parameters

+-------------+--------------------------------------------------------+
| Parameter   | Description                                            |
+=============+========================================================+
| x           | Value to compute inverse hyperbolic cosine of.         |
+-------------+--------------------------------------------------------+

Return value

- If x < 1, return NaN.
- If x is NaN, return x.
- Else, return non-negative inverse hyperbolic cosine of x.

acoshf()
''''''''

Description

Compute inverse hyperbolic cosine, float.

Prototype

::

   float acoshf(float x);

Parameters

+-------------+--------------------------------------------------------+
| Parameter   | Description                                            |
+=============+========================================================+
| x           | Value to compute inverse hyperbolic cosine of.         |
+-------------+--------------------------------------------------------+

Return value

- If x < 1, return NaN.
- If x is NaN, return x.
- Else, return non-negative inverse hyperbolic cosine of x.

acoshl()
''''''''

Description

Compute inverse hyperbolic cosine, long double.

Prototype

::

   long double acoshl(long double x);

Parameters

+-------------+--------------------------------------------------------+
| Parameter   | Description                                            |
+=============+========================================================+
| x           | Value to compute inverse hyperbolic cosine of.         |
+-------------+--------------------------------------------------------+

Return value

- If x < 1, return NaN.
- If x is NaN, return x.
- Else, return non-negative inverse hyperbolic cosine of x.

atanh()
'''''''

Description

Compute inverse hyperbolic tangent, double.

Prototype

::

   double atanh(double x);

Parameters

+-------------+--------------------------------------------------------+
| Parameter   | Description                                            |
+=============+========================================================+
| x           | Value to compute inverse hyperbolic tangent of.        |
+-------------+--------------------------------------------------------+

Return value

- If x is NaN, return x.
- If \|x\| > 1, return NaN.
- If x = +/-1, return +/-infinity.
- Else, return non-negative inverse hyperbolic tangent of x.

atanhf()
''''''''

Description

Compute inverse hyperbolic tangent, float.

Prototype

::

   float atanhf(float x);

Parameters

+-------------+--------------------------------------------------------+
| Parameter   | Description                                            |
+=============+========================================================+
| x           | Value to compute inverse hyperbolic tangent of.        |
+-------------+--------------------------------------------------------+

Return value

- If x is NaN, return x.
- If \|x\| > 1, return NaN.
- If x = +/-1, return +/-infinity.
- Else, return non-negative inverse hyperbolic tangent of x.

atanhl()
''''''''

Description

Compute inverse hyperbolic tangent, long double.

Prototype

::

   long double atanhl(long double x);

Parameters

+-------------+--------------------------------------------------------+
| Parameter   | Description                                            |
+=============+========================================================+
| x           | Value to compute inverse hyperbolic tangent of.        |
+-------------+--------------------------------------------------------+

Return value

- If x is NaN, return x.
- If \|x\| > 1, return NaN.
- If x = +/-1, return +/-infinity.
- Else, return non-negative inverse hyperbolic tangent of x.

Special functions
^^^^^^^^^^^^^^^^^

+--------------+-------------------------------------------------------+
| Function     | Description                                           |
+==============+=======================================================+
| `erf()`_     | Error function, double.                               |
+--------------+-------------------------------------------------------+
| `erff()`_    | Error function, float.                                |
+--------------+-------------------------------------------------------+
| `erfl()`_    | Error function, long double.                          |
+--------------+-------------------------------------------------------+
| `erfc()`_    | Complementary error function, double.                 |
+--------------+-------------------------------------------------------+
| `erfcf()`_   | Complementary error function, float.                  |
+--------------+-------------------------------------------------------+
| `erfcl()`_   | Complementary error function, long double.            |
+--------------+-------------------------------------------------------+
| `lgamma()`_  | Log-Gamma function, double.                           |
+--------------+-------------------------------------------------------+
| `lgammaf()`_ | Log-Gamma function, float.                            |
+--------------+-------------------------------------------------------+
| `lgammal()`_ | Log-Gamma function, long double.                      |
+--------------+-------------------------------------------------------+
| `tgamma()`_  | Gamma function, double.                               |
+--------------+-------------------------------------------------------+
| `tgammaf()`_ | Gamma function, float.                                |
+--------------+-------------------------------------------------------+
| `tgammal()`_ | Gamma function, long double.                          |
+--------------+-------------------------------------------------------+

erf()
'''''

Description

Error function, double.

Prototype

::

   double erf(double x);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Argument.                          |
+---------------------------------+------------------------------------+

Return value

erf(x).

erff()
''''''

Description

Error function, float.

Prototype

::

   float erff(float x);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Argument.                          |
+---------------------------------+------------------------------------+

Return value

erf(x).

erfl()
''''''

Description

Error function, long double.

Prototype

::

   long double erfl(long double x);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Argument.                          |
+---------------------------------+------------------------------------+

Return value

erf(x).

erfc()
''''''

Description

Complementary error function, double.

Prototype

::

   double erfc(double x);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Argument.                          |
+---------------------------------+------------------------------------+

Return value

erfc(x).

erfcf()
'''''''

Description

Complementary error function, float.

Prototype

::

   float erfcf(float x);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Argument.                          |
+---------------------------------+------------------------------------+

Return value

erfc(x).

erfcl()
'''''''

Description

Complementary error function, long double.

Prototype

::

   long double erfcl(long double x);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Argument.                          |
+---------------------------------+------------------------------------+

Return value

erfc(x).

lgamma()
''''''''

Description

Log-Gamma function, double.

Prototype

::

   double lgamma(double x);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Argument.                          |
+---------------------------------+------------------------------------+

Return value

log(gamma(x)).

lgammaf()
'''''''''

Description

Log-Gamma function, float.

Prototype

::

   float lgammaf(float x);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Argument.                          |
+---------------------------------+------------------------------------+

Return value

log(gamma(x)).

lgammal()
'''''''''

Description

Log-Gamma function, long double.

Prototype

::

   long double lgammal(long double x);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Argument.                          |
+---------------------------------+------------------------------------+

Return value

log(gamma(x)).

tgamma()
''''''''

Description

Gamma function, double.

Prototype

::

   double tgamma(double x);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Argument.                          |
+---------------------------------+------------------------------------+

Return value

gamma(x).

tgammaf()
'''''''''

Description

Gamma function, float.

Prototype

::

   float tgammaf(float x);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Argument.                          |
+---------------------------------+------------------------------------+

Return value

gamma(x).

tgammal()
'''''''''

Description

Gamma function, long double.

Prototype

::

   long double tgammal(long double x);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Argument.                          |
+---------------------------------+------------------------------------+

Return value

gamma(x).

Rounding and remainder functions
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

+-----------------+--------------------------------------------------------+
| Function        | Description                                            |
+=================+========================================================+
| `ceil()`_       | Compute smallest integer not less than, double.        |
+-----------------+--------------------------------------------------------+
| `ceilf()`_      | Compute smallest integer not less than, float.         |
+-----------------+--------------------------------------------------------+
| `ceill()`_      | Compute smallest integer not less than, long double.   |
+-----------------+--------------------------------------------------------+
| `floor()`_      | Compute largest integer not greater than, double.      |
+-----------------+--------------------------------------------------------+
| `floorf()`_     | Compute largest integer not greater than, float.       |
+-----------------+--------------------------------------------------------+
| `floorl()`_     | Compute largest integer not greater than, long double. |
+-----------------+--------------------------------------------------------+
| `trunc()`_      | Truncate to integer, double.                           |
+-----------------+--------------------------------------------------------+
| `truncf()`_     | Truncate to integer, float.                            |
+-----------------+--------------------------------------------------------+
| `truncl()`_     | Truncate to integer, long double.                      |
+-----------------+--------------------------------------------------------+
| `rint()`_       | Round to nearest integer, double.                      |
+-----------------+--------------------------------------------------------+
| `rintf()`_      | Round to nearest integer, float.                       |
+-----------------+--------------------------------------------------------+
| `rintl()`_      | Round to nearest integer, long double.                 |
+-----------------+--------------------------------------------------------+
| `lrint()`_      | Round to nearest integer, double.                      |
+-----------------+--------------------------------------------------------+
| `lrintf()`_     | Round to nearest integer, float.                       |
+-----------------+--------------------------------------------------------+
| `lrintl()`_     | Round to nearest integer, long double.                 |
+-----------------+--------------------------------------------------------+
| `llrint()`_     | Round to nearest integer, double.                      |
+-----------------+--------------------------------------------------------+
| `llrintf()`_    | Round to nearest integer, float.                       |
+-----------------+--------------------------------------------------------+
| `llrintl()`_    | Round to nearest integer, long double.                 |
+-----------------+--------------------------------------------------------+
| `round()`_      | Round to nearest integer, double.                      |
+-----------------+--------------------------------------------------------+
| `roundf()`_     | Round to nearest integer, float.                       |
+-----------------+--------------------------------------------------------+
| `roundl()`_     | Round to nearest integer, long double.                 |
+-----------------+--------------------------------------------------------+
| `lround()`_     | Round to nearest integer, double.                      |
+-----------------+--------------------------------------------------------+
| `lroundf()`_    | Round to nearest integer, float.                       |
+-----------------+--------------------------------------------------------+
| `lroundl()`_    | Round to nearest integer, long double.                 |
+-----------------+--------------------------------------------------------+
| `llround()`_    | Round to nearest integer, double.                      |
+-----------------+--------------------------------------------------------+
| `llroundf()`_   | Round to nearest integer, float.                       |
+-----------------+--------------------------------------------------------+
| `llroundl()`_   | Round to nearest integer, long double.                 |
+-----------------+--------------------------------------------------------+
| `nearbyint()`_  | Round to nearest integer, double.                      |
+-----------------+--------------------------------------------------------+
| `nearbyintf()`_ | Round to nearest integer, float.                       |
+-----------------+--------------------------------------------------------+
| `nearbyintl()`_ | Round to nearest integer, long double.                 |
+-----------------+--------------------------------------------------------+
| `fmod()`_       | Compute remainder after division, double.              |
+-----------------+--------------------------------------------------------+
| `fmodf()`_      | Compute remainder after division, float.               |
+-----------------+--------------------------------------------------------+
| `fmodl()`_      | Compute remainder after division, long double.         |
+-----------------+--------------------------------------------------------+
| `modf()`_       | Separate integer and fractional parts, double.         |
+-----------------+--------------------------------------------------------+
| `modff()`_      | Separate integer and fractional parts, float.          |
+-----------------+--------------------------------------------------------+
| `modfl()`_      | Separate integer and fractional parts, long double.    |
+-----------------+--------------------------------------------------------+
| `remainder()`_  | Compute remainder after division, double.              |
+-----------------+--------------------------------------------------------+
| `remainderf()`_ | Compute remainder after division, float.               |
+-----------------+--------------------------------------------------------+
| `remainderl()`_ | Compute remainder after division, long double.         |
+-----------------+--------------------------------------------------------+
| `remquo()`_     | Compute remainder after division, double.              |
+-----------------+--------------------------------------------------------+
| `remquof()`_    | Compute remainder after division, float.               |
+-----------------+--------------------------------------------------------+
| `remquol()`_    | Compute remainder after division, long double.         |
+-----------------+--------------------------------------------------------+

ceil()
''''''

Description

Compute smallest integer not less than, double.

Prototype

::

   double ceil(double x);

Parameters

+--------------------+-------------------------------------------------+
| Parameter          | Description                                     |
+====================+=================================================+
| x                  | Value to compute ceiling of.                    |
+--------------------+-------------------------------------------------+

Return value

- If x is zero, return x.
- If x is infinite, return x.
- If x is NaN, return x.
- Else, return the smallest integer value not greater than x.

ceilf()
'''''''

Description

Compute smallest integer not less than, float.

Prototype

::

   float ceilf(float x);

Parameters

+--------------------+-------------------------------------------------+
| Parameter          | Description                                     |
+====================+=================================================+
| x                  | Value to compute ceiling of.                    |
+--------------------+-------------------------------------------------+

Return value

- If x is zero, return x.
- If x is infinite, return x.
- If x is NaN, return x.
- Else, return the smallest integer value not greater than x.

ceill()
'''''''

Description

Compute smallest integer not less than, long double.

Prototype

::

   long double ceill(long double x);

Parameters

+--------------------+-------------------------------------------------+
| Parameter          | Description                                     |
+====================+=================================================+
| x                  | Value to compute ceiling of.                    |
+--------------------+-------------------------------------------------+

Return value

- If x is zero, return x.
- If x is infinite, return x.
- If x is NaN, return x.
- Else, return the smallest integer value not greater than x.

floor()
'''''''

Description

Compute largest integer not greater than, double.

Prototype

::

   double floor(double x);

Parameters

+------------------------------+---------------------------------------+
| Parameter                    | Description                           |
+==============================+=======================================+
| x                            | Value to floor.                       |
+------------------------------+---------------------------------------+

Return value

- If x is zero, return x.
- If x is infinite, return x.
- If x is NaN, return x.
- Else, return the largest integer value not greater than x.

floorf()
''''''''

Description

Compute largest integer not greater than, float.

Prototype

::

   float floorf(float x);

Parameters

+------------------------------+---------------------------------------+
| Parameter                    | Description                           |
+==============================+=======================================+
| x                            | Value to floor.                       |
+------------------------------+---------------------------------------+

Return value

- If x is zero, return x.
- If x is infinite, return x.
- If x is NaN, return x.
- Else, return the largest integer value not greater than x.

floorl()
''''''''

Description

Compute largest integer not greater than, long double.

Prototype

::

   long double floorl(long double x);

Parameters

+------------------------------+---------------------------------------+
| Parameter                    | Description                           |
+==============================+=======================================+
| x                            | Value to floor.                       |
+------------------------------+---------------------------------------+

Return value

- If x is zero, return x.
- If x is infinite, return x.
- If x is NaN, return x.
- Else, return the largest integer value not greater than x.

trunc()
'''''''

Description

Truncate to integer, double.

Prototype

::

   double trunc(double x);

Parameters

+---------------------------+------------------------------------------+
| Parameter                 | Description                              |
+===========================+==========================================+
| x                         | Value to truncate.                       |
+---------------------------+------------------------------------------+

Return value

- If x is infinite, return x.
- If x is NaN, return x.
- Else, return x with fractional part removed.

truncf()
''''''''

Description

Truncate to integer, float.

Prototype

::

   float truncf(float x);

Parameters

+---------------------------+------------------------------------------+
| Parameter                 | Description                              |
+===========================+==========================================+
| x                         | Value to truncate.                       |
+---------------------------+------------------------------------------+

Return value

- If x is infinite, return x.
- If x is NaN, return x.
- Else, return x with fractional part removed.

truncl()
''''''''

Description

Truncate to integer, long double.

Prototype

::

   long double truncl(long double x);

Parameters

+---------------------------+------------------------------------------+
| Parameter                 | Description                              |
+===========================+==========================================+
| x                         | Value to truncate.                       |
+---------------------------+------------------------------------------+

Return value

- If x is infinite, return x.
- If x is NaN, return x.
- Else, return x with fractional part removed.

rint()
''''''

Description

Round to nearest integer, double.

Prototype

::

   double rint(double x);

Parameters

+----------------+-----------------------------------------------------+
| Parameter      | Description                                         |
+================+=====================================================+
| x              | Value to compute nearest integer of.                |
+----------------+-----------------------------------------------------+

Return value

- If x is infinite, return x.
- If x is NaN, return x.
- Else, return the nearest integer value to x.

rintf()
'''''''

Description

Round to nearest integer, float.

Prototype

::

   float rintf(float x);

Parameters

+----------------+-----------------------------------------------------+
| Parameter      | Description                                         |
+================+=====================================================+
| x              | Value to compute nearest integer of.                |
+----------------+-----------------------------------------------------+

Return value

- If x is infinite, return x.
- If x is NaN, return x.
- Else, return the nearest integer value to x.

rintl()
'''''''

Description

Round to nearest integer, long double.

Prototype

::

   long double rintl(long double x);

Parameters

+----------------+-----------------------------------------------------+
| Parameter      | Description                                         |
+================+=====================================================+
| x              | Value to compute nearest integer of.                |
+----------------+-----------------------------------------------------+

Return value

- If x is infinite, return x.
- If x is NaN, return x.
- Else, return the nearest integer value to x.

lrint()
'''''''

Description

Round to nearest integer, double.

Prototype

::

   long lrint(double x);

Parameters

+----------------+-----------------------------------------------------+
| Parameter      | Description                                         |
+================+=====================================================+
| x              | Value to compute nearest integer of.                |
+----------------+-----------------------------------------------------+

Return value

- If x is infinite, return x.
- If x is NaN, return x.
- Else, return the nearest integer value to x.

lrintf()
''''''''

Description

Round to nearest integer, float.

Prototype

::

   long lrintf(float x);

Parameters

+----------------+-----------------------------------------------------+
| Parameter      | Description                                         |
+================+=====================================================+
| x              | Value to compute nearest integer of.                |
+----------------+-----------------------------------------------------+

Return value

- If x is infinite, return x.
- If x is NaN, return x.
- Else, return the nearest integer value to x.

lrintl()
''''''''

Description

Round to nearest integer, long double.

Prototype

::

   long lrintl(long double x);

Parameters

+----------------+-----------------------------------------------------+
| Parameter      | Description                                         |
+================+=====================================================+
| x              | Value to compute nearest integer of.                |
+----------------+-----------------------------------------------------+

Return value

- If x is infinite, return x.
- If x is NaN, return x.
- Else, return the nearest integer value to x.

llrint()
''''''''

Description

Round to nearest integer, double.

Prototype

::

   long long llrint(double x);

Parameters

+----------------+-----------------------------------------------------+
| Parameter      | Description                                         |
+================+=====================================================+
| x              | Value to compute nearest integer of.                |
+----------------+-----------------------------------------------------+

Return value

- If x is infinite, return x.
- If x is NaN, return x.
- Else, return the nearest integer value to x.

llrintf()
'''''''''

Description

Round to nearest integer, float.

Prototype

::

   long long llrintf(float x);

Parameters

+----------------+-----------------------------------------------------+
| Parameter      | Description                                         |
+================+=====================================================+
| x              | Value to compute nearest integer of.                |
+----------------+-----------------------------------------------------+

Return value

- If x is infinite, return x.
- If x is NaN, return x.
- Else, return the nearest integer value to x.

llrintl()
'''''''''

Description

Round to nearest integer, long double.

Prototype

::

   long long llrintl(long double x);

Parameters

+----------------+-----------------------------------------------------+
| Parameter      | Description                                         |
+================+=====================================================+
| x              | Value to compute nearest integer of.                |
+----------------+-----------------------------------------------------+

Return value

- If x is infinite, return x.
- If x is NaN, return x.
- Else, return the nearest integer value to x.

round()
'''''''

Description

Round to nearest integer, double.

Prototype

::

   double round(double x);

Parameters

+----------------+-----------------------------------------------------+
| Parameter      | Description                                         |
+================+=====================================================+
| x              | Value to compute nearest integer of.                |
+----------------+-----------------------------------------------------+

Return value

- If x is infinite, return x.
- If x is NaN, return x.
- Else, return the nearest integer value to x, ties away from zero.

roundf()
''''''''

Description

Round to nearest integer, float.

Prototype

::

   float roundf(float x);

Parameters

+----------------+-----------------------------------------------------+
| Parameter      | Description                                         |
+================+=====================================================+
| x              | Value to compute nearest integer of.                |
+----------------+-----------------------------------------------------+

Return value

- If x is infinite, return x.
- If x is NaN, return x.
- Else, return the nearest integer value to x, ties away from zero.

roundl()
''''''''

Description

Round to nearest integer, long double.

Prototype

::

   long double roundl(long double x);

Parameters

+----------------+-----------------------------------------------------+
| Parameter      | Description                                         |
+================+=====================================================+
| x              | Value to compute nearest integer of.                |
+----------------+-----------------------------------------------------+

Return value

- If x is infinite, return x.
- If x is NaN, return x.
- Else, return the nearest integer value to x, ties away from zero.

lround()
''''''''

Description

Round to nearest integer, double.

Prototype

::

   long lround(double x);

Parameters

+----------------+-----------------------------------------------------+
| Parameter      | Description                                         |
+================+=====================================================+
| x              | Value to compute nearest integer of.                |
+----------------+-----------------------------------------------------+

Return value

- If x is infinite, return x.
- If x is NaN, return x.
- Else, return the nearest integer value to x.

lroundf()
'''''''''

Description

Round to nearest integer, float.

Prototype

::

   long lroundf(float x);

Parameters

+----------------+-----------------------------------------------------+
| Parameter      | Description                                         |
+================+=====================================================+
| x              | Value to compute nearest integer of.                |
+----------------+-----------------------------------------------------+

Return value

- If x is infinite, return x.
- If x is NaN, return x.
- Else, return the nearest integer value to x.

lroundl()
'''''''''

Description

Round to nearest integer, long double.

Prototype

::

   long lroundl(long double x);

Parameters

+----------------+-----------------------------------------------------+
| Parameter      | Description                                         |
+================+=====================================================+
| x              | Value to compute nearest integer of.                |
+----------------+-----------------------------------------------------+

Return value

- If x is infinite, return x.
- If x is NaN, return x.
- Else, return the nearest integer value to x.

llround()
'''''''''

Description

Round to nearest integer, double.

Prototype

::

   long long llround(double x);

Parameters

+----------------+-----------------------------------------------------+
| Parameter      | Description                                         |
+================+=====================================================+
| x              | Value to compute nearest integer of.                |
+----------------+-----------------------------------------------------+

Return value

- If x is infinite, return x.
- If x is NaN, return x.
- Else, return the nearest integer value to x.

llroundf()
''''''''''

Description

Round to nearest integer, float.

Prototype

::

   long long llroundf(float x);

Parameters

+----------------+-----------------------------------------------------+
| Parameter      | Description                                         |
+================+=====================================================+
| x              | Value to compute nearest integer of.                |
+----------------+-----------------------------------------------------+

Return value

- If x is infinite, return x.
- If x is NaN, return x.
- Else, return the nearest integer value to x.

llroundl()
''''''''''

Description

Round to nearest integer, long double.

Prototype

::

   long long llroundl(long double x);

Parameters

+----------------+-----------------------------------------------------+
| Parameter      | Description                                         |
+================+=====================================================+
| x              | Value to compute nearest integer of.                |
+----------------+-----------------------------------------------------+

Return value

- If x is infinite, return x.
- If x is NaN, return x.
- Else, return the nearest integer value to x.

nearbyint()
'''''''''''

Description

Round to nearest integer, double.

Prototype

::

   double nearbyint(double x);

Parameters

+----------------+-----------------------------------------------------+
| Parameter      | Description                                         |
+================+=====================================================+
| x              | Value to compute nearest integer of.                |
+----------------+-----------------------------------------------------+

Return value

- If x is infinite, return x.
- If x is NaN, return x.
- Else, return the nearest integer value to x.

nearbyintf()
''''''''''''

Description

Round to nearest integer, float.

Prototype

::

   float nearbyintf(float x);

Parameters

+----------------+-----------------------------------------------------+
| Parameter      | Description                                         |
+================+=====================================================+
| x              | Value to compute nearest integer of.                |
+----------------+-----------------------------------------------------+

Return value

- If x is infinite, return x.
- If x is NaN, return x.
- Else, return the nearest integer value to x.

nearbyintl()
''''''''''''

Description

Round to nearest integer, long double.

Prototype

::

   long double nearbyintl(long double x);

Parameters

+----------------+-----------------------------------------------------+
| Parameter      | Description                                         |
+================+=====================================================+
| x              | Value to compute nearest integer of.                |
+----------------+-----------------------------------------------------+

Return value

- If x is infinite, return x.
- If x is NaN, return x.
- Else, return the nearest integer value to x.

fmod()
''''''

Description

Compute remainder after division, double.

Prototype

::

   double fmod(double x,
               double y);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Value #1.                          |
+---------------------------------+------------------------------------+
| y                               | Value #2.                          |
+---------------------------------+------------------------------------+

Return value

- If x is NaN, return NaN.
- If x is zero and y is nonzero, return x.
- If x is infinite, return NaN.
- If x is finite and y is infinite, return x.
- If y is NaN, return NaN.
- If y is zero, return NaN.
- Else, return remainder of x divided by y.

Additional information

Computes the floating-point remainder of x divided by y, i.e. the value x - i*y for some integer i such that, if y is nonzero, the result has the same sign as x and magnitude less than the magnitude of y.

fmodf()
'''''''

Description

Compute remainder after division, float.

Prototype

::

   float fmodf(float x,
               float y);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Value #1.                          |
+---------------------------------+------------------------------------+
| y                               | Value #2.                          |
+---------------------------------+------------------------------------+

Return value

- If x is NaN, return NaN.
- If x is zero and y is nonzero, return x.
- If x is infinite, return NaN.
- If x is finite and y is infinite, return x.
- If y is NaN, return NaN.
- If y is zero, return NaN.
- Else, return remainder of x divided by y.

Additional information

Computes the floating-point remainder of x divided by y, i.e. the value x - i*y for some integer i such that, if y is nonzero, the result has the same sign as x and magnitude less than the magnitude of y.

fmodl()
'''''''

Description

Compute remainder after division, long double.

Prototype

::

   long double fmodl(long double x,
                     long double y);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Value #1.                          |
+---------------------------------+------------------------------------+
| y                               | Value #2.                          |
+---------------------------------+------------------------------------+

Return value

- If x is NaN, return NaN.
- If x is zero and y is nonzero, return x.
- If x is infinite, return NaN.
- If x is finite and y is infinite, return x.
- If y is NaN, return NaN.
- If y is zero, return NaN.
- Else, return remainder of x divided by y.

Additional information

Computes the floating-point remainder of x divided by y, i.e. the value x - i*y for some integer i such that, if y is nonzero, the result has the same sign as x and magnitude less than the magnitude of y.

modf()
''''''

Description

Separate integer and fractional parts, double.

Prototype

::

   double modf(double   x,
               double * iptr);

Parameters

+------------+---------------------------------------------------------+
| Parameter  | Description                                             |
+============+=========================================================+
| x          | Value to separate.                                      |
+------------+---------------------------------------------------------+
| iptr       | Pointer to object that receives the integral part of x. |
+------------+---------------------------------------------------------+

Return value

The signed fractional part of x.

Additional information

Breaks x into integral and fractional parts, each of which has the same type and sign as x.

The integral part (in floating-point format) is stored in the object pointed to by iptr and `modf()`_ returns the signed fractional part of x.

modff()
'''''''

Description

Separate integer and fractional parts, float.

Prototype

::

   float modff(float   x,
               float * iptr);

Parameters

+------------+---------------------------------------------------------+
| Parameter  | Description                                             |
+============+=========================================================+
| x          | Value to separate.                                      |
+------------+---------------------------------------------------------+
| iptr       | Pointer to object that receives the integral part of x. |
+------------+---------------------------------------------------------+

Return value

The signed fractional part of x.

Additional information

Breaks x into integral and fractional parts, each of which has the same type and sign as x.

The integral part (in floating-point format) is stored in the object pointed to by iptr and `modff()`_ returns the signed fractional part of x.

modfl()
'''''''

Description

Separate integer and fractional parts, long double.

Prototype

::

   long double modfl(long double   x,
                     long double * iptr);

Parameters

+------------+---------------------------------------------------------+
| Parameter  | Description                                             |
+============+=========================================================+
| x          | Value to separate.                                      |
+------------+---------------------------------------------------------+
| iptr       | Pointer to object that receives the integral part of x. |
+------------+---------------------------------------------------------+

Return value

The signed fractional part of x.

Additional information

Breaks x into integral and fractional parts, each of which has the same type and sign as x.

The integral part (in floating-point format) is stored in the object pointed to by iptr and `modf()`_ returns the signed fractional part of x.

remainder()
'''''''''''

Description

Compute remainder after division, double.

Prototype

::

   double remainder(double x,
                    double y);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Value #1.                          |
+---------------------------------+------------------------------------+
| y                               | Value #2.                          |
+---------------------------------+------------------------------------+

Return value

- If x is NaN, return NaN.
- If x is zero and y is nonzero, return x.
- If x is infinite, return NaN.
- If x is finite and y is infinite, return x.
- If y is NaN, return NaN.
- If y is zero, return NaN.
- Else, return remainder of x divided by y.

Additional information

Computes the floating-point remainder of x divided by y, i.e. the value x - i*y for some integer i such that, if y is nonzero, the result has the same sign as x and magnitude less than the magnitude of y.

remainderf()
''''''''''''

Description

Compute remainder after division, float.

Prototype

::

   float remainderf(float x,
                    float y);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Value #1.                          |
+---------------------------------+------------------------------------+
| y                               | Value #2.                          |
+---------------------------------+------------------------------------+

Return value

- If x is NaN, return NaN.
- If x is zero and y is nonzero, return x.
- If x is infinite, return NaN.
- If x is finite and y is infinite, return x.
- If y is NaN, return NaN.
- If y is zero, return NaN.
- Else, return remainder of x divided by y.

Additional information

Computes the floating-point remainder of x divided by y, i.e. the value x - i*y for some integer i such that, if y is nonzero, the result has the same sign as x and magnitude less than the magnitude of y.

remainderl()
''''''''''''

Description

Compute remainder after division, long double.

Prototype

::

   long double remainderl(long double x,
                          long double y);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Value #1.                          |
+---------------------------------+------------------------------------+
| y                               | Value #2.                          |
+---------------------------------+------------------------------------+

Return value

- If x is NaN, return NaN.
- If x is zero and y is nonzero, return x.
- If x is infinite, return NaN.
- If x is finite and y is infinite, return x.
- If y is NaN, return NaN.
- If y is zero, return NaN.
- Else, return remainder of x divided by y.

Additional information

Computes the floating-point remainder of x divided by y, i.e. the value x - i*y for some integer i such that, if y is nonzero, the result has the same sign as x and magnitude less than the magnitude of y.

remquo()
''''''''

Description

Compute remainder after division, double.

Prototype

::

   double remquo(double   x,
                 double   y,
                 int    * quo);

Parameters

+-----------+---------------------------------------------------------------------+
| Parameter | Description                                                         |
+===========+=====================================================================+
| x         | Value #1.                                                           |
+-----------+---------------------------------------------------------------------+
| y         | Value #2.                                                           |
+-----------+---------------------------------------------------------------------+
| quo       | Pointer to object that receives the integer part of x divided by y. |
+-----------+---------------------------------------------------------------------+

Return value

- If x is NaN, return NaN.
- If x is zero and y is nonzero, return x.
- If x is infinite, return NaN.
- If x is finite and y is infinite, return x.
- If y is NaN, return NaN.
- If y is zero, return NaN.
- Else, return remainder of x divided by y.

Additional information

Computes the floating-point remainder of x divided by y, i.e. the value x - i*y for some integer i such that, if y is nonzero, the result has the same sign as x and magnitude less than the magnitude of y.

remquof()
'''''''''

Description

Compute remainder after division, float.

Prototype

::

   float remquof(float   x,
                 float   y,
                 int   * quo);

Parameters

+-----------+---------------------------------------------------------------------+
| Parameter | Description                                                         |
+===========+=====================================================================+
| x         | Value #1.                                                           |
+-----------+---------------------------------------------------------------------+
| y         | Value #2.                                                           |
+-----------+---------------------------------------------------------------------+
| quo       | Pointer to object that receives the integer part of x divided by y. |
+-----------+---------------------------------------------------------------------+

Return value

- If x is NaN, return NaN.
- If x is zero and y is nonzero, return x.
- If x is infinite, return NaN.
- If x is finite and y is infinite, return x.
- If y is NaN, return NaN.
- If y is zero, return NaN.
- Else, return remainder of x divided by y.

Additional information

Computes the floating-point remainder of x divided by y, i.e. the value x - i*y for some integer i such that, if y is nonzero, the result has the same sign as x and magnitude less than the magnitude of y.

remquol()
'''''''''

Description

Compute remainder after division, long double.

Prototype

::

   long double remquol(long double   x,
                       long double   y,
                       int         * quo);

Parameters

+-----------+---------------------------------------------------------------------+
| Parameter | Description                                                         |
+===========+=====================================================================+
| x         | Value #1.                                                           |
+-----------+---------------------------------------------------------------------+
| y         | Value #2.                                                           |
+-----------+---------------------------------------------------------------------+
| quo       | Pointer to object that receives the integer part of x divided by y. |
+-----------+---------------------------------------------------------------------+

Return value

- If x is NaN, return NaN.
- If x is zero and y is nonzero, return x.
- If x is infinite, return NaN.
- If x is finite and y is infinite, return x.
- If y is NaN, return NaN.
- If y is zero, return NaN.
- Else, return remainder of x divided by y.

Additional information

Computes the floating-point remainder of x divided by y, i.e. the value x - i*y for some integer i such that, if y is nonzero, the result has the same sign as x and magnitude less than the magnitude of y.

Absolute value functions
^^^^^^^^^^^^^^^^^^^^^^^^

+--------------+-------------------------------------------------------+
| Function     | Description                                           |
+==============+=======================================================+
| `fabs()`_    | Compute absolute value, double.                       |
+--------------+-------------------------------------------------------+
| `fabsf()`_   | Compute absolute value, float.                        |
+--------------+-------------------------------------------------------+
| `fabsl()`_   | Compute absolute value, long double.                  |
+--------------+-------------------------------------------------------+

fabs()
''''''

Description

Compute absolute value, double.

Prototype

::

   double fabs(double x);

Parameters

+------------------+---------------------------------------------------+
| Parameter        | Description                                       |
+==================+===================================================+
| x                | Value to compute magnitude of.                    |
+------------------+---------------------------------------------------+

Return value

- If x is NaN, return x.
- Else, absolute value of x.

fabsf()
'''''''

Description

Compute absolute value, float.

Prototype

::

   float fabsf(float x);

Parameters

+------------------+---------------------------------------------------+
| Parameter        | Description                                       |
+==================+===================================================+
| x                | Value to compute magnitude of.                    |
+------------------+---------------------------------------------------+

Return value

- If x is NaN, return x.
- Else, absolute value of x.

fabsl()
'''''''

Description

Compute absolute value, long double.

Prototype

::

   long double fabsl(long double x);

Parameters

+------------------+---------------------------------------------------+
| Parameter        | Description                                       |
+==================+===================================================+
| x                | Value to compute magnitude of.                    |
+------------------+---------------------------------------------------+

Return value

- If x is NaN, return x.
- Else, absolute value of x.

Fused multiply functions
^^^^^^^^^^^^^^^^^^^^^^^^

+-------------+--------------------------------------------------------+
| Function    | Description                                            |
+=============+========================================================+
| `fma()`_    | Compute fused multiply-add, double.                    |
+-------------+--------------------------------------------------------+
| `fmaf()`_   | Compute fused multiply-add, float.                     |
+-------------+--------------------------------------------------------+
| `fmal()`_   | Compute fused multiply-add, long double.               |
+-------------+--------------------------------------------------------+

fma()
'''''

Description

Compute fused multiply-add, double.

Prototype

::

   double fma(double x,
              double y,
              double z);

Parameters

+-------------------------------+--------------------------------------+
| Parameter                     | Description                          |
+===============================+======================================+
| x                             | Multiplicand.                        |
+-------------------------------+--------------------------------------+
| y                             | Multiplier.                          |
+-------------------------------+--------------------------------------+
| z                             | Summand.                             |
+-------------------------------+--------------------------------------+

Return value

Return (x \* y) + z.

fmaf()
''''''

Description

Compute fused multiply-add, float.

Prototype

::

   float fmaf(float x,
              float y,
              float z);

Parameters

+-------------------------------+--------------------------------------+
| Parameter                     | Description                          |
+===============================+======================================+
| x                             | Multiplier.                          |
+-------------------------------+--------------------------------------+
| y                             | Multiplicand.                        |
+-------------------------------+--------------------------------------+
| z                             | Summand.                             |
+-------------------------------+--------------------------------------+

Return value

Return (x \* y) + z.

fmal()
''''''

Description

Compute fused multiply-add, long double.

Prototype

::

   long double fmal(long double x,
                    long double y,
                    long double z);

Parameters

+-------------------------------+--------------------------------------+
| Parameter                     | Description                          |
+===============================+======================================+
| x                             | Multiplicand.                        |
+-------------------------------+--------------------------------------+
| y                             | Multiplier.                          |
+-------------------------------+--------------------------------------+
| z                             | Summand.                             |
+-------------------------------+--------------------------------------+

Return value

Return (x \* y) + z.

Maximum, minimum, and positive difference functions
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

+----------------+-----------------------------------------------------+
| Function       | Description                                         |
+================+=====================================================+
| `fmin()`_      | Compute minimum, double.                            |
+----------------+-----------------------------------------------------+
| `fminf()`_     | Compute minimum, float.                             |
+----------------+-----------------------------------------------------+
| `fminl()`_     | Compute minimum, long double.                       |
+----------------+-----------------------------------------------------+
| `fmax()`_      | Compute maximum, double.                            |
+----------------+-----------------------------------------------------+
| `fmaxf()`_     | Compute maximum, float.                             |
+----------------+-----------------------------------------------------+
| `fmaxl()`_     | Compute maximum, long double.                       |
+----------------+-----------------------------------------------------+
| `fdim()`_      | Positive difference, double.                        |
+----------------+-----------------------------------------------------+
| `fdimf()`_     | Positive difference, float.                         |
+----------------+-----------------------------------------------------+
| `fdiml()`_     | Positive difference, long double.                   |
+----------------+-----------------------------------------------------+

fmin()
''''''

Description

Compute minimum, double.

Prototype

::

   double fmin(double x,
               double y);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Value #1.                          |
+---------------------------------+------------------------------------+
| y                               | Value #2.                          |
+---------------------------------+------------------------------------+

Return value

- If x is NaN, return y.
- If y is NaN, return x.
- Else, return minimum of x and y.

fminf()
'''''''

Description

Compute minimum, float.

Prototype

::

   float fminf(float x,
               float y);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Value #1.                          |
+---------------------------------+------------------------------------+
| y                               | Value #2.                          |
+---------------------------------+------------------------------------+

Return value

- If x is NaN, return y.
- If y is NaN, return x.
- Else, return minimum of x and y.

fminl()
'''''''

Description

Compute minimum, long double.

Prototype

::

   long double fminl(long double x,
                     long double y);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Value #1.                          |
+---------------------------------+------------------------------------+
| y                               | Value #2.                          |
+---------------------------------+------------------------------------+

Return value

- If x is NaN, return y.
- If y is NaN, return x.
- Else, return minimum of x and y.

fmax()
''''''

Description

Compute maximum, double.

Prototype

::

   double fmax(double x,
               double y);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Value #1.                          |
+---------------------------------+------------------------------------+
| y                               | Value #2.                          |
+---------------------------------+------------------------------------+

Return value

- If x is NaN, return y.
- If y is NaN, return x.
- Else, return maximum of x and y.

fmaxf()
'''''''

Description

Compute maximum, float.

Prototype

::

   float fmaxf(float x,
               float y);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Value #1.                          |
+---------------------------------+------------------------------------+
| y                               | Value #2.                          |
+---------------------------------+------------------------------------+

Return value

- If x is NaN, return y.
- If y is NaN, return x.
- Else, return maximum of x and y.

fmaxl()
'''''''

Description

Compute maximum, long double.

Prototype

::

   long double fmaxl(long double x,
                     long double y);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Value #1.                          |
+---------------------------------+------------------------------------+
| y                               | Value #2.                          |
+---------------------------------+------------------------------------+

Return value

- If x is NaN, return y.
- If y is NaN, return x.
- Else, return maximum of x and y.

fdim()
''''''

Description

Positive difference, double.

Prototype

::

   double fdim(double x,
               double y);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Value #1.                          |
+---------------------------------+------------------------------------+
| y                               | Value #2.                          |
+---------------------------------+------------------------------------+

Return value

- If x > y, x-y.
- Else, +0.

fdimf()
'''''''

Description

Positive difference, float.

Prototype

::

   float fdimf(float x,
               float y);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Value #1.                          |
+---------------------------------+------------------------------------+
| y                               | Value #2.                          |
+---------------------------------+------------------------------------+

Return value

- If x > y, x-y.
- Else, +0.

fdiml()
'''''''

Description

Positive difference, long double.

Prototype

::

   long double fdiml(long double x,
                     long double y);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| x                               | Value #1.                          |
+---------------------------------+------------------------------------+
| y                               | Value #2.                          |
+---------------------------------+------------------------------------+

Return value

- If x > y, x-y.
- Else, +0.

Miscellaneous functions
^^^^^^^^^^^^^^^^^^^^^^^

+------------------+---------------------------------------------------+
| Function         | Description                                       |
+==================+===================================================+
| `nextafter()`_   | Next machine-floating value, double.              |
+------------------+---------------------------------------------------+
| `nextafterf()`_  | Next machine-floating value, float.               |
+------------------+---------------------------------------------------+
| `nextafterl()`_  | Next machine-floating value, long double.         |
+------------------+---------------------------------------------------+
| `nexttoward()`_  | Next machine-floating value, double.              |
+------------------+---------------------------------------------------+
| `nexttowardf()`_ | Next machine-floating value, float.               |
+------------------+---------------------------------------------------+
| `nexttowardl()`_ | Next machine-floating value, long double.         |
+------------------+---------------------------------------------------+
| `nan()`_         | Parse NaN, double.                                |
+------------------+---------------------------------------------------+
| `nanf()`_        | Parse NaN, float.                                 |
+------------------+---------------------------------------------------+
| `nanl()`_        | Parse NaN, long double.                           |
+------------------+---------------------------------------------------+
| `copysign()`_    | Copy sign, double.                                |
+------------------+---------------------------------------------------+
| `copysignf()`_   | Copy sign, float.                                 |
+------------------+---------------------------------------------------+
| `copysignl()`_   | Copy sign, long double.                           |
+------------------+---------------------------------------------------+

nextafter()
'''''''''''

Description

Next machine-floating value, double.

Prototype

::

   double nextafter(double x,
                    double y);

Parameters

+--------------------------+-------------------------------------------+
| Parameter                | Description                               |
+==========================+===========================================+
| x                        | Value to step from.                       |
+--------------------------+-------------------------------------------+
| y                        | Director to step in.                      |
+--------------------------+-------------------------------------------+

Return value

Next machine-floating value after x in direction of y.

nextafterf()
''''''''''''

Description

Next machine-floating value, float.

Prototype

::

   float nextafterf(float x,
                    float y);

Parameters

+--------------------------+-------------------------------------------+
| Parameter                | Description                               |
+==========================+===========================================+
| x                        | Value to step from.                       |
+--------------------------+-------------------------------------------+
| y                        | Director to step in.                      |
+--------------------------+-------------------------------------------+

Return value

Next machine-floating value after x in direction of y.

nextafterl()
''''''''''''

Description

Next machine-floating value, long double.

Prototype

::

   long double nextafterl(long double x,
                          long double y);

Parameters

+--------------------------+-------------------------------------------+
| Parameter                | Description                               |
+==========================+===========================================+
| x                        | Value to step from.                       |
+--------------------------+-------------------------------------------+
| y                        | Director to step in.                      |
+--------------------------+-------------------------------------------+

Return value

Next machine-floating value after x in direction of y.

nexttoward()
''''''''''''

Description

Next machine-floating value, double.

Prototype

::

   double nexttoward(double      x,
                     long double y);

Parameters

+-------------------------+--------------------------------------------+
| Parameter               | Description                                |
+=========================+============================================+
| x                       | Value to step from.                        |
+-------------------------+--------------------------------------------+
| y                       | Direction to step in.                      |
+-------------------------+--------------------------------------------+

Return value

Next machine-floating value after x in direction of y.

nexttowardf()
'''''''''''''

Description

Next machine-floating value, float.

Prototype

::

   float nexttowardf(float       x,
                     long double y);

Parameters

+-------------------------+--------------------------------------------+
| Parameter               | Description                                |
+=========================+============================================+
| x                       | Value to step from.                        |
+-------------------------+--------------------------------------------+
| y                       | Direction to step in.                      |
+-------------------------+--------------------------------------------+

Return value

Next machine-floating value after x in direction of y.

nexttowardl()
'''''''''''''

Description

Next machine-floating value, long double.

Prototype

::

   long double nexttowardl(long double x,
                           long double y);

Parameters

+-------------------------+--------------------------------------------+
| Parameter               | Description                                |
+=========================+============================================+
| x                       | Value to step from.                        |
+-------------------------+--------------------------------------------+
| y                       | Direction to step in.                      |
+-------------------------+--------------------------------------------+

Return value

Next machine-floating value after x in direction of y.

nan()
'''''

Description

Parse NaN, double.

Prototype

::

   double nan(const char * tag);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| tag                             | NaN tag.                           |
+---------------------------------+------------------------------------+

Return value

Quiet NaN formed from tag.

nanf()
''''''

Description

Parse NaN, float.

Prototype

::

   float nanf(const char * tag);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| tag                             | NaN tag.                           |
+---------------------------------+------------------------------------+

Return value

Quiet NaN formed from tag.

nanl()
''''''

Description

Parse NaN, long double.

Prototype

::

   long double nanl(const char * tag);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| tag                             | NaN tag.                           |
+---------------------------------+------------------------------------+

Return value

Quiet NaN formed from tag.

copysign()
''''''''''

Description

Copy sign, double.

Prototype

::

   double copysign(double x,
                   double y);

Parameters

+---------------+------------------------------------------------------+
| Parameter     | Description                                          |
+===============+======================================================+
| x             | Floating value to inject sign into.                  |
+---------------+------------------------------------------------------+
| y             | Floating value carrying the sign to inject.          |
+---------------+------------------------------------------------------+

Return value

x with the sign of y.

copysignf()
'''''''''''

Description

Copy sign, float.

Prototype

::

   float copysignf(float x,
                   float y);

Parameters

+---------------+------------------------------------------------------+
| Parameter     | Description                                          |
+===============+======================================================+
| x             | Floating value to inject sign into.                  |
+---------------+------------------------------------------------------+
| y             | Floating value carrying the sign to inject.          |
+---------------+------------------------------------------------------+

Return value

x with the sign of y.

copysignl()
'''''''''''

Description

Copy sign, long double.

Prototype

::

   long double copysignl(long double x,
                         long double y);

Parameters

+---------------+------------------------------------------------------+
| Parameter     | Description                                          |
+===============+======================================================+
| x             | Floating value to inject sign into.                  |
+---------------+------------------------------------------------------+
| y             | Floating value carrying the sign to inject.          |
+---------------+------------------------------------------------------+

Return value

x with the sign of y.

<setjmp.h>
~~~~~~~~~~

Non-local flow control
^^^^^^^^^^^^^^^^^^^^^^

setjmp()
''''''''

Description

Save calling environment for non-local jump.

Prototype

::

   int setjmp(jmp_buf buf);

Parameters

+--------------------+-------------------------------------------------+
| Parameter          | Description                                     |
+====================+=================================================+
| buf                | Buffer to save context into.                    |
+--------------------+-------------------------------------------------+

Return value

On return from a direct invocation, returns the value zero. On return from a call to the `longjmp()`_ function, returns a nonzero value determined by the call to `longjmp()`_.

Additional information

Saves its calling environment in env for later use by the `longjmp()`_ function.

The environment saved by a call to setjmp () consists of information sufficient for a call to the `longjmp()`_ function to return execution to the correct block and invocation of that block, were it called recursively.

longjmp()
'''''''''

Description

Restores the saved environment.

Prototype

::

   void longjmp(jmp_buf buf,
                int     val);

Parameters

+------------------+---------------------------------------------------+
| Parameter        | Description                                       |
+==================+===================================================+
| buf              | Buffer to restore context from.                   |
+------------------+---------------------------------------------------+
| val              | Value to return to `setjmp()`_ call.              |
+------------------+---------------------------------------------------+

Additional information

Restores the environment saved by `setjmp()`_ in the corresponding env argument. If there has been no such invocation, or if the function containing the invocation of `setjmp()`_ has terminated execution in the interim, the behavior of `longjmp()`_ is undefined.

After `longjmp()`_ is completed, program execution continues as if the corresponding invocation of `setjmp()`_ had just returned the value specified by val.

Objects of automatic storage allocation that are local to the function containing the invocation of the corresponding `setjmp()`_ that do not have volatile-qualified type and have been changed between the `setjmp()`_ invocation and `longjmp()`_ call are indeterminate.

Notes

`longjmp()`_ cannot cause `setjmp()`_ to return the value 0; if val is 0, `setjmp()`_ returns the value 1.

<stdbool.h>
~~~~~~~~~~~

.. _macros-1:

Macros
^^^^^^

bool
''''

Description

Macros expanding to support the Boolean type.

Definition

::

   #define bool     _Bool
   #define true     1
   #define false    0

Symbols

+---------------------+------------------------------------------------+
| Definition          | Description                                    |
+=====================+================================================+
| bool                | Underlying boolean type                        |
+---------------------+------------------------------------------------+
| true                | Boolean true value                             |
+---------------------+------------------------------------------------+
| false               | Boolean false value                            |
+---------------------+------------------------------------------------+

<stddef.h>
~~~~~~~~~~

.. _macros-2:

Macros
^^^^^^

NULL
''''

Description

Null-pointer constant.

Definition

::

   #define NULL    0

Symbols

+--------------------------------+-------------------------------------+
| Definition                     | Description                         |
+================================+=====================================+
| NULL                           | Null pointer                        |
+--------------------------------+-------------------------------------+

offsetof
''''''''

Description

Calculate offset of member from start of structure.

Definition

::

   #define offsetof(s,m)    ((size_t)&(((s *)0)->m))

Symbols

+----------------------------+-----------------------------------------+
| Definition                 | Description                             |
+============================+=========================================+
| offsetof(s,m)              | Offset of m within s                    |
+----------------------------+-----------------------------------------+

Types
^^^^^

size_t
''''''

Description

Unsigned integral type returned by the sizeof operator.

Type definition

::

   typedef __SEGGER_RTL_SIZE_T size_t;

ptrdiff_t
'''''''''

Description

Signed integral type of the result of subtracting two pointers.

Type definition

::

   typedef __SEGGER_RTL_PTRDIFF_T ptrdiff_t;

wchar_t
'''''''

Description

Integral type that can hold one wide character.

Type definition

::

   typedef __SEGGER_RTL_WCHAR_T wchar_t;

<stdint.h>
~~~~~~~~~~

.. _minima-and-maxima-1:

Minima and maxima
^^^^^^^^^^^^^^^^^

Signed integer minima and maxima
''''''''''''''''''''''''''''''''

Description

Minimum and maximum values for signed integer types.

Definition

::

   #define INT8_MIN     (-128)
   #define INT8_MAX     127
   #define INT16_MIN    (-32767-1)
   #define INT16_MAX    32767
   #define INT32_MIN    (-2147483647L-1)
   #define INT32_MAX    2147483647L
   #define INT64_MIN    (-9223372036854775807LL-1)
   #define INT64_MAX    9223372036854775807LL

Symbols

+-----------------------+----------------------------------------------+
| Definition            | Description                                  |
+=======================+==============================================+
| INT8_MIN              | Minimum value of `int8_t`_                   |
+-----------------------+----------------------------------------------+
| INT8_MAX              | Maximum value of `int8_t`_                   |
+-----------------------+----------------------------------------------+
| INT16_MIN             | Minimum value of `int16_t`_                  |
+-----------------------+----------------------------------------------+
| INT16_MAX             | Maximum value of `int16_t`_                  |
+-----------------------+----------------------------------------------+
| INT32_MIN             | Minimum value of `int32_t`_                  |
+-----------------------+----------------------------------------------+
| INT32_MAX             | Maximum value of `int32_t`_                  |
+-----------------------+----------------------------------------------+
| INT64_MIN             | Minimum value of `int64_t`_                  |
+-----------------------+----------------------------------------------+
| INT64_MAX             | Maximum value of `int64_t`_                  |
+-----------------------+----------------------------------------------+

Unsigned integer minima and maxima
''''''''''''''''''''''''''''''''''

Description

Minimum and maximum values for unsigned integer types.

Definition

::

   #define UINT8_MAX     255
   #define UINT16_MAX    65535
   #define UINT32_MAX    4294967295UL
   #define UINT64_MAX    18446744073709551615ULL

Symbols

+-----------------------+----------------------------------------------+
| Definition            | Description                                  |
+=======================+==============================================+
| UINT8_MAX             | Maximum value of `uint8_t`_                  |
+-----------------------+----------------------------------------------+
| UINT16_MAX            | Maximum value of `uint16_t`_                 |
+-----------------------+----------------------------------------------+
| UINT32_MAX            | Maximum value of `uint32_t`_                 |
+-----------------------+----------------------------------------------+
| UINT64_MAX            | Maximum value of `uint64_t`_                 |
+-----------------------+----------------------------------------------+

Maximal integer minima and maxima
'''''''''''''''''''''''''''''''''

Description

Minimum and maximum values for signed and unsigned maximal-integer types.

Definition

::

   #define INTMAX_MIN     INT64_MIN
   #define INTMAX_MAX     INT64_MAX
   #define UINTMAX_MAX    UINT64_MAX

Symbols

+-------------------------+--------------------------------------------+
| Definition              | Description                                |
+=========================+============================================+
| INTMAX_MIN              | Minimum value of `intmax_t`_               |
+-------------------------+--------------------------------------------+
| INTMAX_MAX              | Maximum value of `intmax_t`_               |
+-------------------------+--------------------------------------------+
| UINTMAX_MAX             | Maximum value of `uintmax_t`_              |
+-------------------------+--------------------------------------------+

Least integer minima and maxima
'''''''''''''''''''''''''''''''

Description

Minimum and maximum values for signed and unsigned least-integer types.

Definition

::

   #define INT_LEAST8_MIN      INT8_MIN
   #define INT_LEAST8_MAX      INT8_MAX
   #define INT_LEAST16_MIN     INT16_MIN
   #define INT_LEAST16_MAX     INT16_MAX
   #define INT_LEAST32_MIN     INT32_MIN
   #define INT_LEAST32_MAX     INT32_MAX
   #define INT_LEAST64_MIN     INT64_MIN
   #define INT_LEAST64_MAX     INT64_MAX
   #define UINT_LEAST8_MAX     UINT8_MAX
   #define UINT_LEAST16_MAX    UINT16_MAX
   #define UINT_LEAST32_MAX    UINT32_MAX
   #define UINT_LEAST64_MAX    UINT64_MAX

Symbols

+---------------------------+------------------------------------------+
| Definition                | Description                              |
+===========================+==========================================+
| INT_LEAST8_MIN            | Minimum value of `int_least8_t`_         |
+---------------------------+------------------------------------------+
| INT_LEAST8_MAX            | Maximum value of `int_least8_t`_         |
+---------------------------+------------------------------------------+
| INT_LEAST16_MIN           | Minimum value of `int_least16_t`_        |
+---------------------------+------------------------------------------+
| INT_LEAST16_MAX           | Maximum value of `int_least16_t`_        |
+---------------------------+------------------------------------------+
| INT_LEAST32_MIN           | Minimum value of `int_least32_t`_        |
+---------------------------+------------------------------------------+
| INT_LEAST32_MAX           | Maximum value of `int_least32_t`_        |
+---------------------------+------------------------------------------+
| INT_LEAST64_MIN           | Minimum value of `int_least64_t`_        |
+---------------------------+------------------------------------------+
| INT_LEAST64_MAX           | Maximum value of `int_least64_t`_        |
+---------------------------+------------------------------------------+
| UINT_LEAST8_MAX           | Maximum value of `uint_least8_t`_        |
+---------------------------+------------------------------------------+
| UINT_LEAST16_MAX          | Maximum value of `uint_least16_t`_       |
+---------------------------+------------------------------------------+
| UINT_LEAST32_MAX          | Maximum value of `uint_least32_t`_       |
+---------------------------+------------------------------------------+
| UINT_LEAST64_MAX          | Maximum value of `uint_least64_t`_       |
+---------------------------+------------------------------------------+

Fast integer minima and maxima
''''''''''''''''''''''''''''''

Description

Minimum and maximum values for signed and unsigned fast-integer types.

Definition

::

   #define INT_FAST8_MIN      INT8_MIN
   #define INT_FAST8_MAX      INT8_MAX
   #define INT_FAST16_MIN     INT32_MIN
   #define INT_FAST16_MAX     INT32_MAX
   #define INT_FAST32_MIN     INT32_MIN
   #define INT_FAST32_MAX     INT32_MAX
   #define INT_FAST64_MIN     INT64_MIN
   #define INT_FAST64_MAX     INT64_MAX
   #define UINT_FAST8_MAX     UINT8_MAX
   #define UINT_FAST16_MAX    UINT32_MAX
   #define UINT_FAST32_MAX    UINT32_MAX
   #define UINT_FAST64_MAX    UINT64_MAX

Symbols

+---------------------------+------------------------------------------+
| Definition                | Description                              |
+===========================+==========================================+
| INT_FAST8_MIN             | Minimum value of `int_fast8_t`_          |
+---------------------------+------------------------------------------+
| INT_FAST8_MAX             | Maximum value of `int_fast8_t`_          |
+---------------------------+------------------------------------------+
| INT_FAST16_MIN            | Minimum value of `int_fast16_t`_         |
+---------------------------+------------------------------------------+
| INT_FAST16_MAX            | Maximum value of `int_fast16_t`_         |
+---------------------------+------------------------------------------+
| INT_FAST32_MIN            | Minimum value of `int_fast32_t`_         |
+---------------------------+------------------------------------------+
| INT_FAST32_MAX            | Maximum value of `int_fast32_t`_         |
+---------------------------+------------------------------------------+
| INT_FAST64_MIN            | Minimum value of `int_fast64_t`_         |
+---------------------------+------------------------------------------+
| INT_FAST64_MAX            | Maximum value of `int_fast64_t`_         |
+---------------------------+------------------------------------------+
| UINT_FAST8_MAX            | Maximum value of `uint_fast8_t`_         |
+---------------------------+------------------------------------------+
| UINT_FAST16_MAX           | Maximum value of `uint_fast16_t`_        |
+---------------------------+------------------------------------------+
| UINT_FAST32_MAX           | Maximum value of `uint_fast32_t`_        |
+---------------------------+------------------------------------------+
| UINT_FAST64_MAX           | Maximum value of `uint_fast64_t`_        |
+---------------------------+------------------------------------------+

Pointer types minima and maxima
'''''''''''''''''''''''''''''''

Description

Minimum and maximum values for pointer-related types.

Definition

::

   #define PTRDIFF_MIN    INT64_MIN
   #define PTRDIFF_MAX    INT64_MAX
   #define SIZE_MAX       INT64_MAX
   #define INTPTR_MIN     INT64_MIN
   #define INTPTR_MAX     INT64_MAX
   #define UINTPTR_MAX    UINT64_MAX

Symbols

+-------------------------+--------------------------------------------+
| Definition              | Description                                |
+=========================+============================================+
| PTRDIFF_MIN             | Minimum value of `ptrdiff_t`_              |
+-------------------------+--------------------------------------------+
| PTRDIFF_MAX             | Maximum value of `ptrdiff_t`_              |
+-------------------------+--------------------------------------------+
| SIZE_MAX                | Maximum value of `size_t`_                 |
+-------------------------+--------------------------------------------+
| INTPTR_MIN              | Minimum value of `intptr_t`_               |
+-------------------------+--------------------------------------------+
| INTPTR_MAX              | Maximum value of `intptr_t`_               |
+-------------------------+--------------------------------------------+
| UINTPTR_MAX             | Maximum value of `uintptr_t`_              |
+-------------------------+--------------------------------------------+
| PTRDIFF_MIN             | Minimum value of `ptrdiff_t`_              |
+-------------------------+--------------------------------------------+
| PTRDIFF_MAX             | Maximum value of `ptrdiff_t`_              |
+-------------------------+--------------------------------------------+
| SIZE_MAX                | Maximum value of `size_t`_                 |
+-------------------------+--------------------------------------------+
| INTPTR_MIN              | Minimum value of `intptr_t`_               |
+-------------------------+--------------------------------------------+
| INTPTR_MAX              | Maximum value of `intptr_t`_               |
+-------------------------+--------------------------------------------+
| UINTPTR_MAX             | Maximum value of `uintptr_t`_              |
+-------------------------+--------------------------------------------+

Wide integer minima and maxima
''''''''''''''''''''''''''''''

Description

Minimum and maximum values for the wint_t type.

Definition

::

   #define WINT_MIN    (-2147483647L-1)
   #define WINT_MAX    2147483647L

Symbols

+----------------------+-----------------------------------------------+
| Definition           | Description                                   |
+======================+===============================================+
| WINT_MIN             | Minimum value of wint_t                       |
+----------------------+-----------------------------------------------+
| WINT_MAX             | Maximum value of wint_t                       |
+----------------------+-----------------------------------------------+

Constant construction macros
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Signed integer construction macros
''''''''''''''''''''''''''''''''''

Description

Macros that create constants of type intx_t.

Definition

::

   #define INT8_C(x)     (x)
   #define INT16_C(x)    (x)
   #define INT32_C(x)    (x)
   #define INT64_C(x)    (x##LL)

Symbols

+--------------------+-------------------------------------------------+
| Definition         | Description                                     |
+====================+=================================================+
| INT8_C(x)          | Create constant of type `int8_t`_               |
+--------------------+-------------------------------------------------+
| INT16_C(x)         | Create constant of type `int16_t`_              |
+--------------------+-------------------------------------------------+
| INT32_C(x)         | Create constant of type `int32_t`_              |
+--------------------+-------------------------------------------------+
| INT64_C(x)         | Create constant of type `int64_t`_              |
+--------------------+-------------------------------------------------+

Unsigned integer construction macros
''''''''''''''''''''''''''''''''''''

Description

Macros that create constants of type uintx_t.

Definition

::

   #define UINT8_C(x)     (x##u)
   #define UINT16_C(x)    (x##u)
   #define UINT32_C(x)    (x##u)
   #define UINT64_C(x)    (x##uLL)

Symbols

+---------------------+------------------------------------------------+
| Definition          | Description                                    |
+=====================+================================================+
| UINT8_C(x)          | Create constant of type `uint8_t`_             |
+---------------------+------------------------------------------------+
| UINT16_C(x)         | Create constant of type `uint16_t`_            |
+---------------------+------------------------------------------------+
| UINT32_C(x)         | Create constant of type `uint32_t`_            |
+---------------------+------------------------------------------------+
| UINT64_C(x)         | Create constant of type `uint64_t`_            |
+---------------------+------------------------------------------------+

Maximal integer construction macros
'''''''''''''''''''''''''''''''''''

Description

Macros that create constants of type `intmax_t`_ and uintmax_t.

Definition

::

   #define INTMAX_C(x)     (x##LL)
   #define UINTMAX_C(x)    (x##uLL)

Symbols

+----------------------+-----------------------------------------------+
| Definition           | Description                                   |
+======================+===============================================+
| INTMAX_C(x)          | Create constant of type `intmax_t`_           |
+----------------------+-----------------------------------------------+
| UINTMAX_C(x)         | Create constant of type `uintmax_t`_          |
+----------------------+-----------------------------------------------+

<stdio.h>
~~~~~~~~~

Formatted output control strings
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The functions in this section that accept a formatted output control string do so according to the specification that follows.

Composition
'''''''''''

The format is composed of zero or more directives: ordinary characters (not %, which are copied unchanged to the output stream; and conversion specifications, each of which results in fetching zero or more subsequent arguments, converting them, if applicable, according to the corresponding conversion specifier, and then writing the result to the output stream.

Each conversion specification is introduced by the character %. After the % the following appear in sequence:

- Zero or more flags (in any order) that modify the meaning of the conversion specification.
- An optional minimum field width. If the converted value has fewer characters than the field width, it is padded with spaces (by default) on the left (or right, if the left adjustment flag has been given) to the field width. The field width takes the form of an asterisk \* or a decimal integer.
- An optional precision that gives the minimum number of digits to appear for the d, i, o, u, x, and X conversions, the number of digits to appear after the decimal-point character for e, E, f, and F conversions, the maximum number of significant digits for the g and G conversions, or the maximum number of bytes to be written for s conversions. The precision takes the form of a period . followed either by an asterisk \* or by an optional decimal integer; if only the period is specified, the precision is taken as zero. If a precision appears with any other conversion specifier, the behavior is undefined.
- An optional length modifier that specifies the size of the argument.
- A conversion specifier character that specifies the type of conversion to be applied.

As noted above, a field width, or precision, or both, may be indicated by an asterisk. In this case, an int argument supplies the field width or precision. The arguments specifying field width, or precision, or both, must appear (in that order) before the argument (if any) to be converted. A negative field width argument is taken as a - flag followed by a positive field width. A negative precision argument is taken as if the precision were omitted.

Flag characters
'''''''''''''''

The flag characters and their meanings are:

+-------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Flag  | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
+=======+==========================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================+
| -     | The result of the conversion is left-justified within the field. The default, if this flag is not specified, is that the result of the conversion is left-justified within the field.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
+-------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| +     | The result of a signed conversion always begins with a plus or minus sign. The default, if this flag is not specified, is that it begins with a sign only when a negative value is converted.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
+-------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| space | If the first character of a signed conversion is not a sign, or if a signed conversion results in no characters, a space is prefixed to the result. If the space and + flags both appear, the space flag is ignored.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
+-------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| #     | The result is converted to an alternative form. For o conversion, it increases the precision, if and only if necessary, to force the first digit of the result to be a zero (if the value and precision are both zero, a single 0 is printed). For x or X conversion, a nonzero result has 0x or 0X prefixed to it. For e, E, f, F, g, and G conversions, the result of converting a floating-point number always contains a decimal-point character, even if no digits follow it. (Normally, a decimal-point character appears in the result of these conversions only if a digit follows it.) For g and F conversions, trailing zeros are not removed from the result. As an extension, when used in p conversion, the results has # prefixed to it. For other conversions, the behavior is undefined. |
+-------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| 0     | For d, i, o, u, x, X, e, E, f, F, g, and G conversions, leading zeros (following any indication of sign or base) are used to pad to the field width rather than performing space padding, except when converting an infinity or NaN. If the 0 and - flags both appear, the 0 flag is ignored. For d, i, o, u, x, and X conversions, if a precision is specified, the 0 flag is ignored. For other conversions, the behavior is undefined.                                                                                                                                                                                                                                                                                                                                                                |
+-------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

Length modifiers
''''''''''''''''

The length modifiers and their meanings are:

+------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Flag | Description                                                                                                                                                                                                                                                                                                                                                                    |
+======+================================================================================================================================================================================================================================================================================================================================================================================+
| hh   | Specifies that a following d, i, o, u, x, or X conversion specifier applies to a signed char or unsigned char argument (the argument will have been promoted according to the integer promotions, but its value will be converted to signed char or unsigned char before printing); or that a following n conversion specifier applies to a pointer to a signed char argument. |
+------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| h    | Specifies that a following d, i, o, u, x, or X conversion specifier applies to a short int or unsigned short int argument (the argument will have been promoted according to the integer promotions, but its value is converted to short int or unsigned short int before printing); or that a following n conversion specifier applies to a pointer to a short int argument.  |
+------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| l    | Specifies that a following d, i, o, u, x, or X conversion specifier applies to a long int or unsigned long int argument; that a following n conversion specifier applies to a pointer to a long int argument; or has no effect on a following e, E, f, F, g, or G conversion specifier.                                                                                        |
+------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| ll   | Specifies that a following d, i, o, u, x, or X conversion specifier applies to a long long int or unsigned long long int argument; that a following n conversion specifier applies to a pointer to a long long int argument.                                                                                                                                                   |
+------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

If a length modifier appears with any conversion specifier other than as specified above, the behavior is undefined.

Conversion specifiers
'''''''''''''''''''''

The conversion specifiers and their meanings are:

+------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Flag       | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
+============+==========================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================+
| d, i       | The argument is converted to signed decimal in the style [-]dddd. The precision specifies the minimum number of digits to appear; if the value being converted can be represented in fewer digits, it is expanded with leading spaces. The default precision is one. The result of converting a zero value with a precision of zero is no characters.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
+------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| o, u, x, X | The unsigned argument is converted to unsigned octal for o, unsigned decimal for u, or unsigned hexadecimal notation for x or X in the style dddd the letters abcdef are used for x conversion and the letters ABCDEF for X conversion. The precision specifies the minimum number of digits to appear; if the value being converted can be represented in fewer digits, it is expanded with leading spaces. The default precision is one. The result of converting a zero value with a precision of zero is no characters.                                                                                                                                                                                                                                                                                                                                                                                                                              |
+------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| f, F       | A double argument representing a floating-point number is converted to decimal notation in the style [-]ddd.ddd, where the number of digits after the decimal-point character is equal to the precision specification. If the precision is missing, it is taken as 6; if the precision is zero and the # flag is not specified, no decimal-point character appears. If a decimal-point character appears, at least one digit appears before it. The value is rounded to the appropriate number of digits. A double argument representing an infinity is converted to inf. A double argument representing a NaN is converted to nan. The F conversion specifier produces INF or NAN instead of inf or nan, respectively.                                                                                                                                                                                                                                  |
+------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| e, E       | A double argument representing a floating-point number is converted in the style [-]d.ddde±dd, where there is one digit (which is nonzero if the argument is nonzero) before the decimal-point character and the number of digits after it is equal to the precision; if the precision is missing, it is taken as 6; if the precision is zero and the # flag is not specified, no decimal-point character appears. The value is rounded to the appropriate number of digits. The E conversion specifier produces a number with E instead of e introducing the exponent. The exponent always contains at least two digits, and only as many more digits as necessary to represent the exponent. If the value is zero, the exponent is zero. A double argument representing an infinity is converted to inf. A double argument representing a NaN is converted to nan. The E conversion specifier produces INF or NAN instead of inf or nan, respectively. |
+------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| g, G       | A double argument representing a floating-point number is converted in style f or e (or in style F or e in the case of a G conversion specifier), with the precision specifying the number of significant digits. If the precision is zero, it is taken as one. The style used depends on the value converted; style e (or E) is used only if the exponent resulting from such a conversion is less than -4 or greater than or equal to the precision. Trailing zeros are removed from the fractional portion of the result unless the # flag is specified; a decimal-point character appears only if it is followed by a digit. A double argument representing an infinity is converted to inf. A double argument representing a NaN is converted to nan. The G conversion specifier produces INF or NAN instead of inf or nan, respectively.                                                                                                           |
+------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| c          | The argument is converted to an unsigned char, and the resulting character is written.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
+------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| s          | The argument is be a pointer to the initial element of an array of character type. Characters from the array are written up to (but not including) the terminating null character. If the precision is specified, no more than that many characters are written. If the precision is not specified or is greater than the size of the array, the array must contain a null character.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
+------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| p          | The argument is a pointer to void. The value of the pointer is converted in the same format as the x conversion specifier with a fixed precision of 2*sizeof(void \*).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
+------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| n          | The argument is a pointer to a signed integer into which is written the number of characters written to the output stream so far by the call to the formatting function. No argument is converted, but one is consumed. If the conversion specification includes any flags, a field width, or a precision, the behavior is undefined.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
+------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| %          | A % character is written. No argument is converted.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
+------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

Note that the C99 width modifier l used in conjunction with the c and s conversion specifiers is not supported and nor are the conversion specifiers a and A.

Formatted input control strings
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The format is composed of zero or more directives: one or more white-space characters, an ordinary character (neither % nor a white-space character), or a conversion specification.

Each conversion specification is introduced by the character %. After the %, the following appear in sequence:

- An optional assignment-suppressing character \*.
- An optional nonzero decimal integer that specifies the maximum field width (in characters).
- An optional length modifier that specifies the size of the receiving object.
- A conversion specifier character that specifies the type of conversion to be applied.

The formatted input function executes each directive of the format in turn. If a directive fails, the function returns. Failures are described as input failures (because of the occurrence of an encoding error or the unavailability of input characters), or matching failures (because of inappropriate input).

A directive composed of white-space character(s) is executed by reading input up to the first non-white-space character (which remains unread), or until no more characters can be read.

A directive that is an ordinary character is executed by reading the next characters of the stream. If any of those characters differ from the ones composing the directive, the directive fails and the differing and subsequent characters remain unread. Similarly, if end-of-file, an encoding error, or a read error prevents a character from being read, the directive fails.

A directive that is a conversion specification defines a set of matching input sequences, as described below for each specifier. A conversion specification is executed in the following steps:

- Input white-space characters (as specified by the `isspace()`_ function) are skipped, unless the specification includes a [, c, or n specifier.
- An input item is read from the stream, unless the specification includes an n specifier. An input item is defined as the longest sequence of input characters which does not exceed any specified field width and which is, or is a prefix of, a matching input sequence. The first character, if any, after the input item remains unread. If the length of the input item is zero, the execution of the directive fails; this condition is a matching failure unless end-of-file, an encoding error, or a read error prevented input from the stream, in which case it is an input failure.
- Except in the case of a % specifier, the input item (or, in the case of a %n directive, the count of input characters) is converted to a type appropriate to the conversion specifier. If the input item is not a matching sequence, the execution of the directive fails: this condition is a matching failure. Unless assignment suppression was indicated by a \*, the result of the conversion is placed in the object pointed to by the first argument following the format argument that has not already received a conversion result. If this object does not have an appropriate type, or if the result of the conversion cannot be represented in the object, the behavior is undefined.

.. _length-modifiers-1:

Length modifiers
''''''''''''''''

The length modifiers and their meanings are:

+------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Flag | Description                                                                                                                                                                                                                                                     |
+======+=================================================================================================================================================================================================================================================================+
| hh   | Specifies that a following d, i, o, u, x, X, or n conversion specifier applies to an argument with type pointer to signed char or pointer to unsigned char.                                                                                                     |
+------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| h    | Specifies that a following d, i, o, u, x, X, or n conversion specifier applies to an argument with type pointer to short int or unsigned short int.                                                                                                             |
+------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| l    | Specifies that a following d, i, o, u, x, X, or n conversion specifier applies to an argument with type pointer to long int or unsigned long int; that a following e, E, f, F, g, or G conversion specifier applies to an argument with type pointer to double. |
+------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| ll   | Specifies that a following d, i, o, u, x, X, or n conversion specifier applies to an argument with type pointer to long long int or unsigned long long int.                                                                                                     |
+------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

If a length modifier appears with any conversion specifier other than as specified above, the behavior is undefined. Note that the C99 length modifiers j, z, and t are not supported.

.. _conversion-specifiers-1:

Conversion specifiers
'''''''''''''''''''''

+---------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Flag    | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
+=========+==================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================+
| d       | Matches an optionally signed decimal integer, whose format is the same as expected for the subject sequence of the `strtol()`_ function with the value 10 for the base argument. The corresponding argument must be a pointer to signed integer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
+---------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| i       | Matches an optionally signed integer, whose format is the same as expected for the subject sequence of the `strtol()`_ function with the value zero for the base argument. The corresponding argument must be a pointer to signed integer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
+---------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| o       | Matches an optionally signed octal integer, whose format is the same as expected for the subject sequence of the `strtol()`_ function with the value 18 for the base argument. The corresponding argument must be a pointer to signed integer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
+---------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| u       | Matches an optionally signed decimal integer, whose format is the same as expected for the subject sequence of the `strtoul()`_ function with the value 10 for the base argument. The corresponding argument must be a pointer to unsigned integer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
+---------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| x       | Matches an optionally signed hexadecimal integer, whose format is the same as expected for the subject sequence of the `strtoul()`_ function with the value 16 for the base argument. The corresponding argument must be a pointer to unsigned integer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
+---------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| e, f, g | Matches an optionally signed floating-point number whose format is the same as expected for the subject sequence of the `strtod()`_ function. The corresponding argument shall be a pointer to floating.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
+---------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| c       | Matches a sequence of characters of exactly the number specified by the field width (one if no field width is present in the directive). The corresponding argument must be a pointer to the initial element of a character array large enough to accept the sequence. No null character is added.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
+---------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| s       | Matches a sequence of non-white-space characters The corresponding argument must be a pointer to the initial element of a character array large enough to accept the sequence and a terminating null character, which will be added automatically.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
+---------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| [       | Matches a nonempty sequence of characters from a set of expected characters (the scanset). The corresponding argument must be a pointer to the initial element of a character array large enough to accept the sequence and a terminating null character, which will be added automatically. The conversion specifier includes all subsequent characters in the format string, up to and including the matching right bracket ]. The characters between the brackets (the scanlist) compose the scanset, unless the character after the left bracket is a circumflex ^, in which case the scanset contains all characters that do not appear in the scanlist between the circumflex and the right bracket. If the conversion specifier begins with [] or[^], the right bracket character is in the scanlist and the next following right bracket character is the matching right bracket that ends the specification; otherwise the first following right bracket character is the one that ends the specification. If a - character is in the scanlist and is not the first, nor the second where the first character is a ^, nor the last character, it is treated as a member of the scanset. |
+---------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| p       | Reads a sequence output by the corresponding %p formatted output conversion. The corresponding argument must be a pointer to a pointer to void.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
+---------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| n       | No input is consumed. The corresponding argument shall be a pointer to signed integer into which is to be written the number of characters read from the input stream so far by this call to the formatted input function. Execution of a %n directive does not increment the assignment count returned at the completion of execution of the fscanf function. No argument is converted, but one is consumed. If the conversion specification includes an assignment-suppressing character or a field width, the behavior is undefined.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
+---------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| %       | Matches a single % character; no conversion or assignment occurs.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
+---------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

Note that the C99 width modifier l used in conjunction with the c, s, and [ conversion specifiers is not supported and nor are the conversion specifiers a and A.

Character and string I/O functions
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

+---------------+------------------------------------------------------+
| Function      | Description                                          |
+===============+======================================================+
| `getchar()`_  | Read character from standard input.                  |
+---------------+------------------------------------------------------+
| `gets()`_     | Read string from standard input.                     |
+---------------+------------------------------------------------------+
| `putc()`_     | Write character to file.                             |
+---------------+------------------------------------------------------+
| `putchar()`_  | Write character to standard output.                  |
+---------------+------------------------------------------------------+
| `puts()`_     | Write string to standard output.                     |
+---------------+------------------------------------------------------+

getchar()
'''''''''

Description

Read character from standard input.

Prototype

::

   int getchar(void);

Return value

If the stream is at end-of-file or a read error occurs, returns EOF, otherwise a nonnegative value.

Additional information

Reads a single character from the standard input stream.

gets()
''''''

Description

Read string from standard input.

Prototype

::

   char *gets(char * s);

Parameters

+---------------+------------------------------------------------------+
| Parameter     | Description                                          |
+===============+======================================================+
| s             | Pointer to object that receives the string.          |
+---------------+------------------------------------------------------+

Return value

Returns s if successful. If end-of-file is encountered and no characters have been read into the array, the contents of the array remain unchanged and a null pointer is returned. If a read error occurs during the operation, the array contents are indeterminate and a null null pointer is return.

Additional information

This function reads characters from standard input into the array pointed to by s until end-of-file is encountered or a new-line character is read. Any new-line character is discarded, and a null character is written immediately after the last character read into the array.

putc()
''''''

Description

Write character to file.

Prototype

::

   int putc(int    c,
            FILE * stream);

Parameters

+-------------------+--------------------------------------------------+
| Parameter         | Description                                      |
+===================+==================================================+
| c                 | Character to write.                              |
+-------------------+--------------------------------------------------+
| stream            | Pointer to stream to write to.                   |
+-------------------+--------------------------------------------------+

Return value

If no error, the character written. If a write error occurs, returns EOF.

Additional information

Writes the character c to stream.

putchar()
'''''''''

Description

Write character to standard output.

Prototype

::

   int putchar(int c);

Parameters

+--------------------------+-------------------------------------------+
| Parameter                | Description                               |
+==========================+===========================================+
| c                        | Character to write.                       |
+--------------------------+-------------------------------------------+

Return value

If no error, the character written. If a write error occurs, returns EOF.

Additional information

Writes the character c to the standard output stream.

puts()
''''''

Description

Write string to standard output.

Prototype

::

   int puts(const char * s);

Parameters

+-----------------+----------------------------------------------------+
| Parameter       | Description                                        |
+=================+====================================================+
| s               | Pointer to zero-terminated string.                 |
+-----------------+----------------------------------------------------+

Return value

Returns EOF if a write error occurs; otherwise it returns a nonnegative value.

Additional information

Writes the string pointed to by s to the standard output stream using `putchar()`_ and appends a new-line character to the output. The terminating null character is not written.

Formatted input functions
^^^^^^^^^^^^^^^^^^^^^^^^^

+--------------+---------------------------------------------------------+
| Function     | Description                                             |
+==============+=========================================================+
| `scanf()`_   | Formatted read from standard input.                     |
+--------------+---------------------------------------------------------+
| `sscanf()`_  | Formatted read from string.                             |
+--------------+---------------------------------------------------------+
| `vscanf()`_  | Formatted read from standard input, variadic.           |
+--------------+---------------------------------------------------------+
| `vsscanf()`_ | Formatted read from string, variadic.                   |
+--------------+---------------------------------------------------------+

scanf()
'''''''

Description

Formatted read from standard input.

Prototype

::

   int scanf(const char * format,
                          ...);

Parameters

+-------------+--------------------------------------------------------+
| Parameter   | Description                                            |
+=============+========================================================+
| format      | Pointer to zero-terminated format control string.      |
+-------------+--------------------------------------------------------+

Return value

Returns the value of the macro EOF if an input failure occurs before any conversion. Otherwise, returns the number of input items assigned, which can be fewer than provided for, or even zero, in the event of an early matching failure.

Additional information

Reads input from the standard input stream under control of the string pointed to by format that specifies the admissible input sequences and how they are to be converted for assignment, using subsequent arguments as pointers to the objects to receive the converted input.

If there are insufficient arguments for the format, the behavior is undefined. If the format is exhausted while arguments remain, the excess arguments are evaluated but are otherwise ignored.

sscanf()
''''''''

Description

Formatted read from string.

Prototype

::

   int sscanf(const char * s,
              const char * format,
                           ...);

Parameters

+-------------+--------------------------------------------------------+
| Parameter   | Description                                            |
+=============+========================================================+
| s           | Pointer to string to read from.                        |
+-------------+--------------------------------------------------------+
| format      | Pointer to zero-terminated format control string.      |
+-------------+--------------------------------------------------------+

Return value

Returns the value of the macro EOF if an input failure occurs before any conversion. Otherwise, returns the number of input items assigned, which can be fewer than provided for, or even zero, in the event of an early matching failure.

Additional information

Reads input from the string s under control of the string pointed to by format that specifies the admissible input sequences and how they are to be converted for assignment, using subsequent arguments as pointers to the objects to receive the converted input.

If there are insufficient arguments for the format, the behavior is undefined. If the format is exhausted while arguments remain, the excess arguments are evaluated but are otherwise ignored.

vscanf()
''''''''

Description

Formatted read from standard input, variadic.

Prototype

::

   int vscanf(const char    * format,
                    va_list   arg);

Parameters

+-------------+--------------------------------------------------------+
| Parameter   | Description                                            |
+=============+========================================================+
| format      | Pointer to zero-terminated format control string.      |
+-------------+--------------------------------------------------------+
| arg         | Variable parameter list.                               |
+-------------+--------------------------------------------------------+

Return value

Returns the value of the macro EOF if an input failure occurs before any conversion. Otherwise, returns the number of input items assigned, which can be fewer than provided for, or even zero, in the event of an early matching failure.

Additional information

Reads input from the standard input stream under control of the string pointed to by format that specifies the admissible input sequences and how they are to be converted for assignment, using subsequent arguments as pointers to the objects to receive the converted input. Before calling `vscanf()`_, arg must be initialized by the va_start() macro (and possibly subsequent va_arg() calls). `vscanf()`_ does not invoke the va_end() macro.

If there are insufficient arguments for the format, the behavior is undefined.

vsscanf()
'''''''''

Description

Formatted read from string, variadic.

Prototype

::

   int vsscanf(const char    * s,
               const char    * format,
                     va_list   arg);

Parameters

+-------------+--------------------------------------------------------+
| Parameter   | Description                                            |
+=============+========================================================+
| s           | Pointer to string to read from.                        |
+-------------+--------------------------------------------------------+
| format      | Pointer to zero-terminated format control string.      |
+-------------+--------------------------------------------------------+
| arg         | Variable parameter list.                               |
+-------------+--------------------------------------------------------+

Return value

Returns the value of the macro EOF if an input failure occurs before any conversion. Otherwise, returns the number of input items assigned, which can be fewer than provided for, or even zero, in the event of an early matching failure.

Additional information

Reads input from the standard input stream under control of the string pointed to by format that specifies the admissible input sequences and how they are to be converted for assignment, using subsequent arguments as pointers to the objects to receive the converted input. Before calling `vsscanf()`_, arg must be initialized by the va_start() macro (and possibly subsequent va_arg() calls). `vsscanf()`_ does not invoke the va_end() macro.

If there are insufficient arguments for the format, the behavior is undefined.

Formatted output functions
^^^^^^^^^^^^^^^^^^^^^^^^^^

+----------------+-------------------------------------------------------+
| Function       | Description                                           |
+================+=======================================================+
| `printf()`_    | Formatted write to standard output.                   |
+----------------+-------------------------------------------------------+
| `sprintf()`_   | Formatted write to string.                            |
+----------------+-------------------------------------------------------+
| `snprintf()`_  | Formatted write to string, limit length.              |
+----------------+-------------------------------------------------------+
| `vprintf()`_   | Formatted write to standard output, variadic.         |
+----------------+-------------------------------------------------------+
| `vsprintf()`_  | Formatted write to string, variadic.                  |
+----------------+-------------------------------------------------------+
| `vsnprintf()`_ | Formatted write to string, limit length, variadic.    |
+----------------+-------------------------------------------------------+

printf()
''''''''

Description

Formatted write to standard output.

Prototype

::

   int printf(const char * format,
                           ...);

Parameters

+-------------+--------------------------------------------------------+
| Parameter   | Description                                            |
+=============+========================================================+
| format      | Pointer to zero-terminated format control string.      |
+-------------+--------------------------------------------------------+

Return value

Returns the number of characters written, or a negative value if an output or encoding error occurred.

Additional information

Writes to the standard output stream under control of the string pointed to by format that specifies how subsequent arguments are converted for output.

If there are insufficient arguments for the format, the behavior is undefined. If the format is exhausted while arguments remain, the excess arguments are evaluated but are otherwise ignored.

sprintf()
'''''''''

Description

Formatted write to string.

Prototype

::

   int sprintf(      char * s,
               const char * format,
                            ...);

Parameters

+------------+---------------------------------------------------------+
| Parameter  | Description                                             |
+============+=========================================================+
| s          | Pointer to array that receives the formatted output.    |
+------------+---------------------------------------------------------+
| format     | Pointer to zero-terminated format control string.       |
+------------+---------------------------------------------------------+

Return value

Returns number of characters written to s (not counting the terminating null), or a negative value if an output or encoding error occurred.

Additional information

Writes to the string pointed to by s under control of the string pointed to by format that specifies how subsequent arguments are converted for output. A null character is written at the end of the characters written; it is not counted as part of the returned value.

If there are insufficient arguments for the format, the behavior is undefined. If the format is exhausted while arguments remain, the excess arguments are evaluated but are otherwise ignored.

If copying takes place between objects that overlap, the behavior is undefined.

snprintf()
''''''''''

Description

Formatted write to string, limit length.

Prototype

::

   int snprintf(      char   * s,
                      size_t   n,
                const char   * format,
                               ...);

Parameters

+-----------+---------------------------------------------------------------------+
| Parameter | Description                                                         |
+===========+=====================================================================+
| s         | Pointer to array that receives the formatted output.                |
+-----------+---------------------------------------------------------------------+
| n         | Maximum number of characters to write to the array pointed to by s. |
+-----------+---------------------------------------------------------------------+
| format    | Pointer to zero-terminated format control string.                   |
+-----------+---------------------------------------------------------------------+

Return value

Returns the number of characters that would have been written had n been sufficiently large, not counting the terminating null character, or a negative value if an encoding error occurred. Thus, the null-terminated output has been completely written if and only if the returned value is nonnegative and less than n.

Additional information

Writes to the string pointed to by s under control of the string pointed to by format that specifies how subsequent arguments are converted for output.

If n is zero, nothing is written, and s can be a null pointer. Otherwise, output characters beyond count n-1 are discarded rather than being written to the array, and a null character is written at the end of the characters actually written into the array. A null character is written at the end of the conversion; it is not counted as part of the returned value.

If there are insufficient arguments for the format, the behavior is undefined. If the format is exhausted while arguments remain, the excess arguments are evaluated but are otherwise ignored.

If copying takes place between objects that overlap, the behavior is undefined.

vprintf()
'''''''''

Description

Formatted write to standard output, variadic.

Prototype

::

   int vprintf(const char    * format,
                     va_list   arg);

Parameters

+-------------+--------------------------------------------------------+
| Parameter   | Description                                            |
+=============+========================================================+
| format      | Pointer to zero-terminated format control string.      |
+-------------+--------------------------------------------------------+
| arg         | Variable parameter list.                               |
+-------------+--------------------------------------------------------+

Return value

Returns the number of characters written, or a negative value if an output or encoding error occurred.

Additional information

Writes to the standard output stream using under control of the string pointed to by format that specifies how subsequent arguments are converted for output. Before calling `vprintf()`_, arg must be initialized by the va_start macro (and possibly subsequent va_arg calls). `vprintf()`_ does not invoke the va_end macro.

vsprintf()
''''''''''

Description

Formatted write to string, variadic.

Prototype

::

   int vsprintf(      char    * s,
                const char    * format,
                      va_list   arg);

Parameters

+------------+---------------------------------------------------------+
| Parameter  | Description                                             |
+============+=========================================================+
| s          | Pointer to array that receives the formatted output.    |
+------------+---------------------------------------------------------+
| format     | Pointer to zero-terminated format control string.       |
+------------+---------------------------------------------------------+
| arg        | Variable parameter list.                                |
+------------+---------------------------------------------------------+

Return value

Returns number of characters written to s (not counting the terminating null), or a negative value if an output or encoding error occurred.

Additional information

Writes to the string pointed to by s under control of the string pointed to by format that specifies how subsequent arguments are converted for output. A null character is written at the end of the characters written; it is not counted as part of the returned value.

Before calling `vsprintf()`_, arg must be initialized by the va_start macro (and possibly subsequent va_arg calls). `vsprintf()`_ does not invoke the va_end macro.

If there are insufficient arguments for the format, the behavior is undefined. If the format is exhausted while arguments remain, the excess arguments are evaluated but are otherwise ignored.

If copying takes place between objects that overlap, the behavior is undefined.

Notes

This is equivalent to `sprintf()`_ with the variable argument list replaced by arg.

vsnprintf()
'''''''''''

Description

Formatted write to string, limit length, variadic.

Prototype

::

   int vsnprintf(      char    * s,
                       size_t    n,
                 const char    * format,
                       va_list   arg);

Parameters

+-----------+---------------------------------------------------------------------+
| Parameter | Description                                                         |
+===========+=====================================================================+
| s         | Pointer to array that receives the formatted output.                |
+-----------+---------------------------------------------------------------------+
| n         | Maximum number of characters to write to the array pointed to by s. |
+-----------+---------------------------------------------------------------------+
| format    | Pointer to zero-terminated format control string.                   |
+-----------+---------------------------------------------------------------------+
| arg       | Variable parameter list.                                            |
+-----------+---------------------------------------------------------------------+

Return value

Returns the number of characters that would have been written had n been sufficiently large, not counting the terminating null character, or a negative value if an encoding error occurred. Thus, the null-terminated output has been completely written if and only if the returned value is nonnegative and less than n.

Additional information

Writes to the string pointed to by s under control of the string pointed to by format that specifies how subsequent arguments are converted for output. Before calling `vsnprintf()`_, arg must be initialized by the va_start macro (and possibly subsequent va_arg() calls). `vsnprintf()`_ does not invoke the va_end macro.

If n is zero, nothing is written, and s can be a null pointer. Otherwise, output characters beyond count n-1 are discarded rather than being written to the array, and a null character is written at the end of the characters actually written into the array. A null character is written at the end of the conversion; it is not counted as part of the returned value.

If there are insufficient arguments for the format, the behavior is undefined. If the format is exhausted while arguments remain, the excess arguments are evaluated but are otherwise ignored.

If copying takes place between objects that overlap, the behavior is undefined.

Notes

This is equivalent to `snprintf()`_ with the variable argument list replaced by arg.

<stdlib.h>
~~~~~~~~~~

Process control functions
^^^^^^^^^^^^^^^^^^^^^^^^^

+----------------+-----------------------------------------------------+
| Function       | Description                                         |
+================+=====================================================+
| `atexit()`_    | Set function to be called on exit.                  |
+----------------+-----------------------------------------------------+
| `abort()`_     | Abort execution.                                    |
+----------------+-----------------------------------------------------+

atexit()
''''''''

Description

Set function to be called on exit.

Prototype

::

   int atexit(__SEGGER_RTL_exit_func fn);

Parameters

+-------------------------+--------------------------------------------+
| Parameter               | Description                                |
+=========================+============================================+
| fn                      | Function to register.                      |
+-------------------------+--------------------------------------------+

Return value

+---------+------------------------------------------------------------+
| = 0     | Success registering function.                              |
+---------+------------------------------------------------------------+
| ≠ 0     | Did not register function.                                 |
+---------+------------------------------------------------------------+

Additional information

Registers function fn to be called when the application has exited. The functions registered with `atexit()`_ are executed in reverse order of their registration.

abort()
'''''''

Description

Abort execution.

Prototype

::

   void abort(void);

Additional information

Calls exit() with the exit status -1.

Integer arithmetic functions
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

+------------+----------------------------------------------------------+
| Function   | Description                                              |
+============+==========================================================+
| `abs()`_   | Calculate absolute value, int.                           |
+------------+----------------------------------------------------------+
| `labs()`_  | Calculate absolute value, long.                          |
+------------+----------------------------------------------------------+
| `llabs()`_ | Calculate absolute value, long long.                     |
+------------+----------------------------------------------------------+
| `div()`_   | Divide returning quotient and remainder, int.            |
+------------+----------------------------------------------------------+
| `ldiv()`_  | Divide returning quotient and remainder, long.           |
+------------+----------------------------------------------------------+
| `lldiv()`_ | Divide returning quotient and remainder, long long.      |
+------------+----------------------------------------------------------+

abs()
'''''

Description

Calculate absolute value, int.

Prototype

::

   int abs(int Value);

Parameters

+-------------------------------+--------------------------------------+
| Parameter                     | Description                          |
+===============================+======================================+
| Value                         | Integer value.                       |
+-------------------------------+--------------------------------------+

Return value

The absolute value of the integer argument Value.

labs()
''''''

Description

Calculate absolute value, long.

Prototype

::

   long int labs(long int Value);

Parameters

+--------------------------+-------------------------------------------+
| Parameter                | Description                               |
+==========================+===========================================+
| Value                    | Long integer value.                       |
+--------------------------+-------------------------------------------+

Return value

The absolute value of the long integer argument Value.

llabs()
'''''''

Description

Calculate absolute value, long long.

Prototype

::

   long long int llabs(long long int Value);

Parameters

+----------------------+-----------------------------------------------+
| Parameter            | Description                                   |
+======================+===============================================+
| Value                | Long long integer value.                      |
+----------------------+-----------------------------------------------+

Return value

The absolute value of the long long integer argument Value.

div()
'''''

Description

Divide returning quotient and remainder, int.

Prototype

::

   div_t div(int Numer,
             int Denom);

Parameters

+------------------------------+---------------------------------------+
| Parameter                    | Description                           |
+==============================+=======================================+
| Numer                        | Numerator.                            |
+------------------------------+---------------------------------------+
| Denom                        | Demoninator.                          |
+------------------------------+---------------------------------------+

Return value

Returns a structure of type div_t comprising both the quotient and the remainder. The structures contain the members quot (the quotient) and rem (the remainder), each of which has the same type as the arguments Numer and Denom. If either part of the result cannot be represented, the behavior is undefined.

Additional information

This computes Numer divided by Denom and Numer modulo Denom in a single operation.

See also

div_t

ldiv()
''''''

Description

Divide returning quotient and remainder, long.

Prototype

::

   ldiv_t ldiv(long Numer,
               long Denom);

Parameters

+------------------------------+---------------------------------------+
| Parameter                    | Description                           |
+==============================+=======================================+
| Numer                        | Numerator.                            |
+------------------------------+---------------------------------------+
| Denom                        | Demoninator.                          |
+------------------------------+---------------------------------------+

Return value

Returns a structure of type ldiv_t comprising both the quotient and the remainder. The structures contain the members quot (the quotient) and rem (the remainder), each of which has the same type as the arguments Numer and Denom. If either part of the result cannot be represented, the behavior is undefined.

Additional information

This computes Numer divided by Denom and Numer modulo Denom in a single operation.

See also

ldiv_t

lldiv()
'''''''

Description

Divide returning quotient and remainder, long long.

Prototype

::

   lldiv_t lldiv(long long Numer,
                 long long Denom);

Parameters

+------------------------------+---------------------------------------+
| Parameter                    | Description                           |
+==============================+=======================================+
| Numer                        | Numerator.                            |
+------------------------------+---------------------------------------+
| Denom                        | Demoninator.                          |
+------------------------------+---------------------------------------+

Return value

Returns a structure of type lldiv_t comprising both the quotient and the remainder. The structures contain the members quot (the quotient) and rem (the remainder), each of which has the same type as the arguments Numer and Denom. If either part of the result cannot be represented, the behavior is undefined.

Additional information

This computes Numer divided by Denom and Numer modulo Denom in a single operation.

See also

lldiv_t

Pseudo-random sequence generation functions
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

+-------------+--------------------------------------------------------+
| Function    | Description                                            |
+=============+========================================================+
| `rand()`_   | Return next random number in sequence.                 |
+-------------+--------------------------------------------------------+
| `srand()`_  | Set seed of random number sequence.                    |
+-------------+--------------------------------------------------------+

rand()
''''''

Description

Return next random number in sequence.

Prototype

::

   int rand(void);

Return value

Returns the computed pseudo-random integer.

Additional information

This computes a sequence of pseudo-random integers in the range 0 to RAND_MAX.

See also

`srand()`_

srand()
'''''''

Description

Set seed of random number sequence.

Prototype

::

   void srand(unsigned s);

Parameters

+--------------+-------------------------------------------------------+
| Parameter    | Description                                           |
+==============+=======================================================+
| s            | New seed value for pseudo-random sequence.            |
+--------------+-------------------------------------------------------+

Additional information

This uses the argument Seed as a seed for a new sequence of pseudo-random numbers to be returned by subsequent calls to `rand()`_. If `srand()`_ is called with the same seed value, the same sequence of pseudo-random numbers is generated.

If `rand()`_ is called before any calls to `srand()`_ have been made, a sequence is generated as if `srand()`_ is first called with a seed value of 1.

See also

`rand()`_

Memory allocation functions
^^^^^^^^^^^^^^^^^^^^^^^^^^^

+--------------+----------------------------------------------------------+
| Function     | Description                                              |
+==============+==========================================================+
| `malloc()`_  | Allocate space for single object.                        |
+--------------+----------------------------------------------------------+
| `calloc()`_  | Allocate space for multiple objects and zero them.       |
+--------------+----------------------------------------------------------+
| `realloc()`_ | Resize or allocate memory space.                         |
+--------------+----------------------------------------------------------+
| `free()`_    | Free allocated memory for reuse.                         |
+--------------+----------------------------------------------------------+

malloc()
''''''''

Description

Allocate space for single object.

Prototype

::

   void *malloc(size_t sz);

Parameters

+-------------+--------------------------------------------------------+
| Parameter   | Description                                            |
+=============+========================================================+
| sz          | Number of characters to allocate for the object.       |
+-------------+--------------------------------------------------------+

Return value

Returns a null pointer if the space for the object cannot be allocated from free memory; if space for the object can be allocated, `malloc()`_ returns a pointer to the start of the allocated space.

Additional information

Allocates space for an object whose size is specified by sz and whose value is indeterminate.

calloc()
''''''''

Description

Allocate space for multiple objects and zero them.

Prototype

::

   void *calloc(size_t nobj,
                size_t sz);

Parameters

+--------------+-------------------------------------------------------+
| Parameter    | Description                                           |
+==============+=======================================================+
| nobj         | Number of objects to allocate.                        |
+--------------+-------------------------------------------------------+
| sz           | Number of characters to allocate per object.          |
+--------------+-------------------------------------------------------+

Return value

Returns a null pointer if the space for the object cannot be allocated from free memory; if space for the object can be allocated, `malloc()`_ returns a pointer to the start of the allocated space.

Additional information

Allocates space for an array of nobj objects, each of whose size is sz. The space is initialized to all zero bits.

realloc()
'''''''''

Description

Resize or allocate memory space.

Prototype

::

   void *realloc(void   * ptr,
                 size_t   sz);

Parameters

+----------------+-----------------------------------------------------+
| Parameter      | Description                                         |
+================+=====================================================+
| ptr            | Pointer to resize, or NULL to allocate.             |
+----------------+-----------------------------------------------------+
| sz             | New size of object.                                 |
+----------------+-----------------------------------------------------+

Return value

Returns a pointer to the new object (which may have the same value as a pointer to the old object), or a null pointer if the new object could not be allocated.

Additional information

Deallocates the old object pointed to by ptr and returns a pointer to a new object that has the size specified by sz. The contents of the new object is identical to that of the old object prior to deallocation, up to the lesser of the new and old sizes. Any bytes in the new object beyond the size of the old object have indeterminate values.

If ptr is a null pointer, `realloc()`_ behaves like `malloc()`_ for the specified size. If memory for the new object cannot be allocated, the old object is not deallocated and its value is unchanged.

If ptr does not match a pointer earlier returned by `calloc()`_, `malloc()`_, or `realloc()`_, or if the space has been deallocated by a call to `free()`_ or `realloc()`_, the behavior is undefined.

free()
''''''

Description

Free allocated memory for reuse.

Prototype

::

   void free(void * ptr);

Parameters

+----------------------+-----------------------------------------------+
| Parameter            | Description                                   |
+======================+===============================================+
| ptr                  | Pointer to object to free.                    |
+----------------------+-----------------------------------------------+

Additional information

Causes the space pointed to by ptr to be deallocated, that is, made available for further allocation. If ptr is a null pointer, no action occurs.

If ptr does not match a pointer earlier returned by `calloc()`_, `malloc()`_, or `realloc()`_, or if the space has been deallocated by a call to `free()`_ or `realloc()`_, the behavior is undefined.

Search and sort functions
^^^^^^^^^^^^^^^^^^^^^^^^^

+-----------------------+----------------------------------------------+
| Function              | Description                                  |
+=======================+==============================================+
| `qsort()`_            | Sort array.                                  |
+-----------------------+----------------------------------------------+
| `bsearch()`_          | Search sorted array.                         |
+-----------------------+----------------------------------------------+

qsort()
'''''''

Description

Sort array.

Prototype

::

   void qsort(void   * base,
              size_t   nmemb,
              size_t   sz,
              int      ( *compare)(const void * elem1 , const void * elem2 ));

Parameters

+---------------+------------------------------------------------------+
| Parameter     | Description                                          |
+===============+======================================================+
| base          | Pointer to the start of the array.                   |
+---------------+------------------------------------------------------+
| nmemb         | Number of array elements.                            |
+---------------+------------------------------------------------------+
| sz            | Number of characters per array element.              |
+---------------+------------------------------------------------------+
| compare       | Pointer to element comparison function.              |
+---------------+------------------------------------------------------+

Additional information

Sorts the array pointed to by base using the compare function. The array should have nmemb elements of sz bytes. The compare function should return a negative value if the first parameter is less than the second parameter, zero if the parameters are equal, and a positive value if the first parameter is greater than the second parameter.

bsearch()
'''''''''

Description

Search sorted array.

Prototype

::

   void *bsearch
               (const void   * key,
                const void   * base,
                      size_t   nmemb,
                      size_t   sz,
                      int      ( *compare)(const void * elem1 , const void * elem2 ));

Parameters

+---------------+------------------------------------------------------+
| Parameter     | Description                                          |
+===============+======================================================+
| key           | Pointer to object to search for.                     |
+---------------+------------------------------------------------------+
| base          | Pointer to the start of the array.                   |
+---------------+------------------------------------------------------+
| nmemb         | Number of array elements.                            |
+---------------+------------------------------------------------------+
| sz            | Number of characters per array element.              |
+---------------+------------------------------------------------------+
| compare       | Pointer to element comparison function.              |
+---------------+------------------------------------------------------+

Return value

+------------------+---------------------------------------------------+
| = NULL           | Key not found.                                    |
+------------------+---------------------------------------------------+
| ≠ NULL           | Pointer to found object.                          |
+------------------+---------------------------------------------------+

Additional information

Searches the array pointed to by base for the specified key and returns a pointer to the first entry that matches, or null if no match. The array should have nmemb elements of sz bytes and be sorted by the same algorithm as the compare function.

The compare function should return a negative value if the first parameter is less than second parameter, zero if the parameters are equal, and a positive value if the first parameter is greater than the second parameter.

Number to string conversions
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

+--------------+-------------------------------------------------------+
| Function     | Description                                           |
+==============+=======================================================+
| `itoa()`_    | Convert to string, int.                               |
+--------------+-------------------------------------------------------+
| `ltoa()`_    | Convert to string, long.                              |
+--------------+-------------------------------------------------------+
| `lltoa()`_   | Convert to string, long long.                         |
+--------------+-------------------------------------------------------+
| `utoa()`_    | Convert to string, unsigned.                          |
+--------------+-------------------------------------------------------+
| `ultoa()`_   | Convert to string, unsigned long.                     |
+--------------+-------------------------------------------------------+
| `ulltoa()`_  | Convert to string, unsigned long long.                |
+--------------+-------------------------------------------------------+

itoa()
''''''

Description

Convert to string, int.

Prototype

::

   char *itoa(int    val,
              char * buf,
              int    radix);

Parameters

+------------+----------------------------------------------------------+
| Parameter  | Description                                              |
+============+==========================================================+
| val        | Value to convert.                                        |
+------------+----------------------------------------------------------+
| buf        | Pointer to array of characters that receives the string. |
+------------+----------------------------------------------------------+
| radix      | Number base to use for conversion, 2 to 36.              |
+------------+----------------------------------------------------------+

Return value

Returns buf.

Additional information

Converts val to a string in base radix and places the result in buf which must be large enough to hold the output. If radix is greater than 36, the result is undefined.

If val is negative and radix is 10, the string has a leading minus sign (-); for all other values of radix, value is considered unsigned and never has a leading minus sign.

Notes

This is a non-standard function. Even though this function is commonly used by compilers on other platforms, there is no guarantee that this function will behave the same on all platforms, in all cases.

See also

`ltoa()`_, `lltoa()`_, `utoa()`_, `ultoa()`_, `ulltoa()`_

ltoa()
''''''

Description

Convert to string, long.

Prototype

::

   char *ltoa(long   val,
              char * buf,
              int    radix);

Parameters

+------------+----------------------------------------------------------+
| Parameter  | Description                                              |
+============+==========================================================+
| val        | Value to convert.                                        |
+------------+----------------------------------------------------------+
| buf        | Pointer to array of characters that receives the string. |
+------------+----------------------------------------------------------+
| radix      | Number base to use for conversion, 2 to 36.              |
+------------+----------------------------------------------------------+

Return value

Returns buf.

Additional information

Converts val to a string in base radix and places the result in buf which must be large enough to hold the output. If radix is greater than 36, the result is undefined.

If val is negative and radix is 10, the string has a leading minus sign (-); for all other values of radix, value is considered unsigned and never has a leading minus sign.

Notes

This is a non-standard function. Even though this function is commonly used by compilers on other platforms, there is no guarantee that this function will behave the same on all platforms, in all cases.

See also

`itoa()`_, `lltoa()`_, `utoa()`_, `ultoa()`_, `ulltoa()`_

lltoa()
'''''''

Description

Convert to string, long long.

Prototype

::

   char *lltoa(long long   val,
               char      * buf,
               int         radix);

Parameters

+------------+----------------------------------------------------------+
| Parameter  | Description                                              |
+============+==========================================================+
| val        | Value to convert.                                        |
+------------+----------------------------------------------------------+
| buf        | Pointer to array of characters that receives the string. |
+------------+----------------------------------------------------------+
| radix      | Number base to use for conversion, 2 to 36.              |
+------------+----------------------------------------------------------+

Return value

Returns buf.

Additional information

Converts val to a string in base radix and places the result in buf which must be large enough to hold the output. If radix is greater than 36, the result is undefined.

If val is negative and radix is 10, the string has a leading minus sign (-); for all other values of radix, value is considered unsigned and never has a leading minus sign.

Notes

This is a non-standard function. Even though this function is commonly used by compilers on other platforms, there is no guarantee that this function will behave the same on all platforms, in all cases.

See also

`itoa()`_, `ltoa()`_, `utoa()`_, `ultoa()`_, `ulltoa()`_

utoa()
''''''

Description

Convert to string, unsigned.

Prototype

::

   char *utoa(unsigned   val,
              char     * buf,
              int        radix);

Parameters

+------------+----------------------------------------------------------+
| Parameter  | Description                                              |
+============+==========================================================+
| val        | Value to convert.                                        |
+------------+----------------------------------------------------------+
| buf        | Pointer to array of characters that receives the string. |
+------------+----------------------------------------------------------+
| radix      | Number base to use for conversion, 2 to 36.              |
+------------+----------------------------------------------------------+

Return value

Returns buf.

Additional information

Converts val to a string in base radix and places the result in buf which must be large enough to hold the output. If radix is greater than 36, the result is undefined.

Notes

This is a non-standard function. Even though this function is commonly used by compilers on other platforms, there is no guarantee that this function will behave the same on all platforms, in all cases.

See also

`itoa()`_, `ltoa()`_, `lltoa()`_, `ultoa()`_, `ulltoa()`_

ultoa()
'''''''

Description

Convert to string, unsigned long.

Prototype

::

   char *ultoa(unsigned long   val,
               char          * buf,
               int             radix);

Parameters

+------------+----------------------------------------------------------+
| Parameter  | Description                                              |
+============+==========================================================+
| val        | Value to convert.                                        |
+------------+----------------------------------------------------------+
| buf        | Pointer to array of characters that receives the string. |
+------------+----------------------------------------------------------+
| radix      | Number base to use for conversion, 2 to 36.              |
+------------+----------------------------------------------------------+

Return value

Returns buf.

Additional information

Converts val to a string in base radix and places the result in buf which must be large enough to hold the output. If radix is greater than 36, the result is undefined.

Notes

This is a non-standard function. Even though this function is commonly used by compilers on other platforms, there is no guarantee that this function will behave the same on all platforms, in all cases.

See also

`itoa()`_, `ltoa()`_, `lltoa()`_, `ulltoa()`_, `utoa()`_

ulltoa()
''''''''

Description

Convert to string, unsigned long long.

Prototype

::

   char *ulltoa(unsigned long long   val,
                char               * buf,
                int                  radix);

Parameters

+------------+----------------------------------------------------------+
| Parameter  | Description                                              |
+============+==========================================================+
| val        | Value to convert.                                        |
+------------+----------------------------------------------------------+
| buf        | Pointer to array of characters that receives the string. |
+------------+----------------------------------------------------------+
| radix      | Number base to use for conversion, 2 to 36.              |
+------------+----------------------------------------------------------+

Return value

Returns buf.

Additional information

Converts val to a string in base radix and places the result in buf which must be large enough to hold the output. If radix is greater than 36, the result is undefined.

Notes

This is a non-standard function. Even though this function is commonly used by compilers on other platforms, there is no guarantee that this function will behave the same on all platforms, in all cases.

See also

`itoa()`_, `ltoa()`_, `lltoa()`_, `ultoa()`_, `utoa()`_

String to number conversions
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

+---------------+-------------------------------------------------------+
| Function      | Description                                           |
+===============+=======================================================+
| `atoi()`_     | Convert to number, int.                               |
+---------------+-------------------------------------------------------+
| `atol()`_     | Convert to number, long.                              |
+---------------+-------------------------------------------------------+
| `atoll()`_    | Convert to number, long long.                         |
+---------------+-------------------------------------------------------+
| `atof()`_     | Convert to number, double.                            |
+---------------+-------------------------------------------------------+
| `strtol()`_   | Convert to number, long.                              |
+---------------+-------------------------------------------------------+
| `strtoll()`_  | Convert to number, long long.                         |
+---------------+-------------------------------------------------------+
| `strtoul()`_  | Convert to number, unsigned long.                     |
+---------------+-------------------------------------------------------+
| `strtoull()`_ | Convert to number, unsigned long long.                |
+---------------+-------------------------------------------------------+
| `strtof()`_   | Convert to number, float.                             |
+---------------+-------------------------------------------------------+
| `strtod()`_   | Convert to number, double.                            |
+---------------+-------------------------------------------------------+
| `strtold()`_  | Convert to number, long double.                       |
+---------------+-------------------------------------------------------+

atoi()
''''''

Description

Convert to number, int.

Prototype

::

   int atoi(const char * nptr);

Parameters

+------------------+---------------------------------------------------+
| Parameter        | Description                                       |
+==================+===================================================+
| nptr             | Pointer to string to convert from.                |
+------------------+---------------------------------------------------+

Return value

Returns the converted value, if any. If the value of the result cannot be represented, the behavior is undefined.

Additional information

Converts the initial portion of the string pointed to by nptr to an int representation.

`atoi()`_ does not affect the value of errno on an error.

Notes

Except for the behavior on error, `atoi()`_ is equivalent to (int)strtol(nptr, NULL, 10).

See also

`strtol()`_

atol()
''''''

Description

Convert to number, long.

Prototype

::

   long int atol(const char * nptr);

Parameters

+------------------+---------------------------------------------------+
| Parameter        | Description                                       |
+==================+===================================================+
| nptr             | Pointer to string to convert from.                |
+------------------+---------------------------------------------------+

Return value

Returns the converted value, if any. If the value of the result cannot be represented, the behavior is undefined.

Additional information

Converts the initial portion of the string pointed to by nptr to a long representation.

`atol()`_ does not affect the value of errno on an error.

Notes

Except for the behavior on error, `atol()`_ is equivalent to strtol(nptr, NULL, 10).

See also

`strtol()`_

atoll()
'''''''

Description

Convert to number, long long.

Prototype

::

   long long int atoll(const char * nptr);

Parameters

+------------------+---------------------------------------------------+
| Parameter        | Description                                       |
+==================+===================================================+
| nptr             | Pointer to string to convert from.                |
+------------------+---------------------------------------------------+

Return value

Returns the converted value, if any. If the value of the result cannot be represented, the behavior is undefined.

Additional information

Converts the initial portion of the string pointed to by nptr to a long-long representation.

`atoll()`_ does not affect the value of errno on an error.

Notes

Except for the behavior on error, `atoll()`_ is equivalent to strtoll(nptr, NULL, 10).

See also

`strtoll()`_

atof()
''''''

Description

Convert to number, double.

Prototype

::

   double atof(const char * nptr);

Parameters

+------------------+---------------------------------------------------+
| Parameter        | Description                                       |
+==================+===================================================+
| nptr             | Pointer to string to convert from.                |
+------------------+---------------------------------------------------+

Return value

Returns the converted value, if any. If the value of the result cannot be represented, the behavior is undefined.

Additional information

Converts the initial portion of the string pointed to by nptr to an double representation.

`atof()`_ does not affect the value of errno on an error.

Notes

Except for the behavior on error, `atof()`_ is equivalent to (int)strtod(nptr, NULL).

See also

`strtod()`_

strtol()
''''''''

Description

Convert to number, long.

Prototype

::

   long strtol(const char  * nptr,
                     char ** endptr,
                     int     base);

Parameters

+-----------+-----------------------------------------------------------------------------------------------+
| Parameter | Description                                                                                   |
+===========+===============================================================================================+
| nptr      | Pointer to string to convert from.                                                            |
+-----------+-----------------------------------------------------------------------------------------------+
| endptr    | If nonnull, a pointer to object that receives the pointer to the first unconverted character. |
+-----------+-----------------------------------------------------------------------------------------------+
| base      | Radix to use for conversion, 2 to 36.                                                         |
+-----------+-----------------------------------------------------------------------------------------------+

Return value

Returns the converted value, if any. If no conversion could be performed, zero is returned. If the correct value is outside the range of representable values, LONG_MIN or LONG_MAX is returned according to the sign of the value, if any, and the value of the macro ERANGE is stored in errno.

Additional information

Converts the initial portion of the string pointed to by nptr to a long representation.

First, `strtol()`_ decomposes the input string into three parts: an initial, possibly empty, sequence of white-space characters, as specified by `isspace()`_, a subject sequence resembling an integer represented in some radix determined by the value of base, and a final string of one or more unrecognized characters, including the terminating null character of the input string. `strtol()`_ then attempts to convert the subject sequence to an integer, and return the result.

When converting, no integer suffix (such as U, L, UL, LL, ULL) is allowed.

If the value of base is zero, the expected form of the subject sequence is an optional plus or minus sign followed by an integer constant.

If the value of base is between 2 and 36 (inclusive), the expected form of the subject sequence is an optional plus or minus sign followed by a sequence of letters and digits representing an integer with the radix specified by base. The letters from a (or A) through z (or Z) represent the values 10 through 35; only letters and digits whose ascribed values are less than that of base are permitted.

If the value of base is 16, the characters “0x” or “0X” may optionally precede the sequence of letters and digits, following the optional sign.

The subject sequence is defined as the longest initial subsequence of the input string, starting with the first non-white-space character, that is of the expected form. The subject sequence contains no characters if the input string is empty or consists entirely of white space, or if the first non-white-space character is other than a sign or a permissible letter or digit.

If the subject sequence has the expected form and the value of base is zero, the sequence of characters starting with the first digit is interpreted as an integer constant. If the subject sequence has the expected form and the value of base is between 2 and 36, it is used as the base for conversion.

If the subject sequence begins with a minus sign, the value resulting from the conversion is negated.

A pointer to the final string is stored in the object pointed to by endptr, provided that endptr is not a null pointer.

If the subject sequence is empty or does not have the expected form, no conversion is performed, the value of nptr is stored in the object pointed to by endptr, provided that endptr is not a null pointer.

strtoll()
'''''''''

Description

Convert to number, long long.

Prototype

::

   long long strtoll(const char  * nptr,
                           char ** endptr,
                           int     base);

Parameters

+-----------+-----------------------------------------------------------------------------------------------+
| Parameter | Description                                                                                   |
+===========+===============================================================================================+
| nptr      | Pointer to string to convert from.                                                            |
+-----------+-----------------------------------------------------------------------------------------------+
| endptr    | If nonnull, a pointer to object that receives the pointer to the first unconverted character. |
+-----------+-----------------------------------------------------------------------------------------------+
| base      | Radix to use for conversion, 2 to 36.                                                         |
+-----------+-----------------------------------------------------------------------------------------------+

Return value

Returns the converted value, if any. If no conversion could be performed, zero is returned. If the correct value is outside the range of representable values, LLONG_MIN or LLONG_MAX is returned according to the sign of the value, if any, and the value of the macro ERANGE is stored in errno.

Additional information

Converts the initial portion of the string pointed to by nptr to a long representation.

First, `strtoll()`_ decomposes the input string into three parts: an initial, possibly empty, sequence of white-space characters, as specified by `isspace()`_, a subject sequence resembling an integer represented in some radix determined by the value of base, and a final string of one or more unrecognized characters, including the terminating null character of the input string. `strtoll()`_ then attempts to convert the subject sequence to an integer, and return the result.

When converting, no integer suffix (such as U, L, UL, LL, ULL) is allowed.

If the value of base is zero, the expected form of the subject sequence is an optional plus or minus sign followed by an integer constant.

If the value of base is between 2 and 36 (inclusive), the expected form of the subject sequence is an optional plus or minus sign followed by a sequence of letters and digits representing an integer with the radix specified by base. The letters from a (or A) through z (or Z) represent the values 10 through 35; only letters and digits whose ascribed values are less than that of base are permitted.

If the value of base is 16, the characters “0x” or “0X” may optionally precede the sequence of letters and digits, following the optional sign.

The subject sequence is defined as the longest initial subsequence of the input string, starting with the first non-white-space character, that is of the expected form. The subject sequence contains no characters if the input string is empty or consists entirely of white space, or if the first non-white-space character is other than a sign or a permissible letter or digit.

If the subject sequence has the expected form and the value of base is zero, the sequence of characters starting with the first digit is interpreted as an integer constant. If the subject sequence has the expected form and the value of base is between 2 and 36, it is used as the base for conversion.

If the subject sequence begins with a minus sign, the value resulting from the conversion is negated.

A pointer to the final string is stored in the object pointed to by endptr, provided that endptr is not a null pointer.

If the subject sequence is empty or does not have the expected form, no conversion is performed, the value of nptr is stored in the object pointed to by endptr, provided that endptr is not a null pointer.

strtoul()
'''''''''

Description

Convert to number, unsigned long.

Prototype

::

   unsigned long strtoul(const char  * nptr,
                               char ** endptr,
                               int     base);

Parameters

+-----------+-----------------------------------------------------------------------------------------------+
| Parameter | Description                                                                                   |
+===========+===============================================================================================+
| nptr      | Pointer to string to convert from.                                                            |
+-----------+-----------------------------------------------------------------------------------------------+
| endptr    | If nonnull, a pointer to object that receives the pointer to the first unconverted character. |
+-----------+-----------------------------------------------------------------------------------------------+
| base      | Radix to use for conversion, 2 to 36.                                                         |
+-----------+-----------------------------------------------------------------------------------------------+

Return value

`strtoul()`_ returns the converted value, if any. If no conversion could be performed, zero is returned. If the correct value is outside the range of representable values, ULONG_MAX is and the value of the macro ERANGE is stored in errno.

Additional information

Converts the initial portion of the string pointed to by nptr to a long int representation.

First, `strtoul()`_ decomposes the input string into three parts: an initial, possibly empty, sequence of white-space characters, as specified by `isspace()`_, a subject sequence resembling an integer represented in some radix determined by the value of base, and a final string of one or more unrecognized characters, including the terminating null character of the input string. `strtoul()`_ then attempts to convert the subject sequence to an integer, and return the result.

When converting, no integer suffix (such as U, L, UL, LL, ULL) is allowed.

If the value of base is zero, the expected form of the subject sequence is an optional plus or minus sign followed by an integer constant.

If the value of base is between 2 and 36 (inclusive), the expected form of the subject sequence is an optional plus or minus sign followed by a sequence of letters and digits representing an integer with the radix specified by base. The letters from a (or A) through z (or Z) represent the values 10 through 35; only letters and digits whose ascribed values are less than that of base are permitted.

If the value of base is 16, the characters “0x” or “0X” may optionally precede the sequence of letters and digits, following the optional sign.

The subject sequence is defined as the longest initial subsequence of the input string, starting with the first non-white-space character, that is of the expected form. The subject sequence contains no characters if the input string is empty or consists entirely of white space, or if the first non-white-space character is other than a sign or a permissible letter or digit.

If the subject sequence has the expected form and the value of base is zero, the sequence of characters starting with the first digit is interpreted as an integer constant. If the subject sequence has the expected form and the value of base is between 2 and 36, it is used as the base for conversion.

If the subject sequence begins with a minus sign, the value resulting from the conversion is negated.

A pointer to the final string is stored in the object pointed to by endptr, provided that endptr is not a null pointer.

If the subject sequence is empty or does not have the expected form, no conversion is performed, the value of nptr is stored in the object pointed to by endptr, provided that endptr is not a null pointer.

strtoull()
''''''''''

Description

Convert to number, unsigned long long.

Prototype

::

   unsigned long long strtoull(const char  * nptr,
                                     char ** endptr,
                                     int     base);

Parameters

+-----------+-----------------------------------------------------------------------------------------------+
| Parameter | Description                                                                                   |
+===========+===============================================================================================+
| nptr      | Pointer to string to convert from.                                                            |
+-----------+-----------------------------------------------------------------------------------------------+
| endptr    | If nonnull, a pointer to object that receives the pointer to the first unconverted character. |
+-----------+-----------------------------------------------------------------------------------------------+
| base      | Radix to use for conversion, 2 to 36.                                                         |
+-----------+-----------------------------------------------------------------------------------------------+

Return value

`strtoull()`_ returns the converted value, if any. If no conversion could be performed, zero is returned. If the correct value is outside the range of representable values, ULLONG_MAX is and the value of the macro ERANGE is stored in errno.

Additional information

Converts the initial portion of the string pointed to by nptr to a long int representation.

First, `strtoull()`_ decomposes the input string into three parts: an initial, possibly empty, sequence of white-space characters, as specified by `isspace()`_, a subject sequence resembling an integer represented in some radix determined by the value of base, and a final string of one or more unrecognized characters, including the terminating null character of the input string. `strtoull()`_ then attempts to convert the subject sequence to an integer, and return the result.

When converting, no integer suffix (such as U, L, UL, LL, ULL) is allowed.

If the value of base is zero, the expected form of the subject sequence is an optional plus or minus sign followed by an integer constant.

If the value of base is between 2 and 36 (inclusive), the expected form of the subject sequence is an optional plus or minus sign followed by a sequence of letters and digits representing an integer with the radix specified by base. The letters from a (or A) through z (or Z) represent the values 10 through 35; only letters and digits whose ascribed values are less than that of base are permitted.

If the value of base is 16, the characters “0x” or “0X” may optionally precede the sequence of letters and digits, following the optional sign.

The subject sequence is defined as the longest initial subsequence of the input string, starting with the first non-white-space character, that is of the expected form. The subject sequence contains no characters if the input string is empty or consists entirely of white space, or if the first non-white-space character is other than a sign or a permissible letter or digit.

If the subject sequence has the expected form and the value of base is zero, the sequence of characters starting with the first digit is interpreted as an integer constant. If the subject sequence has the expected form and the value of base is between 2 and 36, it is used as the base for conversion.

If the subject sequence begins with a minus sign, the value resulting from the conversion is negated.

A pointer to the final string is stored in the object pointed to by endptr, provided that endptr is not a null pointer.

If the subject sequence is empty or does not have the expected form, no conversion is performed, the value of nptr is stored in the object pointed to by endptr, provided that endptr is not a null pointer.

strtof()
''''''''

Description

Convert to number, float.

Prototype

::

   float strtof(const char  * nptr,
                      char ** endptr);

Parameters

+-----------+-----------------------------------------------------------------------------------------------+
| Parameter | Description                                                                                   |
+===========+===============================================================================================+
| nptr      | Pointer to string to convert from.                                                            |
+-----------+-----------------------------------------------------------------------------------------------+
| endptr    | If nonnull, a pointer to object that receives the pointer to the first unconverted character. |
+-----------+-----------------------------------------------------------------------------------------------+

Return value

Returns the converted value, if any. If no conversion could be performed, zero is returned. If the correct value is outside the range of representable values, HUGE_VALF is returned according to the sign of the value, if any, and the value of the macro ERANGE is stored in errno.

Additional information

Converts the initial portion of the string pointed to by nptr to float representation.

First, `strtof()`_ decomposes the input string into three parts: an initial, possibly empty, sequence of white-space characters, as specified by `isspace()`_, a subject sequence resembling a floating-point constant, and a final string of one or more unrecognized characters, including the terminating null character of the input string. `strtof()`_ then attempts to convert the subject sequence to a floating-point number, and return the result.

The subject sequence is defined as the longest initial subsequence of the input string, starting with the first non-white-space character, that is of the expected form. The subject sequence contains no characters if the input string is empty or consists entirely of white space, or if the first non-white-space character is other than a sign or a permissible letter or digit.

The expected form of the subject sequence is an optional plus or minus sign followed by a nonempty sequence of decimal digits optionally containing a decimal-point character, then an optional exponent part.

If the subject sequence begins with a minus sign, the value resulting from the conversion is negated. A pointer to the final string is stored in the object pointed to by endptr, provided that endptr is not a null pointer.

If the subject sequence is empty or does not have the expected form, no conversion is performed, the value of nptr is stored in the object pointed to by endptr, provided that endptr is not a null pointer.

See also

`strtod()`_

strtod()
''''''''

Description

Convert to number, double.

Prototype

::

   double strtod(const char  * nptr,
                       char ** endptr);

Parameters

+-----------+-----------------------------------------------------------------------------------------------+
| Parameter | Description                                                                                   |
+===========+===============================================================================================+
| nptr      | Pointer to string to convert from.                                                            |
+-----------+-----------------------------------------------------------------------------------------------+
| endptr    | If nonnull, a pointer to object that receives the pointer to the first unconverted character. |
+-----------+-----------------------------------------------------------------------------------------------+

Return value

Returns the converted value, if any. If no conversion could be performed, zero is returned. If the correct value is outside the range of representable values, HUGE_VAL is returned according to the sign of the value, if any, and the value of the macro ERANGE is stored in errno.

Additional information

Converts the initial portion of the string pointed to by nptr to double representation.

First, `strtod()`_ decomposes the input string into three parts: an initial, possibly empty, sequence of white-space characters, as specified by `isspace()`_, a subject sequence resembling a floating-point constant, and a final string of one or more unrecognized characters, including the terminating null character of the input string. `strtod()`_ then attempts to convert the subject sequence to a floating-point number, and return the result.

The subject sequence is defined as the longest initial subsequence of the input string, starting with the first non-white-space character, that is of the expected form. The subject sequence contains no characters if the input string is empty or consists entirely of white space, or if the first non-white-space character is other than a sign or a permissible letter or digit.

The expected form of the subject sequence is an optional plus or minus sign followed by a nonempty sequence of decimal digits optionally containing a decimal-point character, then an optional exponent part.

If the subject sequence begins with a minus sign, the value resulting from the conversion is negated. A pointer to the final string is stored in the object pointed to by endptr, provided that endptr is not a null pointer.

If the subject sequence is empty or does not have the expected form, no conversion is performed, the value of nptr is stored in the object pointed to by endptr, provided that endptr is not a null pointer.

See also

`strtof()`_

strtold()
'''''''''

Description

Convert to number, long double.

Prototype

::

   long double strtold(const char  * nptr,
                             char ** endptr);

Parameters

+-----------+-----------------------------------------------------------------------------------------------+
| Parameter | Description                                                                                   |
+===========+===============================================================================================+
| nptr      | Pointer to string to convert from.                                                            |
+-----------+-----------------------------------------------------------------------------------------------+
| endptr    | If nonnull, a pointer to object that receives the pointer to the first unconverted character. |
+-----------+-----------------------------------------------------------------------------------------------+

Return value

Returns the converted value, if any. If no conversion could be performed, zero is returned. If the correct value is outside the range of representable values, HUGE_VAL is returned according to the sign of the value, if any, and the value of the macro ERANGE is stored in errno.

Additional information

Converts the initial portion of the string pointed to by nptr to long double representation.

First, `strtold()`_ decomposes the input string into three parts: an initial, possibly empty, sequence of white-space characters, as specified by `isspace()`_, a subject sequence resembling a floating-point constant, and a final string of one or more unrecognized characters, including the terminating null character of the input string. `strtod()`_ then attempts to convert the subject sequence to a floating-point number, and return the result.

The subject sequence is defined as the longest initial subsequence of the input string, starting with the first non-white-space character, that is of the expected form. The subject sequence contains no characters if the input string is empty or consists entirely of white space, or if the first non-white-space character is other than a sign or a permissible letter or digit.

The expected form of the subject sequence is an optional plus or minus sign followed by a nonempty sequence of decimal digits optionally containing a decimal-point character, then an optional exponent part.

If the subject sequence begins with a minus sign, the value resulting from the conversion is negated. A pointer to the final string is stored in the object pointed to by endptr, provided that endptr is not a null pointer.

If the subject sequence is empty or does not have the expected form, no conversion is performed, the value of nptr is stored in the object pointed to by endptr, provided that endptr is not a null pointer.

See also

`strtod()`_

Multi-byte/wide character functions
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

+------------------+----------------------------------------------------------------------------------------+
| Function         | Description                                                                            |
+==================+========================================================================================+
| `btowc()`_       | Convert single-byte character to wide character.                                       |
+------------------+----------------------------------------------------------------------------------------+
| `btowc_l()`_     | Convert single-byte character to wide character, per locale, (POSIX.1).                |
+------------------+----------------------------------------------------------------------------------------+
| `mblen()`_       | Count number of bytes in multi-byte character.                                         |
+------------------+----------------------------------------------------------------------------------------+
| `mblen_l()`_     | Count number of bytes in multi-byte character, per locale (POSIX.1).                   |
+------------------+----------------------------------------------------------------------------------------+
| `mbtowc()`_      | Convert multi-byte character to wide character.                                        |
+------------------+----------------------------------------------------------------------------------------+
| `mbtowc_l()`_    | Convert multi-byte character to wide character, per locale (POSIX.1).                  |
+------------------+----------------------------------------------------------------------------------------+
| `mbstowcs()`_    | Convert multi-byte string to wide string.                                              |
+------------------+----------------------------------------------------------------------------------------+
| `mbstowcs_l()`_  | Convert multi-byte string to wide string, per locale (POSIX.1).                        |
+------------------+----------------------------------------------------------------------------------------+
| `mbsrtowcs()`_   | Convert multi-byte string to wide character string, restartable.                       |
+------------------+----------------------------------------------------------------------------------------+
| `mbsrtowcs_l()`_ | Convert multi-byte string to wide character string, restartable, per locale (POSIX.1). |
+------------------+----------------------------------------------------------------------------------------+
| `wctomb()`_      | Convert wide character to multi-byte character.                                        |
+------------------+----------------------------------------------------------------------------------------+
| `wctomb_l()`_    | Convert wide character to multi-byte character, per locale (POSIX.1).                  |
+------------------+----------------------------------------------------------------------------------------+
| `wcstombs()`_    | Convert wide string to multi-byte string.                                              |
+------------------+----------------------------------------------------------------------------------------+
| `wcstombs_l()`_  | Convert wide string to multi-byte string.                                              |
+------------------+----------------------------------------------------------------------------------------+

btowc()
'''''''

Description

Convert single-byte character to wide character.

Prototype

::

   wint_t btowc(int c);

Parameters

+------------------------+---------------------------------------------+
| Parameter              | Description                                 |
+========================+=============================================+
| c                      | Character to convert.                       |
+------------------------+---------------------------------------------+

Return value

Returns WEOF if c has the value EOF or if c, converted to an unsigned char and in the current locale, does not constitute a valid single-byte character in the initial shift state.

Additional information

Determines whether c constitutes a valid single-byte character in the current locale. If c is a valid single-byte character, `btowc()`_ returns the wide character representation of that character.

btowc_l()
'''''''''

Description

Convert single-byte character to wide character, per locale, (POSIX.1).

Prototype

::

   wint_t btowc_l(int c,
                      locale_t loc);

Parameters

+--------------------+-------------------------------------------------+
| Parameter          | Description                                     |
+====================+=================================================+
| c                  | Character to convert.                           |
+--------------------+-------------------------------------------------+
| loc                | Locale used for conversion.                     |
+--------------------+-------------------------------------------------+

Return value

Returns WEOF if c has the value EOF or if c, converted to an unsigned char and in the locale loc, does not constitute a valid single-byte character in the initial shift state.

Additional information

Determines whether c constitutes a valid single-byte character in the locale loc. If c is a valid single-byte character, `btowc_l()`_ returns the wide character representation of that character.

Notes

Conforms to POSIX.1-2008.

mblen()
'''''''

Description

Count number of bytes in multi-byte character.

Prototype

::

   int mblen(const char   * s,
                   size_t   n);

Parameters

+----------------+-----------------------------------------------------+
| Parameter      | Description                                         |
+================+=====================================================+
| s              | Pointer to multi-byte character.                    |
+----------------+-----------------------------------------------------+
| n              | Maximum number of bytes to examine.                 |
+----------------+-----------------------------------------------------+

Return value

If s is a null pointer, returns a nonzero or zero value, if multi-byte character encodings, respectively, do or do not have state-dependent encodings.

If s is not a null pointer, either returns 0 (if s points to the null character), or returns the number of bytes that are contained in the multi-byte character (if the next n or fewer bytes form a valid multi-byte character), or returns -1 (if they do not form a valid multi-byte character).

Additional information

Determines the number of bytes contained in the multi-byte character pointed to by s in the current locale.

Except that the conversion state of the `mbtowc()`_ function is not affected, it is equivalent to

mbtowc(NULL, s, n);

See also

`mblen_l()`_, `mbtowc()`_

mblen_l()
'''''''''

Description

Count number of bytes in multi-byte character, per locale (POSIX.1).

Prototype

::

   int mblen_l(const char   * s,
                     size_t   n,
                              locale_t loc);

Parameters

+----------------+-----------------------------------------------------+
| Parameter      | Description                                         |
+================+=====================================================+
| s              | Pointer to multi-byte character.                    |
+----------------+-----------------------------------------------------+
| n              | Maximum number of bytes to examine.                 |
+----------------+-----------------------------------------------------+
| loc            | Locale to use for conversion.                       |
+----------------+-----------------------------------------------------+

Return value

If s is a null pointer, returns a nonzero or zero value, if multi-byte character encodings, respectively, do or do not have state-dependent encodings in locale loc.

If s is not a null pointer, either returns 0 (if s points to the null character), or returns the number of bytes that are contained in the multi-byte character (if the next n or fewer bytes form a valid multi-byte character), or returns -1 (if they do not form a valid multi-byte character).

Additional information

Determines the number of bytes contained in the multi-byte character pointed to by s in the locale loc.

Except that the conversion state of the `mbtowc()`_ function is not affected, it is equivalent to

mbtowc_l(NULL, s, n, loc);

Notes

Conforms to POSIX.1-2008.

See also

`mblen()`_, `mbtowc()`_

mbtowc()
''''''''

Description

Convert multi-byte character to wide character.

Prototype

::

   int mbtowc(      wchar_t * pwc,
              const char    * s,
                    size_t    n);

Parameters

+-------------+--------------------------------------------------------+
| Parameter   | Description                                            |
+=============+========================================================+
| pwc         | Pointer to object that receives the wide character.    |
+-------------+--------------------------------------------------------+
| s           | Pointer to multi-byte character string.                |
+-------------+--------------------------------------------------------+
| n           | Maximum number of bytes that will be examined.         |
+-------------+--------------------------------------------------------+

Return value

If s is a null pointer, `mbtowc()`_ returns a nonzero value if multi-byte character encodings are state-dependent in the current locale, and zero otherwise.

If s is not null and the object that s points to is a wide character null, `mbtowc()`_ returns 0.

If s is not null and the object that s points to forms a valid multi-byte character, `mbtowc()`_ returns the length in bytes of the multi-byte character.

If the object that `mbtowc()`_ points to does not form a valid multi-byte character within the first n characters, it returns -1.

Additional information

Converts a single multi-byte character to a wide character in the current locale. The wide character, if the multi-byte character string is converted correctly, is stored into the object pointed to by pwc.

See also

`mbtowc_l()`_

mbtowc_l()
''''''''''

Description

Convert multi-byte character to wide character, per locale (POSIX.1).

Prototype

::

   int mbtowc_l(      wchar_t * pwc,
                const char    * s,
                      size_t    n,
                                locale_t loc);

Parameters

+-------------+--------------------------------------------------------+
| Parameter   | Description                                            |
+=============+========================================================+
| pwc         | Pointer to object that receives the wide character.    |
+-------------+--------------------------------------------------------+
| s           | Pointer to multi-byte character string.                |
+-------------+--------------------------------------------------------+
| n           | Maximum number of bytes that will be examined.         |
+-------------+--------------------------------------------------------+
| loc         | Locale used to convert the multi-byte character.       |
+-------------+--------------------------------------------------------+

Return value

If s is a null pointer, `mbtowc_l()`_ returns a nonzero value if multi-byte character encodings are state-dependent in locale loc, and zero otherwise.

If s is not null and the object that s points to is a wide null character, `mbtowc_l()`_ returns 0.

If s is not null and the object that s points to forms a valid multi-byte character, `mbtowc_l()`_ returns the length in bytes of the multi-byte character.

If the object that `mbtowc_l()`_ points to does not form a valid multi-byte character within the first n characters, it returns -1.

Additional information

Converts a single multi-byte character to a wide character in the locale loc. The wide character, if the multi-byte character string is converted correctly, is stored into the object pointed to by pwc.

Notes

Conforms to POSIX.1-2008.

See also

`mbtowc()`_

mbstowcs()
''''''''''

Description

Convert multi-byte string to wide string.

Prototype

::

   size_t mbstowcs(      wchar_t * pwcs,
                   const char    * s,
                         size_t    n);

Parameters

+-----------+-----------------------------------------------------------+
| Parameter | Description                                               |
+===========+===========================================================+
| pwcs      | Pointer to array that receives the wide character string. |
+-----------+-----------------------------------------------------------+
| s         | Pointer to array that contains the multi-byte string.     |
+-----------+-----------------------------------------------------------+
| n         | Maximum number of wide characters to write into pwcs.     |
+-----------+-----------------------------------------------------------+

Return value

Returns -1 if an invalid multi-byte character is encountered, otherwise returns the number of array elements modified (if any), not including a terminating null wide character.

Additional information

Converts a sequence of multi-byte characters, in the current locale, that begins in the initial shift state from the array pointed to by s into a sequence of corresponding wide characters and stores not more than n wide characters into the array pointed to by pwcs.

No multi-byte characters that follow a null character (which is converted into a null wide character) will be examined or converted. Each multi-byte character is converted as if by a call to the `mbtowc()`_ function, except that the conversion state of the `mbtowc()`_ function is not affected.

No more than n elements will be modified in the array pointed to by pwcs. If copying takes place between objects that overlap, the behavior is undefined.

mbstowcs_l()
''''''''''''

Description

Convert multi-byte string to wide string, per locale (POSIX.1).

Prototype

::

   size_t mbstowcs_l(      wchar_t * pwcs,
                     const char    * s,
                           size_t    n,
                                     locale_t loc);

Parameters

+-----------+-----------------------------------------------------------+
| Parameter | Description                                               |
+===========+===========================================================+
| pwcs      | Pointer to array that receives the wide character string. |
+-----------+-----------------------------------------------------------+
| s         | Pointer to array that contains the multi-byte string.     |
+-----------+-----------------------------------------------------------+
| n         | Maximum number of wide characters to write into pwcs.     |
+-----------+-----------------------------------------------------------+
| loc       | Locale to use for conversion.                             |
+-----------+-----------------------------------------------------------+

Return value

Returns -1 if an invalid multi-byte character is encountered, otherwise returns the number of array elements modified (if any), not including a terminating null wide character.

Additional information

Converts a sequence of multi-byte characters, in the locale loc, that begins in the initial shift state from the array pointed to by s into a sequence of corresponding wide characters and stores not more than n wide characters into the array pointed to by pwcs.

No multi-byte characters that follow a null character (which is converted into a null wide character) will be examined or converted. Each multi-byte character is converted as if by a call to the `mbtowc()`_ function, except that the conversion state of the `mbtowc()`_ function is not affected.

No more than n elements will be modified in the array pointed to by pwcs. If copying takes place between objects that overlap, the behavior is undefined.

Notes

Conforms to POSIX.1-2017.

mbsrtowcs()
'''''''''''

Description

Convert multi-byte string to wide character string, restartable.

Prototype

::

   size_t mbsrtowcs(      wchar_t    * dst,
                    const char      ** src,
                          size_t       len,
                          mbstate_t  * ps);

Parameters

+-----------+----------------------------------------------------------------+
| Parameter | Description                                                    |
+===========+================================================================+
| dst       | Pointer to object that receives the converted wide characters. |
+-----------+----------------------------------------------------------------+
| src       | Pointer to pointer to multi-byte character string.             |
+-----------+----------------------------------------------------------------+
| len       | Maximum number of wide characters that will be written to dst. |
+-----------+----------------------------------------------------------------+
| ps        | Pointer to multi-byte conversion state.                        |
+-----------+----------------------------------------------------------------+

Return value

The number of wide characters written to dst (not including the eventual terminating null character).

Additional information

Converts a sequence of multi-byte characters, in the current locale, that begins in the conversion state described by the object pointed to by ps, from the array indirectly pointed to by src into a sequence of corresponding wide characters.

If dst is not a null pointer, the converted characters are stored into the array pointed to by dst. Conversion continues up to and including a terminating null character, which is also stored.

Conversion stops earlier in two cases: when a sequence of bytes is encountered that does not form a valid multi-byte character, or (if dst is not a null pointer) when len wide characters have been stored into the array pointed to by dst. Each conversion takes place as if by a call to the `mbrtowc()`_ function.

If dst is not a null pointer, the pointer object pointed to by src is assigned either a null pointer (if conversion stopped due to reaching a terminating null character) or the address just past the last multi-byte character converted (if any). If conversion stopped due to reaching a terminating null character and if dst is not a null pointer, the resulting state described is the initial conversion state.

See also

`mbsrtowcs_l()`_, `mbrtowc()`_

mbsrtowcs_l()
'''''''''''''

Description

Convert multi-byte string to wide character string, restartable, per locale (POSIX.1).

Prototype

::

   size_t mbsrtowcs_l(      wchar_t    * dst,
                      const char      ** src,
                            size_t       len,
                            mbstate_t  * ps,
                                         locale_t loc);

Parameters

+-----------+----------------------------------------------------------------+
| Parameter | Description                                                    |
+===========+================================================================+
| dst       | Pointer to object that receives the converted wide characters. |
+-----------+----------------------------------------------------------------+
| src       | Pointer to pointer to multi-byte character string.             |
+-----------+----------------------------------------------------------------+
| len       | Maximum number of wide characters that will be written to dst. |
+-----------+----------------------------------------------------------------+
| ps        | Pointer to multi-byte conversion state.                        |
+-----------+----------------------------------------------------------------+
| loc       | Locale used for conversion.                                    |
+-----------+----------------------------------------------------------------+

Return value

The number of wide characters written to dst (not including the eventual terminating null character).

Additional information

Converts a sequence of multi-byte characters, in the locale loc, that begins in the conversion state described by the object pointed to by ps, from the array indirectly pointed to by src into a sequence of corresponding wide characters.

If dst is not a null pointer, the converted characters are stored into the array pointed to by dst. Conversion continues up to and including a terminating null character, which is also stored.

Conversion stops earlier in two cases: when a sequence of bytes is encountered that does not form a valid multi-byte character, or (if dst is not a null pointer) when len wide characters have been stored into the array pointed to by dst. Each conversion takes place as if by a call to the `mbrtowc()`_ function.

If dst is not a null pointer, the pointer object pointed to by src is assigned either a null pointer (if conversion stopped due to reaching a terminating null character) or the address just past the last multi-byte character converted (if any). If conversion stopped due to reaching a terminating null character and if dst is not a null pointer, the resulting state described is the initial conversion state.

Notes

Conforms to POSIX.1-2008.

See also

`mbsrtowcs()`_, `mbrtowc()`_

wctomb()
''''''''

Description

Convert wide character to multi-byte character.

Prototype

::

   int wctomb(char * s,
                     wchar_t wc);

Parameters

+------------+----------------------------------------------------------+
| Parameter  | Description                                              |
+============+==========================================================+
| s          | Pointer to array that receives the multi-byte character. |
+------------+----------------------------------------------------------+
| wc         | Wide character to convert.                               |
+------------+----------------------------------------------------------+

Return value

Returns the number of bytes stored in the array object. When wc is not a valid wide character, an encoding error occurs: `wctomb()`_ stores the value of the macro EILSEQ in errno and returns (`size_t`_)(-1); the conversion state is unspecified.

Additional information

If s is a null pointer, `wctomb()`_ is equivalent to the call wcrtomb(buf, 0, ps) where buf is an internal buffer.

If s is not a null pointer, `wctomb()`_ determines the number of bytes needed to represent the multi-byte character that corresponds to the wide character given by wc in the current locale, and stores the multi-byte character representation in the array whose first element is pointed to by s. At most MB_CUR_MAX bytes are stored. If wc is a null wide character, a null byte is stored; the resulting state described is the initial conversion state.

wctomb_l()
''''''''''

Description

Convert wide character to multi-byte character, per locale (POSIX.1).

Prototype

::

   int wctomb_l(char * s,
                       wchar_t wc,
                       locale_t loc);

Parameters

+------------+----------------------------------------------------------+
| Parameter  | Description                                              |
+============+==========================================================+
| s          | Pointer to array that receives the multi-byte character. |
+------------+----------------------------------------------------------+
| wc         | Wide character to convert.                               |
+------------+----------------------------------------------------------+
| loc        | Locale used for conversion.                              |
+------------+----------------------------------------------------------+

Return value

Returns the number of bytes stored in the array object. When wc is not a valid wide character, an encoding error occurs: `wctomb_l()`_ stores the value of the macro EILSEQ in errno and returns (`size_t`_)(-1); the conversion state is unspecified.

Additional information

If s is a null pointer, `wctomb_l()`_ is equivalent to the call wcrtomb_l(buf, 0, ps, loc) where buf is an internal buffer.

If s is not a null pointer, `wctomb_l()`_ determines the number of bytes needed to represent the multi-byte character that corresponds to the wide character given by wc in the locale loc, and stores the multi-byte character representation in the array whose first element is pointed to by s. At most MB_CUR_MAX bytes are stored. If wc is a null wide character, a null byte is stored; the resulting state described is the initial conversion state.

Notes

Conforms to POSIX.1-2008.

wcstombs()
''''''''''

Description

Convert wide string to multi-byte string.

Prototype

::

   size_t wcstombs(      char    * s,
                   const wchar_t * pwcs,
                         size_t    n);

Parameters

+------------+---------------------------------------------------------+
| Parameter  | Description                                             |
+============+=========================================================+
| s          | Pointer to array that receives the multi-byte string.   |
+------------+---------------------------------------------------------+
| pwcs       | Pointer to wide character string to convert.            |
+------------+---------------------------------------------------------+
| n          | Maximum number of bytes to write into s.                |
+------------+---------------------------------------------------------+

Return value

If a wide character is encountered that does not correspond to a valid multibyte character in the current locale, returns (`size_t`_)(-1). Otherwise, returns the number of bytes written, not including a terminating null character (if any).

Additional information

Converts a sequence of wide characters in the current locale from the array pointed to by pwcs into a sequence of corresponding multi-byte characters that begins in the initial shift state, and stores these multi-byte characters into the array pointed to by s, stopping if a multi-byte character would exceed the limit of n total bytes or if a null character is stored. Each wide character is converted as if by a call to `wctomb()`_, except that the conversion state of `wctomb()`_ is not affected.

wcstombs_l()
''''''''''''

Description

Convert wide string to multi-byte string.

Prototype

::

   size_t wcstombs_l(      char    * s,
                     const wchar_t * pwcs,
                           size_t    n,
                                     locale_t loc);

Parameters

+------------+---------------------------------------------------------+
| Parameter  | Description                                             |
+============+=========================================================+
| s          | Pointer to array that receives the multi-byte string.   |
+------------+---------------------------------------------------------+
| pwcs       | Pointer to wide character string to convert.            |
+------------+---------------------------------------------------------+
| n          | Maximum number of bytes to write into s.                |
+------------+---------------------------------------------------------+
| loc        | Locale used for conversion.                             |
+------------+---------------------------------------------------------+

Return value

If a wide character is encountered that does not correspond to a valid multibyte character in the locale loc, returns (`size_t`_)(-1). Otherwise, returns the number of bytes written, not including a terminating null character (if any).

Additional information

Converts a sequence of wide characters in the locale loc from the array pointed to by pwcs into a sequence of corresponding multi-byte characters that begins in the initial shift state, and stores these multi-byte characters into the array pointed to by s, stopping if a multi-byte character would exceed the limit of n total bytes or if a null character is stored. Each wide character is converted as if by a call to `wctomb()`_, except that the conversion state of `wctomb()`_ is not affected.

<string.h>
~~~~~~~~~~

The header file <string.h> defines functions that operate on arrays that are interpreted as null-terminated strings.

Various methods are used for determining the lengths of the arrays, but in all cases a char \* or void \* argument points to the initial (lowest addressed) character of the array. If an array is accessed beyond the end of an object, the behavior is undefined.

Where an argument declared as `size_t`_ n specifies the length of an array for a function, n can have the value zero on a call to that function. Unless explicitly stated otherwise in the description of a particular function, pointer arguments must have valid values on a call with a zero size. On such a call, a function that locates a character finds no occurrence, a function that compares two character sequences returns zero, and a function that copies characters copies zero characters.

Copying functions
^^^^^^^^^^^^^^^^^

+--------------+-----------------------------------------------------------------+
| Function     | Description                                                     |
+==============+=================================================================+
| `memset()`_  | Set memory to character.                                        |
+--------------+-----------------------------------------------------------------+
| `memcpy()`_  | Copy memory.                                                    |
+--------------+-----------------------------------------------------------------+
| `memccpy()`_ | Copy memory, specify terminator (POSIX.1).                      |
+--------------+-----------------------------------------------------------------+
| `mempcpy()`_ | Copy memory (GNU).                                              |
+--------------+-----------------------------------------------------------------+
| `memmove()`_ | Copy memory, tolerate overlaps.                                 |
+--------------+-----------------------------------------------------------------+
| `strcpy()`_  | Copy string.                                                    |
+--------------+-----------------------------------------------------------------+
| `strncpy()`_ | Copy string, limit length.                                      |
+--------------+-----------------------------------------------------------------+
| `strlcpy()`_ | Copy string, limit length, always zero terminate (BSD).         |
+--------------+-----------------------------------------------------------------+
| `stpcpy()`_  | Copy string, return end.                                        |
+--------------+-----------------------------------------------------------------+
| `stpncpy()`_ | Copy string, limit length, return end.                          |
+--------------+-----------------------------------------------------------------+
| `strcat()`_  | Concatenate strings.                                            |
+--------------+-----------------------------------------------------------------+
| `strncat()`_ | Concatenate strings, limit length.                              |
+--------------+-----------------------------------------------------------------+
| `strlcat()`_ | Concatenate strings, limit length, always zero terminate (BSD). |
+--------------+-----------------------------------------------------------------+
| `strdup()`_  | Duplicate string (POSIX.1).                                     |
+--------------+-----------------------------------------------------------------+
| `strndup()`_ | Duplicate string, limit length (POSIX.1).                       |
+--------------+-----------------------------------------------------------------+

memset()
''''''''

Description

Set memory to character.

Prototype

::

   void *memset(void   * s,
                int      c,
                size_t   n);

Parameters

+---------------+------------------------------------------------------+
| Parameter     | Description                                          |
+===============+======================================================+
| s             | Pointer to destination object.                       |
+---------------+------------------------------------------------------+
| c             | Character to copy.                                   |
+---------------+------------------------------------------------------+
| n             | Length of destination object in characters.          |
+---------------+------------------------------------------------------+

Return value

Returns s.

Additional information

Copies the value of c (converted to an unsigned char) into each of the first n characters of the object pointed to by s.

memcpy()
''''''''

Description

Copy memory.

Prototype

::

   void *memcpy(      void   * s1,
                const void   * s2,
                      size_t   n);

Parameters

+-------------------+--------------------------------------------------+
| Parameter         | Description                                      |
+===================+==================================================+
| s1                | Pointer to destination object.                   |
+-------------------+--------------------------------------------------+
| s2                | Pointer to source object.                        |
+-------------------+--------------------------------------------------+
| n                 | Number of characters to copy.                    |
+-------------------+--------------------------------------------------+

Return value

Returns a pointer to the destination object.

Additional information

Copies n characters from the object pointed to by s2 into the object pointed to by s1. The behavior of `memcpy()`_ is undefined if copying takes place between objects that overlap.

memccpy()
'''''''''

Description

Copy memory, specify terminator (POSIX.1).

Prototype

::

   void *memccpy(      void   * s1,
                 const void   * s2,
                       int      c,
                       size_t   n);

Parameters

+---------------+------------------------------------------------------+
| Parameter     | Description                                          |
+===============+======================================================+
| s1            | Pointer to destination object.                       |
+---------------+------------------------------------------------------+
| s2            | Pointer to source object.                            |
+---------------+------------------------------------------------------+
| c             | Character that terminates copy.                      |
+---------------+------------------------------------------------------+
| n             | Maximum number of characters to copy.                |
+---------------+------------------------------------------------------+

Return value

Returns a pointer to the character immediately following c in s1, or NULL if c was not found in the first n characters of s2.

Additional information

Copies at most n characters from the object pointed to by s2 into the object pointed to by s1. The copying stops as soon as n characters are copied or the character c is copied into the destination object pointed to by s1.

The behavior of `memccpy()`_ is undefined if copying takes place between objects that overlap.

Notes

Conforms to POSIX.1-2008.

mempcpy()
'''''''''

Description

Copy memory (GNU).

Prototype

::

   void *mempcpy(      void   * s1,
                 const void   * s2,
                       size_t   n);

Parameters

+-------------------+--------------------------------------------------+
| Parameter         | Description                                      |
+===================+==================================================+
| s1                | Pointer to destination object.                   |
+-------------------+--------------------------------------------------+
| s2                | Pointer to source object.                        |
+-------------------+--------------------------------------------------+
| n                 | Number of characters to copy.                    |
+-------------------+--------------------------------------------------+

Return value

Returns a pointer to the character immediately following the final character written into s1.

Additional information

Copies n characters from the object pointed to by s2 into the object pointed to by s1. The behavior of `mempcpy()`_ is undefined if copying takes place between objects that overlap.

Notes

This is an extension found in GNU libc.

memmove()
'''''''''

Description

Copy memory, tolerate overlaps.

Prototype

::

   void *memmove(      void   * s1,
                 const void   * s2,
                       size_t   n);

Parameters

+-------------------+--------------------------------------------------+
| Parameter         | Description                                      |
+===================+==================================================+
| s1                | Pointer to destination object.                   |
+-------------------+--------------------------------------------------+
| s2                | Pointer to source object.                        |
+-------------------+--------------------------------------------------+
| n                 | Number of characters to copy.                    |
+-------------------+--------------------------------------------------+

Return value

Returns the value of s1.

Additional information

Copies n characters from the object pointed to by s2 into the object pointed to by s1 ensuring that if s1 and s2 overlap, the copy works correctly. Copying takes place as if the n characters from the object pointed to by s2 are first copied into a temporary array of n characters that does not overlap the objects pointed to by s1 and s2, and then the n characters from the temporary array are copied into the object pointed to by s1.

strcpy()
''''''''

Description

Copy string.

Prototype

::

   char *strcpy(      char * s1,
                const char * s2);

Parameters

+---------------------------+------------------------------------------+
| Parameter                 | Description                              |
+===========================+==========================================+
| s1                        | String to copy to.                       |
+---------------------------+------------------------------------------+
| s2                        | String to copy.                          |
+---------------------------+------------------------------------------+

Return value

Returns the value of s1.

Additional information

Copies the string pointed to by s2 (including the terminating null character) into the array pointed to by s1. The behavior of `strcpy()`_ is undefined if copying takes place between objects that overlap.

strncpy()
'''''''''

Description

Copy string, limit length.

Prototype

::

   char *strncpy(      char   * s1,
                 const char   * s2,
                       size_t   n);

Parameters

+---------------+------------------------------------------------------+
| Parameter     | Description                                          |
+===============+======================================================+
| s1            | String to copy to.                                   |
+---------------+------------------------------------------------------+
| s2            | String to copy.                                      |
+---------------+------------------------------------------------------+
| n             | Maximum number of characters to copy.                |
+---------------+------------------------------------------------------+

Return value

Returns the value of s1.

Additional information

Copies not more than n characters from the array pointed to by s2 to the array pointed to by s1. Characters that follow a null character in s2 are not copied. The behavior of `strncpy()`_ is undefined if copying takes place between objects that overlap. If the array pointed to by s2 is a string that is shorter than n characters, null characters are appended to the copy in the array pointed to by s1, until n characters in all have been written.

Notes

No null character is implicitly appended to the end of s1, so s1 will only be terminated by a null character if the length of the string pointed to by s2 is less than n.

strlcpy()
'''''''''

Description

Copy string, limit length, always zero terminate (BSD).

Prototype

::

   size_t strlcpy(      char   * s1,
                  const char   * s2,
                        size_t   n);

Parameters

+-----------+------------------------------------------------------------------+
| Parameter | Description                                                      |
+===========+==================================================================+
| s1        | Pointer to string to copy to.                                    |
+-----------+------------------------------------------------------------------+
| s2        | Pointer to string to copy.                                       |
+-----------+------------------------------------------------------------------+
| n         | Maximum number of characters, including terminating null, in s1. |
+-----------+------------------------------------------------------------------+

Return value

Returns the number of characters it tried to copy, which is the length of the string s2 or n, whichever is smaller.

Additional information

Copies up to n-1 characters from the string pointed to by s2 into the array pointed to by s1 and always terminates the result with a null character.

The behavior of `strlcpy()`_ is undefined if copying takes place between objects that overlap.

Notes

Commonly found in BSD libraries and contrasts with `strncpy()`_ in that the resulting string is always terminated with a null character.

stpcpy()
''''''''

Description

Copy string, return end.

Prototype

::

   char *stpcpy(      char * s1,
                const char * s2);

Parameters

+---------------------------+------------------------------------------+
| Parameter                 | Description                              |
+===========================+==========================================+
| s1                        | String to copy to.                       |
+---------------------------+------------------------------------------+
| s2                        | String to copy.                          |
+---------------------------+------------------------------------------+

Return value

A pointer to the end of the string s1, i.e. the terminating null byte of the string s1, after s2 is copied to it.

Additional information

Copies the string pointed to by s2 (including the terminating null character) into the array pointed to by s1. The behavior of `stpcpy()`_ is undefined if copying takes place between objects that overlap.

stpncpy()
'''''''''

Description

Copy string, limit length, return end.

Prototype

::

   char *stpncpy(      char   * s1,
                 const char   * s2,
                       size_t   n);

Parameters

+---------------+------------------------------------------------------+
| Parameter     | Description                                          |
+===============+======================================================+
| s1            | String to copy to.                                   |
+---------------+------------------------------------------------------+
| s2            | String to copy.                                      |
+---------------+------------------------------------------------------+
| n             | Maximum number of characters to copy.                |
+---------------+------------------------------------------------------+

Return value

`stpncpy()`_ returns a pointer to the terminating null byte in s1 after it is copied to, or, if s1 is not null-terminated, s1+n.

Additional information

Copies not more than n characters from the array pointed to by s2 to the array pointed to by s1. Characters that follow a null character in s2 are not copied. The behavior of `strncpy()`_ is undefined if copying takes place between objects that overlap. If the array pointed to by s2 is a string that is shorter than n characters, null characters are appended to the copy in the array pointed to by s1, until n characters in all have been written.

Notes

No null character is implicitly appended to the end of s1, so s1 will only be terminated by a null character if the length of the string pointed to by s2 is less than n.

strcat()
''''''''

Description

Concatenate strings.

Prototype

::

   char *strcat(      char * s1,
                const char * s2);

Parameters

+----------------+-----------------------------------------------------+
| Parameter      | Description                                         |
+================+=====================================================+
| s1             | Zero-terminated string to append to.                |
+----------------+-----------------------------------------------------+
| s2             | Zero-terminated string to append.                   |
+----------------+-----------------------------------------------------+

Return value

Returns the value of s1.

Additional information

Appends a copy of the string pointed to by s2 (including the terminating null character) to the end of the string pointed to by s1. The initial character of s2 overwrites the null character at the end of s1. The behavior of `strcat()`_ is undefined if copying takes place between objects that overlap.

strncat()
'''''''''

Description

Concatenate strings, limit length.

Prototype

::

   char *strncat(      char   * s1,
                 const char   * s2,
                       size_t   n);

Parameters

+----------------+-----------------------------------------------------+
| Parameter      | Description                                         |
+================+=====================================================+
| s1             | String to append to.                                |
+----------------+-----------------------------------------------------+
| s2             | String to append.                                   |
+----------------+-----------------------------------------------------+
| n              | Maximum number of characters in s1.                 |
+----------------+-----------------------------------------------------+

Return value

Returns the value of s1.

Additional information

Appends not more than n characters from the array pointed to by s2 to the end of the string pointed to by s1. A null character in s1 and characters that follow it are not appended. The initial character of s2 overwrites the null character at the end of s1. A terminating null character is always appended to the result.

The behavior of `strncat()`_ is undefined if copying takes place between objects that overlap.

strlcat()
'''''''''

Description

Concatenate strings, limit length, always zero terminate (BSD).

Prototype

::

   size_t strlcat(      char   * s1,
                  const char   * s2,
                        size_t   n);

Parameters

+-----------+------------------------------------------------------------------+
| Parameter | Description                                                      |
+===========+==================================================================+
| s1        | Pointer to string to append to.                                  |
+-----------+------------------------------------------------------------------+
| s2        | Pointer to string to append.                                     |
+-----------+------------------------------------------------------------------+
| n         | Maximum number of characters, including terminating null, in s1. |
+-----------+------------------------------------------------------------------+

Return value

Returns the number of characters it tried to copy, which is the sum of the lengths of the strings s1 and s2 or n, whichever is smaller.

Additional information

Appends no more than n-strlen(s1}-1 characters pointed to by s2 into the array pointed to by s1 and always terminates the result with a null character if n is greater than zero. Both the strings s1 and s2 must be terminated with a null character on entry to `strlcat()`_ and a character position for the terminating null should be included in n.

The behavior of `strlcat()`_ is undefined if copying takes place between objects that overlap.

Notes

Commonly found in BSD libraries.

strdup()
''''''''

Description

Duplicate string (POSIX.1).

Prototype

::

   char *strdup(const char * s1);

Parameters

+-------------------+--------------------------------------------------+
| Parameter         | Description                                      |
+===================+==================================================+
| s1                | Pointer to string to duplicate.                  |
+-------------------+--------------------------------------------------+

Return value

Returns a pointer to the new string or a null pointer if the new string cannot be created. The returned pointer can be passed to `free()`_.

Additional information

Duplicates the string pointed to by s1 by using `malloc()`_ to allocate memory for a copy of s and then copyies s, including the terminating null, to that memory

Notes

Conforms to POSIX.1-2008 and SC22 TR 24731-2.

strndup()
'''''''''

Description

Duplicate string, limit length (POSIX.1).

Prototype

::

   char *strndup(const char   * s,
                       size_t   n);

Parameters

+--------------+-------------------------------------------------------+
| Parameter    | Description                                           |
+==============+=======================================================+
| s            | Pointer to string to duplicate.                       |
+--------------+-------------------------------------------------------+
| n            | Maximum number of characters to duplicate.            |
+--------------+-------------------------------------------------------+

Return value

Returns a pointer to the new string or a null pointer if the new string cannot be created. The returned pointer can be passed to `free()`_.

Additional information

Duplicates at most n characters from the the string pointed to by s by using `malloc()`_ to allocate memory for a copy of s.

If the length of string pointed to by s is greater than n characters, only n characters will be duplicated. If n is greater than the length of the string pointed to by s, all characters in the string are copied into the allocated array including the terminating null character.

Notes

Conforms to POSIX.1-2008 and SC22 TR 24731-2.

Comparison functions
^^^^^^^^^^^^^^^^^^^^

+------------------+-------------------------------------------------------+
| Function         | Description                                           |
+==================+=======================================================+
| `memcmp()`_      | Compare memory.                                       |
+------------------+-------------------------------------------------------+
| `strcmp()`_      | Compare strings.                                      |
+------------------+-------------------------------------------------------+
| `strncmp()`_     | Compare strings, limit length.                        |
+------------------+-------------------------------------------------------+
| `strcasecmp()`_  | Compare strings, ignore case (POSIX.1).               |
+------------------+-------------------------------------------------------+
| `strncasecmp()`_ | Compare strings, ignore case, limit length (POSIX.1). |
+------------------+-------------------------------------------------------+

memcmp()
''''''''

Description

Compare memory.

Prototype

::

   int memcmp(const void   * s1,
              const void   * s2,
                    size_t   n);

Parameters

+-----------------+----------------------------------------------------+
| Parameter       | Description                                        |
+=================+====================================================+
| s1              | Pointer to object #1.                              |
+-----------------+----------------------------------------------------+
| s2              | Pointer to object #2.                              |
+-----------------+----------------------------------------------------+
| n               | Number of characters to compare.                   |
+-----------------+----------------------------------------------------+

Return value

+-----------+----------------------------------------------------------+
| < 0       | s1 is less than s2.                                      |
+-----------+----------------------------------------------------------+
| = 0       | s1 is equal to s2.                                       |
+-----------+----------------------------------------------------------+
| > 0       | s1 is greater than to s2.                                |
+-----------+----------------------------------------------------------+

Additional information

Compares the first n characters of the object pointed to by s1 to the first n characters of the object pointed to by s2. `memcmp()`_ returns an integer greater than, equal to, or less than zero as the object pointed to by s1 is greater than, equal to, or less than the object pointed to by s2.

strcmp()
''''''''

Description

Compare strings.

Prototype

::

   int strcmp(const char * s1,
              const char * s2);

Parameters

+-------------------------+--------------------------------------------+
| Parameter               | Description                                |
+=========================+============================================+
| s1                      | Pointer to string #1.                      |
+-------------------------+--------------------------------------------+
| s2                      | Pointer to string #2.                      |
+-------------------------+--------------------------------------------+

Return value

Returns an integer greater than, equal to, or less than zero, if the null-terminated array pointed to by s1 is greater than, equal to, or less than the null-terminated array pointed to by s2.

strncmp()
'''''''''

Description

Compare strings, limit length.

Prototype

::

   int strncmp(const char   * s1,
               const char   * s2,
                     size_t   n);

Parameters

+--------------+-------------------------------------------------------+
| Parameter    | Description                                           |
+==============+=======================================================+
| s1           | Pointer to string #1.                                 |
+--------------+-------------------------------------------------------+
| s2           | Pointer to string #2.                                 |
+--------------+-------------------------------------------------------+
| n            | Maximum number of characters to compare.              |
+--------------+-------------------------------------------------------+

Return value

Returns an integer greater than, equal to, or less than zero, if the possibly null-terminated array pointed to by s1 is greater than, equal to, or less than the possibly null-terminated array pointed to by s2.

Additional information

Compares not more than n characters from the array pointed to by s1 to the array pointed to by s2. Characters that follow a null character are not compared.

strcasecmp()
''''''''''''

Description

Compare strings, ignore case (POSIX.1).

Prototype

::

   int strcasecmp(const char * s1,
                  const char * s2);

Parameters

+-------------------------+--------------------------------------------+
| Parameter               | Description                                |
+=========================+============================================+
| s1                      | Pointer to string #1.                      |
+-------------------------+--------------------------------------------+
| s2                      | Pointer to string #2.                      |
+-------------------------+--------------------------------------------+

Return value

+-----------+----------------------------------------------------------+
| < 0       | s1 is less than s2.                                      |
+-----------+----------------------------------------------------------+
| = 0       | s1 is equal to s2.                                       |
+-----------+----------------------------------------------------------+
| > 0       | s1 is greater than to s2.                                |
+-----------+----------------------------------------------------------+

Additional information

Compares the string pointed to by s1 to the string pointed to by s2 ignoring differences in case.

`strcasecmp()`_ returns an integer greater than, equal to, or less than zero if the string pointed to by s1 is greater than, equal to, or less than the string pointed to by s2.

Notes

Conforms to POSIX.1-2008.

strncasecmp()
'''''''''''''

Description

Compare strings, ignore case, limit length (POSIX.1).

Prototype

::

   int strncasecmp(const char   * s1,
                   const char   * s2,
                         size_t   n);

Parameters

+--------------+-------------------------------------------------------+
| Parameter    | Description                                           |
+==============+=======================================================+
| s1           | Pointer to string #1.                                 |
+--------------+-------------------------------------------------------+
| s2           | Pointer to string #2.                                 |
+--------------+-------------------------------------------------------+
| n            | Maximum number of characters to compare.              |
+--------------+-------------------------------------------------------+

Return value

+-----------+----------------------------------------------------------+
| < 0       | s1 is less than s2.                                      |
+-----------+----------------------------------------------------------+
| = 0       | s1 is equal to s2.                                       |
+-----------+----------------------------------------------------------+
| > 0       | s1 is greater than to s2.                                |
+-----------+----------------------------------------------------------+

Additional information

Compares not more than n characters from the array pointed to by s1 to the array pointed to by s2 ignoring differences in case. Characters that follow a null character are not compared.

`strncasecmp()`_ returns an integer greater than, equal to, or less than zero, if the possibly null-terminated array pointed to by s1 is greater than, equal to, or less than the possibly null-terminated array pointed to by s2.

Notes

Conforms to POSIX.1-2008.

Search functions
^^^^^^^^^^^^^^^^

+------------------+----------------------------------------------------------------------+
| Function         | Description                                                          |
+==================+======================================================================+
| `memchr()`_      | Find character in memory, forward.                                   |
+------------------+----------------------------------------------------------------------+
| `memrchr()`_     | Find character in memory, reverse (BSD).                             |
+------------------+----------------------------------------------------------------------+
| `memmem()`_      | Find memory in memory, forward (BSD).                                |
+------------------+----------------------------------------------------------------------+
| `strchr()`_      | Find character within string, forward.                               |
+------------------+----------------------------------------------------------------------+
| `strnchr()`_     | Find character within string, forward, limit length.                 |
+------------------+----------------------------------------------------------------------+
| `strrchr()`_     | Find character within string, reverse.                               |
+------------------+----------------------------------------------------------------------+
| `strlen()`_      | Calculate length of string.                                          |
+------------------+----------------------------------------------------------------------+
| `strnlen()`_     | Calculate length of string, limit length (POSIX.1).                  |
+------------------+----------------------------------------------------------------------+
| `strstr()`_      | Find string within string, forward.                                  |
+------------------+----------------------------------------------------------------------+
| `strnstr()`_     | Find string within string, forward, limit length (BSD).              |
+------------------+----------------------------------------------------------------------+
| `strcasestr()`_  | Find string within string, forward, ignore case (BSD).               |
+------------------+----------------------------------------------------------------------+
| `strncasestr()`_ | Find string within string, forward, ignore case, limit length (BSD). |
+------------------+----------------------------------------------------------------------+
| `strpbrk()`_     | Find first occurrence of characters within string.                   |
+------------------+----------------------------------------------------------------------+
| `strspn()`_      | Compute size of string prefixed by a set of characters.              |
+------------------+----------------------------------------------------------------------+
| `strcspn()`_     | Compute size of string not prefixed by a set of characters.          |
+------------------+----------------------------------------------------------------------+
| `strtok()`_      | Break string into tokens.                                            |
+------------------+----------------------------------------------------------------------+
| `strtok_r()`_    | Break string into tokens, reentrant (POSIX.1).                       |
+------------------+----------------------------------------------------------------------+
| `strsep()`_      | Break string into tokens (BSD).                                      |
+------------------+----------------------------------------------------------------------+

memchr()
''''''''

Description

Find character in memory, forward.

Prototype

::

   void *memchr(const void   * s,
                      int      c,
                      size_t   n);

Parameters

+---------------+------------------------------------------------------+
| Parameter     | Description                                          |
+===============+======================================================+
| s             | Pointer to object to search.                         |
+---------------+------------------------------------------------------+
| c             | Character to search for.                             |
+---------------+------------------------------------------------------+
| n             | Number of characters in object to search.            |
+---------------+------------------------------------------------------+

Return value

+--------------+-------------------------------------------------------+
| = NULL       | c does not occur in the object.                       |
+--------------+-------------------------------------------------------+
| ≠ NULL       | Pointer to the located character.                     |
+--------------+-------------------------------------------------------+

Additional information

Locates the first occurrence of c (converted to an unsigned char) in the initial n characters (each interpreted as unsigned char) of the object pointed to by s. Unlike `strchr()`_, `memchr()`_ does not terminate a search when a null character is found in the object pointed to by s.

memrchr()
'''''''''

Description

Find character in memory, reverse (BSD).

Prototype

::

   void *memrchr(const void   * s,
                       int      c,
                       size_t   n);

Parameters

+---------------+------------------------------------------------------+
| Parameter     | Description                                          |
+===============+======================================================+
| s             | Pointer to object to search.                         |
+---------------+------------------------------------------------------+
| c             | Character to search for.                             |
+---------------+------------------------------------------------------+
| n             | Number of characters in object to search.            |
+---------------+------------------------------------------------------+

Return value

Returns a pointer to the located character, or a null pointer if c does not occur in the string.

Additional information

Locates the last occurrence of c (converted to a char) in the string pointed to by s.

Notes

Commonly found in Linux and BSD C libraries.

memmem()
''''''''

Description

Find memory in memory, forward (BSD).

Prototype

::

   void *memmem(const void   * s1,
                      size_t   n1,
                const void   * s2,
                      size_t   n2);

Parameters

+---------------+------------------------------------------------------+
| Parameter     | Description                                          |
+===============+======================================================+
| s1            | Pointer to object to search.                         |
+---------------+------------------------------------------------------+
| n1            | Number of characters to search in s1.                |
+---------------+------------------------------------------------------+
| s2            | Pointer to object to search for.                     |
+---------------+------------------------------------------------------+
| n2            | Number of characters to search from s2.              |
+---------------+------------------------------------------------------+

Return value

+---------+------------------------------------------------------------+
| = NULL  | (s2, n2) does not occur in (s1, n1).                       |
+---------+------------------------------------------------------------+
| ≠ NULL  | Pointer to the first occurrence of (s2, n2) in (s1, n1).   |
+---------+------------------------------------------------------------+

Additional information

Locates the first occurrence of the octet string s2 of length n2 in the octet string s1 of length n1.

Notes

Commonly found in Linux and BSD C libraries.

strchr()
''''''''

Description

Find character within string, forward.

Prototype

::

   char *strchr(const char * s,
                      int    c);

Parameters

+----------------------+-----------------------------------------------+
| Parameter            | Description                                   |
+======================+===============================================+
| s                    | String to search.                             |
+----------------------+-----------------------------------------------+
| c                    | Character to search for.                      |
+----------------------+-----------------------------------------------+

Return value

Returns a pointer to the located character, or a null pointer if c does not occur in the string.

Additional information

Locates the first occurrence of c (converted to a char) in the string pointed to by s. The terminating null character is considered to be part of the string.

strnchr()
'''''''''

Description

Find character within string, forward, limit length.

Prototype

::

   char *strnchr(const char   * s,
                       size_t   n,
                       int      c);

Parameters

+------------------+---------------------------------------------------+
| Parameter        | Description                                       |
+==================+===================================================+
| s                | String to search.                                 |
+------------------+---------------------------------------------------+
| n                | Number of characters to search.                   |
+------------------+---------------------------------------------------+
| c                | Character to search for.                          |
+------------------+---------------------------------------------------+

Return value

Returns a pointer to the located character, or a null pointer if c does not occur in the string.

Additional information

Searches not more than n characters to locate the first occurrence of c (converted to a char) in the string pointed to by s. The terminating null character is considered to be part of the string.

strrchr()
'''''''''

Description

Find character within string, reverse.

Prototype

::

   char *strrchr(const char * s,
                       int    c);

Parameters

+----------------------+-----------------------------------------------+
| Parameter            | Description                                   |
+======================+===============================================+
| s                    | String to search.                             |
+----------------------+-----------------------------------------------+
| c                    | Character to search for.                      |
+----------------------+-----------------------------------------------+

Return value

Returns a pointer to the located character, or a null pointer if c does not occur in the string.

Additional information

Locates the last occurrence of c (converted to a char) in the string pointed to by s. The terminating null character is considered to be part of the string.

strlen()
''''''''

Description

Calculate length of string.

Prototype

::

   size_t strlen(const char * s);

Parameters

+-----------------+----------------------------------------------------+
| Parameter       | Description                                        |
+=================+====================================================+
| s               | Pointer to zero-terminated string.                 |
+-----------------+----------------------------------------------------+

Return value

Returns the length of the string pointed to by s, that is the number of characters that precede the terminating null character.

strnlen()
'''''''''

Description

Calculate length of string, limit length (POSIX.1).

Prototype

::

   size_t strnlen(const char   * s,
                        size_t   n);

Parameters

+--------------+-------------------------------------------------------+
| Parameter    | Description                                           |
+==============+=======================================================+
| s            | Pointer to string.                                    |
+--------------+-------------------------------------------------------+
| n            | Maximum number of characters to examine.              |
+--------------+-------------------------------------------------------+

Return value

Returns the length of the string pointed to by s, up to a maximum of n characters. `strnlen()`_ only examines the first n characters of the string s.

Notes

Conforms to POSIX.1-2008.

strstr()
''''''''

Description

Find string within string, forward.

Prototype

::

   char *strstr(const char * s1,
                const char * s2);

Parameters

+-------------------------+--------------------------------------------+
| Parameter               | Description                                |
+=========================+============================================+
| s1                      | String to search.                          |
+-------------------------+--------------------------------------------+
| s2                      | String to search for.                      |
+-------------------------+--------------------------------------------+

Return value

Returns a pointer to the located string, or a null pointer if the string is not found. If s2 points to a string with zero length, `strstr()`_ returns s1.

Additional information

Locates the first occurrence in the string pointed to by s1 of the sequence of characters (excluding the terminating null character) in the string pointed to by s2.

strnstr()
'''''''''

Description

Find string within string, forward, limit length (BSD).

Prototype

::

   char *strnstr(const char   * s1,
                 const char   * s2,
                       size_t   n);

Parameters

+--------------+-------------------------------------------------------+
| Parameter    | Description                                           |
+==============+=======================================================+
| s1           | String to search.                                     |
+--------------+-------------------------------------------------------+
| s2           | String to search for.                                 |
+--------------+-------------------------------------------------------+
| n            | Maximum number of characters to search for.           |
+--------------+-------------------------------------------------------+

Return value

Returns a pointer to the located string, or a null pointer if the string is not found. If s2 points to a string with zero length, `strnstr()`_ returns s1.

Additional information

Searches at most n characters to locate the first occurrence in the string pointed to by s1 of the sequence of characters (excluding the terminating null character) in the string pointed to by s2.

Notes

Commonly found in Linux and BSD C libraries.

strcasestr()
''''''''''''

Description

Find string within string, forward, ignore case (BSD).

Prototype

::

   char *strcasestr(const char * s1,
                    const char * s2);

Parameters

+-------------------------+--------------------------------------------+
| Parameter               | Description                                |
+=========================+============================================+
| s1                      | String to search for.                      |
+-------------------------+--------------------------------------------+
| s2                      | String to search.                          |
+-------------------------+--------------------------------------------+

Return value

Returns a pointer to the located string, or a null pointer if the string is not found. If s2 points to a string with zero length, returns s1.

Additional information

Locates the first occurrence in the string pointed to by s1 of the sequence of characters (excluding the terminating null character) in the string pointed to by s2 without regard to character case.

Notes

This extension is commonly found in Linux and BSD C libraries.

strncasestr()
'''''''''''''

Description

Find string within string, forward, ignore case, limit length (BSD).

Prototype

::

   char *strncasestr(const char   * s1,
                     const char   * s2,
                           size_t   n);

Parameters

+-------------+--------------------------------------------------------+
| Parameter   | Description                                            |
+=============+========================================================+
| s1          | String to search for.                                  |
+-------------+--------------------------------------------------------+
| s2          | String to search.                                      |
+-------------+--------------------------------------------------------+
| n           | Maximum number of characters to compare in s2.         |
+-------------+--------------------------------------------------------+

Return value

Returns a pointer to the located string, or a null pointer if the string is not found. If s2 points to a string with zero length, returns s1.

Additional information

Searches at most n characters to locate the first occurrence in the string pointed to by s1 of the sequence of characters (excluding the terminating null character) in the string pointed to by s2 without regard to character case.

Notes

This extension is commonly found in Linux and BSD C libraries.

strpbrk()
'''''''''

Description

Find first occurrence of characters within string.

Prototype

::

   char *strpbrk(const char * s1,
                 const char * s2);

Parameters

+-------------------+--------------------------------------------------+
| Parameter         | Description                                      |
+===================+==================================================+
| s1                | Pointer to string to search.                     |
+-------------------+--------------------------------------------------+
| s2                | Pointer to string to search for.                 |
+-------------------+--------------------------------------------------+

Return value

Returns a pointer to the first character, or a null pointer if no character from s2 occurs in s1.

Additional information

Locates the first occurrence in the string pointed to by s1 of any character from the string pointed to by s2.

strspn()
''''''''

Description

Compute size of string prefixed by a set of characters.

Prototype

::

   size_t strspn(const char * s1,
                 const char * s2);

Parameters

+-------------+--------------------------------------------------------+
| Parameter   | Description                                            |
+=============+========================================================+
| s1          | Pointer to zero-terminated string to search.           |
+-------------+--------------------------------------------------------+
| s2          | Pointer to zero-terminated acceptable-set string.      |
+-------------+--------------------------------------------------------+

Return value

Returns the length of the string pointed to by s1 which consists entirely of characters from the string pointed to by s2

Additional information

Computes the length of the maximum initial segment of the string pointed to by s1 which consists entirely of characters from the string pointed to by s2.

strcspn()
'''''''''

Description

Compute size of string not prefixed by a set of characters.

Prototype

::

   size_t strcspn(const char * s1,
                  const char * s2);

Parameters

+-------------+--------------------------------------------------------+
| Parameter   | Description                                            |
+=============+========================================================+
| s1          | Pointer to string to search.                           |
+-------------+--------------------------------------------------------+
| s2          | Pointer to string containing characters to skip.       |
+-------------+--------------------------------------------------------+

Return value

Returns the length of the segment of string s1 prefixed by characters from s2.

Additional information

Computes the length of the maximum initial segment of the string pointed to by s1 which consists entirely of characters not from the string pointed to by s2.

strtok()
''''''''

Description

Break string into tokens.

Prototype

::

   char *strtok(      char * s1,
                const char * s2);

Parameters

+--------------+-------------------------------------------------------+
| Parameter    | Description                                           |
+==============+=======================================================+
| s1           | Pointer to zero-terminated string to parse.           |
+--------------+-------------------------------------------------------+
| s2           | Pointer to zero-terminated set of separators.         |
+--------------+-------------------------------------------------------+

Return value

NULL if no further tokens else a pointer to the next token.

Additional information

A sequence of calls to `strtok()`_ breaks the string pointed to by s1 into a sequence of tokens, each of which is delimited by a character from the string pointed to by s2. The first call in the sequence has a non-null first argument; subsequent calls in the sequence have a null first argument. The separator string pointed to by s2 may be different from call to call.

The first call in the sequence searches the string pointed to by s1 for the first character that is not contained in the current separator string pointed to by s2. If no such character is found, then there are no tokens in the string pointed to by s1 and `strtok()`_ returns a null pointer. If such a character is found, it is the start of the first token.

`strtok()`_ then searches from there for a character that is contained in the current separator string. If no such character is found, the current token extends to the end of the string pointed to by s1, and subsequent searches for a token will return a null pointer. If such a character is found, it is overwritten by a null character, which terminates the current token. `strtok()`_ saves a pointer to the following character, from which the next search for a token will start.

Each subsequent call, with a null pointer as the value of the first argument, starts searching from the saved pointer and behaves as described above.

Notes

`strtok()`_ maintains static state and is therefore not reentrant and not thread safe. See `strtok_r()`_ for a thread-safe and reentrant variant.

See also

`strsep()`_, `strtok_r()`_.

strtok_r()
''''''''''

Description

Break string into tokens, reentrant (POSIX.1).

Prototype

::

   char *strtok_r(      char  * s1,
                  const char  * s2,
                        char ** lasts);

Parameters

+------------+---------------------------------------------------------+
| Parameter  | Description                                             |
+============+=========================================================+
| s1         | Pointer to zero-terminated string to parse.             |
+------------+---------------------------------------------------------+
| s2         | Pointer to zero-terminated set of separators.           |
+------------+---------------------------------------------------------+
| lasts      | Pointer to pointer to char that maintains parse state.  |
+------------+---------------------------------------------------------+

Return value

NULL if no further tokens else a pointer to the next token.

Additional information

`strtok_r()`_ is a reentrant version of the function `strtok()`_ where the state is maintained in the object of type char \* pointed to by s3.

Notes

Conforms to POSIX.1-2008 and is commonly found in Linux and BSD C libraries.

See also

`strtok()`_

strsep()
''''''''

Description

Break string into tokens (BSD).

Prototype

::

   char *strsep(      char ** stringp,
                const char  * delim);

Parameters

+--------------+-------------------------------------------------------+
| Parameter    | Description                                           |
+==============+=======================================================+
| stringp      | Pointer to pointer to zero-terminated string.         |
+--------------+-------------------------------------------------------+
| delim        | Pointer to delimiter set string.                      |
+--------------+-------------------------------------------------------+

Return value

See below.

Additional information

Locates, in the string referenced by \*stringp, the first occurrence of any character in the string delim (or the terminating null character) and replaces it with a null character. The location of the next character after the delimiter character (or NULL, if the end of the string was reached) is stored in \*stringp. The original value of \*stringp is returned.

An empty field (that is, a character in the string delim occurs as the first character of \*stringp) can be detected by comparing the location referenced by the returned pointer to the null wide character.

If \*stringp is initially null, `strsep()`_ returns null.

Notes

Commonly found in Linux and BSD C libraries.

.. _miscellaneous-functions-1:

Miscellaneous functions
^^^^^^^^^^^^^^^^^^^^^^^

+-------------------------+--------------------------------------------+
| Function                | Description                                |
+=========================+============================================+
| `strerror()`_           | Decode error code.                         |
+-------------------------+--------------------------------------------+

strerror()
''''''''''

Description

Decode error code.

Prototype

::

   char *strerror(int num);

Parameters

+------------------------------+---------------------------------------+
| Parameter                    | Description                           |
+==============================+=======================================+
| num                          | Error number.                         |
+------------------------------+---------------------------------------+

Return value

Returns a pointer to the message string. The program must not modify the returned message string. The message may be overwritten by a subsequent call to `strerror()`_.

Additional information

Maps the number in num to a message string. Typically, the values for num come from errno, but `strerror()`_ can map any value of type int to a message.

<time.h>
~~~~~~~~

Operations
^^^^^^^^^^

+---------------+-------------------------------------------------------+
| Function      | Description                                           |
+===============+=======================================================+
| `mktime()`_   | Convert a struct tm to time_t.                        |
+---------------+-------------------------------------------------------+
| `difftime()`_ | Calculate difference between two times.               |
+---------------+-------------------------------------------------------+

mktime()
''''''''

Description

Convert a struct tm to time_t.

Prototype

::

   time_t mktime(tm * tp);

Parameters

+-----------------------+----------------------------------------------+
| Parameter             | Description                                  |
+=======================+==============================================+
| tp                    | Pointer to time object.                      |
+-----------------------+----------------------------------------------+

Return value

Number of seconds since UTC 1 January 1970 of the validated object.

Additional information

Validates (and updates) the object pointed to by tp to ensure that the tm_sec, tm_min, tm_hour, and tm_mon fields are within the supported integer ranges and the tm_mday, tm_mon and tm_year fields are consistent. The validated object is converted to the number of seconds since UTC 1 January 1970 and returned.

difftime()
''''''''''

Description

Calculate difference between two times.

Prototype

::

   double difftime(time_t time2,
                   time_t time1);

Parameters

+---------------------------------+------------------------------------+
| Parameter                       | Description                        |
+=================================+====================================+
| time2                           | End time.                          |
+---------------------------------+------------------------------------+
| time1                           | Start time.                        |
+---------------------------------+------------------------------------+

Return value

returns time2-time1 as a double precision number.

.. _conversion-functions-1:

Conversion functions
^^^^^^^^^^^^^^^^^^^^

+------------------+---------------------------------------------------+
| Function         | Description                                       |
+==================+===================================================+
| `ctime()`_       | Convert time_t to a string.                       |
+------------------+---------------------------------------------------+
| `ctime_r()`_     | Convert time_t to a string, reentrant.            |
+------------------+---------------------------------------------------+
| `asctime()`_     | Convert time_t to a string.                       |
+------------------+---------------------------------------------------+
| `asctime_r()`_   | Convert time_t to a string, reentrant.            |
+------------------+---------------------------------------------------+
| `gmtime()`_      | Convert time_t to struct tm.                      |
+------------------+---------------------------------------------------+
| `gmtime_r()`_    | Convert time_t to struct tm, reentrant.           |
+------------------+---------------------------------------------------+
| `localtime()`_   | Convert time to local time.                       |
+------------------+---------------------------------------------------+
| `localtime_r()`_ | Convert time to local time, reentrant.            |
+------------------+---------------------------------------------------+
| `strftime()`_    | Convert time to a string.                         |
+------------------+---------------------------------------------------+
| `strftime_l()`_  | Convert time to a string.                         |
+------------------+---------------------------------------------------+

ctime()
'''''''

Description

Convert time_t to a string.

Prototype

::

   char *ctime(const time_t * tp);

Parameters

+---------------------+------------------------------------------------+
| Parameter           | Description                                    |
+=====================+================================================+
| tp                  | Pointer to time to convert.                    |
+---------------------+------------------------------------------------+

Return value

Pointer to zero-terminated converted string.

Additional information

Converts the time pointed to by tp to a null-terminated string.

Notes

The returned string is held in a static buffer: this function is not thread safe.

ctime_r()
'''''''''

Description

Convert time_t to a string, reentrant.

Prototype

::

   char *ctime_r(const time_t * tp,
                       char   * buf);

Parameters

+-----------+------------------------------------------------------------------------------------------------------------------------------+
| Parameter | Description                                                                                                                  |
+===========+==============================================================================================================================+
| tp        | Pointer to time to convert.                                                                                                  |
+-----------+------------------------------------------------------------------------------------------------------------------------------+
| buf       | Pointer to array of characters that receives the zero-terminated string; the array must be at least 26 characters in length. |
+-----------+------------------------------------------------------------------------------------------------------------------------------+

Return value

Returns the value of buf.

Additional information

Converts the time pointed to by tp to a null-terminated string.

Notes

The returned string is held in a static buffer: this function is not thread safe.

asctime()
'''''''''

Description

Convert time_t to a string.

Prototype

::

   char *asctime(const tm * tp);

Parameters

+---------------------+------------------------------------------------+
| Parameter           | Description                                    |
+=====================+================================================+
| tp                  | Pointer to time to convert.                    |
+---------------------+------------------------------------------------+

Return value

Pointer to zero-terminated converted string.

Additional information

Converts the time pointed to by tp to a null-terminated string of the Sun Sep 16 01:03:52 1973. The returned string is held in a static buffer.

Notes

The returned string is held in a static buffer: this function is not thread safe.

asctime_r()
'''''''''''

Description

Convert time_t to a string, reentrant.

Prototype

::

   char *asctime_r(const tm   * tp,
                         char * buf);

Parameters

+-----------+------------------------------------------------------------------------------------------------------------------------------+
| Parameter | Description                                                                                                                  |
+===========+==============================================================================================================================+
| tp        | Pointer to time to convert.                                                                                                  |
+-----------+------------------------------------------------------------------------------------------------------------------------------+
| buf       | Pointer to array of characters that receives the zero-terminated string; the array must be at least 26 characters in length. |
+-----------+------------------------------------------------------------------------------------------------------------------------------+

Return value

Returns the value of buf.

Additional information

Converts the time pointed to by tp to a null-terminated string of the Sun Sep 16 01:03:52 1973. The converted string is written into the array pointed to by buf.

gmtime()
''''''''

Description

Convert time_t to struct tm.

Prototype

::

    gmtime(const time_t * tp);

Parameters

+---------------------+------------------------------------------------+
| Parameter           | Description                                    |
+=====================+================================================+
| tp                  | Pointer to time to convert.                    |
+---------------------+------------------------------------------------+

Return value

Pointer to converted time.

Additional information

Converts the time pointed to by tp to a struct tm.

Notes

The returned pointer points to a static buffer: this function is not thread safe.

gmtime_r()
''''''''''

Description

Convert time_t to struct tm, reentrant.

Prototype

::

    gmtime_r(const time_t * tp,
                            tm *tm);

Parameters

+-------------+--------------------------------------------------------+
| Parameter   | Description                                            |
+=============+========================================================+
| tp          | Pointer to time to convert.                            |
+-------------+--------------------------------------------------------+
| tm          | Pointer to object that receives the converted time.    |
+-------------+--------------------------------------------------------+

Return value

Returns tm.

Additional information

Converts the time pointed to by tp to a struct tm.

localtime()
'''''''''''

Description

Convert time to local time.

Prototype

::

    localtime(const time_t * tp);

Parameters

+---------------------+------------------------------------------------+
| Parameter           | Description                                    |
+=====================+================================================+
| tp                  | Pointer to time to convert.                    |
+---------------------+------------------------------------------------+

Return value

Pointer to a statically-allocated object holding the local time.

Additional information

Converts the time pointed to by tp to local time format.

Notes

The returned pointer points to a static object: this function is not thread safe.

localtime_r()
'''''''''''''

Description

Convert time to local time, reentrant.

Prototype

::

    localtime_r(const time_t * tp,
                               tm *tm);

Parameters

+------------+-----------------------------------------------------------+
| Parameter  | Description                                               |
+============+===========================================================+
| tp         | Pointer to time to convert.                               |
+------------+-----------------------------------------------------------+
| tm         | Pointer to object that receives the converted local time. |
+------------+-----------------------------------------------------------+

Return value

Returns tm.

Additional information

Converts the time pointed to by tp to local time format and writes it to the object pointed to by tm.

strftime()
''''''''''

Description

Convert time to a string.

Prototype

::

   size_t strftime(      char   * s,
                         size_t   smax,
                   const char   * fmt,
                   const tm     * tp);

Parameters

+-----------+--------------------------------------------------------------------+
| Parameter | Description                                                        |
+===========+====================================================================+
| s         | Pointer to object that receives the converted string.              |
+-----------+--------------------------------------------------------------------+
| smax      | Maximum number of characters written to the array pointed to by s. |
+-----------+--------------------------------------------------------------------+
| fmt       | Pointer to zero-terminated format control string.                  |
+-----------+--------------------------------------------------------------------+
| tp        | Pointer to time to convert.                                        |
+-----------+--------------------------------------------------------------------+

Return value

Returns the name of the current locale.

Additional information

Formats the time pointed to by tp to a null-terminated string of maximum size smax-1 into the pointed to by \*s based on the fmt format string. The format string consists of conversion specifications and ordinary characters. Conversion specifications start with a “%” character followed by an optional “#” character.

The following conversion specifications are supported:

+---------------+------------------------------------------------------------------------------------------------+
| Specification | Description                                                                                    |
+===============+================================================================================================+
| %a            | Abbreviated weekday name                                                                       |
+---------------+------------------------------------------------------------------------------------------------+
| %A            | Full weekday name                                                                              |
+---------------+------------------------------------------------------------------------------------------------+
| %b            | Abbreviated month name                                                                         |
+---------------+------------------------------------------------------------------------------------------------+
| %B            | Full month name                                                                                |
+---------------+------------------------------------------------------------------------------------------------+
| %c            | Date and time representation appropriate for locale                                            |
+---------------+------------------------------------------------------------------------------------------------+
| %#c           | Date and time formatted as “%A, %B %#d, %Y, %H:%M:%S” (Microsoft extension)                    |
+---------------+------------------------------------------------------------------------------------------------+
| %C            | Century number                                                                                 |
+---------------+------------------------------------------------------------------------------------------------+
| %d            | Day of month as a decimal number [01,31]                                                       |
+---------------+------------------------------------------------------------------------------------------------+
| %#d           | Day of month without leading zero [1,31]                                                       |
+---------------+------------------------------------------------------------------------------------------------+
| %D            | Date in the form %m/%d/%y (POSIX.1-2008 extension)                                             |
+---------------+------------------------------------------------------------------------------------------------+
| %e            | Day of month [ 1,31], single digit preceded by space                                           |
+---------------+------------------------------------------------------------------------------------------------+
| %F            | Date in the format %Y-%m-%d                                                                    |
+---------------+------------------------------------------------------------------------------------------------+
| %h            | Abbreviated month name as %b                                                                   |
+---------------+------------------------------------------------------------------------------------------------+
| %H            | Hour in 24-hour format [00,23]                                                                 |
+---------------+------------------------------------------------------------------------------------------------+
| %#H           | Hour in 24-hour format without leading zeros [0,23]                                            |
+---------------+------------------------------------------------------------------------------------------------+
| %I            | Hour in 12-hour format [01,12]                                                                 |
+---------------+------------------------------------------------------------------------------------------------+
| %#I           | Hour in 12-hour format without leading zeros [1,12]                                            |
+---------------+------------------------------------------------------------------------------------------------+
| %j            | Day of year as a decimal number [001,366]                                                      |
+---------------+------------------------------------------------------------------------------------------------+
| %#j           | Day of year as a decimal number without leading zeros [1,366]                                  |
+---------------+------------------------------------------------------------------------------------------------+
| %k            | Hour in 24-hour clock format [ 0,23] (POSIX.1-2008 extension)                                  |
+---------------+------------------------------------------------------------------------------------------------+
| %l            | Hour in 12-hour clock format [ 0,12] (POSIX.1-2008 extension)                                  |
+---------------+------------------------------------------------------------------------------------------------+
| %m            | Month as a decimal number [01,12]                                                              |
+---------------+------------------------------------------------------------------------------------------------+
| %#m           | Month as a decimal number without leading zeros [1,12]                                         |
+---------------+------------------------------------------------------------------------------------------------+
| %M            | Minute as a decimal number [00,59]                                                             |
+---------------+------------------------------------------------------------------------------------------------+
| %#M           | Minute as a decimal number without leading zeros [0,59]                                        |
+---------------+------------------------------------------------------------------------------------------------+
| %n            | Insert newline character (POSIX.1-2008 extension)                                              |
+---------------+------------------------------------------------------------------------------------------------+
| %p            | Locale’s a.m or p.m indicator for 12-hour clock                                                |
+---------------+------------------------------------------------------------------------------------------------+
| %r            | Time as %I:%M:%s %p (POSIX.1-2008 extension)                                                   |
+---------------+------------------------------------------------------------------------------------------------+
| %R            | Time as %H:%M (POSIX.1-2008 extension)                                                         |
+---------------+------------------------------------------------------------------------------------------------+
| %S            | Second as a decimal number [00,59]                                                             |
+---------------+------------------------------------------------------------------------------------------------+
| %t            | Insert tab character (POSIX.1-2008 extension)                                                  |
+---------------+------------------------------------------------------------------------------------------------+
| %T            | Time as %H:%M:%S                                                                               |
+---------------+------------------------------------------------------------------------------------------------+
| %#S           | Second as a decimal number without leading zeros [0,59]                                        |
+---------------+------------------------------------------------------------------------------------------------+
| %U            | Week of year as a decimal number [00,53], Sunday is first day of the week                      |
+---------------+------------------------------------------------------------------------------------------------+
| %#U           | Week of year as a decimal number without leading zeros [0,53], Sunday is first day of the week |
+---------------+------------------------------------------------------------------------------------------------+
| %w            | Weekday as a decimal number [0,6], Sunday is 0                                                 |
+---------------+------------------------------------------------------------------------------------------------+
| %W            | Week number as a decimal number [00,53], Monday is first day of the week                       |
+---------------+------------------------------------------------------------------------------------------------+
| %#W           | Week number as a decimal number without leading zeros [0,53], Monday is first day of the week  |
+---------------+------------------------------------------------------------------------------------------------+
| %x            | Locale’s date representation                                                                   |
+---------------+------------------------------------------------------------------------------------------------+
| %#x           | Locale’s long date representation                                                              |
+---------------+------------------------------------------------------------------------------------------------+
| %X            | Locale’s time representation                                                                   |
+---------------+------------------------------------------------------------------------------------------------+
| %y            | Year without century, as a decimal number [00,99]                                              |
+---------------+------------------------------------------------------------------------------------------------+
| %#y           | Year without century, as a decimal number without leading zeros [0,99]                         |
+---------------+------------------------------------------------------------------------------------------------+
| %Y            | Year with century, as decimal number                                                           |
+---------------+------------------------------------------------------------------------------------------------+
| %z,%Z         | Timezone name or abbreviation                                                                  |
+---------------+------------------------------------------------------------------------------------------------+
| %%            | %                                                                                              |
+---------------+------------------------------------------------------------------------------------------------+

strftime_l()
''''''''''''

Description

Convert time to a string.

Prototype

::

   size_t strftime_l(      char   * s,
                           size_t   smax,
                     const char   * fmt,
                     const tm     * tp,
                                    locale_t loc);

Parameters

+-----------+--------------------------------------------------------------------+
| Parameter | Description                                                        |
+===========+====================================================================+
| s         | Pointer to object that receives the converted string.              |
+-----------+--------------------------------------------------------------------+
| smax      | Maximum number of characters written to the array pointed to by s. |
+-----------+--------------------------------------------------------------------+
| fmt       | Pointer to zero-terminated format control string.                  |
+-----------+--------------------------------------------------------------------+
| tp        | Pointer to time to convert.                                        |
+-----------+--------------------------------------------------------------------+
| loc       | Locale to use for conversion.                                      |
+-----------+--------------------------------------------------------------------+

Return value

Returns the name of the current locale.

Additional information

Formats the time pointed to by tp to a null-terminated string of maximum size smax-1 into the pointed to by \*s based on the fmt format string and using the locale loc.

The format string consists of conversion specifications and ordinary characters. Conversion specifications start with a “%” character followed by an optional “#” character.

See `strftime()`_ for a description of the format conversion specifications.

<wchar.h>
~~~~~~~~~

.. _copying-functions-1:

Copying functions
^^^^^^^^^^^^^^^^^

+---------------+-----------------------------------------------------------------+
| Function      | Description                                                     |
+===============+=================================================================+
| `wmemset()`_  | Set memory to wide character.                                   |
+---------------+-----------------------------------------------------------------+
| `wmemcpy()`_  | Copy memory.                                                    |
+---------------+-----------------------------------------------------------------+
| `wmemccpy()`_ | Copy memory, specify terminator (POSIX.1).                      |
+---------------+-----------------------------------------------------------------+
| `wmempcpy()`_ | Copy memory (GNU).                                              |
+---------------+-----------------------------------------------------------------+
| `wmemmove()`_ | Copy memory, tolerate overlaps.                                 |
+---------------+-----------------------------------------------------------------+
| `wcscpy()`_   | Copy string.                                                    |
+---------------+-----------------------------------------------------------------+
| `wcsncpy()`_  | Copy string, limit length.                                      |
+---------------+-----------------------------------------------------------------+
| `wcslcpy()`_  | Copy string, limit length, always zero terminate (BSD).         |
+---------------+-----------------------------------------------------------------+
| `wcscat()`_   | Concatenate strings.                                            |
+---------------+-----------------------------------------------------------------+
| `wcsncat()`_  | Concatenate strings, limit length.                              |
+---------------+-----------------------------------------------------------------+
| `wcslcat()`_  | Concatenate strings, limit length, always zero terminate (BSD). |
+---------------+-----------------------------------------------------------------+
| `wcsdup()`_   | Duplicate string (POSIX.1).                                     |
+---------------+-----------------------------------------------------------------+
| `wcsndup()`_  | Duplicate string, limit length (GNU).                           |
+---------------+-----------------------------------------------------------------+

wmemset()
'''''''''

Description

Set memory to wide character.

Prototype

::

   wchar_t *wmemset(wchar_t * s,
                    wchar_t   c,
                    size_t    n);

Parameters

+-------------+--------------------------------------------------------+
| Parameter   | Description                                            |
+=============+========================================================+
| s           | Pointer to destination object.                         |
+-------------+--------------------------------------------------------+
| c           | Wide character to copy.                                |
+-------------+--------------------------------------------------------+
| n           | Length of destination object in wide characters.       |
+-------------+--------------------------------------------------------+

Return value

Returns s.

Additional information

Copies the value of c into each of the first n wide characters of the object pointed to by s.

wmemcpy()
'''''''''

Description

Copy memory.

Prototype

::

   wchar_t *wmemcpy(      wchar_t * s1,
                    const wchar_t * s2,
                          size_t    n);

Parameters

+-----------------+----------------------------------------------------+
| Parameter       | Description                                        |
+=================+====================================================+
| s1              | Pointer to destination object.                     |
+-----------------+----------------------------------------------------+
| s2              | Pointer to source object.                          |
+-----------------+----------------------------------------------------+
| n               | Number of wide characters to copy.                 |
+-----------------+----------------------------------------------------+

Return value

Returns the value of s1.

Additional information

Copies n wide characters from the object pointed to by s2 into the object pointed to by s1. The behavior of `wmemcpy()`_ is undefined if copying takes place between objects that overlap.

wmemccpy()
''''''''''

Description

Copy memory, specify terminator (POSIX.1).

Prototype

::

   wchar_t *wmemccpy(      wchar_t * s1,
                     const wchar_t * s2,
                           wchar_t   c,
                           size_t    n);

Parameters

+---------------+------------------------------------------------------+
| Parameter     | Description                                          |
+===============+======================================================+
| s1            | Pointer to destination object.                       |
+---------------+------------------------------------------------------+
| s2            | Pointer to source object.                            |
+---------------+------------------------------------------------------+
| c             | Character that terminates copy.                      |
+---------------+------------------------------------------------------+
| n             | Maximum number of characters to copy.                |
+---------------+------------------------------------------------------+

Return value

Returns a pointer to the wide character immediately following c in s1, or NULL if c was not found in the first n wide characters of s2.

Additional information

Copies at most n wide characters from the object pointed to by s2 into the object pointed to by s1. The copying stops as soon as n wide characters are copied or the wide character c is copied into the destination object pointed to by s1.

The behavior of `wmemccpy()`_ is undefined if copying takes place between objects that overlap.

Notes

Conforms to POSIX.1-2008.

wmempcpy()
''''''''''

Description

Copy memory (GNU).

Prototype

::

   wchar_t *wmempcpy(      wchar_t * s1,
                     const wchar_t * s2,
                           size_t    n);

Parameters

+-----------------+----------------------------------------------------+
| Parameter       | Description                                        |
+=================+====================================================+
| s1              | Pointer to destination object.                     |
+-----------------+----------------------------------------------------+
| s2              | Pointer to source object.                          |
+-----------------+----------------------------------------------------+
| n               | Number of wide characters to copy.                 |
+-----------------+----------------------------------------------------+

Return value

Returns a pointer to the wide character immediately following the final wide character written into s1.

Additional information

Copies n wide characters from the object pointed to by s2 into the object pointed to by s1. The behavior of `wmempcpy()`_ is undefined if copying takes place between objects that overlap.

Notes

This is an extension found in GNU libc.

wmemmove()
''''''''''

Description

Copy memory, tolerate overlaps.

Prototype

::

   wchar_t *wmemmove(      wchar_t * s1,
                     const wchar_t * s2,
                           size_t    n);

Parameters

+-----------------+----------------------------------------------------+
| Parameter       | Description                                        |
+=================+====================================================+
| s1              | Pointer to destination object.                     |
+-----------------+----------------------------------------------------+
| s2              | Pointer to source object.                          |
+-----------------+----------------------------------------------------+
| n               | Number of wide characters to copy.                 |
+-----------------+----------------------------------------------------+

Return value

Returns the value of s1.

Additional information

Copies n wide characters from the object pointed to by s2 into the object pointed to by s1 ensuring that if s1 and s2 overlap, the copy works correctly. Copying takes place as if the n wide characters from the object pointed to by s2 are first copied into a temporary array of n wide characters that does not overlap the objects pointed to by s1 and s2, and then the n wide characters from the temporary array are copied into the object pointed to by s1.

wcscpy()
''''''''

Description

Copy string.

Prototype

::

   wchar_t *wcscpy(      wchar_t * s1,
                   const wchar_t * s2);

Parameters

+------------------+---------------------------------------------------+
| Parameter        | Description                                       |
+==================+===================================================+
| s1               | Pointer to wide string to copy to.                |
+------------------+---------------------------------------------------+
| s2               | Pointer to wide string to copy.                   |
+------------------+---------------------------------------------------+

Return value

Returns the value of s1.

Additional information

Copies the wide string pointed to by s2 (including the terminating null wide character) into the array pointed to by s1. The behavior of `wcscpy()`_ is undefined if copying takes place between objects that overlap.

wcsncpy()
'''''''''

Description

Copy string, limit length.

Prototype

::

   wchar_t *wcsncpy(      wchar_t * s1,
                    const wchar_t * s2,
                          size_t    n);

Parameters

+--------------+-------------------------------------------------------+
| Parameter    | Description                                           |
+==============+=======================================================+
| s1           | Pointer to wide string to copy to.                    |
+--------------+-------------------------------------------------------+
| s2           | Pointer to wide string to copy.                       |
+--------------+-------------------------------------------------------+
| n            | Maximum number of wide characters to copy.            |
+--------------+-------------------------------------------------------+

Return value

Returns the value of s1.

Additional information

Copies not more than n wide characters from the array pointed to by s2 to the array pointed to by s1. Wide characters that follow a null wide character in s2 are not copied. The behavior of `wcsncpy()`_ is undefined if copying takes place between objects that overlap. If the array pointed to by s2 is a wide string that is shorter than n wide characters, null wide characters are appended to the copy in the array pointed to by s1, until n characters in all have been written.

Notes

No wide null character is implicitly appended to the end of s1, so s1 will only be terminated by a wide null character if the length of the wide string pointed to by s2 is less than n.

wcslcpy()
'''''''''

Description

Copy string, limit length, always zero terminate (BSD).

Prototype

::

   size_t wcslcpy(      wchar_t * s1,
                  const wchar_t * s2,
                        size_t    n);

Parameters

+-----------+-----------------------------------------------------------------------+
| Parameter | Description                                                           |
+===========+=======================================================================+
| s1        | Pointer to wide string to copy to.                                    |
+-----------+-----------------------------------------------------------------------+
| s2        | Pointer to wide string to copy.                                       |
+-----------+-----------------------------------------------------------------------+
| n         | Maximum number of wide characters, including terminating null, in s1. |
+-----------+-----------------------------------------------------------------------+

Return value

Returns the number of wide characters it tried to copy, which is the length of the wide string s2 or n, whichever is smaller.

Additional information

Copies up to n-1 wide characters from the wide string pointed to by s2 into the array pointed to by s1 and always terminates the result with a null character.

The behavior of `strlcpy()`_ is undefined if copying takes place between objects that overlap.

Notes

Commonly found in BSD libraries and contrasts with `wcsncpy()`_ in that the resulting string is always terminated with a null wide character.

wcscat()
''''''''

Description

Concatenate strings.

Prototype

::

   wchar_t *wcscat(      wchar_t * s1,
                   const wchar_t * s2);

Parameters

+---------------+------------------------------------------------------+
| Parameter     | Description                                          |
+===============+======================================================+
| s1            | Zero-terminated wide string to append to.            |
+---------------+------------------------------------------------------+
| s2            | Zero-terminated wide string to append.               |
+---------------+------------------------------------------------------+

Return value

Returns the value of s1.

Additional information

Appends a copy of the wide string pointed to by s2 (including the terminating null wide character) to the end of the wide string pointed to by s1. The initial character of s2 overwrites the null wide character at the end of s1. The behavior of `wcscat()`_ is undefined if copying takes place between objects that overlap.

wcsncat()
'''''''''

Description

Concatenate strings, limit length.

Prototype

::

   wchar_t *wcsncat(      wchar_t * s1,
                    const wchar_t * s2,
                          size_t    n);

Parameters

+--------------+-------------------------------------------------------+
| Parameter    | Description                                           |
+==============+=======================================================+
| s1           | Wide string to append to.                             |
+--------------+-------------------------------------------------------+
| s2           | Wide string to append.                                |
+--------------+-------------------------------------------------------+
| n            | Maximum number of wide characters in s1.              |
+--------------+-------------------------------------------------------+

Return value

Returns the value of s1.

Additional information

Appends not more than n wide characters from the array pointed to by s2 to the end of the wide string pointed to by s1. A null wide character in s1 and wide characters that follow it are not appended. The initial wide character of s2 overwrites the null wide character at the end of s1. A terminating wide null character is always appended to the result. The behavior of `wcsncat()`_ is undefined if copying takes place between objects that overlap.

wcslcat()
'''''''''

Description

Concatenate strings, limit length, always zero terminate (BSD).

Prototype

::

   size_t wcslcat(      char   * s1,
                  const char   * s2,
                        size_t   n);

Parameters

+-----------+-----------------------------------------------------------------------+
| Parameter | Description                                                           |
+===========+=======================================================================+
| s1        | Pointer to wide string to append to.                                  |
+-----------+-----------------------------------------------------------------------+
| s2        | Pointer to wide string to append.                                     |
+-----------+-----------------------------------------------------------------------+
| n         | Maximum number of characters, including terminating wide null, in s1. |
+-----------+-----------------------------------------------------------------------+

Return value

Returns the number of wide characters it tried to copy, which is the sum of the lengths of the wide strings s1 and s2 or n, whichever is smaller.

Additional information

Appends no more than n-strlen(s1}-1 wide characters pointed to by s2 into the array pointed to by s1 and always terminates the result with a wide null character if n is greater than zero. Both the wide strings s1 and s2 must be terminated with a wide null character on entry to `wcslcat()`_ and a character position for the terminating wide null should be included in n.

The behavior of `wcslcat()`_ is undefined if copying takes place between objects that overlap.

Notes

Commonly found in BSD libraries.

wcsdup()
''''''''

Description

Duplicate string (POSIX.1).

Prototype

::

   wchar_t *wcsdup(const wchar_t * s);

Parameters

+-----------------+----------------------------------------------------+
| Parameter       | Description                                        |
+=================+====================================================+
| s               | Pointer to wide string to duplicate.               |
+-----------------+----------------------------------------------------+

Return value

Returns a pointer to the new wide string or a null pointer if the new wide string cannot be created. The returned pointer can be passed to `free()`_.

Additional information

Duplicates the wide string pointed to by s by using `malloc()`_ to allocate memory for a copy of s and then copies s, including the terminating null, to that memory

Notes

Conforms to POSIX.1-2008 and SC22 TR 24731-2.

wcsndup()
'''''''''

Description

Duplicate string, limit length (GNU).

Prototype

::

   wchar_t *wcsndup(const wchar_t * s,
                          size_t    n);

Parameters

+-------------+--------------------------------------------------------+
| Parameter   | Description                                            |
+=============+========================================================+
| s           | Pointer to wide string to duplicate.                   |
+-------------+--------------------------------------------------------+
| n           | Maximum number of wide characters to duplicate.        |
+-------------+--------------------------------------------------------+

Return value

Returns a pointer to the new wide string or a null pointer if the new wide string cannot be created. The returned pointer can be passed to `free()`_.

Additional information

Duplicates at most n wide characters from the the string pointed to by s by using `malloc()`_ to allocate memory for a copy of s.

If the length of string pointed to by s is greater than n wide characters, only n wide characters will be duplicated. If n is greater than the length of the wide string pointed to by s, all characters in the string are copied into the allocated array including the terminating null character.

Notes

This is a GNU extension.

.. _comparison-functions-1:

Comparison functions
^^^^^^^^^^^^^^^^^^^^

+------------------+-------------------------------------------------------+
| Function         | Description                                           |
+==================+=======================================================+
| `wmemcmp()`_     | Compare memory.                                       |
+------------------+-------------------------------------------------------+
| `wcsncmp()`_     | Compare strings, limit length.                        |
+------------------+-------------------------------------------------------+
| `wcscasecmp()`_  | Compare strings, ignore case (POSIX.1).               |
+------------------+-------------------------------------------------------+
| `wcsncasecmp()`_ | Compare strings, ignore case, limit length (POSIX.1). |
+------------------+-------------------------------------------------------+

wmemcmp()
'''''''''

Description

Compare memory.

Prototype

::

   int wmemcmp(const wchar_t * s1,
               const wchar_t * s2,
                     size_t    n);

Parameters

+---------------+------------------------------------------------------+
| Parameter     | Description                                          |
+===============+======================================================+
| s1            | Pointer to object #1.                                |
+---------------+------------------------------------------------------+
| s2            | Pointer to object #2.                                |
+---------------+------------------------------------------------------+
| n             | Number of wide characters to compare.                |
+---------------+------------------------------------------------------+

Return value

+-----------+----------------------------------------------------------+
| < 0       | s1 is less than s2.                                      |
+-----------+----------------------------------------------------------+
| = 0       | s1 is equal to s2.                                       |
+-----------+----------------------------------------------------------+
| > 0       | s1 is greater than to s2.                                |
+-----------+----------------------------------------------------------+

Additional information

Compares the first n wide characters of the object pointed to by s1 to the first n wide characters of the object pointed to by s2. `wmemcmp()`_ returns an integer greater than, equal to, or less than zero as the object pointed to by s1 is greater than, equal to, or less than the object pointed to by s2.

wcsncmp()
'''''''''

Description

Compare strings, limit length.

Prototype

::

   int wcsncmp(const wchar_t * s1,
               const wchar_t * s2,
                     size_t    n);

Parameters

+-------------+--------------------------------------------------------+
| Parameter   | Description                                            |
+=============+========================================================+
| s1          | Pointer to wide string #1.                             |
+-------------+--------------------------------------------------------+
| s2          | Pointer to wide string #2.                             |
+-------------+--------------------------------------------------------+
| n           | Maximum number of wide characters to compare.          |
+-------------+--------------------------------------------------------+

Return value

Returns an integer greater than, equal to, or less than zero, if the possibly null-terminated array pointed to by s1 is greater than, equal to, or less than the possibly null-terminated array pointed to by s2.

Additional information

Compares not more than n wide characters from the array pointed to by s1 to the array pointed to by s2. Wide characters that follow a null wide character are not compared.

wcscasecmp()
''''''''''''

Description

Compare strings, ignore case (POSIX.1).

Prototype

::

   int wcscasecmp(const char * s1,
                  const char * s2);

Parameters

+---------------------+------------------------------------------------+
| Parameter           | Description                                    |
+=====================+================================================+
| s1                  | Pointer to wide string #1.                     |
+---------------------+------------------------------------------------+
| s2                  | Pointer to wide string #2.                     |
+---------------------+------------------------------------------------+

Return value

+-----------+----------------------------------------------------------+
| < 0       | s1 is less than s2.                                      |
+-----------+----------------------------------------------------------+
| = 0       | s1 is equal to s2.                                       |
+-----------+----------------------------------------------------------+
| > 0       | s1 is greater than to s2.                                |
+-----------+----------------------------------------------------------+

Additional information

Compares the wide string pointed to by s1 to the wide string pointed to by s2 ignoring differences in case.

`wcscasecmp()`_ returns an integer greater than, equal to, or less than zero if the wide string pointed to by s1 is greater than, equal to, or less than the wide string pointed to by s2.

Notes

Conforms to POSIX.1-2017.

wcsncasecmp()
'''''''''''''

Description

Compare strings, ignore case, limit length (POSIX.1).

Prototype

::

   int wcsncasecmp(const char   * s1,
                   const char   * s2,
                         size_t   n);

Parameters

+-------------+--------------------------------------------------------+
| Parameter   | Description                                            |
+=============+========================================================+
| s1          | Pointer to wide string #1.                             |
+-------------+--------------------------------------------------------+
| s2          | Pointer to wide string #2.                             |
+-------------+--------------------------------------------------------+
| n           | Maximum number of wide characters to compare.          |
+-------------+--------------------------------------------------------+

Return value

+-----------+----------------------------------------------------------+
| < 0       | s1 is less than s2.                                      |
+-----------+----------------------------------------------------------+
| = 0       | s1 is equal to s2.                                       |
+-----------+----------------------------------------------------------+
| > 0       | s1 is greater than to s2.                                |
+-----------+----------------------------------------------------------+

Additional information

Compares not more than n wide characters from the array pointed to by s1 to the array pointed to by s2 ignoring differences in case. Characters that follow a wide null character are not compared.

`strncasecmp()`_ returns an integer greater than, equal to, or less than zero, if the possibly null-terminated array pointed to by s1 is greater than, equal to, or less than the possibly null-terminated array pointed to by s2.

Notes

Conforms to POSIX.1-2017.

.. _search-functions-1:

Search functions
^^^^^^^^^^^^^^^^

+--------------+-------------------------------------------------------------+
| Function     | Description                                                 |
+==============+=============================================================+
| `wmemchr()`_ | Find character in memory, forward.                          |
+--------------+-------------------------------------------------------------+
| `wcschr()`_  | Find character within string, forward.                      |
+--------------+-------------------------------------------------------------+
| `wcsnchr()`_ | Find character within string, forward, limit length.        |
+--------------+-------------------------------------------------------------+
| `wcsrchr()`_ | Find character within string, reverse.                      |
+--------------+-------------------------------------------------------------+
| `wcslen()`_  | Calculate length of string.                                 |
+--------------+-------------------------------------------------------------+
| `wcsnlen()`_ | Calculate length of string, limit length (POSIX.1).         |
+--------------+-------------------------------------------------------------+
| `wcsstr()`_  | Find string within string, forward.                         |
+--------------+-------------------------------------------------------------+
| `wcsnstr()`_ | Find string within string, forward, limit length (BSD).     |
+--------------+-------------------------------------------------------------+
| `wcspbrk()`_ | Find first occurrence of characters within string.          |
+--------------+-------------------------------------------------------------+
| `wcsspn()`_  | Compute size of string prefixed by a set of characters.     |
+--------------+-------------------------------------------------------------+
| `wcscspn()`_ | Compute size of string not prefixed by a set of characters. |
+--------------+-------------------------------------------------------------+
| `wcstok()`_  | Break string into tokens.                                   |
+--------------+-------------------------------------------------------------+
| `wcssep()`_  | Break string into tokens (BSD).                             |
+--------------+-------------------------------------------------------------+

wmemchr()
'''''''''

Description

Find character in memory, forward.

Prototype

::

   wchar_t *wmemchr(const wchar_t * s,
                          wchar_t   c,
                          size_t    n);

Parameters

+-------------+--------------------------------------------------------+
| Parameter   | Description                                            |
+=============+========================================================+
| s           | Pointer to object to search.                           |
+-------------+--------------------------------------------------------+
| c           | Wide character to search for.                          |
+-------------+--------------------------------------------------------+
| n           | Number of wide characters in object to search.         |
+-------------+--------------------------------------------------------+

Return value

+------------+---------------------------------------------------------+
| = NULL     | c does not occur in the object.                         |
+------------+---------------------------------------------------------+
| ≠ NULL     | Pointer to the located wide character.                  |
+------------+---------------------------------------------------------+

Additional information

Locates the first occurrence of c in the initial n wide characters of the object pointed to by s. Unlike `wcschr()`_, `wmemchr()`_ does not terminate a search when a null wide character is found in the object pointed to by s.

wcschr()
''''''''

Description

Find character within string, forward.

Prototype

::

   wchar_t *wcschr(const wchar_t * s,
                         wchar_t   c);

Parameters

+-------------------+--------------------------------------------------+
| Parameter         | Description                                      |
+===================+==================================================+
| s                 | Wide string to search.                           |
+-------------------+--------------------------------------------------+
| c                 | Wide character to search for.                    |
+-------------------+--------------------------------------------------+

Return value

Returns a pointer to the located wide character, or a null pointer if c does not occur in the wide string.

Additional information

Locates the first occurrence of c in the wide string pointed to by s. The terminating wide null character is considered to be part of the string.

wcsnchr()
'''''''''

Description

Find character within string, forward, limit length.

Prototype

::

   wchar_t *wcsnchr(const wchar_t * s,
                          size_t    n,
                          wchar_t   c);

Parameters

+----------------+-----------------------------------------------------+
| Parameter      | Description                                         |
+================+=====================================================+
| s              | Pointer to wide string to search.                   |
+----------------+-----------------------------------------------------+
| n              | Number of wide characters to search.                |
+----------------+-----------------------------------------------------+
| c              | Wide character to search for.                       |
+----------------+-----------------------------------------------------+

Return value

Returns a pointer to the located wide character, or a null pointer if c does not occur in the string.

Additional information

Searches not more than n wide characters to locate the first occurrence of c in the wide string pointed to by s. The terminating wide null character is considered to be part of the wide string.

wcsrchr()
'''''''''

Description

Find character within string, reverse.

Prototype

::

   wchar_t *wcsrchr(const wchar_t * s,
                          wchar_t   c);

Parameters

+------------------+---------------------------------------------------+
| Parameter        | Description                                       |
+==================+===================================================+
| s                | Pointer to wide string to search.                 |
+------------------+---------------------------------------------------+
| c                | Wide character to search for.                     |
+------------------+---------------------------------------------------+

Return value

Returns a pointer to the located wide character, or a null pointer if c does not occur in the string.

Additional information

Locates the last occurrence of c in the wide string pointed to by s. The terminating wide null character is considered to be part of the string.

wcslen()
''''''''

Description

Calculate length of string.

Prototype

::

   size_t wcslen(const wchar_t * s);

Parameters

+---------------+------------------------------------------------------+
| Parameter     | Description                                          |
+===============+======================================================+
| s             | Pointer to zero-terminated wide string.              |
+---------------+------------------------------------------------------+

Return value

Returns the length of the wide string pointed to by s, that is the number of wide characters that precede the terminating wide null character.

wcsnlen()
'''''''''

Description

Calculate length of string, limit length (POSIX.1).

Prototype

::

   size_t wcsnlen(const wchar_t * s,
                        size_t    n);

Parameters

+-------------+--------------------------------------------------------+
| Parameter   | Description                                            |
+=============+========================================================+
| s           | Pointer to wide string.                                |
+-------------+--------------------------------------------------------+
| n           | Maximum number of wide characters to examine.          |
+-------------+--------------------------------------------------------+

Return value

Returns the length of the wide string pointed to by s, up to a maximum of n wide characters. `wcsnlen()`_ only examines the first n wide characters of the string s.

Notes

Conforms to POSIX.1-2008.

wcsstr()
''''''''

Description

Find string within string, forward.

Prototype

::

   wchar_t *wcsstr(const wchar_t * s1,
                   const wchar_t * s2);

Parameters

+-----------------+----------------------------------------------------+
| Parameter       | Description                                        |
+=================+====================================================+
| s1              | Pointer to wide string to search.                  |
+-----------------+----------------------------------------------------+
| s2              | Pointer to wide string to search for.              |
+-----------------+----------------------------------------------------+

Return value

Returns a pointer to the located wide string, or a null pointer if the wide string is not found. If s2 points to a wide string with zero length, `wcsstr()`_ returns s1.

Additional information

Locates the first occurrence in the wide string pointed to by s1 of the sequence of wide characters (excluding the terminating null wide character) in the wide string pointed to by s2.

wcsnstr()
'''''''''

Description

Find string within string, forward, limit length (BSD).

Prototype

::

   wchar_t *wcsnstr(const wchar_t * s1,
                    const wchar_t * s2,
                          size_t    n);

Parameters

+--------------+-------------------------------------------------------+
| Parameter    | Description                                           |
+==============+=======================================================+
| s1           | Pointer to wide string to search.                     |
+--------------+-------------------------------------------------------+
| s2           | Pointer to wide string to search for.                 |
+--------------+-------------------------------------------------------+
| n            | Maximum number of characters to search for.           |
+--------------+-------------------------------------------------------+

Return value

Returns a pointer to the located wide string, or a null pointer if the wide string is not found. If s2 points to a wide string with zero length, `wcsnstr()`_ returns s1.

Additional information

Searches at most n wide characters to locate the first occurrence in the wide string pointed to by s1 of the sequence of wide characters (excluding the terminating wide null character) in the string pointed to by s2.

Notes

Commonly found in Linux and BSD C libraries.

wcspbrk()
'''''''''

Description

Find first occurrence of characters within string.

Prototype

::

   wchar_t *wcspbrk(const wchar_t * s1,
                    const wchar_t * s2);

Parameters

+-----------------+----------------------------------------------------+
| Parameter       | Description                                        |
+=================+====================================================+
| s1              | Pointer to wide string to search.                  |
+-----------------+----------------------------------------------------+
| s2              | Pointer to wide string to search for.              |
+-----------------+----------------------------------------------------+

Return value

Returns a pointer to the first wide character, or a null pointer if no wide character from s2 occurs in s1.

Additional information

Locates the first occurrence in the wide string pointed to by s1 of any wide character from the string pointed to by s2.

wcsspn()
''''''''

Description

Compute size of string prefixed by a set of characters.

Prototype

::

   size_t wcsspn(const wchar_t * s1,
                 const wchar_t * s2);

Parameters

+------------+---------------------------------------------------------+
| Parameter  | Description                                             |
+============+=========================================================+
| s1         | Pointer to zero-terminated wide string to search.       |
+------------+---------------------------------------------------------+
| s2         | Pointer to zero-terminated acceptable-set wide string.  |
+------------+---------------------------------------------------------+

Return value

Returns the length of the wide string pointed to by s1 which consists entirely of wide characters from the wide string pointed to by s2

Additional information

Computes the length of the maximum initial segment of the wide string pointed to by s1 which consists entirely of wide characters from the string pointed to by s2.

wcscspn()
'''''''''

Description

Compute size of string not prefixed by a set of characters.

Prototype

::

   size_t wcscspn(const wchar_t * s1,
                  const wchar_t * s2);

Parameters

+------------+---------------------------------------------------------+
| Parameter  | Description                                             |
+============+=========================================================+
| s1         | Pointer to wide string to search.                       |
+------------+---------------------------------------------------------+
| s2         | Pointer to wide string containing characters to skip.   |
+------------+---------------------------------------------------------+

Return value

Returns the length of the segment of wide string s1 prefixed by wide characters from s2.

Additional information

Computes the length of the maximum initial segment of the wide string pointed to by s1 which consists entirely of wide characters not from the wide string pointed to by s2.

wcstok()
''''''''

Description

Break string into tokens.

Prototype

::

   wchar_t *wcstok(      wchar_t  * s1,
                   const wchar_t  * s2,
                         wchar_t ** ptr);

Parameters

+-------------+--------------------------------------------------------+
| Parameter   | Description                                            |
+=============+========================================================+
| s1          | Pointer to zero-terminated wide string to parse.       |
+-------------+--------------------------------------------------------+
| s2          | Pointer to zero-terminated set of separators.          |
+-------------+--------------------------------------------------------+
| ptr         | Pointer to object that maintains parse state.          |
+-------------+--------------------------------------------------------+

Return value

NULL if no further tokens else a pointer to the next token.

Additional information

A sequence of calls to `wcstok()`_ breaks the wide string pointed to by s1 into a sequence of tokens, each of which is delimited by a wide character from the wide string pointed to by s2. The first call in the sequence has a non-null first argument; subsequent calls in the sequence have a null first argument. The separator wide string pointed to by s2 may be different from call to call.

The first call in the sequence searches the wide string pointed to by s1 for the wide first character that is not contained in the current separator wide string pointed to by s2. If no such wide character is found, then there are no tokens in the string pointed to by s1 and `wcstok()`_ returns a null pointer. If such a wide character is found, it is the start of the first token.

`wcstok()`_ then searches from there for a wide character that is contained in the current separator wide string. If no such wide character is found, the current token extends to the end of the wide string pointed to by s1, and subsequent searches for a token will return a null pointer. If such a wide character is found, it is overwritten by a null wide character, which terminates the current token. `wcstok()`_ saves a pointer to the following wide character, from which the next search for a token will start.

Each subsequent call, with a null pointer as the value of the first argument, starts searching from the saved pointer and behaves as described above.

See also

`wcssep()`_.

wcssep()
''''''''

Description

Break string into tokens (BSD).

Prototype

::

   wchar_t *wcssep(      wchar_t ** stringp,
                   const wchar_t  * delim);

Parameters

+-------------+--------------------------------------------------------+
| Parameter   | Description                                            |
+=============+========================================================+
| stringp     | Pointer to pointer to zero-terminated wide string.     |
+-------------+--------------------------------------------------------+
| delim       | Pointer to delimiter set wide string.                  |
+-------------+--------------------------------------------------------+

Return value

See below.

Additional information

Locates, in the wide string referenced by \*stringp, the first occurrence of any wide character in the wide string delim (or the terminating null character) and replaces it with a null wide character. The location of the next wide character after the delimiter wide character (or NULL, if the end of the wide string was reached) is stored in \*stringp. The original value of \*stringp is returned.

An empty field (that is, a wide character in the string delim occurs as the first character of \*stringp) can be detected by comparing the location referenced by the returned pointer to the null wide character.

If \*stringp is initially null, `wcssep()`_ returns null.

Notes

Commonly found in Linux and BSD C libraries.

Multi-byte/wide string conversion functions
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

+------------------+------------------------------------------------------------------------------------+
| Function         | Description                                                                        |
+==================+====================================================================================+
| `mbsinit()`_     | Query initial conversion state.                                                    |
+------------------+------------------------------------------------------------------------------------+
| `mbrlen()`_      | Count number of bytes in multi-byte character, restartable.                        |
+------------------+------------------------------------------------------------------------------------+
| `mbrlen_l()`_    | Count number of bytes in multi-byte character, restartable, per locale (POSIX.1).  |
+------------------+------------------------------------------------------------------------------------+
| `mbrtowc()`_     | Convert multi-byte character to wide character, restartable.                       |
+------------------+------------------------------------------------------------------------------------+
| `mbrtowc_l()`_   | Convert multi-byte character to wide character, restartable, per locale (POSIX.1). |
+------------------+------------------------------------------------------------------------------------+
| `wctob()`_       | Convert wide character to single-byte character.                                   |
+------------------+------------------------------------------------------------------------------------+
| `wctob_l()`_     | Convert wide character to single-byte character, per locale (POSIX.1).             |
+------------------+------------------------------------------------------------------------------------+
| `wcrtomb()`_     | Convert wide character to multi-byte character, restartable.                       |
+------------------+------------------------------------------------------------------------------------+
| `wcrtomb_l()`_   | Convert wide character to multi-byte character, restartable, per locale (POSIX.1). |
+------------------+------------------------------------------------------------------------------------+
| `wcsrtombs()`_   | Convert wide string to multi-byte string, restartable.                             |
+------------------+------------------------------------------------------------------------------------+
| `wcsrtombs_l()`_ | Convert wide string to multi-byte string, restartable (POSIX.1).                   |
+------------------+------------------------------------------------------------------------------------+

mbsinit()
'''''''''

Description

Query initial conversion state.

Prototype

::

   int mbsinit(const mbstate_t * ps);

Parameters

+--------------------+-------------------------------------------------+
| Parameter          | Description                                     |
+====================+=================================================+
| ps                 | Pointer to conversion state.                    |
+--------------------+-------------------------------------------------+

Return value

Returns nonzero (true) if ps is a null pointer or if the pointed-to object describes an initial conversion state; otherwise, returns zero.

mbrlen()
''''''''

Description

Count number of bytes in multi-byte character, restartable.

Prototype

::

   size_t mbrlen(const char      * s,
                       size_t      n,
                       mbstate_t * ps);

Parameters

+----------------+-----------------------------------------------------+
| Parameter      | Description                                         |
+================+=====================================================+
| s              | Pointer to multi-byte character.                    |
+----------------+-----------------------------------------------------+
| n              | Maximum number of bytes to examine.                 |
+----------------+-----------------------------------------------------+
| ps             | Pointer to multi-byte conversion state.             |
+----------------+-----------------------------------------------------+

Return value

Number of bytes in multi-byte character.

Additional information

Determines the number of bytes contained in the multi-byte character pointed to by s in the current locale.

Except that except that the expression designated by ps is evaluated only once, this function is equivalent to the call:

::

   mbrtowc(NULL, s, n, ps != NULL ? ps : &internal); 

where internal is the mbstate_t object for the `mbrlen()`_ function.

See also

`mbrlen_l()`_, `mbrtowc()`_

mbrlen_l()
''''''''''

Description

Count number of bytes in multi-byte character, restartable, per locale (POSIX.1).

Prototype

::

   size_t mbrlen_l(const char      * s,
                         size_t      n,
                         mbstate_t * ps,
                                     locale_t loc);

Parameters

+----------------+-----------------------------------------------------+
| Parameter      | Description                                         |
+================+=====================================================+
| s              | Pointer to multi-byte character.                    |
+----------------+-----------------------------------------------------+
| n              | Maximum number of bytes to examine.                 |
+----------------+-----------------------------------------------------+
| ps             | Pointer to multi-byte conversion state.             |
+----------------+-----------------------------------------------------+
| loc            | Locale used for conversion.                         |
+----------------+-----------------------------------------------------+

Return value

Number of bytes in multi-byte character.

Additional information

Determines the number of bytes contained in the multi-byte character pointed to by s in the locale loc.

Except that except that the expression designated by ps is evaluated only once, this function is equivalent to the call:

::

   mbrtowc_l(NULL, s, n, ps != NULL ? ps : &internal, loc); 

where internal is the mbstate_t object for the `mbrlen()`_ function,

Notes

Conforms to POSIX.1-2008.

See also

`mbrlen_l()`_, `mbrtowc()`_

mbrtowc()
'''''''''

Description

Convert multi-byte character to wide character, restartable.

Prototype

::

   size_t mbrtowc(      wchar_t   * pwc,
                  const char      * s,
                        size_t      n,
                        mbstate_t * ps);

Parameters

+-------------+--------------------------------------------------------+
| Parameter   | Description                                            |
+=============+========================================================+
| pwc         | Pointer to object that receives the wide character.    |
+-------------+--------------------------------------------------------+
| s           | Pointer to multi-byte character string.                |
+-------------+--------------------------------------------------------+
| n           | Maximum number of bytes that will be examined.         |
+-------------+--------------------------------------------------------+
| ps          | Pointer to multi-byte conversion state.                |
+-------------+--------------------------------------------------------+

Return value

If s is a null pointer, `mbrtowc()`_ is equivalent to mbrtowc(NULL, “”, 1, ps), ignoring pwc and n.

If s is not null and the object that s points to is a wide null character, `mbrtowc()`_ returns 0.

If s is not null and the object that s points to forms a valid multi-byte character in the current locale with a most n bytes, `mbrtowc()`_ returns the length in bytes of the multi-byte character and stores that wide character to the object pointed to by pwc (if pwc is not null).

If the object that s points to forms an incomplete, but possibly valid, multi-byte character, `mbrtowc()`_ returns -2.

If the object that s points to does not form a partial multi-byte character, `mbrtowc()`_ returns -1.

Additional information

Converts a single multi-byte character to a wide character in the current locale.

See also

`mbtowc()`_, `mbrtowc_l()`_

mbrtowc_l()
'''''''''''

Description

Convert multi-byte character to wide character, restartable, per locale (POSIX.1).

Prototype

::

   size_t mbrtowc_l(      wchar_t   * pwc,
                    const char      * s,
                          size_t      n,
                          mbstate_t * ps,
                                      locale_t loc);

Parameters

+-------------+--------------------------------------------------------+
| Parameter   | Description                                            |
+=============+========================================================+
| pwc         | Pointer to object that receives the wide character.    |
+-------------+--------------------------------------------------------+
| s           | Pointer to multi-byte character string.                |
+-------------+--------------------------------------------------------+
| n           | Maximum number of bytes that will be examined.         |
+-------------+--------------------------------------------------------+
| ps          | Pointer to multi-byte conversion state.                |
+-------------+--------------------------------------------------------+
| loc         | Locale used for conversion.                            |
+-------------+--------------------------------------------------------+

Return value

If s is a null pointer, `mbrtowc()`_ is equivalent to mbrtowc(NULL, “”, 1, ps), ignoring pwc and n.

If s is not null and the object that s points to is a wide null character, `mbrtowc()`_ returns 0.

If s is not null and the object that s points to forms a valid multi-byte character in the locale loc with a most n bytes, `mbrtowc()`_ returns the length in bytes of the multi-byte character and stores that wide character to the object pointed to by pwc (if pwc is not null).

If the object that s points to forms an incomplete, but possibly valid, multi-byte character, `mbrtowc()`_ returns -2.

If the object that s points to does not form a partial multi-byte character, `mbrtowc()`_ returns -1.

Additional information

Converts a single multi-byte character to a wide character in the locale loc.

Notes

Conforms to POSIX.1-2008.

See also

`mbtowc()`_, `mbrtowc_l()`_

wctob()
'''''''

Description

Convert wide character to single-byte character.

Prototype

::

   int wctob(wint_t c);

Parameters

+------------------------+---------------------------------------------+
| Parameter              | Description                                 |
+========================+=============================================+
| c                      | Character to convert.                       |
+------------------------+---------------------------------------------+

Return value

Returns EOF if c does not correspond to a multi-byte character with length one in the initial shift state in the current locale. Otherwise, it returns the single-byte representation of that character as an unsigned char converted to an int.

Additional information

Determines whether c corresponds to a member of the extended character set whose multi-byte character representation is a single byte in the current locale when in the initial shift state.

wctob_l()
'''''''''

Description

Convert wide character to single-byte character, per locale (POSIX.1).

Prototype

::

   int wctob_l(wint_t c,
                      locale_t loc);

Parameters

+--------------------+-------------------------------------------------+
| Parameter          | Description                                     |
+====================+=================================================+
| c                  | Character to convert.                           |
+--------------------+-------------------------------------------------+
| loc                | Locale used for conversion.                     |
+--------------------+-------------------------------------------------+

Return value

Returns EOF if c does not correspond to a multi-byte character with length one in the initial shift state in the locale loc. Otherwise, it returns the single-byte representation of that character as an unsigned char converted to an int.

Additional information

Determines whether c corresponds to a member of the extended character set whose multi-byte character representation is a single byte in the locale loc when in the initial shift state.

wcrtomb()
'''''''''

Description

Convert wide character to multi-byte character, restartable.

Prototype

::

   size_t wcrtomb(char      * s,
                              wchar_t wc,
                  mbstate_t * ps);

Parameters

+------------+----------------------------------------------------------+
| Parameter  | Description                                              |
+============+==========================================================+
| s          | Pointer to array that receives the multi-byte character. |
+------------+----------------------------------------------------------+
| wc         | Wide character to convert.                               |
+------------+----------------------------------------------------------+
| ps         | Pointer to multi-byte conversion state.                  |
+------------+----------------------------------------------------------+

Return value

Returns the number of bytes stored in the array object. When wc is not a valid wide character, an encoding error occurs: `wcrtomb()`_ stores the value of the macro EILSEQ in errno and returns (`size_t`_)(-1); the conversion state is unspecified.

Additional information

If s is a null pointer, `wcrtomb()`_ is equivalent to the call wcrtomb(buf, 0, ps) where buf is an internal buffer.

If s is not a null pointer, `wcrtomb()`_ determines the number of bytes needed to represent the multi-byte character that corresponds to the wide character given by wc in the locale loc, and stores the multi-byte character representation in the array whose first element is pointed to by s. At most MB_CUR_MAX bytes are stored. If wc is a null wide character, a null byte is stored; the resulting state described is the initial conversion state.

wcrtomb_l()
'''''''''''

Description

Convert wide character to multi-byte character, restartable, per locale (POSIX.1).

Prototype

::

   size_t wcrtomb_l(char      * s,
                                wchar_t wc,
                    mbstate_t * ps,
                                locale_t loc);

Parameters

+------------+----------------------------------------------------------+
| Parameter  | Description                                              |
+============+==========================================================+
| s          | Pointer to array that receives the multi-byte character. |
+------------+----------------------------------------------------------+
| wc         | Wide character to convert.                               |
+------------+----------------------------------------------------------+
| ps         | Pointer to multi-byte conversion state.                  |
+------------+----------------------------------------------------------+
| loc        | Locale used for conversion.                              |
+------------+----------------------------------------------------------+

Return value

Returns the number of bytes stored in the array object. When wc is not a valid wide character, an encoding error occurs: `wcrtomb_l()`_ stores the value of the macro EILSEQ in errno and returns (`size_t`_)(-1); the conversion state is unspecified.

Additional information

If s is a null pointer, `wcrtomb()`_ is equivalent to the call wcrtomb(buf, 0, ps) where buf is an internal buffer.

If s is not a null pointer, `wcrtomb()`_ determines the number of bytes needed to represent the multi-byte character that corresponds to the wide character given by wc in the current locale, and stores the multi-byte character representation in the array whose first element is pointed to by s. At most MB_CUR_MAX bytes are stored. If wc is a null wide character, a null byte is stored; the resulting state described is the initial conversion state.

wcsrtombs()
'''''''''''

Description

Convert wide string to multi-byte string, restartable.

Prototype

::

   size_t wcsrtombs(      char       * dst,
                    const wchar_t   ** src,
                          size_t       len,
                          mbstate_t  * ps);

Parameters

+-----------+--------------------------------------------------------------------+
| Parameter | Description                                                        |
+===========+====================================================================+
| dst       | Pointer to array that receives the multi-byte string.              |
+-----------+--------------------------------------------------------------------+
| src       | Indirect pointer to wide character string being converted.         |
+-----------+--------------------------------------------------------------------+
| len       | Maximum number of bytes to write into the array pointed to by dst. |
+-----------+--------------------------------------------------------------------+
| ps        | Pointer to multi-byte conversion state.                            |
+-----------+--------------------------------------------------------------------+

Return value

If conversion stops because a wide character is reached that does not correspond to a valid multi-byte character, an encoding error occurs: `wcsrtombs()`_ stores the value of the macro EILSEQ in errno and returns (`size_t`_)(-1); the conversion state is unspecified. Otherwise, it returns the number of bytes in the resulting multi-byte character sequence, not including the terminating null character (if any).

Additional information

Converts a sequence of wide characters in the current locale from the array indirectly pointed to by src into a sequence of corresponding multi-byte characters that begins in the conversion state described by the object pointed to by ps. If dst is not a null pointer, the converted characters are then stored into the array pointed to by dst. Conversion continues up to and including a terminating null wide character, which is also stored.

Conversion stops earlier in two cases: when a wide character is reached that does not correspond to a valid multi-byte character, or (if dst is not a null pointer) when the next multi-byte character would exceed the limit of len total bytes to be stored into the array pointed to by dst. Each conversion takes place as if by a call to `wcrtomb()`_.

If dst is not a null pointer, the pointer object pointed to by src is assigned either a null pointer (if conversion stopped due to reaching a terminating null wide character) or the address just past the last wide character converted (if any). If conversion stopped due to reaching a terminating null wide character, the resulting state described is the initial conversion state.

wcsrtombs_l()
'''''''''''''

Description

Convert wide string to multi-byte string, restartable (POSIX.1).

Prototype

::

   size_t wcsrtombs_l(      char       * dst,
                      const wchar_t   ** src,
                            size_t       len,
                            mbstate_t  * ps,
                                         locale_t loc);

Parameters

+-----------+--------------------------------------------------------------------+
| Parameter | Description                                                        |
+===========+====================================================================+
| dst       | Pointer to array that receives the multi-byte string.              |
+-----------+--------------------------------------------------------------------+
| src       | Indirect pointer to wide character string being converted.         |
+-----------+--------------------------------------------------------------------+
| len       | Maximum number of bytes to write into the array pointed to by dst. |
+-----------+--------------------------------------------------------------------+
| ps        | Pointer to multi-byte conversion state.                            |
+-----------+--------------------------------------------------------------------+
| loc       | Locale used for conversion.                                        |
+-----------+--------------------------------------------------------------------+

Return value

If conversion stops because a wide character is reached that does not correspond to a valid multi-byte character, an encoding error occurs: `wcsrtombs()`_ stores the value of the macro EILSEQ in errno and returns (`size_t`_)(-1); the conversion state is unspecified. Otherwise, it returns the number of bytes in the resulting multi-byte character sequence, not including the terminating null character (if any).

Additional information

Converts a sequence of wide characters in the locale loc from the array indirectly pointed to by src into a sequence of corresponding multi-byte characters that begins in the conversion state described by the object pointed to by ps. If dst is not a null pointer, the converted characters are then stored into the array pointed to by dst. Conversion continues up to and including a terminating null wide character, which is also stored.

Conversion stops earlier in two cases: when a wide character is reached that does not correspond to a valid multi-byte character, or (if dst is not a null pointer) when the next multi-byte character would exceed the limit of len total bytes to be stored into the array pointed to by dst. Each conversion takes place as if by a call to `wcrtomb_l()`_.

If dst is not a null pointer, the pointer object pointed to by src is assigned either a null pointer (if conversion stopped due to reaching a terminating null wide character) or the address just past the last wide character converted (if any). If conversion stopped due to reaching a terminating null wide character, the resulting state described is the initial conversion state.

Notes

Conforms to POSIX.1-2008.

<wctype.h>
~~~~~~~~~~

.. _classification-functions-1:

Classification functions
^^^^^^^^^^^^^^^^^^^^^^^^

+------------------+-------------------------------------------------------------+
| Function         | Description                                                 |
+==================+=============================================================+
| `iswcntrl()`_    | Is character a control?                                     |
+------------------+-------------------------------------------------------------+
| `iswcntrl_l()`_  | Is character a control, per locale? (POSIX.1).              |
+------------------+-------------------------------------------------------------+
| `iswblank()`_    | Is character a blank?                                       |
+------------------+-------------------------------------------------------------+
| `iswblank_l()`_  | Is character a blank, per locale? (POSIX.1).                |
+------------------+-------------------------------------------------------------+
| `iswspace()`_    | Is character a whitespace character?                        |
+------------------+-------------------------------------------------------------+
| `iswspace_l()`_  | Is character a whitespace character, per locale? (POSIX.1). |
+------------------+-------------------------------------------------------------+
| `iswpunct()`_    | Is character a punctuation mark?                            |
+------------------+-------------------------------------------------------------+
| `iswpunct_l()`_  | Is character a punctuation mark, per locale? (POSIX.1).     |
+------------------+-------------------------------------------------------------+
| `iswdigit()`_    | Is character a decimal digit?                               |
+------------------+-------------------------------------------------------------+
| `iswdigit_l()`_  | Is character a decimal digit, per locale? (POSIX.           |
+------------------+-------------------------------------------------------------+
| `iswxdigit()`_   | Is character a hexadecimal digit?                           |
+------------------+-------------------------------------------------------------+
| `iswxdigit_l()`_ | Is character a hexadecimal digit, per locale? (POSIX.1).    |
+------------------+-------------------------------------------------------------+
| `iswalpha()`_    | Is character alphabetic?                                    |
+------------------+-------------------------------------------------------------+
| `iswalpha_l()`_  | Is character alphabetic, per locale? (POSIX.1).             |
+------------------+-------------------------------------------------------------+
| `iswalnum()`_    | Is character alphanumeric?                                  |
+------------------+-------------------------------------------------------------+
| `iswalnum_l()`_  | Is character alphanumeric, per locale? (POSIX.1).           |
+------------------+-------------------------------------------------------------+
| `iswupper()`_    | Is character an uppercase letter?                           |
+------------------+-------------------------------------------------------------+
| `iswupper_l()`_  | Is character an uppercase letter, per locale? (POSIX.1).    |
+------------------+-------------------------------------------------------------+
| `iswlower()`_    | Is character a lowercase letter?                            |
+------------------+-------------------------------------------------------------+
| `iswlower_l()`_  | Is character a lowercase letter, per locale? (POSIX.1).     |
+------------------+-------------------------------------------------------------+
| `iswprint()`_    | Is character printable?                                     |
+------------------+-------------------------------------------------------------+
| `iswprint_l()`_  | Is character printable, per locale? (POSIX.1).              |
+------------------+-------------------------------------------------------------+
| `iswgraph()`_    | Is character any printing character?                        |
+------------------+-------------------------------------------------------------+
| `iswgraph_l()`_  | Is character any printing character, per locale? (POSIX.1). |
+------------------+-------------------------------------------------------------+
| `iswctype()`_    | Construct character mapping.                                |
+------------------+-------------------------------------------------------------+
| `iswctype_l()`_  | Construct character mapping, per locale (POSIX.1).          |
+------------------+-------------------------------------------------------------+
| `wctype()`_      | Construct character class.                                  |
+------------------+-------------------------------------------------------------+

iswcntrl()
''''''''''

Description

Is character a control?

Prototype

::

   int iswcntrl(wint_t c);

Parameters

+-----------------------+----------------------------------------------+
| Parameter             | Description                                  |
+=======================+==============================================+
| c                     | Wide character to test.                      |
+-----------------------+----------------------------------------------+

Return value

Returns nonzero (true) if and only if the value of the argument c is a control character in the current locale.

iswcntrl_l()
''''''''''''

Description

Is character a control, per locale? (POSIX.1).

Prototype

::

   int iswcntrl_l(wint_t c,
                         locale_t loc);

Parameters

+-----------------------+----------------------------------------------+
| Parameter             | Description                                  |
+=======================+==============================================+
| c                     | Wide character to test.                      |
+-----------------------+----------------------------------------------+
| loc                   | Locale used to test c.                       |
+-----------------------+----------------------------------------------+

Return value

Returns nonzero (true) if and only if the value of the argument c is a control character in the locale loc.

Notes

Conforms to POSIX.1-2017.

iswblank()
''''''''''

Description

Is character a blank?

Prototype

::

   int iswblank(wint_t c);

Parameters

+-----------------------+----------------------------------------------+
| Parameter             | Description                                  |
+=======================+==============================================+
| c                     | Wide character to test.                      |
+-----------------------+----------------------------------------------+

Return value

Returns nonzero (true) if and only if the value of the argument c is either a space character or tab character in the current locale.

iswblank_l()
''''''''''''

Description

Is character a blank, per locale? (POSIX.1).

Prototype

::

   int iswblank_l(wint_t c,
                         locale_t loc);

Parameters

+-----------------------+----------------------------------------------+
| Parameter             | Description                                  |
+=======================+==============================================+
| c                     | Wide character to test.                      |
+-----------------------+----------------------------------------------+
| loc                   | Locale used to test c.                       |
+-----------------------+----------------------------------------------+

Return value

Returns nonzero (true) if and only if the value of the argument c is either a space character or the tab character in locale loc.

Notes

Conforms to POSIX.1-2017.

iswspace()
''''''''''

Description

Is character a whitespace character?

Prototype

::

   int iswspace(wint_t c);

Parameters

+-----------------------+----------------------------------------------+
| Parameter             | Description                                  |
+=======================+==============================================+
| c                     | Wide character to test.                      |
+-----------------------+----------------------------------------------+

Return value

Returns nonzero (true) if and only if the value of the argument c is a standard white-space character in the current locale. The standard white-space characters are space, form feed, new-line, carriage return, horizontal tab, and vertical tab.

iswspace_l()
''''''''''''

Description

Is character a whitespace character, per locale? (POSIX.1).

Prototype

::

   int iswspace_l(wint_t c,
                         locale_t loc);

Parameters

+-----------------------+----------------------------------------------+
| Parameter             | Description                                  |
+=======================+==============================================+
| c                     | Wide character to test.                      |
+-----------------------+----------------------------------------------+
| loc                   | Locale used to test c.                       |
+-----------------------+----------------------------------------------+

Return value

Returns nonzero (true) if and only if the value of the argument c is a standard white-space character in the locale loc.

Notes

Conforms to POSIX.1-2017.

iswpunct()
''''''''''

Description

Is character a punctuation mark?

Prototype

::

   int iswpunct(wint_t c);

Parameters

+-----------------------+----------------------------------------------+
| Parameter             | Description                                  |
+=======================+==============================================+
| c                     | Wide character to test.                      |
+-----------------------+----------------------------------------------+

Return value

Returns nonzero (true) for every printing character for which neither `isspace()`_ nor `isalnum()`_ is true in the current locale.

iswpunct_l()
''''''''''''

Description

Is character a punctuation mark, per locale? (POSIX.1).

Prototype

::

   int iswpunct_l(wint_t c,
                         locale_t loc);

Parameters

+-----------------------+----------------------------------------------+
| Parameter             | Description                                  |
+=======================+==============================================+
| c                     | Wide character to test.                      |
+-----------------------+----------------------------------------------+
| loc                   | Locale used to test c.                       |
+-----------------------+----------------------------------------------+

Return value

Returns nonzero (true) for every printing character for which neither `isspace()`_ nor `isalnum()`_ is true in the locale loc.

Notes

Conforms to POSIX.1-2017.

iswdigit()
''''''''''

Description

Is character a decimal digit?

Prototype

::

   int iswdigit(wint_t c);

Parameters

+-----------------------+----------------------------------------------+
| Parameter             | Description                                  |
+=======================+==============================================+
| c                     | Wide character to test.                      |
+-----------------------+----------------------------------------------+

Return value

Returns nonzero (true) if and only if the value of the argument c is a digit in the current locale.

iswdigit_l()
''''''''''''

Description

Is character a decimal digit, per locale? (POSIX.1)

Prototype

::

   int iswdigit_l(wint_t c,
                         locale_t loc);

Parameters

+-----------------------+----------------------------------------------+
| Parameter             | Description                                  |
+=======================+==============================================+
| c                     | Wide character to test.                      |
+-----------------------+----------------------------------------------+
| loc                   | Locale used to test c.                       |
+-----------------------+----------------------------------------------+

Return value

Returns nonzero (true) if and only if the value of the argument c is a digit in the locale loc.

Notes

Conforms to POSIX.1-2017.

iswxdigit()
'''''''''''

Description

Is character a hexadecimal digit?

Prototype

::

   int iswxdigit(wint_t c);

Parameters

+-----------------------+----------------------------------------------+
| Parameter             | Description                                  |
+=======================+==============================================+
| c                     | Wide character to test.                      |
+-----------------------+----------------------------------------------+

Return value

Returns nonzero (true) if and only if the value of the argument c is a hexadecimal digit in the current locale.

iswxdigit_l()
'''''''''''''

Description

Is character a hexadecimal digit, per locale? (POSIX.1).

Prototype

::

   int iswxdigit_l(wint_t c,
                          locale_t loc);

Parameters

+-----------------------+----------------------------------------------+
| Parameter             | Description                                  |
+=======================+==============================================+
| c                     | Wide character to test.                      |
+-----------------------+----------------------------------------------+
| loc                   | Locale used to test c.                       |
+-----------------------+----------------------------------------------+

Return value

Returns nonzero (true) if and only if the value of the argument c is a hexadecimal digit in the current locale.

Notes

Conforms to POSIX.1-2017.

iswalpha()
''''''''''

Description

Is character alphabetic?

Prototype

::

   int iswalpha(wint_t c);

Parameters

+-----------------------+----------------------------------------------+
| Parameter             | Description                                  |
+=======================+==============================================+
| c                     | Wide character to test.                      |
+-----------------------+----------------------------------------------+

Return value

Returns true if the character c is alphabetic in the current locale. That is, any character for which `iswupper()`_ or `iswlower()`_ returns true is considered alphabetic in addition to any of the locale-specific set of alphabetic characters for which none of `iswcntrl()`_, `iswdigit()`_, `iswpunct()`_, or `isspace()`_ is true.

In the C locale, `isalpha()`_ returns nonzero (true) if and only if `isupper()`_ or `islower()`_ return true for value of the argument c.

iswalpha_l()
''''''''''''

Description

Is character alphabetic, per locale? (POSIX.1).

Prototype

::

   int iswalpha_l(wint_t c,
                         locale_t loc);

Parameters

+-----------------------+----------------------------------------------+
| Parameter             | Description                                  |
+=======================+==============================================+
| c                     | Wide character to test.                      |
+-----------------------+----------------------------------------------+
| loc                   | Locale used to test c.                       |
+-----------------------+----------------------------------------------+

Return value

Returns true if the wide character c is alphabetic in the locale loc. That is, any character for which `iswupper()`_ or `iswlower()`_ returns true is considered alphabetic in addition to any of the locale-specific set of alphabetic characters for which none of `iswcntrl_l()`_, `iswdigit_l()`_, `iswpunct_l()`_, or `iswspace_l()`_ is true in the locale loc.

In the C locale, `iswalpha_l()`_ returns nonzero (true) if and only if `iswupper_l()`_ or `iswlower_l()`_ return true for value of the argument c.

Notes

Conforms to POSIX.1-2017.

iswalnum()
''''''''''

Description

Is character alphanumeric?

Prototype

::

   int iswalnum(wint_t c);

Parameters

+-----------------------+----------------------------------------------+
| Parameter             | Description                                  |
+=======================+==============================================+
| c                     | Wide character to test.                      |
+-----------------------+----------------------------------------------+

Return value

Returns nonzero (true) if and only if the value of the argument c is an alphabetic or numeric character in the current locale.

iswalnum_l()
''''''''''''

Description

Is character alphanumeric, per locale? (POSIX.1).

Prototype

::

   int iswalnum_l(wint_t c,
                         locale_t loc);

Parameters

+-----------------------+----------------------------------------------+
| Parameter             | Description                                  |
+=======================+==============================================+
| c                     | Wide character to test.                      |
+-----------------------+----------------------------------------------+
| loc                   | Locale used to test c.                       |
+-----------------------+----------------------------------------------+

Return value

Returns nonzero (true) if and only if the value of the argument c is an alphabetic or numeric character in the locale loc.

Notes

Conforms to POSIX.1-2017.

iswupper()
''''''''''

Description

Is character an uppercase letter?

Prototype

::

   int iswupper(wint_t c);

Parameters

+-----------------------+----------------------------------------------+
| Parameter             | Description                                  |
+=======================+==============================================+
| c                     | Wide character to test.                      |
+-----------------------+----------------------------------------------+

Return value

Returns nonzero (true) if and only if the value of the argument c is an uppercase letter in the current locale.

iswupper_l()
''''''''''''

Description

Is character an uppercase letter, per locale? (POSIX.1).

Prototype

::

   int iswupper_l(wint_t c,
                         locale_t loc);

Parameters

+-----------------------+----------------------------------------------+
| Parameter             | Description                                  |
+=======================+==============================================+
| c                     | Wide character to test.                      |
+-----------------------+----------------------------------------------+
| loc                   | Locale used to test c.                       |
+-----------------------+----------------------------------------------+

Return value

Returns nonzero (true) if and only if the value of the argument c is an uppercase letter in the locale loc.

Notes

Conforms to POSIX.1-2017.

iswlower()
''''''''''

Description

Is character a lowercase letter?

Prototype

::

   int iswlower(wint_t c);

Parameters

+-----------------------+----------------------------------------------+
| Parameter             | Description                                  |
+=======================+==============================================+
| c                     | Wide character to test.                      |
+-----------------------+----------------------------------------------+

Return value

Returns nonzero (true) if and only if the value of the argument c is a lowercase letter in the current locale.

iswlower_l()
''''''''''''

Description

Is character a lowercase letter, per locale? (POSIX.1).

Prototype

::

   int iswlower_l(wint_t c,
                         locale_t loc);

Parameters

+-----------------------+----------------------------------------------+
| Parameter             | Description                                  |
+=======================+==============================================+
| c                     | Wide character to test.                      |
+-----------------------+----------------------------------------------+
| loc                   | Locale used to test c.                       |
+-----------------------+----------------------------------------------+

Return value

Returns nonzero (true) if and only if the value of the argument c is a lowercase letter in the locale loc.

Notes

Conforms to POSIX.1-2017.

iswprint()
''''''''''

Description

Is character printable?

Prototype

::

   int iswprint(wint_t c);

Parameters

+-----------------------+----------------------------------------------+
| Parameter             | Description                                  |
+=======================+==============================================+
| c                     | Wide character to test.                      |
+-----------------------+----------------------------------------------+

Return value

Returns nonzero (true) if and only if the value of the argument c is any printing character including space in the current locale.

iswprint_l()
''''''''''''

Description

Is character printable, per locale? (POSIX.1).

Prototype

::

   int iswprint_l(wint_t c,
                         locale_t loc);

Parameters

+-----------------------+----------------------------------------------+
| Parameter             | Description                                  |
+=======================+==============================================+
| c                     | Wide character to test.                      |
+-----------------------+----------------------------------------------+
| loc                   | Locale used to test c.                       |
+-----------------------+----------------------------------------------+

Return value

Returns nonzero (true) if and only if the value of the argument c is any printing character including space in the locale loc.

Notes

Conforms to POSIX.1-2017.

iswgraph()
''''''''''

Description

Is character any printing character?

Prototype

::

   int iswgraph(wint_t c);

Parameters

+-----------------------+----------------------------------------------+
| Parameter             | Description                                  |
+=======================+==============================================+
| c                     | Wide character to test.                      |
+-----------------------+----------------------------------------------+

Return value

Returns nonzero (true) if and only if the value of the argument c is any printing character except space in the current locale.

iswgraph_l()
''''''''''''

Description

Is character any printing character, per locale? (POSIX.1).

Prototype

::

   int iswgraph_l(wint_t c,
                         locale_t loc);

Parameters

+-----------------------+----------------------------------------------+
| Parameter             | Description                                  |
+=======================+==============================================+
| c                     | Wide character to test.                      |
+-----------------------+----------------------------------------------+
| loc                   | Locale used to test c.                       |
+-----------------------+----------------------------------------------+

Return value

Returns nonzero (true) if and only if the value of the argument c is any printing character except space in the locale loc.

Notes

Conforms to POSIX.1-2017.

iswctype()
''''''''''

Description

Construct character mapping.

Prototype

::

   int iswctype(wint_t   c,
                wctype_t t);

Parameters

+------------+---------------------------------------------------------------+
| Parameter  | Description                                                   |
+============+===============================================================+
| c          | Wide character to test.                                       |
+------------+---------------------------------------------------------------+
| t          | Property to test, typically delivered by calling `wctype()`_. |
+------------+---------------------------------------------------------------+

Return value

Returns nonzero (true) if and only if the wide character c has the property t in the current locale.

Additional information

Determines whether the wide character c has the property described by t in the current locale.

iswctype_l()
''''''''''''

Description

Construct character mapping, per locale (POSIX.1).

Prototype

::

   int iswctype_l(wint_t   c,
                  wctype_t t,
                           locale_t loc);

Parameters

+-----------+--------------------------------------------------------------+
| Parameter | Description                                                  |
+===========+==============================================================+
| c         | Wide character to test.                                      |
+-----------+--------------------------------------------------------------+
| t         | Property to test, typically delivered by calling wctype_l(). |
+-----------+--------------------------------------------------------------+
| loc       | Locale used for mapping.                                     |
+-----------+--------------------------------------------------------------+

Return value

Returns nonzero (true) if and only if the wide character c has the property t in the locale loc.

Additional information

Determines whether the wide character c has the property described by t in the locale loc.

Notes

Conforms to POSIX.1-2017.

wctype()
''''''''

Description

Construct character class.

Prototype

::

   wctype_t wctype(char const * name);

Parameters

+--------------------------+-------------------------------------------+
| Parameter                | Description                               |
+==========================+===========================================+
| name                     | Name of mapping.                          |
+--------------------------+-------------------------------------------+

Return value

Character class; zero if class unrecognized.

Additional information

Constructs a value of type wctype_t that describes a class of wide characters identified by the string argument property.

If property identifies a valid class of wide characters in the current locale, returns a nonzero value that is valid as the second argument to `iswctype()`_; otherwise, it returns zero.

Notes

The only mappings supported are:

- “alnum”
- “alpha”,
- “blank”
- “cntrl”
- “digit”
- “graph”
- “lower”
- “print”
- “punct”
- “space”
- “upper”
- “xdigit”

.. _conversion-functions-2:

Conversion functions
^^^^^^^^^^^^^^^^^^^^

+------------------+-----------------------------------------------------------------+
| Function         | Description                                                     |
+==================+=================================================================+
| `towupper()`_    | Convert uppercase character to lowercase.                       |
+------------------+-----------------------------------------------------------------+
| `towupper_l()`_  | Convert uppercase character to lowercase, per locale (POSIX.1). |
+------------------+-----------------------------------------------------------------+
| `towlower()`_    | Convert uppercase character to lowercase.                       |
+------------------+-----------------------------------------------------------------+
| `towlower_l()`_  | Convert uppercase character to lowercase, per locale (POSIX.1). |
+------------------+-----------------------------------------------------------------+
| `towctrans()`_   | Translate character.                                            |
+------------------+-----------------------------------------------------------------+
| `towctrans_l()`_ | Translate character, per locale (POSIX.1).                      |
+------------------+-----------------------------------------------------------------+
| `wctrans()`_     | Construct character mapping.                                    |
+------------------+-----------------------------------------------------------------+
| `wctrans_l()`_   | Construct character mapping, per locale (POSIX.1).              |
+------------------+-----------------------------------------------------------------+

towupper()
''''''''''

Description

Convert uppercase character to lowercase.

Prototype

::

   wint_t towupper(wint_t c);

Parameters

+---------------------+------------------------------------------------+
| Parameter           | Description                                    |
+=====================+================================================+
| c                   | Wide character to convert.                     |
+---------------------+------------------------------------------------+

Return value

Converted wide character.

Additional information

Converts a lowercase letter to a corresponding uppercase letter.

If the argument c is a wide character for which `iswlower()`_ is true and there are one or more corresponding wide characters, in the current current locale, for which `iswupper()`_ is true, `towupper()`_ returns one (and always the same one for any given locale) of the corresponding wide characters; otherwise, c is returned unchanged.

towupper_l()
''''''''''''

Description

Convert uppercase character to lowercase, per locale (POSIX.1).

Prototype

::

   wint_t towupper_l(wint_t c,
                            locale_t loc);

Parameters

+---------------------+------------------------------------------------+
| Parameter           | Description                                    |
+=====================+================================================+
| c                   | Wide character to convert.                     |
+---------------------+------------------------------------------------+
| loc                 | Locale used to convert c.                      |
+---------------------+------------------------------------------------+

Return value

Converted wide character.

Additional information

Converts a lowercase letter to a corresponding uppercase letter.

If the argument c is a wide character for which `iswlower_l()`_ is true and there are one or more corresponding wide characters, in the current locale loc, for which `iswupper_l()`_ is true, `towupper_l()`_ returns one (and always the same one for any given locale) of the corresponding wide characters; otherwise, c is returned unchanged.

Notes

Conforms to POSIX.1-2017.

towlower()
''''''''''

Description

Convert uppercase character to lowercase.

Prototype

::

   wint_t towlower(wint_t c);

Parameters

+---------------------+------------------------------------------------+
| Parameter           | Description                                    |
+=====================+================================================+
| c                   | Wide character to convert.                     |
+---------------------+------------------------------------------------+

Return value

Converted wide character.

Additional information

Converts an uppercase letter to a corresponding lowercase letter.

If the argument c is a wide character for which `iswupper()`_ is true and there are one or more corresponding wide characters, in the current locale, for which `iswlower()`_ is true, `towlower()`_ returns one (and always the same one for any given locale) of the corresponding wide characters; otherwise, c is returned unchanged.

towlower_l()
''''''''''''

Description

Convert uppercase character to lowercase, per locale (POSIX.1).

Prototype

::

   wint_t towlower_l(wint_t c,
                            locale_t loc);

Parameters

+---------------------+------------------------------------------------+
| Parameter           | Description                                    |
+=====================+================================================+
| c                   | Wide character to convert.                     |
+---------------------+------------------------------------------------+
| loc                 | Locale used to convert c.                      |
+---------------------+------------------------------------------------+

Return value

Converted wide character.

Additional information

Converts an uppercase letter to a corresponding lowercase letter.

If the argument c is a wide character for which `iswupper_l()`_ is true and there are one or more corresponding wide characters, in the locale loc, for which `iswlower_l()`_ is true, `towlower_l()`_ returns one (and always the same one for any given locale) of the corresponding wide characters; otherwise, c is returned unchanged.

Notes

Conforms to POSIX.1-2017.

towctrans()
'''''''''''

Description

Translate character.

Prototype

::

   wint_t towctrans(wint_t    c,
                    wctrans_t t);

Parameters

+-------------------+--------------------------------------------------+
| Parameter         | Description                                      |
+===================+==================================================+
| c                 | Wide character to convert.                       |
+-------------------+--------------------------------------------------+
| t                 | Mapping to use for conversion.                   |
+-------------------+--------------------------------------------------+

Return value

Converted wide character.

Additional information

Maps the wide character c using the mapping described by t in the current locale.

towctrans_l()
'''''''''''''

Description

Translate character, per locale (POSIX.1).

Prototype

::

   wint_t towctrans_l(wint_t    c,
                      wctrans_t t,
                                locale_t loc);

Parameters

+-------------------+--------------------------------------------------+
| Parameter         | Description                                      |
+===================+==================================================+
| c                 | Wide character to convert.                       |
+-------------------+--------------------------------------------------+
| t                 | Mapping to use for conversion.                   |
+-------------------+--------------------------------------------------+
| loc               | Locale used for conversion.                      |
+-------------------+--------------------------------------------------+

Return value

Converted wide character.

Additional information

Maps the wide character c using the mapping described by t in the locale loc.

Notes

Conforms to POSIX.1-2017.

wctrans()
'''''''''

Description

Construct character mapping.

Prototype

::

   wctrans_t wctrans(const char * name);

Parameters

+--------------------------+-------------------------------------------+
| Parameter                | Description                               |
+==========================+===========================================+
| name                     | Name of mapping.                          |
+--------------------------+-------------------------------------------+

Return value

Transformation mapping; zero if mapping unrecognized.

Additional information

Constructs a value of type wctrans_t that describes a mapping between wide characters identified by the string argument property.

If property identifies a valid mapping of wide characters in the current locale, `wctrans_l()`_ returns a nonzero value that is valid as the second argument to `towctrans()`_; otherwise, it returns zero.

The only mappings supported are “tolower” and “toupper”.

wctrans_l()
'''''''''''

Description

Construct character mapping, per locale (POSIX.1).

Prototype

::

   wctrans_t wctrans_l(const char * name,
                                    locale_t loc);

Parameters

+---------------------+------------------------------------------------+
| Parameter           | Description                                    |
+=====================+================================================+
| name                | Name of mapping.                               |
+---------------------+------------------------------------------------+
| loc                 | Locale used for mapping.                       |
+---------------------+------------------------------------------------+

Return value

Transformation mapping; zero if mapping unrecognized.

Additional information

Constructs a value of type wctrans_t that describes a mapping between wide characters identified by the string argument property.

If property identifies a valid mapping of wide characters in the locale loc, `wctrans_l()`_ returns a nonzero value that is valid as the second argument to `towctrans()`_; otherwise, it returns zero.

The only mappings supported are “tolower” and “toupper”.

Notes

Conforms to POSIX.1-2017.

<xlocale.h>
~~~~~~~~~~~

.. _locale-management-1:

Locale management
^^^^^^^^^^^^^^^^^

+----------------------+-----------------------------------------------+
| Function             | Description                                   |
+======================+===============================================+
| `newlocale()`_       | Duplicate locale data (POSIX.1).              |
+----------------------+-----------------------------------------------+
| `duplocale()`_       | Duplicate locale data (POSIX.1).              |
+----------------------+-----------------------------------------------+
| `freelocale()`_      | Free locale (POSIX.1).                        |
+----------------------+-----------------------------------------------+
| `localeconv_l()`_    | Get locale data (POSIX.1).                    |
+----------------------+-----------------------------------------------+

newlocale()
'''''''''''

Description

Duplicate locale data (POSIX.1).

Prototype

::

   locale_t newlocale(      int        category_mask,
                      const char     * loc,
                            locale_t   base);

Parameters

+-----------------+----------------------------------------------------+
| Parameter       | Description                                        |
+=================+====================================================+
| category_mask   | Locale categories to be set or modified.           |
+-----------------+----------------------------------------------------+
| loc             | Locale name.                                       |
+-----------------+----------------------------------------------------+
| base            | Base to modify or NULL to create a new locale.     |
+-----------------+----------------------------------------------------+

Return value

Pointer to modified locale.

Additional information

Creates a new locale object or modifies an existing one. If the base argument is NULL, a new locale object is created.

category_mask specifies the locale categories to be set or modified. Values for category_mask are constructed by a bitwise-inclusive OR of the symbolic constants LC_CTYPE_MASK, LC_NUMERIC_MASK, LC_TIME_MASK, LC_COLLATE_MASK, LC_MONETARY_MASK, and LC_MESSAGES_MASK.

For each category with the corresponding bit set in category_mask, the data from the locale named by loc is used. In the case of modifying an existing locale object, the data from the locale named by loc replaces the existing data within the locale object. If a completely new locale object is created, the data for all sections not requested by category_mask are taken from the default locale.

The locales “C” and “POSIX” are equivalent and defined for all settings of category_mask:

If loc is NULL, then the “C” locale is used. If loc is an empty string, `newlocale()`_ will use the default locale.

If base is NULL, the current locale is used. If base is LC_GLOBAL_LOCALE, the global locale is used.

If mask is LC_ALL_MASK, base is ignored.

Notes

Conforms to POSIX.1-2008.

POSIX.1-2008 does not specify whether the locale object pointed to by base is modified or whether it is freed and a new locale object created.

The category mask LC_MESSAGES_MASK is not implemented as POSIX messages are not implemented.

duplocale()
'''''''''''

Description

Duplicate locale data (POSIX.1).

Prototype

::

   locale_t duplocale(locale_t base);

Parameters

+-------------------------+--------------------------------------------+
| Parameter               | Description                                |
+=========================+============================================+
| base                    | Locale to duplicate.                       |
+-------------------------+--------------------------------------------+

Return value

If there is insufficient memory to duplicate loc, returns a NULL and sets errno to ENOMEM as required by POSIX.1-2008. Otherwise, returns a new, duplicated locale.

Additional information

Duplicates the locale object referenced by loc. Duplicated locales must be freed with `freelocale()`_.

Notes

Conforms to POSIX.1-2008.

freelocale()
''''''''''''

Description

Free locale (POSIX.1).

Prototype

::

   int freelocale(locale_t loc);

Parameters

+------------------------------+---------------------------------------+
| Parameter                    | Description                           |
+==============================+=======================================+
| loc                          | Locale to free.                       |
+------------------------------+---------------------------------------+

Return value

Zero on success, -1 on error.

Additional information

Frees the storage associated with loc.

Notes

Conforms to POSIX.1-2008.

localeconv_l()
''''''''''''''

Description

Get locale data (POSIX.1).

Prototype

::

    localeconv_l(locale_t loc);

Parameters

+---------------------------+------------------------------------------+
| Parameter                 | Description                              |
+===========================+==========================================+
| loc                       | Locale to inquire.                       |
+---------------------------+------------------------------------------+

Return value

Returns a pointer to a structure of type lconv with the corresponding values for the locale loc filled in.

Notes

Conforms to POSIX.1-2008.

.. _cabs(): #cabs
.. _cabsf(): #cabsf
.. _cabsl(): #cabsl
.. _carg(): #carg
.. _cargf(): #cargf
.. _cargl(): #cargl
.. _cimag(): #cimag
.. _cimagf(): #cimagf
.. _cimagl(): #cimagl
.. _creal(): #creal
.. _crealf(): #crealf
.. _creall(): #creall
.. _cproj(): #cproj
.. _cprojf(): #cprojf
.. _cprojl(): #cprojl
.. _conj(): #conj
.. _conjf(): #conjf
.. _conjl(): #conjl
.. _csin(): #csin
.. _csinf(): #csinf
.. _csinl(): #csinl
.. _ccos(): #ccos
.. _ccosf(): #ccosf
.. _ccosl(): #ccosl
.. _ctan(): #ctan
.. _ctanf(): #ctanf
.. _ctanl(): #ctanl
.. _casin(): #casin
.. _casinf(): #casinf
.. _casinl(): #casinl
.. _cacos(): #cacos
.. _cacosf(): #cacosf
.. _cacosl(): #cacosl
.. _catan(): #catan
.. _catanf(): #catanf
.. _catanl(): #catanl
.. _csinh(): #csinh
.. _csinhf(): #csinhf
.. _csinhl(): #csinhl
.. _ccosh(): #ccosh
.. _ccoshf(): #ccoshf
.. _ccoshl(): #ccoshl
.. _ctanh(): #ctanh
.. _ctanhf(): #ctanhf
.. _ctanhl(): #ctanhl
.. _casinh(): #casinh
.. _casinhf(): #casinhf
.. _casinhl(): #casinhl
.. _cacosh(): #cacosh
.. _cacoshf(): #cacoshf
.. _cacoshl(): #cacoshl
.. _catanh(): #catanh
.. _catanhf(): #catanhf
.. _catanhl(): #catanhl
.. _cpow(): #cpow
.. _cpowf(): #cpowf
.. _cpowl(): #cpowl
.. _csqrt(): #csqrt
.. _csqrtf(): #csqrtf
.. _csqrtl(): #csqrtl
.. _clog(): #clog
.. _clogf(): #clogf
.. _clogl(): #clogl
.. _cexp(): #cexp
.. _cexpf(): #cexpf
.. _cexpl(): #cexpl
.. _iscntrl(): #iscntrl
.. _iscntrl_l(): #iscntrl_l
.. _isblank(): #isblank
.. _isblank_l(): #isblank_l
.. _isspace(): #isspace
.. _isspace_l(): #isspace_l
.. _ispunct(): #ispunct
.. _ispunct_l(): #ispunct_l
.. _isdigit(): #isdigit
.. _isdigit_l(): #isdigit_l
.. _isxdigit(): #isxdigit
.. _isxdigit_l(): #isxdigit_l
.. _isalpha(): #isalpha
.. _isalpha_l(): #isalpha_l
.. _isalnum(): #isalnum
.. _isalnum_l(): #isalnum_l
.. _isupper(): #isupper
.. _isupper_l(): #isupper_l
.. _islower(): #islower
.. _islower_l(): #islower_l
.. _isprint(): #isprint
.. _isprint_l(): #isprint_l
.. _isgraph(): #isgraph
.. _isgraph_l(): #isgraph_l
.. _toupper(): #toupper
.. _toupper_l(): #toupper_l
.. _tolower(): #tolower
.. _tolower_l(): #tolower_l
.. _feclearexcept(): #feclearexcept
.. _feraiseexcept(): #feraiseexcept
.. _fegetexceptflag(): #fegetexceptflag
.. _fesetexceptflag(): #fesetexceptflag
.. _fetestexcept(): #fetestexcept
.. _fegetround(): #fegetround
.. _fesetround(): #fesetround
.. _fegetenv(): #fegetenv
.. _fesetenv(): #fesetenv
.. _feupdateenv(): #feupdateenv
.. _feholdexcept(): #feholdexcept
.. _setlocale(): #setlocale
.. _localeconv(): #localeconv
.. _strftime(): #strftime
.. _sqrt(): #sqrt
.. _sqrtf(): #sqrtf
.. _sqrtl(): #sqrtl
.. _cbrt(): #cbrt
.. _cbrtf(): #cbrtf
.. _cbrtl(): #cbrtl
.. _rsqrt(): #rsqrt
.. _rsqrtf(): #rsqrtf
.. _rsqrtl(): #rsqrtl
.. _exp(): #exp
.. _expf(): #expf
.. _expl(): #expl
.. _expm1(): #expm1
.. _expm1f(): #expm1f
.. _expm1l(): #expm1l
.. _exp2(): #exp2
.. _exp2f(): #exp2f
.. _exp2l(): #exp2l
.. _exp10(): #exp10
.. _exp10f(): #exp10f
.. _exp10l(): #exp10l
.. _frexp(): #frexp
.. _frexpf(): #frexpf
.. _frexpl(): #frexpl
.. _hypot(): #hypot
.. _hypotf(): #hypotf
.. _hypotl(): #hypotl
.. _log(): #log
.. _logf(): #logf
.. _logl(): #logl
.. _log2(): #log2
.. _log2f(): #log2f
.. _log2l(): #log2l
.. _log10(): #log10
.. _log10f(): #log10f
.. _log10l(): #log10l
.. _logb(): #logb
.. _logbf(): #logbf
.. _logbl(): #logbl
.. _ilogb(): #ilogb
.. _ilogbf(): #ilogbf
.. _ilogbl(): #ilogbl
.. _log1p(): #log1p
.. _log1pf(): #log1pf
.. _log1pl(): #log1pl
.. _ldexp(): #ldexp
.. _ldexpf(): #ldexpf
.. _ldexpl(): #ldexpl
.. _pow(): #pow
.. _powf(): #powf
.. _powl(): #powl
.. _scalbn(): #scalbn
.. _scalbnf(): #scalbnf
.. _scalbnl(): #scalbnl
.. _scalbln(): #scalbln
.. _scalblnf(): #scalblnf
.. _scalblnl(): #scalblnl
.. _sin(): #sin
.. _sinf(): #sinf
.. _sinl(): #sinl
.. _cos(): #cos
.. _cosf(): #cosf
.. _cosl(): #cosl
.. _tan(): #tan
.. _tanf(): #tanf
.. _tanl(): #tanl
.. _sinh(): #sinh
.. _sinhf(): #sinhf
.. _sinhl(): #sinhl
.. _cosh(): #cosh
.. _coshf(): #coshf
.. _coshl(): #coshl
.. _tanh(): #tanh
.. _tanhf(): #tanhf
.. _tanhl(): #tanhl
.. _asin(): #asin
.. _asinf(): #asinf
.. _asinl(): #asinl
.. _acos(): #acos
.. _acosf(): #acosf
.. _acosl(): #acosl
.. _atan(): #atan
.. _atanf(): #atanf
.. _atanl(): #atanl
.. _atan2(): #atan2
.. _atan2f(): #atan2f
.. _atan2l(): #atan2l
.. _asinh(): #asinh
.. _asinhf(): #asinhf
.. _asinhl(): #asinhl
.. _acosh(): #acosh
.. _acoshf(): #acoshf
.. _acoshl(): #acoshl
.. _atanh(): #atanh
.. _atanhf(): #atanhf
.. _atanhl(): #atanhl
.. _erf(): #erf
.. _erff(): #erff
.. _erfl(): #erfl
.. _erfc(): #erfc
.. _erfcf(): #erfcf
.. _erfcl(): #erfcl
.. _lgamma(): #lgamma
.. _lgammaf(): #lgammaf
.. _lgammal(): #lgammal
.. _tgamma(): #tgamma
.. _tgammaf(): #tgammaf
.. _tgammal(): #tgammal
.. _ceil(): #ceil
.. _ceilf(): #ceilf
.. _ceill(): #ceill
.. _floor(): #floor
.. _floorf(): #floorf
.. _floorl(): #floorl
.. _trunc(): #trunc
.. _truncf(): #truncf
.. _truncl(): #truncl
.. _rint(): #rint
.. _rintf(): #rintf
.. _rintl(): #rintl
.. _lrint(): #lrint
.. _lrintf(): #lrintf
.. _lrintl(): #lrintl
.. _llrint(): #llrint
.. _llrintf(): #llrintf
.. _llrintl(): #llrintl
.. _round(): #round
.. _roundf(): #roundf
.. _roundl(): #roundl
.. _lround(): #lround
.. _lroundf(): #lroundf
.. _lroundl(): #lroundl
.. _llround(): #llround
.. _llroundf(): #llroundf
.. _llroundl(): #llroundl
.. _nearbyint(): #nearbyint
.. _nearbyintf(): #nearbyintf
.. _nearbyintl(): #nearbyintl
.. _fmod(): #fmod
.. _fmodf(): #fmodf
.. _fmodl(): #fmodl
.. _modf(): #modf
.. _modff(): #modff
.. _modfl(): #modfl
.. _remainder(): #remainder
.. _remainderf(): #remainderf
.. _remainderl(): #remainderl
.. _remquo(): #remquo
.. _remquof(): #remquof
.. _remquol(): #remquol
.. _fabs(): #fabs
.. _fabsf(): #fabsf
.. _fabsl(): #fabsl
.. _fma(): #fma
.. _fmaf(): #fmaf
.. _fmal(): #fmal
.. _fmin(): #fmin
.. _fminf(): #fminf
.. _fminl(): #fminl
.. _fmax(): #fmax
.. _fmaxf(): #fmaxf
.. _fmaxl(): #fmaxl
.. _fdim(): #fdim
.. _fdimf(): #fdimf
.. _fdiml(): #fdiml
.. _nextafter(): #nextafter
.. _nextafterf(): #nextafterf
.. _nextafterl(): #nextafterl
.. _nexttoward(): #nexttoward
.. _nexttowardf(): #nexttowardf
.. _nexttowardl(): #nexttowardl
.. _nan(): #nan
.. _nanf(): #nanf
.. _nanl(): #nanl
.. _copysign(): #copysign
.. _copysignf(): #copysignf
.. _copysignl(): #copysignl
.. _longjmp(): #longjmp
.. _setjmp(): #setjmp
.. _int8_t: #int8_t
.. _int16_t: #int16_t
.. _int32_t: #int32_t
.. _int64_t: #int64_t
.. _uint8_t: #uint8_t
.. _uint16_t: #uint16_t
.. _uint32_t: #uint32_t
.. _uint64_t: #uint64_t
.. _intmax_t: #intmax_t
.. _uintmax_t: #uintmax_t
.. _int_least8_t: #int_least8_t
.. _int_least16_t: #int_least16_t
.. _int_least32_t: #int_least32_t
.. _int_least64_t: #int_least64_t
.. _uint_least8_t: #uint_least8_t
.. _uint_least16_t: #uint_least16_t
.. _uint_least32_t: #uint_least32_t
.. _uint_least64_t: #uint_least64_t
.. _int_fast8_t: #int_fast8_t
.. _int_fast16_t: #int_fast16_t
.. _int_fast32_t: #int_fast32_t
.. _int_fast64_t: #int_fast64_t
.. _uint_fast8_t: #uint_fast8_t
.. _uint_fast16_t: #uint_fast16_t
.. _uint_fast32_t: #uint_fast32_t
.. _uint_fast64_t: #uint_fast64_t
.. _ptrdiff_t: #ptrdiff_t
.. _size_t: #size_t
.. _intptr_t: #intptr_t
.. _uintptr_t: #uintptr_t
.. _strtol(): #strtol
.. _strtoul(): #strtoul
.. _strtod(): #strtod
.. _getchar(): #getchar
.. _gets(): #gets
.. _putc(): #putc
.. _putchar(): #putchar
.. _puts(): #puts
.. _scanf(): #scanf
.. _sscanf(): #sscanf
.. _vscanf(): #vscanf
.. _vsscanf(): #vsscanf
.. _printf(): #printf
.. _sprintf(): #sprintf
.. _snprintf(): #snprintf
.. _vprintf(): #vprintf
.. _vsprintf(): #vsprintf
.. _vsnprintf(): #vsnprintf
.. _atexit(): #atexit
.. _abort(): #abort
.. _abs(): #abs
.. _labs(): #labs
.. _llabs(): #llabs
.. _div(): #div
.. _ldiv(): #ldiv
.. _lldiv(): #lldiv
.. _rand(): #rand
.. _srand(): #srand
.. _malloc(): #malloc
.. _calloc(): #calloc
.. _realloc(): #realloc
.. _free(): #free
.. _qsort(): #qsort
.. _bsearch(): #bsearch
.. _itoa(): #itoa
.. _ltoa(): #ltoa
.. _lltoa(): #lltoa
.. _utoa(): #utoa
.. _ultoa(): #ultoa
.. _ulltoa(): #ulltoa
.. _atoi(): #atoi
.. _atol(): #atol
.. _atoll(): #atoll
.. _atof(): #atof
.. _strtoll(): #strtoll
.. _strtoull(): #strtoull
.. _strtof(): #strtof
.. _strtold(): #strtold
.. _btowc(): #btowc
.. _btowc_l(): #btowc_l
.. _mblen(): #mblen
.. _mblen_l(): #mblen_l
.. _mbtowc(): #mbtowc
.. _mbtowc_l(): #mbtowc_l
.. _mbstowcs(): #mbstowcs
.. _mbstowcs_l(): #mbstowcs_l
.. _mbsrtowcs(): #mbsrtowcs
.. _mbsrtowcs_l(): #mbsrtowcs_l
.. _wctomb(): #wctomb
.. _wctomb_l(): #wctomb_l
.. _wcstombs(): #wcstombs
.. _wcstombs_l(): #wcstombs_l
.. _mbrtowc(): #mbrtowc
.. _memset(): #memset
.. _memcpy(): #memcpy
.. _memccpy(): #memccpy
.. _mempcpy(): #mempcpy
.. _memmove(): #memmove
.. _strcpy(): #strcpy
.. _strncpy(): #strncpy
.. _strlcpy(): #strlcpy
.. _stpcpy(): #stpcpy
.. _stpncpy(): #stpncpy
.. _strcat(): #strcat
.. _strncat(): #strncat
.. _strlcat(): #strlcat
.. _strdup(): #strdup
.. _strndup(): #strndup
.. _memcmp(): #memcmp
.. _strcmp(): #strcmp
.. _strncmp(): #strncmp
.. _strcasecmp(): #strcasecmp
.. _strncasecmp(): #strncasecmp
.. _memchr(): #memchr
.. _memrchr(): #memrchr
.. _memmem(): #memmem
.. _strchr(): #strchr
.. _strnchr(): #strnchr
.. _strrchr(): #strrchr
.. _strlen(): #strlen
.. _strnlen(): #strnlen
.. _strstr(): #strstr
.. _strnstr(): #strnstr
.. _strcasestr(): #strcasestr
.. _strncasestr(): #strncasestr
.. _strpbrk(): #strpbrk
.. _strspn(): #strspn
.. _strcspn(): #strcspn
.. _strtok(): #strtok
.. _strtok_r(): #strtok_r
.. _strsep(): #strsep
.. _strerror(): #strerror
.. _mktime(): #mktime
.. _difftime(): #difftime
.. _ctime(): #ctime
.. _ctime_r(): #ctime_r
.. _asctime(): #asctime
.. _asctime_r(): #asctime_r
.. _gmtime(): #gmtime
.. _gmtime_r(): #gmtime_r
.. _localtime(): #localtime
.. _localtime_r(): #localtime_r
.. _strftime_l(): #strftime_l
.. _wmemset(): #wmemset
.. _wmemcpy(): #wmemcpy
.. _wmemccpy(): #wmemccpy
.. _wmempcpy(): #wmempcpy
.. _wmemmove(): #wmemmove
.. _wcscpy(): #wcscpy
.. _wcsncpy(): #wcsncpy
.. _wcslcpy(): #wcslcpy
.. _wcscat(): #wcscat
.. _wcsncat(): #wcsncat
.. _wcslcat(): #wcslcat
.. _wcsdup(): #wcsdup
.. _wcsndup(): #wcsndup
.. _wmemcmp(): #wmemcmp
.. _wcsncmp(): #wcsncmp
.. _wcscasecmp(): #wcscasecmp
.. _wcsncasecmp(): #wcsncasecmp
.. _wmemchr(): #wmemchr
.. _wcschr(): #wcschr
.. _wcsnchr(): #wcsnchr
.. _wcsrchr(): #wcsrchr
.. _wcslen(): #wcslen
.. _wcsnlen(): #wcsnlen
.. _wcsstr(): #wcsstr
.. _wcsnstr(): #wcsnstr
.. _wcspbrk(): #wcspbrk
.. _wcsspn(): #wcsspn
.. _wcscspn(): #wcscspn
.. _wcstok(): #wcstok
.. _wcssep(): #wcssep
.. _mbsinit(): #mbsinit
.. _mbrlen(): #mbrlen
.. _mbrlen_l(): #mbrlen_l
.. _mbrtowc_l(): #mbrtowc_l
.. _wctob(): #wctob
.. _wctob_l(): #wctob_l
.. _wcrtomb(): #wcrtomb
.. _wcrtomb_l(): #wcrtomb_l
.. _wcsrtombs(): #wcsrtombs
.. _wcsrtombs_l(): #wcsrtombs_l
.. _iswcntrl(): #iswcntrl
.. _iswcntrl_l(): #iswcntrl_l
.. _iswblank(): #iswblank
.. _iswblank_l(): #iswblank_l
.. _iswspace(): #iswspace
.. _iswspace_l(): #iswspace_l
.. _iswpunct(): #iswpunct
.. _iswpunct_l(): #iswpunct_l
.. _iswdigit(): #iswdigit
.. _iswdigit_l(): #iswdigit_l
.. _iswxdigit(): #iswxdigit
.. _iswxdigit_l(): #iswxdigit_l
.. _iswalpha(): #iswalpha
.. _iswalpha_l(): #iswalpha_l
.. _iswalnum(): #iswalnum
.. _iswalnum_l(): #iswalnum_l
.. _iswupper(): #iswupper
.. _iswupper_l(): #iswupper_l
.. _iswlower(): #iswlower
.. _iswlower_l(): #iswlower_l
.. _iswprint(): #iswprint
.. _iswprint_l(): #iswprint_l
.. _iswgraph(): #iswgraph
.. _iswgraph_l(): #iswgraph_l
.. _iswctype(): #iswctype
.. _iswctype_l(): #iswctype_l
.. _wctype(): #wctype
.. _towupper(): #towupper
.. _towupper_l(): #towupper_l
.. _towlower(): #towlower
.. _towlower_l(): #towlower_l
.. _towctrans(): #towctrans
.. _towctrans_l(): #towctrans_l
.. _wctrans(): #wctrans
.. _wctrans_l(): #wctrans_l
.. _newlocale(): #newlocale
.. _duplocale(): #duplocale
.. _freelocale(): #freelocale
.. _localeconv_l(): #localeconv_l
