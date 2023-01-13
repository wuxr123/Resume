---
title: R语言中的表连接
date: 2023-01-13T15:13:14.759Z
summary: 在科研中，常常需要将两个表根据某个/些字段进行连接，R的dplyr包内有一套完整的join系列函数解决各类连接问题。
draft: false
featured: false
image:
  filename: feature.jpg
  focal_point: Smart
  preview_only: false
---
# 一、表连接

在科研中，常常需要将两个表根据某个/些字段进行连接（如将气象站点的坐标与站点的降水值进行连接）。在R中有许多函数可以实现这一功能，如`merge()`和`setkey()`等，其中dplyr包有一套完整的join系列函数，因此更便于学习。

首先需要明确以下几种连接的含义，x与y分别为需要连接的两个表：

- 内连接：仅保留x与y中相匹配的观测

- 左连接：保留x中所有观测，y中保留匹配的观测

- 右连接：保留y中所有观测，x中保留匹配的观测

- 全连接：x和y中所有观测都保留

- 反连接：仅保留x与y中不匹配的观测
  
  &nbsp;

# 二、dplyr包中的表连接函数

dplyr包主要包括以下几个join函数：

- inner_join(x, y, by  ...)

- left_join(x, y, by  ...)

- right_join(x, y, by  ...)

- full_join(x, y, by ...)

- anti_join(x, y, by ...)

&nbsp;

# 三、实践应用

以下代码逐一介绍了不同join函数的用法，同时条件各不相同。

## 1. inner_join()

所有join系列函数中，x与y分别为两个表，by属性设置用于连接的字段。

```r
> library(dplyr)
> 
> student <- data.frame(
+   name = c("张三", "李四", "王五", "马六"),
+   score = c(65, 70, 61, 98))
> 
> class <- data.frame(
+   name = c("张三", "王五", "马六", "小明"),
+   grade = c("三年级", "二年级", "四年级", "四年级"))
> 
> inner_join(student, class, by = "name")
  name score  grade
1 张三    65 三年级
2 王五    61 二年级
3 马六    98 四年级
```

## 2. left_join()

需要保留用于连接的两个字段，使用`keep  = TURE`。

```r
> library(dplyr)
> 
> student <- data.frame(
+   name = c("张三", "李四", "王五", "马六"),
+   score = c(65, 70, 61, 98))
> 
> class <- data.frame(
+   name = c("张三", "王五", "马六", "小明"),
+   grade = c("三年级", "二年级", "四年级", "四年级"))
> 
> left_join(student, class, by = "name", keep = TRUE)
  name.x score name.y  grade
1   张三    65   张三 三年级
2   李四    70   <NA>   <NA>
3   王五    61   王五 二年级
4   马六    98   马六 四年级
```

## 3. right_join()

两个表中用于连接的字段名有差异，使用`by = c("x字段名" = "y字段名")`连接。

```r
> library(dplyr)
> 
> student <- data.frame(
+   name1 = c("张三", "李四", "王五", "马六"),
+   score = c(65, 70, 61, 98))
> 
> class <- data.frame(
+   name2 = c("张三", "王五", "马六", "小明"),
+   grade = c("三年级", "二年级", "四年级", "四年级"))
> 
> right_join(student, class, by = c("name1" = "name2"))
  name1 score  grade
1  张三    65 三年级
2  王五    61 二年级
3  马六    98 四年级
4  小明    NA 四年级
```

## 4. full_join()

有多个连接字段时，by属性使用一个包含字段名的向量对象。

```r
> library(dplyr)
> 
> student <- data.frame(
+   name = c("张三", "李四", "王五", "马六"),
+   sex = c("男", "男", "女", "男"),
+   score = c(65, 70, 61, 98))
> 
> class <- data.frame(
+   name = c("张三", "王五", "马六", "小明"),
+   sex = c("男", "男", "男", "女"),
+   grade = c("三年级", "二年级", "四年级", "四年级"))
> 
> full_join(student, class, by = c("name", "sex"))
  name sex score  grade
1 张三  男    65 三年级
2 李四  男    70   <NA>
3 王五  女    61   <NA>
4 马六  男    98 四年级
5 王五  男    NA 二年级
6 小明  女    NA 四年级
```

## 5. anti_join()

最后是同时需要两个字段连接，且字段名均不同的情况。

```r
> library(dplyr)
> 
> student <- data.frame(
+   name1 = c("张三", "李四", "王五", "马六"),
+   sex1 = c("男", "男", "女", "男"),
+   score = c(65, 70, 61, 98))
> 
> class <- data.frame(
+   name2 = c("张三", "王五", "马六", "小明"),
+   sex2 = c("男", "男", "男", "女"),
+   grade = c("三年级", "二年级", "四年级", "四年级"))
> 
> anti_join(student, class, keep = True,
+            by = c("name1" = "name2","sex1" = "sex2"))
  name1 sex1 score
1  李四   男    70
2  王五   女    61
```


