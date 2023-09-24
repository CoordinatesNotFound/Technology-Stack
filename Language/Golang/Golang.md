# Golang

[TOC]



## 1 Go语言介绍



### 1.1 Go语言概述

- 定义
  - Google开源
  - 编译型语言
  - 21世纪的C语言
- 特点
  - 开发效率
  - 简单易学
  - 性能



## 2 开发环境准备



### 2.1 开发环境搭建

- 安装
  - Go官网下载地址：https://golang.org/dl/
  - Go官方镜像站（推荐）：https://golang.google.cn/dl/
- 检查
  - 安装过程执行完毕后，可以打开终端窗口，输入`go version`命令，查看安装的Go版本。

- GOROOT和GOPATH

  - `GOROOT`和`GOPATH`都是**环境变量**
    - `GOROOT`：安装go开发包的路径
    - `GOPATH`：是我们的工作空间,保存go项目代码和第三方依赖包
  - 从Go 1.8版本开始，Go开发包在安装完成后会为GOPATH设置一个默认目录，并且在Go1.14及之后的版本中启用了Go Module模式之后，不一定非要将代码写到GOPATH目录下，所以也就不需要我们再自己配置GOPATH了，使用默认的即可。

  - 使用`go env`查看两个路径
    - `set GOPATH=C:\Users\hyn\go`
    - `set GOROOT=D:\Go`

- GOPROXY 

  - 从公共代理镜像中快速拉取所需的依赖代码

  ```shell
  # 配置 GOPROXY 环境变量
  $env:GOPROXY = "https://proxy.golang.com.cn,direct"
  # 还可以设置不走 proxy 的私有仓库或组，多个用逗号相隔（可选）
  $env:GOPRIVATE = "git.mycompany.com,github.com/my/private"
  ```

- Hello World：第一个Go程序

  - 创建项目

    - `go mod init`

      - 使用go module模式新建项目时，通过go mod init 项目名命令对项目进行初始化，该命令会在项目根目录下生成go.mod文件。

      - 例如，使用hello作为我们第一个Go项目的名称，执行如下命令。

        ```shell
        go mod init hello
        ```

    - 编写代码

      - 在该目录中创建一个main.go文件：

        ```go
        package main  // 声明 main 包，表明当前是一个可执行程序
        
        import "fmt"  // 导入内置 fmt 包
        
        func main(){  // main函数，是程序执行的入口
        	fmt.Println("Hello World!")  // 在终端打印 Hello World!
        }
        ```

  - 编译

    - `go build`

      - 表示将源代码编译成可执行文件。

      - 在hello目录下执行：
        ```shell
        go build
        ```

    - 编译得到的可执行文件会保存在执行编译命令的当前目录下，如果是`Windows`平台会在当前目录下找到`hello.exe`可执行文件。

      - 可在终端直接执行该`hello.exe`文件

      - 还可以使用`-o`参数来指定编译后得到的可执行文件的名字。
        ```shell
        go build -o test.exe
        ```

  - `go run`

    - `go run main.go`也可以执行程序
    - 该命令本质上是先在临时目录编译程序然后再执行。

  - `go install`

    - `go install`表示安装
    - 它先编译源代码得到可执行文件，然后将可执行文件移动到`GOPATH`的bin目录下。因为把`GOPATH`下的`bin`目录添加到了环境变量中，所以就可以在任意地方直接执行可执行文件了。



### 2.2 依赖管理

- 依赖管理动机

  - 最早的时候，Go所依赖的所有的第三方库都放在GOPATH这个目录下面。这就导致了**同一个库只能保存一个版本的代码**。

- `go dep`

  - 概述

    - Go语言从v1.5开始开始引入`vendor`模式，如果项目目录下有vendor目录，那么go工具链会优先使用`vendor`内的包进行编译、测试等。
    - `godep`是一个通过vender模式实现的Go语言的第三方依赖管理工具，类似的还有由社区维护准官方包管理工具`dep`。

  - 安装

    - 执行以下命令安装godep工具。
      ```shell
      go get github.com/tools/godep
      ```

  - 基本命令

    - 安装好godep之后，在终端输入`godep`查看支持的所有命令。

      ```bash
      godep save     将依赖项输出并复制到Godeps.json文件中
      godep go       使用保存的依赖项运行go工具
      godep get      下载并安装具有指定依赖项的包
      godep path     打印依赖的GOPATH路径
      godep restore  在GOPATH中拉取依赖的版本
      godep update   更新选定的包或go版本
      godep diff     显示当前和以前保存的依赖项集之间的差异
      godep version  查看版本信息
      ```

    - 使用`godep help [command]`可以看看具体命令的帮助信息。

  - vender机制

    - Go1.5版本之后开始支持，能够控制Go语言程序编译时依赖包搜索路径的优先级。

    - 查找项目的某个依赖包，首先会在项目根目录下的vender文件夹中查找，如果没有找到就会去$GOAPTH/src目录下查找。

- `go module`

  - 概述

    - `go module`是Go1.11版本之后官方推出的版本管理工具，并且从Go1.13版本开始，`go module`将是Go语言默认的依赖管理工具。

  - `GO111MODULE`

    - 要启用go module支持首先要设置环境变量GO111MODULE，通过它可以开启或关闭模块支持，它有三个可选值：off、on、auto，默认值是auto。
      - GO111MODULE=off禁用模块支持，编译时会从GOPATH和vendor文件夹中查找包。
      - GO111MODULE=on启用模块支持，编译时会忽略GOPATH和vendor文件夹，只根据 go.mod下载依赖。
      - GO111MODULE=auto，当项目在$GOPATH/src外且项目根目录有go.mod文件时，开启模块支持。
    - 简单来说，设置GO111MODULE=on之后就可以使用go module了，以后就没有必要在GOPATH中创建项目了，并且还能够很好的管理项目依赖的第三方包信息。
    - 使用 go module 管理依赖后会在项目根目录下生成两个文件`go.mod`和`go.sum`。

  - `go mod`

    - 常用的go mod命令如下：
      ```shell
      go mod download    下载依赖的module到本地cache（默认为$GOPATH/pkg/mod目录）
      go mod edit        编辑go.mod文件
      go mod graph       打印模块依赖图
      go mod init        初始化当前文件夹, 创建go.mod文件
      go mod tidy        增加缺少的module，删除无用的module
      go mod vendor      将依赖复制到vendor下
      go mod verify      校验依赖
      go mod why         解释为什么需要依赖
      ```

  - go.mod文件

    - go.mod文件记录了项目所有的依赖信息，其结构大致如下：
      ```
      module github.com/Q1mi/studygo/blogger
      
      go 1.12
      
      require (
      	github.com/DeanThompson/ginpprof v0.0.0-20190408063150-3be636683586
      	github.com/gin-gonic/gin v1.4.0
      	github.com/go-sql-driver/mysql v1.4.1
      	github.com/jmoiron/sqlx v1.2.0
      	github.com/satori/go.uuid v1.2.0
      	google.golang.org/appengine v1.6.1 // indirect
      )
      ```

    - 其中

      - `module`用来定义包名
      - `require`用来定义依赖包及版本
      - `indirect`表示间接引用

  - `go get`

    - 在项目中执行`go get`命令可以下载依赖包，并且还可以指定下载的版本。
      - 运行`go get -u`将会升级到最新的次要版本或者修订版本(x.y.z, z是修订版本号， y是次要版本号)
      - 运行`go get -u=patch`将会升级到最新的修订版本
      - 运行`go get package@version`将会升级到指定的版本号version
    - 如果下载所有依赖可以使用`go mod download`命令。

  - 整理依赖

    - 在代码中删除依赖代码后，相关的依赖库并不会在`go.mod`文件中自动移除。
    - 这种情况下可以使用`go mod tidy`命令更新`go.mod`中的依赖关系。

  - `go mod edit`

    - 格式化

      - 因为可以手动修改go.mod文件，所以有些时候需要格式化该文件。Go提供了一下命令
        ```shell
        go mod edit -fmt
        ```

    - 添加依赖项
      ```shell
      go mod edit -require=golang.org/x/text
      ```

    - 移除依赖项

      - 如果只是想修改go.mod文件中的内容，那么可以运行go mod edit -droprequire=package path，比如要在go.mod中移除golang.org/x/text包，可以使用如下命令：
        ```shell
        go mod edit -droprequire=golang.org/x/text
        ```

        关于go mod edit的更多用法可以通过`go help mod edit`查看。

- 在项目中使用go module
  - 既有项目
    - 如果需要对一个已经存在的项目启用go module，可以按照以下步骤操作：
      1. 在项目目录下执行`go mod init`，生成一个go.mod文件。
      2. 执行`go get`，查找并记录当前项目的依赖，同时生成一个go.sum记录每个依赖库的版本和哈希值。
  - 新项目
    - 对于一个新创建的项目，我们可以在项目文件夹下按照以下步骤操作：
      1. 执行`go mod init 项目名`命令，在当前项目文件夹下创建一个go.mod文件。
      2. 手动编辑go.mod中的require依赖项或执行`go get`自动发现、维护依赖。



### 2.3 导入本地包

https://www.liwenzhou.com/posts/Go/import-local-package/



## 3 变量和常量

https://www.liwenzhou.com/posts/Go/var-and-const/



## 4 数据类型

https://www.liwenzhou.com/posts/Go/datatype/



## 5 运算符

https://www.liwenzhou.com/posts/Go/operators/



## 6 流程控制

https://www.liwenzhou.com/posts/Go/control-flow/

> 任何需要对外暴露的名字必须以大写字母开头，不需要对外暴露的则应该以小写字母开头。



## 7 数组



### 7.1 数组定义

- 定义方法
  ```go
  var 数组变量名 [元素数量]T
  ```

- 数组的长度必须是常量，并且**长度是数组类型的一部分**。一旦定义，长度不能变

- 数组可以通过下标进行访问，下标是从`0`开始，最后一个元素下标是：`len-1`，访问越界（下标在合法范围之外），则触发访问越界，会panic。



### 7.2 数组初始化

- 方法一

  - 初始化数组时可以使用初始化列表来设置数组元素的值。

- 方法二

  - 按照上面的方法每次都要确保提供的初始值和数组长度一致，一般情况下我们可以让编译器根据初始值的个数自行推断数组的长度
    ```go
    var cityArray = [...]string{"北京", "上海", "深圳"}
    ```

- 方法三

  - 还可以使用指定索引值的方式来初始化数组

    ```go
    a := [...]int{1: 1, 3: 5}
    ```

    

### 7.3 数组遍历

- 方法一
  - for循环遍历
- 方法二
  - for range遍历



### 7.4 多维数组

- 多维数组只有第一层可以使用...来让编译器推导数组长度



### 7.5 其他

- 数组是值类型，赋值和传参会复制整个数组。因此改变副本的值，不会改变本身的值。
- 数组支持 “==“、”!=” 操作符，因为内存总是被初始化过的。
- `[n]*T`表示指针数组，`*[n]T`表示数组指针 。



## 8 切片



### 8.1 切片定义

- 定义
  - 切片（Slice）是一个拥有相同类型元素的可变长度的序列。它是基于数组类型做的一层封装。它非常灵活，支持自动扩容。
  - 切片是一个引用类型，它的内部结构包含`地址`、`长度`和`容量`。切片一般用于快速地操作一块数据集合。

- 定义方法
  ```go
  var name []T
  ```

- 切片容量和长度

  - 切片拥有自己的长度和容量
  - 使用内置的`len()`函数求长度
  - 使用内置的`cap()`函数求切片的容量。

- 切片表达式

  - 切片表达式从字符串、数组、指向数组或切片的指针构造子字符串或切片。它有两种变体：一种指定low和high两个索引界限值的简单的形式，另一种是除了low和high索引界限值外还指定容量的完整的形式。

  - 简单切片表达式

    - 切片的底层就是一个**数组**，所以可以基于数组通过切片表达式得到切片。
    - 切片表达式中的`low`和`high`表示一个索引范围（左闭右开）
    - 容量等于得到的切片的底层数组的容量。
    - 要求：`0 <= low <= high <= len(a)`，否则越界
    - 对切片再执行切片表达式时（切片再切片），high的上限边界是切片的容量cap(a)，而不是长度

  - 完整切片表达式

    - 对于数组，指向数组的指针，或切片a(**注意不能是字符串**)支持完整切片表达式：
      ```go
      a[low : high : max]
      ```

    - 上面的代码会构造与简单切片表达式`a[low: high]`相同类型、相同长度和元素的切片。另外，它会将得到的结果切片的容量设置为`max-low`。

    - 要求：`0 <= low <= high <= max <= cap(a)`

    - 在完整切片表达式中**只有第一个索引值（low）可以省略**；它默认为0。

- 使用make()函数动态构造切片

  - 如果需要动态的创建一个切片，就需要使用内置的`make()`函数：
    ```go
    make([]T, size, cap)
    ```

- 切片本质

  - 切片的本质就是对底层数组的封装，它包含了三个信息：
    - 底层数组的指针
    - 切片的长度（len）
    - 切片的容量（cap）。

- 检查切片是否为空
  - 要检查切片是否为空，请始终使用`len(s) == 0`来判断，而不应该使用`s == nil`来判断。



### 8.2 切片无法直接比较

- 切片之间是不能比较的，不能使用`==`操作符来判断两个切片是否含有全部相等元素。
- 切片唯一合法的比较操作是和`nil`比较。 一个`nil`值的切片并没有底层数组，一个`nil`值的切片的长度和容量都是0；但是，不能说一个长度和容量都是0的切片一定是`nil`



### 8.2 切片赋值

- 拷贝前后两个变量共享底层数组，对一个切片的修改会影响另一个切片的内容
  ```go
  func main() {
  	s1 := make([]int, 3) //[0 0 0]
  	s2 := s1             //将s1直接赋值给s2，s1和s2共用一个底层数组
  	s2[0] = 100
  	fmt.Println(s1) //[100 0 0]
  	fmt.Println(s2) //[100 0 0]
  }
  ```



### 8.3 切片遍历

- 切片的遍历方式和数组是一致的，支持索引遍历和`for range`遍历。



### 8.4 append()方法为切片添加元素

- Go语言的内建函数`append()`可以为切片动态添加元素。 

- 可以一次添加一个元素，可以添加多个元素，也可以添加另一个切片中的元素（后面加…）。

- 通过var声明的零值切片可以在`append()`函数直接使用，无需初始化。

- 每个切片会指向一个底层数组，这个数组的容量够用就添加新增元素。当底层数组不能容纳新增的元素时，切片就会自动按照一定的策略进行**“扩容”**，此时该切片指向的底层数组就会更换。“扩容”操作往往发生在`append()`函数调用时，所以通常都需要用原变量接收append函数的返回值。

  > 按照1，2，4，8，16这样的规则自动进行扩容，每次扩容后都是扩容前的2倍。



### 8.5 使用copy()函数复制切片

- Go语言内建的`copy()`函数可以迅速地将一个切片的数据复制到另外一个切片空间中，`copy()`函数的使用格式如下：
  ```go
  copy(destSlice, srcSlice []T)
  ```



### 8.6 从切片中删除元素

- Go语言中并没有删除切片元素的专用方法，可以使用切片本身的特性来删除元素
- 要从切片a中删除索引为`index`的元素，操作方法是`a = append(a[:index], a[index+1:]...)`







## 9 map



### 9.1 map定义

- 定义
  - map是一种无序的基于`key-value`的数据结构，Go语言中的map是引用类型，必须初始化才能使用。

- 定义方法
  ```go
  map[KeyType]ValueType
  ```

- map类型的变量默认初始值为nil，需要使用make()函数来分配内存。语法为：
  ```go
  make(map[KeyType]ValueType, [cap])
  ```

  - 其中cap表示map的容量，该参数虽然不是必须的，但是我们应该在初始化map的时候就为其指定一个合适的容量。



### 9.2 map基本使用

- map中的数据都是成对出现的
  ```go
  scoreMap := make(map[string]int, 8)
  scoreMap["张三"] = 90
  scoreMap["小明"] = 100
  ```

- map也支持在声明的时候填充元素
  ```go
  func main() {
  	userInfo := map[string]string{
  		"username": "沙河小王子",
  		"password": "123456",
  	}
  	fmt.Println(userInfo) //
  }
  ```



### 9.3 判断某个键是否存在

- 语法
  ```go
  value, ok := map[key]
  ```

- 如果key存在ok为true,v为对应的值；不存在ok为false,v为值类型的零值



### 9.4 map遍历

- 使用`for range`遍历map。
  ```go
  for key, value := range demoMap 
  ```

- 遍历map时的元素顺序与添加键值对的顺序**无关**



### 9.5 使用delete()函数删除键值对

- 使用`delete()`内建函数从map中删除一组键值对，`delete()`函数的格式如下：
  ```go
  delete(map, key)
  ```



### 9.5 按照指定顺序遍历map

- 思路
  1. 取出map中的所有key存入切片keys
  2. 对切片进行排序
  3. 按照排序后的key遍历map



## 10 函数



### 10.1 函数定义

- 定义方法
  ```go
  func 函数名(参数)(返回值){
      函数体
  }
  ```



### 10.2 函数调用

- 调用有返回值的函数时，可以不接收其返回值



### 10.3 参数

- 类型简写

  - 函数的参数中如果相邻变量的类型相同，则可以省略类型
    ```go
    func intSum(x, y int) int {
    	return x + y
    }
    ```

- 可变参数

  - 可变参数是指函数的参数数量不固定。Go语言中的可变参数通过在参数名后加`...`来标识
    ```go
    func intSum2(x ...int) int {
    	fmt.Println(x) //x是一个切片
    	sum := 0
    	for _, v := range x {
    		sum = sum + v
    	}
    	return sum
    }
    ```

  - 可变参数通常要作为函数的最后一个参数。

  - 本质上，函数的可变参数是通过切片来实现的。



### 10.4 返回值

- 通过`return`关键字向外输出返回值。

- 多返回值

  - Go语言中函数支持多返回值，函数如果有多个返回值时必须用`()`将所有返回值包裹起来。
    ```go
    func calc(x, y int) (int, int) {
    	sum := x + y
    	sub := x - y
    	return sum, sub
    }
    ```

- 返回值命名

  - 函数定义时可以给返回值命名，并在函数体中直接使用这些变量，最后通过`return`关键字返回。

  - ```go
    func calc(x, y int) (sum, sub int) {
    	sum = x + y
    	sub = x - y
    	return
    }
    ```

- 返回值补充
  - 当一个函数返回值类型为slice时，nil可以看做是一个有效的slice，没必要显示返回一个长度为0的切片。



### 10.5 变量作用域

- 全局变量
  - 全局变量是定义在函数外部的变量，它在程序整个运行周期内都有效。 在函数中可以访问到全局变量。
- 局部变量
  - 局部变量又分为两种：
    - 函数内定义的变量
      - 无法在该函数外使用
      - **如果局部变量和全局变量重名，优先访问局部变量。**
    - 语句块定义的变量
      - if条件判断、for循环、switch语句上



### 10.6 函数类型与变量

- 函数类型

  - 可以使用`type`关键字来定义一个函数类型，具体格式如下：
    ```go
    type calculation func(int, int) int
    ```

    - 语句定义了一个calculation类型，它是一种函数类型，这种函数接收两个int类型的参数并且返回一个int类型的返回值。

- 函数类型变量

  - 可以声明函数类型的变量并且为该变量赋值
    ```go
    func main() {
    	var c calculation               // 声明一个calculation类型的变量c
    	c = add                         // 把add赋值给c
    	fmt.Printf("type of c:%T\n", c) // type of c:main.calculation
    	fmt.Println(c(1, 2))            // 像调用add一样调用c
    
    	f := add                        // 将函数add赋值给变量f
    	fmt.Printf("type of f:%T\n", f) // type of f:func(int, int) int
    	fmt.Println(f(10, 20))          // 像调用add一样调用f
    }
    ```

    

### 10.7 高阶函数

- 高阶函数分为函数作为参数和函数作为返回值两部分。

- 函数作为参数
  ```go
  func add(x, y int) int {
  	return x + y
  }
  func calc(x, y int, op func(int, int) int) int {
  	return op(x, y)
  }
  func main() {
  	ret2 := calc(10, 20, add)
  	fmt.Println(ret2) //30
  }
  ```

- 函数作为返回值
  ```go
  func do(s string) (func(int, int) int, error) {
  	switch s {
  	case "+":
  		return add, nil
  	case "-":
  		return sub, nil
  	default:
  		err := errors.New("无法识别的操作符")
  		return nil, err
  	}
  }
  ```



### 10.8 匿名函数和闭包

- 匿名函数

  - 函数当然还可以作为返回值，但是在Go语言中函数内部不能再像之前那样定义函数了，只能定义匿名函数。匿名函数就是没有函数名的函数，匿名函数的定义格式如下：
    ```go
    func(参数)(返回值){
        函数体
    }
    ```

  - 匿名函数因为没有函数名，所以没办法像普通函数那样调用，所以匿名函数需要保存到某个变量或者作为立即执行函数
    ```go
    func main() {
    	// 将匿名函数保存到变量
    	add := func(x, y int) {
    		fmt.Println(x + y)
    	}
    	add(10, 20) // 通过变量调用匿名函数
    
    	//自执行函数：匿名函数定义完加()直接执行
    	func(x, y int) {
    		fmt.Println(x + y)
    	}(10, 20)
    }
    ```

  - 匿名函数多用于实现回调函数和闭包。

- 闭包

  - 闭包指的是一个函数和与其相关的引用环境组合而成的实体。简单来说，`闭包=函数+引用环境`
    ```go
    func makeSuffixFunc(suffix string) func(string) string {
    	return func(name string) string {
    		if !strings.HasSuffix(name, suffix) {
    			return name + suffix
    		}
    		return name
    	}
    }
    
    func main() {
    	jpgFunc := makeSuffixFunc(".jpg")
    	txtFunc := makeSuffixFunc(".txt")
    	fmt.Println(jpgFunc("test")) //test.jpg
    	fmt.Println(txtFunc("test")) //test.txt
    }
    ```

  - 闭包在引用外部变量后具有记忆效应，闭包中可以修改变量，变量会随着闭包的生命周期一直存在，此时，闭包如同变量一样拥有了记忆效应。

- defer语句
  - `defer`语句会将其后面跟随的语句进行延迟处理。在`defer`归属的函数即将返回时，将延迟处理的语句按`defer`定义的逆序进行执行，也就是说，先被`defer`的语句最后被执行，最后被`defer`的语句，最先被执行。
  - 由于defer语句延迟调用的特性，所以defer语句能非常方便的处理资源释放问题。比如：资源清理、文件关闭、解锁及记录时间等。
  - defer执行时机
    - 在Go语言的函数中`return`语句在底层并不是原子操作，它分为给返回值赋值和RET指令两步。而`defer`语句执行的时机就**在返回值赋值操作后，RET指令执行前**。



## 11 指针



### 11.1 指针地址和指针类型

- 每个变量在运行时都拥有一个地址，这个地址代表变量在内存中的位置。Go语言中使用`&`字符放在变量前面对变量进行“取地址”操作。 Go语言中的值类型（int、float、bool、string、array、struct）都有对应的指针类型，如：\*int、\*int64、*string等。

- 取变量指针的语法如下：
  ```go
  ptr := &v    // v的类型为T
  ```

- 指针是引用类型变量，需要分配内存空间（初始化）



### 11.2 指针取值

- 可以对指针使用`*`操作，也就是指针取值

- 取地址操作符`&`和取值操作符`*`是一对互补操作符，`&`取出地址，`*`根据地址取出地址指向的值。
- 变量、指针地址、指针变量、取地址、取值的相互关系和特性如下：
  - 对变量进行取地址（&）操作，可以获得这个变量的**指针变量**。
  - 指针变量的值是**指针地址**。
  - 对指针变量进行取值（*）操作，可以获得指针变量**指向的原变量的值**。



### 11.3 new和make

- `new`

  - new是一个内置的函数，它的函数签名如下：
    ```go
    func new(Type) *Type
    ```

    - Type表示类型，new函数只接受一个参数，这个参数是一个类型
    - *Type表示类型指针，new函数返回一个指向该类型内存地址的指针。

  - 使用new函数得到的是**一个类型的指针**，并且该指针对应的值为**该类型的零值**

- `make`

  - make也是用于内存分配的，区别于new，它只用于slice、map以及channel的内存创建，而且它返回的类型就是这三个类型本身，而不是他们的指针类型，因为这三种类型就是引用类型，所以就没有必要返回他们的指针了。make函数的函数签名如下：
    ```go
    func make(t Type, size ...IntegerType) Type
    ```

  > 【new与make的异同】
  >
  > - 二者都是用来做内存分配的。
  > - make只用于slice、map以及channel的初始化，返回的还是这三个引用类型本身；
  > - new用于类型的内存分配，并且内存对应的值为类型零值，返回的是指向类型的指针。



## 12 结构体



### 12.1 自定义类型和类型别名

- 自定义类型

  - Go语言中可以使用`type`关键字来定义自定义类型。自定义类型是定义了一个全新的类型。

  - 可以基于内置的基本类型定义，也可以通过struct定义

    ```go
    //将MyInt定义为int类型
    type MyInt int
    ```

- 类型别名

  - 类型别名规定：TypeAlias只是Type的别名，本质上TypeAlias与Type是同一个类型
    ```go
    type TypeAlias = Type
    ```



### 12.2 结构体定义

- 定义

  - Go语言提供了一种自定义数据类型，可以封装多个基本数据类型，这种数据类型叫结构体，英文名称`struct`。 也就是可以通过`struct`来定义自己的类型了。
  - Go语言中通过`struct`来实现面向对象。

- 定义方法
  ```go
  type 类型名 struct {
      字段名 字段类型
      字段名 字段类型
      …
  }
  ```

  > 同样类型的字段也可以写在一行



### 12.3 结构体实例化

- 只有当结构体实例化时，才会真正地分配内存。也就是必须实例化后才能使用结构体的字段。

- 结构体本身也是一种类型，我们可以像声明内置类型一样使用`var`关键字声明结构体类型。
  ```go
  var 结构体实例 结构体类型
  ```

- 通过`.`来访问结构体的字段（成员变量）

- 匿名结构体

  - 在定义一些临时数据结构等场景下还可以使用匿名结构体。
    ```go
    package main
         
    import (
        "fmt"
    )
         
    func main() {
        var user struct{Name string; Age int}
        user.Name = "小王子"
        user.Age = 18
        fmt.Printf("%#v\n", user)
    }
    ```

  - 创建指针类型结构体

    - 还可以通过使用`new`关键字对结构体进行实例化，得到的是结构体的地址。 

  - 取结构体的地址实例化

    - 使用&对结构体进行取地址操作相当于对该结构体类型进行了一次new实例化操作。
      ```go
      p3 := &person{}
      fmt.Printf("%T\n", p3)     //*main.person
      fmt.Printf("p3=%#v\n", p3) //p3=&main.person{name:"", city:"", age:0}
      p3.name = "七米"
      p3.age = 30
      p3.city = "成都"
      fmt.Printf("p3=%#v\n", p3) //p3=&main.person{name:"七米", city:"成都", age:30}
      ```

    - `p3.name = "七米"`其实在底层是`(*p3).name = "七米"`，这是Go语言帮我们实现的语法糖。

  

  

  ### 12.4 结构体初始化

  - 没有初始化的结构体，其成员变量都是对应其类型的零值。

  - 使用键值对初始化

    - 使用键值对对结构体进行初始化时，键对应结构体的字段，值对应该字段的初始值。
      ```go
      p5 := person{
      	name: "小王子",
      	city: "北京",
      	age:  18,
      }
      fmt.Printf("p5=%#v\n", p5) //p5=main.person{name:"小王子", city:"北京", age:18}
      ```

    - 也可以对**结构体指针**进行键值对初始化

    - 当某些字段没有初始值的时候，该字段可以不写。此时，没有指定初始值的字段的值就是该字段类型的零值。

  - 使用值的列表初始化

    - 初始化结构体的时候可以简写，也就是初始化的时候不写键，直接写值：
      ```go
      p8 := &person{
      	"沙河娜扎",
      	"北京",
      	28,
      }
      fmt.Printf("p8=%#v\n", p8) //p8=&main.person{name:"沙河娜扎", city:"北京", age:28}
      ```

    - 使用这种格式初始化时，需要注意：

      1. 必须初始化结构体的所有字段。
      2. 初始值的填充顺序必须与字段在结构体中的声明顺序一致。
      3. 该方式不能和键值初始化方式混用

- 结构体内存布局

  - 结构体占用一块连续的内存
  - 空结构体不占用内存
  - 拓展阅读：结构体的内存对齐
    - liwenzhou.com/posts/Go/struct-memory-layout/



### 12.4 构造函数

- Go语言的结构体没有构造函数，可以自己实现。 例如，下方的代码就实现了一个`person`的构造函数。
  ```go
  func newPerson(name, city string, age int8) *person {
  	return &person{
  		name: name,
  		city: city,
  		age:  age,
  	}
  }
  ```

- 因为`struct`是值类型，如果结构体比较复杂的话，值拷贝性能开销会比较大，所以该构造函数返回的是结构体指针类型。



### 12.5 方法和接收者

- 定义

  - Go语言中的`方法（Method）`是一种作用于特定类型变量的函数。这种特定类型变量叫做`接收者（Receiver）`。接收者的概念就类似于其他语言中的`this`或者 `self`。

- 定义方法
  ```go
  func (接收者变量 接收者类型) 方法名(参数列表) (返回参数) {
      函数体
  }
  ```

  > 接收者中的参数变量名在命名时，官方建议使用接收者类型名称首字母的小写，而不是`self`、`this`之类的命名。例如，`Person`类型的接收者变量应该命名为 `p`，`Connector`类型的接收者变量应该命名为`c`等。

  > 方法与函数的区别是，函数不属于任何类型，方法属于特定的类型。

  - 示例
    ```go
    //Person 结构体
    type Person struct {
    	name string
    	age  int8
    }
    
    //NewPerson 构造函数
    func NewPerson(name string, age int8) *Person {
    	return &Person{
    		name: name,
    		age:  age,
    	}
    }
    
    //Dream Person做梦的方法
    func (p Person) Dream() {
    	fmt.Printf("%s的梦想是学好Go语言！\n", p.name)
    }
    
    func main() {
    	p1 := NewPerson("小王子", 25)
    	p1.Dream()
    }
    ```

- 指针类型接收者

  - 指针类型的接收者由一个结构体的指针组成，由于指针的特性，调用方法时修改接收者指针的任意成员变量，在方法结束后，修改都是有效的。

- 值类型接收者

  - 当方法作用于值类型接收者时，Go语言会在代码运行时将接收者的值复制一份。在值类型接收者的方法中可以获取接收者的成员值，但修改操作只是针对副本，无法修改接收者变量本身。

> 【什么时候使用指针类型接收者】
>
> 1. 需要修改接收者中的值
> 2. 接收者是拷贝代价比较大的大对象
> 3. 保证一致性，如果有某个方法使用了指针接收者，那么其他的方法也应该使用指针接收者。

- 任意类型添加方法
  - 接收者的类型可以是任何类型，不仅仅是结构体，任何类型都可以拥有方法。 举个例子，我们基于内置的`int`类型使用type关键字可以定义新的自定义类型，然后为我们的自定义类型添加方法。
  - 非本地类型不能定义方法，也就是说不能给别的包的类型定义方法。



### 12.6 结构体的匿名字段

- 结构体允许其成员字段在声明时没有字段名而只有类型，这种没有名字的字段就称为匿名字段。
- 匿名字段的说法并不代表没有字段名，而是默认会采用**类型名**作为字段名，结构体要求字段名称必须唯一，因此**一个结构体中同种类型的匿名字段只能有一个**。



### 12.7 嵌套结构体

- 一个结构体中可以嵌套包含另一个结构体或结构体指针
  ```go
  //Address 地址结构体
  type Address struct {
  	Province string
  	City     string
  }
  
  //User 用户结构体
  type User struct {
  	Name    string
  	Gender  string
  	Address Address
  }
  
  func main() {
  	user1 := User{
  		Name:   "小王子",
  		Gender: "男",
  		Address: Address{
  			Province: "山东",
  			City:     "威海",
  		},
  	}
  	fmt.Printf("user1=%#v\n", user1)//user1=main.User{Name:"小王子", Gender:"男", Address:main.Address{Province:"山东", City:"威海"}}
  }
  ```

- 嵌套匿名字段

- 嵌套结构体内部可能存在相同的字段名。在这种情况下为了避免歧义需要通过指定具体的内嵌结构体字段名。



### 12.8 结构体的“继承”

- 使用结构体也可以实现其他编程语言中面向对象的继承。
  ```go
  //Animal 动物
  type Animal struct {
  	name string
  }
  
  func (a *Animal) move() {
  	fmt.Printf("%s会动！\n", a.name)
  }
  
  //Dog 狗
  type Dog struct {
  	Feet    int8
  	*Animal //通过嵌套匿名结构体实现继承
  }
  
  func (d *Dog) wang() {
  	fmt.Printf("%s会汪汪汪~\n", d.name)
  }
  
  func main() {
  	d1 := &Dog{
  		Feet: 4,
  		Animal: &Animal{ //注意嵌套的是结构体指针
  			name: "乐乐",
  		},
  	}
  	d1.wang() //乐乐会汪汪汪~
  	d1.move() //乐乐会动！
  }
  ```

  

### 12.9 结构体字段的可见性

- 结构体中字段大写开头表示可公开访问，小写表示私有（仅在定义当前结构体的包中可访问）。



### 12.10 结构体与JSON序列化

- JSON(JavaScript Object Notation) 

  - 是一种轻量级的数据交换格式。
  - 易于人阅读和编写。同时也易于机器解析和生成。
  - JSON键值对是用来保存JS对象的一种方式，键/值对组合中的键名写在前面并用双引号`""`包裹，使用冒号`:`分隔，然后紧接着值；多个键值之间使用英文`,`分隔。

  ```go
  //Student 学生
  type Student struct {
  	ID     int
  	Gender string
  	Name   string
  }
  
  //Class 班级
  type Class struct {
  	Title    string
  	Students []*Student
  }
  
  func main() {
  	c := &Class{
  		Title:    "101",
  		Students: make([]*Student, 0, 200),
  	}
  	for i := 0; i < 10; i++ {
  		stu := &Student{
  			Name:   fmt.Sprintf("stu%02d", i),
  			Gender: "男",
  			ID:     i,
  		}
  		c.Students = append(c.Students, stu)
  	}
  	//JSON序列化：结构体-->JSON格式的字符串
  	data, err := json.Marshal(c)
  	if err != nil {
  		fmt.Println("json marshal failed")
  		return
  	}
  	fmt.Printf("json:%s\n", data)
  	//JSON反序列化：JSON格式的字符串-->结构体
  	str := `{"Title":"101","Students":[{"ID":0,"Gender":"男","Name":"stu00"},{"ID":1,"Gender":"男","Name":"stu01"},{"ID":2,"Gender":"男","Name":"stu02"},{"ID":3,"Gender":"男","Name":"stu03"},{"ID":4,"Gender":"男","Name":"stu04"},{"ID":5,"Gender":"男","Name":"stu05"},{"ID":6,"Gender":"男","Name":"stu06"},{"ID":7,"Gender":"男","Name":"stu07"},{"ID":8,"Gender":"男","Name":"stu08"},{"ID":9,"Gender":"男","Name":"stu09"}]}`
  	c1 := &Class{}
  	err = json.Unmarshal([]byte(str), c1)
  	if err != nil {
  		fmt.Println("json unmarshal failed!")
  		return
  	}
  	fmt.Printf("%#v\n", c1)
  }
  ```

  

### 12.11 结构体标签（Tag）

- `Tag`是结构体的元信息，可以在运行的时候通过反射的机制读取出来。 `Tag`在结构体字段的后方定义，由一对**反引号**包裹起来，具体的格式如下：

  ```go
  `key1:"value1" key2:"value2"`
  ```

- 结构体tag由一个或多个键值对组成。键与值使用冒号分隔，值用双引号括起来。同一个结构体字段可以设置多个键值对tag，不同的键值对之间使用空格分隔。





## 13 包



### 13.1 包概述

- Go语言中支持模块化的开发理念，在Go语言中使用`包（package）`来支持代码模块化和代码复用。一个包是由一个或多个Go源码文件（.go结尾的文件）组成，是一种高级的代码复用方案，Go语言为我们提供了很多内置包，如`fmt`、`os`、`io`等。

- 定义方法

  - 可以根据自己的需要创建自定义包。一个包可以简单理解为一个存放`.go`文件的文件夹。该文件夹下面的所有`.go`文件都要在非注释的第一行添加如下声明，声明该文件归属的包。
    ```go
    package packagename
    ```

  - 需要注意一个文件夹下面直接包含的文件只能归属一个包，同一个包的文件不能在多个文件夹下。包名为`main`的包是应用程序的入口包，这种包编译后会得到一个可执行文件，而编译不包含`main`包的源代码则不会得到可执行文件。

- 标识符可见性

  - 在同一个包内部声明的标识符都位于同一个命名空间下，在不同的包内部声明的标识符就属于不同的命名空间。想要在包的外部使用包内部的标识符就需要**添加包名前缀**，例如`fmt.Println("Hello world!")`，就是指调用`fmt`包中的`Println`函数。
  - 如果想让一个包中的标识符（如变量、常量、类型、函数等）能被外部的包使用，那么标识符必须是对外可见的（public）。在Go语言中是通过**标识符的首字母大/小写**来控制标识符的对外可见（public）/不可见（private）的。在一个包内部只有首字母大写的标识符才是对外可见的。

- 包的引入

  - 语法
    ```go
    import importname "path/to/package"
    ```

  - Go语言中禁止循环导入包。
  - 如果引入一个包的时候为其设置了一个特殊_作为包名，那么这个包的引入方式就称为**匿名引入**。一个包被匿名引入的目的主要是为了加载这个包，从而使得这个包中的资源得以初始化。 被匿名引入的包中的init函数将被执行并且仅执行一遍。
  - Go语言中不允许引入包却不在代码中使用这个包的内容，如果引入了未使用的包则会触发编译错误。

- init初始化函数

  - 在每一个Go源文件中，都可以定义任意个如下格式的特殊函数：
    ```go
    func init(){
      // ...
    }
    ```

  - 这种特殊的函数不接收任何参数也没有任何返回值，我们也不能在代码中主动调用它。当程序启动的时候，init函数会按照它们声明的顺序自动执行。

  - 一个包的初始化过程是按照**代码中引入的顺序**来进行的，所有在该包中声明的`init`函数都将被串行调用并且仅调用执行一次。每一个包初始化的时候都是先执行依赖的包中声明的`init`函数再执行当前包中声明的`init`函数。确保在程序的`main`函数开始执行时所有的依赖包都已初始化完成。

  - 同一个module内多个文件初始化顺序：**源文件名字典序**

  - 每一个包的初始化是先从初始化包级别变量开始的。



## 14 接口



### 14.1 接口类型

- 定义方法
  ```go
  type 接口类型名 interface{
      方法名1( 参数列表1 ) 返回值列表1
      方法名2( 参数列表2 ) 返回值列表2
      …
  }
  ```

  - 接口类型名：Go语言的接口在命名时，一般会在单词后面添加er，如有写操作的接口叫Writer，有关闭操作的接口叫closer等。接口名最好要能突出该接口的类型含义。
  - 方法名：当方法名首字母是大写且这个接口类型名首字母也是大写时，这个方法可以被接口所在的包（package）之外的代码访问。

- 实现接口的条件

  - 接口就是规定了一个**需要实现的方法列表**，在 Go 语言中一个类型只要实现了接口中规定的所有方法，那么我们就称它实现了这个接口。

- 面向接口编程

  - PHP、Java等语言中也有接口的概念，不过在PHP和Java语言中需要显式声明一个类实现了哪些接口，在Go语言中使用隐式声明的方式实现接口。只要一个类型实现了接口中规定的所有方法，那么它就实现了这个接口。

- 接口类型变量

  - 个接口类型的变量能够存储所有实现了该接口的类型变量。





### 14.2 值接收者和指针接收者

- 值接收者
  - 使用值接收者实现接口之后，不管是结构体类型还是对应的结构体指针类型的变量都可以赋值给该接口变量。
- 指针接收者
  - 只能用结构体指针变量赋值
  - 并不总是能对一个值求址，所以对于指针接收者实现的接口要额外注意



### 14.3 类型与接口的关系

- 一个类型实现多个接口
  - 一个类型可以同时实现多个接口，而接口间彼此独立，不知道对方的实现。
  - 同一个类型实现不同的接口互相不影响使用。
- 多种类型实现同一接口
  - Go语言中不同的类型还可以实现同一接口。例如在我们的代码世界中不仅狗可以动，汽车也可以动。
  - 一个接口的所有方法，不一定需要由一个类型完全实现，接口的方法可以通过在类型中嵌入其他类型或者结构体来实现。



### 14.4 接口组合

- 接口与接口之间可以通过互相嵌套形成新的接口类型，例如Go标准库`io`源码中就有很多接口之间互相组合的示例。

- 对于这种由多个接口类型组合形成的新接口类型，同样只需要实现新接口类型中规定的所有方法就算实现了该接口类型。

- 接口也可以作为结构体的一个字段

  - 一段Go标准库`sort`源码中的示例
    ```go
    // src/sort/sort.go
    
    // Interface 定义通过索引对元素排序的接口类型
    type Interface interface {
        Len() int
        Less(i, j int) bool
        Swap(i, j int)
    }
    
    
    // reverse 结构体中嵌入了Interface接口
    type reverse struct {
        Interface
    }
    ```

  - 过在结构体中嵌入一个接口类型，从而让该结构体类型实现了该接口类型，并且还可以改写该接口的方法。
    ```go
    // Less 为reverse类型添加Less方法，重写原Interface接口类型的Less方法
    func (r reverse) Less(i, j int) bool {
    	return r.Interface.Less(j, i)
    }
    ```

    - `Interface`类型原本的`Less`方法签名为`Less(i, j int) bool`，此处重写为`r.Interface.Less(j, i)`，即通过将索引参数交换位置实现反转。

    - 一个需要注意的地方是`reverse`结构体本身是不可导出的（结构体类型名称首字母小写），`sort.go`中通过定义一个可导出的`Reverse`函数来让使用者创建`reverse`结构体实例。
      ```go
      func Reverse(data Interface) Interface {
      	return &reverse{data}
      }
      ```

    - 这样做的目的是保证得到的`reverse`结构体中的`Interface`属性一定不为`nil`，否者`r.Interface.Less(j, i)`就会出现空指针panic。

  - sort深入理解

    - http://liuqh.icu/2021/06/08/go/package/11-sort/





### 14.5 空接口

- 空接口定义

  - 空接口是指没有定义任何方法的接口类型。因此任何类型都可以视为实现了空接口。也正是因为空接口类型的这个特性，空接口类型的变量可以存储任意类型的值。

  - 通常我们在使用空接口类型时不必使用`type`关键字声明，可以像下面的代码一样直接使用`interface{}`。
    ```go
    var x interface{}  // 声明一个空接口类型变量x
    ```

- 空接口的应用

  - 空接口作为函数的参数

    - 使用空接口实现可以接收任意类型的函数参数。
      ```go
      // 空接口作为函数参数
      func show(a interface{}) {
      	fmt.Printf("type:%T value:%v\n", a, a)
      }
      ```

  - 空接口作为map的值

    - 使用空接口实现可以保存任意值的字典。
      ```go
      // 空接口作为map值
      	var studentInfo = make(map[string]interface{})
      	studentInfo["name"] = "沙河娜扎"
      	studentInfo["age"] = 18
      	studentInfo["married"] = false
      	fmt.Println(studentInfo)
      ```



### 14.6 接口值

- 由于接口类型的值可以是任意一个实现了该接口的类型值，所以接口值除了需要记录具体**值**之外，还需要记录这个值属于的**类型**。也就是说接口值由“类型”和“值”组成，鉴于这两部分会根据存入值的不同而发生变化，我们称之为接口的`动态类型`和`动态值`。

- 接口值是支持相互比较的，当且仅当接口值的动态类型和动态值都相等时才相等。

  ```go
  var (
  	x Mover = new(Dog)
  	y Mover = new(Car)
  )
  fmt.Println(x == y) // false
  ```

  - 但是有一种特殊情况需要特别注意，如果接口值保存的动态类型相同，但是这个动态类型不支持互相比较（比如切片），那么对它们相互比较时就会引发panic。



### 14.7 类型断言

- 获取动态类型

  - 以借助标准库`fmt`包的格式化打印获取到接口值的动态类型。
  - `fmt`包内部其实是使用反射的机制在程序运行时获取到动态类型的名称

- 获取动态值

  - 从接口值中获取到对应的实际值需要使用类型断言
    ```go
    x.(T)
    ```

    - x：表示接口类型的变量
    - T：表示断言`x`可能是的类型。

  - 该语法返回两个参数，第一个参数是`x`转化为`T`类型后的变量，第二个值是一个布尔值，若为`true`则表示断言成功，为`false`则表示断言失败。

  - 如果对一个接口值有多个实际类型需要判断，推荐使用switch语句来实现。
    ```go
    // justifyType 对传入的空接口类型变量x进行类型断言
    func justifyType(x interface{}) {
    	switch v := x.(type) {
    	case string:
    		fmt.Printf("x is a string，value is %v\n", v)
    	case int:
    		fmt.Printf("x is a int is %v\n", v)
    	case bool:
    		fmt.Printf("x is a bool is %v\n", v)
    	default:
    		fmt.Println("unsupport type！")
    	}
    }
    ```

    

## 15 Error接口和错误处理



### 15.1 Error 接口

- Go 语言中使用一个名为 `error` 接口来表示错误类型。
  ```go
  type error interface {
      Error() string
  }
  ```

- `error` 接口只包含一个方法——`Error`，这个函数需要返回一个描述错误信息的字符串

- 当一个函数或方法需要返回错误时，我们通常是把错误作为最后一个返回值。
  ```go
  func Open(name string) (*File, error) {
  	return OpenFile(name, O_RDONLY, 0)
  }
  ```

- 由于 error 是一个接口类型，默认零值为`nil`。所以我们通常将调用函数返回的错误与`nil`进行比较，以此来判断函数是否返回错误。例如你会经常看到类似下面的错误判断代码。
  ```go
  file, err := os.Open("./xx.go")
  if err != nil {
  	fmt.Println("打开文件失败,err:", err)
  	return
  }
  ```

- 当使用`fmt`包打印错误时会自动调用 error 类型的 Error 方法，也就是会打印出错误的描述信息。



### 15.2 创建错误

- 可以根据需求自定义 error，最简单的方式是使用`errors` 包提供的`New`函数创建一个错误。
  ```go
  func New(text string) error
  ```

- fmt.Errorf

  - 当需要传入格式化的错误描述信息时，使用`fmt.Errorf`是个更好的选择。

  - 为了不丢失函数调用的错误链，使用`fmt.Errorf`时搭配使用特殊的格式化动词`%w`，可以实现基于已有的错误再包装得到一个新的错误。
    ```go
    fmt.Errorf("查询数据库失败，err:%w", err)
    ```



### 15.3 错误结构体类型

- 还可以自己定义结构体类型，实现`error`接口。

- ```go
  // OpError 自定义结构体类型
  type OpError struct {
  	Op string
  }
  
  // Error OpError 类型实现error接口
  func (e *OpError) Error() string {
  	return fmt.Sprintf("无权执行%s操作", e.Op)
  }
  ```



## 16 反射



### 16.1 变量的内在机制

- Go语言中的变量是分为两部分的:
  - 类型信息：预先定义好的元信息。
  - 值信息：程序运行过程中可动态变化的。



### 16.2 反射介绍

- 反射是指在程序运行期间对程序本身进行访问和修改的能力。程序在编译时，变量被转换为内存地址，变量名不会被编译器写入到可执行部分。在运行程序时，程序无法获取自身的信息。
- 支持反射的语言可以在程序编译期间将变量的反射信息，如字段名称、类型信息、结构体信息等整合到可执行文件中，并给程序提供接口访问反射信息，这样就可以在程序运行期间获取类型的反射信息，并且有能力修改它们。
- Go程序在运行期间使用reflect包访问程序的反射信息。



### 16.3 reflect包

- 在Go语言的反射机制中，任何接口值都由是`一个具体类型`和`具体类型的值`两部分组成的(我们在上一篇接口的博客中有介绍相关概念)。 在Go语言中反射的相关功能由内置的reflect包提供，任意接口值在反射中都可以理解为由`reflect.Type`和`reflect.Value`两部分组成，并且reflect包提供了`reflect.TypeOf`和`reflect.ValueOf`两个函数来获取任意对象的Value和Type。
- `TypeOf`
  - 在Go语言中，使用`reflect.TypeOf()`函数可以获得任意值的类型对象（reflect.Type），程序通过类型对象可以访问任意值的类型信息。
  - type name和type kind
    - 在反射中关于类型还划分为两种：`类型（Type）`和`种类（Kind）`。
    - 因为在Go语言中我们可以使用type关键字构造很多自定义类型，而`种类（Kind）`就是指底层的类型，但在反射中，当需要区分指针、结构体等大品种的类型时，就会用到`种类（Kind）`。 
    - 举个例子，我们定义了两个指针类型和两个结构体类型，通过反射查看它们的类型和种类。

- `ValueOf`

  - `reflect.ValueOf()`返回的是`reflect.Value`类型，其中包含了原始值的值信息。`reflect.Value`与原始值之间可以互相转换。

  - 通过反射获取值
    ```go
    func reflectValue(x interface{}) {
    	v := reflect.ValueOf(x)
    	k := v.Kind()
    	switch k {
    	case reflect.Int64:
    		// v.Int()从反射中获取整型的原始值，然后通过int64()强制类型转换
    		fmt.Printf("type is int64, value is %d\n", int64(v.Int()))
    	case reflect.Float32:
    		// v.Float()从反射中获取浮点型的原始值，然后通过float32()强制类型转换
    		fmt.Printf("type is float32, value is %f\n", float32(v.Float()))
    	case reflect.Float64:
    		// v.Float()从反射中获取浮点型的原始值，然后通过float64()强制类型转换
    		fmt.Printf("type is float64, value is %f\n", float64(v.Float()))
    	}
    }
    func main() {
    	var a float32 = 3.14
    	var b int64 = 100
    	reflectValue(a) // type is float32, value is 3.140000
    	reflectValue(b) // type is int64, value is 100
    	// 将int类型的原始值转换为reflect.Value类型
    	c := reflect.ValueOf(10)
    	fmt.Printf("type c :%T\n", c) // type c :reflect.Value
    }
    ```

  - 通过反射设置变量的值

    - 想要在函数中通过反射修改变量的值，需要注意函数参数传递的是值拷贝，必须传递变量地址才能修改变量值。而反射中使用专有的Elem()方法来获取指针对应的值。
      ```go
      package main
      
      import (
      	"fmt"
      	"reflect"
      )
      
      func reflectSetValue1(x interface{}) {
      	v := reflect.ValueOf(x)
      	if v.Kind() == reflect.Int64 {
      		v.SetInt(200) //修改的是副本，reflect包会引发panic
      	}
      }
      func reflectSetValue2(x interface{}) {
      	v := reflect.ValueOf(x)
      	// 反射中使用 Elem()方法获取指针对应的值
      	if v.Elem().Kind() == reflect.Int64 {
      		v.Elem().SetInt(200)
      	}
      }
      func main() {
      	var a int64 = 100
      	// reflectSetValue1(a) //panic: reflect: reflect.Value.SetInt using unaddressable value
      	reflectSetValue2(&a)
      	fmt.Println(a)
      }
      ```

  - `isNil()`和`isValid()`

    - `isNil()`

      - `IsNil()`报告v持有的值是否为nil。v持有的值的分类必须是通道、函数、接口、映射、指针、切片之一；否则IsNil函数会导致panic。

        ```go
        func (v Value) IsNil() bool
        ```

    - `isValid()`

      - `IsValid()`返回v是否持有一个值。如果v是Value零值会返回假，此时v除了IsValid、String、Kind之外的方法都会导致panic。

        ```go
        func (v Value) IsValid() bool
        ```

        

### 16.4 结构体反射

- 与结构体相关的方法

  - 任意值通过reflect.TypeOf()获得反射对象信息后，如果它的类型是结构体，可以通过反射值对象（reflect.Type）的NumField()和Field()方法获得结构体成员的详细信息。

- StructField类型

  - StructField类型用来描述结构体中的一个字段的信息。

  - StructField的定义如下：
    ```go
    type StructField struct {
        // Name是字段的名字。PkgPath是非导出字段的包路径，对导出字段该字段为""。
        // 参见http://golang.org/ref/spec#Uniqueness_of_identifiers
        Name    string
        PkgPath string
        Type      Type      // 字段的类型
        Tag       StructTag // 字段的标签
        Offset    uintptr   // 字段在结构体中的字节偏移量
        Index     []int     // 用于Type.FieldByIndex时的索引切片
        Anonymous bool      // 是否匿名字段
    }
    ```



## 17 并发



### 17.1 并发基本概念

- 进程、线程和协程
  - 进程（process）：程序在操作系统中的一次执行过程，系统进行资源分配和调度的一个独立单位。
  - 线程（thread）：操作系统基于进程开启的轻量级进程，是操作系统调度执行的最小单位。
  - 协程（coroutine）：非操作系统提供而是由用户自行创建和控制的用户态‘线程’，比线程更轻量级。

- 并发模型
  - 业界将如何实现并发编程总结归纳为各式各样的并发模型，常见的并发模型有以下几种：
    - 线程&锁模型
    - Actor模型
    - CSP模型
    - Fork&Join模型
  - Go语言中的并发程序主要是通过基于CSP（communicating sequential processes）的goroutine和channel来实现，当然也支持使用传统的多线程共享内存的并发方式



### 17.2 goroutine

- Goroutine 是 Go 语言支持并发的核心，在一个Go程序中同时创建成百上千个goroutine是非常普遍的，一个goroutine会以一个很小的栈开始其生命周期，一般只需要2KB。区别于操作系统线程由系统内核进行调度， goroutine 是由Go运行时（runtime）负责调度。例如Go运行时会智能地将 m个goroutine 合理地分配给n个操作系统线程，实现类似m:n的调度机制，不再需要Go开发者自行在代码层面维护一个线程池。

- Goroutine 是 Go 程序中最基本的并发执行单元。每一个 Go 程序都至少包含一个 goroutine——main goroutine，当 Go 程序启动时它会自动创建。

- go关键字

  - Go语言中使用 goroutine 非常简单，只需要在函数或方法调用前加上go关键字就可以创建一个 goroutine ，从而让该函数或方法在新创建的 goroutine 中执行。
    ```go
    go f()  // 创建一个新的 goroutine 运行函数f
    ```

  - 匿名函数也支持使用go关键字创建 goroutine 去执行。
    ```go
    go func(){
      // ...
    }()
    ```

  - 一个 goroutine 必定对应一个函数/方法，可以创建多个 goroutine 去执行相同的函数/方法。

- 启动单个goroutine

  - 启动 goroutine 的方式非常简单，只需要在调用函数（普通函数和匿名函数）前加上一个go关键字。

  - 其实在 Go 程序启动时，Go 程序就会为 main 函数创建一个默认的 goroutine 。在 main 函数中使用 go 关键字创建了另外一个 goroutine 去执行 别的函数，而此时 main goroutine 还在继续往下执行，我们的程序中此时存在两个并发执行的 goroutine。

  - 当 main 函数结束时整个程序也就结束了，同时 main goroutine 也结束了，所有由 main goroutine 创建的 goroutine 也会一同退出。
    ```go
    package main
    
    import (
    	"fmt"
    	"time"
    )
    
    func hello() {
    	fmt.Println("hello")
    }
    
    func main() {
    	go hello()
    	fmt.Println("你好")
    	time.Sleep(time.Second)
    }
    ```

- 启动多个goroutine

  - 在 Go 语言中实现并发就是这样简单，还可以启动多个 goroutine 。

  - 使用了sync.WaitGroup来实现 goroutine 的同步。
    ```go
    package main
    
    import (
    	"fmt"
    	"sync"
    )
    
    var wg sync.WaitGroup
    
    func hello(i int) {
    	defer wg.Done() // goroutine结束就登记-1
    	fmt.Println("hello", i)
    }
    func main() {
    	for i := 0; i < 10; i++ {
    		wg.Add(1) // 启动一个goroutine就登记+1
    		go hello(i)
    	}
    	wg.Wait() // 等待所有登记的goroutine都结束
    }
    ```

- 动态栈

  - 操作系统的线程一般都有固定的栈内存（通常为2MB）,而 Go 语言中的 goroutine 非常轻量级，一个 goroutine 的初始栈空间很小（一般为2KB），所以在 Go 语言中一次创建数万个 goroutine 也是可能的。
  - 并且 goroutine 的栈不是固定的，可以根据需要动态地增大或缩小， Go 的 runtime 会自动为 goroutine 分配合适的栈空间。

- gorouine调度

  - 操作系统内核在调度时会挂起当前正在执行的线程并将寄存器中的内容保存到内存中，然后选出接下来要执行的线程并从内存中恢复该线程的寄存器信息，然后恢复执行该线程的现场并开始执行线程。从一个线程切换到另一个线程需要**完整的上下文切换**。因为可能需要多次内存访问，索引这个切换上下文的操作开销较大，会增加运行的cpu周期。
  - 区别于操作系统内核调度操作系统线程，goroutine 的调度是**Go语言运行时（runtime）层面**的实现，是完全由 Go 语言本身实现的一套调度系统——**go scheduler**。它的作用是按照一定的规则将所有的 goroutine 调度到操作系统线程上执行。
  - 目前 Go 语言的调度器采用的是 GPM 调度模型。
  - 单从线程调度讲，Go语言相比起其他语言的优势在于OS线程是由OS内核来调度的， goroutine 则是由Go运行时（runtime）自己的调度器调度的，完全是在**用户态下**完成的， 不涉及内核态与用户态之间的频繁切换，包括内存的分配与释放，都是在用户态维护着一块大的内存池， 不直接调用系统的malloc函数（除非内存池需要改变），成本比调度OS线程低很多。 另一方面充分利用了多核的硬件资源，**近似的把若干goroutine均分在物理线程上**， 再加上本身 goroutine 的超轻量级，以上种种特性保证了 goroutine 调度方面的性能。
  - GOMAXPROCS
    - Go运行时的调度器使用GOMAXPROCS参数来确定需要使用多少个 OS 线程来同时执行 Go 代码。默认值是机器上的 CPU 核心数。例如在一个 8 核心的机器上，GOMAXPROCS 默认为 8。
    - Go语言中可以通过runtime.GOMAXPROCS函数设置当前程序并发时占用的 CPU逻辑核心数。（Go1.5版本之前，默认使用的是单核心执行。Go1.5 版本之后，默认使用全部的CPU 逻辑核心数。）



### 17.3 channel

- 概述

  - Go语言采用的并发模型是CSP（Communicating Sequential Processes），提倡通过通信共享内存而不是通过共享内存而实现通信。
  - 如果说 goroutine 是Go程序并发的执行体，channel就是它们之间的连接。channel是可以让一个 goroutine 发送特定值到另一个 goroutine 的通信机制。
  - Go 语言中的通道（channel）是一种特殊的类型。通道像一个传送带或者队列，总是遵循**先入先出（First In First Out）**的规则，保证收发数据的顺序。每一个通道都是一个具体类型的导管，也就是声明channel的时候需要为其指定元素类型。

- channel类型

  - channel是 Go 语言中一种特有的类型。声明通道类型变量的格式如下：
    ```go
    var 变量名称 chan 元素类型
    ```

- channel零值

  - 未初始化的通道类型变量其默认零值是`nil`。

- 初始化channel

  - 声明的通道类型变量需要使用内置的make函数初始化之后才能使用。具体格式如下：
    ```go
    make(chan 元素类型, [缓冲大小])
    ```

- channel操作

  - 通道共有发送（send）、接收(receive）和关闭（close）三种操作。而发送和接收操作都使用<-符号。

  - 现在我们先使用以下语句定义一个通道：

    ```go
    ch := make(chan int)
    ```

  - 发送

    - 将一个值发送到通道中。
      ```go
      ch <- 10 // 把10发送到ch中
      ```

  - 接收

    - 从一个通道中接收值。
      ```go
      x := <- ch // 从ch中接收值并赋值给变量x
      <-ch       // 从ch中接收值，忽略结果
      ```

  - 关闭

    - 通过调用内置的close函数来关闭通道。
      ```go
      close(ch)
      ```

    - 一个通道值是可以被**垃圾回收**掉的。通道通常由发送方执行关闭操作，并且只有在接收方明确等待通道关闭的信号时才需要执行关闭操作。它和关闭文件不一样，通常在结束操作之后关闭文件是必须要做的，但关闭通道不是必须的。

    - 关闭后的通道有以下特点：

      1. 对一个关闭的通道再发送值就会导致 panic。
      2. 对一个关闭的通道进行接收会一直获取值直到通道为空。
      3. 对一个关闭的并且没有值的通道执行接收操作会得到对应类型的零值。
      4. 关闭一个已经关闭的通道会导致 panic。

- 无缓冲的通道

  - 无缓冲的通道又称为阻塞的通道。
    ```go
    func main() {
    	ch := make(chan int)
    	ch <- 10
    	fmt.Println("发送成功")
    }
    ```

  - 上面这段代码能够通过编译，但是执行的时候会出现以下错误：
    ```
    fatal error: all goroutines are asleep - deadlock!
    
    goroutine 1 [chan send]:
    main.main()
            .../main.go:8 +0x54
    ```

  - `deadlock`表示我们程序中的 goroutine 都被挂起导致程序死锁了。

    - 因为我们使用`ch := make(chan int)`创建的是无缓冲的通道，无缓冲的通道只有在有接收方能够接收值的时候才能发送成功，否则会一直处于等待发送的阶段。同理，如果对一个无缓冲通道执行接收操作时，没有任何向通道中发送值的操作那么也会导致接收操作阻塞。
    - 简单来说就是无缓冲的通道必须有至少一个接收方才能发送成功。

  - 其中一种可行的方法是创建一个 goroutine 去接收值，例如：
    ```go
    func recv(c chan int) {
    	ret := <-c
    	fmt.Println("接收成功", ret)
    }
    
    func main() {
    	ch := make(chan int)
    	go recv(ch) // 创建一个 goroutine 从通道接收值
    	ch <- 10
    	fmt.Println("发送成功")
    }
    ```

  - 首先无缓冲通道`ch`上的发送操作会阻塞，直到另一个 goroutine 在该通道上执行接收操作，这时数字10才能发送成功，两个 goroutine 将继续执行。相反，如果接收操作先执行，接收方所在的 goroutine 将阻塞，直到 main goroutine 中向该通道发送数字10。

  - 使用无缓冲通道进行通信将导致发送和接收的 goroutine 同步化。因此，无缓冲通道也被称为`同步通道`。

- 有缓冲的通道

  - 还有另外一种解决上面死锁问题的方法，那就是使用有缓冲区的通道。可以在使用 make 函数初始化通道时，可以为其指定通道的容量
    ```go
    func main() {
    	ch := make(chan int, 1) // 创建一个容量为1的有缓冲区通道
    	ch <- 10
    	fmt.Println("发送成功")
    }
    ```

  - 只要通道的容量大于零，那么该通道就属于有缓冲的通道，通道的容量表示通道中最大能存放的元素数量。当通道内已有元素数达到最大容量后，再向通道执行发送操作就会阻塞，除非有从通道执行接收操作。
  - 使用内置的`len`函数获取通道内元素的数量，使用`cap`函数获取通道的容量

- 多返回值模式

  - 当向通道中发送完数据时，我们可以通过close函数来关闭通道。当一个通道被关闭后，再往该通道发送值会引发panic，从该通道取值的操作会先取完通道中的值。通道内的值被接收完后再对通道执行接收操作得到的值会一直都是对应元素类型的零值。

  - 对一个通道执行接收操作时支持使用如下多返回值模式。
    ```go
    value, ok := <- ch
    ```

    - ok：通道ch关闭时返回 false，否则返回 true。

- for range接收值

  - 通常我们会选择使用for range循环从通道中接收值，当通道被关闭后，会在通道内的所有值被接收完毕后会自动退出循环。
    ```go
    func f3(ch chan int) {
    	for v := range ch {
    		fmt.Println(v)
    	}
    }
    ```

- 单向通道

  - 在某些场景下我们可能会将通道作为参数在多个任务函数间进行传递，通常我们会选择在不同的任务函数中对通道的使用进行限制，比如限制通道在某个函数中只能执行发送或只能执行接收操作。

  - Go语言中提供了**单向通道**来处理这种需要限制通道只能进行某种操作的情况。
    ```go
    <- chan int // 只接收通道，只能接收不能发送
    chan <- int // 只发送通道，只能发送不能接收
    ```

  - 示例
    ```go
    // Producer2 返回一个接收通道
    func Producer2() <-chan int {
    	ch := make(chan int, 2)
    	// 创建一个新的goroutine执行发送数据的任务
    	go func() {
    		for i := 0; i < 10; i++ {
    			if i%2 == 1 {
    				ch <- i
    			}
    		}
    		close(ch) // 任务完成后关闭通道
    	}()
    
    	return ch
    }
    
    // Consumer2 参数为接收通道
    func Consumer2(ch <-chan int) int {
    	sum := 0
    	for v := range ch {
    		sum += v
    	}
    	return sum
    }
    
    func main() {
    	ch2 := Producer2()
      
    	res2 := Consumer2(ch2)
    	fmt.Println(res2) // 25
    }
    ```



### 17.4 并发安全和锁

- 竞态

  - 代码中可能会存在多个 goroutine 同时操作一个资源（临界区）的情况，这种情况下就会发生竞态问题（数据竞态）。

- 互斥锁

  - 互斥锁是一种常用的控制共享资源访问的方法，它能够保证同一时间只有一个 goroutine 可以访问共享资源。Go 语言中使用sync包中提供的`Mutex`类型来实现互斥锁。
  - 使用互斥锁能够保证同一时间有且只有一个 goroutine 进入临界区，其他的 goroutine 则在等待锁；当互斥锁释放后，等待的 goroutine 才可以获取锁进入临界区，多个 goroutine 同时等待一个锁时，唤醒的策略是随机的。
  - `sync.Mutex`提供了两个方法供我们使用。
    - `func (m *Mutex) Lock()`：获取互斥锁
    - `func (m *Mutex) Unlock()`： 释放互斥锁

- 读写互斥锁

  - 互斥锁是完全互斥的，但是实际上有很多场景是读多写少的，当我们并发的去读取一个资源而不涉及资源修改的时候是没有必要加互斥锁的，这种场景下使用读写锁是更好的一种选择。读写锁在 Go 语言中使用sync包中的`RWMutex`类型。

  - | 方法名                              | 功能                           |
    | ----------------------------------- | ------------------------------ |
    | func (rw *RWMutex) Unlock()         | 释放写锁                       |
    | func (rw *RWMutex) Lock()           | 获取写锁                       |
    | func (rw *RWMutex) RLock()          | 获取读锁                       |
    | func (rw *RWMutex) RUnlock()        | 释放读锁                       |
    | func (rw *RWMutex) RLocker() Locker | 返回一个实现Locker接口的读写锁 |

  - 读写锁分为两种：读锁和写锁。当一个 goroutine 获取到读锁之后，其他的 goroutine 如果是获取读锁会继续获得锁，如果是获取写锁就会等待；而当一个 goroutine 获取写锁之后，其他的 goroutine 无论是获取读锁还是写锁都会等待。

- `syn.WaitGroup`

  - Go语言中可以使用`sync.WaitGroup`来实现并发任务的同步。 `sync.WaitGroup`有以下几个方法：

  - |                方法名                |        功能         |
    | :----------------------------------: | :-----------------: |
    | func (wg * WaitGroup) Add(delta int) |    计数器+delta     |
    |        (wg *WaitGroup) Done()        |      计数器-1       |
    |        (wg *WaitGroup) Wait()        | 阻塞直到计数器变为0 |

  - `sync.WaitGroup`内部维护着一个计数器，计数器的值可以增加和减少。例如当我们启动了 N 个并发任务时，就将计数器值增加N。每个任务完成时通过调用 Done 方法将计数器减1。通过调用 Wait 来等待并发任务执行完，当计数器值为 0 时，表示所有并发任务已经完成。

    ```go
    var wg sync.WaitGroup
    
    func hello() {
    	defer wg.Done()
    	fmt.Println("Hello Goroutine!")
    }
    func main() {
    	wg.Add(1)
    	go hello() // 启动另外一个goroutine去执行hello函数
    	fmt.Println("main goroutine done!")
    	wg.Wait()
    }
    ```

  - 注意`sync.WaitGroup`是一个结构体，进行参数传递的时候要传递指针。

- `sync.Once`

  - Go语言中的sync包中提供了一个针对只执行一次场景的解决方案——sync.Once，sync.Once只有一个Do方法，其签名如下：
    ```go
    func (o *Once) Do(f func())
    ```

  - 如果要执行的函数`f`需要传递参数就需要搭配闭包来使用。

  - 加载配置文件示例
    ```go
    var icons map[string]image.Image
    
    var loadIconsOnce sync.Once
    
    func loadIcons() {
    	icons = map[string]image.Image{
    		"left":  loadIcon("left.png"),
    		"up":    loadIcon("up.png"),
    		"right": loadIcon("right.png"),
    		"down":  loadIcon("down.png"),
    	}
    }
    
    // Icon 是并发安全的
    func Icon(name string) image.Image {
    	loadIconsOnce.Do(loadIcons)
    	return icons[name]
    }
    ```

  - 并发安全的单例模式
    ```go
    package singleton
    
    import (
        "sync"
    )
    
    type singleton struct {}
    
    var instance *singleton
    var once sync.Once
    
    func GetInstance() *singleton {
        once.Do(func() {
            instance = &singleton{}
        })
        return instance
    }
    ```

- `sync.Map`

  - 不能在多个 goroutine 中并发对内置的 map 进行读写操作，否则会存在数据竞争问题。

  - 需要为 map 加锁来保证并发的安全性了，Go语言的`sync`包中提供了一个开箱即用的并发安全版 map——`sync.Map`。开箱即用表示其不用像内置的 map 一样使用 make 函数初始化就能直接使用。同时`sync.Map`内置了诸如`Store`、`Load`、`LoadOrStore`、`Delete`、`Range`等操作方法。

  - |                            方法名                            |              功能               |
    | :----------------------------------------------------------: | :-----------------------------: |
    |         func (m *Map) Store(key, value interface{})          |        存储key-value数据        |
    | func (m *Map) Load(key interface{}) (value interface{}, ok bool) |       查询key对应的value        |
    | func (m *Map) LoadOrStore(key, value interface{}) (actual interface{}, loaded bool) |    查询或存储key对应的value     |
    | func (m *Map) LoadAndDelete(key interface{}) (value interface{}, loaded bool) |          查询并删除key          |
    |            func (m *Map) Delete(key interface{})             |             删除key             |
    |   func (m *Map) Range(f func(key, value interface{}) bool)   | 对map中的每个key-value依次调用f |

  - 示例
    ```go
    package main
    
    import (
    	"fmt"
    	"strconv"
    	"sync"
    )
    
    // 并发安全的map
    var m = sync.Map{}
    
    func main() {
    	wg := sync.WaitGroup{}
    	// 对m执行20个并发的读写操作
    	for i := 0; i < 20; i++ {
    		wg.Add(1)
    		go func(n int) {
    			key := strconv.Itoa(n)
    			m.Store(key, n)         // 存储key-value
    			value, _ := m.Load(key) // 根据key取值
    			fmt.Printf("k=:%v,v:=%v\n", key, value)
    			wg.Done()
    		}(i)
    	}
    	wg.Wait()
    }
    ```

  

### 17.5 原子操作

- atomic包

  |                             方法                             |     解释     |
  | :----------------------------------------------------------: | :----------: |
  | func LoadInt32(addr *int32) (val int32) func LoadInt64(addr *int64) (val int64) func LoadUint32(addr *uint32) (val uint32) func LoadUint64(addr *uint64) (val uint64) func LoadUintptr(addr *uintptr) (val uintptr) func LoadPointer(addr *unsafe.Pointer) (val unsafe.Pointer) |   读取操作   |
  | func StoreInt32(addr *int32, val int32) func StoreInt64(addr *int64, val int64) func StoreUint32(addr *uint32, val uint32) func StoreUint64(addr *uint64, val uint64) func StoreUintptr(addr *uintptr, val uintptr) func StorePointer(addr *unsafe.Pointer, val unsafe.Pointer) |   写入操作   |
  | func AddInt32(addr *int32, delta int32) (new int32) func AddInt64(addr *int64, delta int64) (new int64) func AddUint32(addr *uint32, delta uint32) (new uint32) func AddUint64(addr *uint64, delta uint64) (new uint64) func AddUintptr(addr *uintptr, delta uintptr) (new uintptr) |   修改操作   |
  | func SwapInt32(addr *int32, new int32) (old int32) func SwapInt64(addr *int64, new int64) (old int64) func SwapUint32(addr *uint32, new uint32) (old uint32) func SwapUint64(addr *uint64, new uint64) (old uint64) func SwapUintptr(addr *uintptr, new uintptr) (old uintptr) func SwapPointer(addr *unsafe.Pointer, new unsafe.Pointer) (old unsafe.Pointer) |   交换操作   |
  | func CompareAndSwapInt32(addr *int32, old, new int32) (swapped bool) func CompareAndSwapInt64(addr *int64, old, new int64) (swapped bool) func CompareAndSwapUint32(addr *uint32, old, new uint32) (swapped bool) func CompareAndSwapUint64(addr *uint64, old, new uint64) (swapped bool) func CompareAndSwapUintptr(addr *uintptr, old, new uintptr) (swapped bool) func CompareAndSwapPointer(addr *unsafe.Pointer, old, new unsafe.Pointer) (swapped bool) | 比较并交换操 |



## 18 网络编程

https://www.liwenzhou.com/posts/Go/socket/#autoid-2-0-5



## 19 单元测试

https://www.liwenzhou.com/posts/Go/unit-test/