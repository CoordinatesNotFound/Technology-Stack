# MySQL

[TOC]



## MySQL基础



### 1 MySQL概述



#### 1.1 数据库相关概念

- 数据库DB：存储数据的仓库，数据是有组织的进行存储
- 数据库管理系统DBMS：操纵和管理数据库的大型软件
- SQL：操作关系型数据库的编程语言，定义了一套操作型关系数据库的统一标准



#### 1.2 MySQL数据库

- 启动：`net start mysql`
- 停止：`net stop mysql`
- 客户端连接：`mysql -u root -p`
  - 密码：123456
- 客户端退出：`exit`/`quit`
- 可视化工具
  - Sqlyog
  - Navicate
  - DataGrip







### 2 SQL



#### 2.1 SQL通用语法

- 单行或多行书写，分号结尾
- 不区分大小写，关键字建议大写
- 空格或缩进增强可读性
- 注释
  - 单行注释：`--注释内容`/`#注释内容`
  - 多行注释：`/*注释内容*/`



#### 2.2 SQL分类

- DDL：数据定义语言
- DML：数据操作语言
- DQL：数据查询语言
- DCL：数据控制语言



#### 2.3 DDL

- 数据库操作

  - 查询

    - 查询所有数据库

      ```mysql
      SHOW DATABASE;
      ```

    - 查询当前数据库

      ```mysql
      SELECT DATABASE();
      ```

  - 创建

    ```mysql
    CREATE DATABASE [IF NOT EXISTS] 数据库名 [DEFAULT CHARSET 字符集] [COLLATE 排序规则];
    ```

  - 删除

    ```mysql
    DROP DATABASE [IF EXISTS] 数据库名;
    ```

  - 使用

    ```mysql
    USE 数据库名;
    ```

- 表操作

  - 查询

    - 查询当前数据库所有表

      ```mysql
      SHOW TABLES
      ```

    - 查询表结构

      ```mysql
      DESC 表名;
      ```

    - 查询指定表的建表语句

      ```mysql
      SHOW CREATE TABLE 表名;
      ```

  - 创建

    ```mysql
    CREATE TABLE 表名(
        字段1 字段1类型 [COMMENT '注释'],
        字段2 字段2类型 [COMMENT '注释'],
        ...
    )[COMMENT '注释'];
    ```

  - 数据类型

    - 数值类型

      - INT

    - 字符串类型

      - CHAR：定长字符串
      - VARCHAR：变长字符串

      > 【char(10)和varchar(10)的区别】
      >
      > - 比如存储一个"a"，前者以空格补齐，仍占用10字符空间；后者只占用1字符空间
      > - 前者性能高，后者性能较差；原因是varchar需要根据字符长度计算空间
      >   - 用户名 varchar(10)
      >   - 性别 char(1) //英文字符和汉字字符都只占用一个字符

    - 日期类型

      - DATE：日期 YYYY-MM-DD
      - TIME：时间 HH:MM:SS
      - YEAR：年份 YYYY
      - DATETIME：日期时间 YYYY-MM-DD HH:MM:SS
      - TIMESTAMP：时间戳 YYYY-MM-DD HH:MM:SS

  - 修改

    - 添加字段

      ```mysql
      ALTER TABLE 表名 ADD 字段名 类型(长度) [COMMENT 注释] [约束];
      ```

    - 修改数据类型

      ```mysql
      ALTER TABLE 表明 MODIFY 字段名 新数据类型(长度);
      ```

    - 修改字段名和字段类型

      ```mysql
      ALTER TABLE 表名 CHANGE 旧字段名 新字段名 类型(长度) [COMMENT 注释] [约束];
      ```

    - 删除字段

      ```mysql
      ALTER TABLE 表名 DROP 字段名;
      ```

    - 修改表名

      ```mysql
      ALTER TABLE 表名 RENAME TO 新表名;
      ```

  - 删除

    - 删除表

      ```mysql
      DROP TABLE [IF EXSITS] 表名;
      ```

    - 删除指定表，并重新创建该表（保留表结构，删除数据）

      ```mysql
      TRUNCATE TABLE 表名;
      ```

      



#### 2.4 DML

- 添加数据

  - 给指定字段数据添加数据
    ```mysql
    INSERT INTO 表名(字段名1,字段名2,...) VALUES(值1,值2,...);
    ```

  - 给全部字段添加数据
    ```mysql
    INSERT INTO 表名 VALUES(值1,值2,...);
    ```

  - 批量添加数据
    ```mysql
    INSERT INTO 表名 (字段名1, 字段名2,...) VALUES(值1,值2,...),(值1,值2,...);
    ```

    ```mysql
    INSERT INTO 表名 VALUES(值1,值2,...),(值1,值2,...);
    ```

- 修改数据

  ```mysql
  UPDATE 表名 SET 字段名1=值1, 字段名2=值2,...[WHERE 条件];
  ```

- 删除数据
  ```mysql
  DELETE FROM 表名 [WHERE 条件];
  ```

  



#### 2.5 DQL

- 查询语法
  ```mysql
  SELECT
  	字段列表
  FROM
  	表名列表
  WHERE
  	条件列表
  GROUP BY
  	分组字段列表
  HAVING
  	分组后条件列表
  ORDER BY
  	排序字段列表
  LIMIT
  	分页参数
  ```

- 基本查询

  - 查询多个字段
    ```mysql
    SELECT 字段1,字段2,... FROM 表名;
    ```

    ```mysql
    SELECT * FROM 表名;
    ```

  - 设置别名
    ```mysql
    SELECT 字段1 [AS 别名1], 字段2 [AS 别名2] ... 表名;
    ```

  - 去除重复操作
    ```mysql
    SELECT DISTINCT 字段列表 FROM 表名;
    ```

- 条件查询

  - 语法
    ```mysql
    SELECT 字段列表 FROM 表名 WHERE 条件列表;
    ```

  - 条件

    - 比较运算符
      <img src="C:/Users/Oliver/AppData/Roaming/Typora/typora-user-images/image-20220925184308438.png" alt="image-20220925184308438" style="zoom:67%;" />
    - 逻辑运算符
      <img src="C:/Users/Oliver/AppData/Roaming/Typora/typora-user-images/image-20220925184330039.png" alt="image-20220925184330039" style="zoom:67%;" />

- 聚合函数

  - 将一列数据作为整体进行纵向计算

  - 常见聚合函数
    <img src="C:/Users/Oliver/AppData/Roaming/Typora/typora-user-images/image-20220925184847666.png" alt="image-20220925184847666" style="zoom:67%;" />

  - 语法
    ```mysql
    SELECT 聚合函数(字段列表) FROM 表名 ;
    ```

- 分组查询

  - 语法
    ```mysql
    SELECT 字段列表 FROM 表名 [ WHERE 条件 ] GROUP BY 分组字段名 [ HAVING 分组 后过滤条件 ];
    ```

  -  where与having区别

    - 执行时机不同：where是分组之前进行过滤，不满足where条件，不参与分组；而having是分组之后对结果进行过滤。

    - 判断条件不同：where不能对聚合函数进行判断，而having可以。

  - 注意

    - 分组之后，查询的字段一般为聚合函数和分组字段，查询其他字段无任何意义。
    - 执行顺序: where > 聚合函数 > having 。
    - 支持多字段分组, 具体语法为 : group by columnA,column

- 排序查询

  - 语法
    ```mysql
    SELECT 字段列表 FROM 表名 ORDER BY 字段1 排序方式1 , 字段2 排序方式2 ; 
    ```

  - 排序方式

    - ASC : 升序(默认值)
    - DESC: 降序

  - 注意

    - 如果是多字段排序，当第一个字段值相同时，才会根据第二个字段进行排序 ;

- 分页查询

  - 语法
    ```mysql
    SELECT 字段列表 FROM 表名 LIMIT 起始索引, 查询记录数 ;
    ```

  - 注意事项

    - 起始索引从0开始，起始索引 = （查询页码 - 1）* 每页显示记录数。
    - 分页查询是数据库的方言，不同的数据库有不同的实现，MySQL中是LIMIT。
    - 如果查询的是第一页数据，起始索引可以省略，直接简写为 limit 10

  



#### 2.6 DCL

- 管理用户

  - 查询用户
    ```mysql
    select * from mysql.user;
    ```

  - 创建用户
    ```mysql
    CREATE USER '用户名'@'主机名' IDENTIFIED BY '密码';
    ```

  - 修改用户密码
    ```mysql
    ALTER USER '用户名'@'主机名' IDENTIFIED WITH mysql_native_password BY '新密码' ;
    ```

  - 删除用户
    ```mysql
    DROP USER '用户名'@'主机名' ;
    ```

  - 注意

    - 在MySQL中需要通过用户名@主机名的方式，来唯一标识一个用户。 
    - 主机名可以使用 % 通配。
    - 这类SQL开发人员操作的比较少，主要是DBA（ Database Administrator 数据库管理员）使用

- 权限控制

  - 权限
    <img src="C:/Users/Oliver/AppData/Roaming/Typora/typora-user-images/image-20220925191532954.png" alt="image-20220925191532954" style="zoom:67%;" />

  - 查询权限
    ```mysql
    SHOW GRANTS FOR '用户名'@'主机名' ;
    ```

  - 授予权限
    ```mysql
    GRANT 权限列表 ON 数据库名.表名 TO '用户名'@'主机名';
    ```

  - 撤销权限
    ```mysql
    REVOKE 权限列表 ON 数据库名.表名 FROM '用户名'@'主机名';
    ```

  - 注意

    - 多个权限之间，使用逗号分隔
    - 授权时， 数据库名和表名可以使用 * 进行通配，代表所有。





### 3 函数



#### 3.1 字符串函数

<img src="C:/Users/Oliver/AppData/Roaming/Typora/typora-user-images/image-20220925191829046.png" alt="image-20220925191829046" style="zoom:67%;" />



#### 3.2 数值函数

<img src="C:/Users/Oliver/AppData/Roaming/Typora/typora-user-images/image-20220925191859893.png" alt="image-20220925191859893" style="zoom:67%;" />

#### 3.3 日期函数

<img src="C:/Users/Oliver/AppData/Roaming/Typora/typora-user-images/image-20220925191939428.png" alt="image-20220925191939428" style="zoom:67%;" />

#### 3.4 流程函数

<img src="C:/Users/Oliver/AppData/Roaming/Typora/typora-user-images/image-20220925192011341.png" alt="image-20220925192011341" style="zoom:67%;" />



### 4 约束



#### 4.1 概述

- 概念：约束是作用于表中字段上的规则，用于限制存储在表中的数据。
- 目的：保证数据库中数据的正确、有效性和完整性。
- 分类:
  <img src="C:/Users/Oliver/AppData/Roaming/Typora/typora-user-images/image-20220925192108374.png" alt="image-20220925192108374" style="zoom:67%;" />



#### 4.2 外键约束

- 外键：用来让两张表的数据之间建立连接，从而保证数据的一致性和完整性。

  > 【外键缺陷】
  >
  > - 增加开发难度
  > - 降低性能
  >
  > 【外键替代】
  >
  > - 触发器
  > - 应用程序

- 添加外键
  ```mysql
  ALTER TABLE 表名 ADD CONSTRAINT 外键名称 FOREIGN KEY (外键字段名) REFERENCES 主表 (主表列名) ;
  ```

- 删除外键
  ```mysql
  ALTER TABLE 表名 DROP FOREIGN KEY 外键名称;
  ```

- 删除/更新行为

  - 添加了外键之后，再删除父表数据时产生的约束行为，我们就称为删除/更新行为。具体的删除/更新行为

  - 有以下几种:
    <img src="C:/Users/Oliver/AppData/Roaming/Typora/typora-user-images/image-20220925192627932.png" alt="image-20220925192627932" style="zoom:67%;" />

  - 语法
    ```mysql
    ALTER TABLE 表名 ADD CONSTRAINT 外键名称 FOREIGN KEY (外键字段) REFERENCES 主表名 (主表字段名) ON UPDATE CASCADE ON DELETE CASCADE;
    ```

    





### 5 多表查询



#### 5.1 多表关系

- 项目开发中，在进行数据库表结构设计时，会根据业务需求及业务模块之间的关系，分析并设计表结构，由于业务之间相互关联，所以各个表结构之间也存在着各种联系，基本上分为三种：
  - 一对多(多对一)
    - 实现: 在多的一方建立外键，指向一的一方的主键
  - 多对多
    - 实现: 建立第三张中间表，中间表至少包含两个外键，分别关联两方主键
  - 一对一
    - 实现: 在任意一方加入外键，关联另外一方的主键，并且设置外键为唯一的(UNIQUE)



#### 5.2 概述

- 多表查询就是指从多张表中查询数据。
- 语法：需要使用逗号分隔多张表
- 分类
  - 连接查询
    - 内连接：相当于查询A、B交集部分数据
    - 外连接：
      - 左外连接：查询左表所有数据，以及两张表交集部分数据
      - 右外连接：查询右表所有数据，以及两张表交集部分数据
    - 自连接：当前表与自身的连接查询，自连接必须使用表别名
  - 子查询



#### 5.3 连接查询

- 内连接

  - 内连接求交集

  - 隐式内连接

    ```mysql
    SELECT 字段列表 FROM 表1 , 表2 WHERE 条件 ... ;
    ```

  - 显式内连接

    ```mysql
    SELECT 字段列表 FROM 表1 [ INNER ] JOIN 表2 ON 连接条件 ... ;
    ```

- 外连接

  - 左外连接

    ```mysql
    SELECT 字段列表 FROM 表1 LEFT [ OUTER ] JOIN 表2 ON 条件 ... ;
    ```

  - 右外连接

    ```mysql
    SELECT 字段列表 FROM 表1 RIGHT [ OUTER ] JOIN 表2 ON 条件 ... ;
    ```

  > 外连接可以将另一张表为null的值也查出来

- 自连接

  - 语法

    ```mysql
    SELECT 字段列表 FROM 表A 别名A JOIN 表A 别名B ON 条件 ... ;
    ```

  - 自连接既可以是内连接也可以是外连接

- 联合查询

  - 把多次查询的结果合并起来，形成一个新的查询结果集。

  - 语法

    ```mysql
    SELECT 字段列表 FROM 表A ... UNION [ ALL ] SELECT 字段列表 FROM 表B ....;
    ```

  - 对于联合查询的多张表的列数必须保持一致，字段类型也需要保持一致。

  - union all 会将全部的数据直接合并在一起，union 会对合并之后的数据去重。



#### 5.4 子查询

- 概述

  -  SQL语句中嵌套SELECT语句，称为嵌套查询，又称子查询。
    ```mysql
    SELECT * FROM t1 WHERE column1 = ( SELECT column1 FROM t2 );
    ```

  - 子查询外部的语句可以是INSERT / UPDATE / DELETE / SELECT 的任何一个。

- 分类

  - 根据查询结果
    - 标量子查询（子查询结果为单个值）
    - 列子查询(子查询结果为一列)
    - 行子查询(子查询结果为一行)
    - 表子查询(子查询结果为多行多列)
  - 根据子查询位置
    - WHERE之后
    - FROM之后
    - SELECT之后







### 6 事务



#### 6.1 概述

- 事务 是一组操作的集合，它是一个不可分割的工作单位，事务会把所有的操作作为一个整体一起向系
  统提交或撤销操作请求，即这些操作要么同时成功，要么同时失败。



#### 6.2 事务操作

- 查看/设置事务提交方式
  ```mysql
  SELECT @@autocommit ; 
  SET @@autocommit = 0 ; # 设置为手动提交
  ```

- 提交事务
  ```mysql
  COMMIT;
  ```

- 回滚事务
  ```mysql
  ROLLBACK;
  ```

- 开启事务
  ```mysql
  START TRANSACTION 或 BEGIN ;
  ```





#### 6.3 事务四大特性：ACID

- 原子性（Atomicity）：事务是不可分割的最小操作单元，要么全部成功，要么全部失败。
- 一致性（Consistency）：事务完成时，必须使所有的数据都保持一致状态。
- 隔离性（Isolation）：数据库系统提供的隔离机制，保证事务在不受外部并发操作影响的独立环境下运行。
- 持久性（Durability）：事务一旦提交或回滚，它对数据库中的数据的改变就是永久的。



#### 6.4 并发事务问题

-  赃读：一个事务读到另外一个事务还没有提交的数据。
  <img src="C:/Users/Oliver/AppData/Roaming/Typora/typora-user-images/image-20220925201316731.png" alt="image-20220925201316731" style="zoom:67%;" />
-  不可重复读：一个事务先后读取同一条记录，但两次读取的数据不同，称之为不可重复读。
  <img src="C:/Users/Oliver/AppData/Roaming/Typora/typora-user-images/image-20220925201348260.png" alt="image-20220925201348260" style="zoom:67%;" />
- 幻读：一个事务按照条件查询数据时，没有对应的数据行，但是在插入数据时，又发现这行数据已经存在，好像出现了 "幻影"。
  <img src="C:/Users/Oliver/AppData/Roaming/Typora/typora-user-images/image-20220925201425326.png" alt="image-20220925201425326" style="zoom:67%;" />



#### 6.5 事务隔离级别

- 事务隔离级别
  <img src="C:/Users/Oliver/AppData/Roaming/Typora/typora-user-images/image-20220925201613092.png" alt="image-20220925201613092" style="zoom:67%;" />

-  查看事务隔离级别
  ```mysql
  SELECT @@TRANSACTION_ISOLATION;
  ```

- 设置事务隔离级别
  ```mysql
  SET [ SESSION | GLOBAL ] TRANSACTION ISOLATION LEVEL { READ UNCOMMITTED | READ COMMITTED | REPEATABLE READ | SERIALIZABLE }
  ```

> 事务隔离级别越高，数据越安全，但是性能越低。







## MySQL进阶



### 7 存储引擎



#### 7.1 MySQL体系结构

<img src="C:/Users/Oliver/AppData/Roaming/Typora/typora-user-images/image-20220926183721828.png" alt="image-20220926183721828" style="zoom:80%;" />

- 连接层
- 服务层
- 引擎层
- 存储层



#### 7.2 存储引擎概述

- 存储引擎就是存储数据、建立索引、更新/查询数据等技术的实现方式 。存储引擎是基于表的，而不是基于库的，所以存储引擎也可被称为表类型。

- 建表时指定存储引擎
  ```mysql
  CREATE TABLE 表名( 
      字段1 字段1类型 [ COMMENT 字段1注释 ] , 
      ...... 
      字段n 字段n类型 [COMMENT 字段n注释 ] 
  ) ENGINE = INNODB [ COMMENT 表注释 ] ; 12345
  ```

- 查询当前数据库支持的存储引擎
  ```mysql
  show engines;
  ```

  



#### 7.3 存储引擎特点

- InnoDB
  - InnoDB是一种兼顾高可靠性和高性能的通用存储引擎，在 MySQL 5.5 之后，InnoDB是默认的MySQL 存储引擎。
  -  特点
    - DML操作遵循ACID模型，支持事务；
    - 行级锁，提高并发访问性能；
    - 支持外键FOREIGN KEY约束，保证数据的完整性和正确性；
  - 文件
    - xxx.ibd：xxx代表的是表名，innoDB引擎的每张表都会对应这样一个表空间文件，存储该表的表结构（frm-早期的 、sdi-新版的）、数据和索引。
    - 参数：innodb_file_per_table
      - 如果该参数开启，代表对于InnoDB引擎的表，每一张表都对应一个ibd文件。 我们直接打开MySQL的数据存放目录： C:\ProgramData\MySQL\MySQL Server 8.0\Data ， 这个目录下有很多文件夹，不同的文件夹代表不同的数据库，我们直接打开itcast文件夹。
  - 逻辑存储结构
    - 表空间 : InnoDB存储引擎逻辑结构的最高层，ibd文件其实就是表空间文件，在表空间中可以包含多个Segment段。
    - 段 : 表空间是由各个段组成的， 常见的段有数据段、索引段、回滚段等。InnoDB中对于段的管理，都是引擎自身完成，不需要人为对其控制，一个段中包含多个区。
    - 区 : 区是表空间的单元结构，每个区的大小为1M。 默认情况下， InnoDB存储引擎页大小为16K， 即**一个区中一共有64个连续的页**。
    - 页 : 页是组成区的最小单元，**页也是InnoDB 存储引擎磁盘管理的最小单元**，每个页的大小默认为 16KB。为了保证页的连续性，InnoDB 存储引擎每次从磁盘申请 4-5 个区。
    - 行 : InnoDB 存储引擎是面向行的，也就是说数据是按行进行存放的，在每一行中除了定义表时所指定的字段以外，还包含两个隐藏字段(后面会详细介绍)
- MyISAM
  - MyISAM是MySQL早期的默认存储引擎。
  - 特点
    - 不支持事务，不支持外键
    - 支持表锁，不支持行锁
    - 访问速度快
  -  文件
    - xxx.sdi：存储表结构信息
    - xxx.MYD: 存储数据
    - xxx.MYI: 存储索引

- Memory
  - Memory引擎的表数据时存储在内存中的，由于受到硬件问题、或断电问题的影响，只能将这些表作为临时表或缓存使用。
  - 特点
    - 内存存放
    - hash索引（默认）
  - 文件
    - xxx.sdi：存储表结构信息

> 【InnoDB和MyISAM的区别】
>
> - InnoDB引擎, 支持事务, 而MyISAM不支持。
> - InnoDB引擎, 支持行锁和表锁, 而MyISAM仅支持表锁, 不支持行锁。
> - InnoDB引擎, 支持外键, 而MyISAM是不支持的



#### 7.4 存储引擎选择

- InnoDB: 是Mysql的默认存储引擎，支持事务、外键。如果应用对事务的完整性有比较高的要求，在并发条件下要求数据的一致性，数据操作除了插入和查询之外，还包含很多的更新、删除操作，那么InnoDB存储引擎是比较合适的选择。
- MyISAM ： 如果应用是以读操作和插入操作为主，只有很少的更新和删除操作，并且对事务的完整性、并发性要求不是很高，那么选择这个存储引擎是非常合适的。
- MEMORY：将所有数据保存在内存中，访问速度快，通常用于临时表及缓存。MEMORY的缺陷就是对表的大小有限制，太大的表无法缓存在内存中，而且无法保障数据的安全性。





### 8 索引



#### 8.1 索引概述

- 索引（index）
  - 是帮助MySQL高效获取数据的数据结构(有序)。在数据之外，数据库系统还维护着满足特定查找算法的数据结构，这些数据结构以某种方式引用（指向）数据， 这样就可以在这些数据结构上实现高级查找算法，这种数据结构就是索引。
- 特点
  - 优点
    - 提高数据检索的效率，降低数据库的IO成本
    - 通过索引列对数据进行排序，降低数据排序的成本，降低CPU的消耗
  - 缺点
    - 索引列也是要占用空间的。
    - 索引大大提高了查询效率，同时却也降低更新表的速度，如对表进行INSERT、UPDATE、DELETE时，效率降低。



#### 8.2 索引结构

- 结构
  - **B+Tree索引** 
    - 最常见的索引类型，大部分引擎都支持 B+ 树索引
  - Hash索引
    - 底层数据结构是用哈希表实现的, 只有精确匹配索引列的查询才有效, 不支持范围查询
  - R-tree(空间索引）
    - 空间索引是MyISAM引擎的一个特殊索引类型，主要用于地理空间数据类型，通常使用较少
  - Full-text(全文索引)
    - 是一种通过建立倒排索引,快速匹配文档的方式。类似于Lucene,Solr,ES

> - 二叉树：顺序插入时会形成列表，层级深，检索速度慢
> - 红黑树：自平衡二叉树，仍为二叉树
> - B树：多路平衡查找树。N阶的B树每个节点最多存储N-1个key，有N个指针。裂变方式为：中间结点向上裂变

- B+树索引
  - B+树和B树的区别是，所有数据只存储在叶子节点，非叶子节点只起到索引的作用。
  - 叶子节点形成单向链表
    <img src="C:/Users/Oliver/AppData/Roaming/Typora/typora-user-images/image-20220926191123024.png" alt="image-20220926191123024" style="zoom:70%;" />

> 【为什么InnoDB存储引擎采用B+树】
>
> - 相对于二叉树，层级更少，检索效率更高
> - 对于B树，无论是叶子节点还是非叶子节点都会保存数据，导致一页中存储的键值减少，指针跟着减少，要保存大量数据，只能增加树的高度，导致性能降低
> - 相对于Hash，B+树支持范围匹配和排序操作

- Hash索引
  - 哈希索引就是采用一定的hash算法，将键值换算成新的hash值，映射到对应的槽位上，然后存储在hash表中。
  - 如果两个(或多个)键值，映射到一个相同的槽位上，他们就产生了hash冲突（也称为hash碰撞），可以通过链表来解决。
  -  特点
    - Hash索引只能用于对等比较(=，in)，不支持范围查询（between，>，< ，...）
    - 无法利用索引完成排序操作
    - 查询效率高，通常(不存在hash冲突的情况)只需要一次检索就可以了，效率通常要高于B+tree索 引
  - 存储引擎支持
    - 在MySQL中，支持hash索引的是Memory存储引擎。 而InnoDB中具有自适应hash功能，hash索引是InnoDB存储引擎根据B+Tree索引在指定条件下自动构建的。



#### 8.3 索引分类

- 主要分类

  | 分类     | 含义                                                 | 特点                       | 关键字   |
  | -------- | ---------------------------------------------------- | -------------------------- | -------- |
  | 主键索引 | 针对于表中主键创建的索引                             | 默认自动创建，且只能有一个 | PRIMARY  |
  | 唯一索引 | 避免同一个表中某数据列中的值重复                     | 可以有多个                 | UNIQUE   |
  | 常规索引 | 快速定位特定数据                                     | 可以有多个                 |          |
  | 全文索引 | 全文索引查找的是文本中的关键词，而不是比较索引中的值 | 可以有多个                 | FULLTEXT |

- InnoDB中分类

  | 分类                   | 含义                                                       | 特点                 |
  | ---------------------- | ---------------------------------------------------------- | -------------------- |
  | 聚集索引               | 将数据存储与索引放到一块，索引结构的叶子节点保存了行数据   | 必须有，且只能有一个 |
  | 二级索引（非聚集索引） | 将数据与索引分开存储，索引结构的叶子节点关联的是对应的主键 | 可以存在多个         |

  - 聚集索引选取规则：
    - 如果存在主键，则主键索引就是聚集索引
    - 如果不存在主键，则使用第一个唯一索引作为聚集索引
    - 如果没有主键和唯一索引，则自动生成一个rowid作为隐藏的聚集索引
  - 具体结构<img src="C:/Users/Oliver/AppData/Roaming/Typora/typora-user-images/image-20221003150537533.png" alt="image-20221003150537533" style="zoom:67%;" />

  - 回表查询：
    - 这种先到二级索引中查找数据，找到主键值，然后再到聚集索引中根据主键值，获取数据的方式，就称之为回表查询。



#### 8.4 索引语法

- 创建索引
  ```mysql
  CREATE [ UNIQUE | FULLTEXT ] INDEX index_name ON table_name ( index_col_name,... ) ;
  ```

  - 一个索引可以关联多个字段
    - 单列索引
    - 联合索引/组合索引

- 查看索引
  ```mysql
  SHOW INDEX FROM table_name ;
  ```

- 删除索引
  ```mysql
  DROP INDEX index_name ON table_name ;
  ```



#### 8.5 SQL性能分析

- SQL执行频率

  - MySQL 客户端连接成功后，通过 show [session|global] status 命令可以提供服务器状态信息。通过如下指令，可以查看当前数据库的INSERT、UPDATE、DELETE、SELECT的访问频次：
    ```mysql
    -- session 是查看当前会话 ; 
    -- global 是查询全局数据 ; 
    SHOW GLOBAL STATUS LIKE 'Com_______';
    ```

    - Com_delete: 删除次数
    - Com_insert: 插入次数
    - Com_select: 查询次数
    - Com_update: 更新次数

  - 通过上述指令，我们可以查看到当前数据库到底是以查询为主，还是以增删改为主，从而为数据库优化提供参考依据。 如果是以增删改为主，我们可以考虑不对其进行索引的优化。 **如果是以查询为主，那么就要考虑对数据库的索引进行优化了**。

- 慢查询日志

  - 慢查询日志记录了所有执行时间超过指定参数（long_query_time，单位：秒，默认10秒）的所有SQL语句的日志。

  - MySQL的慢查询日志默认没有开启，我们可以查看一下系统变量 slow_query_log
    ```mysql 
    show variables like 'slow_query_log';
    ```

  - 如果要开启慢查询日志，需要在MySQL的配置文件（/etc/my.cnf）中配置如下信息：
    ```cnf
    # 开启MySQL慢日志查询开关 
    slow_query_log=1 
    # 设置慢日志的时间为2秒，SQL语句执行时间超过2秒，就会视为慢查询，记录慢查询日志 
    long_query_time=2
    ```

  - 配置完毕之后，通过以下指令重新启动MySQL服务器进行测试，查看慢日志文件中记录的信息**/var/lib/mysql/localhost-slow.log**
    ```cmd
    systemctl restart mysqld
    ```

  - 然后，再次查看开关情况，慢查询日志就已经打开了。
  
  - 在慢查询日志中，只会记录执行时间超多我们预设时间（2s）的SQL，执行较快的SQL是不会记录的。通过慢查询日志，就可以定位出执行效率比较低的SQL，从而有针对性的进行优化
  
- profile详情

  - show profiles 能够在做SQL优化时帮助我们了解时间都耗费到哪里去了。通过have_profiling参数，能够看到当前MySQL是否支持profile操作：
    ```mysql
    SELECT @@have_profiling ;
    ```

  - 可以通过set语句在session/global级别开启profiling：
    ```mysql
    SET profiling = 1;
    ```

  - 查看指令耗时
    ```mysql
    -- 查看每一条SQL的耗时基本情况 
    show profiles; 
    -- 查看指定query_id的SQL语句各个阶段的耗时情况 
    show profile for query query_id; 
    -- 查看指定query_id的SQL语句CPU的使用情况 
    show profile cpu for query query_id;
    ```

- explain执行计划

  - EXPLAIN 或者 DESC命令获取 MySQL 如何执行 SELECT 语句的信息，包括在 SELECT 语句执行过程中表如何连接和连接的顺序
  - Explain 执行计划中各个字段的含义：
    <img src="C:\Users\Oliver\AppData\Roaming\Typora\typora-user-images\image-20221003153840733.png" alt="image-20221003153840733" style="zoom:67%;" />



#### 8.6 索引使用

- 最左前缀法则
  - 如果索引了多列（联合索引），要遵守最左前缀法则。最左前缀法则指的是查询从索引的最左列开始，并且不跳过索引中的列。如果跳跃某一列，索引将会部分失效(后面的字段索引失效)。
  - 最左前缀法则中指的最左边的列，是指在查询时，联合索引的最左边的字段(即是第一个字段)必须存在，与我们编写SQL时，条件编写的先后顺序无关。
- 范围查询
  - 联合索引中，出现范围查询(>,<)，范围查询右侧的列索引失效。
  - 所以，在业务允许的情况下，尽可能的使用类似于 >= 或 <= 这类的范围查询，而避免使用 > 或 <
- 索引失效情况
  - 索引列运算
    - 不要在索引列上进行运算操作， 索引将失效
  - 字符串不加引号
    - 字符串类型字段使用时，不加引号，索引将失效。
    - 如果字符串不加单引号，对于查询结果，没什么影响，但是数据库存在隐式类型转换，索引将失效。
  - 模糊查询
    - 如果仅仅是尾部模糊匹配，索引不会失效。如果是头部模糊匹配，索引失效。
    - 即"%xxx"索引失效
  - or连接条件
    - 用or分割开的条件， 如果or前的条件中的列有索引，而后面的列中没有索引，那么涉及的索引都不会被用到。
    - 当or连接的条件，左右两侧字段都有索引时，索引才会生效。
  -  数据分布影响
    - 如果MySQL评估使用索引比全表更慢，则不使用索引。
    - 因为MySQL在查询时，会评估使用索引的效率与走全表扫描的效率，如果走全表扫描更快，则放弃索引，走全表扫描。 因为索引是用来索引少量数据的，如果通过索引查询返回大批量的数据，则还不如走全表扫描来的快，此时索引就会失效。
- SQL提示
  - SQL提示，是优化数据库的一个重要手段，简单来说，就是在SQL语句中加入一些人为的提示来达到优化操作的目的。
  - 类型
    -  use index ： 建议MySQL使用哪一个索引完成此次查询（仅仅是建议，mysql内部还会再次进行评估）
    -  ignore index ： 忽略指定的索引
    -  force index ： 强制使用索引
- 覆盖索引
  - 覆盖索引是指 查询使用了索引，并且需要返回的列，在该索引中已经全部能够找到，也就是说通过二级索引可以直接返回数据
  - 尽量使用覆盖索引，减少select *，避免了回表查询
  - Extra字段<img src="C:\Users\Oliver\AppData\Roaming\Typora\typora-user-images\image-20221003155423642.png" alt="image-20221003155423642" style="zoom:50%;" />

- 前缀索引

  - 当字段类型为字符串（varchar，text，longtext等）时，有时候需要索引很长的字符串，这会让索引变得很大，查询时，浪费大量的磁盘IO， 影响查询效率。此时可以只将字符串的一部分前缀，建立索引，这样可以大大节约索引空间，从而提高索引效率

  - 语法
    ```mysql
    create index idx_xxxx on table_name(column(n)) ;
    ```

  - 前缀长度

    - 可以根据索引的选择性来决定，而选择性是指不重复的索引值（基数）和数据表的记录总数的比值，索引选择性越高则查询效率越高， 唯一索引的选择性是1，这是最好的索引选择性，性能也是最好的。

  -  前缀索引的查询流程
    <img src="C:\Users\Oliver\AppData\Roaming\Typora\typora-user-images\image-20221003160413995.png" alt="image-20221003160413995" style="zoom:50%;" />

  - 单列索引与联合索引

    - 单列索引：即一个索引只包含单个列。
    - 联合索引：即一个索引包含了多个列。
    - 在业务场景中，如果存在多个查询条件，考虑针对于查询字段建立索引时，建议建立联合索引，而非单列索引。



#### 8.7 索引设计原则

- 针对于**数据量较大，且查询比较频繁的表**建立索引。
- 针对于**常作为查询条件（where）、排序（order by）、分组（group by）**操作的字段建立索
- 尽量选择**区分度高**的列作为索引，尽量建立唯一索引，区分度越高，使用索引的效率越高。
- 如果是字符串类型的字段，字段的长度较长，可以针对于字段的特点，建立**前缀索引**。
- 尽量使用**联合索引**，减少单列索引，查询时，联合索引很多时候可以覆盖索引，节省存储空间，避免回表，提高查询效率。
- 要控制索引的数量，索引并不是多多益善，索引越多，维护索引结构的代价也就越大，会影响增删改的效率。
- 如果索引列**不能存储NULL值**，请在创建表时使用NOT NULL约束它。当优化器知道每列是否包含NULL值时，它可以更好地确定哪个索引最有效地用于查询。



### 9 SQL优化



#### 9.1 插入数据

- insert

  - 优化一：批量插入
  - 优化二：手动控制事务
  - 优化三：主键顺序插入

- 大批量插入数据

  - 如果一次性需要插入大批量数据(比如: 几百万的记录)，使用insert语句插入性能较低，此时可以使用MySQL数据库提供的load指令进行插入。

  - 可以执行如下指令，将数据脚本文件中的数据加载到表结构中：
    ```shell
    -- 客户端连接服务端时，加上参数 -–local-infile 
    mysql –-local-infile -u root -p 
    -- 设置全局参数local_infile为1，开启从本地加载文件导入数据的开关 
    set global local_infile = 1; 
    -- 执行load指令将准备好的数据，加载到表结构中 
    load data local infile '/root/sql1.log' into table tb_user fields terminated by ',' lines terminated by '\n' ;
    ```

    



#### 9.2 主键优化

-  数据组织方式
  - 在InnoDB存储引擎中，表数据都是根据主键顺序组织存放的，这种存储方式的表称为索引组织表
- 页分裂
  - 页可以为空，也可以填充一半，也可以填充100%。每个页包含了2-N行数据(如果一行数据过大，会行溢出)，根据主键排列
  - 主键乱序插入时发生
- 页合并
  - 当删除一行记录时，实际上记录并没有被物理删除，只是记录被标记（flaged）为删除并且它的空间变得允许被其他记录声明使用。
  - 当页中删除的记录达到 MERGE_THRESHOLD（默认为页的50%），InnoDB会开始寻找最靠近的页（前或后）看看是否可以将两个页合并以优化空间使用
-  索引设计原则
  - 满足业务需求的情况下，尽量降低主键的长度。
  - 插入数据时，尽量选择顺序插入，选择使用AUTO_INCREMENT自增主键。
  - 尽量不要使用UUID做主键或者是其他自然主键，如身份证号。
  - 业务操作时，避免对主键的修改。



#### 9.3 order by优化

- MySQL的排序，有两种方式：
  - Using filesort : 通过表的索引或全表扫描，读取满足条件的数据行，然后在排序缓冲区sort buffer中完成排序操作，所有不是通过索引直接返回排序结果的排序都叫 FileSort 排序。
  - Using index : 通过有序索引顺序扫描直接返回有序数据，这种情况即为 using index，不需要额外排序，操作效率高。
- 对于以上的两种排序方式，Using index的性能高，而Using filesort的性能低，我们在优化排序操作时，尽量要优化为 Using index。

- order by优化原则:
  - 根据排序字段建立合适的索引，多字段排序时，也遵循最左前缀法则。
  - 尽量使用覆盖索引。
  - 多字段排序, 一个升序一个降序，此时需要注意联合索引在创建时的规则（ASC/DESC）。
  - 如果不可避免的出现filesort，大数据量排序时，可以适当增大排序缓冲区大小sort_buffer_size(默认256k)。



#### 9.4 group by优化

- 分组操作优化：
  - 在分组操作时，可以通过索引来提高效率。
  - 分组操作时，索引的使用也是满足最左前缀法则的



#### 9.5 limit优化

- 在数据量比较大时，如果进行limit分页查询，在查询时，越往后，分页查询效率越低。
-  一般分页查询时，通过创建 覆盖索引 能够比较好地提高性能，可以通过覆盖索引加子查询形式进行优化。



#### 9.6 count优化

- 概述
  - MyISAM 引擎把一个表的总行数存在了磁盘上，因此执行 count(\*) 的时候会直接返回这个
    数，效率很高； 但是如果是带条件的count，MyISAM也慢。
  - InnoDB 引擎就麻烦了，它执行 count(*) 的时候，需要把数据一行一行地从引擎里面读出
    来，然后累积计数。
- count用法
  - count() 是一个聚合函数，对于返回的结果集，一行行地判断，如果 count 函数的参数不是NULL，累计值就加 1，否则不加，最后返回累计值。
    <img src="C:\Users\Oliver\AppData\Roaming\Typora\typora-user-images\image-20221010175934335.png" alt="image-20221010175934335" style="zoom:80%;" />
  - 按照效率排序的话，count(字段) < count(主键 id) < count(1) ≈ count(\*)，所以尽量使用 count(*)。



#### 9.7 update优化

- InnoDB的行锁是针对索引加的锁，不是针对记录加的锁 ,并且该索引不能失效，否则会从行锁
  升级为表锁 。







### 10 视图/存储过程/触发器



#### 10.1 视图

- 概述

  - 视图（View）是一种虚拟存在的表。视图中的数据并不在数据库中实际存在，行和列数据来自定义视图的查询中使用的表，并且是在使用视图时动态生成的。
  - 通俗的讲，视图只保存了查询的SQL逻辑，不保存查询结果。所以我们在创建视图的时候，主要的工作就落在创建这条SQL查询语句上。

- 语法

  - 创建
    ```mysql
    CREATE [OR REPLACE] VIEW 视图名称[(列名列表)] AS SELECT语句 [ WITH [
    CASCADED | LOCAL ] CHECK OPTION ]
    ```

  - 查询
    ```mysql
    查看创建视图语句：SHOW CREATE VIEW 视图名称;
    查看视图数据：SELECT * FROM 视图名称 ...... ;
    ```

  - 修改
    ```mysql
    方式一：CREATE [OR REPLACE] VIEW 视图名称[(列名列表)] AS SELECT语句 [ WITH
    [ CASCADED | LOCAL ] CHECK OPTION ]
    方式二：ALTER VIEW 视图名称[(列名列表)] AS SELECT语句 [ WITH [ CASCADED |
    LOCAL ] CHECK OPTION ]
    ```

  - 删除
    ```mysql
    DROP VIEW [IF EXISTS] 视图名称 [,视图名称] ...
    ```

- 检查选项

  - 当使用WITH CHECK OPTION子句创建视图时，MySQL会通过视图检查正在更改的每个行，例如 插入，更新，删除，以使其符合视图的定义。 MySQL允许基于另一个视图创建视图，它还会检查依赖视图中的规则以保持一致性。为了确定检查的范围，mysql提供了两个选项： CASCADED 和 LOCAL，默认值为 CASCADED 。
    - CASCADED：级联
      比如，v2视图是基于v1视图的，如果在v2视图创建的时候指定了检查选项为 cascaded，但是v1视图
      创建时未指定检查选项。 则在执行检查时，不仅会检查v2，还会级联检查v2的关联视图v1。
    - LOCAL：本地
      比如，v2视图是基于v1视图的，如果在v2视图创建的时候指定了检查选项为 local ，但是v1视图创
      建时未指定检查选项。 则在执行检查时，知会检查v2，不会检查v2的关联视图v1。

-  视图的更新

  - 要使视图可更新，视图中的行与基础表中的行之间必须存在一对一的关系。如果视图包含以下任何一项，则该视图不可更新：
    - 聚合函数或窗口函数（SUM()、 MIN()、 MAX()、 COUNT()等）
    - DISTINCT
    - GROUP BY
    - HAVING
    - UNION 或者 UNION ALL 
  - 视图作用
    - 简单
      - 视图不仅可以简化用户对数据的理解，也可以简化他们的操作。那些被经常使用的查询可以被定义为视图，从而使得用户不必为以后的操作每次指定全部的条件。
    - 安全
      - 数据库可以授权，但不能授权到数据库特定行和特定的列上。通过视图用户只能查询和修改他们所能见到的数据
    - 数据独立
      - 视图可帮助用户屏蔽真实表结构变化带来的影响。



#### 10.2 存储过程

- 概述

  - 存储过程是事先经过编译并存储在数据库中的一段 SQL 语句的集合，调用存储过程可以简化应用开发人员的很多工作，减少数据在数据库和应用服务器之间的传输，对于提高数据处理的效率是有好处的。

  - 存储过程思想上很简单，就是数据库 SQL 语言层面的代码封装与重用。

  - 特点:

    - 封装，复用：可以把某一业务SQL封装在存储过程中，需要用到的时候直接调用即可。

    - 可以接收参数，也可以返回数据：再存储过程中，可以传递参数，也可以接收返回值。

    - 减少网络交互，效率提升：如果涉及到多条SQL，每执行一次都是一次网络传输。 而如果封装在存储过程中，我们只需要网络交互一次可能就可以了。

- 语法

  - 创建
    ```mysql
    CREATE PROCEDURE 存储过程名称 ([ 参数列表 ])
    BEGIN
    -- SQL语句
    END ;
    ```

  - 调用
    ```mysql
    CALL 名称 ([ 参数 ]);
    ```

  - 查看
    ```mysql
    SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA = 'xxx'; -- 查询指
    定数据库的存储过程及状态信息
    SHOW CREATE PROCEDURE 存储过程名称 ; -- 查询某个存储过程的定义
    ```

  - 删除
    ```mysql
    DROP PROCEDURE [ IF EXISTS ] 存储过程名称 ；
    ```

- 变量

  - 系统变量：是MySQL服务器提供，不是用户定义的，属于服务器层面。分为全局变量（GLOBAL）、会话变量（SESSION）。

    - 查看系统变量
      ```mysql
      SHOW [ SESSION | GLOBAL ] VARIABLES ; -- 查看所有系统变量
      SHOW [ SESSION | GLOBAL ] VARIABLES LIKE '......'; -- 可以通过LIKE模糊匹配方
      式查找变量
      SELECT @@[SESSION | GLOBAL] 系统变量名; -- 查看指定变量的值
      ```

    - 设置系统变量
      ```mysql
      SET [ SESSION | GLOBAL ] 系统变量名 = 值 ;
      SET @@[SESSION | GLOBAL]系统变量名 = 值 ;
      ```

      > 如果没有指定SESSION/GLOBAL，默认是SESSION，会话变量。
      > A. 全局变量(GLOBAL): 全局变量针对于所有的会话。
      > B. 会话变量(SESSION): 会话变量针对于单个会话，在另外一个会话窗口就不生效了。

  - 用户定义变量：是用户根据需要自己定义的变量，用户变量不用提前声明，在用的时候直接用 "@变量名" 使用就可以。其作用域为当前连接

    - 赋值
      ```mysql
      SET @var_name = expr [, @var_name = expr] ... ;
      SET @var_name := expr [, @var_name := expr] ... ;
      SELECT @var_name := expr [, @var_name := expr] ... ;
      SELECT 字段名 INTO @var_name FROM 表名;
      ```

    - 使用
      ```mysql
      SELECT @var_name ;
      ```

      > 注意: 用户定义的变量无需对其进行声明或初始化，只不过获取到的值为NULL

  - 局部变量：是根据需要定义的在局部生效的变量，访问之前，需要DECLARE声明。可用作存储过程内的局部变量和输入参数，局部变量的范围是在其内声明的BEGIN ... END块。

    - 声明
      ```mysql
      DECLARE 变量名 变量类型 [DEFAULT ... ] ;
      ```

      > 变量类型就是数据库字段类型：INT、BIGINT、CHAR、VARCHAR、DATE、TIME等

    - 赋值
      ```mysql
      SET 变量名 = 值 ;
      SET 变量名 := 值 ;
      SELECT 字段名 INTO 变量名 FROM 表名 ... ;
      ```

- if

  - 语法
    ```mysql
    IF 条件1 THEN
    .....
    ELSEIF 条件2 THEN -- 可选
    .....
    ELSE -- 可选
    .....
    END IF;
    ```

- 参数
  <img src="C:\Users\Oliver\AppData\Roaming\Typora\typora-user-images\image-20221016223325232.png" alt="image-20221016223325232" style="zoom:50%;" />

- case

  - 语法一
    ```mysql
    -- 含义： 当case_value的值为 when_value1时，执行statement_list1，当值为 when_value2时，
    执行statement_list2， 否则就执行 statement_list
    CASE case_value
    WHEN when_value1 THEN statement_list1
    [ WHEN when_value2 THEN statement_list2] ...
    [ ELSE statement_list ]
    END CASE;
    ```

  - 语法二
    ```mysql
    -- 含义： 当条件search_condition1成立时，执行statement_list1，当条件search_condition2成
    立时，执行statement_list2， 否则就执行 statement_list
    CASE
    WHEN search_condition1 THEN statement_list1
    [WHEN search_condition2 THEN statement_list2] ...
    [ELSE statement_list]
    END CASE;
    ```

- while

  - 语法
    ```mysql
    -- 先判定条件，如果条件为true，则执行逻辑，否则，不执行逻辑
    WHILE 条件 DO
    SQL逻辑...
    END WHILE;
    ```

- repeat

  - 语法
    ```mysql
    -- 先执行一次逻辑，然后判定UNTIL条件是否满足，如果满足，则退出。如果不满足，则继续下一次循环
    REPEAT
    SQL逻辑...
    UNTIL 条件
    END REPEAT;
    ```

- loop

  - 语法
    ```mysql
    -- LOOP 实现简单的循环，如果不在SQL逻辑中增加退出循环的条件，可以用其来实现简单的死循环。
    [begin_label:] LOOP
    SQL逻辑...
    END LOOP [end_label];
    -- LOOP可以配合一下两个语句使用：
    LEAVE ：配合循环使用，退出循环。
    ITERATE：必须用在循环中，作用是跳过当前循环剩下的语句，直接进入下一次循环。
    ```

- 游标

  - 游标（CURSOR）是用来存储查询结果集的数据类型 , 在存储过程和函数中可以使用游标对结果集进行循环的处理。游标的使用包括游标的声明、OPEN、FETCH 和 CLOSE，其语法分别如下。

  - 语法

    - 声明游标
      ```mysql
      DECLARE 游标名称 CURSOR FOR 查询语句 ;
      ```

    - 打开游标
      ```mysql
      OPEN 游标名称 ;
      ```

    - 获取游标记录
      ```mysql
      FETCH 游标名称 INTO 变量 [, 变量 ] ;
      ```

    - 关闭游标
      ```mysql
      CLOSE 游标名称 ;
      ```

- 条件处理程序

  - 条件处理程序（Handler）可以用来定义在流程控制结构执行过程中遇到问题时相应的处理步骤。

  - 语法

    ```mysql
    DECLARE handler_action HANDLER FOR condition_value [, condition_value]
    ... statement ;
    
    handler_action 的取值：
    CONTINUE: 继续执行当前程序
    EXIT: 终止执行当前程序
    
    condition_value 的取值：
    SQLSTATE sqlstate_value: 状态码，如 02000
    SQLWARNING: 所有以01开头的SQLSTATE代码的简写
    NOT FOUND: 所有以02开头的SQLSTATE代码的简写
    SQLEXCEPTION: 所有没有被SQLWARNING 或 NOT FOUND捕获的SQLSTATE代码的简写
    ```







#### 10.3 触发器

- 概述

  - 触发器是与表有关的数据库对象，指在insert/update/delete之前(BEFORE)或之后(AFTER)，触发并执行触发器中定义的SQL语句集合。触发器的这种特性可以协助应用在数据库端确保数据的完整性, 日志记录 , 数据校验等操作 。

  - 使用别名OLD和NEW来引用触发器中发生变化的记录内容，这与其他的数据库是相似的。现在触发器还只支持行级触发，不支持语句级触发。

    <img src="C:\Users\Oliver\AppData\Roaming\Typora\typora-user-images\image-20221016224445872.png" alt="image-20221016224445872" style="zoom:67%;" />

- 语法

  - 创建
    ```mysql
    CREATE TRIGGER trigger_name
    BEFORE/AFTER INSERT/UPDATE/DELETE
    ON tbl_name FOR EACH ROW -- 行级触发器
    BEGIN
    	trigger_stmt ;
    END;
    ```

  - 查看

    ```mysql
    SHOW TRIGGERS ;
    ```

  - 删除

    ```mysql
    DROP TRIGGER [schema_name.]trigger_name ; -- 如果没有指定 schema_name，默认为当前数
    据库 。
    ```

    





### 11 锁



#### 11.1 概述

- 锁是计算机协调多个进程或线程并发访问某一资源的机制。在数据库中，除传统的计算资源（CPU、RAM、I/O）的争用以外，数据也是一种供许多用户共享的资源。如何保证数据并发访问的一致性、有效性是所有数据库必须解决的一个问题，锁冲突也是影响数据库并发访问性能的一个重要因素。从这个角度来说，锁对数据库而言显得尤其重要，也更加复杂。
- MySQL中的锁，按照锁的粒度分，分为以下三类：
  - 全局锁：锁定数据库中的所有表。
  - 表级锁：每次操作锁住整张表。
  - 行级锁：每次操作锁住对应的行数据。



#### 11.2 全局锁

- 全局锁就是对整个数据库实例加锁，加锁后整个实例就处于只读状态，后续的DML的写语句，DDL语句，已经更新操作的事务提交语句都将被阻塞

- 典型的使用场景：做全库的逻辑备份，对所有的表进行锁定，从而获取一致性视图，保证数据的完整性。
  - 对数据库进行进行逻辑备份之前，先对整个数据库加上全局锁，一旦加了全局锁之后，其他的DDL、DML全部都处于阻塞状态，但是可以执行DQL语句，也就是处于只读状态，而数据备份就是查询操作。那么数据在进行逻辑备份的过程中，数据库中的数据就是不会发生变化的，这样就保证了数据的一致性和完整性

  

  - 对数据库进行进行逻辑备份之前，先对整个数据库加上全局锁，一旦加了全局锁之后，其他的DDL、
    DML全部都处于阻塞状态，但是可以执行DQL语句，也就是处于只读状态，而数据备份就是查询操作。
    那么数据在进行逻辑备份的过程中，数据库中的数据就是不会发生变化的，这样就保证了数据的一致性
    和完整性

- 语法

  - 加全局锁
    ```mysql
    flush tables with read lock ;
    ```

  - 数据备份
    ```mysql
    mysqldump -uroot –p1234 itcast > itcast.sql
    ```

  - 释放锁
    ```mysql
    unlock tables ;
    ```

- 特点

  - 数据库中加全局锁，是一个比较重的操作，存在以下问题：
    - 如果在主库上备份，那么在备份期间都不能执行更新，业务基本上就得停摆。
    - 如果在从库上备份，那么在备份期间从库不能执行主库同步过来的二进制日志（binlog），会导致主从延迟。
  - 在InnoDB引擎中，我们可以在备份时加上参数 --single-transaction 参数来完成不加锁的一致性数据备份



#### 11.3 表级锁

- 概述

  - 表级锁，每次操作锁住整张表。锁定粒度大，发生锁冲突的概率最高，并发度最低。应用在MyISAM、InnoDB、BDB等存储引擎中。
  - 对于表级锁，主要分为以下三类：
    - 表锁
    - 元数据锁（meta data lock，MDL）
    - 意向锁

- 表锁
  - 对于表锁，分为两类：

    - 表共享读锁（read lock）：只可读不可写

    - 表独占写锁（write lock）：不可读不可写

  - 语法：
    - 加锁：lock tables 表名... read/write。
    - 释放锁：unlock tables / 客户端断开连接 。

- 元数据锁

  - meta data lock , 元数据锁，简写MDL。
  - MDL加锁过程是系统自动控制，无需显式使用，在访问一张表的时候会自动加上。MDL锁主要作用是维护表元数据的数据一致性，在表上有活动事务的时候，不可以对元数据进行写入操作。为了避免DML与DDL冲突，保证读写的正确性

- 意向锁

  - 为了避免DML在执行时，加的行锁与表锁的冲突，在InnoDB中引入了意向锁，使得表锁不用检查每行数据是否加锁，使用意向锁来减少表锁的检查。

  - 分类

    - 意向共享锁(IS): 由语句select ... lock in share mode添加 。 与 表锁共享锁(read)兼容，与表锁排他锁(write)互斥。
    - 意向排他锁(IX): 由insert、update、delete、select...for update添加 。与表锁共享锁(read)及排他锁(write)都互斥，意向锁之间不会互斥。

    > 一旦事务提交了，意向共享锁、意向排他锁，都会自动释放。



#### 11.4 行级锁

- 概述

  - 行级锁，每次操作锁住对应的行数据。锁定粒度最小，发生锁冲突的概率最低，并发度最高。应用在InnoDB存储引擎中。
  - InnoDB的数据是基于索引组织的，行锁是通过对索引上的索引项加锁来实现的，而不是对记录加的锁。对于行级锁，主要分为以下三类：
    - 行锁（Record Lock）：锁定单个行记录的锁，防止其他事务对此行进行update和delete。在RC、RR隔离级别下都支持。
    - 间隙锁（Gap Lock）：锁定索引记录间隙（不含该记录），确保索引记录间隙不变，防止其他事务在这个间隙进行insert，产生幻读。在RR隔离级别下都支持。
    - 临键锁（Next-Key Lock）：行锁和间隙锁组合，同时锁住数据，并锁住数据前面的间隙Gap。在RR隔离级别下支持。

- 行锁

  - InnoDB实现了以下两种类型的行锁：

    - 共享锁（S）：允许一个事务去读一行，阻止其他事务获得相同数据集的排它锁。
    - 排他锁（X）：允许获取排他锁的事务更新数据，阻止其他事务获得相同数据集的共享锁和排他锁

    <img src="C:\Users\Oliver\AppData\Roaming\Typora\typora-user-images\image-20221016231403776.png" alt="image-20221016231403776" style="zoom:67%;" />

  - 常见的SQL语句，在执行时，所加的行锁如下：
    <img src="C:\Users\Oliver\AppData\Roaming\Typora\typora-user-images\image-20221016231437798.png" alt="image-20221016231437798" style="zoom:50%;" />

- 间隙锁&临键锁

  - 默认情况下，InnoDB在 REPEATABLE READ事务隔离级别运行，InnoDB使用 next-key 锁进行搜索和索引扫描，以防止幻读。
  - 索引上的等值查询(唯一索引)，给不存在的记录加锁时, 优化为间隙锁 。
  - 索引上的等值查询(非唯一普通索引)，向右遍历时最后一个值不满足查询需求时，next-key lock 退化为间隙锁。
  - 索引上的范围查询(唯一索引)--会访问到不满足条件的第一个值为止。



### 12 InnoDB引擎



#### 12.1 逻辑存储

- 逻辑存储结构
  ![image-20221018164628841](C:\Users\Oliver\AppData\Roaming\Typora\typora-user-images\image-20221018164628841.png)
  - 表空间
    - 是InnoDB存储引擎逻辑结构的最高层， 如果用户启用了参数 innodb_file_per_table(在8.0版本中默认开启) ，则每张表都会有一个表空间（xxx.ibd），一个mysql实例可以对应多个表空间，用于存储记录、索引等数据。
  - 段
    - 分为数据段（Leaf node segment）、索引段（Non-leaf node segment）、回滚段（Rollback segment），InnoDB是索引组织表，数据段就是B+树的叶子节点， 索引段即为B+树的非叶子节点。段用来管理多个Extent（区）。
  -  区
    - 表空间的单元结构，每个区的大小为1M。 默认情况下， InnoDB存储引擎页大小为16K， 即一个区中一共有64个连续的页。
  - 页
    - **是InnoDB 存储引擎磁盘管理的最小单元**，每个页的大小默认为 **16KB**。为了保证页的连续性，InnoDB 存储引擎每次从磁盘申请 4-5 个区。
  - 行
    - InnoDB 存储引擎数据是按行进行存放的。
    - 在行中，默认有两个隐藏字段：
      - Trx_id：每次对某条记录进行改动时，都会把对应的事务id赋值给trx_id隐藏列。
      - Roll_pointer：每次对某条引记录进行改动时，都会把旧的版本写入到undo日志中，然后这个隐藏列就相当于一个指针，可以通过它来找到该记录修改前的信息。



#### 12.2 架构

- 概述
  - MySQL5.5 版本开始，默认使用InnoDB存储引擎，它擅长事务处理，具有崩溃恢复特性，在日常开发中使用非常广泛。下面是InnoDB架构图，左侧为内存结构，右侧为磁盘结构。
    ![image-20221018165000423](C:\Users\Oliver\AppData\Roaming\Typora\typora-user-images\image-20221018165000423.png)
- 内存结构
  ![image-20221018165052179](C:\Users\Oliver\AppData\Roaming\Typora\typora-user-images\image-20221018165052179.png)
  -  Buffer Pool
    - InnoDB存储引擎基于磁盘文件存储，访问物理硬盘和在内存中进行访问，速度相差很大，为了尽可能弥补这两者之间的I/O效率的差值，就需要把经常使用的数据加载到缓冲池中，避免每次访问都进行磁盘I/O。
    - 在InnoDB的缓冲池中不仅缓存了索引页和数据页，还包含了undo页、插入缓存、自适应哈希索引以及InnoDB的锁信息等等。
    - 缓冲池 Buffer Pool，是主内存中的一个区域，里面可以缓存磁盘上经常操作的真实数据，在执行增删改查操作时，先操作缓冲池中的数据（若缓冲池没有数据，则从磁盘加载并缓存），然后再以一定频率刷新到磁盘，从而减少磁盘IO，加快处理速度。
    - 缓冲池以Page页为单位，底层采用链表数据结构管理Page。根据状态，将Page分为三种类型：
      - free page：空闲page，未被使用。
      - clean page：被使用page，数据没有被修改过。
      - dirty page：脏页，被使用page，数据被修改过，也中数据与磁盘的数据产生了不一致。
    - 在专用服务器上，通常将多达80％的物理内存分配给缓冲池 。参数设置： `show variables like 'innodb_buffer_pool_size';`
  -  Change Buffer
    - Change Buffer，更改缓冲区（针对于非唯一二级索引页），在执行DML语句时，如果这些数据Page没有在Buffer Pool中，不会直接操作磁盘，而会将数据变更存在更改缓冲区 Change Buffer中，在未来数据被读取时，再将数据合并恢复到Buffer Pool中，再将合并后的数据刷新到磁盘中
    - 与聚集索引不同，二级索引通常是非唯一的，并且以相对随机的顺序插入二级索引。同样，删除和更新可能会影响索引树中不相邻的二级索引页，如果每一次都操作磁盘，会造成大量的磁盘IO。有了ChangeBuffer之后，我们可以在缓冲池中进行合并处理，减少磁盘IO。
  -  Adaptive Hash Index
    - 自适应hash索引，用于优化对Buffer Pool数据的查询。MySQL的innoDB引擎中虽然没有直接支持hash索引，但是给我们提供了一个功能就是这个自适应hash索引。因为前面我们讲到过，hash索引在进行等值匹配时，一般性能是要高于B+树的，因为hash索引一般只需要一次IO即可，而B+树，可能需要几次匹配，所以hash索引的效率要高，但是hash索引又**不适合做范围查询、模糊匹配**等。
    - InnoDB存储引擎会监控对表上各索引页的查询，如果观察到在特定的条件下hash索引可以提升速度，则建立hash索引，称之为自适应hash索引。
    - **自适应**哈希索引，无需人工干预，是系统根据情况自动完成。
    - 参数：` adaptive_hash_index`
  - Log Buffer
    - Log Buffer：日志缓冲区，用来保存要写入到磁盘中的log日志数据（redo log 、undo log），
      默认大小为 16MB，日志缓冲区的日志会定期刷新到磁盘中。如果需要更新、插入或删除许多行的事
      务，增加日志缓冲区的大小可以节省磁盘 I/O。
    - 参数:
      - `innodb_log_buffer_size`：缓冲区大小
      - `innodb_flush_log_at_trx_commit`：日志刷新到磁盘时机，取值主要包含以下三个：
        - 1: 日志在每次事务提交时写入并刷新到磁盘，默认值。
        - 0: 每秒将日志写入并刷新到磁盘一次。
        - 2: 日志在每次事务提交后写入，并每秒刷新到磁盘一次。
- 磁盘结构
  ![image-20221018170149107](C:\Users\Oliver\AppData\Roaming\Typora\typora-user-images\image-20221018170149107.png)
  -  System Tablespace
    - 系统表空间是更改缓冲区的存储区域。如果表是在系统表空间而不是每个表文件或通用表空间中创建的，它也可能包含表和索引数据。(在MySQL5.x版本中还包含InnoDB数据字典、undolog等)
    - 参数：`innodb_data_file_path`
  -  File-Per-Table Tablespaces
    - 如果开启了innodb_file_per_table开关 ，则每个表的文件表空间包含单个InnoDB表的数据和索引 ，并存储在文件系统上的单个数据文件中。
    - 开关参数：`innodb_file_per_table` ，该参数默认开启。
  -  General Tablespaces
    - 通用表空间，需要通过 CREATE TABLESPACE 语法创建通用表空间，在创建表时，可以指定该表空间。
  -  Undo Tablespaces
    - 撤销表空间，MySQL实例在初始化时会自动创建两个默认的undo表空间（初始大小16M），用于存储undo log日志。
  - Temporary Tablespaces
    - InnoDB 使用会话临时表空间和全局临时表空间。存储用户创建的临时表等数据。
  - Doublewrite Buffer Files
    - 双写缓冲区，innoDB引擎将数据页从Buffer Pool刷新到磁盘前，先将数据页写入双写缓冲区文件中，便于系统异常时恢复数据。
  - Redo Log
    - 重做日志，是用来实现事务的持久性。该日志文件由两部分组成：重做日志缓冲（redo logbuffer）以及重做日志文件（redo log）,前者是在内存中，后者在磁盘中。当事务提交之后会把所有修改信息都会存到该日志中, 用于在刷新脏页到磁盘时,发生错误时, 进行数据恢复使用。
    - 以循环方式写入重做日志文件，涉及两个文件：
      - ib_logfile0
      - ib_logfile1
- 后台进程
  -  Master Thread
    - 核心后台线程，负责调度其他线程，还负责将缓冲池中的数据异步刷新到磁盘中, 保持数据的一致性，还包括脏页的刷新、合并插入缓存、undo页的回收 。
  - IO Thread
    - 在InnoDB存储引擎中大量使用了AIO来处理IO请求, 这样可以极大地提高数据库的性能，而IO
    - Thread主要负责这些IO请求的回调
      ![image-20221018170545666](C:\Users\Oliver\AppData\Roaming\Typora\typora-user-images\image-20221018170545666.png)
  - Purge Thread
    - 主要用于回收事务已经提交了的undo log，在事务提交之后，undo log可能不用了，就用它来回收。
  - Page Cleaner Thread
    - 协助 Master Thread 刷新脏页到磁盘的线程，它可以减轻 Master Thread 的工作压力，减少阻塞。



#### 12.3 事务原理

- ACID

  - 原子性（Atomicity）：事务是不可分割的最小操作单元，要么全部成功，要么全部失败。
  - 一致性（Consistency）：事务完成时，必须使所有的数据都保持一致状态。
  - 隔离性（Isolation）：数据库系统提供的隔离机制，保证事务在不受外部并发操作影响的独立环境下运行。
  - 持久性（Durability）：事务一旦提交或回滚，它对数据库中的数据的改变就是永久的。

- ACID实现

  - 其中的原子性、一致性、持久性，实际上是由InnoDB中的两份日志来保证的，一份是redo log日志，一份是undo log日志。
  - 而隔离性是通过数据库的锁，加上MVCC来保证的

- redolog（-持久性）

  - 重做日志，记录的是事务提交时数据页的物理修改，是用来实现事务的持久性。

  - 该日志文件由两部分组成：重做日志缓冲（redo log buffer）以及重做日志文件（redo logfile）,前者是在内存中，后者在磁盘中。当事务提交之后会把所有修改信息都存到该日志文件中, 用于在刷新脏页到磁盘,发生错误时, 进行数据恢复使用

  - 问题：

    -  当我们在一个事务中，执行多个增删改的操作时，InnoDB引擎会先操作缓冲池中的数据，如果缓冲区没有对应的数据，会通过后台线程将磁盘中的数据加载出来，存放在缓冲区中，然后将缓冲池中的数据修改，修改后的数据页我们称为脏页。 而脏页则会在一定的时机，通过后台线程刷新到磁盘中，从而保证缓冲区与磁盘的数据一致。 而缓冲区的脏页数据并不是实时刷新的，而是一段时间之后将缓冲区的数据刷新到磁盘中，假如刷新到磁盘的过程出错了，而提示给用户事务提交成功，而数据却没有持久化下来，这就出现问题了，没有保证事务的持久性。

  - 解决：

    - 有了redolog之后，当对缓冲区的数据进行增删改之后，会首先将操作的数据页的变化，记录在redolog buffer中。

    - 在事务提交时，会将redo log buffer中的数据刷新到redo log磁盘文件中。过一段时间之后，如果刷新缓冲区的脏页到磁盘时，发生错误，此时就可以借助于redo log进行数据恢复，这样就保证了事务的持久性。 （WAL：Write-Ahead Logging）

    - 而如果脏页成功刷新到磁盘 或 或者涉及到的数据已经落盘，此时redolog就没有作用了，就可以删除了，所以存在的两个redolog文件是循环写的

    - 日志文件都是顺序追加的，不存在性能问题！
      ![image-20221018171342611](C:\Users\Oliver\AppData\Roaming\Typora\typora-user-images\image-20221018171342611.png)

      > 因为在业务操作中，我们操作数据一般都是随机读写磁盘的，而不是顺序读写磁盘。 
      > 而redo log在往磁盘文件中写入数据，由于是日志文件，所以都是顺序写的。顺序写的效率，要远大于随机写。 这种先写日志的方式，称之为 WAL（Write-Ahead Logging）

- undolog（-原子性&MVCC）

  - 回滚日志，用于记录数据被修改前的信息 , 作用包含两个 : 提供回滚(保证事务的原子性) 和MVCC(多版本并发控制) 。
  - undo log和redo log记录物理日志不一样，它是逻辑日志。**可以认为当delete一条记录时，undo log中会记录一条对应的insert记录，反之亦然，当update一条记录时，它记录一条对应相反的update记录**。当执行rollback时，就可以从undo log中的逻辑记录读取到相应的内容并进行回滚。
  - Undo log销毁：undo log在事务执行时产生，事务提交时，并不会立即删除undo log，因为这些日志可能还用于MVCC。
  - Undo log存储：undo log采用段的方式进行管理和记录，存放在前面介绍的 rollback segment回滚段中，内部包含1024个undo log segment。



#### 12.4 MVCC

- 概述
  - 当前读
    - 读取的是记录的最新版本，读取时还要保证其他并发事务不能修改当前记录，会对读取的记录进行加锁。对于我们日常的操作，如：select ... lock in share mode(共享锁)，select ...for update、update、insert、delete(排他锁)都是一种当前读。
  - 快照读
    - 简单的select（不加锁）就是快照读，快照读，读取的是记录数据的可见版本，有可能是历史数据，**不加锁**，是非阻塞读。
      - Read Committed：每次select，都生成一个快照读。
      - Repeatable Read：开启事务后第一个select语句才是快照读的地方。
      - Serializable：快照读会退化为当前读
  -  MVCC
    - 全称 Multi-Version Concurrency Control，多版本并发控制。指维护一个数据的多个版本，使得读写操作没有冲突，快照读为MySQL实现MVCC提供了一个非阻塞读功能。MVCC的具体实现，还需要依赖于数据库记录中的三个隐式字段、undo log日志、readView。
- 隐藏字段
  <img src="C:\Users\Oliver\AppData\Roaming\Typora\typora-user-images\image-20221018173016542.png" alt="image-20221018173016542" style="zoom:67%;" />
- undo log
  - 概述
    - 回滚日志，在insert、update、delete的时候产生的便于数据回滚的日志。
    - 当insert的时候，产生的undo log日志只在回滚时需要，在事务提交后，可被立即删除。
    - 而update、delete的时候，产生的undo log日志不仅在回滚时需要，在快照读时也需要，不会立即被删除
  - 版本链
    - 不同事务或相同事务对同一条记录进行修改，会导致该记录的undolog生成一条记录版本链表，链表的头部是最新的旧记录，链表尾部是最早的旧记录。
      ![image-20221018173429147](C:\Users\Oliver\AppData\Roaming\Typora\typora-user-images\image-20221018173429147.png)
- readview
  - ReadView（读视图）是 快照读 SQL执行时MVCC提取数据的依据，记录并维护系统当前活跃的事务（未提交的）id。
  - ReadView中包含了四个核心字段：
    ![image-20221018173447539](C:\Users\Oliver\AppData\Roaming\Typora\typora-user-images\image-20221018173447539.png)
  - 版本链数据访问规则（根据此规则在版本链中递归查找最新的可访问版本）
    ![image-20221018173601746](C:\Users\Oliver\AppData\Roaming\Typora\typora-user-images\image-20221018173601746.png)
  - 不同的隔离级别，生成ReadView的时机不同：
    - READ COMMITTED ：在事务中每一次执行快照读时生成ReadView。
    - REPEATABLE READ：仅在事务中第一次执行快照读时生成ReadView，后续复用该ReadView。

- 原理分析
  - RC隔离级别
    - RC隔离级别下，在事务中每一次执行快照读时生成ReadView。
    - 核心规则：快照读只能读到当前已提交事务的最新版本
  -  RR隔离级别
    - RR隔离级别下，仅在事务中第一次执行快照读时生成ReadView，后续复用该ReadView。 而RR 是可重复读，在一个事务中，执行两次相同的select语句，查询到的结果是一样的
    - 核心规则：一个事务中快照读都读取的是同一版本



### 13 MySQL管理



#### 13.1 系统数据库

Mysql数据库安装完成后，自带了一下四个数据库，具体作用如下：
![image-20221019111924390](C:\Users\Oliver\AppData\Roaming\Typora\typora-user-images\image-20221019111924390.png)





#### 13.2 常用工具

- mysql

  - 该mysql不是指mysql服务，而是指mysql的客户端工具。

  - 语法
    ```mysql
    语法 ：
    mysql [options] [database]
    选项 ：
    -u, --user=name #指定用户名
    -p, --password[=name] #指定密码
    -h, --host=name #指定服务器IP或域名
    -P, --port=port #指定连接端口
    -e, --execute=name #执行SQL语句并退出
    ```

    > -e选项可以在Mysql客户端执行SQL语句，而不用连接到MySQL数据库再执行，对于一些批处理脚本，这种方式尤其方便。

- mysqladmin

  - mysqladmin 是一个执行管理操作的客户端程序。可以用它来检查服务器的配置和当前状态、创建并删除数据库等。

  - 语法
    ```mysql
    语法:
    mysqladmin [options] command ...
    选项:
    -u, --user=name #指定用户名
    -p, --password[=name] #指定密码
    -h, --host=name #指定服务器IP或域名
    -P, --port=port #指定连接端口
    ```

- mysqlbinlog

  - 由于服务器生成的二进制日志文件以二进制格式保存，所以如果想要检查这些文本的文本格式，就会使用到mysqlbinlog 日志管理工具。

  - 语法
    ```mysql
    语法 ：
    mysqlbinlog [options] log-files1 log-files2 ...
    选项 ：
    -d, --database=name 指定数据库名称，只列出指定的数据库相关操作。
    -o, --offset=# 忽略掉日志中的前n行命令。
    -r,--result-file=name 将输出的文本格式日志输出到指定文件。
    -s, --short-form 显示简单格式， 省略掉一些信息。
    --start-datatime=date1 --stop-datetime=date2 指定日期间隔内的所有日志。
    --start-position=pos1 --stop-position=pos2 指定位置间隔内的所有日志。
    ```

- mysqlshow 

  - 客户端对象查找工具，用来很快地查找存在哪些数据库、数据库中的表、表中的列或者索引

  - 语法
    ```mysql
    语法 ：
    mysqlshow [options] [db_name [table_name [col_name]]]
    选项 ：
    --count 显示数据库及表的统计信息（数据库，表 均可以不指定）
    -i 显示指定数据库或者指定表的状态信息
    ```

-  mysqldump

  - 客户端工具用来备份数据库或在不同数据库之间进行数据迁移。备份内容包含创建表，及插入表的SQL语句

  - 语法
    ```mysql
    语法 ：
    mysqldump [options] db_name [tables]
    mysqldump [options] --database/-B db1 [db2 db3...]
    mysqldump [options] --all-databases/-A
    连接选项 ：
    -u, --user=name 指定用户名
    -p, --password[=name] 指定密码
    -h, --host=name 指定服务器ip或域名
    -P, --port=# 指定连接端口
    输出选项：
    --add-drop-database 在每个数据库创建语句前加上 drop database 语句
    --add-drop-table 在每个表创建语句前加上 drop table 语句 , 默认开启 ; 不开启 (--skip-add-drop-table)
    -n, --no-create-db 不包含数据库的创建语句
    -t, --no-create-info 不包含数据表的创建语句
    -d --no-data 不包含数据
    -T, --tab=name 自动生成两个文件：一个.sql文件，创建表结构的语句；一个.txt文件，数据文件
    ```

- mysqlimport/source

  - mysqlimport

    - 客户端数据导入工具，用来导入mysqldump 加 -T 参数后导出的文本文件

    - 语法
      ```mysql
      语法 ：
      mysqlimport [options] db_name textfile1 [textfile2...]
      ```

  -  source

    - 如果需要导入sql文件,可以使用mysql中的source 指令

    - 语法
      ```mysql
      语法 ：
      source /root/xxxxx.sq
      ```

      
