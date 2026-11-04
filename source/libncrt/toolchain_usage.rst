.. _libncrt_toolchain_usage:

Nuclei C Runtime Library for Nuclei Toolchain
---------------------------------------------

Usage
~~~~~

| You can use prebuilt libncrt library for both **Nuclei GNU** and **LLVM** toolchain to replace **libgcc(-lgcc)**, **newlib c(-lc/-lc_nano)** and **math(-lm)** library.

| If you want to select a small variant of libncrt library, with basic `'heapops'` and uart `'fileops'`, you can use it like below:

For **Nuclei GNU** Toolchain(`riscv64-unknown-elf-gcc`) case:

.. code-block:: shell

    riscv64-unknown-elf-gcc --specs=libncrt_small.specs -Wl,--start-group -lncrt_small -lheapops_basic -lfileops_uart -Wl,--end-group

For **Nuclei LLVM** Toolchain(`riscv64-unknown-elf-clang`) case:

You can't use `--specs=libncrt_small.specs` option, since it is not supported, gcc can also use following command just like clang.

.. code-block:: shell

    riscv64-unknown-elf-clang -nodefaultlibs -isystem=/include/libncrt -Wl,--start-group -lncrt_small -lheapops_basic -lfileops_uart -Wl,--end-group

For details about `libncrt`, `'heapops'` and `'fileops'` variant, please read following documentation.

When using this method, please don't link with **-lm/lc_nano/-lgcc/-lc** library to avoid potential linker error and code size increasement. Please also note that ``libncrt`` requires a few functions to be provided by the application itself, such as ``exit`` and the basic I/O functions used by the selected `'fileops'` library, see :ref:`libncrt_quick_start` for the minimal set of functions to implement.

.. _libncrt_zicfilp_usage:

zicfilp landing pad usage
~~~~~~~~~~~~~~~~~~~~~~~~~

``libncrt`` supports the **zicfilp** control-flow integrity extension: when the runtime library is built with CFI landing pads enabled, every assembly language routine starts with a valid ``lpad`` instruction, so indirect calls guarded by zicfilp can safely land in runtime library code.

Using it requires a **zicfilp-enabled toolchain**: the standard released toolchain neither supports ``-fcf-protection=branch`` for RISC-V targets nor ships the CFI variants of the ``libncrt``, `'heapops'` and `'fileops'` libraries. On a zicfilp-enabled toolchain, simply add ``_zicfilp`` to ``-march`` and compile and link with ``-fcf-protection=branch``: the CFI variants of the runtime libraries (the ``cfi`` multilib directory) are then selected automatically, and there is no separate library variant to select. An example is as follows:

.. code-block:: shell

    riscv64-unknown-elf-gcc -march=rv32ima_zicfilp_zicond_zaamo_zalrsc_zca_zcb_zcmp_zba_zbb_zbs -mabi=ilp32 -fcf-protection=branch --specs=libncrt_small.specs -Wl,--start-group -lncrt_small -lheapops_basic -lfileops_uart -Wl,--end-group

.. _libncrt_big_endian_usage:

Big-endian usage
~~~~~~~~~~~~~~~~

``libncrt`` also supports RISC-V big-endian targets. The big-endian toolchain is **not publicly released**: to use the big-endian C library, you need to use the tools prefixed with ``riscv64be-unknown-elf-`` together with the ``-mbig-endian`` compile option. There is no separate library variant to select for big-endian: the byte order used by the runtime library is automatically configured from the byte-order macros predefined by the compiler, so the libraries are used in exactly the same way as on little-endian targets, taking the small variant with basic `'heapops'` and uart `'fileops'` as an example:

.. code-block:: shell

    riscv64be-unknown-elf-gcc -mbig-endian --specs=libncrt_small.specs -Wl,--start-group -lncrt_small -lheapops_basic -lfileops_uart -Wl,--end-group

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
