.. _overview_intro:

Introduction
============

This user guide mainly talked about how to use Nuclei Development Tools, including
Nuclei Studio IDE, Nuclei RISC-V Toolchain, Nuclei OpenOCD, Nuclei QEMU and Nuclei Model.

**Nuclei Studio IDE** is built on Eclipse Embedded CDT plugins, mainly optimized for
Nuclei RISC-V Processor to improve user experience in IDE.

**Nuclei RISC-V Toolchain** is built on RISC-V GNU and LLVM toolchain(gcc/llvm/binutils/gdb/newlib) and
also include Nuclei C Runtime Library, it provide good support for Nuclei RISC-V
Processor.

**Nuclei OpenOCD** is built on RISC-V OpenOCD, adding nuspi flash support, cjtag support,
customized csr support, nuclei openocd flashloader support.

**Nuclei QEMU** is built on QEMU project, adding Nuclei N/NX/UX RISC-V processor support,
which works with Nuclei SDK and Nuclei Linux SDK.

**Nuclei Model** uses spike as the RISC-V ISA simulator and adds support for Nuclei's N/NX/UX RISC-V processors,
it supports near cycle-level simulation and SystemC TLM 2.0 Nuclei EvalSoC modeling.

.. note::

    To get a pdf version of this documentation, please click `Nuclei Development Tool User Guide`_

.. _Nuclei Development Tool User Guide: ../nuclei_tool_user_guide.pdf

You can also find our Nuclei Studio Supply documentation in https://nuclei-software.github.io/nuclei-studio/,
which is used for application notes using Nuclei Studio and Nuclei Tools.

If you have issues in this user guide, please send us an pull request in https://github.com/Nuclei-Software/nuclei-tool-guide repo to help us improve it.

If you have issues in our Nuclei Tools, please send us an issue in this repo or related tool repo to help us improve it.

- Nuclei Studio: https://github.com/Nuclei-Software/nuclei-studio

- Nuclei RISC-V Toolchain: https://github.com/riscv-mcu/riscv-gnu-toolchain

- Nuclei OpenOCD: https://github.com/riscv-mcu/riscv-openocd

- Nuclei Qemu: https://github.com/riscv-mcu/qemu

- Nuclei DLink: https://github.com/nuclei-Software/nuclei-dlink
