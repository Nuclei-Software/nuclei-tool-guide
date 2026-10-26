Changelog
=========

.. _qemu_changelog_202610:

Version 2026.10
---------------

**Interrupt and Timer Support**

- Improved ECLIC multi-hart routing and M/S-mode interrupt support.
- Added ECLIC V2 automatic context save/restore, shadow GPRs and nested-trap handling.
- Reworked the SysTimer around shared MTIME state.
- Improved Sstc integration on EvalSoC.
- Improved multicore timer delivery, timer control and RV32 compare access.
- Improved CIDU distribution, inter-core interrupts, semaphores and supervisor access control.
- Improved PLIC interrupt routing and integration.
- Improved AIA configuration, IMSIC address alignment and KVM AIA integration.

**CPU Features and Extensions**

- Added Nuclei sMPU protection.
- Added Nuclei stack-bound checking.
- Added RNMI and double-trap extension support.
- Added NICE plugin support for Nuclei NICE and VNICE instructions.
- Added Zicfilp, Zicfiss, Zibi, Zimop and Zcmop extension support.
- Improved Xxldsp, Xxlcz and BF16 instruction behavior.
- Improved fractional-LMUL instruction behavior and dependency validation.
- Improved Nuclei custom CSR behavior.
- Updated the default RISC-V Privileged ISA specification version to 1.13.

**Peripheral and SoC Module Support**

- Added Nuclei USART support.
- Added Nuclei QSPI support.
- Added Nuclei uDMA support.
- Added Nuclei XEC Ethernet controller support.
- Added Nuclei MISC support.
- Added IREGION capability register support.
- Improved SD-card SPI CRC handling.
- Removed UART1.

**EvalSoC Configuration and Boot**

- Expanded ``soc-cfg`` support for device instantiation, MMIO sizes and partial overrides.
- Added ``irqmax`` validation.
- Improved memory-map overlap checks.
- Added big-endian guest support and ELF-based automatic endianness detection.
- Added ELF ISA compatibility validation.
- Removed the MROM reset trampoline.

**Platform Compatibility and Fixes**

- Fixed GLib version-related warnings in the Windows QEMU build.

.. _qemu_changelog_202510:

Version 2025.10
---------------

- Iregion now can be accessed via 1-8bytes per ops
- Adjust the configuration of ELEN
- Support pausing Nuclei systimer
- Support smode ECLIC
- Add support for Nuclei xxlfbf & xxlvfbf extensions
- Add optional AIA APLIC & IMSIC support on nuclei_evalsoc
- Cherry-pick Smcntrpmf extension support
- Add Nuclei N300e core support
- Update to reflect the overflow flag of xxldsp instructions through 'ucode'
- Implement some Nuclei custom csrs
- Fixed some issues related to csr access
- Adapt the SSTC extension on nuclei_evalsoc
- Add zhinx/zhinxmin/zdinx imply rules
- Fixed the support for single-letter input of the 'ext=' option
- Increase the default size of the flash to 64MB
- Fixed overflow caused by setting the 'mtimecmp' too large in clint timer
- Trigger system reset rather than systimer reset when writing 'msftrst'
- Fix a series of issues during interrupt handling in eclic


.. _qemu_changelog_202502:

Version 2025.02
---------------

- Synchronize to the upstream QEMU 9.0
- Remove the Nuclei Demosoc support
- Add new cpu support for the Nuclei 200 and 1000 series
- Add Nuclei custom Xxlvqmacc extension support
- Add basic support for Nuclei gpio, qspi, test finisher, etc
- Zilsd/Zclsd extensions sync to upstream releases 1.0
- Add support for rv32/64 linux-user
- The maximum number of cpus supported by the Nuclei evalsoc smp has been adjusted from 16 to 64
- Fixed failure to respond to external interrupt in ECLIC
- Fixed Nuclei systimer support in CLINT  mode

Known Issues
============

For a summary of reported Nuclei QEMU issues, see https://github.com/riscv-mcu/qemu/issues/1.

Fixed issues on Nuclei Qemu 2026.10
-----------------------------------

- Unable to write mip/sip in eclic interrupt mode, see https://github.com/riscv-mcu/qemu/issues/7

- The PLIC/ECLIC interrupt controller cannot be automatically switched, see https://github.com/riscv-mcu/qemu/issues/8

- Can not run SMP version RTOS such FreeRTOS, RT-Thread, Zephyr and ThreadX, see https://github.com/riscv-mcu/qemu/issues/9

- Sstc is not fully compatible with the Nuclei SysTimer, see https://github.com/riscv-mcu/qemu/issues/10

- Caculation error of the "dkmda" and "dkmxda" instructions in Nuclei xxldsp, see https://github.com/riscv-mcu/qemu/issues/11
