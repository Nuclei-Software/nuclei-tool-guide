.. _libncrt_customized_fileops:

Using customized fileops
------------------------

If you prefer not to use our provided :ref:`fileops_uart <libncrt_fileops_uart>`, :ref:`fileops_semi <libncrt_fileops_semi>` or :ref:`fileops_rtt <libncrt_fileops_rtt>` static libraries and would like to implement your own customized `'fileops'`, do not link the `'fileops'` static library. Instead, you should implement all of the following `'fileops'` functions.

.. code-block:: c

    // Open file. Return NULL if file not opened, !=NULL if opened
    __SEGGER_RTL_FILE *__SEGGER_RTL_X_file_open(const char *filename, const char *mode) {

    }

    // Test for file-error condition. Return <0 if stream is closed, ==0 if stream is not in error, >0 if stream is in error
    int __SEGGER_RTL_X_file_error(__SEGGER_RTL_FILE *stream) {

    }

    // Test for end-of-file condition. Return <0 if stream is closed, ==0 if stream is not at end of file, >0 if stream is at end of file
    int __SEGGER_RTL_X_file_end(__SEGGER_RTL_FILE *stream) {

    }

    // Get file status. Return <0 if stream is not a valid file, >=0 if stream is a valid file
    int __SEGGER_RTL_X_file_stat(__SEGGER_RTL_FILE *stream) {

    }

    // Get stream buffer size. Return 1 for unbuffered I/O, nonzero number of characters to use for
    // buffered I/O
    int __SEGGER_RTL_X_file_bufsize(__SEGGER_RTL_FILE *stream) {

    }

    // Flush unwritten data to file. Return <0 if failure, ==0 if success
    int __SEGGER_RTL_X_file_flush(__SEGGER_RTL_FILE *stream) {

    }

    // Get file position. Return <0 if position not retrieved successfully, ==0 if retrieved successfully
    int __SEGGER_RTL_X_file_getpos(__SEGGER_RTL_FILE *stream, fpos_t *pos) {

    }

    // Set file position. Return !=0 if position is not set, ==0 if position is set
    int __SEGGER_RTL_X_file_seek(__SEGGER_RTL_FILE *stream, long offset, int whence) {

    }

    // Clear file-error status.
    void __SEGGER_RTL_X_file_clrerr(__SEGGER_RTL_FILE *stream)- {

    }

    // Close file. Return <0 if stream if already closed, >=0 if stream is closed
    int __SEGGER_RTL_X_file_close(__SEGGER_RTL_FILE *stream) {

    }

    // Read data from file. Return <0 if failure, >=0 if success
    int __SEGGER_RTL_X_file_read(__SEGGER_RTL_FILE *stream, char *s, unsigned len) {

    }

    // Write data to file. Return <0 if failure, >=0 if success
    int __SEGGER_RTL_X_file_write(__SEGGER_RTL_FILE *stream, const char *s, unsigned len) {

    }

    // Rename file. Return !=0 if rename failure, ==0 if rename success
    int __SEGGER_RTL_X_file_rename(const char *old, const char *new) {

    }

    // Remove file, Return !=0 if remove failed, ==0 if remove success
    int __SEGGER_RTL_X_file_remove(const char *filename) {

    }

    // Generate name for temporary file. Return !=NULL if pointer to temporary name generated, ==NULL if cannot generate a unique temporary name
    char *__SEGGER_RTL_X_file_tmpnam(char *s, unsigned max) {

    }

    // Generate temporary file. Return != NULL if pointer to temporary file, ==NULL if cannot generate a unique temporary file
    __SEGGER_RTL_FILE *__SEGGER_RTL_X_file_tmpfile(void) {

    }

    // Push character back to stream. Return <0 if failure, >=0 if success
    int __SEGGER_RTL_X_file_unget(__SEGGER_RTL_FILE *stream, int c) {

    }

You can refer to the example of UART using the complete `'fileops'` API, which includes the functions mentioned above, in the file **libncrt_fileops_reference.c** located in the same directory as this document.

Of course, you still need to additionally implement these two basic I/O functions is essential for a complete UART `'fileops'` implementation:

.. code-block:: c

    int metal_tty_putc(int c); // UART output function

    int metal_tty_getc(void);  // UART input function
