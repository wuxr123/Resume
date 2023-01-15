---
title: R语言ggplot2包的颜色设置
date: 2023-01-15T15:15:57.806Z
summary: R语言中的ggplot2包有丰富的配色函数，本文展示了可用于离散型变量、连续型变量、时间型变量的全部配色设置函数。
draft: false
featured: false
image:
  filename: feature.jpg
  focal_point: Smart
  preview_only: false
---
[点击下载本文全部代码](R语言ggplot2包的颜色设置_代码.R)

ggplot2是R语言中最著名的数据可视化绘图包之一，是一个具有高自由度的绘图工具。在使用不同颜色表达变量中不同的类型或值时，ggplot2配置了多种颜色设置函数。本文以图形的fill属性为例（color属性同）展示了全部的颜色设置函数。

# 一、数据准备

使用了R自带的数据，state.name和state.area分别是美国50个州的名称和面积。将两个向量并成表格后取面积最小的8个州作为样例数据。

```r
data <- data.frame(state = state.name,
                   area = state.area)
data <- dplyr::arrange(data, area)
data <- head(data, 8)
```

&nbsp;

# 二、图形绘制

使用`ggplot()`函数，绘制两张柱状图，分别以名称（离散型）和面积（连续型）作为颜色填充变量。

```r
library(ggplot2)

p1 <- ggplot(data = data,
            mapping = aes(x = state,
                          y = area,
                          fill = state)) +
        geom_col()

p2 <- ggplot(data = data,
            mapping = aes(x = state,
                          y = area,
                          fill = area)) +
        geom_col()
```

&nbsp;

# 二、颜色设置函数

ggplot2的颜色设置函数按作用可分为四类，分别可用于离散型变量、连续型变量、日期型变量和日期时间型变量。

## 1. 离散型变量

`scale_fill_brewer()`函数可以调用调色板中的配色方案，将palette属性设置为方案名称即可，direction参数设置色带方向，1为正，-1为反。

使用`RColorBrewer::display.brewer.all()`函数可以可视化调色板中的所有配色方案。

```r
RColorBrewer::display.brewer.all()
p1 + scale_fill_brewer(palette = "Set3",
                       direction = -1)
```

`scale_fill_grey()`是使用不同灰度进行配色，start和end属性分别设置黑白的边界值，0为纯白，1为纯黑。

```r
p1 + scale_fill_grey(start = 0.2, end = 0.8)
```

`scale_fill_manual()`函数是完全自定义颜色，需要自行配色。

```r
colors = as.character(palette.colors(8))
p1 + scale_fill_manual(values = colors)
```

`scale_fill_viridis_d()`函数将viridis色带分为数个离散颜色，begin和end参数分别控制起止的色带位置，direction参数设置色带方向，1为正，-1为反。

```r
p1 + scale_fill_viridis_d(begin = 0,
                          end = 1,
                          direction = -1)
```

`scale_fill_discrete()`用于离散型颜色的设置，type参数设置使用的颜色向量。

```r
colors = as.character(palette.colors(8))
p1 + scale_fill_discrete(type = colors)
```

`scale_fill_identity()`直接使用变量的值来表示颜色，若变量的值不能代表颜色，则会出错。这里为data数据集增加了一个表示颜色的color字段。

```r
data$color = terrain.colors(8)
ggplot(data = data,
             mapping = aes(x = state,
                           y = area,
                           fill = color)) +
  geom_col() + 
  scale_fill_identity()
```

`scale_fill_ordinal()`默认使用viridis色带绘制离散型变量，type属性可以设置其他配色方案。

```r
colors = as.character(palette.colors(8))
p1 + scale_fill_ordinal(type = colors)
```

## 2. 连续型变量

`scale_fill_gradient()`函数使用low与high属性创建渐变色带。

```r
p2 + scale_fill_gradient(low = "red",
                         high = "green")
```

`scale_fill_gradient2()`函数使用low, mid与high属性创建二次渐变色，其中midpoint参数控制mid颜色的值。

```r
p2 + scale_fill_gradient2(low = "green",
                          mid = "yellow",
                          high = "red",
                          midpoint = 5000)")
```

`scale_fill_gradientn()`函数将一组离散的颜色转为渐变色，colours属性输入一组离散的颜色。

```r
p2 + scale_fill_gradientn(colours = terrain.colors(8)))
```

`scale_fill_distiller()`函数可以将调色板中的配色方案应用在连续变量上，palette参数设置配色方案名称，direction参数设置色带方向，1为正，-1为反。

```r
p2 + scale_fill_distiller(palette = "Set3",
                          direction = -1)
```

`scale_fill_steps()`使用low与high属性创建渐变色，并切分为数个离散颜色，n.breaks属性可设置离散颜色的个数。

```r
p2 + scale_fill_steps(low = "blue",
                      high = "red",
                      n.breaks = 10)
```

`scale_fill_steps2()`使用low, mid与high属性创建二次渐变色，并切分为数个离散颜色，n.breaks属性可设置离散颜色的个数，midpoint属性设置mid颜色的对应值。

```r
p2 + scale_fill_steps2(low = "blue",
                       high = "red",
                       mid = "yellow",
                       midpoint = 5000,
                       n.breaks = 10)
```

`scale_fill_stepsn()`函数将一组自定义的离散的颜色转为多次渐变色，再分为数个离散的颜色，n.breaks属性可设置离散颜色的个数。

```r
colors = as.character(palette.colors(3))
p2 + scale_fill_stepsn(colours = colors,
                       n.breaks = 10)
```

`scale_fill_fermenter()`函数使用调色板进行颜色分阶，direction参数设置色带方向，1为正，-1为反。

```r
p2 + scale_fill_fermenter(palette = "Set3",
                          direction = -1)
```

`scale_fill_viridis_c()`函数对连续型变量使用，将viridis色带分为数个离散颜色，begin和end参数分别控制起止的色带位置，direction参数设置色带方向，1为正，-1为反。

```r
p2 + scale_fill_viridis_c(begin = 0,
                          end = 1,
                          direction = -1)
```

`scale_fill_viridis_b()`函数将连续型变量分箱后，赋予viridis色带的离散化颜色，begin和end参数分别控制起止的色带位置，n.breaks属性控制分箱数量，direction参数设置色带方向，1为正，-1为反。

```r
p2 + scale_fill_viridis_b(begin = 0,
                          end = 1,
                          direction = -1,
                          n.breaks = 10)
```

`scale_fill_continuous()`函数用于连续性变量的颜色设置，type属性设置渐变颜方案。

```r
p2 + scale_fill_continuous(type = "viridis")
```

`scale_fill_hue()`函数通过改变色相（h）饱和度（c）亮度（l）来调整颜色，direction参数设置色带方向，1为正，-1为反。

```r
p1 + scale_fill_hue(h = c(0,100),
                    l = 200,
                    c = 100,
                    direction = -1)
```

scale_fill_binned()函数用于连续型变量的分箱显示，type参数控制色带，n.breaks参数控制分箱数量。

```r
p2 + scale_fill_binned(type = "viridis",
                       n.breaks = 10)
```

## 3. 日期型变量

scale_fill_date()函数用low与high参数创建日期型变量的渐变色带。

```r
data <- airquality
data$Date <- as.Date(paste("1973",
                           data$Month,
                           data$Day,
                           sep = "-"))
ggplot(data = data,
       mapping = aes(x = Date,
                     y = Temp,
                     fill = Date)) +
  geom_col() +
  scale_fill_date(low = "green",
                  high = "red")
```

## 4. 日期时间型变量

`scale_fill_datetime()`函数用用low与high参数创建日期时间型变量的渐变色带。

```r
data <- head(beaver1, 50)
data$time <- as.POSIXct("2000-1-1 00:00") +
                data$time * 60
data$no <- 1:nrow(data)
ggplot(data = data,
       mapping = aes(x = no,
                     y = temp,
                     fill = time)) +
  geom_col() +
  scale_fill_datetime(low = "green",
                      high = "red")
```
