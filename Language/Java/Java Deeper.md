# Java高级编程

[TOC]



## 1 多线程



### 1.1 基本概念

- 线程和进程
  - 进程
    - 系统资源分配的单位
  - 线程
    - 系统调度的基本单位
    - 每一个线程有一份独立的运行栈和程序计数器
    - 一个进程的多个线程共享相同的内存单元（堆、方法区）

- 并发和并行
  - 并行：同一时间点执行
  - 并发：同一时间间隔内执行
- 多线程优点
  - 提高应用程序的响应
  - 提高CPU的利用率
  - 改善程序结构
- 应用场景
  - 执行多个任务
  - 实现需要等待的任务（用户输入、文件读写、网络操作、搜索）
  - 后台运行程序



### 1.2 线程的创建和使用

- JVM允许程序运行多个线程，它通过`java.lang.Thread`类实现

- Thread类的特性

  - 通过`run()`方法来操作，方法体称为线程体
  - 通过`start()`方法启动线程

- 多线程的创建

  - 继承于Thread类

    1. 创建一个继承于Thread类的子类
    2. 重写Thread类的`run()` —— 将线程执行的操作声明其中
    3. 创建Thread类的子类的对象
    4. 通过此对象调用`start()`来开启线程

  - 实现`Runnable`接口

    1. 创建一个实现了Runnable接口的类

    2. 实现类去实现Runnable中的抽象方法：`run()`

    3. 创建实现类的对象

    4. 将此对象作为参数传入到Thread类的构造器中，创建Thread类的对象

    5. 通过Thread类的对象调用`start()`

       > 调用了Runnable类型的target对象

- 两种创建方式的比较

  - 开发中优先选择实现接口方式
    - 没有单继承的局限性
    - 更适合处理多个线程共享数据（不需要`static`）
  - 联系
    - 不管是继承还是实现接口方式，都需要重写`run()`方法

- Thread类常用方法
  - `start()`
    - 启动线程，调用`run()`
  - `run()`
    - 线程被调度时执行的操作
  - `currentThread()`
    - 静态方法，返回执行当前代码的线程（主线程）
  - `getName()`
    - 获取当前线程的名字
  - `setName()`
    - 设置当前线程的名字
  - `yield()`
    - 释放当前cpu的执行权
  - `join()`
    - 在线程a中调用线程b的`join()`，则线程a进入阻塞状态，知道线程b完全执行完之后，线程a才结束阻塞状态
  - `stop()`
    - 强制线程生命期结束
    - 不建议使用
  - `sleep()`
    - 单位：毫秒
    - 休眠，当前线程是阻塞态
    - 抛出`InterruptException`异常，只能`try-catch`
  - `isAlive()`
    - 判断当前线程是否存活
- 线程调度
  - Java线程调度策略
    - 同优先级线程组成先进先出队列，使用时间片策略
    - 对高优先级，使用优先调度的抢占式策略
  - 优先级
    - 等级
      - `MAX_PRIORITY`：10
      - `MIN_PRIORITY`：1
      - `NORM_PRIORITY`：5
    - 涉及的方法
      - `getPriority()`返回线程优先级
      - `setPriority()`改变线程优先级
    - 说明
      - 线程创建时，继承父线程优先级
      - 低优先级只是获得调度的概率低，并非一定是在高优先级线程之后才调用



### 1.3 线程的生命周期

- Thread.State类定义了线程的几种状态

  - 新建
  - 就绪
  - 运行
  - 阻塞
  - 死亡

  <img src="C:/Users/Oliver/AppData/Roaming/Typora/typora-user-images/image-20220308201840022.png" alt="image-20220308201840022" style="zoom:50%;" />



### 1.4 线程的同步

- 同步机制

  - 同步代码块

    - 结构

      ```java
      synchronized(同步监视器){
          //需要同步的代码
      }
      ```

    - 操作共享数据的代码，即需要同步的代码

    - 同步监视器：锁。任何一个类的对象都可以充当锁

      - 实现接口方式：`private Object obj = new Object();`  / `this`
      - 继承类方式：`private static Object obj = new Object()`

    - ==多个线程必须共用一把锁==

  - 同步方法

    - 如果操作共享资源的代码完整地声明在一个方法中，则声明此方法是同步的

    - 结构

      ```java
      private synchronized void show(){}//实现接口
      private static synchronized void show(){}//继承类接口

    - 同步监视器：

      - 实现接口方式：`this`
      - 继承类方式：`当前类.class`

  - 锁Lock
    - jDK 5.0新增，通过显式定义同步锁来实现同步
    - 步骤
      1. 实例化`ReentrantLock`
      2. 调用锁定方法`lock()`
      3. 调用解锁方法`unlock()`
    - 特点
      - 需要手动开启和关闭锁
      - 只有代码块锁，没有方法锁
      - 性能更好，具有更好的扩展性

- 使用同步机制将单例模式中的懒汉式改写为线程安全的

  ```java
  //方式一：效率较低
  class Bank(){
      
      private Bank(){}
      
      private static Bank() instance = null;
      
      public static synchronized Bank getInstance(){
          
          if(instance == null){
              instance = new Bank();
          }
          return instance;
      }
  }
  
  //方式二
  class Bank(){
      
      private Bank(){}
      
      private static Bank() instance = null;
      
      
      public static Bank getInstance(){
          
          if(instance == null){
              
              synchronized(Bank.class){
                  if(instance == null){
                      instance = new Bank();
                  }
              }
              
          }
          return instance;
      }
  }

- 死锁
  - 不同的线程分别占用对方的同步资源不放弃，都在等待对方放弃自己需要的同步资源



### 1.5 线程的通信

- 通信三方法

  - `wait()`
    - 使得当前线程进入阻塞状态，并释放同步监视器
  - `notify()`
    - 一旦执行此方法，就会唤醒被wait的一个线程；如果有多个线程，就唤醒优先级最高的线程
  - `notifyAll()`
    - 一旦执行此方法，就会唤醒所有被wait的线程

- 说明

  - 三种方法都必须在同步代码块或同步方法中
  - 这三种方法的调用者都必须是同步监视器，否则出现`illegalMonitorStateException`异常
  - 这三个方法定义在Object类中

  > `sleep()`和`wait()`的异同
  >
  > - 相同
  >   - 一旦执行方法，都使得当前线程进入阻塞状态
  > - 不同
  >   - 声明的位置不同，Thread中声明sleep，Object中声明wait
  >   - 调用的要求不同，sleep可以在任意场景下使用，wait只能在同步代码块或同步方法中使用
  >   - 如果两个方法都使用在同步代码块或同步方法中，sleep不释放锁，wait释放锁



### 1.6 JDK5.0新增线程创建方式

- 实现Callable接口

  - 优势

    - 相比`run()`方法，可以有返回值
    - 方法可以抛出异常
    - 支持泛型的返回值
    - 需要借助FutureTask类，比如获取返回值

  - 步骤

    1. 创建一个实现Callable类的实现类
    2. 实现call方法，将此线程需要执行的操作声明在`call()`中
    3. 创建Callable接口的实现类对象
    4. 将此对象作为参数传递到FutureTask的构造器中，创建FutureTask对象
    5. 将FutureTask的对象传递到Thread类对象中，创建Thread类对象，并调用`start()`
    6. 获取Callable中call方法的返回值

  - 结构

    ```java
    class MyThread implements Callable{
        
        @Override
        public Object call() throws Exception{
            //
        }
    }
    
    public class ThreadNew{
        public static void main(String[] args){
            MyThread myThread = new MyThread();
            
            FutureTask futureTask = new FutureTask(myThread);
            
            new Thread(futureTask).start();//启动线程
            
            try{
                //get()返回值即为FutureTask构造器参数Callable实现类重写的call()的返回值
                Object result = futureTask.get();
            }catch(InterruptedException e){
                e.printStackTrace();
            }catch(ExecutionException e){
                e.printStackTrace();
            }
        }
    }

- 使用线程池

  - 提前创建好多个线程，放入线程池中，使用时直接获取，使用完放回池中

  - 优势

    - 提高响应速度
    - 降低资源小号
    - 便于线程管理
      - `corePoolSize`：核心池大小
      - `maximumPoolSize`：最大线程数
      - `keepAliveTime`：线程没有任务时最多保持多长时间

  - 步骤

    1. 提供指定线程数量的线程池
    2. 执行指定线程的操作，需要提供Runnable或Callable接口实现类的对象
    3. 关闭连接池

  - 结构

    ```java
    public class ThreadPool{
        
        public static void main(String[] args){
            
         
            ExecutorService service = Executors.newFixedThreadPool(10);
            
            //设置线程属性
            ThreadPoolExecutor service1 = (ThreadPoolExecutor)service;
            service1.setCorePoolSize(15);
            service1.keepAliveTime(100);
            
            service.execute(new MyThread());//适合用于Runnable
            //service.submit(Callable callale);//适合用于Callable
            
            service.shutdown();
        }
    }





## 2 Java常用类



### 2.1 String类

- `String`的特性

  - 是一个final类，不可被继承
  - 实现了`Serializable`接口，表示支持序列化
    实现了`Comparable`接口，表示可以比较大小
  - `String`对象的字符内容存储在字符数组`value[]`中
  - `String`代表不可变的字符序列，简称不可变性
    - 当对字符串重新赋值时，需要重写指定区域内存赋值，不能使用原有的value进行赋值
    - 当对现有的字符串进行连接操作时，也需要重新指定内存区域赋值，不能使用原有的value进行赋值
    - 当调用`String.replace()`方法修改指定字符或字符串时，也需要重新指定内存区域赋值
  - 通过字面量的方式（区别于`new`）给字符串赋值，此时的字符串值声明在方法区的字符串常量池中。字符串常量池只维护相同内容的一个字符串

  ```java
  String s1 = "abc";//字面量定义方式
  s1 = "hello";//s1: "hello"
  s1 += " world"; //s1: "hello world"
  ```

  - 通过`new`+构造器方式构造String对象，此时字符串非常量存储在堆空间中；本质上构造了两个对象：

    - 堆空间中new结构
    - `char[]`对应字符串常量池中的数据

  - 不同拼接操作对比

    - 常量与常量拼接操作的结果在常量池，且常量池中不会存在相同内容的常量

      > `final`会把变量变为常量

    - 只要拼接操作中有一个是变量，结果就在堆中

    - 如果凭借的结果调用`intern()`方法，结果在常量池中

- `String`常用方法

  - `int length()`
    - 返回字符串长度
  - `char charAt(int index)`
    - 返回索引处的字符
  - `boolean isEmpty()`
    - 判断是否是空字符串
  - `String toLowerCase()`
    - 将所有字符转换为小写
  - `String toUpperCase()`
    - 将所有字符转换为大写
  - `String trim()`
    - 裁剪前导空白和尾部空白
  - `boolean equals(Object obj)`
    - 比较内容是否相同
  - `boolean equalsIgnoreCase(String anotherString)`
    - 忽略大小写比较内容
  - `String concat(String str)`
    - 将指定字符串连接到尾部，等价于`+n`
  - `int compareTo(String anotherString)`
    - 比较两个字符串大小，涉及到字符串排序
  - `String substring(int beginIndex)`
    - 返回一个新的字符串，它是从指定索引开始截取
  - `String substring(int beginIndex, int endIndex)`
    - 返回子串
    - 左闭右开
  - `boolean endWith(String suffix)`
    - 判断是否以指定后缀结束
  - `boolean startsWith(String prefix)`
    - 判断是否以指定前缀开始
  - `boolean startsWith(String prefix, int toffset)`
    - 判断从指定索引开始的字串是否以指定前缀开始
  - `boolean contains(CharSequence s)`
    - 判断是否包含指定的char值序列
    - char值序列可以是String类型
  - `int indexOf(String str)`
    - 返回指定子串第一次出现的索引值
  - `int indexOf(String str, int fromIndex)`
    - 返回指定子串第一次出现的索引值，从指定的索引开始
  - `int lastIndexOf(String str)`
    - 返回指定子串最后一次出现的索引值
  - `int lastIndexOf(String str, int fromIndex)`
    - 返回指定子串最后一次出现的索引值，从指定的索引开始反向搜索

  > 若没找到则返回`-1`

  - `String replace(char oldChar, char newChar)`
    - 替换所有指定字符
  - `String replace(CharSequence target, CharSequence replacement)`
    - 替换所有指定字串
  - `String replaceAll(String regex, String replacement)`
    - 替换所有符合指定正则表达式的子串
  - `String replaceFirst(String regex, String replacement)`
    - 替换第一个符合指定正则表达式的子串
  - `boolean matches(String regex)`
    - 判断是否匹配正则表达式
  - `String[] split(String regex)`
    - 根据指定正则表达式的匹配拆分字符串
  - `String[] split(String regex, int limit)`
    - 根据指定正则表达式的匹配拆分字符串
    - 最多不超过指定限制个，若超过则剩余的全部放在最后一个元素

- `String`与`char[]`之间的转换

  - `String` --> `char[]`
    - 调用`String`的`toCharArray()`方法
  - `char[]` --> `String`
    - 调用`String`的构造器

- `String` 和 `byte[]`之间的转换

  - `String` --> `byte[]`（编码）

    - 调用`String`的`getBytes()`方法

      > 可以指定字符集进行转换

  - `byte[]` --> `String`（解码）
    - 调用`Arrays.toString(byte[])`方法

- `StringBuffer`类

  - 底层数组解析

    - 初始char[]长度为：初始化字符串长度+16

      > 调用`length()`返回的仍是实际字符串长度

    - 扩容问题：如果要添加的数据底层数组容不下了，那就需要扩容底层数组；
      默认情况下扩容为原来容量的2倍+2，同时将原有数组中的元素复制到新的数组中

  - 常用方法

    - `StringBuffer append(String xxx)`
      - 字符串拼接
    - `StringBuffer delete(int start, int end)`
      - 删除指定位置的内容
    - `StringBuffer replace(int start, int end, String str)`
      - 把[start, end)内容替换为str
    - `StringBuffer insert(int offset, String str)`
      - 在指定位置插入xxx
    - `StringBuffer reverse()`
      - 把当前字符串逆转
    - `void setCharAt(int index, char ch)`
      - 设置指定索引字符

    > 如上方法支持方法链

  > `StringBuilder`类似

> 【String、StringBuffer、StringBuilder三者的异同】
>
> - String：
>   - 不可变的字符序列
>   - 底层使用char[]存储
>   - 效率最低
> - StringBuffer：
>   - 可变的字符序列
>   - 线程安全的，效率偏低
>   - 底层使用char[]存储
> - StringBuilder：
>   - 可变的字符序列
>   - jdk5.0新增的，线程不安全的，效率较高
>   - 底层使用char[]存储



### 2.2 JDK8.0之前的日期时间API

- `java.lang.System`类中的`currentTimeMillis()`

  - 返回时间戳：1970年1月1日0时0分0秒之间以毫秒为单位的时间差

  - 单位：毫秒
  - 适用于计算时间差

- `java.util.Date`类

  - 两个构造器

    - `Date()`
      - 创建一个对应当前日期时间的Date对象
    - `Date(long date)`
      - 创建对应指定毫秒数的Date对象

  - 两个方法

    - `toString()`
      - 显示当前的年月日时分秒
    - `getTime()`
      - 获取时间戳

  - 子类`java.sql.Date`对应着数据库中日期类型的变量

    - 创建对象
      `java.sql.Date date = new java.sql.Date(3487236478L)`

    - 将`java.util.Date`转换为`java.sql.Date`
      - 强制转换
      - 利用`getTime()`

- `java.text.SimpleDateFormat`类

  - 易于国际化
  - 实例化
    - `SimpleDateFormat()`
    - `SimpleFataFormat(String pattern)`
      - pattern可自定义格式
        `yyyy-MM-dd hh:mm:ss`
  - 格式化：日期>文本
    - `String format(Date date)`
  - 解析：文本>日期
    - `Date parse(String source)`

- `java.util.Calendar`类

  - 信息

    - `YEAR`

    - `MONTH`

      > 从0开始算月份

    - `DAY_OF_MONTH`

    - `DAY_OF_WEEK`

      > 从1开始算

    - `HOUR_OF_DAY`

    - `MINUTE`

    - `SECOND`

  - 实例化
    - 调用静态方法`Calendar.getInstance()`
    - 创建其子类`GregroianCalendar`对象
  - 常用方法
    - `get()`
    - `set()`
    - `add()`
    - `getTime()`
      - `Calendar` > `Date`
    - `setTime()`
      - `Date` > `Calendar`





### 2.3 JDK 8中新日期时间API

- `LocalDate`，`LocalTime`，`LocalDateTime`

  - `now()`
    - 获取当前的日期、时间、日期+时间
  - `of()`
    - 设置指定日期、时间、日期+时间，没有偏移量
  - `getXxx()`
    - 获取指定量
  - `withXxx()`
    - 设置指定量，体现不可变性
  - `plusXxx()`
    - 增加指定量，体现不可变性
  - `minusXxx()`
    - 减去指定量，体现不可变性

- `Instant`

  - `now()`

    - 获取本初子午线对应标准时间

    > 添加时间偏移量：
    >
    > ```java
    > OffsetDateTime offsetDateTime = instant.atOffset(ZoneOffset.offHours(8));

  - `toEpochMilli()`

    - 获取对应的毫秒数

  - `ofEpochMilli()`

    - 获取指定毫秒数的instant对象

- `DateTimeFormatter`类

  - 与`SimpleDateDormat`类似
  - - 格式实例化
      - 预定义的标准格式`ISO_LOCAL_DATE_TIME`，`ISO_LOCAL_DATE`，`ISO_LOCAL_TIME`
      - 本地化相关的格式`ofLocalizedDateTime(FormatStyle.LONG)`
      - 自定义的格式`ofPattern(String pattern)`
    - 格式化
      - `format()`
    - 解析
      - `parse()`





### 2.4 Java比较器

- `Comparable`接口

  - 自然排序

  - 像String、包装类等，实现了Comparable接口，重写了`comparableTo(obj)`方法
  - 重写`comparableTo(obj)`的规则
    - this > anotherObject，返回正整数
    - this < anotherObject，返回负整数
    - this == anotherObject，返回0

- `Comparator`接口

  - 定制排序
  - 当元素的类型没有实现`java.lang.Comparable`接口而又不方便修改代码，或者实现了`Comparable`但是排序规则不适合当前排序，则用`Comparator`“特别定制”
  - 重写`compare()`方法
  - 应用：排序二维数组
    ```java
    Arrays.sort(arr, new Comparator<int[]>(){
        @Override
        public int compare(int[] o1, int o2){
            if(o1[0] == o2[0]){
                return o1[1]-o2[2];
            }
            return o1[0]-o2[0];
        }
    })
    ```
  
    



### 2.5 System类

- 代表系统
- 构造器是private的，无法实例化
- 成员变量
  - `in`
  - `out`
  - `err`
- 成员方法
  - `native long currentTimeMillis()`
  - `exit(int status)`
    - 退出程序
  - `void gc()`
    - 请求系统进行垃圾回收
  - `String getProperty(String key)`
    - 获取属性



### 2.6 Math类

- `abs()`
- `sqrt()`
- `pow(double a, double b)`
- `log()`
- `exp()`
- `max(double a, double b)`
- `min(double a, double b)`
- `random()`
  - 返回0.0-1.0的随机数
- `long round(double a)`
  - 四舍五入



### 2.7 BigInteger与BigDecimal类

- `BigInteger`类
  - 表示不可变的任意精度的整数
  - 构造器
    - `BigInteger(String val)`
- `BigDecimal`类
  - 表示不可变的、任意精度的有符号十进制定点数
  - 构造器
    - `BigDecimal(double val)`
    - `BigDecimal(String val)`



## 3 枚举类&注解



### 3.1 枚举类

- 枚举类

  - 当类的对象是有限个、确定的，称此类为枚举类
  - 若枚举只有一个对象，则作为单例模式的实现方式

  - 枚举类定义

    - 自定义枚举类

      - 步骤

        1. 提供类对象的属性，用`private final`修饰
        2. 私有化类的构造器
        3. 提供当前枚举类的多个对象
        4. 提供`getXxx()`方法
        5. 提供`toString()`方法

      - 结构

        ```java
        class Season{
            private final String seasonName;
            private final Striing seasonDesc;
            
            private Season(String seasonName, String seasonDesc){
                this.seasonName = seasonName;
                this.seasonDesc = seasonDesc;
            }
            
            public static final Season SPRING = new Season("春天", "交配的季节");
            public static final Season SUMMER = new Season("夏天", "醉生梦死的季节");
            ...
                
            
        }
            
        ```

    - 使用`enum`定义枚举类

      - 定义的枚举类默认继承于`java.lang.Enum`

      - 步骤

        1. 提供给多个枚举类的对象，多个对象用`,`分隔，末尾用`;`结束
        2. 提供类对象的属性，用`private final`修饰
        3. 私有化类的构造器
        4. 提供`getXxx()`方法

      - 结构

        ```java
        enum Season{
            
            SPRING("春天","春暖花开"),
            SUMMER("夏天","醉生梦死"),
            AUTUMN("秋天","秋高气爽"),
            WINTER("冬天","冰天雪地");
            
            private final String seasonName;
            private final Striing seasonDesc;
            
            private Season(String seasonName, String seasonDesc){
                this.seasonName = seasonName;
                this.seasonDesc = seasonDesc;
            }
            
            
        }
        ```

  - `Enum`类常用方法

    - `values()`
      - 返回枚举类型的对象数组
      - 便于遍历
    - `valueOf(String objName)`
      - 返回指定对象名的对象
    - `toString()`
      - 返回当前枚举类对象常用的名称

  - `Enum`类实现接口

    - 在enum类中实现抽象方法

    - 针对每一个对象实现抽象方法

      ```java
      SPRING("春天","春暖花开"){
          public void show(){
              //
          }
      },
      ...
      ```



### 3.2 注解

- 注解

  - 概述

    - 元数据
    - 其实就是特殊标记
    - 可用于修饰包、类、构造器、方法、成员变量、参数、局部变量
    - 框架 = 注解 + 反射 + 设计模式

  - 常见注解示例

    - 生成文档相关的注释
      - `@author`
      - `@version`
      - `@date`
      - `@param`
      - `@return`
    - 编译时进行格式检查
      - `@Override`
      - `@Deprecated`
      - `@SuppressWarnings`
    - 跟踪代码依赖性，实现替代配置文件功能

  - JDK内置的三个基本注解

    - `@Override`
      - 限定重写父类方法
    - `@Deprecated`
      - 表示当前结构已经过时，不建议使用
    - `@SuppressWarnings`
      - 抑制编译器警告

  - 自定义注解

    - 步骤
      1. 使用`@interface`关键字
      2. 使用无参数方法`value()`声明成员变量
      3. 可以通过default指定默认值
      4. 如果自定义注解没有成员，则作标记

    - 结构

      ```java
      public @interface MyAnnotation{
          
          String value();
           
      }
      ```

  - JDK中的4种元注解

    - `@Retention`
      - 只能同于修饰一个注解定义，指定该注解的生命周期
      - value取值
        - `RetentionPolicy.SOURCE`
        - `RetentionPolicy.CLASS`（默认行为）
        - `RetentionPolicy.RUNTIME`
    - `@Target`
      - 只能用于修饰注解，指定注解能用于修饰哪些元素
      - value取值
        - `CONSTRUCTOR`
        - `FIELD`
        - `LOCAL_VARIABLE`
        - `METHOD`
        - `PACKAGE`
        - `PARAMETER`
        - `TYPE`

    - `@Documented`
      - 只能用于修饰注解，表明注解在被javadoc解析时保留下来
      - 定义为`Documented`的注解必须设置`Retention`值为`RUNTIME`
    - `@Inherited`
      - 只能用于修饰注解，表明注解具有继承性：如果某个类使用了该注解，其子类自动具有该注解

  - jdk 8.0中注解新特性

    - 可重复注解

      - 实现

        1. 在MyAnnotation上声明`@Repeatable(MyAnnotations.class)`

        2. MyAnnotation和MyAnnotations的Target和Retention等元注解相同

        3. MyAnnotation结构

           ```java
           public @interface MyAnnotations{
               MyAnnotation[] value();
           }

      - 类型注解

        - `TYPE_PARAMETER`
          - 该注解能写在类型变量的声明语句中（泛型）
        - `TYPE_USE`
          - 该注解能写在使用类型的任何语句中



## 4 Java集合



### 4.1 Java集合框架概述

- 集合框架的概述

  - 集合、数组都是对多个数据进行存储操作的结构，简称java容器

    > 此时的存储，主要指的是内存层面的存储

  - 数组在存储多个数据方面的特点

    - 一旦初始化后，长度就确定了，不可修改
    - 数据一旦确定后，其元素的类型确定了，只能操作指定类型的数据
    - 数组提供的方法非常有限，不方便而且效率不高
    - 没有现成的属性或方法去获取数组中实际元素的个数
    - 有序、可重复；对于无序或不可重复的需求不能满足

- 集合框架结构

  - `Collection`接口：单列集合，存储多个对象
    - `List`接口：存储有序的、可重复的数据，“动态数组”
      - `ArrayList`、`LinkedList`、`Vector`
    - `Set`接口：存储无序的、不可重复的数据，“元组”
      - `HashSet`、`LinkedHashSet`、`TreeSet`
  - `Map`接口：双列集合，存储多对(key-value）对象
    - `HashMap`、`LinkedHashMap`、`TreeMap`、`Hashtable`、`Properties`



### 4.2 Collection接口常用方法

- `Collection`接口中的方法

  - `add(Object obj)`

    - 添加元素

  - `size()`

    - 获取添加的元素的个数

  - `addAll(Collection coll)`

    - 添加coll集合中的元素

  - `isEmpty()`

    - 判断是否为空

  - `clear()`

    - 清空

  - `contains(Object obj)`

    - 判断集合中是否包含e
    - 判断利用的是`equals()`

    > 向Collection接口类的实现类的对象中添加数据obj时，要求obj所在类要重写`equals()`

  - `containsAll(Collection coll)`

    - 判断coll中所有元素是否都在当前集合中

  - `remove(Object obj)`

    - 从当前集合中移除obj元素，

  - `removeAll(Collection coll)`

    - 从当前集合中移除coll中所有元素

  - `retainAll(Collection coll)`

    - 求交集

  - `equals(Object obj)`

    - 比较是否相同

  - `hashCode()`

    - 获得哈希值

  - `toArray()`

    - 集合转换为数组

    > 【数组转换为集合】
    >
    > - `Arrays.asList()`

  - `iterator()`

    - 返回`Iterator`接口的实例，用于遍历集合元素
    - 每次使用都会产生一个全新的`Iterator`对象，默认游标都在第一个元素之前



### 4.3 Iterator迭代器接口

- `Iterator`迭代器接口

  - `hasNext()`
    - 判断是否还有下一个元素
  - `next()`
    - 指针下移、返回下移后指针所指元素
    - 初始状态指针指向空
  - `remove()`
    - 在遍历过程中，移除元素
    - 在`next()`调用之前 或 连续两次调用`remove()`都会报错

  ```java
  Iterator iterator = coll.iterator();
  while(iterator.hasNext()){
      System.out.println(iterator.next());
  }
  ```

- foreach循环

  - `for(集合元素的类型 局部变量 : 集合对象)`
  - 内部仍然调用了迭代器
  - 局部变量是和集合对象无关的新变量，因此赋值操作不会改变集合对象的值

  ```java
  for(Object obj : coll){
      //
  }
  ```



### 4.4 Collection子接口之一：List接口

- `List`接口概述

  - 元素有序、可重复

  - 元素有索引

  - 实现类：

    - `ArrayList`：作为List的主要实现类；线程不安全的、效率高；底层使用Object[]存储
    - `LinkedList`：对于频繁的插入、删除操作，使用效率高；底层使用双向链表存储
    - `Vector`：作为List的古老实现类，线程安全的、效率不高；底层使用Object[]存储

    > 【ArrayList、LinkedList、Vector的异同】
    >
    > - 同：三个类都实现了List的接口；存储有序的、可重复的元素
    > - 异：见上

- `ArrayList`的源码分析（jdk7）

  - `ArrayList list = new ArrayList();`
    底层创建了容量是10的Object[]数组
  - `list.add(123);`
    如果此次的添加导致底层数组容量不够，则扩容；
    默认情况下，扩容为原来的1.5倍，同时需要将原来数组的数据复制到新的数组中
  - 建议开发中使用带参的构造器：`ArrayList list = new ArrayList(int capacity)`

  > 【jdk8中ArrayList的变化】
  >
  > - `ArrayList list = new ArrayList();`
  >   底层Object[]初始化为{}，并没有创建长度为10的数组
  > - `list.add(123);`
  >   第一次调用`add()`时，底层才创建了长度10的数组，并将数据添加
  > - 延迟数组的创建，内存节省

- `LinkedList`的源码分析

  - `LinkedList list = new LinkedList();`
    内部声明了`Node`类型的first和last属性
  - `list.add(123);`创建了新的Node对象
  - `Node`定义了`prev`和`next`，体现双向性

- `Vector`的源码分析

  - 扩容：2倍
  - 一般不使用了

- `List`接口的常用方法

  - `void add(int index, Object obj)`
  - `Object get(int index)`
  - `Object remove(int index)`
  - `Object set(int index, Object obj)`





### 4.5 Collection子接口之二：Set接口

- `Set`接口概述
  - 无序的、不可重复的
    - 无序性：不等于随机性；存储的数据在底层数组中并非按照数组索引的顺序添加，而是根据数据的哈希值
    - 不可重复性：保证添加的元素按照equals()判断时，不能返回true，相同的元素只能添加一个
  - 实现类
    - `HashSet`：Set接口的主要实现类；线程不安全的；可以存储null值；底层数组+链表结构
    - `LinkedHashSet`：作为`HashSet`的子类；遍历其内部数据时，可以按照添加的顺序遍历；对于频繁的遍历操作，效率较高
    - `TreeSet`：可以按照添加对象的指定属性，进行排序；底层是红黑树
- 添加元素的过程（以HashSet为例）
  - 向HashSet中添加元素a，首先调用元素a所在类的`hashCode()`方法，计算元素a的哈希值，此哈希值接着通过某种算法计算出HashSet底层数组中的存放位置，判断此位置上是否已有元素
    - 如果此位置上没有其他元素，则元素a添加成功
    - 如果此位置上有其他元素（或以链表形式存在的多个元素），则比较hash值
    - 如果hash值相同，则需要调用元素a所在类的`equlas()`方法
      - `equals()`返回true，元素a添加失败
      - `equals()`返回false，元素a添加成功
  - 要求向Set中添加的数据，其所在的类一定要重写`hashCode()`和`equals()`
    - 原则：相等的对象一定要有相等的哈希值
- `LinkedHashSet`的使用
  - 在添加数据的同时，每个数据还维护了一个两个指针，记录前一个数据和后一个数据
  - 优点：对于频繁的遍历操作，效率较高
- `TreeSet`的使用
  - 向`Treeset`中添加的数据，必须得是相同类型的对象
  - 两种排序方式：自然排序、定制排序
    - 比较元素是否相同的方法不是`equals()`



### 4.6 Map接口

- `Map`接口概述

  - `HashMap`：作为主要的实现类；线程不安全的，效率高；存储null的key和value；底层使用数组+链表+红黑树（jdk8）
    - `LinkedHashMap`：保证在遍历map元素时，可以按照添加的顺序遍历；在HashMap基础上添加了一对双向指针；对于频繁的遍历操作，效率较高
  - `TreeMap`：保证按照添加的key-value对进行排序，实现排序遍历，此时考虑key的自然排序和定制排序；底层使用红黑树
  - `Hashtable`：作为古老的实现类；线程安全的，效率低；不能存储null的key和value
    - `Properties`：常用来处理配置文件，key和value都是String类型
    
      ```java
      Properties pros = enw Properties();
      FileInputStream fis = new FileInputStream("jdbc.properties");
      pros.load(fis);
      
      String user = pros.getProperties("user");
      String pwd = pros.getProperties("password");

- `Map`结构理解

  - key：无序的、不可重复的；使用Set存储
    - key所在的类要重写`equals()`和`hashCode()`
  - value：无序的、可重复的；使用Collection存储
  - entry(key, value)：无序的、不可重复的；使用Set存储

- `HashMap`的底层实现原理（以jdk7.0为例）

  - `HashMap map = new HashMap();`

    - 在实例化以后，底层创建了长度是16的一维数组Entry[]

  - `map.put(key1,value1)`

    - 首先，计算key1所在类的`hashCode()`计算哈希值，此哈希值经过某种计算以后，得到在Entry数组中的存放位置；

    - 如果此位置上的数据为空，则此时key1-value1添加成功；
    - 如果此位置上的数据不为空（此位置上存放一个或链表形式的多个数据），比较key1和已经存在的数据的哈希值
      - 如果哈希值不相同，则entry添加成功
      - 如果存在哈希值相同，则继续调用key1所在类的`equals()`
        - 如果`equals()`返回false，则entry添加成功
        - 如果`equals()`返回true，则使用value1替换value2（修改功能）

  - 扩容问题：扩容2倍

    - `DEFAULT_INITIAL_CAPACITY`：HashMap的默认容量，16
    - `DEFAULT_LOAD_FACTOR`：HashMap的默认加载因子，0.75
    - `threshold`：扩容的临界值，16 * 0.75 = 12

  > 【jdk8中HashMap的底层实现方面的不同】
  >
  > - `new HashMap`：没有创建一个长度为16的数组
  > - 底层的数组时Node[]，而非Entry[]
  > - 首次调用put方法时，底层创建为16的数组
  > - 底层结构：数组+链表+红黑树
  >   - 当数组的某一个索引位置上的元素以链表形式存在的数据个数 > 8 且当前数组长度 > 64时，
  >     此时此索引位置上的所有数据改为使用红黑树存储（查找优化）
  >     - `TREE_THRESHOLD`：转化为红黑树的链表长度临界值，8
  >     - `MIN_TREE_CAPACITY`：Node树化的最小数组长度，64

- `Map`常用方法
  - `Object put(Object key, Object value)`
    - 添加键值对
  - `Object putAll(Map m)`
    - 添加m中所有键值对
  - `Object remove(Object key)`
    - 移除指定键的键值对，并返回相应值
  - `void clear()`
    - 清空
  - `Object get(Object key)`
    - 获取指定键的值
  - `boolean containsKey(Object key)`
    - 是否包含指定的key
  - `boolean containValue(Object value)`
    - 是否包含指定的value
  - `int size()`
    - 获取键值对个数
  - `boolean isEmpty()`
    - 判断是否为空
  - `boolean equals(Object obj)`
    - 判断是否相等
  - `Set keySet()`
    - 返回所有key构成的Set
  - `Collection values()`
    - 返回所有value构成的Collection
  - `Set entrySet()`
    - 返回所有键值对构成的Set
- `Properties`
  - 用于处理配置文件
  - `load()`



### 4.7 Collections工具类

- 可用于操作`Collection`，`Map`

- 常用方法

  - `reverse(List)`
  - `shuffle(List)`
  - `sort(List)`
  - `sort(List, Comparator)`
  - `swap(List, int, int)`

  - `Object max(Collection)`
  - `Object max(Collection, Comparator)`
  - `Object min(Collection)`
  - `Object min(Collection, Comparator)`
  - `int frequency(Collection, Object)`
  - `void copy(List dest, List src)`
  - `void repaceAll(List list, Object oldVal, Object newVal)`

- 同步控制

  - 提供了多个`synchronizedXxx()`方法，该方法可将指定集合包装成线程同步的集合，从而解决多线程并发访问集合时的线程安全问题





## 5 泛型



### 5.1 泛型动机

- 把元素的类型设计成一个参数，这个参数叫做泛型
- 使用Object问题
  - 类型不安全
  - 强转时，可能出现`ClassCastException`



### 5.2 在集合中使用泛型

- 集合接口或集合类在jdk5.0时都修改为带泛型的结构

- 在实例化集合类时，可以指明具体的泛型类型

- 指明完以后，在集合类或接口中凡是定义类或接口时，内部结构使用到类的泛型的位置，都指定为实例化的泛型类型

- 泛型的类型必须是类，不能是基本数据类型；需要用到基本数据类型的位置，拿包装类替换

- 如果实例化时，没有指明泛型的类型，默认类型为`Object`

- jdk7新特性：类型推断

  ```java
  TreeSet<Integer> set = new TreeSet<>();
  ```

  



### 5.3 自定义泛型结构

- 泛型类/泛型接口

  - 结构

    ```java
    public class Order<T> {
        //
    }
    ```

  - 泛型类可能有多个参数

  - 泛型不同的引用不能相互赋值

  - 尽管编译时`ArrayList<String>`和`ArrayList<Integer>`是两种类型，但运行时只有一个`ArrayList`类被加载到方法区

  - 在类/接口上声明的泛型，可以作为非静态属性的类型、非静态方法的参数类型、非静态方法的返回值类型；但静态方法中不能使用泛型

  - 异常类不能是泛型的

    - `catch(T t)`是错误的

  - 不能使用`new T[]`

    - `T[] arr = new T[10]`编译错误
    - `T[] arr = (T[]) new Object[20]`编译通过

  - 父类有泛型，子类可以选择指定泛型类型

    - 子类不保留父类的泛型

      - 没有类型，擦除

        ```java
        class Son extends Father{} //等价于<Object, Object>
        ```

      - 具体类型

        ```java
        class Son extends Father<Integer, String>{}
        ```

    - 子类保留父类的泛型

      - 全部保留

        ```java
        class Son<T1, T2> extends Father<T1, T2>{}
        ```

      - 部分保留

        ```java
        class Son<T2> extends Father<Integer, T2>{}

- 泛型方法

  - 在方法中，出现了泛型的结构，泛型参数与类的泛型参数没有任何关系

  - 泛型方法与所属类/接口是不是泛型的无关

  - 结构

    ```java
    public <T> List<T> myMethod(T[] arr){
        //
    }
    ```

  - 泛型方法可以是静态的；原因：泛型参数是在调用方法时确定的，并非在实例化类时确定



### 5.4 泛型在继承上的体现

- 类A是类B的子类，则`List<A>`和`List<B>`不具备子父类关系，二者是并列关系
- 类A是类B的子类，则`A<T>`是`B<T>`的子类



### 5.5 通配符的使用

- 通配符：`?`

- `List<?>`是`List<Object>`、`List<String>`……的公共父类

- 使用

  ```java
  List<String> list1 = null;
  LIst<Integer> list2 = null;
      
  List<?> list = null;
  
  list = list1;//编译通过
  list = list2;//编译通过
  
  ```

- 数据读取

  - 除了`null`之外，`LIst<?>`不能添加数据
  - `List<?>`允许读取数据，读取的数据类型为`Object`

- 有限制条件的通配符

  - `<? extends Person>`
    - `?`可以匹配`Person`的子类
    - $(-\infin,Person]$
  - `<? super Person>`
    - `?`可以匹配`Person`的父类
    - $[Person, +\infin)$





## 6 IO流



### 6.1 File类

- File类的一个对象，代表一个文件或一个文件目录

- File类在`java.io`包下

- 当硬盘中有一个真实的文件或目录存在时，创建File对象，各个属性会显式赋值；否则，创建对象除了指定的目录和路径之外，其他属性都是取默认值

- 常用构造器

  - `File(String pathname)`
    - pathname可以是绝对路径或相对路径
    - 若pathname是相对路径，相较于当前module
  - `File(String parent, String child)`
    - 以parent为父路径，child为子路径
  - `File(File parrent, String child)`
    - 根据一个父File对象和子文件路径

  > 【路径分隔符】
  >
  > - windows和DOS："\\"
  > - UNIX和URL："/"
  > - File类常量：separator
  >   - 根据操作系统，动态提供分隔符

- 常用方法

  - 获取功能
    - `String getAbsolutePath()`
      - 获取绝对路径
    - `String getPath()`
      - 获取路径
    - `String getName()`
      - 获取名称
    - `String getParent()`
      - 获取上层文件目录路径，若无，返回null
    - `long length()`
      - 获取文件长度
    - `long lastModified`
      - 获取最后一次修改时间（毫秒）
    - `String[] list()`
      - 获取指定目录下的所有文件或者文件目录的名称数组
    - `File[] listFiles()`
      - 获取指定目录下的所有文件或者文件目录的File数组
  - 重命名
    - `boolean renameTo(File dest)`
      - 把文件重命名为指定的文件路径
      - `boolean t = file1.renameTo(file2)`返回true条件：file1存在且file2不存在
  - 判断功能
    - `boolean isDirectory()`
      - 判断是否是文件目录
    - `boolean isFile()`
      - 判断是否是文件
    - `boolean exists()`
      - 判断是否存在
    - `boolean canRead()`
      - 判断是否可读
    - `boolean canWrite()`
      - 判断是否可写
    - `boolean isHidden()`
      - 判断是否隐藏
  - 创建功能
    - `boolean createNewFile()`
      - 创建文件
      - 若文件存在，则不创建，返回true
    - `boolean mkdir()`
      - 创建文件目录
      - 若文件目录存在，则不创建，返回false
      - 如果文件目录的上层目录不存在，则不创建
    - `boolean mkdirs()`
      - 创建文件目录
      - 如果上层文件目录不存在，则一并创建
  - 删除功能
    - `boolean delete()`
      - 删除文件或文件夹
      - java中的删除不走回收站
      - 要删除一个文件目录，请注意该文件目录内不能包含文件或者文件目录



​                         

### 6.2 IO流原理及流的分类

- IO用于处理设备之间的数据传输
- Java对于数据的输入输出以”流“的形式进行
- 流的分类
  - 根据数据单位的不同
    - 字节流（8bit
    - 字符流（16bit
  - 根据数据流流向不同
    - 输入流
    - 输出流
  - 根据流的角色不同
    - 节点流
    - 处理流
- IO流的体系结构
  - 抽象基类
    - `InputStream` 输入字节流
    - `OutputStream` 输出字节流
    - `Reader` 输入字符流
    - `Writer` 输出字符流
  - 节点流
    - `FileInputStream`
    - `FileOutputStream`
    - `FileReader`
    - `FileWriter`
  - 缓冲流
    - `BufferInputStream`
    - `BUfferOutputStream`
    - `BufferReader`
    - `BufferWriter`

​                           



### 6.3 节点流

- 字符读入

  - `FileReader`

  - 方法
    - `read()`
      - 返回读入的一个字符，如果达到文件末尾，返回-1
    - `read(char[] cbuf)`
      - 返回每次读入cbuf的字符个数，如果达到文件末尾，返回-1
  - 异常处理：为了保证流资源一定可以执行关闭操作，需要使用`try-catch-finally`结构
  - 读入的文件一定要存在，否则报`FileNotFoundException`

- 字符写出

  - `FileWriter`

  - 方法
    - `write()`
    - `write(char[] cbuf, int offset, int len)`
  - 输出对应的文件可以不存在
    - 如果不存在，会自动创建文件；
    - 如果存在
      - 如果流使用的构造器是`FileWriter(file, false)` 或 `FileWriter(file)`，则覆盖原有文件
      - 如果流使用的构造器是`FileWriter(file, true)`，则追加

- 示例：文本复制

  ```java
  FileReader fr = null;
  Filewriter fw = null;
  
  try{
      File srcFile = new File("hello.txt");
      File destFile = new File("hello1.txt");
  
  	fr = new FileReader(srcFile); //可能出现文件找不到有异常
      fw = new FileWriter(destFile);
  
  	char[] cbuf = new char[5];
      int len;
  	while((len = fr.read()) != -1){
      	fw.write(cbuf,0,len);
  	}
  }catch(IOException e){
      e.printStackTrace();
  }finally{
      
      try{
          if(fr != null){ //防止空指针异常
              fr.close();
          }
      }catch(IOException e){
          e.printStackTrace();
      }
      
      try{
          if(fw != null){ //防止空指针异常
              fw.close();
          }
      }catch(IOException e){
          e.printStackTrace();
      }
  }

- 字节读入

  - `FileInputStream`

  - `read()`
  - `read(byte[] buffer)`

- 字节写出

  - `FileOutputStream`

  - `read()`
  - `read(byte[] buffer, int offset, int len)`

- 示例：图片复制（带缓冲流）

  ```java
  BufferInputStream bis = null;
  BUfferOutputStream bos = null;
  
  try{
      File srcFile = new File("hello.jpg");
  	File srcFile = new File("hello1.jpg");
      
      //造节点流
  	FileInputStream fis = new FileInputStream(srcFile);
  	FileOutputStream fos = new FileOutputStream(destFile);
  
      //造缓冲流
  	bis = new BufferInputStream(fis);
  	bos = new BufferOutputStream(fos);
      
      byte[] buffer = new byte[1024];
      int len;
      while((len = bis.read(buffer)) != -1){
      	bos.write(buffer,0,len);
          
          bos.flush();//刷新缓冲区
  	}
  }catch(IOException e){
      e.printStackTrace();
  }finally{
      
      try{
          if(bis != null){ //防止空指针异常
              bis.close();
          }
      }catch(IOException e){
          e.printStackTrace();
      }
      
      try{
          if(bos != null){ //防止空指针异常
              bos.close();
          }
      }catch(IOException e){
          e.printStackTrace();
      }
  }
  
  //关闭外层流的同时，内层流也会自动地进行关闭。对于内层流的关闭，可以省略



### 6.4 缓冲流

- 属于处理流

- 提高文件写入、读取的速度

- 内部提供了一个缓冲区

- 字符读入

  - `BufferReader`

  - `read(char[] cbuf)` / `readline()`

- 字符写出

  - `BufferWriter`

  - `write(char[] cbuf, int offset, int len)`
  - `flush()` 刷新缓冲区

- 字节读入

  - `BufferInputStream`
  - `read(byte[] buffer)`

- 字节写出

  - `BufferOutputStream`
  - `write(byte[] buffer, int offset, int len)`
  - `flush() `刷新缓冲区

  



### 6.5 转换流

- 属于字符流

- 提供字节流和字符流之间的转换

- 两个转换流

  - `InputStreamReader`
    - 字节输入流 > 字符输入流
  - `OutputStreamWriter`
    - 字符输出流 > 字节输出流

- 构造器的第二个参数指明了字符集，具体使用哪个字符集，取决于读取文件保存时所使用的字符集

- 字符集

  - ASCII
    - 美国标准信息交换码
    - 用一个字节的7位表示
  - ISO8859-1
    - 拉丁码表，欧洲码表用一个字节的8位表示
  - GB2312
    - 中国的中文编码表
    - 最多两个字节
  - GBK
    - 中文编码表升级
    - 最多两个字节
  - Unicode
    - 国际标准码，目前人类使用的所有字符
    - 两个字节
  - UTF-8
    - Unicode变长编码方式
    - 1-4个字节

- 示例：将文件编码格式从utf-8转换为gbk

  ```java
  File file1 = new File("hello.txt");
  File file2 = new File("hello_gbk.txt");
  
  FileInputStream fis = new FileInputStream(file1);
  FileOutputStream fos = new FileOutputStream(file2);
  
  
  InputStreamReader isr = new InputStreamReader(fis, "utf-8");
  OutputStreamWriter osw = new OutputStreamWriter(fos, "gbk");
  
  char[] cbuf = new char[20];
  int len;
  while((len = isr.read(cbuf) != -1)){
      osw.write(cbuf, 0, len);
  }
  
  isr.close();
  osw.close();



### 6.6 标准输入、输出流

- `System.in`

  - 标准的输入流，默认从键盘输入

- `System.out`

  - 标准的输出流，默认从控制台输出

- 重新指定输入/输出设备

  - `SetIn(InputStream is)`

  - `SetOut(PrintStream ps)`

    > `PrintStream`是`OutputStream`的子类

​                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   



### 6.7 打印流

- 实现将基本数据类型的数据格式转化为字符串输出
- `PrintStream`和`PrintWriter`
- `print()`/`println()`



### 6.8 数据流

- 读取和写出基本数据类型和String的数据，持久化
- `DataInputStream`和`DataOutputStream`
- 分别套接在`InputStream`和`OutputStream`子类的流上
- 常用方法
  - `readChar`/`writeChar()`
  - `readByte()`/`writeByte`
  - . . .



### 6.9 对象流

- 用于存储和读取基本数据类型数据或对象的处理流，可以将Java中的对象写入到数据源中，也能把对象从数据源中还原回来

- `ObjectInputStream`和`ObjectOutputStream`

- 对象序列化机制

  - 序列化：把内存中的java对象转换成平台无关的二进制流，从而允许将这种二进制流持久地保存在磁盘上，或者通过网络将这种二进制流传输到另一个网络节点
  - 反序列化：当其他程序获取了二进制流，可以恢复成员来的Java对象
  - 为了让某个类是可序列化的，必须
    - 实现`Serializable`
    - 提供一个全局常量：`serialVersionUID`，用来对序列化对象进行版本控制
    - 除了当前类需要实现`Serilizable`接口之外，还必须保证其内部所有属性可序列化（默认基本数据类型是可序列化的）
  - 不能序列化`static`和`transient`的成员变量

- 序列化和反序列化的实现

  - 序列化：用`ObjectOutputStream`类保存基本数据类型或对象的机制

    ```java
    ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream("hello.data"));
    oos.writeObject(new String("hello, world!"));
    oos.flush();
    ```

  - 反序列化：用`ObjectInputStream`类读取基本类型数据或对象的机制

    ```java
    ObjectInputStream ois = new ObjectInputStream(new FileInputStream("hello.data"));
    Object obj = ois.readObject();
    String str = (String)obj;



### 6.10 随机存取文件流

- `RandomAccessFile`类

- 支持随机访问方式，可以直接跳到文件的任意位置读写文件

- 既可以作为输入流，也可以作为输出流

- 其对象包含一个记录指针，用以标记当前读写的位置

- 构造器

  - `RandomAccessFile(File file, String mode)`
  - `RandomAccessFile(String name, String mode)`

  > 【mode】
  >
  > - r：只读
  > - rw：读写
  > - rwd：读写；同步文件内容的更新
  > - rws：读写；同步文件内容和元数据的更新

- 方法

  - `read()`
  - `write()`
  - `long getFilePointer()`
    - 获取当前指针位置
  - `void seek(long pos)`
    - 将指针定位到pos位置







## 7 网络编程



### 7.1  网络编程概述

- 网络编程目的：直接或间接地通过网络协议与其他计算机实现数据交换，进行通讯
- 两个问题
  - 准确地定位网咯上一台或多台主机；定位主机上的具体应用
  - 可靠高效地进行数据传输





### 7.2 网络通信要素

- 要素
  - IP和端口号
  - 网络协议：TCP/IP模型



### 7.3 通信要素一：IP和端口号

- IP地址：唯一地标识Internet上的计算机
- 在Java中使用InetAddress类代表IP
- IP地址分类方式
  - 方式1
    - IPv4
      - 4Bytes
    - IPv6
      - 6Bytes
  - 方式2
    - 公网地址（万维网使用）
    - 私有地址（局域网使用）
      - 192.168开头
- 域名：`www.baidu.com`
  DNS：域名解析服务器
- 本地回路地址：127.0.0.1 对应localhost
- `InetAddress`
  - 实例化
    - `getByName(String host)`
    - `getLocalHost()` 获取本地IP
  - 两个常用方法
    - `getHostName()`
    - `getHostAddress()`

- 端口号：标识正在计算机上运行的进程（程序）
- 端口分类
  - 公认端口
    - 0-1023，被预先定义的服务通信占用
  - 注册端口
    - 1024-49151，分配给用户进程或应用程序
  - 动态/私有端口
    - 49152-65535
- 端口号与IP地址组合的出一个网络套接字：Socket



### 7.4 通信要素二：网络通信协议

- TCP和UDP
  - TCP协议
    - 传输前需建立TCP连接
    - “三次握手”，可靠的
    - 进行大数据量的传输
    - 传输完毕需释放已建立的连接
  - UDP
    - 将数据、源、目的封装成数据包，不需要建立连接
    - 不可靠
    - 结束时无需释放资源



### 7.5 TCP网络编程

- 客户端
  1. 创建Socket对象，指明服务器端的ip和端口号
  2. 获取一个输出流，用于输出数据
  3. 写出数据
  4. 关闭资源
- 服务端
  1. 创建ServerSocket对象，指明自己的端口号
  2. 调用`accpet()`表示接收来自于客户端的Socket
  3. 获取输入流
  4. 读取输入流中的数据
  5. 关闭资源

- 示例一

  ```java
  //客户端发送消息给服务端
  public void client(){
      
      InetAddress inet = null
          
      Socket socket = null
          
      try{
          
          os = InetAddress.getByName("127.0.0.1");
          socket = new Socket(inet, 8899);
          OutputStream os = socket.getOutputStream();
      	os.write("你好，我是客户端".getBytes());
      }catch(IOExeption e){
          e.printStackTrace();
      }finally{
          if(os != null){
              try{
                  os.close();
              }catch(IOException e){
                  e.printStackTrace();
              }
          }
          if(socket != null){
              try{
                  socket.close();
              }catch(IOException e){
                  e.printStackTrace();
              }
          }
        
      }
          
  }
  
  public void server(){
      
      ServerSocket ss = new ServerSOcket(8899);
      
      Socket socket = ss.accept();
      
      InputStream is = socket.getInputStream();
      
      ByteArrayOutputStream baos = new ByteArrayOutputStream();
      byte[] buffer = new byte[5];
      int len;
      while((len = is.read(buffer)) != -1){
          baos.write(buffer,0,len);
      }
      System.out.println(baos.toString());
      
      baos.close();
      is.close();
      socket.close();
      ss.close();
      
      //为方便，不try-catch
      
  }

- 示例二

  ```java
  //客户端发送文件给服务端，服务端保存文件并给予反馈
  public void client() throws IOException{
      Socket socket = new Socket(InetAddress.getByName("127.0.0.1"), 9090);
      
      OutputStream os = socket.getOutputStream();
      
      FileInputStream fls = new FileInputStream(new File("beauty.jpg"));
      
      byte[] buffer = new byte[1024];
      int len;
      while((len = fls.read(buffer)) != -1){
          os.write(buffer, 0, len);
      }
      socket.shutdownOutput();//告诉服务端数据传完了
      
      //接收来自于服务端的反馈
      InputStream is = socket.getInputStream();
      ByteArrayOutputStream baos = new ByteArrayOutputStream();
      byte[] buffer = new byte[20];
      int len1;
      while((len1 = is.read(buffer)) != -1){
          baos.write(buffer, 0, len1);
      }
      System.out.println(baos.toString());
      
      fls.close();
      os.close();
      socket.close();
      baos.close();
      os.close();
  }
  
  public void server() throws IOWException{
      ServerSocket ss = new ServerSocket(9090);
      
      Socket socket = ss.accpet();
      
      InputStream is = socket.getInputStream();
      
      FileOutputStream fos = new fileOutputStream(new File("beauty1.jpg"));
      
      byte[] buffer = new byte[1024];
      int len;
      while((len = is.read(buffer)) != -1){
         fos.write(buffer, 0, len);
      }
      
      
      //给予客户端反馈
      OutputStream os = socket.getOutputStream();
      os.write("I received that.".getBytes());
      
      fos.close();
      is.close();
      socket.close();
      ss.close();
  }





### 7.6 UDP网络编程

- 示例

  ```java
  public void sender() throws SocketException{
      DatagramSocket socket = new DatagramSocket();
      
      String str = "UDP sending message.";
      byte[] data = str.getBytes();
      InetAddress inet = InetAddress.getLocalHost();
      DatagramOacket packet = new DatagramPacket(data, 0, data.length);
      
      socket,send(packet);
      
      socket.close();
      
  }
  
  
  public void receiver() throws SocketException{
      DatagramSocket socket = new DatagramSocket(9090);
      
      byte[] buffer = new bute[100]
      DatagramPacket packet = new DatagramPacket(buffer, 0, buffer.length);
      
      socket.receive(packet);
      
      System.out.println(new String(packet.getData(), 0, packet.getLength()));
      
      socket.close();
      
  }



### 7.7 URL编程

- URL：统一资源定位符，表示Internet上某一资源的地址

- 基本结构

  - `<传输协议> ://<主机名>:<端口号>/<文件名/资源地址>#<片段名>?<参数列表>`
    - 片段名即锚点
    - 参数列表：`参数名=参数值&参数名=参数...`

- `URL`类

  - 实例化
    - `URL(String url)`

  - 建立连接

    ```java
    HttpURLConnection urlConnection = (HttpURLCOnnection) url.openConnection();
    urlConnection.connect();

  - 方法
    - `String getProtocol()`
      - 获取协议名
    - `String getHost()`
      - 获取端口号
    - `String getPath()`
      - 获取文件路径
    - `String getFile()`
      - 获取文件名
    - `String getQuery()`
      - 获取查询名





## 8 Java反射机制



### 8.1 反射机制概述

- 被视为动态语言的关键，反射机制允许程序在执行期间借助于反射API取得任何类的内部信息，并能直接操作任意对象的内部属性及方法

- 加载完类之后，在堆内存的方法区就产生了一个Class类型的对象（一个类只有一个Class对象）。这个对象包含了完整的类的结构信息，我们可以通过这个对象看到类的结构

- 反射相关的主要API

  - `java.lang.Class`
    - 类
  - `java.lang,reflect.Method`
    - 方法
  - `java.lang.reflect.Field`
    - 成员变量
  - `java.lang.reflect.Constructor`
    - 构造器

- 反射示例

  ```java
  Class clazz = Person.class;
  
  //1.通过反射，创建Person类的对象
  Constructor cons = clazz.getConstructor(String.class, int.class);
  Object obj = cons.newInstance("Tom", 12);
  Person p = (Person) obj;
  
  //2.通过反射，调用对象指定的属性、方法
  //调用属性
  Field age = clazz.getDeclaredField("age");
  age.set(p,10);
  System.out.prin;n(p.toString());
  //调用方法
  Method show = clazz.getDeclaredMethod("show");
  show.invoke(p);
  
  //通过反射，可以调用私有的结构
  Field name = clazz.getDeclaredField("name");
  name.setAccessible(true);
  name.set(p, "Hanmeimei");





### 8.2 Class类及获取Class实例

- `Class`类的理解

  - 类的加载过程：
    - 程序经过编译后，会生成一个或多个字节码文件（.class文件）。接着对某个字节码文件进行解释运行，相当于把某个字节码文件加载到内存中，此过程称为类的加载
    - 加载到内存中的类。称为运行时类，此运行时类，就作为Class的一个实例
  - Class的实例对应着一个运行时类
  - 加载到内存中的运行时类，会缓存一定时间，在此时间内，可以通过不同的方式获取此运行时类
  - 可以有Class对象的类型
    - class
    - interface
    - []
    - enum
    - annotation
    - 基本数据类型
    - void

- 获取Class实例的方式

  - 方式一：调用运行时类的属性

    - `Class clazz = Person.class`

  - 方式二：通过运行时类的对象

    - ```java
      Person p = new Person();
      Class clazz = p.getClass();
      ```

  - 方式三：调用Class的静态方法：`forName(String classPath)`

    - ```java
      Class clazz = Class.forName("com.oliver.Person");
      //classPath指定类的全类名
      ```

  - 方式四：使用类的加载器`ClassLoader`

    - ```java
      ClassLoader classLoader = ReflectionTest.class.getClassLoader();
      Class clazz = classLoader.loadClass("com.oliver.Person");
      ```

      





### 8.3 类的加载与ClassLoader

- 类的加载过程

  1. 类的加载
     - 将类的class文件读入内存，并为之创建一个java.lang.Class对象。此过程由类加载器完成
  2. 类的链接
     - 将类的二进制数据合并到JRE中
  3. 类的初始化
     - JVM负责对类初始化。执行类构造器`<clinit>()`方法

- 类加载器

  - 作用：把类装载进内存中

  - 三种

    - 系统类加载器：加载自定义类
    - 扩展类加载器
    - 引导类加载器：主要负责加载java的核心类库

  - 读取配置文件

    ```java
    Properties pros = new Properties();
    
    //配置文件默认识别为当前module的src下
    ClassLoader classLoader = ClassLoaderTest.class.getClassLoader();
    InputStream is = classLoader.getResourceAsStream("jdbc.properties");
    pros.load(is);
    
    String user = pros.getProperties("user");
    String password = pros.getProperties("password");
    ```

    





### 8.4 创建运行时类的对象

- `newInstance()`

  - 创建运行时类的方法
  - 内部调用了运行时类的空参构造器
    - 运行时类必须提供合适访问权限的空参构造器，通常设置为`public`

- 通过反射创建对应的运行时类的对象

  ```java
  Class clazz = Person.class;
  Object obj = class.newInstance();
  Person p = (Person)obj;
  ```

- 示例

  ```java
  public Object getInstance(String classPath) throws Exception{
      Class clazz = forName(classPath);
      return clazz.newInstance();
  }
  ```

  



### 8.5 调用运行时类的完整结构

- 获取属性结构
  - `getFields()`
    - 获取当前运行时类及其父类中声明为public的属性
  - `getDeclaredFields()`
    - 获取当前运行类自己定义的所有属性（不包含父类属性）
  - `getModifiers()`
    - 返回代表权限的数字
  - `getType()`
    - 返回数据类型（Class类型表示）
  - `getName()`
    - 返回变量名
- 获取方法结构
  - `getMethods()`
    - 获取当前运行时类及其父类中声明为public的方法
  - `getDeclaredMethods()`
    - 获取当前运行时类自己定义的所有方法
  - `getAnnotations`
    - 获取注解
  - `getModifiers()`
    - 获取权限修饰符
  - `getReturnType()`
    - 获取返回值类型
  - `getName()`
    - 获取方法名
  - `getParameterTypes()`
    - 获取形参列表
  - `getExceptionTypes()`
    - 获取抛出的异常
- 获取构造器结构
  - `getConstructors()`
    - 获取当前运行时类中声明为public的构造器
  - `getDeclaredConstructors()`
    - 获取当前运行时类中所有的构造器
- 获取运行时类的父类
  - `getSuperclass()`
    - 获取父类
  - `getGenericSuperclass()`
    - 获取带泛型的父类
  - `getgetActualTypeArguements()`
    - 获取带泛型的父类的泛型
- 获取实现的接口
  - `getInterfaces()`
    - 获取接口
- 获取运行时类所在的包
  - `getPackage()`
    - 获取运行时类所在包
- 获取注解
  - `getAnnotations()`
    - 获取运行时类声明的注解



### 8.6 调用运行时类的指定结构

- 操作运行时类的指定属性

  ```java
  //1.获取运行时类中指定变量名的属性
  Filed name = clazz.getDeclaredField("name");
  //2.保证属性可访问
  name.setAccessible(true);
  //3.设置、获取指定属性的值
  name.set(p,"Tom");
  name.get(p);
  ```

- 操作运行时类的指定方法

  ```java
  //1.获取运行时类中指定方法 getDeclaredMethod()需要指明名称和形参列表
  Method show = clazz.getDeclaredMethod("show", String.class);
  //2.保证指定方法可访问
  show.setAccessible(true);
  //3.调用指定方法 invoke()需要指明方法调用者和实参列表，返回值即为对应类中调用方法的返回值
  Object returnValue = show.invoke(p, "CHN");
  ```

- 操作运行时类的指定构造器

  ```java
  //1.获取指定构造器 getDeclaredConstructor()需要指明形参列表
  Constructor constructor = clazz.getDeclaredConstructor(String.class);
  //2.保证构造器可访问
  constructor.setAccessible(true);
  //3.调用此构造器创建运行时对象
  Person per = (Person)constructor.newInstance("Oliver");
  ```

  



### 8.7 反射的应用：动态代理

- 动态代理

  - 通过一个代理类完成全部的代理功能，代理不同的目标类
  - 客户通过代理类来调用其他对象的方法，并且是在运行时根据需要动态创建目标类的代理对象

- 示例

  ```java
  interface Huamn{
      String getBelief();
      
      void eat(String food);
  }
  
  //被代理类
  class SuperMan implements Human{
      
      @Override
      public String getBelief(){
          return "I believe I can fly.";
      }
      
      @Override
      public void eat(String food){
          System.out.println("I like eat " + food);
      }
  }
      
  //代理类
  class ProxyFactory{
      
      MyInvocationHandler s = new MyInvocationHandler();
      //调用此方法返回代理类的对象
      //即根据加载到内存中的被代理类，动态的创建一个代理类及对象
      public static Object getProxyInstance(Object obj){
          Proxy.newProxyInstance(obj.getClass().getClassLoader(), obj.getClass().getInterfaces(), s)
      }
  }
  
  class MyInvocationHandler implements InvocationHandler{
      
      private Object obj;//需要使用被代理类的对象进行赋值
      
      //当通过代理类的对象，调用方法a时，就会自动的调用invoke()
      //将被代理类要执行的方法a的功能声明在invoke中
      @Override
      public Object invoke(Object proxy, Method method, Object[] args)throws Throwable{
          
          //method：即为代理类对象调用的方法，此方法就作为了被代理类对象要调用的方法
          //obj:被代理类的对象
          Object returnValue = method.invoke(obj, args);
          //上述方法的返回值也就作为当前类invoke()的返回值
          return returnValue;
      }
  }
  
  public class ProxyTest{
      
      public static void main(String[] args){
          SuperMan superMan = new SuperMan();
      	Human ProxyInstance = (Human)ProxyFactory.getProxyInstance(superMan);
      	String belief = proxyInstance.getBelief();
      	proxyInstance.eat("章鱼小丸子");
      }
  }
  ```
  
  
