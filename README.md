# DB2022Spring

#### 介绍
HUST 数据库系统原理实验 2022年春季

Finance数据集.

本数据集是2022春季数据库系统原理实验课数据集中一个公开的数据集。如果你在实训平台上写的代码，不能通过评测，又找不到出错的原因，可以在此数据集上进行SQL语句练习，测试SQL语句的正确性。在确认正确后，再将语句复制粘贴到代码文件，然后提交评测。

如果你对SQL很熟悉，在评测环境下闯关很顺利，那么你根本不需要这个数据集，下面的教程你也可以直接跳过，这些过程不是评测所必须的，只是为你提供一个调试语句的环境。因为实训平台仅在你提交代码文件后才开始加载数据，接着运行你提交的代码，最后根据运行结果进行评测，而在提交代码评测之前，不能加载数据，因而缺乏有效的观察、调试、验证的手段。你可以借助本数据集，在命令行导入数据，进行观察，验证和调试。

#### 安装教程

1.打开linux(Ubuntu)命令行窗口；
2.获取数据集初始化脚本文件finance.sql；
3.导入数据集；
4.开启MySQL命令行工具，连接数据库，进行练习，或进行实训任务相关的操作与验证； 
SQL语句调试运行正确后，可以直接COPY到代码文件，提交代码，开始评测。

#### 使用说明

1.打开linux(Ubuntu)命令行窗口；
点击在线实训系统“代码文件”右侧的“命令行”，开启linux命令行窗口，你将看到linux命令行的提符#。

2.获取数据集初始化脚本文件finance.sql。
在linux命令行输入命令：

`wget https://gitee.com/kylin8575543/db2022-spring/raw/master/finance.sql`

也可以下载这个文件的压缩文件:

`wget https://gitee.com/kylin8575543/db2022-spring/raw/master/finance.tar.gz`

注意下载后要用tar解压。

3.导入数据集；
在linux命令行输入命令：

`mysql -h127.0.0.1 -uroot -p123123 < finance.sql 2>/dev/null `

你可能会看到警告信息，直接无视！

4.开启MySQL命令行工具，连接数据库，进行练习，或进行实训任务相关的操作与验证； 
在linux命令行，输入以下命令，即可连接到MySQL数据库:

`mysql -h127.0.0.1 -uroot -p123123`

命令行中的参数説明：
-h:指定host的ip地址；
-u:数据库用户名
-p:用户登录到本服务器的密码
注意各参数后没有空格！！！特别是-p之后的任何文字都会理解成密码的一部分。

屏幕显示如下内容：

```
mysql: [Warning] Using a password on the command line interface can be insecure.
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 12
Server version: 8.0.22 MySQL Community Server - GPL

Copyright (c) 2000, 2020, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.
mysql>
```

你在上述提示中会看到警告信息，提示你不应该在命令行输入密码，这样做不安全，因为很容易被别人看到。 在实际工作中，你确实不应该这样作，不过这只是一个实验，而且所有学生的MySQL实例赋予了相同的密码，没有什么好保密的。

当然，你也可以在命令行参数-p后不给出密码，直接回车，MySQL将提示你输入密码：
`Enter password:`

输入密码时，光标不会移动，也不会显示任何字符（不是你期待的*号！！！),正确输入123123并回车即可。 这样就不会有警告了， 你在平时工作时，务必这么做！
在上述提示信息中你还会看到其它信息，比如MySQL的版本号8.0.22等等。 最后出现的是MySQL命令行的提示符:

`mysql>`

接下来，你可以像在你本机一样进行MySQL的操作：建库，选择工作数据库，建表，增、删、改、查询等操作。
关于MySQL的相关操作命令，请参考[MySQL 8.0 Reference Manual](https://dev.mysql.com/doc/refman/8.0/en/)。

这里仅列出最常用的命令：

- show databases; --列出服务器上所有的数据库，包括(4个)系统数据库。你创建数据库，都会出现在这个列表中。
- use 数据库名; --指定某个数据库为当前工作数据库，在后面的实验中，你第一件要作的事，就是把实验数据库设置为当前数据库；
- show tables;  --列出当前数据库中所有的表。 
- create table ...;  --建表。
- insert,delete,update,select等命令。
- quit -- 退出mysql命令行环境（）

注意，MySQL所有的语句都以分号结束，语句可以分多行书写, MySQL会一直等到分号出现才开始执行你的命令(use、quit语句是例外，可以省略分号)！

SQL语句调试运行正确后，可以直接COPY语句到代码文件，提交代码，开始评测。

开始你的实验吧！

