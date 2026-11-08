.. _libncrt_changelog:

Changelog
=========

.. _libncrt_changelog_202610:

Version 2026.10
---------------

**New Features:**

- Added **RISC-V big-endian** support, the runtime library automatically matches the byte order of the target and no separate library variant needs to be selected. Using the big-endian C library requires the ``riscv64be-unknown-elf-`` prefixed tools together with ``-mbig-endian``, see :ref:`libncrt_big_endian_usage`.
- Added **zicfilp landing pad** support, all runtime library routines are valid landing pad targets when built with CFI landing pad enabled, so indirect calls guarded by the ``zicfilp`` extension can safely land in runtime library code, see :ref:`libncrt_zicfilp_usage`.
- Added the POSIX-compatible headers ``malloc.h``, ``unistd.h``, ``fcntl.h`` and ``stdalign.h`` to prevent include errors when building existing code with ``libncrt``.

**Bug Fixes:**

- Fixed ``strcmp`` returning a wrong result in some cases when comparing longer strings, refer to `issue #66 <https://github.com/riscv-mcu/riscv-gnu-toolchain/issues/66>`__ for details.

.. _libncrt_changelog_202502:

Version 2025.02
---------------

**Bug Fixes:**

- Fixed the 64-bit integer multiplication ``__muldi3`` returning a wrong result when built with GCC 14 ``-Os``.

.. _libncrt_changelog_202406:

Version 2024.06
---------------

**New Features:**

- Improved the performance of ``memset``, ``memcpy``, ``strlen``, ``strcmp``, ``strcpy``, ``strcat`` and the integer to floating-point conversions ``__floatsisf``, ``__floatunsisf``, ``__floatdisf``, ``__floatundisf``, ``__floatsidf``, ``__floatunsidf``, ``__floatdidf`` and ``__floatundidf`` under ``libncrt_small`` with minimal increase in code size.
- Improved the performance of the assembly routines such as ``memcpy`` and ``__divsf3`` by optimizing the instruction scheduling to avoid load-to-use stalls.

**Bug Fixes:**

- Fixed the double-precision floating-point division ``__divdf3`` failing on cores which only have the ``Zmmul`` extension, since it used the ``divu`` instruction which is not available without the ``M`` extension.
- Fixed a linker error when linking the UART `'fileops'` library without ``-gc-sections`` due to the unimplemented ``__SEGGER_RTL_X_file_eof``.

.. _libncrt_changelog_202310:

Version 2023.10
---------------

**New Features:**

- ``libncrt`` is released as three parts, ``libncrt``, `'heapops'` (``basic``/``realtime``/``minimal``) and `'fileops'` (``uart``/``semi``/``rtt``).
- Added the bit operation compiler support APIs ``__ctzsi2``, ``__ctzdi2``, ``__ffssi2``, ``__ffsdi2``, ``__bswapsi2`` and ``__bswapdi2``.
- Added optimizations for the ``Zcmp`` extension (``cm.popret`` in the assembly routine epilogues) 
- Added the Nuclei ``xxlcz`` extension (``xl.lb``/``xl.lbu``/``xl.sb``/``xl.lw``/``xl.ffnz``/``xl.nzmsk``/``xl.bezm``/``xl.bnei`` etc. in the string and floating-point assembly routines).
- ``__SEGGER_RTL_init_heap`` is no longer a weak function.
