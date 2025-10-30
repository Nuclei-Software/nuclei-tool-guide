.. _qemu_intro:

About Nuclei QEMU
===================

Nuclei QEMU is now developed based on QEMU version 9.0, supporting the machine features of Nuclei Evalsoc. In terms of extensions, in addition to the official upstream support, it also supports the following non ratified and custom extensions implemented by Nuclei.

  - **Xxldsp**: P 0.5.4 draft extension and Nuclei custom N1/N2/N3 extensions

  - **Xxlcz**: Nuclei custom code size reduction extension

  - **Nice & Vnice**: Nuclei custom Nice & Vnice extensions

  - **Xxlvqmacc**: Nuclei custom vpu extension

  - **Zilsd & Zclsd**: riscv-zilsd Release 1.0

  - **Xxlfbf & Xxlvfbf**: Nuclei custom scalar & vector BF16 extensions

.. note::

  Before using Nuclei QEMU, you can check the current version on which Nuclei QEMU is based and the commit id through the ``--version`` option of Nuclei QEMU, for example:

  .. code-block:: shell

    $ qemu-system-riscv32 --version
    QEMU emulator version 9.0.4 (v9.0.4-143-g1857be8c7d-dirty)
    Copyright (c) 2003-2024 Fabrice Bellard and the QEMU Project developers

  The above shows that Nuclei QEMU is currently developed based on the upstream version 9.0.4, and commit id is `1857be8c7d <https://github.com/riscv-mcu/qemu/tree/1857be8c7d>`_.

If you want to access the code of Nuclei QEMU, you can visit our opensource `Nuclei QEMU Github Repository <https://github.com/riscv-mcu/qemu/tree/nuclei/9.0>`_. If you want to learn more about QEMU, please refer to the official QEMU documentation, which is available at https://www.qemu.org/documentation/.

Design and Architecture
=======================

Previously, Nuclei QEMU supports two machine types: ``nuclei_evalsoc`` and ``nuclei_demosoc``, but now, ``nuclei_demosoc`` has been abandoned on Nuclei QEMU 2025.02 and later versions.

Nuclei CPU Types Supported on QEMU
----------------------------------

The following image shows the relevant information of the Nuclei CPU types supported by Nuclei QEMU.

  .. figure:: /asserts/images/qemu_nuclei_cpus_support.png
     :align: center
     :alt: Nuclei QEMU CPUs Support

**Address Allocation of Evalsoc on QEMU**
-----------------------------------------

For the sake of generality, all Nuclei IPs have been mapped and implemented on QEMU, some with fixed addresses and some dynamically initialized based on iregion information.

  ``Fixed``: The address is fixed by default in qemu.

  ``Offset``: The address is equal to iregion base address plus the corresponding offset.

  +---------------------+-----------------------+-----------------------+-----------------------+---------------------------------------+
  |                     | Component             | Base Address          | Size                  | Description                           |
  +=====================+=======================+=======================+=======================+=======================================+
  | Memory Resource     | XIP                   | 0x20000000            | 0x02000000            | XIP address space.                    |
  +---------------------+-----------------------+-----------------------+-----------------------+---------------------------------------+
  |                     | DDR                   | 0x80000000            | 0x04000000            | DDR address space.                    |
  +---------------------+-----------------------+-----------------------+-----------------------+---------------------------------------+
  |                     | ILM                   | 0x80000000            | 0x00800000            | ILM address space.                    |
  +---------------------+-----------------------+-----------------------+-----------------------+---------------------------------------+
  |                     | DLM                   | 0x90000000            | 0x00800000            | DLM address space.                    |
  +---------------------+-----------------------+-----------------------+-----------------------+---------------------------------------+
  |                     | SRAM                  | 0xA0000000            | 0x20000000            | SRAM address space.                   |
  +---------------------+-----------------------+-----------------------+-----------------------+---------------------------------------+
  | Peripherals (Fixed) | IINFO                 | 0                     | 0x1000                | IINFO address space.                  |
  +---------------------+-----------------------+-----------------------+-----------------------+---------------------------------------+
  |                     | MROM                  | 0x1000                | 0xf000                | MROM address space.                   |
  +---------------------+-----------------------+-----------------------+-----------------------+---------------------------------------+
  |                     | TEST                  | 0x100000              | 0x10000               | Space for Eval_SoC exit mechanism.    |
  +---------------------+-----------------------+-----------------------+-----------------------+---------------------------------------+
  |                     | GPIO                  | 0x10012000            | 0x1000                | GPIO address space.                   |
  +---------------------+-----------------------+-----------------------+-----------------------+---------------------------------------+
  |                     | UART0                 | 0x10013000            | 0x1000                | UART0 address space.                  |
  +---------------------+-----------------------+-----------------------+-----------------------+---------------------------------------+
  |                     | UART1                 | 0x10023000            | 0x1000                | UART1 address space.                  |
  +---------------------+-----------------------+-----------------------+-----------------------+---------------------------------------+
  |                     | QSPI0                 | 0x10014000            | 0x1000                | QSPI0 address space.                  |
  +---------------------+-----------------------+-----------------------+-----------------------+---------------------------------------+
  |                     | QSPI1                 | 0x10024000            | 0x1000                | QSPI1 address space.                  |
  +---------------------+-----------------------+-----------------------+-----------------------+---------------------------------------+
  |                     | QSPI2                 | 0x10034000            | 0x1000                | QSPI2 address space.                  |
  +---------------------+-----------------------+-----------------------+-----------------------+---------------------------------------+
  | Peripherals (Offset)| DEBUG                 | 0x10000               | 0x1000                | DEBUG address space.                  |
  +---------------------+-----------------------+-----------------------+-----------------------+---------------------------------------+
  |                     | ECLIC                 | 0x20000               | 0x10000               | ECLIC address space.                  |
  +---------------------+-----------------------+-----------------------+-----------------------+---------------------------------------+
  |                     | TIMER                 | 0x30000               | 0x10000               | TIMER address space.                  |
  +---------------------+-----------------------+-----------------------+-----------------------+---------------------------------------+
  |                     | SMP                   | 0x40000               | 0x1000                | SMP address space.                    |
  +---------------------+-----------------------+-----------------------+-----------------------+---------------------------------------+
  |                     | CIDU                  | 0x50000               | 0x10000               | CIDU address space.                   |
  +---------------------+-----------------------+-----------------------+-----------------------+---------------------------------------+
  |                     | PLIC                  | 0x4000000             | 0x4000000             | PLIC address space.                   |
  +---------------------+-----------------------+-----------------------+-----------------------+---------------------------------------+
  |                     | PPI                   | 0xB0000000            | /                     | Used to view CPU info, not implemented|
  +---------------------+-----------------------+-----------------------+-----------------------+---------------------------------------+
  |                     | FIO                   | 0xC0000000            | /                     | Used to view CPU info, not implemented|
  +---------------------+-----------------------+-----------------------+-----------------------+---------------------------------------+

  In addition, Evalsoc's address mapping can be customized and configured through the ``soc-cfg`` option. Regarding the usage of this option, please see :ref:`Description_of_Parameters`.

**Nuclei CPU Features Supported on QEMU**
-----------------------------------------

The following is the support status of Nuclei CPU features on qemu.

  +---------------------+-------------------------------------------------------+
  | CPU Features        | Status on QEMU                                        |
  +=====================+=======================================================+
  |NMI                  | Not supported                                         |
  +---------------------+-------------------------------------------------------+
  |TIMER                | Supported, see :ref:`qemu_support_status_of_timer`    |
  +---------------------+-------------------------------------------------------+
  |PLIC                 | Supported, see :ref:`qemu_support_status_of_plic`     |
  +---------------------+-------------------------------------------------------+
  |ECLIC                | Supported, see :ref:`qemu_support_status_of_eclic`    |
  +---------------------+-------------------------------------------------------+
  |CIDU                 | Supported, see :ref:`qemu_support_status_of_cidu`     |
  +---------------------+-------------------------------------------------------+
  |PMP                  | Supported, see :ref:`qemu_support_status_of_pmp`      |
  +---------------------+-------------------------------------------------------+
  |TEE                  | Only CSRs Supported                                   |
  +---------------------+-------------------------------------------------------+
  |WFI/WFE              | Supported, see :ref:`qemu_support_status_of_wfi_wfe`  |
  +---------------------+-------------------------------------------------------+
  |ECC                  | Only CSRs Supported                                   |
  +---------------------+-------------------------------------------------------+
  |CCM                  | Only CSRs Supported                                   |
  +---------------------+-------------------------------------------------------+
  |SPMP                 | Not supported                                         |
  +---------------------+-------------------------------------------------------+
  |SMP&CLUSTER CACHE    | Supported, see :ref:`qemu_support_status_of_smpcc`    |
  +---------------------+-------------------------------------------------------+
  |UART                 | Supported, see :ref:`qemu_support_status_of_uart`     |
  +---------------------+-------------------------------------------------------+
  |GPIO                 | Supported, see :ref:`qemu_support_status_of_gpio`     |
  +---------------------+-------------------------------------------------------+
  |QSPI                 | Supported, see :ref:`qemu_support_status_of_qspi`     |
  +---------------------+-------------------------------------------------------+
  |TEST FINISHER        | Supported, see :ref:`qemu_support_status_of_test`     |
  +---------------------+-------------------------------------------------------+

.. _qemu_support_status_of_timer:

TIMER Support
~~~~~~~~~~~~~

  TIMER currently supports normal access and interrupt triggering under two interrupt architectures, eclic and clint (plic) in m-mode, but the functionality in s-mode has not yet been implemented.

.. _qemu_support_status_of_plic:

PLIC Support
~~~~~~~~~~~~

  There is already complete support for the pilc module in qemu, but when selecting **nuclei_evalsoc**, kernal needs to be passed through the ``-bios`` option to make it work in **PLIC** mode.

.. _qemu_support_status_of_eclic:

ECLIC Support
~~~~~~~~~~~~~

  Now QEMU have been equipped with ECLIC, which is optimized based on the RISC-V standard CLIC, to manage all interrupt sources. ECLCI supports both single core and multi-core modes, but kernal needs to be passed through ``-kernel`` to make **nuclei_evalsoc** work in **ECLIC** mode.

.. _qemu_support_status_of_cidu:

CIDU Support
~~~~~~~~~~~~

  The CIDU is used to distribute external interrupts to the core’s ECLIC, also it provides Inter Core Interrupt (ICI) and Semaphores Mechanism. Now QEMU supports ICI interrupt triggering and external interrupt distribution, but the semaphore mechanism needs to be improved.

.. _qemu_support_status_of_pmp:

PMP Support
~~~~~~~~~~~

  The PMP function has been fully supported upstream, and all Nuclei CPUs in QEMU enable this by default.

.. _qemu_support_status_of_wfi_wfe:

WFI/WFE Support
~~~~~~~~~~~~~~~

  The Nuclei processor core can support sleep mode for lower power consumption. In QEMU, WFI has been fully supported by upstream, while WFE only has CSR support.

.. _qemu_support_status_of_smpcc:

SMP&CLUSTER CACHE Support
~~~~~~~~~~~~~~~~~~~~~~~~~

  This module is designed to simulate Cluster Cache (CC) and Symmetric Multi-Processor (SMP), in a Nuclei MP core design (like UX900 MP core), it default integrates the Cluster Cache (CC) and SMP related module called Snoop Control Unit (SCU). However, due to the lack of complete cache support in QEMU, only register read and write as well as dynamic instantiation of CLM have been implemented for this module so far.

.. _qemu_support_status_of_uart:

UART Support
~~~~~~~~~~~~

  Only basic data transmission and interrupt triggering have been implemented.

.. _qemu_support_status_of_gpio:

GPIO Support
~~~~~~~~~~~~

  Only basic input/output and interrupt triggering functions have been implemented.

.. _qemu_support_status_of_qspi:

QSPI Support
~~~~~~~~~~~~

  Currently, only the register mode of QSPI has been implemented in QMEU, which involves configuring relevant registers for data transmission and triggering interrupts.


.. _qemu_support_status_of_test:

TEST Support
~~~~~~~~~~~~

  This is an exit mechanism implemented for **nuclei_evalsoc** in QEMU. By writing different values ``0x3333`` / ``0x5555`` to ``0x100000`` during program execution, qemu can automatically exit in **Fail/Pass** state. Writing ``0x7777`` will trigger system **reset**, initialize all devices, and run the program again.

.. _Description_of_Parameters:

Description of Parameters
=========================

Nuclei QEMU adds some custom features and functionalities based on the original capabilities of qemu. If you want to learn more about the usage of qemu, you can refer to the documentation at https://www.qemu.org/docs/master/.

Nuclei QEMU has several types of parameters that can be configured.
You can enter ``qemu-system-riscv32 --help`` to view the parameters that can be configured in Nuclei QEMU.

Nuclei QEMU supports two main programs: ``qemu-system-riscv32`` and ``qemu-system-riscv64``. ``qemu-system-riscv32`` is used to support 32-bit programs, while ``qemu-system-riscv64`` supports 64-bit programs.

This is an example of a fully functional parameter for Nuclei QEMU: ``qemu-system-riscv32 -M nuclei_evalsoc,download=ddr,aia=aplic-imsic,aia-guests=4,soc-cfg=evalsoc.json,debug=1 -cpu nuclei-n300fd,ext=_v_xxldsp,vlen=128,elen=64,s=true -m 512M -smp 1 -icount shift=0 -nodefaults -nographic -serial stdio -kernel dhrystone.elf``.

Let's describe the meaning of this complete command:

* ``-M nuclei_evalsoc,download=ddr,soc-cfg=evalsoc.json,debug=1``:

  ``-M`` represents ``machine``, which means selecting the type of machine. Currently, Nuclei QEMU has added ``nuclei_evalsoc`` to the existing options. This option must exist.

  ``download=`` is used to choose the download mode, and currently, it supports four download modes: ``sram``, ``flashxip``, ``flash``, ``ilm``, and ``ddr``. If this parameter is not present, the default value is ``flashxip``.

  ``aia=`` is used to set type of AIA interrupt controller. The valid values are ``none``, ``aplic`` and ``aplic-imsic``, corresponding to the interrupt controller enabled on evalsoc as ``PLIC``, ``APLIC`` and ``APLIC-IMSIC``.

  ``aia-guests=`` will set number of guest MMIO pages for AIA-IMSIC. Valid value should be between 0 and 4.

  ``soc-cfg=`` is an optional option to pass dynamic modifications to the initial configuration of the machine with a json file. If this parameter is not set, the default value of qemu will be used.

  Here is an example of json config file passed to ``soc-cfg=``:

  .. code-block:: json

    {
        "general_config": {
            "ddr": {
                    "base":"0x70000000",
                    "size":"2G"
            },
            "ilm": {
                    "base":"0x90000000",
                    "size":"0x100000"
            },
            "dlm": {
                    "base":"0xA0000000",
                    "size":"0x100000"
            },
            "sram": {
                    "base":"0xB0000000",
                    "size":"0x10000000"
            },
            "norflash": {
                    "base":"0x30000000",
                    "size":"32M"
            },
            "uart0": {
                    "base":"0x20013000",
                    "irq":"34"
            },
            "uart1": {
                    "base":"0x20023000",
                    "irq":"35"
            },
            "qspi0": {
                    "base":"0x20014000",
                    "irq":"36"
            },
            "qspi2": {
                    "base":"0x20034000",
                    "irq":"37"
            },
            "iregion": {
                    "base":"0x1000000"
            },
            "cpu_freq":"50000000",
            "timer_freq":"32768",
            "irqmax":"100"
        },
        "download": {
            "ilm": {
                    "startaddr":"0x90000000"
            },
            "flashxip": {
                    "startaddr":"0x30000000"
            },
            "flash": {
                    "startaddr":"0x30000000"
            },
            "sram": {
                    "startaddr":"0xB0000000"
            },
            "ddr": {
                    "startaddr":"0x70000000"
            }
        }
    }

  **general_config** : mainly used to configure the board resource or chip base address

  **base**: module base address, only support hex format

  **size**: module size, support hex, dec, size string format

  **irq**: peripheral interrupt id, dec format

  **download**: firmware startup address

  **irqmax**: number of external interrupts supported by evalsoc, maximum can be set to 1024. In addition, it is necessary to ensure that both the custom irq number and the irq number of the peripheral devices supported by default in qemu are less than this.

  The following is a list of interrupt id for all interrupts implemented in qemu in both PLIC and ECLIC, users should follow this rule when configuring irq.

  +---------------------+-----------------------+-----------------------+-----------------------+
  |                     | Source                | PLIC Interrupt ID     | ECLIC Interrupt ID    |
  +=====================+=======================+=======================+=======================+
  | Internal Interrupt  | TIMER SW              | /                     | 3                     |
  +---------------------+-----------------------+-----------------------+-----------------------+
  |                     | TIMER                 | /                     | 7                     |
  +---------------------+-----------------------+-----------------------+-----------------------+
  |                     | CIDU ICI              | /                     | 16                    |
  +---------------------+-----------------------+-----------------------+-----------------------+
  | Internal Interrupt  | GPIO 0 ~ 31           | 1 ~ 32                | 19 ~ 50               |
  +---------------------+-----------------------+-----------------------+-----------------------+
  |                     | UART0                 | 33                    | 51                    |
  +---------------------+-----------------------+-----------------------+-----------------------+
  |                     | UART1                 | 34                    | 52                    |
  +---------------------+-----------------------+-----------------------+-----------------------+
  |                     | QSPI0                 | 35                    | 53                    |
  +---------------------+-----------------------+-----------------------+-----------------------+
  |                     | QSPI1                 | 36                    | 54                    |
  +---------------------+-----------------------+-----------------------+-----------------------+
  |                     | QSPI2                 | 37                    | 55                    |
  +---------------------+-----------------------+-----------------------+-----------------------+

  In the above script, if there is no **download startaddr** information, the program entry will be the start address of the address range relative to the download mode. For example, when ``download=ilm``, if the following configuration is not in the script,

  .. code-block:: json

    "download": {
            "ilm": {
                    "startaddr":"0x90000000"
            }

  then the ilm base in **general_config** will be used as the program start address by default.

  .. code-block:: json

    "general_config": {
         "ilm": {
                 "base":"0x90000000",
                 "size":"0x100000"
         }

  Other configurations follow this rule as well.

  .. note::

        In the **general_config** JSON configuration script, the **base** attribute must coexist with either **size** or **irq**, and the format requires **base** to be written first, followed by either **size** or **irq**.

  ``debug=1`` list the start address of the current device's peripherals and memory distribution information or irq info for debugging purposes. It is generally not recommended to enable this feature under normal circumstances.

* ``-cpu nuclei-n300fd,ext=_v_xxldsp,vlen=128,elen=64,s=true``:

  Using the ``-cpu`` option, ``nuclei-n300fd`` represents the selectable CPU type for Nuclei, and the complete list of types can be referred to in the diagrams within the ``Design and Architecture`` section. This operation is necessary.

  ``ext=`` This parameter is optional, used to pass different riscv extension, The way to enable different extensions is to add them inside it, for example, ``xxldsp`` represents enable the nuclei DSP extension, ``v`` represents enable RISC-V V-Extension, When enabling multiple extensions, they are connected through ``_``. Currently, Nuclei QEMU supports the following common RISC-V instruction set extension types:

  +--------------+-------------------------------------------------------------------------+
  | Extension    | Functionality                                                           |
  +==============+=========================================================================+
  | v            | RISC-V V-Extension                                                      |
  +--------------+-------------------------------------------------------------------------+
  | h            | RISC-V H-Extension                                                      |
  +--------------+-------------------------------------------------------------------------+
  | zicbom       | RISC-V Zicbom Extension                                                 |
  +--------------+-------------------------------------------------------------------------+
  | zicboz       | RISC-V Zicboz Extension                                                 |
  +--------------+-------------------------------------------------------------------------+
  | zicond       | RISC-V Zicond Extension                                                 |
  +--------------+-------------------------------------------------------------------------+
  | zicsr        | RV32/RV64 Zicsr Standard Extension                                      |
  +--------------+-------------------------------------------------------------------------+
  | zifencei     | RV32/RV64 Zifencei Standard Extension                                   |
  +--------------+-------------------------------------------------------------------------+
  | zihintpause  | ZiHintPause extension                                                   |
  +--------------+-------------------------------------------------------------------------+
  | zilsd        | Zilsd extension (RV32 ONLY)                                             |
  +--------------+-------------------------------------------------------------------------+
  | zclsd        | Zclsd extension (RV32 ONLY)                                             |
  +--------------+-------------------------------------------------------------------------+
  | zawrs        | Zawrs extension                                                         |
  +--------------+-------------------------------------------------------------------------+
  | zfh          | Zfh  Extension                                                          |
  +--------------+-------------------------------------------------------------------------+
  | zfa          | Zfa  Extension                                                          |
  +--------------+-------------------------------------------------------------------------+
  | zfhmin       | Zfhmin Extension                                                        |
  +--------------+-------------------------------------------------------------------------+
  | zfinx        | Zfinx  Extension                                                        |
  +--------------+-------------------------------------------------------------------------+
  | zdinx        | Zdinx  Extension                                                        |
  +--------------+-------------------------------------------------------------------------+
  | zca          | RISC-V Zc* Extension                                                    |
  +--------------+-------------------------------------------------------------------------+
  | zcb          | RISC-V Zc* Extension                                                    |
  +--------------+-------------------------------------------------------------------------+
  | zcf          | RISC-V Zc* Extension                                                    |
  +--------------+-------------------------------------------------------------------------+
  | zcd          | RISC-V Zc* Extension                                                    |
  +--------------+-------------------------------------------------------------------------+
  | zce          | RISC-V Zc* Extension                                                    |
  +--------------+-------------------------------------------------------------------------+
  | zcmp         | RISC-V Zc* Extension                                                    |
  +--------------+-------------------------------------------------------------------------+
  | zcmt         | RISC-V Zc* Extension                                                    |
  +--------------+-------------------------------------------------------------------------+
  | zba          | RISC-V Bitmanipulation Extension                                        |
  +--------------+-------------------------------------------------------------------------+
  | zbb          | RISC-V Bitmanipulation Extension                                        |
  +--------------+-------------------------------------------------------------------------+
  | zbc          | RISC-V Bitmanipulation Extension                                        |
  +--------------+-------------------------------------------------------------------------+
  | zbkb         | RISC-V Bitmanipulation Extension                                        |
  +--------------+-------------------------------------------------------------------------+
  | zbkc         | RISC-V Bitmanipulation Extension                                        |
  +--------------+-------------------------------------------------------------------------+
  | zbkx         | RISC-V Bitmanipulation Extension                                        |
  +--------------+-------------------------------------------------------------------------+
  | zbs          | RISC-V Bitmanipulation Extension                                        |
  +--------------+-------------------------------------------------------------------------+
  | zk           | RISC-V Scalar Crypto Extension                                          |
  +--------------+-------------------------------------------------------------------------+
  | zkn          | RISC-V Scalar Crypto Extension                                          |
  +--------------+-------------------------------------------------------------------------+
  | zknd         | RISC-V Scalar Crypto Extension                                          |
  +--------------+-------------------------------------------------------------------------+
  | zkne         | RISC-V Scalar Crypto Extension                                          |
  +--------------+-------------------------------------------------------------------------+
  | zknh         | RISC-V Scalar Crypto Extension                                          |
  +--------------+-------------------------------------------------------------------------+
  | zkr          | RISC-V Scalar Crypto Extension                                          |
  +--------------+-------------------------------------------------------------------------+
  | zks          | RISC-V Scalar Crypto Extension                                          |
  +--------------+-------------------------------------------------------------------------+
  | zksed        | RISC-V Scalar Crypto Extension                                          |
  +--------------+-------------------------------------------------------------------------+
  | zksh         | RISC-V Scalar Crypto Extension                                          |
  +--------------+-------------------------------------------------------------------------+
  | zkt          | RISC-V Scalar Crypto Extension                                          |
  +--------------+-------------------------------------------------------------------------+
  | zve32x       | RISC-V V-Extension                                                      |
  +--------------+-------------------------------------------------------------------------+
  | zve32f       | RISC-V V-Extension                                                      |
  +--------------+-------------------------------------------------------------------------+
  | zve64x       | RISC-V V-Extension                                                      |
  +--------------+-------------------------------------------------------------------------+
  | zve64f       | RISC-V V-Extension                                                      |
  +--------------+-------------------------------------------------------------------------+
  | zve64d       | RISC-V V-Extension                                                      |
  +--------------+-------------------------------------------------------------------------+
  | zvfh         | RISC-V V-Extension                                                      |
  +--------------+-------------------------------------------------------------------------+
  | zvfhmin      | RISC-V V-Extension                                                      |
  +--------------+-------------------------------------------------------------------------+
  | zhinx        | Zhinx Extension                                                         |
  +--------------+-------------------------------------------------------------------------+
  | zhinxmin     | Zhinxmin Extension                                                      |
  +--------------+-------------------------------------------------------------------------+
  | smaia        | Smaia Extension                                                         |
  +--------------+-------------------------------------------------------------------------+
  | smcntrpmf    | Smcntrpmf Extension                                                     |
  +--------------+-------------------------------------------------------------------------+
  | ssaia        | Ssaia  Extension                                                        |
  +--------------+-------------------------------------------------------------------------+
  | sscofpmf     | Sscofpmf  Extension                                                     |
  +--------------+-------------------------------------------------------------------------+
  | sstc         | Sstc  Extension                                                         |
  +--------------+-------------------------------------------------------------------------+
  | svadu        | Svadu Extension                                                         |
  +--------------+-------------------------------------------------------------------------+
  | svinval      | Svinval Extension                                                       |
  +--------------+-------------------------------------------------------------------------+
  | svnapot      | Svnapot Extension                                                       |
  +--------------+-------------------------------------------------------------------------+
  | svpbmt       | Svpbmt Extension                                                        |
  +--------------+-------------------------------------------------------------------------+
  | xxldsp       | Nuclei DSP Extension based on P-ext 0.5.4 + default 8 EXPD instructions |
  +--------------+-------------------------------------------------------------------------+
  | xxldspn1x    | Xxldsp + Nuclei N1 extension                                            |
  +--------------+-------------------------------------------------------------------------+
  | xxldspn2x    | Xxldspn1x + Nuclei N2 extension                                         |
  +--------------+-------------------------------------------------------------------------+
  | xxldspn3x    | Xxldspn2x + Nuclei N3 extension                                         |
  +--------------+-------------------------------------------------------------------------+
  | xxlcz        | Nuclei code size reduction extension                                    |
  +--------------+-------------------------------------------------------------------------+
  | xxlvqmacc    | Nuclei custom vpu extension                                             |
  +--------------+-------------------------------------------------------------------------+

  **vlen=128**: The VLEN is only effective when the V extension instructions of RISC-V are enabled. The default value of VLEN is 128, and it must be a multiple of 2 when set, with a value range of [128, 1024]. The default value of ELEN is 64, and ELEN must also be a multiple of 2, with a value range of [8, 64].

  **elen=64**: The ELEN is also only effective when the V extension instructions of RISC-V are enabled. When QEMU only enables Zve32* extension, ELEN will be set to 32; otherwise, the default ELEN is 64. If it is also configured through 'elen=', the actual ELEN value will be set based on this option.

  **s=true**: This parameter is optional, If you wish for RISC-V to support the S (supervisor) privilege mode, you can add s=true to the parameters to meet this requirement. Nuclei QEMU currently only supports interrupt handling in M-privilege mode.

* ``-m 512M``: To set the DDR size in QEMU, if the DDR size is not passed with ``-m``, then the JSON config will be used to determine the size, and lastly, if neither is specified, it will initialize with 32MB.

  .. note::

        The following is the current default qemu memory size configuration, **xip: 32MB**, **ddr:64MB**, **ilm: 8MB**, **dlm: 8MB**, **sram: 512MB**. You can change the size of the DDR by using **-m size**. When **-m 128M** or no ``-m`` is passed, the default DDR size configured in the JSON or the size initialized by the program will be used. If the DDR size is configured too large and the computer does not have enough memory to allocate, an error such as ``qemu-system-riscv32: cannot set up guest memory 'riscv.evalsoc.ram.sram'`` may occur.

* ``-smp 1``: Nuclei Qemu currently supports up to 64 CPUs. If this parameter is not set, it defaults to 1.

* ``-icount shift=0``: This parameter is optional, Qemu TCG Instruction Counting. By enabling this option, you can enable qemu's instruction count. For more detailed information, refer to https://www.qemu.org/docs/master/devel/tcg-icount.html

* ``-nodefaults``: QEMU is used to disable all default devices and configurations, and some custom parameters and commands can be passed.

* ``-nographic``: Disable qemu's graphical interface and redirect standard output to the console.

* ``-serial stdio``: Direct standard output to the console.

* ``-kernel or -bios``: Choose the boot mode for the firmware. By default, programs on nuclei-sdk load using the ``-kernel`` mode, while on Linux, they load using the ``-bios`` mode. In the design of Nuclei Qemu, ``-kernel`` enables the use of **ECLIC**. For bare metal or RTOS, ``-kernel`` is used to transfer ELF file, while ``-bios`` is used to enable **PLIC+CLINT** timers, which are more suitable for Linux applications.

Use Nuclei QEMU in Nuclei SDK
=============================

**Setup Tools and Environment**

1. Download the `nuclei-sdk <https://github.com/Nuclei-Software/nuclei-sdk>`_, checkout to ``master`` branch.
2. Download RISC-V GNU Toolchain form `Nuclei Download Center <https://nucleisys.com/download.php>`_.

3. Download Nuclei Qemu form `Nuclei Download Center <https://nucleisys.com/download.php>`_.

4. Set up the system environment variables to ensure that the directories containing ``riscv64-unknown-elf-gcc`` and ``qemu-system-riscv32`` are included in the global system variable environment.

**Example**

If you want to use QEMU on Nuclei-SDK. The example here uses the CPU of the nx900fd, but other CPU types can also be used for testing. The example is xxldsp.

First, you need to configure the toolchain, nuclei-sdk, and qemu environments according to the documentation https://doc.nucleisys.com/nuclei_sdk/quickstart.html

.. code-block:: c

   # Enter the example folder of xxldsp
   cd nuclei-sdk/application/baremetal/demo_dsp/
   # Clear the compilation cache
   make clean
   # Compile the program for the nx900fd, set the download mode to ILM, and enable the xxldsp extension
   make CORE=nx900fd SOC=evalsoc DOWNLOAD=ilm ARCH_EXT=_xxldsp dasm
   # Automatically generate qemu running commands and execute the program
   make CORE=nx900fd SOC=evalsoc DOWNLOAD=ilm ARCH_EXT=_xxldsp run_qemu

Where **ARCH_EXT** can be used to pass the extension name.
Under normal circumstances, you should see the final output ``NMSIS_TEST_PASS``, which indicates that all test cases have passed successfully.

**Support for Nuclei SDK Cases on QEMU**

  ``Y`` - Successfully run and consistent with hardware

  ``N`` - Successfully run but inconsistent with hardware

  ``F`` - Failed

+-----------------------+---------------+---------------+-----------------------------------------------+
| Cases                 | SMP=1         | SMP>1         | Description (Additional compilation parameters|
|                       |               |               | and running status)                           |
+=======================+===============+===============+===============================================+
| benchmark/coremark    | Y             |               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+
| benchmark/dhrystone   | Y             |               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+
| benchmark/whetstone   | Y             |               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+
| cpuinfo/              | Y             |               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+
| demo_cache/           | F             |               | QEMU does not support cache emulation.        |
+-----------------------+---------------+---------------+-----------------------------------------------+
| demo_cidu/            |               | Y             | SMP,XLCFG_CIDU,eg:SMP=1 XXLCFG_CIDU=1         |
+-----------------------+---------------+---------------+-----------------------------------------------+
| demo_clint_timer/     | Y             |               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+
| demo_dsp/             | Y             |               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+
| demo_eclic/           | Y             |               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+
| demo_nice/            | Y             |               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+
| demo_plic/            | Y             | Y             | XLCFG_PLIC, eg:XLCFG_PLIC=1                   |
+-----------------------+---------------+---------------+-----------------------------------------------+
| demo_pmp/             | N             |               | Not meeting expectations when                 |
|                       |               |               | TRIGGER_PMP_VIOLATION_MODE=LOAD_EXCEPTION.    |
+-----------------------+---------------+---------------+-----------------------------------------------+
| demo_profiling/       | Y             |               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+
| demo_smode_eclic/     | Y             |               | XLCFG_TEE, eg:XLCFG_TEE=1 .                   |
+-----------------------+---------------+---------------+-----------------------------------------------+
| demo_smpu/            | F             |               | XLCFG_SMPU, eg:XLCFG_SMPU=1, SPMU has not yet |
|                       |               |               | been implemented in qemu.                     |
+-----------------------+---------------+---------------+-----------------------------------------------+
| demo_spmp/            | F             |               | XLCFG_SPMP, eg:XLCFG_SPMP=1, SPMP has not yet |
|                       |               |               | been implemented in qemu.                     |
+-----------------------+---------------+---------------+-----------------------------------------------+
| demo_stack_check/     | N             |               | Only read and write access to CSRs.           |
+-----------------------+---------------+---------------+-----------------------------------------------+
| demo_timer/           | Y             |               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+
| demo_vnice/           | Y             |               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+
| helloworld/           | Y             |               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+
| lowpower/             | Y             |               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+
| smphello/             |               | Y             | SMP, eg:SMP=4                                 |
+-----------------------+---------------+---------------+-----------------------------------------------+
| freertos/demo/        | Y             |               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+
| freertos/smpdemo/     |               | N             | SMP, eg:SMP=4, all tasks run on core0.        |
+-----------------------+---------------+---------------+-----------------------------------------------+
| rtthread/demo/        | Y             |               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+
| rtthread/msh/         | Y             |               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+
| threadx/demo/         | Y             |               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+
| ucosii/demo/          | Y             |               |                                               |
+-----------------------+---------------+---------------+-----------------------------------------------+

And Nuclei QEMU and Nuclei SDK are deeply integrated in Nuclei Studio, you can also use it in Nuclei Studio, see :ref:`ide`.

Use Nuclei QEMU in Nuclei Linux SDK
===================================

Nuclei QEMU can also used to boot and test RISC-V Linux Kernel using emulated Nuclei EvalSoC, please check documentation
here https://github.com/Nuclei-Software/nuclei-linux-sdk#booting-linux-on-nuclei-qemu .

An example of a typical Nuclei QEMU running Nuclei Linux SDK is as follows:

.. code-block:: c

   qemu-system-riscv64 -M nuclei_evalsoc,download=flashxip,soc-cfg=soc.json -cpu nuclei-ux900fd,ext= -smp 8 -m 2G -bios freeloader_qemu.elf -nographic -drive file=disk.img,if=sd,format=raw

This command sets up QEMU to emulate a Nuclei processor and environment specifically for the Nuclei Linux SDK. Here's a breakdown of the parameters:

* ``qemu-system-riscv64``: This is the QEMU emulator for the RISC-V 64-bit architecture.

* ``-M nuclei_evalsoc``: Specifies the machine type for nuclei_evalsoc.

* ``download=flashxip``: The download mode of firmware, which is an optional parameter. If not set, the default download mode is flashxip.

* ``soc-cfg=evalsoc.json``: optional, additional configuration scripts can customize the interrupt information and memory address information of peripherals. For details, see Description of Parameters.

* ``-cpu nuclei-ux900fd``: Selects the Nuclei UX900FD CPU model for emulation.

* ``-ext=``: You can pass the extensions supported by riscv, and connect multiple extensions with ``_``, eg. ``_zba_zbb_zbc_zbs_zicond``.

* ``-smp 8``: Enables Symmetric Multi-Processing (SMP) with 8 CPU cores.

* ``-m 2G``: Allocates 2GB of RAM to the virtual machine.

* ``-bios freeloader_qemu.elf``: Specifies the BIOS or bootloader to use, in this case a freeloader named freeloader_qemu.elf specifically for QEMU.

* ``-nographic``: Disables graphical output, making QEMU run in a text-only mode.

* ``-drive file=disk.img,if=sd,format=raw``: Attaches a virtual disk image named ``disk.img`` to the virtual machine, using the SD card interface (if=sd) and a raw file format (format=raw). This disk image likely contains the Nuclei Linux SDK filesystem.

Changelog
=========

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

Fixed issues on Nuclei Qemu 2025.10
-----------------------------------

- LiteOS-M is not able to run on Nuclei Qemu, see https://github.com/riscv-mcu/qemu/issues/6

Remaining issues on Nuclei Qemu 2025.10
---------------------------------------

- The plic/eclic interrupt controller cannot be automatically switched, see https://github.com/riscv-mcu/qemu/issues/8

- Can not run SMP mode of FreeRTOS, RT-Thread, and Zephyr, see https://github.com/riscv-mcu/qemu/issues/9

- Sstc is not yet fully compatible with Nuclei systimer, see https://github.com/riscv-mcu/qemu/issues/10
