.. _changelog:

ChangeLog
=========

Nuclei Tools official releases can be found in https://nucleisys.com/download.php#tools, you can download
it from there.

You can also find our **Nuclei Studio Supply Documents** in https://doc.nucleisys.com/nuclei_studio_supply/,
which is used for application notes using Nuclei Studio and Nuclei Tools.

.. _changelog_202610:

2026.10
-------

This is **2026.10** release of Nuclei Tools.

.. note::

    - This release is mostly based on 2025.10, the toolchain components such as GCC, Binutils, GDB, Newlib, LLVM and GLIBC keep the same versions.
    - The **Nuclei Studio VSCode** extension is released for the first time in this release, its version is **0.3.0**.
    - RISC-V **big-endian** target support is added in Nuclei QEMU and Nuclei Model, while the big-endian toolchain is not released yet.

.. attention::

    **Upgrade notes.** The following changes may silently change the behavior of existing projects, please check your build options after upgrading:

    - The ``Zcmt`` table jump auto-generation is now disabled by default. Pass ``-Wl,--relax-zcmt`` to the linker to enable it again, see :ref:`the Zcmt note <toolchain_gnu_intro>`.

    - The Nuclei DSP auto-vectorization (``-mautovec-dsp``) and the Nuclei ``xxlcz`` auto-generation (``-mautogen-xxlcz``) are disabled by default now, pass the corresponding option to enable them again.

    - The ``-maddibne/-mno-addibne`` option is removed, use ``-mautogen-xxlcz/-mno-autogen-xxlcz`` instead. Build scripts still passing ``-maddibne`` will fail to compile.

    - Nuclei QEMU no longer instantiates UART1 and no longer provides the MROM reset trampoline at ``0x1000``; each hart now resets directly to the selected ``download=`` start address.

For this release pdf doc, please check https://doc.nucleisys.com/nuclei_tools/nuclei_tool_user_guide.pdf

.. note::

    To check the known issues encountered after this release, please refer to the content at the following link:

    - All Nuclei Tools Known Issues: `Nuclei Tools Known Issues <https://github.com/Nuclei-Software/nuclei-tool-guide/issues/18>`_

    - GNU Toolchain Known Issues: :ref:`Known Issues <toolchain_gnu_known_issues>`

    - LLVM Toolchain Known Issues: :ref:`Known Issues <toolchain_llvm_known_issues>`

    - libncrt Known Issues: :ref:`Known Issues <libncrt_202610_known_issues>`

    - QEMU Known Issues: :ref:`Known Issues <qemu_known_issues>`

    - OpenOCD Known Issues: :ref:`Known Issues <openocd_known_issues>`

    - Nuclei Studio IDE Known Issues: :ref:`Known Issues <ide_known_issues>`

    - Nuclei Model Known Issues: :ref:`Known Issues <xlmodel_202610_known_issues>`

**Find release note below**:

- `Nuclei Studio 2026.10`_ : Add new features such as RISC-V Extension Selector, Flash Erase, Live Peripheral, CPU Information, MMU View and RISC-V Reference, optimize Connect to Running Target, Trace, Flame View and Live Watch, and add IDE support for the big-endian toolchain which is supplied separately, see :ref:`ide_changelog_202610`.
- `Nuclei RISC-V Toolchain 2026.10`_ : Based on 2025.10, add RNMI/Double Trap and Zibi extension support, enhance the Nuclei ``xxldsp``/``xxlcz``/``xxlvqmacc`` extensions, and fix a lot of known issues, see :ref:`toolchain_changelog_202610`.
- `Nuclei QEMU 2026.10`_ : Based on 2025.10, add Nuclei USART/QSPI/uDMA/XEC support, improve ECLIC V2, timer and AIA support, and add big-endian guest support, see :ref:`qemu_changelog_202610`.
- `Nuclei OpenOCD 2026.10`_ : Based on 2025.10, add the ``nuclei trace`` command group, enhance ``nuclei etrace`` and ``nuclei cpuinfo``, and add more flash drivers, see :ref:`openocd_changelog_202610`.
- **Nuclei Model 2026.10** : Based on 2025.10, and support booting a RISC-V Linux kernel, SMP GDB debugging, big-endian ELF, semihosting and ``soc-cfg`` configuration files, see :ref:`xlmodel_changelog_202610`.
- **Nuclei Studio VSCode 2026.10** : First official release of the Nuclei Studio VSCode extension (extension version **0.3.0**), bringing project management, build, debug, Live Watch, and NPK package management to Visual Studio Code, see :ref:`Nuclei Studio VSCode Changelog <vscode_changelog_202610>`.

.. _changelog_202510:

2025.10
-------

This is **2025.10** release of Nuclei Tools.

.. note::

    - This release is mostly based on 2025.02. but introduced some new features and fixed some known issues reported.
    - Windows RISC-V Toolchain changed from win32 to win64 now, please take care!

For this release pdf doc, please check https://doc.nucleisys.com/nuclei_tools/nuclei_tool_user_guide.pdf

**Find release note below**:

- `Nuclei Studio 2025.10`_ : Add a lot new features such as New Welcome, Connect to Running Target, Flame View, Nuclei Model Debug integration and IDE online update, see :ref:`ide_changelog_202510`.
- `Nuclei RISC-V Toolchain 2025.10`_ : Based on 2025.02, only bump newlibc and glibc version, and do lot of fixup and some new features, see :ref:`toolchain_changelog_202510`.
- `Nuclei QEMU 2025.10`_ : Based on 2025.02, and fixup some known issues and introduce some new features, see :ref:`qemu_changelog_202510`.
- `Nuclei OpenOCD 2025.10`_ : Based on 2025.02. and fixup some known issues and enhance existing features such as etrace, cpuinfo, cross trigger and etc, see :ref:`openocd_changelog_202510`.
- **Nuclei Model 2025.10** : Introduced a lot of new features in this release, gdb debug and flame graph are also supported, see :ref:`xlmodel_changelog_202510`.

Click https://github.com/Nuclei-Software/nuclei-tool-guide/issues/18 for known issues.

.. _changelog_202502:

2025.02
-------

This is 2025.02 release of Nuclei Tools.

For this release pdf doc, please check https://doc.nucleisys.com/nuclei_tools/nuclei_tool_user_guide_2025.02.pdf

**Find release note below**:

- `Nuclei Studio 2025.02`_ : Add a lot new features such as Live watch, Modeling integration, flash programming, and Nice Wizard etc.
- `Nuclei RISC-V Toolchain 2025.02`_ : Bump to GCC 14 and LLVM 19.
- `Nuclei QEMU 2025.02`_ : Bump to Qemu 9.0.
- `Nuclei OpenOCD 2025.02`_ : Bump to OpenOCD 0.12.0

Click https://github.com/Nuclei-Software/nuclei-tool-guide/issues/18 for this release known issues.

.. _changelog_202406:

2024.06
-------

This is 2024.06 release of Nuclei Tools.

This release introduced :ref:`xlmodel_intro` first release which can be used in Ubuntu 20.04 environment.

For this release pdf doc, please check https://doc.nucleisys.com/nuclei_tools/nuclei_tool_user_guide_2024.06.pdf

**Find release note below**:

- `Nuclei Studio 2024.06`_
- `Nuclei RISC-V Toolchain 2024.06`_
- `Nuclei QEMU 2024.06`_
- `Nuclei OpenOCD 2024.06`_

Click https://github.com/Nuclei-Software/nuclei-tool-guide/issues/4 for this release known issues.

.. _changelog_202402:

2024.02
-------

This release is a bugfix release for 2023.10, which fix many issues reported by 2023.10.

See https://github.com/Nuclei-Software/nuclei-tool-guide/issues/1

.. _changelog_202310:

2023.10
-------

This is 2023.10 release of Nuclei Tools.

**Find release note below**:

- `Nuclei Studio 2023.10`_
- `Nuclei RISC-V Toolchain 2023.10`_
- `Nuclei QEMU 2023.10`_
- `Nuclei OpenOCD 2023.10`_

Click https://github.com/Nuclei-Software/nuclei-tool-guide/issues/1 for this release known issues.


.. _Nuclei Studio 2023.10: https://github.com/Nuclei-Software/nuclei-studio/releases/tag/2023.10
.. _Nuclei RISC-V Toolchain 2023.10: https://github.com/riscv-mcu/riscv-gnu-toolchain/releases/tag/nuclei-2023.10
.. _Nuclei QEMU 2023.10: https://github.com/riscv-mcu/qemu/releases/tag/nuclei-2023.10
.. _Nuclei OpenOCD 2023.10: https://github.com/riscv-mcu/riscv-openocd/releases/tag/nuclei-2023.10

.. _Nuclei Studio 2024.06: https://github.com/Nuclei-Software/nuclei-studio/releases/tag/2024.06
.. _Nuclei RISC-V Toolchain 2024.06: https://github.com/riscv-mcu/riscv-gnu-toolchain/releases/tag/nuclei-2024.06
.. _Nuclei QEMU 2024.06: https://github.com/riscv-mcu/qemu/releases/tag/nuclei-2024.06
.. _Nuclei OpenOCD 2024.06: https://github.com/riscv-mcu/riscv-openocd/releases/tag/nuclei-2024.06

.. _Nuclei Studio 2025.02: https://github.com/Nuclei-Software/nuclei-studio/releases/tag/2025.02
.. _Nuclei RISC-V Toolchain 2025.02: https://github.com/riscv-mcu/riscv-gnu-toolchain/releases/tag/nuclei-2025.02
.. _Nuclei QEMU 2025.02: https://github.com/riscv-mcu/qemu/releases/tag/nuclei-2025.02
.. _Nuclei OpenOCD 2025.02: https://github.com/riscv-mcu/riscv-openocd/releases/tag/nuclei-2025.02

.. _Nuclei Studio 2025.10: https://github.com/Nuclei-Software/nuclei-studio/releases/tag/2025.10
.. _Nuclei RISC-V Toolchain 2025.10: https://github.com/riscv-mcu/riscv-gnu-toolchain/releases/tag/nuclei-2025.10
.. _Nuclei QEMU 2025.10: https://github.com/riscv-mcu/qemu/releases/tag/nuclei-2025.10
.. _Nuclei OpenOCD 2025.10: https://github.com/riscv-mcu/riscv-openocd/releases/tag/nuclei-2025.10

.. _Nuclei Studio 2026.10: https://github.com/Nuclei-Software/nuclei-studio/releases/tag/2026.10
.. _Nuclei RISC-V Toolchain 2026.10: https://github.com/riscv-mcu/riscv-gnu-toolchain/releases/tag/nuclei-2026.10
.. _Nuclei QEMU 2026.10: https://github.com/riscv-mcu/qemu/releases/tag/nuclei-2026.10
.. _Nuclei OpenOCD 2026.10: https://github.com/riscv-mcu/riscv-openocd/releases/tag/nuclei-2026.10
