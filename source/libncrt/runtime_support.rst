.. _libncrt_runtime_support:

Runtime support
---------------

This section describes how to set up the execution environment for the C library.

Getting to main() and then exit()
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Before entering `main()` the execution environment must be set up such that the C standard library will function correctly.

.. note::

    This section does not describe the compiler or linker support for placing code and data into memory, how to configure any RAM, or how to zero memory required for zero-initialized data. For this, please refer to your toolset compiler and linker documentation.

    Nor does this section document how to call constructors and destructors in the correct order. Again, refer to your toolset manuals.

At-exit function support
^^^^^^^^^^^^^^^^^^^^^^^^

After returning from `main()` or by calling `exit()`, any registered At-exit functions must be called to close down. To do this, call `__SEGGER_RTL_execute_at_exit_fns()` from the runtime startup immediately after the call to `main()`.

Multithreaded protection for the heap
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Heap functions (allocation, reallocation, deallocation) can be protected from reentrancy in a multithreaded environment by implementing **lock and unlock** functions. By default, these functions do nothing and memory allocation functions are not protected.

See :ref:`segger_rtl_x_heap_lock` and :ref:`segger_rtl_x_heap_unlock`.

