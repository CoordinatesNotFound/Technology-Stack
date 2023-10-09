# Docker

[TOC]



## 1 Docker概述



### 1.1 Docker动机

- 问题：开发中为每一台机器配置环境非常麻烦，且不能跨平台
- 解决：发布一个项目时带上环境打包（开发打包部署上线，一套流程昨晚）
- Docker思想：通过容器（镜像）将多个应用进行**隔离**；通过隔离机制将服务器充分利用



### 1.2 Docker历史

- 2010，dotCloud，pass的云计算服务；发明容器化技术
- 2013，Docker开源
- 2014，Dicker1.0发布



### 1.3 虚拟机和容器区别

https://blog.csdn.net/thinkwon/article/details/107476886

- 虚拟机
  - 硬件虚拟化：运行一个完整的操作系统，然后在这个系统上安装和运行软件
  - 硬件隔离性强
  - 笨重；启动慢
- 容器
  - 操作系统虚拟化：应用直接运行在宿主机的内核，容器是没有自己的内核的
    - 并不是一个完整的操作系统；本质是一个进程
  - 进程隔离性差
  - 轻巧（最核心环境 + 软件包）；启动快

> 文档地址：https://docs.docker.com/
>
> 仓库地址：https://hub.docker.com/



### 1.4 Docker作用

- 快速交付部署
- 便捷升级和扩缩容
- 简化系统运维
- 高效计算资源利用



### 1.5 Docker概念

- 镜像（image）
  - Docker镜像是一个模板。可以通过这个模板来创建容器服务
  - 通过这个镜像可以创建多个容器（最终服务就是运行在容器中）
- 容器（container）
  - Docker利用容器技术，独立运行一个或多个应用
  - 可以理解为一个简易的操作系统
- 仓库（repository）
  - 存放镜像的地方
  - 分为公有仓库和私有仓库



### 1.6 Run的流程和Docker底层原理

- Run的流程
  1. Docker在本机寻找镜像
  2. 若本机找到则直接使用这个镜像运行
  3. 若本机没找到则去Docker Hub上寻找镜像
  4. 若Docker Hub可以找到，则下载到本机并运行
  5. 若Docker Hub没找到，则返回错误
- Docker工作原理
  - Docker是一个Client-Server的系统，Docker的守护进程运行在主机上，通过Socket从客户端访问该后台进程
  - DockerServer接收到DockerClient的指令，并执行该指令

- Docker比VM快的原因
  - Docker有更少的抽象层
  - Docker利用的是宿主机的内核，VM需要的是Guest OS
  - 新建一个容器的时候，docker不需要像VM一样重新加载一个操作系统内核



## 2 Docker命令

> 参考文档 https://docs.docker.com/reference/



### 2.1 帮助命令

- `docker version` 显示版本信息

- `docker info` 显示系统信息，包括镜像和容器的数量

- `docker <命令> --help` 万能帮助命令



### 2.2 镜像命令

- `docker images ` 查看所有的镜像

  ```shell
  # 示例
  REPOSITORY                   TAG              IMAGE ID       CREATED         SIZE
  scheduler_trader-scheduler   latest           73a6b9b30b30   11 days ago     1.01GB
  hello-world                  latest           feb5d9fea6a5   18 months ago   13.3kB
  
  # 解释
  REPOSITORY	镜像仓库源
  TAG			镜像标签		
  IMAGE ID	镜像ID     
  CREATED		镜像创建时间      
  SIZE		镜像大小
  
  # 可选项
  -a	列出所有的镜像
  -q	只显示镜像的id
  -f	
  ```

- `docker search <镜像>` 搜索镜像

  ```shell
  # 示例
  NAME      DESCRIPTION       						    STARS     	OFFICIAL AUTOMATED
  mysql     MySQL is a widely used, open-source relation…  13955     [OK]
  
  # 可选项
  --filter=STARTS=3000 过滤STARS大于3000的镜像
  ```

- `docker pull <镜像>` 下载镜像

  ```shell
  # 默认下载latest版本
  
  # 可选项
  :tag	指定版本
  ```

- `docker rmi` 删除镜像

  ```shell
  # 可选项
  -f <容器id...>				删除指定镜像
  -f $(docker images -aq)		 删除所有镜像
  ```



### 2.3 容器命令

- `docker run <镜像>` 启动镜像

  ```shell
  # 可选项
  --name="Name"	容器名字
  --d				后台方式运行 # 注意：后台启动容器后，如果docker发现前台没有应用，就会自动停止
  --it			使用交互方式运行
  -p				指定容器的端口	
  -P				随机指定端口
  ```

- `docker ps ` 查看运行的容器

  ```shell
  # 可选项
  -a		列出当前正在运行的容器，带出历史运行过的容器
  -n=?	显示最新创建的容器
  -q		只显示容器id
  ```

- 退出容器
  ```shell
  exit	直接退出并停止
  Ctrl + P + Q 容器退出不停止
  ```

- `docker rm <容器id>` 删除容器

  ```shell
  # 可选项
  -f $(docker ps -aq)		删除所有容器
  ```

- `docker start <容器id>` 启动容器

- `docker restart <容器id>` 重启容器

- `docker stop <容器id>` 停止当前正在运行的容器

- `docker kill <容器id>` 强制停止当前容器



### 2.4 常用其他命令

- `docker logs` 日志

  ```shell
  # 可选项
  -tf		指定时间戳格式
   --tail	要显示的日志条数
  ```

- `docker top <容器id>` 查看进程

  ```shell
  # 示例
  UID          PID       PPID         C        STIME    TTY          TIME           CMD
  999           1407      1384        0       10:17      ?         00:00:00            /bin/sh /opt/rabbitmq/sbin/rabbitmq-server
  ```

- `docker inspect <容器id>` 查看元数据

- `docker exec -it <容器id> bashshell` / `docker attch <容器id> bashshell` 进入当前正在运行的容器

  > 区别：前者进入后开启一个新的终端，可以在里面操作；后者进入容器正在执行的终端，不会启动新的容器

- `docker cp <容器id>:<容器内路径> <目的主机路径>` 从容器内拷贝文件到主机上



## 3 Docker镜像



### 3.1 镜像概念

- 镜像是一种轻量级的、可执行的独立软件包，用来打包软件运行环境和基于运行环境开发的软件，它包含某个软件所需的内容，包括代码、运行时、库、环境变量和配置文件
- 得到镜像的方式
  - 从远程仓库下载
  - 拷贝
  - 制作DockerFile



### 3.2 镜像加载原理

- UnionFS 联合文件系统
  - Union FS是一种分层、轻量级并且高性能的文件系统，支持对文件系统的修改座位一次提交来一层层叠加，同时可以将不同目录挂载到同一个虚拟文件系统下；
  - Union文件系统是Docker镜像的基础。镜像可以通过分层来进行继承，基于基础镜像可以制作各种具体的应用镜像
  - 特性：一次同时加载多个文件系统，但从外部看只能看到一个文件系统；联合加载会把各层文件系统叠加起来，最终文件系统会包含所有的底层文件和目录
- Docker镜像加载原理
  - Docker的镜像实际上由一层一层的文件系统组成
  - bootfs：在Docker镜像的最底层是bootfs；bootfs主要包含bootloader和kernel，bootloader主要是引导加载kernel，Linux刚启动时会加载bootfs文件系统；当boot加载完之后，整个内核就在内存中，bootfs可以卸载了
  - rootfs：在bootfs之上，包含的是标准目录文件，相当于不同操作系统的发行版



### 3.3 分层

- 所有Docker镜像起始于一个基础镜像层，当进行修改或增加新的内容时，就会在当前镜像层上，创建新的镜像层
- 在添加额外镜像层的同时，镜像始终保持当前所有镜像的组合
- 当上层镜像的某个文件是下层镜像的更新版本时，会发生覆盖
- Docker通过存储引擎（新版本采用快照机制）的方式来实现镜像层堆栈，并保证多镜像层对外展示为统一的文件系统
- 镜像是只读的，所有修改或增加的操作都是在顶层新建一层进行；当容器启动时，一个新的可写层被加载到镜像的顶部，也就是容器层（其下都叫做镜像层）



### 3.4 提交镜像

- `docker commit <容器id> <目标镜像名>[:tag]` 提交容器成为一个新的副本

  ```shell
  # 可选项 (和git类似)
  -m="comment" 	注解
  -a="author"		作者
  ```

  > 可以用于保存当前容器的状态



## 4 Docker容器数据卷



### 4.1 容器数据卷概念

- 目的
  - 容器的持久化和同步操作
  - 容器之间数据共享



### 4.2 使用命令挂载容器数据卷

- `docker run -it -v <主机目录>:<容器内目录>` 挂载容器数据卷
- `docker volume ls` 查看所有容器数据卷
- `docker volume inspect`



### 4.4 具名挂载和匿名挂载

- 匿名挂载：不指定主机目录和卷名（`-v <容器内目录>`）
- 具名挂载：指定容器数据卷名字（`-v <卷名>:<容器内目录>`），但不指定主机目录
- 所有的容器数据卷，没有指定主机目录的情况下都在`/var/lib/docker/volumes/xxx/_data`目录下

> 【容器数据卷权限】
>
> `-v <容器内目录> [ro]/[rw]`
>
> - `ro` 只读（只能通过宿主机写，容器内部不能写）
> - `rw` 可读可写（默认）



### 4.5 使用Dockerfile挂载容器数据卷

- 指定容器数据卷后，生成镜像后自动挂载

```dockerfile
# DockerFile

FROM centos

VOLUME ["volume01", "volume02"] # 匿名挂载

CMD echo "----end----"

CMD /bin/bash
```

- 假设构建镜像时没有挂载卷，要手动镜像内挂载



### 4.6 数据卷容器

- `--volumes-from <镜像名>` 共享某个镜像的数据卷
- 删掉其中一个镜像，不影响其他数据卷，因为所有数据卷本质上都是指向宿主机的同一块内存



## 5 Dockerfile



### 5.1 Dockerfile概念

- DockerFile是用来构建镜像的文件，是一个命令参数脚本
- 构建步骤
  1. 编写一个DockerFile文件
  2. docker build构建成为一个镜像
  3. docker run运行镜像
  4. docker push发布镜像



### 5.2 Dockerfile镜像构建过程

- 基本原则：每个保留关键字必须是大写字母

- 执行从上到下顺序执行，每一个指令都会创建提交一层镜像层

- #表示注释

- `docker build -f <Dockerfile文件路径> -t <镜像名>[:tag] <上下文路径>`

  



### 5.3 Dockerfile指令

> 官方指令文档：https://docs.docker.com/engine/reference/builder/

```shell
FROM		# 基础镜像
MAINTAINER	# 镜像作者（姓名+邮箱）
RUN		# 镜像构建需要的命令
ADD		# 叠加内容
WORKDIR		# 镜像的工作目录
VOLUME		# 挂载的目录
EXPOSE		# 暴露端口
CMD		# 指定这个容器启动的时候要运行的命令，只有最后一个会生效，可被docker run的参数替代
ENTRYPONIT	# 指定这个容器启动时要运行的命令，可以追加命令
ONBUILD		# 当构建一个被继承DockerFile，触发
COPY			# 类似ADD，将文件拷贝到镜像中
ENV		# 构建的时候设置环境变量
```





## 6 Docker网络原理



### 6.1 Docker0

- 基本原理
  - 容器启动时会有一个docker分配的网络地址，只要电脑上安装了docker，就会有一个网卡docker0（桥接模式），使用的技术为evth-pair技术
  - evth-pair技术：就是一对虚拟设备接口，成对出现，一段连着协议，一段彼此相连
  - 宿主机能ping通容器，容器之间能ping通



### 6.2 通过link进行容器互联

- `docker run --link <容器名>` 互联（本质上在hosts配置中添加了映射）



### 6.3 自定义网络容器互联

> 【网络模式】
>
> - `bridge` 桥接模式
> - `none` 不配置网络
> - `host` 和宿主机共享网络
> - `container` 容器网络联通

- `docker network create <网络名>`

  ```shell
  # 可选项
  --driver <网络模式>
  --subnet	<子网>
  --gateway	<网关>
  ```

- `docker network connect <网络名> <容器名>`





## 7 Docker-compose容器编排



### 7.1 Compose概念

- Docker-Compose 是Docker官方的开源项目，负责实现对Docker容器集群的快速编排
- 允许用户通过一个单独的docker-compose.yml模版文件来定义一组相关联的应用容器为一个项目
- 核心要素
  - 服务：一个一个应用容器实例
  - 工程：由一组关联的应用容器组成的一个完整业务单元





### 7.2 Compose使用步骤

- 步骤
  1. 编写Dockerfile定义各个微服务
  2. 使用docker-compose.yml定义一个完整业务单元，安排好整体应用中的各个容器
  3. 执行`docker-compose up`启动运行整个应用程序，完成一键部署上线



### 7.3 Compose命令

- 官方文档：https://docs.docker.com/compose/compose-file/03-compose-file/
