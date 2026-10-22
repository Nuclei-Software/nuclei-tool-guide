.. _tracedecoder_decoding_trace_data:

TraceDecoder Decoding Trace Data
================================

TraceDecoder is a tool for decoding Nuclei RISC-V architecture trace data. It supports reconstructing instruction streams and data streams from Etrace/TraceBundle format trace data. The tool provides a standalone executable ``dqr`` and dynamic libraries (``dqr.dll`` or ``libdqr.so``).

Table of Contents
-----------------

- `Tool Installation and Environment Setup`_
- `Features`_
- `Command Line Usage`_
- `Usage Examples`_
- `Common Problem Troubleshooting and Solutions`_

Tool Installation and Environment Setup
---------------------------------------

Download and install the latest version of the TraceDecoder tool from the Nuclei official website: https://nucleisys.com/download.php

After downloading and extracting to the installation directory, add the following directory to the PATH environment variable:

- ``Nuclei\TraceDecoder\xxx\bin``

Features
--------

- Supports 32-bit and 64-bit trace data decoding
- Provides both command-line tool and dynamic library usage modes
- Cross-platform support (Windows, Linux, macOS)
- Can reconstruct program execution flow for debugging and performance analysis

Command Line Usage
------------------

Basic Syntax
~~~~~~~~~~~~

.. code-block::

    Usage: dqr -t <tracefile> -e <elffile> [-od <objdump-path>] [options]

    -t <tracefile>:   Specify the name of the Nuclei trace message file. Must contain the file extension (such as .rtd).
    -e <elffile>:     Specify the name of the executable elf file. Must contain the file extension (such as .elf).
    -od <objdump>:    Specify the path and name of the objdump executable to use. By default uses riscv64-unknown-elf-objdump.
    -nofile:          Do not display source file information (enabled by default).
    -nodasm:          Do not display disassembled code in output (enabled by default).
    -nofunc:          Do not display function information with source information (enabled by default).
    -notrace:         Do not display trace information in output (enabled by default).
    -nobranches:      Do not display conditional branches with taken or not taken information (annotated by default).
    -cutpath=<path>:  Strip off the specified path when displaying source file name/path.
    -path=unix:       Show all file paths using unix-type '/' path separators (default).
    -path=windows:    Show all file paths using windows-type '\\' path separators.
    -path=raw:        Show all file paths in the format stored in the elf file.
    -tdasize=<n>:     Specify size in bits of trace data align size. Must be [8, 32, 64], default is 8.
    -tssize=<n>:      Specify size in bits of timestamp counter; used for timestamp wrap, default is 13.
    -freq=<n>:        Specify the frequency in Hz for the timestamp tics clock, default is 0.
    -srcid=<n>:       Set srcid for trace decoder, default is 0.
    -decodemode=<n>:  Set trace decode mode [7:0] and feature [31:8], default is 0.
                       mode[7:0]=0x00: etrace-v1.0 (default)
                       mode[7:0]=0x01: etrace-v1.1
                       mode[7:0]=0x02: etrace-v1.2 (2bit srcid)
                       mode[7:0]=0x03: etrace-v1.3 (2bit srcid + thaddr)
                       mode[7:0]=0x10: tracebundle-v1.0.0
                       mode[7:0]=0x11: tracebundle-v1.1.0/v1.2.0/v1.3.0
                       mode[7:0]=0x12: tracebundle-v1.4.0
                       feature[08]: has-srcid
                       feature[09]: has-timestamp
                       feature[10]: has-load
                       feature[11]: has-store
                       feature[12]: has-csr
                       feature[13]: has-amo
                       feature[14]: has-zcmp
                       feature[15]: has-value
                       feature[16]: has-addr
    -datatrace=<n>:   Specify whether hardware supports data-trace. n is index_width, default is 0.
    -contextsize=<n>: Specify size in bits of context, default is 0.
    -analytics:       Compute and display trace analytics.
    -debug:           Display some debug information for the trace to aid in debugging the trace decoder.
    -v:               Display the version number of the dqr and exit.
    -h:               Display this usage information.

Common Parameter Descriptions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-tdasize (Trace Data Align Size in Bits)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This parameter should be set according to the actual hardware configuration.

- **TraceBundle module**: tdasize is typically **8**
- **Etrace module**: tdasize can be **8, 32, or 64**, please confirm with your hardware team

Example: If a trace packet contains only 22 bits of data:

- When tdasize=8, the final output will be 24 bits (aligned to 8 bits)
- When tdasize=32, the final output will be 32 bits (aligned to 32 bits)
- When tdasize=64, the final output will be 64 bits (aligned to 64 bits)

-tssize (Timestamp Size in Bits)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This parameter specifies the size of the timestamp counter in bits, used for timestamp wrap detection.

- **etrace-v1.0** and **etrace-v1.1**: tssize is fixed at **13 bits** (default value), can be omitted
- **etrace-v1.2** and **etrace-v1.3**: tssize is fixed at **16 bits**
- **TraceBundle module**: The tssize you can obtain it by reading the `[7:0]` bit field of the TRPATAMETER1 (0x4e04) register in the tracebundle module.

-srcid
^^^^^^

This parameter was previously named ``-srcid=n``, and both serve the same purpose.

``-srcid=n`` is used to specify which srcid's trace information to parse. In multi-core trace scenarios, the trace data contains information from multiple cores. Each core is assigned a unique srcid when capturing trace data. Therefore, you need to specify ``-srcid=n`` during decoding to indicate which core's trace data to decode.

-decodemode
^^^^^^^^^^^

This is a **critical** decoding parameter that consists of two fields: **mode field** and **feature field**.

**Mode Field [7:0]**: Specifies the trace hardware version

- Used to identify the format version of the trace data
- Must match the hardware version that generated the trace

**Mode Values:**

.. note::

   For all etrace versions, you need to check the hardware code and packet format to determine the specific version.

- ``0x00`` (etrace-v1.0): Nuclei's initial trace version

  - Supports instruction trace only (follows RISC-V trace spec v1.0)
  - 5-bit srcid, 13-bit timestamp

**Trace Packet Format (etrace-v1.0):**

+------------------+------------+-------------------------+
| Field            | Size       | Description             |
+==================+============+=========================+
| Timestamp Switch | 1 bit      | Fixed to 1              |
+------------------+------------+-------------------------+
| halt-id(l2)      | 2 bits     | Lower 2 bits of halt ID |
+------------------+------------+-------------------------+
| payload-length   | 5 bits     | Length of payload data  |
+------------------+------------+-------------------------+
| halt-id(h3)      | 3 bits     | Upper 3 bits of halt ID |
+------------------+------------+-------------------------+
| timestamp        | 13 bits    | Timestamp value         |
+------------------+------------+-------------------------+
| payload          | 0-31 bytes | Variable length payload |
+------------------+------------+-------------------------+

- ``0x01`` (etrace-v1.1): Special version for specific customers (rarely used)

- ``0x02`` (etrace-v1.2): Same as v1.0 but with different srcid/timestamp size

  - 2-bit srcid, 16-bit timestamp

**Trace Packet Format (etrace-v1.2):**

+------------------+------------+-------------------------+
| Field            | Size       | Description             |
+==================+============+=========================+
| Timestamp Switch | 1 bit      | Fixed to 1              |
+------------------+------------+-------------------------+
| halt-id          | 2 bits     | 2 bits of halt ID       |
+------------------+------------+-------------------------+
| payload-length   | 5 bits     | Length of payload data  |
+------------------+------------+-------------------------+
| timestamp        | 16 bits    | Timestamp value         |
+------------------+------------+-------------------------+
| payload          | 0-31 bytes | Variable length payload |
+------------------+------------+-------------------------+

- ``0x03`` (etrace-v1.3): Same as v1.2 with additional thaddr field

  - 2-bit srcid, 16-bit timestamp
  - Format 3 subformat 1 (support packet) includes thaddr field

- ``0x10`` (tracebundle-v1.0.0): Supports both instruction and data trace (follows RISC-V trace spec v2.0)
- ``0x11`` (tracebundle-v1.1.0): Updated tracebundle version
- ``0x12`` (tracebundle-v1.4.0): Updated tracebundle version with 5bit ecause

**Trace Packet Format (tracebundle-v1.x.x):**

+---------------+--------------------+---------------------------------------------------------------------------------+
| Field         | Size               | Description                                                                     |
+===============+====================+=================================================================================+
| header        | 1 byte             | Protocol header                                                                 |
+---------------+--------------------+---------------------------------------------------------------------------------+
| src_id        | 1 byte (optional)  | Source ID                                                                       |
+---------------+--------------------+---------------------------------------------------------------------------------+
| Timestamp     | n bytes (optional) | Timestamp (controlled by header bit[7])                                         |
+---------------+--------------------+---------------------------------------------------------------------------------+
| type          | 1 bit (optional)   | Packet type (0=Instruction Trace, 1=Data Trace), only when data trace supported |
+---------------+--------------------+---------------------------------------------------------------------------------+
| Trace Package | Variable length    | Trace data payload                                                              |
+---------------+--------------------+---------------------------------------------------------------------------------+

**Header Byte Format:**

+-----------+----------------------------------------------+
| Bit Field | Description                                  |
+===========+==============================================+
| bit[4:0]  | Trace package byte size (5 bits)             |
+-----------+----------------------------------------------+
| bit[6:5]  | Reserved to 0 (2 bits)                       |
+-----------+----------------------------------------------+
| bit[7]    | Timestamp exist flag (1=exists, 0=not exist) |
+-----------+----------------------------------------------+

.. note::

   For tracebundle, you can read the TRTRACEBUNDLEVERSION (0xe00) register to determine the version:

   - Register value = 0: tracebundle-v1.0.0
   - Register value = 0x10100: tracebundle-v1.1.0
   - Register value = 0x10200: tracebundle-v1.2.0
   - Register value = 0x10300: tracebundle-v1.3.0
   - Register value = 0x10400: tracebundle-v1.4.0

**Feature Field [31:8]**: Specifies which features were enabled when the trace hardware captured the data

- Indicates what types of trace information are included in the data
- Must match the hardware configuration used during trace capture

.. note::

   Only ``has-zcmp`` is valid for both etrace and tracebundle. Other features are only valid for tracebundle.

**Feature Bits:**

- ``feature[08]`` (has-srcid): Trace packet contains srcid field

  - Typically only present in multi-core trace scenarios (when using Nuclei's OpenOCD to capture trace)

- ``feature[09]`` (has-timestamp): Trace packet contains timestamp field

  - Should match the configuration used during trace capture

- ``feature[10]`` (has-load): Enable data trace for load operations (tracebundle only)
- ``feature[11]`` (has-store): Enable data trace for store operations (tracebundle only)
- ``feature[12]`` (has-csr): Enable data trace for CSR operations (tracebundle only)
- ``feature[13]`` (has-amo): Enable data trace for AMO operations (tracebundle only)
- ``feature[14]`` (has-zcmp): Current decoding includes ZCMP instructions

  - **Valid for both etrace and tracebundle**
  - Required because ZCMP instruction encoding overlaps with floating-point instruction encoding

- ``feature[15]`` (has-value): Include data values in data trace (tracebundle only)
- ``feature[16]`` (has-addr): Include data addresses in data trace (tracebundle only)

**Important**: Both mode and feature fields must be set correctly according to your hardware configuration for successful decoding.

-datatrace
^^^^^^^^^^

This parameter is **only valid for tracebundle**. It indicates whether the trace hardware supports data trace.

If data trace is supported, you need to pass the ``index_width`` (split transaction ID width) via ``-datatrace=n``.

- ``-datatrace=0``: Data trace is disabled (default)
- ``-datatrace=n`` (n > 0): Data trace is enabled, where n specifies the index_width
- The index_width you can obtain it by reading the `[31:16]` bit field of the TRPATAMETER0 (0x4e00) register in the tracebundle module.

-contextsize
^^^^^^^^^^^^

This parameter is **valid for tracebundle-v1.1.0 and later versions**. 

- Default value is 0
- The contextsize is ASID + VMID. You can obtain it by reading the `[15:8]` bit field of the TRPATAMETER1 (0x4e04) register in the tracebundle module.


Usage Examples
--------------

Example 1: ATB2AXI (etrace-v1.x) Instruction Trace Decode
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This example demonstrates decoding instruction trace data captured from an ATB2AXI-based system (etrace-v1.x) with 64-bit trace data alignment.

**Decode Command:**

.. code-block:: bash

    # Windows
    .\install\bin\dqr.exe -t tests\atb2axi_tdasize64_demo_eclic.bin -e tests\atb2axi_tdasize64_demo_eclic.elf -tdasize=64

    # Linux
    ./install/bin/dqr -t tests/atb2axi_tdasize64_demo_eclic.bin -e tests/atb2axi_tdasize64_demo_eclic.elf -tdasize=64

**Parameters Explained:**

- ``-tdasize=64``: Specify 64-bit trace data alignment size (required for this ATB2AXI configuration)

**Output Sample:**

.. code-block::

    Trace: Msg # Num: 1, SrcId: 0, Tics: 634
               # Raw: 85 02 7a 73 8e 1d 00 80
               # NxtAddr: 0x80001d8e, FormatCode: sync(3) SubFormatCode: start(0)
               # branch(0x1) privilege(0x3) context(0x0) address(0x80001d8e)

    File: C:/software/nucleiIDE/workspace/demo_eclic/application/demo_eclic.c:97
    <_text+1b0e>
        80001d8e:         4785        c.li	a5,1

    Trace: Msg # Num: 2, SrcId: 0, Tics: 887
               # Raw: 82 03 77 81 06 00 00 00
               # NxtAddr: 0x80001d90, FormatCode: diff-delta(1)
               # branches(0x1f) branch_map(0xd) address(0x0) notify(0x0) updiscon(0x0) irreport(0x0) irdepth(0x0)
        80001d90:         fef40723    sb	a5,-18(s0)

    File: C:/software/nucleiIDE/workspace/demo_eclic/application/demo_eclic.c:101
        80001d94:         91bff0ef    jal	ra,800016ae <setup_timer>

    File: C:/software/nucleiIDE/workspace/demo_eclic/application/demo_eclic.c:31
    <_text+142e>
        800016ae:         1141        c.addi	sp,-16
        800016b0:         c606        c.swsp	ra,12(sp)
        800016b2:         c422        c.swsp	s0,8(sp)
        800016b4:         0800        c.addi4spn	s0,sp,16

Example 2: TraceBundle Instruction Trace Decode
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This example demonstrates decoding instruction-only trace data captured from a TraceBundle-based system with CPU timestamp (16-bit).

**Decode Command:**

.. code-block:: bash

    # Windows
    .\install\bin\dqr.exe -t tests\tracebundle_inst_cpu16_helloworld.bin -e tests\tracebundle_inst_cpu16_helloworld.elf -datatrace=5 -decodemode=0x310 -tssize=16

    # Linux
    ./install/bin/dqr -t tests/tracebundle_inst_cpu16_helloworld.bin -e tests/tracebundle_inst_cpu16_helloworld.elf -datatrace=5 -decodemode=0x310 -tssize=16

**Parameters Explained:**

- ``-datatrace=5``: Specify index_width for data trace (required even for instruction-only traces in tracebundle)
- ``-decodemode=0x310``: tracebundle-v1.0.0 (0x10) with has-timestamp (0x100) and has-srcid (0x200) features
- ``-tssize=16``: 16-bit timestamp counter size

**Output Sample:**

.. code-block::

    Trace: Msg # Num: 1, SrcId: 0, Tics: 0
               # Raw: 86 00 00 00 e6 08 02 00 00 ff
               # NxtAddr: 0x80000104, FormatCode: sync(3) SubFormatCode: start(0)
               # branch(0x1) privilege(0x3) context(0x0) address(0x80000104)

    File: D:/Git/nuclei-sdk/SoC/evalsoc/Common/Source/GCC/startup_evalsoc.S:169
    <_start+4>
        80000104:         f1402573    csrrs	a0,mhartid,zero

    Trace: Msg # Num: 2, SrcId: 0, Tics: 0
               # Raw: 82 00 00 00 02 09
               # NxtAddr: 0x80000108, FormatCode: diff-delta(1)
               # branches(0x1f) branch_map(0x9) address(0x0) notify(0x0) updiscon(0x0) irreport(0x0) irdepth(0x0)

    File: D:/Git/nuclei-sdk/SoC/evalsoc/Common/Source/GCC/startup_evalsoc.S:170
        80000108:         0ff57513    andi	a0,a0,255

Example 3: TraceBundle Instruction + Data Trace Decode
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This example demonstrates decoding both instruction and data trace captured from a TraceBundle-based system. Data trace includes load/store operations with addresses and values.

**Decode Command:**

.. code-block:: bash

    # Windows
    .\install\bin\dqr.exe -t tests\tracebundle_inst_data_cpu16_dhrystone.bin -e tests\tracebundle_inst_data_cpu16_dhrystone.elf -datatrace=4 -decodemode=0x3f10 -tssize=16

    # Linux
    ./install/bin/dqr -t tests/tracebundle_inst_data_cpu16_dhrystone.bin -e tests/tracebundle_inst_data_cpu16_dhrystone.elf -datatrace=4 -decodemode=0x3f10 -tssize=16

**Parameters Explained:**

- ``-datatrace=4``: Enable data trace with index_width=4 (split transaction ID width)
- ``-decodemode=0x3f10``: tracebundle-v1.0.0 (0x10) with has-load(0x100), has-store(0x200), has-value(0x4000), has-addr(0x8000), has-timestamp(0x2000), and has-srcid(0x400) features
- ``-tssize=16``: 16-bit timestamp counter size

**Output Sample:**

.. code-block::

    Trace: Msg # Num: 3, SrcId: 0, Tics: 28822
               # Raw: 84 00 96 70 1e 80 21 20
               # NxtAddr: 0x800031a0, FormatCode: sync(3) SubFormatCode: support(3)
               # ienable(0x0) encoder_mode(0x0) qual_status(0x0) ioptions(0xc0) denable(0x1) dloss(0x0) doptions(0x40)

    Trace: Msg # Num: 4, SrcId: 0, Tics: 28824
               # Raw: 86 00 98 70 e6 40 63 00 00 ff
               # NxtAddr: 0x800031a0, FormatCode: sync(3) SubFormatCode: start(0)
               # branch(0x1) privilege(0x3) context(0x0) address(0x800031a0)
    <_text+2f60>
        800031a0:         85aa        c.mv	a1,a0

    Trace: Msg # Num: 5, SrcId: 0, Tics: 28853
               # Raw: 83 00 b5 70 1a 32 05
               # NxtAddr: 0x800031a2, FormatCode: diff-delta(1)
               # branches(0x3) branch_map(0x2) address(0xa6) notify(0x0) updiscon(0x0) irreport(0x0) irdepth(0x0)
        800031a2:         80c1a503    lw	a0,-2036(gp) # 900001d4 <_impure_ptr>

    Trace: Msg # Num: 6, SrcId: 0, Tics: 94360
               # Raw: 86 00 98 70 21 a9 03 00 20 ff
               # Data Trace Format: split load address,aligned(0)
               # size(0x2) index(0x4) diff(0x0) daddress(0x900001d4)
        800031a6:         a8b1        c.j	80003202 <_malloc_r>
    <_text+2fc2>
        80003202:         1101        c.addi	sp,-32
        80003204:         ca26        c.swsp	s1,20(sp)

    Trace: Msg # Num: 7, SrcId: 0, Tics: 94363
               # Raw: 86 00 9b 70 29 09 00 00 00 f9
               # Data Trace Format: split load data(4)
               # size(0x2) index(0x4) resp(0x2) data(0x90000000)

    Trace: Msg # Num: 8, SrcId: 0, Tics: 94365
               # Raw: 87 00 9d 70 a5 4a c0 04 80 fd 00
               # Data Trace Format: store,aligned address(2)
               # size(0x2) diff(0x2) data_len(0x2) data(0x13012) daddress(0x9000ff54)
        80003206:         00358493    addi	s1,a1,3
        8000320a:         98f1        c.andi	s1,-4
        8000320c:         c84a        c.swsp	s2,16(sp)

    Trace: Msg # Num: 9, SrcId: 0, Tics: 94367
               # Raw: 83 00 9f 70 a5 04 fc
               # Data Trace Format: store,aligned address(2)
               # size(0x2) diff(0x2) data_len(0x0) data(0x1) daddress(0x9000ff50)
        8000320e:         ce06        c.swsp	ra,28(sp)

Example 4: TraceBundle with ZCMP Extension Decode
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This example demonstrates decoding trace data that includes ZCMP (RISC-V Code Size Reduction) instructions. ZCMP instructions require special handling because their encoding overlaps with floating-point instruction encoding.

**Decode Command:**

.. code-block:: bash

    # Windows
    .\install\bin\dqr.exe -t tests\rv32im_zc.bin -e tests\rv32im_zc.elf -datatrace=4 -decodemode=0x7f10 -tssize=16

    # Linux
    ./install/bin/dqr -t tests/rv32im_zc.bin -e tests/rv32im_zc.elf -datatrace=4 -decodemode=0x7f10 -tssize=16

**Parameters Explained:**

- ``-datatrace=4``: Enable data trace with index_width=4
- ``-decodemode=0x7f10``: tracebundle-v1.0.0 (0x10) with has-load(0x100), has-store(0x200), has-csr(0x1000), has-amo(0x2000), has-zcmp(0x4000), has-value(0x8000), has-addr(0x10000), has-timestamp(0x400), and has-srcid(0x200) features
- ``-tssize=16``: 16-bit timestamp counter size
- **Note**: The ``has-zcmp`` feature (0x4000) is critical for correct decoding when ZCMP instructions are present in the code

**Output Sample:**

.. code-block::

    Trace: Msg # Num: 1, SrcId: 0, Tics: 29356
               # Raw: 84 00 ac 72 3e 80 21 20
               # NxtAddr: 0x00000000, FormatCode: sync(3) SubFormatCode: support(3)
               # ienable(0x1) encoder_mode(0x0) qual_status(0x0) ioptions(0xc0) denable(0x1) dloss(0x0) doptions(0x40)

    Trace: Msg # Num: 2, SrcId: 0, Tics: 29367
               # Raw: 86 00 b7 72 e6 08 00 00 40 ff
               # NxtAddr: 0xa0000004, FormatCode: sync(3) SubFormatCode: start(0)
               # branch(0x1) privilege(0x3) context(0x0) address(0xa0000004)
    <_start+4>
        a0000004:         4181        c.li	gp,0

    Trace: Msg # Num: 3, SrcId: 0, Tics: 30846
               # Raw: 82 00 7e 78 14 04
               # NxtAddr: 0xa0000006, FormatCode: addr-only(2)
               # address(0x82) notify(0x0) updiscon(0x0) irreport(0x0) irdepth(0x0)
        a0000006:         06400213    addi	tp,zero,100
        a000000a:         4295        c.li	t0,5
        a000000c:         a0002337    lui	t1,0xa0002
        a0000010:         6385        c.lui	t2,0x1

**Output Sample - ZCMP Operations:**

.. code-block::

    Trace: Msg # Num: 11, SrcId: 0, Tics: 95139
               # Raw: 82 00 a3 73 61 04
               # Data Trace Format: split load address,aligned(0)
               # size(0x2) index(0x1) diff(0x1) daddress(0xa0002000)
        a0000056:         0001        c.addi	zero,0
        a0000058:         4085        c.li	ra,1
        a000005a:         b846        cm.push	{ra},-32

    Trace: Msg # Num: 13, srcId: 0, Tics: 95200
               # Raw: 84 00 e0 73 a5 04 fc ef
               # Data Trace Format: store,aligned address(2)
               # size(0x2) diff(0x2) data_len(0x0) data(0x1) daddress(0xa0000ffc)
        a000005c:         0001        c.addi	zero,0
        a000005e:         ba46        cm.pop	{ra},32

    Trace: Msg # Num: 14, SrcId: 0, Tics: 95282
               # Raw: 82 00 32 74 e1 04
               # Data Trace Format: split load address,aligned(0)
               # size(0x2) index(0x3) diff(0x1) daddress(0xa0000ffc)
        a0000060:         b856        cm.push	{ra,s0},-32

    Trace: Msg # Num: 17, SrcId: 0, Tics: 95330
               # Raw: 83 00 62 74 a5 04 fc
               # Data Trace Format: store,aligned address(2)
               # size(0x2) diff(0x2) data_len(0x0) data(0x1) daddress(0xa0000ff8)
        a0000062:         0001        c.addi	zero,0
        a0000064:         ba56        cm.pop	{ra,s0},32

    Trace: Msg # Num: 19, SrcId: 0, Tics: 95418
               # Raw: 82 00 ba 74 61 fc
               # Data Trace Format: split load address,aligned(0)
               # size(0x2) index(0x1) diff(0x1) daddress(0xa0000ff8)
        a0000066:         b866        cm.push	{ra,s0-s1},-32

    Trace: Msg # Num: 24, SrcId: 0, Tics: 95489
               # Raw: 83 00 01 75 a5 04 fc
               # Data Trace Format: store,aligned address(2)
               # size(0x2) diff(0x2) data_len(0x0) data(0x1) daddress(0xa0000ff4)
        a0000068:         0001        c.addi	zero,0
        a000006a:         ba66        cm.pop	{ra,s0-s1},32

**Key Observations:**

**ZCMP Instructions in the Output:**

- ``cm.push {ra},-32`` (0xb846): Push return address register onto stack, allocate 32 bytes
- ``cm.pop {ra},32`` (0xba46): Pop return address register from stack, deallocate 32 bytes
- ``cm.push {ra,s0},-32`` (0xb856): Push ra and s0 registers, allocate 32 bytes
- ``cm.pop {ra,s0},32`` (0xba56): Pop ra and s0 registers, deallocate 32 bytes
- ``cm.push {ra,s0-s1},-32`` (0xb866): Push ra, s0, and s1 registers, allocate 32 bytes
- ``cm.pop {ra,s0-s1},32`` (0xba66): Pop ra, s0, and s1 registers, deallocate 32 bytes

**ZCMP Trace Characteristics:**

- ZCMP instructions are displayed with their mnemonics (cm.push, cm.pop) in the disassembly
- The decoder correctly identifies these as code size reduction instructions rather than floating-point instructions
- Stack operations (push/pop) are tracked with corresponding data trace entries showing memory writes/reads
- The ``has-zcmp`` feature ensures proper disassembly of these instructions

**Key Points about ZCMP:**

- ZCMP (Code Size Reduction) instructions share encoding space with floating-point instructions
- Without ``has-zcmp`` feature enabled, the decoder may misinterpret ZCMP instructions as floating-point instructions
- The ``has-zcmp`` feature bit must be set in the decodemode when the target code contains ZCMP instructions

Example 5: TraceBundle with CSR and AMO Operations Decode
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This example demonstrates decoding trace data that includes CSR (Control and Status Register) operations and AMO (Atomic Memory Operation) instructions.

**Decode Command:**

.. code-block:: bash

    # Windows
    .\install\bin\dqr.exe -t tests\rv32imc_csr_amo.bin -e tests\rv32imc_csr_amo.elf -datatrace=4 -decodemode=0x3f10 -tssize=16

    # Linux
    ./install/bin/dqr -t tests/rv32imc_csr_amo.bin -e tests/rv32imc_csr_amo.elf -datatrace=4 -decodemode=0x3f10 -tssize=16

**Parameters Explained:**

- ``-datatrace=4``: Enable data trace with index_width=4
- ``-decodemode=0x3f10``: tracebundle-v1.0.0 (0x10) with has-load(0x100), has-store(0x200), has-csr(0x1000), has-amo(0x2000), has-value(0x4000), has-addr(0x8000), has-timestamp(0x2000), and has-srcid(0x400) features
- ``-tssize=16``: 16-bit timestamp counter size

**Output Sample - CSR Operations:**

.. code-block::

    Trace: Msg # Num: 4, SrcId: 0, Tics: 69454
               # Raw: 8b 00 4e 0f 1b 1f 44 40 00 31 03 00 00 00 04
               # Data Trace Format: csr(5) subtype(1)
               # diff(0x0) data_len(0x3) data(0x40101107) addr_msbs(0xc) op_len(0x3) operand(0x0) addr_lsbs(0x1) csr_addr(0x301)
        a0000032:         b0002573    csrrs	a0,mcycle,zero

    Trace: Msg # Num: 5, SrcId: 0, Tics: 69469
               # Raw: 87 00 5d 0f 1b e7 87 12 29 b1 03
               # Data Trace Format: csr(5) subtype(1)
               # diff(0x0) data_len(0x3) data(0x4a44a1f9) addr_msbs(0x2c) op_len(0x3) operand(0x0) addr_lsbs(0x0) csr_addr(0xb00)
        a0000036:         0001        c.addi	zero,0
        a0000038:         34031073    csrrw	zero,mscratch,t1

**Output Sample - AMO Operations:**

.. code-block::

    Trace: Msg # Num: 16, SrcId: 0, Tics: 69686
               # Raw: 8a 00 36 10 0d 1d 00 04 00 74 00 10 00 50
               # Data Trace Format: unified atomic or split atomic address(6) subtype(0)
               # size(0x2) diff(0x2) op_len(0x3) operand(0xa0002000) data_len(0x3) data(0xa0002000) daddress(0xa0002000)
               # amo_data(0xa0002000)
        a000006c:         0001        c.addi	zero,0
        a000006e:         000323af    amoadd.w	t2,zero,(t1)

    Trace: Msg # Num: 17, SrcId: 0, Tics: 69718
               # Raw: 8a 00 56 10 1d 1d 00 00 00 60 00 10 00 50
               # Data Trace Format: unified atomic or split atomic address(6) subtype(1)
               # size(0x2) diff(0x2) op_len(0x3) operand(0x0) data_len(0x3) data(0xa0002000) daddress(0xa0002000)
               # amo_data(0xa0002000)
        a0000072:         0001        c.addi	zero,0
        a0000074:         606323af    amoand.w	t2,t1,(t1)

**Key Observations:**

**CSR Trace Format:**

- **Data Trace Format**: ``csr(5)`` indicates a CSR operation trace packet
- **subtype**: Different subtypes for different CSR operations (read, write, set, clear)
- **csr_addr**: The address of the CSR being accessed (e.g., 0x301 for misa, 0xb00 for mcycle)
- **data**: The value read from or written to the CSR
- **operand**: The source register value for CSR write operations

**AMO Trace Format:**

- **Data Trace Format**: ``unified atomic or split atomic address(6)`` indicates an AMO operation
- **subtype**: Different subtypes for different AMO operations:

  - subtype(0): AMOADD
  - subtype(1): AMOAND
  - subtype(2): AMOXOR
  - subtype(4): AMAX
  - subtype(5): AMAXU/AMOMINU
  - subtype(6): AMOMIN

- **daddress**: The memory address for the atomic operation
- **data**: The data value involved in the atomic operation
- **operand**: The operand value for the atomic operation
- **amo_data**: The result of the atomic operation

**Supported AMO Instructions:**

- ``amoswap.w``: Atomic swap
- ``amoadd.w``: Atomic add
- ``amoand.w``: Atomic AND
- ``amoxor.w``: Atomic XOR
- ``amomax.w``/``amomaxu.w``: Atomic maximum (signed/unsigned)
- ``amomin.w``/``amominu.w``: Atomic minimum (signed/unsigned)
- ``lr.w``/``sc.w``: Load-reserved / Store-conditional

Trace Packet Output Format Description
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block::

    Trace: Msg # Num: 1, SrcId: 0, Tics: 634

This line contains three fields: Num, SrcId, and Tics. Num is a unique identifier assigned by the decoder software; SrcId is the source ID parsed from the trace packet; Tics/Time is the complete timestamp calculated from the timestamp information within the trace packet.

.. code-block::

               # Raw: 85 02 7a 73 8e 1d 00 80

This line shows the raw data of the trace packet, with each byte represented in hexadecimal.

.. code-block::

               # NxtAddr: 0x80001d8e, FormatCode: sync(3) SubFormatCode: start(0)

NxtAddr is the next instruction address predicted by the decoder, calculated based on the trace packet information and the current instruction. FormatCode indicates the specific format of the trace packet.

.. code-block::

               # branch(0x1) privilege(0x3) context(0x0) address(0x80001d8e)

These are the individual fields decoded from the raw trace packet data.

- To learn about the packet formats and features supported by Nuclei Trace hardware, please refer to the <Nuclei_Trace_Bundle_Specification.pdf> document.
- For more detailed information about trace formats, please refer to the <RISC-V Etrace v1.0> and <RISC-V Etrace v2.0> specifications. Please visit https://github.com/riscv-non-isa/riscv-trace-spec/releases/tag/v2.0-20250616 for more details about etrace.

Common Problem Troubleshooting and Solutions
--------------------------------------------

- **Dependency Tool**: TraceDecoder requires the RISC-V version of the ``objdump`` tool to parse the ELF file's symbol table and perform disassembly
- **File Path**: If files specified with ``-t`` and ``-e`` are not in the current directory, full paths need to be provided
- **Decode Mode**: Ensure the selected decode mode matches the actual format of the trace data, otherwise decoding may fail
- **Memory Usage**: When processing large trace files, ensure the system has sufficient memory resources

Default (etrace-v1.0) Decoding srcid Mismatch Issue
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

After adding the -debug parameter, the error scenario is as follows: nm.srcId shows multiple abnormal values. In this case, try adding ``-decodemode=0x2`` or ``-decodemode=0x3`` for decoding

.. code-block::

    Trace: Msg # Num: 1, SrcId: 0, tics: 82901

    Raw: 85 03 d5 01 32 20 01 f2
    NxtAddr: 0x00000000, FormatCode: diff-delta(1)
    branches(0x1f) branch_map(0x64024064) address(0xffffffff) notify(0x1) updisc0n(0x1) irreport(0x1) irdepth(0x1)
    state:0
    readNewTraceMessage:true
    readDataTrace:0
    nm.srcId 0x20, srcid 0x0, nm.srcId != srcid, ignored
    state:0
    readNewTraceMessage:true
    readDataTrace:0
    nm.srcId 0x8, srcid 0x0, nm.srcId != srcid, ignored
    state:0
    readNewTraceMessage:true
    readDataTrace:0
    nm.srcId 0x16, srcid 0x0, nm.srcId != srcid, ignored
    state:0
    readNewTraceMessage:true
    readDataTrace:0
    nm.srcId 0x28, srcid 0x0, nm.srcId != srcid, ignored

Decoding Exception Scenarios for tracebundle Versions Higher than v1.1.0
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

When the tracebundle version is higher than v1.1.0, regardless of whether the software has enabled timestamp or not, the tssize parameter must be passed during decoding. If the CPU is configured with MMU, the contextsize parameter must also be passed, otherwise the following decoding phenomena may occur

.. code-block::

    trace_decoder\bin>dqr -t core0_trace_02.bin -e yunduu_fpga.elf -decodemode=0x111
    Trace: Msg # Num: 1, SrcId: 0
               # Raw: 0d 00 33 00 00 00 00 00 00 00 00 00 42 73 01
               # NxtAddr: 0x1000000000000000, FormatCode: sync(3) SubFormatCode: start(0)
               # branch(0x1) privilege(0x1) time(0x0) context(0x0) address(0x0)
    Error: ElfReader::getInstructionByAddress(): Address 0x1000000000000000 not found in any ELF code section. The ELF file may not contain the code for this trace address.
    Error: status:2 getInstructionByAddress failed - addr:0x1000000000000000
    Error (5) terminated trace decode

Changelog
---------

Version v1.0.0
~~~~~~~~~~~~~~~~~~

This version is developed based on v0.9.0, mainly optimizing code structure, removing redundant code and command line parameters, adding new feature support, and fixing some bugs.

- New features added:

  - Added support for multiple versions of trace hardware (divided into atb2axi and tracebundle categories)
  - Added support for data-trace decoding
  - Added CI automated testing process and new test sets
  - Added TraceDecoder decoding documentation

- Bug fixes:

  - Fixed the issue of discontinuous Msg Num during multi-core decoding
  - Fixed the issue where adjacent trace packets with the same timestamp were incorrectly identified as timestamp overflow
  - Fixed the libc version incompatibility issue on Linux by switching to static linking
  - Fix objdump locale issue on Linux

- Command line parameter changes:

  - Removed command line parameters: ``[-src] [-nosrc] [-file] [-func] [-dasm] [-trace] [-branches] [--strip=path] [-addrsize=n] [-addrsize=n+] [-32] [-64] [-32+] [-addrsep] [-noaddrsep] [-analytics=n] [-noanalytics] [-callreturen] [-nocallreturn] [-msglevel=n] [-r addr] [-nodebug]``
  - Merged ``[-pathunix] [-pathwindows] [-pathraw]`` into ``[-path=unix|windows|raw]``
  - Renamed ``[-hartid=n]`` to ``[-srcid=n]``
  - Added ``[-datatrace=n]``
  - Extended ``[-decodemode=n]``

Command parameter table:

.. code-block::

    Usage: dqr -t tracefile -e elffile [-od objdump]
               [-nofile] [-nofunc] [-nodasm] [-notrace] [-nobranches]
               [-cutpath=path] [-path=unix|windows|raw]
               [-tdasize=n] [-tssize=n] [-freq=n] [-srcid=n] [-decodemode=n] [-datatrace=n]
               [-analytics] [-debug] [-v] [-h]

Version v0.9.0
~~~~~~~~~~~~~~

This is the first release version. Since TraceDecoder does not have a separate release plan, it was released together with Nuclei Studio 2025.10.

Command parameter table:

.. code-block::

    Usage: dqr -t tracefile -e elffile [-od objdump] -basename name
               [-src] [-nosrc] [-file] [-nofile] [-func] [-nofunc] [-dasm] [-nodasm]
               [-trace] [-notrace] [-pathunix] [-pathwindows] [-pathraw] [--strip=path]
               [-addrsize=n] [-addrsize=n+] [-32] [-64] [-32+] [-addrsep] [-noaddrsep] [-analytics | -analytics=n]
               [-noanalytics] [-freq nn] [-tssize=n] [-callreturn] [-nocallreturn] [-branches] [-nobranches] [-msglevel=n]
               [-cutpath=<base path>] [-r addr] [-debug] [-nodebug] [-tdasize=n] [-hartid=n] [-decodemode=n] [-v] [-h]
