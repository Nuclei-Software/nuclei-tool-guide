.. _libncrt_toolchain_usage:

Nuclei C Runtime Library for Nuclei Toolchain
---------------------------------------------

Usage
~~~~~

| You can use prebuilt libncrt library for both **Nuclei GNU** and **LLVM** toolchain to replace **libgcc(-lgcc)**, **newlib c(-lc/-lc_nano)** and **math(-lm)** library.

| If you want to select a small variant of libncrt library, with basic `'heapops'` and uart `'fileops'`, you can use it like below:

For **Nuclei GNU** Toolchain(`riscv64-unknown-elf-gcc`) case:

.. code-block:: shell

    riscv64-unknown-elf-gcc --specs=libncrt_small.specs -Wl,--start-group -lheapops_basic -lfileops_uart -Wl,--end-group

For **Nuclei LLVM** Toolchain(`riscv64-unknown-elf-clang`) case:

You can't use `--specs=libncrt_small.specs` option, since it is not supported, gcc can also use following command just like clang.

.. code-block:: shell

    riscv64-unknown-elf-clang -nodefaultlibs -isystem=/include/libncrt -Wl,--start-group -lncrt_small -lheapops_basic -lfileops_uart -Wl,--end-group

For details about `libncrt`, `'heapops'` and `'fileops'` variant, please read following documentation.

When using this method, please don't link with **-lm/lc_nano/-lgcc/-lc** library to avoid potential linker error and code size increasement.

Varieties
~~~~~~~~~

Libncrt Library choice
^^^^^^^^^^^^^^^^^^^^^^

+-------------+------------------------------+------------------------+
|             | **GCC Specs**                | **Library**            |
+=============+==============================+========================+
| Fast        | libncrt_fast.specs           | libncrt_fast.a         |
+-------------+------------------------------+------------------------+
| Balanced    | libncrt_balanced.specs       | libncrt_balanced.a     |
+-------------+------------------------------+------------------------+
| Small       | libncrt_small.specs          | libncrt_small.a        |
+-------------+------------------------------+------------------------+
| Nano        | libncrt_nano.specs           | libncrt_nano.a         |
+-------------+------------------------------+------------------------+
| Pico        | libncrt_pico.specs           | libncrt_pico.a         |
+-------------+------------------------------+------------------------+

If you are not using gcc, and want to use libncrt small variant, you can pass **-isystem=/include/libncrt** during compile phase, and **-nodefaultlibs -lncrt_small** during link phase.

Optimization
^^^^^^^^^^^^

+----------------+-----------------------------------------------------+
|                | **Optimization**                                    |
+================+=====================================================+
| Fast           | Favor speed at the expense of size                  |
+----------------+-----------------------------------------------------+
| Balanced       | Balanced                                            |
+----------------+-----------------------------------------------------+
| Small          | Favor size at the expense of speed                  |
+----------------+-----------------------------------------------------+
| Nano           | Favor size at the expense of speed                  |
+----------------+-----------------------------------------------------+
| Pico           | Favor size at the expense of speed                  |
+----------------+-----------------------------------------------------+

Formatted I/O
^^^^^^^^^^^^^

+----------+---------+----------+---------------+-----------+------------+--------------------+---------------------------+---------------------------------------+-------------------------------------+
|          | **int** | **long** | **long long** | **float** | **double** | **wide character** | **input character class** | **Width and precision specification** | **stdout formatting buffer (byte)** |
+==========+=========+==========+===============+===========+============+====================+===========================+=======================================+=====================================+
| Fast     | yes     | yes      | yes           | yes       | yes        | yes                | yes                       | yes                                   | 64                                  |
+----------+---------+----------+---------------+-----------+------------+--------------------+---------------------------+---------------------------------------+-------------------------------------+
| Balanced | yes     | yes      | yes           | yes       | yes        | yes                | yes                       | yes                                   | 64                                  |
+----------+---------+----------+---------------+-----------+------------+--------------------+---------------------------+---------------------------------------+-------------------------------------+
| Small    | yes     | yes      | yes           | yes       | yes        | yes                | yes                       | yes                                   | 64                                  |
+----------+---------+----------+---------------+-----------+------------+--------------------+---------------------------+---------------------------------------+-------------------------------------+
| Nano     | yes     | yes      | yes           | no        | no         | no                 | no                        | yes                                   | 64                                  |
+----------+---------+----------+---------------+-----------+------------+--------------------+---------------------------+---------------------------------------+-------------------------------------+
| Pico     | yes     | no       | no            | no        | no         | no                 | no                        | no                                    | 32                                  |
+----------+---------+----------+---------------+-----------+------------+--------------------+---------------------------+---------------------------------------+-------------------------------------+

Algorithm
^^^^^^^^^

+----------+----------------------------------------------------------------------------------------------------------------------------+
|          | **Scaled-integer Algorithm**                                                                                               |
+==========+============================================================================================================================+
| Fast     | Algorithms use C-language floating-point arithmetic.                                                                       |
+----------+----------------------------------------------------------------------------------------------------------------------------+
| Balanced | Algorithms use C-language floating-point arithmetic.                                                                       |
+----------+----------------------------------------------------------------------------------------------------------------------------+
| Small    | Algorithms use C-language floating-point arithmetic.                                                                       |
+----------+----------------------------------------------------------------------------------------------------------------------------+
| Nano     | Algorithms use C-language floating-point arithmetic.                                                                       |
+----------+----------------------------------------------------------------------------------------------------------------------------+
| Pico     | IEEE single-precision functions use scaled integer arithmetic if there is a scaled-integer implementation of the function. |
+----------+----------------------------------------------------------------------------------------------------------------------------+

.. _section-1:

Extra fileops and heapops libraries used together with libncrt
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

+------------------------------------------------------+------------------+------------------------------------------------------------------------------------+
|                                                      | **Library Type** | **Library description**                                                            |
+======================================================+==================+====================================================================================+
| :ref:`-lfileops_uart <libncrt_fileops_uart>`         | fileops          | Using a UART for I/O, need to implement at least metal_tty_putc and metal_tty_getc |
+------------------------------------------------------+------------------+------------------------------------------------------------------------------------+
| :ref:`-lfileops_semi <libncrt_fileops_semi>`         | fileops          | Using semihosting for I/O                                                          |
+------------------------------------------------------+------------------+------------------------------------------------------------------------------------+
| :ref:`-lfileops_rtt <libncrt_fileops_rtt>`           | fileops          | Using SEGGER RTT for I/O                                                           |
+------------------------------------------------------+------------------+------------------------------------------------------------------------------------+
| :ref:`-lheapops_basic <libncrt_heapops_basic>`       | heapops          | Using a basic heap implementation                                                  |
+------------------------------------------------------+------------------+------------------------------------------------------------------------------------+
| :ref:`-lheapops_realtime <libncrt_heapops_realtime>` | heapops          | Using a real-time heap implementation                                              |
+------------------------------------------------------+------------------+------------------------------------------------------------------------------------+
| :ref:`-lheapops_minimal <libncrt_heapops_minimal>`   | heapops          | Using a minimal heap implementation                                                |
+------------------------------------------------------+------------------+------------------------------------------------------------------------------------+

.. _section-2:
