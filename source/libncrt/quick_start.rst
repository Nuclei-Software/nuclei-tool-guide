.. _libncrt_quick_start:

Quick start
-----------

There are four fundamental parts you need to implement for a minimal ``Nuclei C Runtime Library`` evaluation. And you can find the reference implementation in the latest **Nuclei SDK** release which support **riscv64-unknown-elf-gcc (>=gcc13)**. The documentation for advanced features is in :ref:`libncrt_external_function`.

.. _libncrt_exit:

exit()
~~~~~~

.. code-block:: c

    void exit(int fd);

.. _libncrt_fileops_uart:

Basic UART I/O functions (-lfileops_uart)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To simplify this tutorial, here you only need to implement 2 basic I/O functions:

.. code-block:: c

    int metal_tty_putc(int c); // UART output function
    int metal_tty_getc(void);  // UART input function

.. _libncrt_fileops_semi:

Using Semihosting (-lfileops_semi)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If you want to use the semihosting function, simply link the `'fileops_semi'` static library; there is no need to implement any additional stub functions.

.. _libncrt_fileops_rtt:

Using RTT (-lfileops_rtt)
~~~~~~~~~~~~~~~~~~~~~~~~~

To use SEGGER's RTT, you need to use J-LINK(**>=v7.92f**).

You can download the J-LINK installation package from the J-LINK page on the SEGGER official website, then unzip it. Next, use the SEGGER J-LINK GDB Server included in it to ensure that your J-LINK is connected.

Then, you need to compile and link the program with the `'fileops_rtt'` static library, use the `riscv64-unknown-elf-gdb` to debug the program, and please note that you need to use `monitor reset` and `monitor halt` to reset the J-Link before loading the program.

Finally, open the J-LINK RTT Viewer to observe bi-directional communication with the target program. Please note that if nothing is displayed on the terminal, you may need to disconnect and then reconnect the terminal.

Thread-local storage
~~~~~~~~~~~~~~~~~~~~

In the linker script, setup `tdata`, `tbss`, `__tls_base` and `__tls_end`:

.. code-block:: shell

    .tdata           : ALIGN(8)
    {
        PROVIDE( __tls_base = . );
        *(.tdata .tdata.* .gnu.linkonce.td.*)
    } >RAM AT>DATA_LMA

    .tbss (NOLOAD)   : ALIGN(8)
    {
        *(.tbss .tbss.* .gnu.linkonce.tb.*)
        *(.tcommon)
        PROVIDE( __tls_end = . );
    } >RAM AT>RAM

In `startup.S`, load `__tls_base` to tp register:

.. code-block:: c

    /* Initialize GP, TP and Stack Pointer SP */
    .option push
    .option norelax
    la gp, __global_pointer$
    la tp, __tls_base
    .option pop
    la sp, _sp

Heap
~~~~

Specific `'heapops'` static libraries can be chosen based on the API support. Here are the **SEGGER heap API** support conditions for the three `'heapops'` static libraries:

SEGGER heap API support
^^^^^^^^^^^^^^^^^^^^^^^

+-----------------------------+----------------------+-------------------+---------------------+
|                             | **heapops_realtime** | **heapops_basic** | **heapops_minimal** |
+=============================+======================+===================+=====================+
| __SEGGER_RTL_alloc          | yes                  | yes               | yes                 |
+-----------------------------+----------------------+-------------------+---------------------+
| __SEGGER_RTL_aligned_alloc  | yes                  | no                | no                  |
+-----------------------------+----------------------+-------------------+---------------------+
| __SEGGER_RTL_realloc        | yes                  | yes               | no                  |
+-----------------------------+----------------------+-------------------+---------------------+
| __SEGGER_RTL_free           | yes                  | yes               | no                  |
+-----------------------------+----------------------+-------------------+---------------------+

Before calling heap-related APIs such as malloc, you need to implement the initialization of the heap as shown in `init_libncrt_heap()`. You can call the function during startup such as in the `startup.S` file.

.. code-block:: c

    extern void __SEGGER_RTL_init_heap(void *ptr, size_t size);
    extern char __heap_start[];
    extern char __heap_end[];

    void init_libncrt_heap(void)
    {
        size_t heapsz = (size_t)__heap_end - (size_t)__heap_start;
        __SEGGER_RTL_init_heap((void *)__heap_start, heapsz);
    }

In the linker script, setup `__heap_start` and `__heap_end`. You need to align the heap to a 16-byte boundary and reserve `__HEAP_SIZE` bytes for it.

.. code-block:: shell

    .heap (NOLOAD)   : ALIGN(16)
    {
        . = ALIGN(16);
        PROVIDE( __heap_start = . );
        . += __HEAP_SIZE;
        . = ALIGN(16);
        PROVIDE( __heap_limit = . );
    } >RAM AT>RAM

    .stack ORIGIN(RAM) + LENGTH(RAM) - __TOT_STACK_SIZE (NOLOAD) :
    {
        . = ALIGN(16);
        PROVIDE( _heap_end = . );
        PROVIDE( __heap_end = . );
        PROVIDE( __StackLimit = . );
        PROVIDE( __StackBottom = . );
        . += __TOT_STACK_SIZE;
        . = ALIGN(16);
        PROVIDE( __StackTop = . );
        PROVIDE( _sp = . );
    } >RAM AT>RAM
