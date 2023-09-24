# Linux



## 1 概述



### 1.1 Linux定义

- Linux定义
  - Linus编写的开源操作系统的内核
  - 广义的操作系统



### 1.2 版本

- 内核版本
  - https://www.kernel.org/
  - 内核版本分为三个部分
    - 主版本号
    - 次版本号
    - 末版本号
  - 次版本号是奇数为开发版，偶数为稳定版（2.6以后不再区分！）

- 发行版本

  > 公司对开源的Linux进行修改后发行

  - Redhat
  - Fedora
  - CentOS
  - Debian
  - Ubuntu



### 1.3 虚拟机及系统部署

- VirtualBox下载
  - https://www.virtualbox.org/wiki/Downloads
- CentOS下载
  - http://isoredirect.centos.org/centos/7/isos/x86_64/

- 基本操作
  - `root`
  - `exit`
  - `clear`



## 2 系统操作



### 2.1 帮助命令

- man 帮助

  > man - manual

  - `man [章节] <命令>`

- help 帮助
  - shell自带的命令称为内部命令，其他的是外部命令
  - 内部命令：`help <内部命令>`
  - 外部命令：`<命令> --help`
- info 帮助
  - info帮助比help更详细，作为help的补充



### 2.2 文件与目录基本操作

- pwd 显示当前的目录名称

  - `pwd [OPTION]`

    > 【/ 和 /root的区别】
    > /是根目录
    > /root是root用户的home目录

    - 选项
      - `--help`
      - `--version`

- ls 文件查看

  - `ls [OPTION] [FILENAME...]`
  - 选项
    - `-l`：长格式显示
    - `-a`：显示隐藏文件或隐藏文件夹（文件名以`.`开头）
    - `-r`： 辅助-l选项，按文件名以逆序排序
    - `-t`： 辅助-l -r选项，按时间以逆序排序
    - `-R`：递归显示

- cd 更改当前的操作目录
  - `cd [选项] <目录>`
  - `cd -`：回到之前的目录
  - 路径
    - `/`：根目录
    - `./`：当前目录
    - `../`：上一级目录

- mkdir 创建空目录
  - `mkdir [选项] <目录...>`
    - 选项
      - `-p`：建立多级目录
- rmdir 删除目录
  - `rmdir <目录...>`
- rm 删除目录，可以删除非空目录
  - `rm [选项] <目录...>`
    - 选项
      - `-r`：删除非空目录，非空提示
      - `-f`：辅助-r，非空不提示
- cp 文件复制
  - `cp [选项] <文件名> <目录>`
    - 选项
      - `-r`：复制目录
      - `-v`：显示复制过程
      - `-p`：保留原来时间
      - `-a`：保留原来时间、权限、属组
- mv 文件移动/重命名
  - 改名：`mv [选项] <旧文件名> <新文件名>`
  - 移动：`mv [选项] <文件名> <目录>`
  - 支持移动和重命名同时进行

> 【通配符】
> `*`：匹配所有字符，不限数量
>
> `?`：匹配所有字符，只匹配一个



### 2.3 文本查看

- cat 文本内容显示到终端
  - `cat <文件名>`
- head 查看文件开头（默认10行）
  - `head [-行数] <文件名>`
- tail 查看文件结尾（默认10行）
  - `tail [-行数] [选项] <文件名>`
    - 选项
      - `-f`：同步显示文件更新
- wc 统计文件内容信息
  - `wc [选项] <文件名>`
    - 选项
      - `-l`：查看行数



### 2.4 打包和压缩

- Linux的备份压缩

  - 最早的Linux备份介质是磁带，使用的命令是tar
  - 可以将打包后的磁带文件进行压缩存储，压缩的命令是gzip和bzip2
  - 经常使用的扩展名是`.tar.gz` `.tar.bz2` `.tgz` `.tbz2`

- tar 打包

  - `tar [选项] <打包后文件名> <待打包目录>`

    - `c`：打包

    - `f`：打包为文件

    - `z`：进一步压缩为.gz

    - `j`：进一步压缩为.bz2

      > bz2更高的压缩比比例
      >
      > gz压缩速度更快

- tar 解包

  - `tar [选项] <待解压文件名> [-C 解压后放置目录]`
    - `x`：解包
    - `f`：文件解包
    - `z`：解压缩.gz
    - `j`：解压缩.bz2



### 2.4 文本编辑器vi

- vim

  - `vim <文件名>` 进入文本编辑界面
  - `i` 编辑，进入插入模式
  - `q` 退出

- 多模式

  - 正常模式

    - `i`：开头
    - `I`：本行开头
    - `a`：下一位
    - `A`：末尾
    - `o`：下一行
    - `O`：上一行
    - `:`：进入命令模式
    - `hjkl`：上下左右移动
    - `[行数] yy`：复制整行
    - `y$`：一直复制到结尾
    - `[行数] dd`：剪切整行
    - `d$`：一直剪切到结尾
    - `p`：粘贴
    - `u`：撤销
    - `ctrl r`：撤销重做
    - `x`：删除单个字符
    - `r`：替换单个字符

  - 插入模式

  - 命令模式/末行模式

    - `:`：进入命令模式

    - `esc`：退出命令模式
    - `w [文件名]`：保存文件
    - `wq`：保存退出vim
    - `q!`：不保存退出vim
    - `!<命令>`：临时退出vim执行命令
    - `/<待查找字符>`：查找字符
      - `n`：查找下一个
    - `s/<旧字符>/<新字符>`：替换字符（光标所在行）
    - `%s/<旧字符>/<新字符>/g`：替换字符（全文件）
    - `i,js/<旧字符>/<新字符>/g`：替换字符（从i到j行）
    - `set nu`：显示行号（单次生效）
    - `set nonu`：不显示行号

  - 可视模式

    - `v`：字符可视模式
    - `V`：行可视模式
    - `ctrl+v`：块可视模式



### 2.5 用户管理

- useradd 新建用户

  > 【二级用户】
  >
  > - root 超级管理员
  >
  > - 普通用户

  - `useradd <用户名>`

    > `id <用户名>`：验证用户是否存在

    > /etc/shadow：用户密码所在文件

- userdel 删除用户

  - `userdel [选项] <用户名>`
    - 选项
      - `-r`：删除home目录的所有数据

- passwd 修改用户密码

  - `passwd <用户名> <新密码>`

- usermod 修改用户属性

  - `usermod [选项] <用户名>`
    - 选项
      - `-d <新位置>`：修改home目录位置
      - `-g <用户组>`：修改所属用户组

- chage 修改用户属性

  - `chage [选项] <用户名>`

- groupadd 新建用户组

  - `groupadd <用户组名>`

- groupdel 删除用户组

  - `groupdel <用户组名>`

- su 切换用户

  - 完全切换： `su - <用户名>`

  - 不完全切换： `su <用户名>`

    > 【su和su - 区别】
    >
    > - su  后面不加用户是默认切到 root
    >   su  是不改变当前变量
    >   su - 是改变为切换到用户的变量
    >
    > - su只能获得root的执行权限，不能获得环境变量；而su - 是切换到root并获得root的环境变量及执行权限

- sudo 以其他用户身份执行指令

  - `visudo`：设置需要使用sudo的用户（组）
  - `sudo <命令路径及选项>`：以其他用户身份执行指令，只需输入当前用户的密码

- 用户及用户组配置文件

  - 用户配置文件`/etc/passwd`
    - `用户名称:x(是否需要密码验证):uid:gid:注释:用户home目录位置:用户登录命令解释器目录位置`
  - 用户密码信息`/etc/shadow`
  - 用户组配置文件`/stc/group`
    - `用户组名称:x(是否需要密码验证):gid:其他组设置`



### 2.6 权限管理

- 查看文件权限
  - 权限位：`x<文件类型>xxx<用户权限>xxx<用户组权限>xxx<组其他用户权限>`
  - 文件类型：
    - `-`：普通文件
    - `d`：目录文件
    - `b`：块特殊文件
    - `c`：字符特殊文件
    - `l`：符号链接
    - `f`：命名管道
    - `s`：套接字文件
  - 权限类型：
    - `r`：可读（4）
    - `w`：可写（2）
    - `x`：可执行（1）
  - 目录权限类型
    - `x`：进入目录
    - `rx`：查看目录里的文件名
    - `wx`：修改目录里的文件名
  - 特殊权限
    - `SUID`：用于二进制可执行文件，执行命令时获取文件属主权限（如/user/bin/passwd）
    - `SGID`：用于目录，在该目录下创建新的文件和目录，权限自动更改为该目录的属组
    - `SBIT`：用于目录，在该目录下创建新的文件和目录，仅root和自己可以删除

- chmod 修改文件、目录权限
  - `chmod <操作对象><操作方法><权限类型> <文件名>`
    - 操作对象
      - `u`
      - `g`
      - `o`
    - 操作方法
      - `=`
      - `+`
      - `-`
  - `chmod <三位数字>`
- chown 更改属主、属组
  - `chown <属主> <文件>`
  - `chown :<属组> <文件>`
- chgrp 单独更改属组
  - `chgrp <属组> <文件>`



## 3 服务管理



### 3.1  网络管理

- 网络状态查看

  - 网络查看工具

    - net-tools
      - ifconfig
      - route
      - netstat
    - iproute2
      - ip
      - ss

  - ifconfig 查看网卡

    - `ifconfig [网卡]`

    - 网卡

      - eth0第一块网卡（网络接口）

      - 第一块网卡可能叫做下面的名字

        - eno1 板载网卡

        - ens33 PCI-E网卡

        - enp0s3 无法获取物理信息的PCI-E网卡

          > CentOS7 使用了一致性网络设备命名，以上都不匹配则使用eth0

    - 网络接口命名修改

      1. 网卡命名规则受biosdevname和net.ifnames两个参数影响
      2. 编辑/etc/default/grub文件，增加biosdevname=0 net.ifnames=0
      3. 更新grub：`# grub2-mkconfig -o /boot/grub2/grub.cfg`
      4. 重启：`# reboot`

  - mii-tool 查看网卡物理连接情况

    - `mii-tool <网卡名>`

  - route 查看网关

    - `route -n`
    - 使用-n参数不解析主机名route

- 网络配置

  - route 添加网关
    - `route add default gw <网关ip>` 默认网关
    - `route add -host <指定ip> gw <网关ip>` 添加主机路由
    - `route add -net <指定网段> netmask <子网掩码> gw <网关ip>` 添加网段路由
  - ip 网络命令集合
    - `ip addr ls` 查看网卡
    - `ip link set dev <接口> up` 网卡eth0启用
    - `ip addr add 10.0.0.1/24 dev <接口>` 添加主机路由
    - `ip route add 10.0.0/24 via 192.168.0.1` 添加网段的路由
  - if 网络命令集合
    - `ifconfig <接口> <ip> [netmask]` 配置网卡
    - `ifup <接口>` 网卡启用 
    - `ifdown <接口>` 网卡禁用

- 网络故障排除

  - ping 测试网路是否通

    - `ping <ip/域名>`

  - traceroute 跟踪网路

    - `traceroute [-w 秒数] <ip/域名> `

  - mtr 显示更丰富网络信息

    - `mtr <ip/域名>`

  - nslookup 解析域名为ip

    - `nslookup <域名>`

  - telnet 检测端口是否畅通

    - `telnet <ip/域名> <端口>`

  - tcpdump 抓包

    - `tcpdump [选项] port <端口>` 捕获端口
    - `tcpdump [选项] host <ip>` 捕获主机
    - `tcpdump [选项] host <ip> and port <端口>` 捕获主机和端口
      - 选项
        - `-i any`：抓所有包
        - `-n`：域名解析为ip
        - `-w <文件>`：数据包抓取后保存到文件

  - netstat 查看服务监听地址

    - `netstat [选项]`

      - `-n`：域名解析为ip
      - `-t`：tcp包
      - `-p`：进程
      - `-l`：服务为监听等待连接

      > - 127.0.0.1 环回测试地址，代表本机IP地址，访问127.0.0.1:80表示本机的80号端口；
      >   0.0.0.0 网络地址，0.0.0.0:80也表示本机IP地址，以外网的方式访问
      >
      > - 如果服务器监听0.0.0.0，则这个可以被外部网络访问；
      >   而监听127.0.0.1， 则这个端口只能被本机访问

  - ss 查看服务监听地址

    - `ss [选项]`
      - 选项同netstat

- 网络服务管理

  > 两套服务：network和NetworkManager

  - SysV
    - `service network start|stop|restart|status`
    - `chkconfig --list network`
  - systemd
    - `systemctl list-unit-files NetworkManager.service`
    - `systemctl start|stop|restart|enable|disable NetworkManager`

- 网络配置文件

  > 放置于/etc/sysconfig/network-scripts/

  - ifcfg-xxx：网卡配置文件
  - /etc/hosts：主机相关配置文件

  > 查看主机名：`hostname`
  >
  > 修改主机名：`hostnamectl set-hostname <name>`



### 3.2 软件安装

- 软件包管理器

  - CentOS、RedHat使用yum包管理器，软件安装包格式为rpm
  - Debian、Ubuntu使用apt包管理器，软件安装包格式为deb

- rpm包

  - rpm包格式

    - `<软件名称><软件版本><系统版本><平台>.rpm`

      > e.g. `vim-common-7.4.10-5.el7.x86_64.rpm`

  - rpm命令常用参数

    - `-q`：查询软件包
    - `-i`：安装软件包

    - `-e`：卸载软件包

- yum包管理器

  - yum命令常用选项
    - `install`：安装
    - `remove`：卸载
    - `list|grouplist`：查看软件包
    - `update`：升级

- 源代码编译安装

  - `./configure --prefix=xxx`
  - `make -j2`
  - `make install`

- 内核升级

  - rpm格式内核

    - 查看内核版本
      - `uname -r`
    - 升级内核版本
      - `yum install kernel-3.10.0`
    - 升级已安装的其他软件包和补丁
      - `yum update`

  - 源代码编译安装内核

    1. 安装依赖包
    2. 下载并解压缩内核
    3. 配置内核编译参数
       - `make menuconfig|allyesconfig|allnoconfig`
       - 或 使用当前系统内核配置

    4. 查看CPU
       - `lscpu`
    5. 编译
       - `make -j2 -all`
    6. 安装内核
       - `make modules_install`
       - `make install`

- grub
  - grub：系统启动引导程序
  - grub配置文件
    - /etc/default/grub 默认配置
      - `GRUB_DEFAULT`：默认引导启动的内核
      - `GRUB_CMDLINE_LINUX`：引导启动配置项
    - /etc/grub.d 自定义配置
    - /boot/grub2/grub.cfg 
    - grub2-mkconfig -o /boot/grub2/grub.cfg



### 3.3 进程管理

- 进程查看

  > 进程为树形结构；
  > 进程和权限相关

  - ps

    > process state

    - `ps [选项]` 查看运行的进程

      - 选项

        - `-e`：查看更多进程

        - `-f`：查看更多信息

          - `UID`：启动用户ID/有效用户ID

          - `PPID`：父进程ID

            > Linux第一个进程：init进程

        - `-L`：线程（轻量级进程）

  - pstree

    - `pstree` 树状结构显示进程

  - top

    - `top` 显示进程信息和系统信息
      - `xxx min`：最近一次开机到现在时间
      - `xxx user`：当前系统登录用户
      - `load average `：平均负载
      - `Tasks`：进程数
      - `Cpu`：处理器 
      - `KiB Mem`：内存
      - `KiB Swap`：交换分区（虚拟内存）
    - `top -p <进程号>`  显示指定进程信息和系统信息

- 进程控制

  - 调整优先级

    > 每个进程都有一个介于 -20 到 19 之间的 nice 值，值越小优先级越高，抢占资源越多

    - nice 设置优先级。可以给要启动的进程赋予 NI 值，但是不能修改已运行进程的 NI 值
      - `nice -n <新优先级> <命令>`
    - renice 重新设置已运行进程的优先级
      - `renice -n <新优先级> <PID>`

  - 作业控制

    - jobs 查看后台程序

      - `jobs`

      - `fg <程序序号>` 调取后台至前台
      - `<ctrl z>` 挂起到后台

    - & 后台启动

      - `<命令> &` 

- 进程通信

  - 信号：终端用户输入中断命令，通过信号机制停止一个程序的运行
  - 信号的命令
    - `kill -l` 查看所有信号
      - SIGINT：`<ctrl c>` 通知前台进程组终止进程
      - SIGKILL：`kill -9 <PID> ` 立即结束程序，不能被阻塞和处理

- 守护进程和系统日志

  - nohup进程

    - nohup命令使进程忽略挂起（hangup）信号

      - `nohup <命令> &`

      - 与&配合，在前端继续输入指令

    - 关闭终端后，程序继续运行但父进程被杀死，被其他进程收留

    - nohup进程输出放置在nohup.out文件中

  - 守护进程（daemon）

    - 开启Linux时需要启动一系列服务，不需要终端
    - 守护进程的输出放置在系统日志中

  - screen命令：模拟守护进程

    - `screen` 进入screen环境
    - `<ctrl a> d` 退出screen环境
    - `screen  -ls` 查看screen的会话
    - `screen -r <sessionid>`恢复会话

  - 系统日志`/var/log`

    - message：常规日志
    - dmesg：内核启动运行相关信息
    - secure：安全日志
    - cron：计划任务

- 服务管理工具systemctl

  - 服务（提供常见功能的守护进程）集中管理工具

    - service
    - systemctl

  - systemctl常见操作

    - `systemctl start|stop|restart|reload|enable|disable|status <服务名>`

      > 软件包安装的服务单元 `/usr/lib/systemd/system/`

- SELinux

  - MAC（强制访问控制）与DAC（自主访问控制）
  - 查看SELinux的命令
    - `getenforce`
    - `/usr/sbin/sestatus`
    - `ps -Z and ls -Z and id -Z`
  - 关闭SELinux
    - `setenforce 0`
    - `/etc/selinux/sysconfig`



### 3.4 内存和磁盘管理

- 内存和磁盘使用率查看

  - 内存查看

    - `free [选项]`

      - 选项

        - `-m`：以MB为单位
        - `-g`：以GB为单位

        > Mem内存、Swap虚拟内存
        >
        > 内存满了 - 内核随机杀掉内存

    - `top`

  - 磁盘查看

    - `fdisk -l` 查看分区
    - `partd -l` 查看分区
    - `df -h` 查看挂载目录
    - `du <文件名>` 查看文件实际占用的空间

    > 空洞文件：`dd if=<源文件> bs=<文件块大小> count=<复制文件块个数> seek=<跳过文件块个数> of=<目标文件>`

- ext4文件系统

  - Linux支持多种文件系统：

    - ext4
    - xfs
    - NTFS

  - ext4结构

    - 超级块：统计所有文件信息

    - 超级块副本：超级块备份，用于恢复数据

    - inode：记录文件索引、文件名、权限信息等

      > 文件名记录在文件的父目录的inode里

    - datablock：记录数据

      > `ls`显示的文件大小是inode记录的信息，`du`显示的文件大小是实际占用datablock的个数

      > 以datablock为单位记录数据，一个datablock为4KB，所以小文件会浪费空间（用网络文件系统解决）

  - inode与datablock操作

    - cp复制文件：创建了新的inode和datablock

    - mv改名或移动（不离开当前分区）：新建一个文件名，改变文件名和inode映射关系

    - vim编辑文件：改变inode和datablock

      > 使用`echo <文件内容> > <文件>`可以不改变inode

      > vim打开时，会创建`.XXX.swp`文件

    - rm删除文件：把inode和文件名的链接断开

  - 硬链接和软链接：

    - `ln <源文件> <待链接文件名>`：创建硬链接

    - `ln -s <源文件> <待链接文件名>`：创建软链接（符号链接）

      > 【区别】
      >
      > - 硬链接和原来的文件没有什么区别，而且共享一个 inode 号（文件在文件系统上的唯一标识）；而软链接不共享 inode，也可以说是个特殊的 inode，所以和原来的 inode 有区别
      > - 若原文件删除了，则该软连接则不可以访问，而硬连接则是可以的
      > - 由于符号链接的特性，导致其可以跨越磁盘分区，但硬链接不具备这个特性

- 磁盘分区与挂载

  1. fdisk 创建分区
     1. `fdisk <磁盘名>`
     2. `n` 
     3. `p` / `e` 选择主分区或扩展分区
  2. mkfs 分区映射成文件系统
     - `mkfs.<文件系统名> <分区>`
  3. mount 挂载分区到目录下
     - `mount <分区> <目录>`
  4. mount挂在是临时挂载，存在内存中，如果要固化则需要配置`/etc/fstab`
     - `<分区> <目录> <文件系统名> <权限(default)> 0 0 `

  > 如果磁盘>2T，则需要使用parted

- 用户磁盘配额（以xfs为例）

  ```bash
  mkfs.xfs /dev/sdb1
  mkdir /mnt/disk1
  mount -o uquota,gquota /dev/sdb1 /mnt/disk1
  chmod 1777 /mnt/disk1
  xfs_quota -x -v 'report -ugibh' /mnt/disk1 #查看用户限额
  xfs_quota -x -c 'limit -u isoft=5 ihard=10 user1' /mnt/disk1 #配置用户限额，inode软限额为5，硬限额为10
  ```

- 交换分区（虚拟内存）的查看与创建

  - 利用磁盘扩充交换分区

    1. `mkswap <磁盘名> `
    2. `swapon <磁盘名>`

  - 利用文件扩充交换分区

    1. `dd if=/dev/zero bs=4M count=1024 of=/swapfile`
    2. `mkswap <文件名> `
    3. `swapon <文件名>`

    > 配置`/etc/fstab`：`<交换分区> swap <权限(default)> 0 0 `

- RAID

  - RAID概述

    - 磁盘阵列：磁盘组合起来使用

  - RAID的常见级别与含义

    - RAID 0：striping条带方式，提高单盘吞吐率（每块磁盘存一部分数据）
    - RAID 1：mirroring镜像方式，提高可靠性（一份数据写入至少两个磁盘，作为备份）
    - RAID 5： 有奇偶校验（两块磁盘RAID1，校验数据占用一个磁盘量）
    - RAID 10：RAID1和RAID0的结合 （四块磁盘磁盘，两块磁盘RAID1，两块磁盘RAID1，两组RAID组成RAID0，磁盘校验占用两个磁盘量）

  - 软件RAID的使用

    - `mdadm -C <设备名> -a yes -l1 -n2 <磁盘名>...` 用两块磁盘创建RAID1磁盘阵列

    - `mdadm -D <设备名>` 查看RAID

    - `mdadm --stop <设备名>` 停用RAID

      > RAID在磁盘的上层，挂载直接针对RAID

- 逻辑卷LVM管理

  - 逻辑卷：将多块物理卷组成一整块逻辑上连续的”磁盘“

  - 为Linux创建逻辑卷

    1. `pvcreate <磁盘名>...` 创建物理卷
    2. `pvs` 查看物理卷
    3. `vgcreate <物理卷组名> <物理卷名>...` 创建物理卷组
    4. `vgs` 查看物理卷组
    5. `lvcreate -L <大小> -n <逻辑卷名> <物理卷组名> `

    > 文件系统分层：磁盘 - RAID - 物理卷 - 物理卷组 - 逻辑卷 - 分区 - 文件系统 - 目录

  - 动态扩容逻辑卷

    1. `vgextend <物理卷组名> <物理卷名> ` 扩充物理卷组
    2. `lvextend -L +xxxG <逻辑卷名>` 扩充逻辑卷
    3. `xfs_growfs <逻辑卷名>` 告诉文件系统，逻辑卷被扩充了

- 系统综合状态查看

  - 使用sar命令查看系统综合状态
    - `sar [选项] [采样时间间隔] [采样次数]`
      - 选项：
        - `-u`：CPU状态
        - `-r`：内存状态
        - `-b`：磁盘IO状态
        - `-d`：每块磁盘IO状态
        - `-q`：进程状态
  - 使用第三方命令查看网络流量
    - `iftop -P` 默认监控epf0的网络流量



## 4 Shell脚本



### 4.1 Shell概述

- shell定义

  - shell是命令解释器，用于解释用户对操作系统的操作
    - 把用户所执行的命令翻译给内核，内核执行后把结果返回给用户
  - shell有很多
    - `cat /etc/shells` 查看shell
  - CentOS 7默认使用的shell是`bash`

- Linux的启动过程

  1. BIOS（基本输入输出系统）引导介质（硬盘、光盘）
  2. MBR 硬盘可引导部分
  3. BootLoader（grub）选择内核指定内核版本
  4. kernel 内核启动
  5. systemd/init 第一个程序（一号进程）
  6. 系统初始化 
  7. shell 

- shell脚本编写

  - 脚本编写流程

    - UNIX：一条命令只做一件事
    - 为了组合命令和多次执行，使用脚本来保存需要执行的命令
    - 赋予该文件执行权限 `chomod u+x <文件名>`

  - 标准shell脚本元素

    - She-Bang

      - 在计算机领域中，Shebang(也称为Hashbang)是由井号和感叹号构成的字符序列：`#!`

      - 文件中存在shebang 的情况下，系统会分析shebang后的内容，并调用指定的解释器来解释执行文件的内容；如`#!/bin/bash`

        > 如果用`bash ./filename.sh`方式执行，shebang会被当成注释（因为已经指定解释器了）

    - 命令

    - 注释（`#`开头）

- shell脚本执行

  - `bash ./filename.sh` 

  - `./filename.sh` 需要有可执行权限

  - `source ./filename.sh`

  - `. filename.sh`

    > 【前两种执行方式与后两种方式的区别】
    >
    > - 前者会产生一个bash子进程，并在子进程执行命令，不会对当前环境造成影响
    > - 后者不会产生bash子进程，会对当前环境造成影响

- 内部命令和外部命令

  - 内部命令

    - 内部命令实际上是shell程序的一部分，其中包含的是一些比较简单的linux系统命令，这些命令由shell程序识别并在shell程序内部完成运行，通常在linux系统加载运行时shell就被加载并驻留在系统内存中。内部命令是写在bashy源码里面的，其执行速度比外部命令快，因为解析内部命令shell不需要创建子进程。比如：exit，history，cd，echo等。
    - 内建命令不需要创建子进程，对当前shell生效

  - 外部命令

    - 外部命令是linux系统中的实用程序部分，因为实用程序的功能通常都比较强大，所以其包含的程序量也会很大，在系统加载时并不随系统一起被加载到内存中，而是在需要时才将其调用内存。通常外部命令的实体并不包含在shell中，但是其命令执行过程是由shell程序控制的。shell程序管理外部命令执行的路径查找、加载存放，并控制命令的执行。外部命令是在bash之外额外安装的，通常放在/bin，/usr/bin，/sbin，/usr/sbin......等等。可通过`echo $PATH`命令查看外部命令的存储路径，比如：ls、vi等。
    - 外部命令的执行时，会创建一个子进程。这个操作被称为衍生。在执行速度相比内建命令来说，相对要慢些。这也因为外部命令程序通常位于/bin、/usr/bin、/sbin、/usr/sbin查找命令上需要时间。

    > 用type命令可以分辨内部命令与外部命令



### 4.2 管道与重定向

- 管道

  - 管道和信号一样，也是进程通信的方式之一

  - 匿名管道（管道符）是shell编程常用的通信工具

  - 管道符 `|` 将前一个命令的执行结果传递给后面的命令

    - 创建两个命令相应的子进程，并建立连接

    > e.g. 
    >
    > - `cat <> | more`
    > - `cat | ps -f`
    > - `echo 123 | cat `

- 重定向

  - 一个进程默认打开标准输入、标准输出、错误输出三个文件描述符
    - 输入重定向是用文件代替终端进行输入
    - 输出重定向是用文件代替终端进行输出
  - 输入重定向符号
    - `<`
  - 输出重定向符号
    - `>` 文件清空重写
    - `>>` 文件追加
    - `2>` 错误重定向
    -  `&>` 无论正确还是错误都重定向到指定文件

  > 组合使用
  > ```bash
  > cat > /path/to/a/file << EOF
  > I am $USER
  > EOF
  > ```



### 4.3 变量

- 变量定义

  - 命名规则
    - 字母、数字、下划线
    - 不以数字开头

- 变量赋值

  - 变量替换：为变量赋值
  - 赋值方式
    - 变量名=变量值
      - `<变量名>=<变量值>`
    - 使用let
      - `let <变量名>=<变量值>`
    - 将命令赋值给变量
      - `<变量名>=<命令>`
    - 将命令执行结果赋值给变量
      - `<变量名>=$(<命令>)` 
      - 或使用``
  - 变量值有空格等特殊字符可以包含在`""`或`''`中

- 变量引用

  - `${<变量名>}` 对变量的引用

  - `echo ${<变量名>}` 输出变量**值**

    > a=1
    >
    > `echo a` a
    >
    > `echo $a` 1

  - `{}`可以省略，除非和别的量需要区分

- 变量作用范围

  - 默认范围：只在自己的shell中生效。在子进程、父进程中不生效

    > 所以要注意shell脚本执行方式

  - 变量导出

    - `export <变量名>` 让子进程能够获得父进程的变量

  - 变量赋值删除

    - `unset <变量名>`

- 系统环境变量

  - 环境变量：每个shell打开都可以获得的变量

    - `env` 查看当前用户的环境变量
    - `set` 查看当前shell所有变量，包括当前用户的变量

    > `$PATH` 命令搜索路径
    >
    > `$PS1` 当前提示终端
    >
    > `$USER` 当前用户变量

  - 预定义变量

    - `$?` 上一条命令是否运行成功（1-失败；0-成功）
    - `$$` 当前运行进程的PID
    - `$0` 当前运行进程的名称

  - 位置变量

    - 格式：`$1 $ 2 ... $9 ${10}`
    - 用于传递参数

- 环境变量配置文件

  - `/etc/profile` 

  - `/etc/profile.d/`

  - `~/.bash_profile`

  - `~/.bashrc`

  - `/etc/bashrc`

    > 保存在etc下的，是所有用户通用的环境变量
    >
    > 其他保存用户特有的配置



### 4.4 数组

- 定义数组
  - `<数组名>=(<元素1> <元素2> ...)`
- 显示所有元素
  - `echo ${<数组名>[@]}`
- 显示数组元素个数
  - `echo ${#<数组名>[@]}`
- 显示数组第n个元素
  - `echo ${<数组名>[n-1]}`



### 4.5 特殊字符

- 转义

  - `\`

- 引号

  - `"` 不完全引用；会解释变量引用
  - `'` 完全引用；不会解释变量引用
  - ` 执行命令

- 括号

  - 圆括号

    - `()` 单独使用圆括号产生一个子shell；数组初始化
    - `(())` 用于运算

  - 方括号

    - `[]` 测试；数组元素

      ```bash
      [ 5 -gt 4 ]
      echo $?
      ```

    - `[[]]` 测试

      ```bash
      [[ 5 > 4 ]]
      echo $?
      ```

  - 尖括号

    - 重定向

  - 花括号

    - `{}` 输出范围；文件复制

      ```
      echo {0..9}
      ```

      ```bash
      cp /etc/passwd{,.bak}
      ```

- 运算和逻辑

  - 赋值运算符

    - `=` 弱类型赋值

  - 逻辑运算符

    - `&& || !`

  - 算术运算符

    - `+ - * / ++ -- % ` 运算符

    - `expr` 获取运算结果（仅支持整型）

      ```bash
      <变量名>=`expr <int1> <op> <int2>`
      ```

    - `(())` 更便捷获取运算结果

      ```bash
      ((<变量名>=<int1> <op> <int2>))
      ```

- 其他字符

  - `#` 注释
  - `;` 命令分隔
  - `.` 执行命令（当前shell）
  - `:` 空指令
  - `~` 家目录
  - `-` 上一次目录
  - `,` 目录分隔
  - `*` 通配符
  - `?` 条件测试；通配符
  - `$` 取值
  - `|` 管道
  - `&` 后台运行
  - `_` 空格



### 4.6 测试与判断

- 退出

  - `exit` 退出
  - `exit 10` 返回10给shell，1-非正常退出；0-正常退出
  - `$?` 判断上一个进程是否正常退出

- test测试命令

  - 用于检查文件或者比较值
  - 测试类型
    - 文件测试
    - 整数比较测试
    - 字符串测试
  - 简化
    - 可以简化为`[]`
    - 可以简化为`[[]]`，支持`&& || < >`
  - 测试表达式
    - `=` 字符串比较（区分大小写）
    - `-z` 判断变量是不是空
    - `-eq -gt -ge -lt -le` 比较
    - `-e` 判断文件是否存在
    - `-d` 判断文件是否存在且是否为目录
    - `-f` 判断文件是否存在且是否为普通文件 

- if-then
  ```bash
  if [测试条件成立] / if 命令返回值为0
  then 执行相应命令
  fi
  ```

- if-then-else
  ```bash
  if [测试条件成立] / if 命令返回值为0
  then 执行相应命令
  else 执行条件不成立命令
  fi
  ```

- 嵌套if
  ```bash
  if [测试条件成立] / if 命令返回值为0
  then 执行相应命令
  	if [测试条件成立] / if 命令返回值为0
  	then 执行相应命令
  	else 执行条件不成立命令
  	fi
  else 执行条件不成立命令
  	...
  fi
  ```

- case分支
  ```bash
  case "$var" in
  	"case1"|"CASE1"|... )
  	cmd1 ;;
  	"case2"|"CASE2"|... )
  	cmd2 ;;
  	* )
  	cmd_default ;;
  esac
  ```



### 4.7 循环

- for循环
  ```bash
  for 参数 in 列表  # 使用反引号或者$()方式取出命令，命令结果当作列表
  do 执行命令
  done
  ```

  - 批量改名
    ```bash
    for filename in `ls *.mp3` 
    do 
    	mv $filename $(basename $filename .mp3).mp4
    done
    ```

    > 【basename】
    >
    > `basename <文件名> <扩展名>`

    > 【通配符】
    >
    > ```
    > * 匹配文件名中的任何字符串，包括空字符串
    > 
    > ? 匹配文件名中的任何单个字符
    > 
    > [...]   匹配[ ]中所包含的任何字符
    > 
    > [!...]   匹配[ ]中非感叹号!之后的字符。和^的效果一样
    > ```

- C语言风格的for命令
  ```bash
  for((变量初始化;循环判断条件;变量变化))
  do 执行命令
  done
  ```

- while循环
  ```bash
  while 测试是否成立
  do 执行命令
  done
  ```

- 死循环
  ```bash
  while 测试一直成立 
  do 执行命令
  done
  ```

- until循环
  ```bash
  until 测试是否不成立
  do 执行命令
  done
  ```

- break和continue

  - 跳过或退出循环

- 使用循环对命令行参数处理

  -  `$0` 脚本名称
  - `$n` 第n个参数
  - `$*` / `$@` 所有位置参数
  - `$#` 位置参数的数量

  > `shift` 参数左移（删掉首个参数）



### 4.8 函数

- 自定义函数

  ```bash
  function fname(){
  	命令
  }
  ```

- 函数执行
  ```bash
  fname
  ```

- 函数作用范围的变量

  ```bash
  local 变量名
  ```

- 函数参数
  ```bash
  $1 $2 $3....
  ```

- 系统函数库

  - 系统自建函数库
    - `/etc/init.d/functions`
    - 使用`source /etc/init.d/functions`导入函数



### 4.9 脚本控制

- 脚本优先级控制

  - 使用nice和renice调整脚本优先级

  - 避免出现不可控的死循环

    > 使用`ulimit -a`查看资源限制

    - 死循环导致cpu占用过高

    - 死循环导致死机

      > 【fork炸弹】
      >
      > ```bash
      > func(){func|func&}; func #shell中函数可以省略function关键字
      > ```

- 信号捕获

  - 信号

    - kill默认发送15号信号给应用程序
    - ctrl+c发送2号信号给应用程序
    - 9号信号不可阻塞

  - 捕获信号脚本的编写

    ```bash
    trap "echo signal 15" 15
    
    echo $$
    
    while :
    do
    	:
    done
    
    # 捕获15好信号,不能用kill pid,必须用kill -9 pid
    ```



### 4.10 计划任务

- 计划任务
  - 让计算机在指定的时间运行程序

- 一次性计划任务

  - `at 指定执行时间` 

  - `<ctrl+d>` 

  - `atq` 查看任务

    > 注意无法输出到终端，必须重定向

- 周期性计划任务

  - `crontab -e` 配置

    - 配置格式：`分钟 小时 日期 月份 星期 命令`

      > 注意命令路径问题

  - `crontab -l` 查看现有的计划任务

- 延时计划任务

  - 对系统计划任务的优化：如果计划任务到期，机器是关机的，那么它会在机器下次开机后执行计划任务

  - `anacrontab` 延时计划任务

    ```bash
    # /etc/anacrontab
    # period   delay   job-identifier   command
    ```

    - `period` - 这是任务的频率，以天来指定，或者是 `@daily`、`@weekly`、`@monthly` 代表每天、每周、每月一次。你也可以使用数字：`1` - 每天、`7` - 每周、`30` - 每月，或者 `N` - 几天。
    - `delay` - 这是在执行一个任务前等待的分钟数。
    - `job-id` - 这是写在日志文件中任务的独特名字。
    - `command` - 这是要执行的命令或 shell 脚本。

- 计划任务加锁

  - 备份时：不希望同一个任务同一时间运行多个
  - `flock` 锁文件
    - `flock -xn "<锁位置>" -c "<加锁脚本>"`

  - 只有第一个进程执行完毕后，才会执行当前的下一个进程。在第一个进程执行过程中，下一分钟crontab运行flock检测到获得不了锁，就直接退出，直到第一个进程执行完，flock再次获得锁。



## 5 文本操作



### 5.1 元字符

- `.` 匹配除换行符外的任意字符
- `*` 匹配前面的字符，匹配0次或多次
- `[]` 匹配方括号中字符任一个
- `^` 匹配开头
- `$` 匹配结尾
- `\` 转义后面的特殊字符

> 注意正则表达式和通配符的区别



### 5.2 扩展元字符

- `+` 匹配前面的正则表达式1次或多次
- `?` 匹配前面的正则表达式出现0次或者1次
- `|` 匹配前面或者后面的正则表达式



### 5.3 文件的查找命令 

- find 查找文件
  - `find [路径] <查找条件>...`
    - 查找条件
      - `-name` ：文件名；对应的是通配符
      - `-regex`：正则表达式；对应的是正则表达式
      - `-atime`：多少时间之前被访问(hr)
      - `-ctime`：多少时间之前文件节点被更新
      - `-mtime`：多少时间之前文件内容被改动

> 报错 find: paths must precede expression
> 一般条件加上双引号可以解决

- grep 文本内容查找

  - `grep <条件> <文件内容>`

    ```bash
    grep xxx /path | cut -d " " -f 1 # 空格分隔找第一个
    ```

    ```bash
    cut -d ":" -f 7 /etc/passwd | uniq -c # 统计shell数量
    ```

    



### 5.4 行编辑器sed\awk

> 【vim和sed\awk的区别】

- sed 文本内容替换

  - sed的模式空间
    - 基本工作方式：
      1. 将文件以行为单位读取到内存（模式空间）
      2. 使用sed的每个脚本对该行进行操作
      3. 处理完成后输出改行

  - 基本语法
    ```bash
    sed [参数][<script>/<script文件>][文本文件]
    ```

    - 参数
      - `-e`： 以选项中指定的script来处理输入的文本文件
      - `-f`：以选项中指定的script文件来处理输入的文本文件
      - `-n`：仅显示script处理后的结果
      - `-i`：处理结果原样落地到文件
      - `-r`：支持扩展正则表达式
    - 动作：
      - `s` ：取代，可以直接进行取代的工作哩！通常这个 s 的动作可以搭配正则表达式
      - `a `：新增， a 的后面可以接字串，而这些字串会在新的一行出现(目前的下一行)
      - `c` ：取代， c 的后面可以接字串，这些字串可以取代 n1,n2 之间的行
      - `d` ：删除，因为是删除，所以 d 后面通常不接任何东西
      - `i `：插入， i 的后面可以接字串，而这些字串会在新的一行出现(目前的上一行)
      - `p` ：打印，亦即将某个选择的数据印出。通常 p 会与参数 sed -n 一起运行
    - script
      - `<动作>/old/new`

    > 分隔符`/`可以改成`!`

  - sed增强

    - 格式
      - `s/old/new/标志位`

    - 标志位
      - `g`：全局替换
      - `数字`：第几次出现才进行替换
      - `p`：但因模式空间的内容
      - `w <file>`：将模式空间的内容输出到文件

  - 保持空间

    - 是多行的一种操作方式
    - 将内容暂存在保持空间，便于做多行处理

- awk 文本内容统计、按需要格式输出

  - awk概述

    - 用于”规范“的文本处理
    - awk的脚本的流程控制
      - 输入数据前例程`BEGIN{}`
      - 主输入循环`{}`
      - 所有文件读取完成例程`END{}`

  - awk字段

    - 记录和字段

      - 记录：awk每行
      - 字段：使用空格、制表符分割开的单词；可以自己指定分隔的字段

    - 字段的引用

      - `$1 $2 ... $n`

        > `$0`：输出每一条记录

  - 基本语法

    ```bash
    awk [选项参数] 'script' var=value file(s)
    ```

    - 参数
      - `-F '<分隔符>'`：指定字段分隔符

  - awk表达式

    - 赋值操作符
      - `=`
      - `++`
      - `--`
      - ...
    - 算数操作符
      - `+`
      - `-`
      - `/`
      - `*`
      - `%`
    - 系统变量
      - `FS`：输入字段分隔符
      - `OFS`：输出字段分隔符
      - `RS`：记录分隔符；默认为`\n`
      - `NR`：行号
      - `NF`：字段数量；`$NF`-最后一个字段
    - 关系操作符
      - `>`
      - `=`
      - `<`
      - ...
    - 布尔操作符
      - `&&`
      - `||`
      - `!`

  - awk判断和循环

    - 同c语言

  - awk数组

    - 定义：`数组名[索引]=值`
    - 遍历：`for(变量 in 数组名)`

    - 删除：`delete 数组[索引]`

`



## 6 常用服务搭建



### 6.1 防火墙

- 防火墙分类

  - 软件防火墙

    - 包过滤防火墙
    - 应用层防火墙

    > CentOS6默认防火墙：iptables
    >
    > CentOS7默认防火墙：firewallD

  - 硬件防火墙

- iptables的表和链

  - 规则表
    - `filter | nat | mangle | raw`
  - 规则链
    - `INPUT | OUTPUT | FORWARD`
    - `PREROUTING | POSTROUTING`

- iptable过滤规则

  - 优先匹配前序规则
  - 若匹配不上规则表中的规则，则使用默认规则

- iptables的filter表

  - `iptables -t filter <命令> <规则链> <规则>` 过滤

    - 命令

      - `-L`：查看规则链；用`-vnL`查看更详细信息

        ```
        Chain <规则链> (policy <默认过滤规则>)
        target	 prot	opt		source	destination
        ```

      - `-A`：添加规则

        ```bash
        iptables -t filter -A INPUT -s 10.0.0.1 -j DROP # 禁止10.0.0.1的包进入
        ```

      - `-D`：删除规则

      - `-F`：清除所有规则

      - `-P`：更改默认规则

      - `-N`：添加自定义规则链

      - `-X`：删除自定义规则链

      - `-E`：重命名自定义规则链

    - 规则链

      - `INPUT`：进入
      - `OUTPUT`：出去
      - `FORWARD`：转发

    - 规则

      - `-s <ip>`：源ip

      - `-d <ip>`：目的ip

      - `-i <进入接口>`：进入接口

      - `-o <出去接口>`：出去接口

      - `-p <协议>`：指定协议

      - `-j <策略>`：指定策略 - `ACCEPT | DROP`

        ```bash
        iptables -t filter -A INPUT -i eth0 -s 10.0.0.2 -p tcp --dport 80 -j ACCEPT # 指定允许接口、ip、端口
        ```

- iptables的nat表

  - `iptables -t nat <命令> <规则链> <规则>` 地址转换

    - 规则链

      - `PREROUTING`：目的地址转换
      - `POSTROUTING`：源地址转换

    - 规则

      - `-j DNAT --to-destination <ip>`：目的地址转换成指定ip
      - `-j SNAT --to-source <ip>`：源地址转换成指定ip

      ```bash
      iptables -t nat -A PREROUTING -i eth0 -d 114.115.115.117 -p tcp --dport 80 -j DNAT --to-destination 10.0.0.1 # 外网发送包本机服务器，本机服务器转发到内网服务器
      iptables -t nat -A POSTROUTING -o eth0 -s 10.0.0.0/24 -p tcp --dport 80 -j SNAT --to-source 111.112.113.114 # 内网服务器发送包到本机服务器，本机服务器转换后伪装
      ```

- iptables配置文件

  - `/etc/sysconfig/iptables`
  - `service iptables save|start|stop|restart`

- firewallD服务

  - firewallD特点
    - 支持区域zone
    - `firewall-cmd`使用
  - 服务控制
    - `systemctl start|stop|disable|status firewalld.service`
  - 使用
    - `firewall-cmd [选项]`
      - 选项
        - `--state`：查看firewallD运行状态
        - `--zone=<区域>`：指定区域
        - `--list-all`：查看所有规则
        - `--list-interfaces`：查看接口
        - `--list-ports`：查看端口
        - `--list-services`：查看服务
        - `--get-zones`：查看所有区域
        - `--get-default-zone`：查看默认区域
        - `--get-acive-zone`：查看激活区域
        - `--add-service=<服务>`：添加支持服务
        - `--add-port=<端口>/<协议>`：添加支持端口
        - `--remove-service=<服务>`：删除服务
        - `--remove-port=<端口>/<协议>`：删除端口
        - `--permanent`：永久生效
        - `--reload`：重启



### 6.2 SSH服务

- telnet服务
  - 启动
    1. `systemtctl start xinetd.service` 启动xinetd监听端口
    2. `systemctl start telnet.socket` 启动telnet接收数据
  - 问题
    - 明文传输
- SSH服务配置文件
  - `etc/ssh/ssh_config`
    - `Port `：端口
    - `PermitRootLogin`：是否允许root登录
    - `AuthorizedKeysFile`：密钥文件
- SSH命令
  - 启动服务
    - `systemctl status|stop|start|restart|enable|disable sshd.service` 
  - 客户端命令
    - `ssh [-p <端口>] <用户>@<远程>`
- SSH公钥认证
  - 密钥认证原理
    - 使用一对加密字符串，一个称为公钥(public key)， 任何人都可以看到其内容，用于加密；另一个称为密钥(private key)，只有拥有者才能看到，用于解密。 
    - 通过公钥加密过的密文使用密钥可以轻松解密，但根据公钥来猜测密钥却十分困难
  - 命令
    - `ssh-keygen -t rsa` 客户端产生密钥
    - `ssh-copy-id -i <公钥文件>` 拷贝到服务端



### 6.3 FTP服务

- FTP协议介绍

  - 主动模式和被动模式
  - 命令和数据由不同链路传输

- FTP用户

  - 虚拟用户：创建独立的FTP资料
  - 系统用户：可以登录系统的真实用户
    - 用户home目录
  - 匿名用户：任何人无需验证既可登录ftp服务端
    - `var/ftp/`

- vsftpd服务器安装和启动

  - `yum install vsftpd ftp`
  - `systemctl start vsftpd.service`

- vsftpd服务配置文件

  - `/etc/vsftpd/vsftpd.conf` 主配置文件

    - `anonymous_enable` 支持匿名用户
    - `local_enable` 支持本地用户

    - `write_enable` 本地用户可写

  - `/etc/vsftpd/ftpusers` 用户配置文件

  - `/etc/vsftpd/user_list` 用户黑/白名单

- FTP命令

  - `ls` 查看服务端用户文件
  - `!ls` 查看本地文件
  - `put <文件>` 上传文件到服务端
  - `get <文件>` 从服务端下载文件



### 6.4 Samba服务

- 常见共享服务的区别
  - 协议不同
  - 对操作系统的支持程度不同
  - 交互的便利性不同
  
- Samba服务配置文件

  - `/etc/samba/smb.conf`

    ```
    [share]
    	comment=myshare
    	path=/data/share
    	read only=No
    ```

- Samba用户的设置

  - `smbpasswd`
    - `-a` 添加用户
    - `-x` 删除用户
  - `pdbedit`
    - `-L` 查看用户

- Samba服务器启动

  - `systemctl start|stop smb.service`



### 6.5 NFS服务

- NFS服务配置和启动

  - `/etc/exports`

    ```
    /data/share*(rw,sync,all_squash)
    ```

  - `showmount -e localhost`

  - 客户端使用挂载方式访问

    - `mount-t nfs localhost:/data/share/ent`

  - 启动NFS服务

    - `systemctl start|stop nfs.service`



### 6.7 Nginx服务

- Nginx概述

  - Nginx(engine X)是一个高性能的Web和反向代理服务器
  - Nginx支持HTTP、HTTPS和电子邮件代理协议
  - OpenResty是基于Nginx和Lua实现的Web应用网关，集成了大量的第三方模块

- OpenResty

  - 安装
  - 配置和启动
    - `/usr/local/openresty/nginx/conf/nginx.conf`
    - `service openresty start|stop|restart|reload`

- 配置基于域名的虚拟主机
  ```
  server{
  	listen 80;
  	server_name www.servera.com;
  	location / {
  		root html/servera;
  		index index.html index.htm;
  	}
  }
  ```

  

