.. _nuclei_xec:

Nuclei XEC Ethernet User Guide
==============================

Official QEMU networking documentation: https://wiki.qemu.org/Documentation/Networking

QEMU supports multiple network backends. To meet the requirements of the Nuclei Ethernet specification (Nuclei_xec_gen2_doc_v1.0.1) and its intended use cases, the current Nuclei XEC implementation supports both User and TAP mode networking.

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
 - ICMP is generally not supported, so ``ping`` cannot normally be used to reach external networks.
 - External hosts cannot directly access the guest; network connections must be initiated by the guest.
 - Multicast and direct networking between multiple QEMU instances are not supported.


Both the Windows and Linux versions of Nuclei QEMU include the Slirp library required for User mode networking. To access the network, specify ``-nic user,model=nuclei.xec`` to select the User network backend and the Nuclei XEC model. For example: ``qemu-system-riscv64.exe -M nuclei_evalsoc,download=flashxip -smp 8 -m 2G -cpu nuclei-ux900fd,ext=_zicbom_svpbmt_sscof -bios freeloader.elf -nographic -drive file=/path/to/your/img,if=sd,format=raw -nic user,model=nuclei.xec``.

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
