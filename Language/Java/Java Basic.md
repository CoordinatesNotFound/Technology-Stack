# Java基础编程

[TOC]



## 1 Java语言概述



### 1.1 软件开发介绍

- 软件，即一系列按照特定顺序组织的计算机数据和指令的集合。有系统软件和应用软件之分
- 人机交互方式
  - 图形化界面
  - 命令行方式



### 1.2 Java语言概述

- SUN推出，1995
- 面向Internet；applet：Java小程序，内嵌在HTML代码中
- Web应用程序的首选开发语言
- Java核心体系平台
  - Java SE标准版
    - Java核心API
  - Java EE企业版
    - Web应用开发



### 1.3 Java语言特点

- 类C语言发展和衍生的产物
- 纯粹的面向对象的程序设计语言
- 舍弃了C语言中的指针（以引用代替）、运算符重载、多重继承（以接口代替）等特性，增加了垃圾回收器功能用于回收不再被引用的对象所占据的内存空间
- 主要特性
  - 易学的
  - 强制面向对象的
  - 分布式的
  - 健壮的
  - 安全的
  - 体系结构中立的
  - 解释型的
  - 性能略高的
  - 原生支持多线程的



### 1.4 Java语言运行机制及运行过程

- 特点

  - 面向对象
    - 类、对象
    - 封装、继承、多态
  - 健壮性
    - 吸收了C语言的特点，去掉了影响健壮性的部分，提供了一个相对安全的内存管理和访问机制
  - 跨平台性
    - 程序在不同的系统平台上都能运行
    - 原理：由JVM负责Java程序在系统中的运行

- 核心机制

  - JVM

    - 一个虚拟的计算机，具有指令集并使用不同的存储区域
    - 屏蔽了底层差别，“一次编译，到处运行”

  - 垃圾收集机制

    - 消除了程序员回收无用内存空间的责任
    - 提供一种系统级线程跟踪存储空间的分配情况。在JVM空闲时，检查并释放那些可被释放的存储空间

    > 还是会出现内存溢出和内存泄漏问题



### 1.5 Java语言环境

- JDK：Java开发工具包
  - Java开发工具（Javac编译工具）
  - JRE
- JRE：Java运行环境
  - JVM
  - Java程序所需核心类库



### 1.6 Java编译运行

- javac将源文件编译为字节码文件.class
- java运行字节码文件





### 1.7 注释

- 注释类型

  - 单行注释
    `//`

  - 多行注释
    `/**/`

  - 文档注释（Java特有）

    ```java
    /**
    `@author指定程序作者
     @version指定源文件的版本信息
    
    */
    ```

    - 注释内容可以被JDK提供的工具javadoc所解析，生成一套以网页形式体现的该程序的说明文档

    - javadoc -d name -author -version HelloWorld.java

      > 报错：javadoc-找不到可以文档化的公共或受保护的类
      > 解决：在类名前面加上public

    - index.html可以查看信息

    - 不可以嵌套使用



### 1.8 Java API

- 应用程序编程接口
- Java提供的基本编程接口





## 2 Java基本语法



### 2.1 关键字和保留字

- 关键字
  - 定义：被Java语言赋予特殊含义，用作专门用途的字符串
  - 特点：关键字中所有字母都为小写
- 保留字
  - 现有版本尚未使用，以后版本可能会作为关键字使用
  - goto、const



### 2.2 标识符

- 定义：Java对各种变量、方法和类等要素命名时使用的字符序列
- 规则：
  - 以英文字母/数字/_/$组成
  - 数字不可以开头
  - 严格区分大小写
- 命名规范：
  - 包名：多单词组成时所有字母都小写：xxxyyyyzzz
  - 类名、接口名：多单词组成时，所有单词的首字母大写：XxxYyyZzz（大驼峰）
  - 变量名、方法名：多单词组成时，第一个单词首字母小写，第二个单词开始首字母大写：xxxYyyZzz（小驼峰）
  - 常量名：所有字母都大写、多单词时每个单词用下划线连接：XXX_YYY_ZZZ



### 2.3 变量

- 概念

  - 内存区中的一个存储区域
  - 该区域的数据可以在同一类型范围内不断变化
  - 程序中基本的存储单元
    - 变量类型
    - 变量名
    - 存储的值

- 使用

  - 先声明再使用
  - 作用域：定义所在的一对`{}`内

- 分类

  - 按数据分类

    - 基本数据类型（8种）

      - byte

      - short（2byte)

      - int（4byte）

      - long（8byte）

        > 定义时以"l"/"L"结尾

      - float（4byte）

        > 定义时以"f"/"F"结尾

      - double（8byte）

        > 定义浮点时通常使用

      - char（2byte）

        > 直接使用Unicode字符集

      - boolean

    - 引用数据类型

      - 类class
      - 接口interface
      - 数组array

  - 按声明位置分类

    - 成员变量

      - 实例变量
      - 类变量

    - 局部变量

      - 方法形参
      - 方法内局部变量
      - 代码块局部变量
      - 构造器形参
      - 构造器内部变量

      > 局部变量初始化必须赋值

- 基本数据类型之间的运算规则

  - 自动类型转换（提升）

    - 当容量小变量和容量大变量做运算时，将结果自动提升为为容量大的数据类型

      > 容量大小指的是表示数的范围的大小

    - byte、char、short --> int --> long --> float --> double

    - 特别的，当byte、char、short变量之间运算时，结果为int

  - 强制类型转换

    - 自动类型提升的逆运算

    - 使用强转符：`()`

    - 截断操作

    - 常见情况

      - 整型常量：默认类型为int型
      - 浮点型常量：默认类型为double型

      ```java
      byte b = 12;
      byte b1 = b + 1;//编译失败
      float f1 = 12.3;//编译失败
      float f1 = 12.3f;
      float f1 = (double)12.3;
      ```

- 字符串String类型

  - 属于引用数据类型
  - 使用`""`声明
  - 可以和8种数据类型作运算，且运算只能是连接运算`+`，运算结果仍是String类型
  - 不能直接自动提升或强转

- 进制
  - 整数表示
    - 二进制：`0b`/`0B`开头
    - 十进制
    - 八进制：`0`开头
    - 十六进制：`0x`/`0X`开头





### 2.4 运算符

- 算术运算符
- 赋值运算符
- 比较运算符
- 逻辑运算符
  - &逻辑与
  - &&短路与
  - |逻辑或
  - ||短路或
  - !逻辑非
  - ^逻辑异或
- 位运算符
  - \>>右移
  - \>>>无符号右移
  - &与
  - |或
  - ^异或
  - ~取反
- 三元运算符



### 2.5 流程控制

-  顺序结构

- 分支结构

  - if-else

  - switch-case

    ```java
    switch(表达式){
        case 常量1:
            语句;
            //break;
        case 常量2:
            语句;
            //break;
        default:
            语句;
            //break;
    }
    ```

- 循环结构

  - for
  - while
  - do-while

- break、continue



### 2.6 Scanner从键盘获取数据

- 实现步骤

  1. 导包
     `import java.util.Scanner;`

  2. Scanner的实例化
     `Scanner sc = new Scanner(System.in);`

  3. 调用Scanner类的相关的方法
     `int age = sc.nextInt();`

     > 对于char型的获取，Scanner没有提供相关方法，只能获取一个字符串：
     >
     > ```java
     > String gender = sc.next();
     > char getderchar = gender.charAt(0);
     > ```

- 需要根据相应方法输入指定类型的值，若不匹配，则报异常：`InputMisMatchException`，导致程序终止





## 3 数组



### 3.1 数组的概述

- 定义：是多个相同类型的数据按一定顺序排列的集合，并使用一个名字命名，并通过编号的方式对这些数据进行统一管理

- 属于引用数据类型，而数组中的元素可以是任何数据类型

- 创建数组对象会在内存中开辟一段连续的空间，而数组名种引用的是这块连续空间的首地址

- 数组的长度一旦确定就不能修改

- 一维数组的使用

  - 一维数组的声明和初始化

    ```java
    int[] ids = new int[]{1001, 1002, 1003, 1004}; //静态初始化：数组的初始化和数组元素的赋值操作同时进行
    String[] names = new String[5]; //动态初始化：数组的初始化和数组元素的赋值操作分开进行
    ```

  - 如何调用数组的指定位置的元素

    ```java
    names[0] = "oliver";
    ```

  - 如何获取数组的长度

    ```java
    names.length;
    ```

  - 如何遍历数组

    ```java
    for(int i = 0; i < names.length; i++){
        System.out.printIn(names[i]);
    }
    ```

  - 数组元素的默认初始化值

    - 整型数组：`0`
    - 浮点型数组：`0.0`
    - 字符数组：`0`(ASCII)
    - 布尔型数组：`false`
    - 引用类型数组：`null`

  - 数组的内存解析

    - 内存简化结构

      - 栈

        - **局部变量**

          > 若在方法中声明数组，则数组名存放数组首地址，属于局部变量

      - 堆

        - new出来的结构
          - 对象
          - **数组**

      - 方法区

        - 静态域
        - 常量池

- 二维数组的使用

  - 二维数组的声明和初始化

    ```java
    int[][] arr = new int[][]{{1,2,3},{4,5}};//静态初始化
    int[][] arr1 = new int[2][2];//动态初始化1
    int[][] arr2 = new int[3][];//动态初始化2
    ```

  - 如何调用数组的指定位置的元素

    ```java
    arr[0][1];
    ```

  - 如何获取数组的长度

    ```java
    arr.length;
    arr[0].length;

  - 如何遍历数组

    ```java
    for(int i = 0; i < arr.length; i++){
        for(int j = 0; j < arr[i].length; j++){
            System.out.printIn(arr[i][j]);
        }
    }

  - 数组元素的默认初始化值

    - 若指定了二维索引（动态初始化1）
      - 外层元素：地址值
      - 内存元素：与一维数组的初始化值相同
    - 若未指定二维索引（动态初始化2）
      - 外层元素：null
      - 内存元素：报错

  - 数组的内存解析

    - 地址值-地址值-数据



### 3.2 数组-算法

- 数组复制

  ```java
  //将array1复制到array2
  array2 = new int[array1.length];
  for(int i = 0; i < array2.length; i++){
      array2[i] = array1[i];
  }

- 数组元素的反转

  ```java
  //将arr反转
  //法一
  for(int i = 0; i < arr.length / 2; i++){
      String temp arr[i];
      arr[i] = arr[arr.length - i - 1];
      arr[arr.length - i - 1] = temp;
  }
  
  //法二
  for(int i = 0, j = arr.length; i < j; i++, j--){
      String temp = arr[i];
      arr[i] = arr1[j];
      arr[j] = temp;
  }

- 数组线性查找

  ```java
  String dest = "BB";
  boolean isFlag = true;
  
  for(int i = 0; i < arr.length; i++){
      if(dest.equals(arr[i])){
          //找到
          isFlag = false;
          break;
      }
  }
  if(isFlag){
      //没找到
  }

- 数组二分查找

  ```java
  int dest = 19;
  int head = 0; //初始首索引
  int end = arr.length - 1; //初始末索引
  boolean isFlag = true;
  
  //二分查找
  while(head <= end){
      
      int middle = (head + end) / 2;
      
      if(dest == arr[middle]){
          //找到
          isFlag = false;
          break;
      }
      else if(arr[middle] > dest){
          end = middle - 1;
      }
      else{
          head = middle + 1;
      }
  }
  
  if(isFlag){
      //没找到
  }
  ```

  > 查找的数组必须有序

- 数组冒泡排序

  ```java
  //冒泡排序
  for(int i = 0; i < arr.length; i++){
      for(int j = 0; j < arr.length - i - 1; j++){
          if(arr[j+1] < arr[j]){
              swap(arr[j], arr[j+1]);
          }
      }
  }

- 数组快速排序

  ```java
  //快速排序
  public class QuickSort{
      static void swap(int[] data, int i, int j){
      	int temp = data[i];
   	    data[i] = data[j];
      	data[j] = temp;
      }
      
      private static void subSort(int[] data, int start, int end){
          if(start < end){
              int base = = data[start];
              int low = start;
              int high = end + 1;
              while(true){
                  while(low < high && data[++low] <= base)
                      ;
                  while(low < high && data[--high] >= base)
                      ;
                  if(low < high){
                      swap(data, low, high);
                  }
                  else{
                      break;
                  }
              }
              swap(data, base, high);
              
              subSort(data, start, high - 1);
              subSort(data, high + 1, end);
          }
      }
      
      public static void quickSort(int[] data){
          subSort(data, 0, data.length - 1);
      }
  }



### 3.3 Arrays工具类

- 引用
  - `import java.util.Arrays`

- 常用方法
  - `bolean equals(int[] a, int[] b)`
    - 判断两个数组是否相等
  - `String toString(int[] a)`
    - 输出数组信息
  - `void fill(int[] a, int val)`
    - 将指定值填充到数组之中
  - `void sort(int[] a)`
    - 排序
  - `int binarySearch(int[] a, int key)`
    - 二分查找



### 3.4 数组使用中的常见异常

- 数组角标越界
  - `ArrayIndexOutOfBoundException`
- 空指针异常
  - `NullPointerException`



## 4 面向对象



### 4.1 类和对象

- 核心概念

  - 类是对一类事物的描述
  - 对象是对实际存在的该类事物的每个个体
- 类和对象的使用

  1. 类的设计

     - 面向对象程序设计的重点是类的设计
     - 类的设计就是设计类成员

     - 常见的类的成员
       - 属性 = 成员变量 = field = 域、字段
       - 行为 = 成员方法 = method = 函数
         - 方法的声明：`权限修饰符 返回值类型 方法名(形参列表){方法体}`

  2. 创建类的对象 = 类的实例化 

     - `new`

  3. 调用对象的结构

     - `对象.属性`
     - `对象.方法`
- 对象的内存解析
  - 同一类实例化的每个对象的实体都占用堆中的独立的内存空间
  - `Person p2 = p1`没有新创建对象，而是共享一个堆空间中的对象实体
- 匿名对象

  - `new 类名().方法名();`
  - 创建的对象没有显示地赋给一个变量名
  - 匿名对象只能调用一次
  - 使用
    - `mall.show(new Phone());`



### 4.2 方法

- 方法重载
  - 概念
    - 在同一个类当中，允许存在一个以上的同名方法，只要它们的参数个数或者参数类型不同
  - 特点
    - 与返回值类型无关，只看参数列表，且参数列表必须不同
    - 调用时，根据参数列表来区别

- 可变个数的形参
  - 概念
    - 允许直接定义能和多个实参相匹配的形参，从而来传递个数可变的实参
  - 具体使用
    - 格式：`数据类型 ... 变量名`
    - 调用：传入的参数个数可以是0，1，2，...
    - 可变个数形参的方法与本类中方法名相同，形参不同的方法之间构成重载
    - 可变个数形参的方法与本类中方法名相同，形参类型也相同的数组之间不构成重载
    - 可变个数形参在方法的形参中，只能声明在末尾
    - 可变个数形参在方法形参中最多只能声明一个

- 方法参数的值传递机制
  - 值传递：将实际参数值的副本（复制品）传入方法内
  - 规则
    - 如果参数是基本数据类型，则实参赋给形参的是实参真实存储的数据值
    - 如果参数是引用数据类型，则实参赋给形参的是实参存储数据的地址值

> 【关于变量的赋值】
>
> - 如果变量是基本数据类型，则赋值的是变量所保存的数据值
> - 如果变量是引用数据类型，则赋值的是变量所保存的数据的地址值



### 4.3 封装性

- 思想：隐藏对象内部的复杂性，只对外公开简单的接口，便于外界的调用，从而提高系统的可扩展性、可维护性
  - 高内聚：类的内部数据操作细节自己完成，不允许外部干涉
  - 低耦合：仅对外暴露少量的方法用于使用
- 封装性体现
  - 将类的属性`Xxx`私有化（`private`)，同时，提供公共的（`public`）方法来获取和设置
    - `setXxx`
    - `getXxx`
  - 不对外暴露的私有的方法
  - 单例模式

- 权限修饰符
  - `private`
  - `default`（缺省
  - `protected`
  - `public`



### 4.4 构造器

- 特征
  - 与类同名
  - 不声明返回类型
  - 不被static、final、synchronized、abstract、native修饰
- 作用
  - 创建对象
  - 初始化对象的属性
- 格式：`权限修饰符 类名（形参列表）{}`
- 显示的定义类的构造器，则系统默认提供一个空参的构造器
- 一个类中定义的多个构造器，彼此构成重构
- 一旦我们显式地定义了类的构造器之后，系统就不再提供默认地空构造器
- 一个类中至少会有一个构造器

> 【属性赋值先后顺序】
>
> 1. 默认初始化
> 2. 显式初始化
> 3. 构造器中赋值
> 4. 通过"对象.方法"或"对象.属性"赋值



### 4.5 JavaBean

- 一种Java语言写成地可重用组件
- JavaBean是指符合如下标准的Java类
  - 类是公共的
  - 有一个无参的公共的构造器
    - 便于通过反射，创建运行时类的对象
    - 便于子类继承此运行时类时，默认调用`super()`时，保证父类有此构造器
  - 有属性，且有对应的get、set方法
- 用户可以使用JavaBean将各种信息打包



### 4.6 this

- 作用
  - `this`修饰调用属性和方法：理解为 当前对象 或 当前正在创建的对象
    - 在类的方法中，可以使用"`this.属性`"或"`this.方法`"，调用当前对象属性或方法。但是通常情况下，我们都选择省略"this."；特殊情况下，如果方法的形参和类的属性重名了，必须显式使用this区分
    - 在类的构造器中，可以使用"`this.属性`"或"`this.方法`"，调用当前对象属性或方法。但是通常情况下，我们都选择省略"this."；特殊情况下，如果方法的形参和类的属性重名了，必须显式使用this区分
  - `this`修饰调用构造器
    - 在类的构造器中，可以显示的使用`this(形参列表)`的方式，来调用本类中的其他构造器
    - 构造器中不能通过这种方式调用自己
    - 如果一个类中有n个构造器，则最多有n - 1个构造器使用了这种方法
    - 规定：`this(形参列表)`必须置于构造器首行



### 4.7 package、import

- package关键字的使用

  - 为了更好的实现项目中类的管理，提供包的概念
  - 使用`package`声明类或接口所属的包，声明在源文件的首行
  - 每`.`一次，代表一层文件目录
  - 同一个包下，不能命名同名的接口或类
  - 不同的包下，可以命名同名的接口或类

- 主要的包介绍

  - java.lang
    - 包含一些Java语言的核心类，如String、Math、Integer、System和Thread
  - java.net
    - 包含执行与网络相关的操作的类和接口
  - java.io
    - 包含能提供多种输入输出功能的类
  - java.util 
    - 包含实用工具类，如定义系统特性、接口的集合框架类、使用与日期日历相关的函数、
  - java.text
    - 包含java格式化相关的类
  - java.sql
    - 包含JDBC数据库编程相关接口
  - java.swt
    - 包含了构成抽象窗口的工具集的多个类，用于创建和管理GUI

- import关键字的使用

  - 在源文件中显式地使用`import`结构导入指定包下的类、接口

  - 声明在包的声明和类的声明之间

  - 如果需要导入多个结构，并列写出

  - 可以使用`xxx.*`的方式，表示可以导入xxx包下的所有结构

  - 如果使用的类或接口在java.lang下，则可以省略import结构

  - 如果使用的类或接口是本包下定义的，则可以省略import结构

  - 如果在源文件中，使用了不同包下的同名的类，则必须至少有一个包以全命名的方式显示

  - 如果使用`xxx.*`表明可以调用xxx包下的所有结构；但是如果使用的是xxx子包下的结构，仍需要显式导入

  - `import static`导入指定类或接口中的静态结构

    ```java
    import static java.lang.System.*;
    import static java.lang.Math.*;
    
    out.printIn("hello");
    long num = round(123.123);
    ```



### 4.8 继承性

- 继承性的好处
  - 减少代码的冗余，提高代码复用性
  - 便于功能的扩展
  - 为之后多态性的使用，提供了前提
- 继承性的格式：`class A extends B{} `
  - A：子类/派生类
  - B：父类/超类/基类
- 继承性体现
  - 一旦子类继承父类，子类获取父类中声明的结构、属性、方法
    - 父类中声明为private的属性或方法，子类继承后仍能获取，只是因为封装性的影响，子类不能直接调用父类的结构
  - 子类继承父类后，还可以声明自己特有的结构、属性、方法，实现功能的拓展
- java中关于继承性的规定
  - 一个类可以被多个子类继承
  - 一个类只能有一个父类（类的单继承性，不支持多重继承）
  - 支持多层继承；子类和父类是相对的概念
    - 直接父类
    - 间接父类

- 如果没有显示地声明一个类的父类的化，则此类继承于java.lang.Objects



### 4.9 方法的重写

- 定义：在子类当中根据需要堆从父类中继承来的方法进行改造，也称方法的重置、覆盖。程序执行时，子类的方法将覆盖父类的方法
- 应用：重写以后，当创建子类对象以后，通过子类对象调用父类中的同名同参数的方法时，实际执行的是子类重写父类的方法

- 规定：
  - 子类重写的方法的方法名和形参列表与父类被重写的方法名和形参列表相同
  - 子类重写的方法的权限修饰符不小于父类被重写的权限修饰符
    -  子类不能重写父类中声明为private的方法
  - 返回值类型：
    - 父类被重写的方法的返回值类型是`void`，则子类重写的方法的返回值类型必须是`void`
    - 父类被重写的方法的返回值类型是A类，则子类重写的方法的返回值类型必须是A类或A类的子类
    - 父类被重写的方法的返回值类型是基本数据类型，则子类重写的方法的返回值类型必须是相同的基本数据类型
  - 子类重写的方法抛出的异常类型不大于父类被重写的方法抛出的异常类型（具体见异常处理）
  - 子类和父类中同名同参数的方法要么声明为非static的（考虑重写），要么都声明为static的（不是重写）



### 4.10 访问权限修饰符

| 修饰符          | 类内部 | 同一个包 | 不同包的子类 | 同一个工程 |
| --------------- | ------ | -------- | ------------ | ---------- |
| `private`       | Y      |          |              |            |
| `default`（缺省 | Y      | Y        |              |            |
| `protected`     | Y      | Y        | Y            |            |
| `public`        | Y      | Y        | Y            | Y          |

> 对于（非内部类）class的权限只可以用`public`和`default`
>
> - public类可以在任意地方被访问
> - default类只可以被同一个包的内部类访问



### 4.11 super

- super理解为：父类的

- super可以用于调用属性、方法、构造器

- 使用：

  - 可以在子类的方法或构造器中，通过`super.属性`或`super.方法`调用父类当中声明的属性或方法；通常情况下，习惯省略`super.`

    - 特殊情况，当子类和父类中定义了同名属性时，若要调用父类中声明的属性，必须显式地使用`super.属性`
    - 特殊情况，当子类重写了父类中的方法之后，若要调用父类中被重写地方法时，则必须显式地使用父类中被重写的方法

  - 调用构造器

    - 可以在子类的构造器中显示地使用`super(形参列表)`的方式，调用父类中指定的构造器

    - `super(形参列表)`必须声明在子类构造器的首行

    - 在类的构造器中，针对于`this(形参列表)`或`super(形参列表)`只能二选一，不能同时出现

    - 在构造器的首行，没有显式的声明`this(形参列表)`或`super(形参列表)`，则默认调用的是父类中空参的构造器（`super()`）

      > 比如，父类中定义了非空构造器，未定义非空构造器，（系统不再默认提供空构造器），则子类中声明空构造器会报错

    - 在类的多个构造器中，至少有一个类的构造器使用了`super(形参列表)`，调用了父类中的构造器

      > 内存解析：堆空间中子类的实例一定会包含父类的结构



### 4.12 子类对象的实例化过程

- 从结果上来看
  - 子类继承父类以后，就继承了父类中声明的属性或方法；创建子类的对象，在堆空间中，就会加载所有父类中声明的属性
- 从过程上看
  - 当通过子类的构造器创建子类对象时，一定会直接或间接地调用父类地构造器，进而调用父类的父类的构造器，直到调用了java.lang.Object类中空参的构造方法。正因为加载过父类的结构，才可以看到内存中有父类的结构，子类对象才可以考虑调用
- 虽然创建子类对象时，调用了父类的构造器，自始至终只创建了一个对象



### 4.13 多态性

- 定义：父类的引用指向子类的对象

  ```java
  Person p1 = new Man();
  Person p2 = new Woman();
  ```

- 使用：当调用子父类同名同参数的方法时，实际执行的是子类重写父类的方法

  > 虚拟方法调用，此调用在编译期无法确定，而是在运行时确定（动态绑定）
  >
  > - 证明方法：利用随机数生成

  - 有了对象的多态之后，在编译期，只能调用父类中声明的方法，但在运行前，我们实际执行的是子类重写父类的方法
  - ”编译看左边；运行看右边“

- 使用前提：

  - 类的继承关系
  - 方法的重写

- 使用场景：

  - 举例一

    ```java
    public class AnimalTest{
        
        public static void main(String[] args){
            
            AnimalTest test = new AnimalTest();
            //Dog, Cat均是Animal的子类，且重写了Animal的eat()和shout()
            test.func(new Dog()); 
            test.func(new Cat());
        }
        
        public void func(Animal animal){//Animal animal = new Dog()/Cat();
            animal.eat();
            animal.shout();
        }
    }
    ```

  - 举例二

    ```java
    class Order{
        
        public void method(Object obj){
            //
        }
    }
    ```

  - 举例三

    ```java
    class Driver{
        
        public void doData(Connection conn){//Connection conn = new MySQLConnection();
            conn.method1();
            conn.method2();
            conn.method3();
        }
    }

- 对象的多态性，适用于方法，不适用于属性

- 不能调用子类所特有的方法、属性

  - 有了对象的多态性以后，内存中是加载了子类特有的属性和方法，但是由于变量声明为父类类型，导致编译时，只能调用父类中声明的属性和方法

- 转型

  - 向上转型：子类 --> 父类

    - 多态

  - 向下转型：父类 --> 子类

    - 使用强转符

      > 可能会出现`ClassCastException异常`

    - 强转前使用`instanceof`进行判断

- `instanceof` 
  - 使用：`a instanceof A`
    - 判断a是否是A的实例，如果是，返回true；如果不是，返回false
    - 若`a instanceof A`返回true，B是A的父类，则`a instanceof B`也返回true
  - 目的：避免在向下转型之前出现`ClassCastException`的异常



### 4.14 Object类

- 所有Java类的根父类

- 若在类的声明中未使用`extends`指明父类，则默认继承Object类

- Object类中的方法具有通用性

  - `protected Object clone()`

    - 复制一个对象

  - `boolean equals(Object obj)`

    - Object类中定义的`equals()`方法用于比较两个对象的地址是否相同，即两个引用是否指向同一对象实体

      ```java
      public boolean equals(Object obj){
          return (this == obj);
      }

    - String、File、Data、包装类等都重写了`equals()`方法，重写以后，比较的不是两个引用的地址是否相同，而是比较两个对象的“实体内容”是否相同（属性）

    - 自定义类重写`equals()`

      ```java
      //重写，比较两个对象的实体内容是否相同
      @Override
      public boolean equals(Object obj){
          if(this == obj){
              return true;
          }
          if(obj instanceof Customer){
              Customer cust = (Customer)obj;
              if(this.age == cust.age && this.name.equals(cust.name)){
                  return true;
              }
              else{
                  return false;
              }
          }
      }

    > `==`和`equals`的区别
    >
    > - ==既可以比较基本数据类型，也可以比较引用数据类型。对于基本类型就是比较值，对于引用类型就是比较内存地址
    > - equals属于java.lang.Object类的方法，如果该方法没有被重写过默认也是==；String、Data、File等类的equals方法是被重写过的，重写后比较的是实体内容是否相同
    > - 具体要看自定义类里面有没有对equals进行重写，通常情况下，重写equals，会比较类中相应属性是否相等

  - `protected void finalize()`

    - 垃圾回收，不需要主动调用

  - `String toString()`

    - 当输出一个对象的引用时，调用的实际是当前对象的`toString()`

    - 定义

      ```java
      public String toString(){
          return getClass().getName() + "@" + Integer.toHexString(hashCode());//输出的是地址值
      }
      ```

    - String、Data、File、包装类重写了`toString()`，使得调用`toString()`，返回实体内容信息

    - 自定义类重写`toString()`

      ```java
      //重写，返回实体内容
      @Override
      public String toString(){
          return "Customer[name = " + name + ",age = " + age + "]";
      }

  - . . .

- Object类只声明了一个空参构造器





### 4.15 JUnit单元测试

- 步骤
  1. 创建java类，进行单元测试
     - 此类是public
     - 此类提供公共的无参构造器
  2. 此类中声明单元测试方法
     - 权限是public，没有返回值
  3. 此单元测试方法上需要声明注解`@Test`，并在单元测试类当中导入：`import org.junit.Test;`
  4. 在方法体内测试相关方法
  5. 写完代码以后，左键双击单元测试方法名，右键：`run as - Junit Test`
  6. 绿条正常，红条异常

```java
import org.junit.Test;

public class JUnitTest{
    
    @Test
    public void testEquals(){
        String s1 = "MM";
        String s2 = "MM";
        System.out.printIn(s1.equals(s2));
    }
    
}
```



### 4.16 包装类

- 针对八种基本数据类型定义相应的引用类型——包装类（封装类）

- 基本数据类型、包装类、String三者之间相互转换

  - 基本数据类型 --> 包装类

    - 调用包装类的构造器

      ```java
      int num1 = 10;
      Integer in1 = new Integer(num1);
      
      Integer in2 - new Integer("123");
      ```

      > boolean
      > 忽略大小写为"true"即是true

    - **自动装箱**

      ```java
      int num1 = 10;
      Integer in1 = num2;

  - 包装类 --> 基本数据类型

    - 调用包装类的`xxxValue()`

      ```java
      int i1 = in1.intValue();
      float f1 = fl1.floatValue();
      ```

    - **自动拆箱**

      ```java
      int num2 = in1;
      ```

  - 基本数据类型/包装类 --> String类型

    - 连接运算

      ```java
      String str = num + "";
      ```

    - **调用String重载的`valueOf()`**

      ```java
      float f = 12.3f;
      String str = String.valueOf(f);
      ```

  - String类型 --> 基本数据类型/包装类

    - **调用包装类的`parseXxx()`**

      ```java
      int num = Integer.parseInt(str);



### 4.17 static

- static：静态的
- 用来修饰：属性、方法、代码块、内部类
  - 修饰属性
    - 静态变量（类变量）：创建了类的多个对象，多个对象共享同一个静态变量，当通过某一个对象修改静态变量时，会导致其他对象调用此静态变量，是修改过的
    - 其他说明
      - 静态变量随着类的加载而加载
      - 静态变量的加载早于对象的创建
      - 由于类只加载一次，静态变量在内存中只会存在一份，存在于方法区的静态域
      - 类和对象都可以调用静态变量
      - 举例：`System.out`、`Math.PI`
  - 修饰方法
    - 静态方法（类方法）
    - 随着类的加载而加载，可以通过类或对象调用
    - 静态方法中，只能调用静态的方法或属性
      非静态方法中，可以调用静态或非静态的方法或属性
- 在静态方法内，不能使用`this`、`super`
- 开发中
  - 确定为static变量
    - 属性被多个对象所共享
  - 确定为static方法
    - 操作静态属性的方法
    - 工具类的方法（Math、Array、Collections

- 单例设计模式

  - 采取一定的方法保证在整个软件系统中，对某个类**只能存在一个对象实例**，且该类只能提供一个取得其对象实例的方法

  - 只生成一个实例，减少了系统性能开销

  - 应用场景

    - 网站计数器
    - 日志
    - 数据库连接池
    - 读取配置文件的类
    - 任务管理器
    - 回收站

  - 饿汉式
    1. 构造器设置为`private`，类外部不能new对象，类内部可以产生该类对象
    1. 内部创建类的对象，要求此对象也必须为静态的
    1. 提供公共的静态的方法，返回类的对象

    ```java
    class Bank{
        
        private Bank(){
            
        }
        
        private static Bank instance = new Bank();
        
        public static Bank getInstance(){
            return instance;
        }
    }

  - 懒汉式

    1. 私有化类的构造器

    2. 声明当前类对象，没有初始化

    3. 声明public、static的返回当前类对象的方法

       ```java
       class Order{
           
           private Order(){
               
           }
           
           private static Order instance = null;
           
           public static Order getInstance(){
               if(instance == null){
                   instance = new Order();
               }
               return instance;
           }
       }

  - 区分饿汉式和懒汉式

    - 饿汉式
      - 对象加载时间过长
      - 线程安全的
    - 懒汉式
      - 延迟对象的创建
      - 线程不安全（待修改



### 4.18 main方法

- `main()`作为程序入口
- 是一个普通的静态方法
- 可以作为与控制台交互的方式



### 4.19 代码块

- 作用：用来初始化类、对象
- 只能使用`static`修饰
- 分类
  - 静态代码块
    - 内部可以有输出语句
    - 随着类的加载而执行，只会执行一次
    - 作用：初始化类的信息
    - 如果一个类中定义了多个静态代码块，则按照声明的顺序执行
    - 静态代码块中只能调用静态的属性、静态的方法，不能调用非静态的结构
  - 非静态代码块
    - 内部可以有输出语句
    - 随着对象的创建而执行
    - 作用：创建对象时，对对象的属性进行初始化
    - 如果一个类中定义了多个非静态代码块，则按照声明的顺序执行
    - 非静态代码块可以调用静态或非静态的结构



### 4.20 final

- final：最终的

- 可以用来修饰：类、方法、变量

  - 修饰类：

    - 此类不能被其他类所继承

      > 如String、System、StringBuffer

  - 修饰方法：

    - 此方法不能被重写

      > 如`Object.getClass()`

  - 修饰变量：

    - 此时变量就称为是一个常量
      - 修饰属性：显式初始化、代码块初始化、构造器初始化
      - 修饰局部变量：特别地，修饰形参时，则此形参是一个常量

- `static final`

  - 修饰属性：全局常量



### 4.21 抽象类与抽象方法

- `abstract`
  - abstract可以用来修饰：类、方法
    - 修饰类：
      - 此类不能实例化
      - 类中仍然提供构造器，便于子类实例化时调用
      - 开发中，都会提供类的子类，让子类对象实例化，完成相关操作
    - 修饰方法：
      - 抽象方法只有方法声明，没有方法体
      - 抽象方法只能存在于抽象类中
      - 若子类重写了父类中的所有方法后，则此类可实例化
        若子类没有重写父类中所有方法，则此类是抽象类
- 注意点
  - abstract不能修饰属性、构造器等结构
  - abstract不能用来修饰私有方法、静态方法、final的方法、final的类

- 抽象类的匿名子类

  ```java
  //创建了一匿名子类的对象
  Person p = new Person(){
      
      @override
      public void eat(){
          //
      }
      
      @Override
      public void breath(){
          //
      }
  };
  
  //创建了匿名子类的非匿名对象
  method(new Person(){
      
      @override
      public void eat(){
          //
      }
      
      @Override
      public void breath(){
          //
      }
  });

- 模板方法设计模式
  - 抽象类作为多个子类的模板
  - 将确定的通用的部分作为模板，将不确定的部分重写



### 4.22 接口

- 接口使用`interface`来定义
- Java中，接口和类是并列的两个结构
- 接口成员

  -  JDK7.0之前，只能定义全局常量和抽象方法
  -  JDK8开始，除了全局常量，和抽象方法，还可以定义静态方法、默认方法
- 接口中不能定义构造器，意味着接口不可以实例化
- 开发中，接口通过让类实现（`implements`）的方式使用

  - 如果实现类覆盖了接口中所有抽象方法，则可以实例化
  - 否则，仍为抽象类

- java类可以实现多个接口，弥补了Java单继承性的局限性
  `class AA extends BB implements CC, DD, EE`
- 接口与接口之间可以继承，可以多继承
- 接口的使用
  - 接口的具体使用，体现了多态性
  - 接口，实际上可以看作是一种规范

- 创建接口匿名实现类的对象

  ```java
  Computer com = new Computer();
  
  //创建接口的非匿名实现类的非匿名对象
  Flash flash = new Flash();
  com.transferData(flash);
  
  //创建接口的非匿名实现类的匿名对象
  com.transferData(new Flash());
  
  //创建接口的匿名实现类的非匿名对象
  USB usb = new USB(){
      
  	@Override
      //
      
      @Override
      //
  };
  
  //创建接口的非匿名实现类的匿名对象
  com.transferData(new USB(){
      @Override
      //
      
      @Override
      //
  });
  
  
  
  
  class Computer{
      transferData(USB usb){
          //
          //
      }
  }
  
  interface USB{
      //
      //
  }
  
  class Flash implements USB{
      //
      //
  }

- 代理模式

  - 为其他对象提供一种代理以控制对这个对象的访问
  - 代理类和被代理类共同实现一个接口
  - 代理类可能会提供额外的服务

  ```java
  //经纪人和明星
  Proxy p = new Proxy(new RealStar());
  ```

- 工厂模式

  - 创建者和调用者分离
  - 分类
    - 简单工厂模式
    - 工厂方法模式
    - 抽象工厂模式

- 默认方法
  - `(public) default`修饰
  - 被类实现后相当于普通的非静态方法
- 规定
  - 接口中的静态方法只能通过接口去调用
  - 通过实现类的对象，可以调用接口中的默认方法
    - 如果实现类重写了默认方法，调用的是重写后的方法
  - 类优先原则：如果子类（实现类）继承的父类和实现的接口声明了同名同参数的默认方法，那么子类没有重写此方法的情况下，默认调用父类中的方法
    - 用`接口名.super.方法()`调用接口中的默认方法（被实现类重写，父类重名）
  - 如果实现类实现了多个接口，而这个接口定义了同名同参数的默认方法，则实现类没有重写此方法情况下，报错--接口冲突



### 4.23 内部类

- 在Java中，允许一个类的定义位于另一个的内部，前者称为内部类，后者称为外部类

- 内部类的分类

  - 成员内部类
    - 静态
    - 非静态
  - 局部内部类
    - 方法内
    - 代码块内
    - 构造器内

- 成员内部类

  - 作为外部类的成员
    - 调用外部类的结构
    - 可以被`static`修饰
    - 被种权限修饰符修饰
  - 作为一个类
    - 类内定义属性、方法、构造器
    - 可以被`final``abstract`修饰

- 实例化成员内部类的对象

  - ```java
    //静态成员内部类
    Person.Dog dog = new Person.Dog();
    
    //非静态成员内部类
    Person p = new Person();
    Person.Bird bird = p.new Bird();

- 使用在成员内部类中区分调用外部类的结构

  - 内部类的属性
    `this.属性`
  - 外部类的属性
    `外部类.this.属性`

- 开发中局部内部类使用

  ```java
  //局部内部类只在类里面用
  public Comparable getComparable(){
      
      //创建一个实现了Comparable接口的类
      class MyComparable implements Comparable{
          
          @Override
          //
      }
      return new MyComparable();
      
  }



## 5 异常处理



### 5.1 异常概述和异常体系结构

- 在程序执行中发生的不正常称为“异常”

  - 语法错误和逻辑错误不是异常

- 分类

  - Error

    - JVM无法解决的严重问题。

      > - JVM系统内部错误
      > - 资源耗尽
      > - `StackOverflowError`栈溢出
      > - `OutOfMemoryError`堆溢出

    - 一般不编写针对性代码进行处理

  - Exception

    - 因编程性错误或偶然的外在因素导致的一般性问题

      > - 空指针访问
      > - 试图读取不存在的文件
      > - 网络连接中断
      > - 数组角标越界

    - 用针对性代码进行处理

    - 分类

      - 编译时异常（checked受检）
      - 运行时异常（unchecked非受检）

- 异常体系结构
  - java.lang.Throwable
    - java.lang.Error
    - java.lang.Exception
      - checked
        - IOExcepption
          - FileNotFoundException
        - ClassNotFoundException
        - . . .
      - unchecked
        - NullPointerException
        - ArrayIndexOutOfBoundException
        - ClassCastExceprion
        - NumberFormatException
        - InputMismatchException
        - ArithmeticException
        - . . .

- java把异常处理的程序代码集中，与正常代码分开
- 抓抛模型
  - 抛
    - 程序再正常执行过程中，一旦出现异常，就会在异常代码处生成一个对应异常类的对象，并将此对象抛出；
    - 一旦抛出对象后，其后代码不再执行
  - 抓
    - 可以理解为异常处理方式
      - `try-catch-finally`
      - `throws`+异常类型



### 5.2 常见异常

- NullPointerException

  ```java
  int arr = null;
  System.out.printIn(arr[3]);

- ArrayIndexOutOfBoundException

  ```java
  int arr = new int[10];
  System.out.printIn(arr[10]);
  ```

- ClassCastException

  ```java
  Object obj = new Data();
  String str = (String)obj;

- NumberFormatException

  ```java
  String str = "abc";
  int num = Integer.parseInt(num);
  ```

- InputMismatchException

  ```java
  Scanner sc = new Scanner(System.in);
  int score = sc.nextInt();
  //输入abc
  ```

- ArithmeticException

  ```java
  int a = 10;
  int b = 0;
  int c = a/b;

- FileNotFoundException

  ```java
  File file = new File("hello.txt");
  FileInputStream fls = new FileInputStream(file);
  //
  fls.close();



### 5.3 try-catch-finally

- 结构

  ```java
  try{
      //可能出现异常的代码
  }catch(异常类型1 变量名1){
      //处理异常方式1
  }catch(异常类型2 变量名2){
      //处理异常方式2
  }
  ...
  finally{
      //一定会执行的代码
  }

- `try-catch`说明
  - 使用`try`将可能出现异常的代码包装，在执行过程中，一旦出现异常，就会生成一个对应异常类的对象，根据此对象的类型，去`catch`中进行匹配
  - 一旦`try`中的异常对象匹配到一个`catch`，就进入`catch`中进行异常处理，处理完成后就跳出当前`try-catch`结构（不包含`finally`），继续执行其后代码
  - `catch`中的异常类型，如果没有子父类关系，则声明顺序无所谓
    `catch`中的异常类型，如果有子父类关系，则子类必须声明在父类上面；否则报错
  - 常用的异常对象处理方式
    - `String getMessage()`
    - `void printStackTrace()`
  - `try`结构中声明的变量不能在结构外调用
  - `try-catch-finally`可以嵌套

- `finally`说明
  - `finally`是可选的
  - `finally`中声明的是一定会被执行的代码，即使
    - `catch`中又出现异常了
    - `try`中有`return`语句
    - `catch`中有`return`语句
  - 使用情况
    - 像数据库连接、输入输出流、网络编程等资源，JVM不能自动地回收，需要自己手动进行资源的释放，就需要写在`finally`中
- 使用
  - `try-catch-finally`处理编译时异常，使得程序在编译时不再报错，运行时仍可能报错，相当于将编译时异常延迟到运行时出现
  - 开发中，由于运行时异常比较常见，所以通常不针对运行时异常进行`try-catch-finally`处理，针对编译时异常则一定要处理



### 5.4 throws

- 结构

  ```java
  方法 throws 异常类型1, 异常类型2, ...{
      
  }

- 说明
  - 写在方法的声明处，指明此方法执行时，可能会生成抛出的异常类型；有一单方法体执行时，出现异常，仍会在异常处生成一个异常对象，此对象满足`throws`后异常类型时，就会被抛出。异常代码后续代码不再执行
  - 只是将异常抛出给了方法的调用者，并没有真正地将异常处理掉

- 方法重写
  - 子类重写抛出地异常类型不大于父类被重写的异常类型（多态）

- 开发中如何选择使用`try-catch-finally`还是`throws`
  - 如果父类中被重写的方法没有`throws`方式处理异常，则子类被重写的方法也不能使用`throws`，意味着子类中只能使用`try-catch-finally`方式处理异常
  - 执行方法中先后调用了另外的几个方法，这几个方法是递进关系，建议这几个方法使用`throws`处理，而执行的方法使用`try-catch-throws`



### 5.5 手动抛出异常：throw

- 异常对象的产生

  - 系统自动生成的异常对象
  - 手动地生成一个异常对象，`throw`

- 手动抛出异常结构

  ```java
  throw new RuntimeException("错误信息");
  throw new Exception("错误信息");//编译时就需要处理
  ```



### 5.6 用户自定义异常类

- 步骤

  1. 继承于现有的异常`RuntimeException`，`Exception`
  2. 提供全局常量`serialVersionUID`，标识一个类
  3. 提供重载的构造器

- 示例

  ```java
  public class MyException extends RuntimeException{
      static final long serialVersionUID = -70454385933475348L;
      
      public MyException(){
          
      }
      
      public MyException(String msg){
          super(msg);
      }
  }





## 6 IDEA介绍



### 6.1 Module

- 概念
  - Project工程，对应一个窗口，一个大项目
  - Module模块，比如不同功能模块



### 6.2 常用配置

- `Settings` 
  - `Appearace & Behavior`
    - 主题设置
      - 获取更多主题：www.riaway.com
      - 导入主题：`file` > `import settings`
    - 字体设置
  - `Editor`
    - `General`
      - 设置鼠标滚轮修改字体大小
      - 设置鼠标悬浮提示
      - 设置自动导包功能`Auto import`
      - 设置显示行号和方法间的分隔符： `Appearance`
      - 设置忽略大小写提示
    - `Font`
      - 设置字体
    - `Code Scheme`
      - `Language Default`
    - `Code Style`
      - `Java`
        - import自动收缩
    - `File and Code Templates`
      - 类头文档注释
    - `File Encoding`
      - 编码格式
  - `Build, Exection, Deployment`
    - `Compiler`
      - 自动重新编译
- `Keymap`
  - 快捷键设置



### 6.3 模板

- 相关功能
  - `Editor > General > Profix Completion`
  - `Editor > Live Template`
- `sout` = `System.out.println()`



