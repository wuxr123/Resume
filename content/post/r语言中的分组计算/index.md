---
title: R语言中的分组计算
date: 2023-01-09T14:44:26.425Z
summary: 分组计算是科研中处理表格时最常见的问题之一，使用R语言的aggregate()函数可以非常灵活地进行简单分组计算、交叉分组计算和调用自定义函数。
draft: false
featured: false
image:
  filename: feature.jpg
  focal_point: Smart
  preview_only: false
---
# 一、aggregate()函数

分组计算问题在R语言中有多种处理办法，包括`tapply()`、`group_by()`和`aggregate()`等，其中`aggregate()`是最为出色、灵活和常用的函数。

首先查看`aggregate()`的基本格式：

```r
aggregate(x,                # x是需要被分组计算的值列
          by,               # by是分组的依据列，是一个list对象
          FUN,              # FUN是分组计算使用的统计函数名
          ...,
          simplify = TRUE,  # simplify设置结果是否需要简化
          drop = TRUE)      # drop设置是否去除未被使用的列
```

&nbsp;

# 二、简单分组计算

InsectSprays是R语言的自带数据集，记录了不同杀虫剂使用后的虫子数量，使用`head(InsectSprays)`可以快速浏览数据格式：


```r
> head(InsectSprays)
  count spray
1    10     A
2     7     A
3    20     A
4    14     A
5    14     A
6    12     A
```



如果我们希望评估不同杀虫剂的有效性，就需要计算每种杀虫剂样本的统计值。以下代码实现了计算各种杀虫剂的平均效力。代码中，`InsectSprays$count`是虫子数量列，是要被分组的值列；by需要一个list对象，list内的要素格式为“结果的分组条件列名 = 表中的分组条件列名”，前后列名可以不一致；FUN选择了最普通的均值函数，可以根据需要替换为max, min, median等甚至是自定义的函数，但注意不要添加"()"。

```r
> result <- aggregate(x = InsectSprays$count,
+                     by = list(spray = InsectSprays$spray),
+                     FUN = mean)
> result
  spray         x
1     A 14.500000
2     B 15.333333
3     C  2.083333
4     D  4.916667
5     E  3.500000
6     F 16.666667
```





&nbsp;

# 三、交叉分组计算

warpbreaks是R语言的自带数据集，记录了织布机的异常数据，使用`head(warpbreaks)`进行可以快速浏览数据格式：


```r
> head(warpbreaks)
  breaks wool tension
1     26    A       L
2     30    A       L
3     54    A       L
4     25    A       L
5     70    A       L
6     52    A       L
```



当分组条件为多个时，只需要在by属性的list对象内添加多个分组信息。

```r
> result <- aggregate(warpbreaks$breaks,
+                     by = list(wool = warpbreaks$wool,
+                               tension = warpbreaks$tension),
+                     FUN = median)
> result
  wool tension  x
1    A       L 51
2    B       L 29
3    A       M 21
4    B       M 28
5    A       H 24
6    B       H 17
```



&nbsp;

# 四、自定义函数分组计算

由于`aggregate()`函数中FUN属性是不限制函数（能正常使用的前提下）的，因此可以编写自身需要的自定义函数。如以下代码定义了返回标准差与均值的比值，即变异系数。

```r
cv <- function(vector){
  sd(vector)/mean(vector)
}
```

只需要在FUN中调用cv即可计算每个分组的变异系数，继续使用前一个例子的数据。

```r
> result <- aggregate(warpbreaks$breaks,
+                     by = list(wool = warpbreaks$wool,
+                               tension = warpbreaks$tension),
+                     FUN = cv)
> result
  wool tension         x
1    A       L 0.4061834
2    B       L 0.3493249
3    A       M 0.3608439
4    B       M 0.3277194
5    A       H 0.4183441
6    B       H 0.2605903
```




