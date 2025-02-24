.. _libncrt_external_function:

External function interface
---------------------------

This section summarises the functions to be provided by the implementor when integrating ``Nuclei C Runtime Library`` into an application or library.

I/O functions
~~~~~~~~~~~~~

+-----------------------------------+----------------------------------+
| Function                          | Description                      |
+===================================+==================================+
| :ref:`segger_rtl_x_file_read`     | Read data from file.             |
+-----------------------------------+----------------------------------+
| :ref:`segger_rtl_x_file_write`    | Write data to file.              |
+-----------------------------------+----------------------------------+
| :ref:`segger_rtl_x_file_unget`    | Push character back to file.     |
+-----------------------------------+----------------------------------+

.. _segger_rtl_x_file_read:

\__SEGGER_RTL_X_file_read()
^^^^^^^^^^^^^^^^^^^^^^^^^^^

Description

Read data from file.

Prototype

::

   int __SEGGER_RTL_X_file_read(           __SEGGER_RTL_FILE *stream,
                                char     * s,
                                unsigned   len);

Parameters

+---------------+------------------------------------------------------+
| Parameter     | Description                                          |
+===============+======================================================+
| stream        | Pointer to file to read from.                        |
+---------------+------------------------------------------------------+
| s             | Pointer to object that receives the input.           |
+---------------+------------------------------------------------------+
| len           | Number of characters to read from file.              |
+---------------+------------------------------------------------------+

Return value

+-----------------------+----------------------------------------------+
| ≥ 0                   | Success.                                     |
+-----------------------+----------------------------------------------+
| < 0                   | Failure.                                     |
+-----------------------+----------------------------------------------+

Additional information

This reads len octets from the file stream into the object pointed to by s.

.. _segger_rtl_x_file_write:

\__SEGGER_RTL_X_file_write()
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Description

Write data to file.

Prototype

::

   int __SEGGER_RTL_X_file_write(                 __SEGGER_RTL_FILE *stream,
                                 const char     * s,
                                 unsigned   len);

Parameters

+--------------+-------------------------------------------------------+
| Parameter    | Description                                           |
+==============+=======================================================+
| stream       | Pointer to stream to write to.                        |
+--------------+-------------------------------------------------------+
| s            | Pointer to object to write to stream.                 |
+--------------+-------------------------------------------------------+
| len          | Number of characters to write to the stream.          |
+--------------+-------------------------------------------------------+

Return value

+-----------------------+----------------------------------------------+
| ≥ 0                   | Success.                                     |
+-----------------------+----------------------------------------------+
| < 0                   | Failure.                                     |
+-----------------------+----------------------------------------------+

Additional information

This writes len octets to the file stream from the object pointed to by s.

.. _segger_rtl_x_file_unget:

\__SEGGER_RTL_X_file_unget()
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Description

Push character back to file.

Prototype

::

   int __SEGGER_RTL_X_file_unget(    __SEGGER_RTL_FILE *stream,
                                 int c);

Parameters

+-------------------+--------------------------------------------------+
| Parameter         | Description                                      |
+===================+==================================================+
| stream            | File to push character to.                       |
+-------------------+--------------------------------------------------+
| c                 | Character to push back to file.                  |
+-------------------+--------------------------------------------------+

Return value

+-----------+----------------------------------------------------------+
| = EOF     | Failed to push character back.                           |
+-----------+----------------------------------------------------------+
| ≠ EOF     | The character pushed back to the file.                   |
+-----------+----------------------------------------------------------+

Additional information

This function pushes the character c back to the file so that it can be read again. If c is EOF, the function fails and EOF is returned. One character of pushback is guaranteed; if more than one character is pushed back without an intervening read, the pushback may fail.

Heap protection functions
~~~~~~~~~~~~~~~~~~~~~~~~~

+------------------------------------------------+---------------------+
| Function                                       | Description         |
+================================================+=====================+
| :ref:`segger_rtl_x_heap_lock`                  | Lock heap.          |
+------------------------------------------------+---------------------+
| :ref:`segger_rtl_x_heap_unlock`                | Unlock heap.        |
+------------------------------------------------+---------------------+

.. _segger_rtl_x_heap_lock:

\__SEGGER_RTL_X_heap_lock()
^^^^^^^^^^^^^^^^^^^^^^^^^^^

Description

Lock heap.

Prototype

::

   void __SEGGER_RTL_X_heap_lock(void);

Additional information

This function is called to lock access to the heap before allocation or deallocation is processed. This is only required for multitasking systems where heap operations may possibly be called called from different threads.

.. _segger_rtl_x_heap_unlock:

\__SEGGER_RTL_X_heap_unlock()
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Description

Unlock heap.

Prototype

::

   void __SEGGER_RTL_X_heap_unlock(void);

Additional information

This function is called to unlock access to the heap after allocation or deallocation has completed. This is only required for multitasking systems where heap operations may possibly be called called from different threads.

Error and assertion functions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

+--------------------------------+---------------------------------------------+
| Function                       | Description                                 |
+================================+=============================================+
| :ref:`segger_rtl_x_assert`     | User-defined behavior for the assert macro. |
+--------------------------------+---------------------------------------------+
| :ref:`segger_rtl_x_errno_addr` | Return pointer to object holding errno.     |
+--------------------------------+---------------------------------------------+

.. _segger_rtl_x_assert:

\__SEGGER_RTL_X_assert()
^^^^^^^^^^^^^^^^^^^^^^^^

Description

User-defined behavior for the assert macro.

Prototype

::

   void __SEGGER_RTL_X_assert(const char * expr,
                              const char * filename,
                              int    line);

Parameters

+-----------+-------------------------------------------------------------+
| Parameter | Description                                                 |
+===========+=============================================================+
| expr      | Stringized expression that caused failure.                  |
+-----------+-------------------------------------------------------------+
| filename  | Filename of the source file where the failure was signaled. |
+-----------+-------------------------------------------------------------+
| line      | Line number of the failed assertion.                        |
+-----------+-------------------------------------------------------------+

Additional information

The default implementation of \__SEGGER_RTL_X_assert() prints the filename, line, and error message to standard output and then calls `abort()`_.

\__SEGGER_RTL_X_assert() is defined as a weak function and can be replaced by user code.

.. _segger_rtl_x_errno_addr:

\__SEGGER_RTL_X_errno_addr()
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Description

Return pointer to object holding errno.

Prototype

::

   int *__SEGGER_RTL_X_errno_addr(void);

Return value

Pointer to errno object.

Additional information

The default implementation of this function is to return the address of a variable declared with the \__SEGGER_RTL_THREAD storage class. Thus, for multithreaded environments that implement thread-local variables through \__SEGGER_RTL_THREAD, each thread receives its own thread-local errno.

It is beyond the scope of this manual to describe how thread-local variables are implemented by the compiler and any associated real-time operating system.

When \__SEGGER_RTL_THREAD is defined as an empty macro, this function returns the address of a singleton errno object.

RTC functions
~~~~~~~~~~~~~

+-------------------------------------------------+--------------------+
| Function                                        | Description        |
+=================================================+====================+
| :ref:`segger_rtl_x_set_time_of_day`             | Set RTC time.      |
+-------------------------------------------------+--------------------+
| :ref:`segger_rtl_x_get_time_of_day`             | Get RTC time.      |
+-------------------------------------------------+--------------------+

.. _segger_rtl_x_set_time_of_day:

\__SEGGER_RTL_X_set_time_of_day()
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Description

Set RTC time.

Prototype

::

   int __SEGGER_RTL_X_set_time_of_day(const struct timeval *__tp);

Parameters

tp - Pointer to timeval.

Return value

return 0 for success, or -1 for failure.

.. _segger_rtl_x_get_time_of_day:

\__SEGGER_RTL_X_get_time_of_day()
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Description

Get RTC time.

Prototype

::

   int __SEGGER_RTL_X_get_time_of_day(struct timeval *__tp);

Parameters

tp - Pointer to timeval.

Return value

return 0 for success, or -1 for failure.

Locale functions
~~~~~~~~~~~~~~~~

+------------------------------------------------+---------------------+
| Function                                       | Description         |
+================================================+=====================+
| :ref:`segger_rtl_x_find_locale`                | Find locale.        |
+------------------------------------------------+---------------------+

.. _segger_rtl_x_find_locale:

\__SEGGER_RTL_X_find_locale()
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Description

Find locale.

Prototype

::

   const __SEGGER_RTL_locale_t *__SEGGER_RTL_X_find_locale(const char *locale);

Parameters

locale - Pointer to zero-terminated locale name.

Return value

Returns a pointer to a locale or NULL if none can be found.

.. _abort(): #abort
