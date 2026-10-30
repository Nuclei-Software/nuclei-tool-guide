.. _nuclei_xec:

Nuclei XEC Ethernet User Guide
==============================

Official QEMU networking documentation: https://wiki.qemu.org/Documentation/Networking

QEMU supports multiple network backends. To meet the requirements of the Nuclei Ethernet specification (Nuclei_xec_gen2_doc_v1.0.1) and its intended use cases, the current Nuclei XEC implementation supports both User and TAP mode networking.

User mode is recommended for most use cases. It works on both Linux and Windows, requires no administrator privileges or host network setup, and provides outbound network access through a built-in NAT service. TAP mode is intended for cases that require the guest to communicate directly with the host, other virtual machines, or external hosts, or that require protocols and traffic patterns not supported by User mode. TAP mode provides more complete networking and better performance, but requires administrator privileges and additional host configuration.

.. note::

   Before starting QEMU, check that the Linux device tree matches the QEMU XEC configuration. The guest image must include the Nuclei XEC driver, the XEC node must be enabled, and the PHY address must be ``2`` for the current QEMU XEC model. If a custom ``soc-cfg`` file is used, its ``xec0`` base address, size, interrupt number, and enable state must also match the Linux device tree.

User Mode Networking
--------------------

QEMU's User mode networking uses the Slirp library to provide NAT forwarding in user space. With the ``-nic user`` option, QEMU provides a complete user mode network stack without requiring root privileges. The default virtual network configuration is as follows:

.. code-block:: shell

    guest (10.0.2.15)  <------>  Firewall/DHCP server <-----> Internet
                        |          (10.0.2.2)
                        |
                        ---->  DNS server (10.0.2.3)
                        |
                        ---->  SMB server (10.0.2.4)

QEMU's User mode networking has the following main limitations:

 - Forwarding runs in user space without kernel acceleration, resulting in lower throughput and making this mode unsuitable for high-volume data transfers.
 - ICMP support is limited, so ``ping`` may not work with hosts outside the virtual network.
 - External hosts cannot directly access the guest; network connections must be initiated by the guest.
 - Multicast and direct networking between multiple QEMU instances are not supported.


Both the Windows and Linux versions of Nuclei QEMU include the Slirp library required for User mode networking. To access the network, specify ``-nic user,model=nuclei.xec`` to select the User network backend and the Nuclei XEC model. For example: ``qemu-system-riscv64.exe -M nuclei_evalsoc,download=flashxip -smp 8 -m 2G -cpu nuclei-ux900fd,ext=_zicbom_svpbmt_sscof -bios freeloader.elf -nographic -drive file=/path/to/your/img,if=sd,format=raw -nic user,model=nuclei.xec``.

With a matching guest device tree and XEC-enabled Linux image, the startup log should contain messages similar to the following. The exact timestamps and MAC address may vary:

.. code-block:: console

    [    1.361511] nuclei-xec 10002000.xec eth0: using RGMII interface
    [    1.370178] Generic PHY 10002000.xec-ffffffff:02: attached PHY driver
    [    1.371734] nuclei-xec 10002000.xec eth0: XEC mac at 0x10002000 irq 4
    [    2.850067] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
    udhcpc: broadcasting discover
    udhcpc: broadcasting select for 10.0.2.15, server 10.0.2.2
    udhcpc: lease of 10.0.2.15 obtained from 10.0.2.2, lease time 86400
    adding dns 10.0.2.3

The assigned address, default route, link state, and neighbor resolution can then be checked from the guest. The following commands also confirm that the emulated PHY is attached at address ``2`` and that packets are exchanged without interface errors:

.. code-block:: console

    # ip -4 addr show dev eth0
    2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast qlen 1000
        inet 10.0.2.15/24 brd 10.0.2.255 scope global eth0
    # ip route
    default via 10.0.2.2 dev eth0
    10.0.2.0/24 dev eth0 scope link src 10.0.2.15
    # cat /etc/resolv.conf
    nameserver 10.0.2.3
    # ethtool eth0 | grep -E 'PHYAD|Link detected'
        PHYAD: 2
        Link detected: yes
    # ping -c 1 10.0.2.2 > /dev/null
    # ip neigh show dev eth0
    10.0.2.2 lladdr 52:55:0a:00:02:02 ref 1 used 0/0/0 probes 4 REACHABLE
    # ifconfig eth0
    eth0      Link encap:Ethernet  HWaddr E6:C4:F2:16:EC:B1
              inet addr:10.0.2.15  Bcast:10.0.2.255  Mask:255.255.255.0
              UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
              RX packets:4 errors:0 dropped:0 overruns:0 frame:0
              TX packets:15 errors:0 dropped:0 overruns:0 carrier:0

For normal network use, ``wget`` can retrieve a web page or download a file from an accessible server. These commands depend on the host's DNS and external network connectivity when a domain name or external server is used:

.. code-block:: console

    # wget -T 10 -O - http://<server>/
    # wget -T 10 -O /tmp/file.bin http://<server>/file.bin

Use ``netstat`` to inspect the routing table, active TCP and UDP sockets, or listening TCP ports:

.. code-block:: console

    # netstat -rn
    # netstat -tn
    # netstat -un
    # netstat -ltn

To verify TCP and an application-layer protocol without depending on Internet access, start a temporary HTTP server on the host:

.. code-block:: shell

    $ python3 -m http.server 18080 --bind 127.0.0.1

Add a ``guestfwd`` rule to the User backend. It maps the guest-visible address ``10.0.2.100:80`` to the temporary server on ``127.0.0.1:18080``:

.. code-block:: shell

    -nic user,model=nuclei.xec,guestfwd=tcp:10.0.2.100:80-tcp:127.0.0.1:18080

The guest can then retrieve content with ``wget``. A successful transfer confirms that TCP and HTTP traffic pass through XEC and the User backend. The response body and transfer size depend on the directory served by the host and are abbreviated below:

.. code-block:: console

    # wget -T 10 -O - http://10.0.2.100/
    Connecting to 10.0.2.100 (10.0.2.100:80)
    writing to stdout
    ...
    -                    100% |********************************|   876  0:00:00 ETA
    written to stdout

TAP Mode Networking
-------------------

QEMU's TAP mode networking is a high-performance, full-featured networking mode. It connects the guest's network interface directly to the host's physical or virtual network, enabling bidirectional communication between the guest and the host, external networks, and other virtual machines. Unlike User mode networking, TAP mode uses kernel-space forwarding, supports nearly all network protocols, and provides performance close to that of a physical network interface. However, it requires root privileges and manual network configuration. The configuration steps for Linux and Windows are provided below.

Linux
*****

**Host Forwarding Rules**

Configure forwarding rules on the host so that packets from the guest are not blocked or filtered.

.. code-block:: shell

    # Configure IPv4 forwarding rules
    $ cat /proc/sys/net/ipv4/ip_forward # Check whether the value is 1 (usually the default), which indicates that IPv4 forwarding is enabled; otherwise, enable it below
    $ sudo sysctl -w net.ipv4.ip_forward=1
    # If the host uses NAT networking, also configure NAT forwarding rules
    $ sudo iptables -t nat -A POSTROUTING -o ens33 -j MASQUERADE # Replace ens33 with the host's network interface name here and below
    $ sudo iptables -t filter -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
    $ sudo iptables -t filter -A FORWARD -i tap0 -o ens33 -j ACCEPT

**Creating a TAP Device**

To use QEMU's TAP mode networking, create a TAP device on the host to connect the QEMU guest to the host network.

.. code-block:: shell

    $ sudo ip tuntap add mode tap dev tap0 # Create a TAP device; if tap0 is already in use, create tap1, tap2, etc.
    $ sudo ip link set tap0 up # Enable the TAP device
    $ sudo ifconfig tap0 192.168.1.1 netmask 255.255.255.0 # Configure the TAP device's IP address and netmask

**Example QEMU Command**

.. code-block:: shell

    $ qemu-system-riscv64 -M nuclei_evalsoc,download=flashxip -smp 8 -m 2G -cpu nuclei-ux900fd,ext=_zicbom_svpbmt_sscof -bios /path/to/freeloader.elf -nographic -drive file=/path/to/disk.img,if=sd,format=raw -nic tap,ifname=tap0,script=no,downscript=no

**Parameter Descriptions**

- ``-bios``: Specifies the freeloader image, which must be built with the XEC driver enabled.

- ``-nic tap,ifname=tap0,script=no,downscript=no``: XEC is already attached directly to the system bus of the Nuclei QEMU evalsoc machine, so no additional option is required to specify the Ethernet device. Use ``-nic`` to select the TAP network backend and ``ifname`` to specify the host TAP device. The ``script=no,downscript=no`` settings disable QEMU's automatic TAP configuration, leaving the network parameters entirely under user control. If script-based configuration is required, paths to the corresponding scripts can be specified instead.

**Guest Configuration**

- Configure the XEC virtual network interface.

.. code-block:: shell

    $ ifconfig eth0 192.168.1.100 netmask 255.255.255.0 # Configure the XEC virtual network interface's IP address and netmask
    $ route add default gw 192.168.1.1 # Use the TAP device as the default gateway

- Edit ``/etc/resolv.conf`` to configure DNS.

Windows
*******

The following steps were tested on Windows 10.

**Creating a TAP Device**

Creating a TAP device on Windows requires an additional driver package, such as ``tap-windows-9.21.2``, which must be downloaded and installed separately.

After installation, a virtual network device appears under ``Control Panel\Network and Internet\Network Connections``. Rename the device to the name that will be used on the QEMU command line, such as ``tap0``.

**Host Forwarding Rules**

Run the following commands, as well as those in the remaining Windows steps, in an elevated Command Prompt or PowerShell session.

.. code-block:: shell

    # Enable IPv4 forwarding
    $ Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name IPEnableRouter -Value 1 -Type DWord
    $ netsh interface ipv4 set interface "tap0" forwarding=enabled
    $ netsh interface ipv4 set interface "Ethernet0" forwarding=enabled  # Replace Ethernet0 with the actual physical network interface name

**Creating a NAT Rule**

Configure NAT to forward traffic from the subnet shared by the TAP device and the guest to external networks through the host's physical network interface. Using the same TAP and guest IP addresses as in the Linux example above, run:

.. code-block:: shell

    $ New-NetNat -Name "QEMU_NAT" -InternalIPInterfaceAddressPrefix "192.168.1.0/24" # QEMU_NAT is the NAT network name and can be customized

**Configuring Firewall Rules (Optional)**

Depending on the local firewall configuration, the following rules may be required to allow traffic between subnets:

.. code-block:: shell

    # Create an inbound rule to allow NAT-related traffic
    $ New-NetFirewallRule -DisplayName "Allow NAT Inbound" -Direction Inbound -Protocol Any -LocalPort 1024-65535 -Action Allow
    # Create an outbound rule to allow all traffic
    $ New-NetFirewallRule -DisplayName "Allow All Outbound" -Direction Outbound -Action Allow

**Running QEMU**

Run QEMU in the same way as in the Linux environment.
