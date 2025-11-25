.. _nuclei_xec:

QEMU9.0上XEC以太网使用指南
==========================

QEMU官方关于network的文档: https://wiki.qemu.org/Documentation/Networking

QEMU中支持多种网络后端方式, 结合我们自己的以太网Spec和使用场景,目前基于Nuclei_xec_gen2_doc_v1.0.1,实现了User和TAP两种模式的以太网。

User模式网络
------------

QEMU的User模式网络基于Slirp库实现用户态NAT转发,通过使用选项 ``-nic user`` ,QEMU可以使用完整的用户模式网络堆栈而不需要root权限。默认的虚拟配置如下:

.. code-block:: shell

    guest (10.0.2.15)  <------>  Firewall/DHCP server <-----> Internet
                        |          (10.0.2.2)
                        |
                        ---->  DNS server (10.0.2.3)
                        |
                        ---->  SMB server (10.0.2.4)

需要注意的是,QEMU的用户网络模式主要存在以下约束:

 - 由于是用户态转发,没有进行内核态加速,所以吞吐量较低,不适合大流量传输
 - 通常不支持ICMP协议,即无法通过 ``ping`` 指令ping通外网
 - 外网无法直接访问guest网络,只能guest发起主动访问
 - 不支持多播以及多QEMU实例的网络互通


Windows版本和Linux版本的Nuclei QEMU上目前都已经集成了User模式网络所需要的Slirp库,所以在使用时只需要通过 ``-nic user,model=nuclei.xec`` 指定使用User模式网络以及使用Nuclei XEC模型即可直接访问网络,例如： ``qemu-system-riscv64.exe -M nuclei_evalsoc,download=flashxip -smp 8 -m 2G -cpu nuclei-ux900fd,ext=_zicbom_svpbmt_sscof -bios freeloader.elf -nographic -drive file=/path/to/your/img,if=sd,format=raw -nic user,model=nuclei.xec`` 。

TAP模式网络
-----------

QEMU的TAP模式网络是一种高性能、全功能的网络模式,核心是将Guest虚拟机的网络接口直接桥接到 Host的物理/虚拟网络中,实现Guest与Host、外网、其他虚拟机的双向直连通信。与User模式网络不同,TAP 模式属于内核态转发,支持几乎所有网络协议,性能接近物理网卡,但需要 root 权限和手动网络配置。Windows和Linux上的详细配置过程如下

Linux环境
*********

**host上转发规则**

host上需要配置转发规则,避免数据包被拦截或过滤

.. code-block:: shell

    # 配置ipv4转发规则
    $ cat /proc/sys/net/ipv4/ip_forward #可以先查看是否为1,一般默认为1,支持ipv4转发,否则需要进行下面的配置
    $ sudo sysctl -w net.ipv4.ip_forward=1
    # 如果host使用了NAT网络模式,那么还需配置NAT转发规则
    $ sudo iptables -t nat -A POSTROUTING -o ens33 -j MASQUERADE #这里的ens33是host网卡名称,配置时需要与自己的网卡名对应,下同
    $ sudo iptables -t filter -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
    $ sudo iptables -t filter -A FORWARD -i tap0 -o ens33 -j ACCEPT

**tap设备创建**

使用qemu的tap模式网络,则主机上必须新建一个tap设备,作为qemu虚拟机和host网络之间的桥梁

.. code-block:: shell

    $ sudo ip tuntap add mode tap dev tap0 #创建tap设备,如果被占用,可以创建新的tap1,2...
    $ sudo ip link set tap0 up #启用tap设备
    $ sudo ifconfig tap0 192.168.1.1 netmask 255.255.255.0 #配置tap设备的ip/mask

**QEMU运行示例**

.. code-block:: shell

    $ qemu-system-riscv64 -M nuclei_evalsoc,download=flashxip -smp 8 -m 2G -cpu nuclei-ux900fd,ext=_zicbom_svpbmt_sscof -bios /path/to/freeloader.elf -nographic -drive file=/path/to/disk.img,if=sd,format=raw -nic tap,ifname=tap0,script=no,downscript=no

**参数说明**

- ``-bios``:指定freeloader,其中需要配置使能XEC驱动

- ``-nic tap,ifname=tap0,script=no,downscript=no`` : 由于Nuclei QEMU的evalsoc中已经直接将XEC挂载到系统总线上了,所以无需额外参数去指定以太网设备,只需通过 ``-nic`` 指定网络模式为tap网桥模式,以及 ``ifname`` 指定使用的host上的tap设备名称, ``script=no,downscript=no`` 则是关闭了qemu对tap设备的自动配置,完全由用户自行控制网络参数,如果需要脚本控制也可以在此给出路径

**虚拟机配置**

- XEC虚拟网卡配置

.. code-block:: shell

    $ ifconfig eth0 192.168.1.100 netmask 255.255.255.0 #配置XEC虚拟网卡ip/mask
    $ route add default gw 192.168.1.1 #将tap设备作为默认路由

- 修改/etc/resolv.conf以配置DNS

Windows环境
***********

本次测试环境为win10

**tap设备创建**

windows上创建tap设备需要安装额外的驱动程序,比如 ``tap-windows-9.21.2`` ,用户需要自行下载安装。

安装成功后,在windows的 ``控制面板\网络`` 和 ``Internet\网络`` 连接下就会多出一个虚拟网络设备,可以将该设备重命名为提供给QEMU命令行使用的名称,比如 ``tap0`` 。

**host转发规则**

以下需要在管理员权限的cmd或者PowerShell中执行,下同

.. code-block:: shell

    # 启用IPv4转发
    $ Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name IPEnableRouter -Value 1 -Type DWord
    $ netsh interface ipv4 set interface "tap0" forwarding=enabled
    $ netsh interface ipv4 set interface "Ethernet0" forwarding=enabled  # Ethernet0需替换为实际物理网卡名称

**创建NAT规则**

将tap设备和虚拟机所在网段的流量通过主机物理网卡转发到外网,这里tap设备和虚拟机IP沿用以上linux系统下的示例,则对应配置如下:

.. code-block:: shell

    $ New-NetNat -Name "QEMU_NAT" -InternalIPInterfaceAddressPrefix "192.168.1.0/24" # QEMU_NAT为NAT网络名称,可自定义

**配置防火墙规则（可选）**

此配置视本地防火墙配置具体情况而定,用于配置允许跨网段流量通过,具体如下:

.. code-block:: shell

    # 创建入站规则允许NAT相关流量
    $ New-NetFirewallRule -DisplayName "Allow NAT Inbound" -Direction Inbound -Protocol Any -LocalPort 1024-65535 -Action Allow
    # 创建出站规则允许所有流量
    $ New-NetFirewallRule -DisplayName "Allow All Outbound" -Direction Outbound -Action Allow

**QEMU运行**

与Linux环境下运行方式一致