---
title: R语言使用并行计算提高循环效率
date: 2023-01-14T15:58:48.717Z
summary: 循环几乎是科研计算程序中必不可少的结构，并行计算可以让计算复杂度高的循环更高效地完成。
draft: false
featured: false
image:
  filename: feature.jpg
  focal_point: Smart
  preview_only: false
---
[点击下载本文全部代码](R语言使用并行计算提高循环效率_代码_.R)

在常规的科研计算程序中，循环几乎是必不可少的结构。处理轻量数据时，for循环方便和迅速，但当计算复杂度较高时，在单线程逐一遍历的for循环常常需要耗费大量时间。

并行计算可以充分发挥计算机的多核心与多线程特性，让循环更高效地完成。最常见的两种并行方式是（1）**parallel**包和（2）**doparallel**包与**foreach**包的组合。

本文使用一个例子演示两种并行的使用方法以及它们与for循环的效率差异。

&nbsp;

# 一、测试内容

使用以下代码创建一个函数`test_fun(x)`，作用是内部循环1,000,000次，每次创建一个包含x个1的向量，并对这个向量依次乘以100，除以100，加上100和减去100。

同时定义函数运行次数`test_n = 20`。

```r
test_fun <- function(x){
  for(i in 1:1000000){
    v = rep(1,x)
    v = v * 100 / 100 + 100 - 100
  }
}
test_n = 20
```

&nbsp;

# 二、for循环

第一种方法，直接使用for函数循环20次`test_fun()`，并输出耗费时间。

```r
> start <- Sys.time()
> for(i in 1:test_n){
+   test_fun(100)
+ }
> end <- Sys.time()
> print(end - start)
Time difference of 22.32324 secs
```

&nbsp;

# 三、parallel包

并行计算的使用有一个固定的模式。

## 1. 加载并行包

parallel是R自带的包，不需要安装。

```r
library(parallel)
```

## 2. 装载线程

线程并非越多越好，当一次循环所占用的内存较高时，需要保证多个线程同时运行不会让系统内存溢出，**否则会出现不可预料的结果**。

并行时对于内存中的对象会拷贝多份，在`makeCluster()`函数中设置`type="FORK"`，可以让多个线程共享内存，降低内存占用。

```r
cl_num <- detectCores() # 检测本机的可用线程数量
cl <- makeCluster(cl_num) # 设置需要启动的线程数量
```

## 3. 传入变量和包

本例子没有额外的变量和包，因此不需要传入。

```r
clusterExport(cl, c("变量1", "变量2", "函数1"))
clusterEvalQ(cl, library(dplyr))
```

## 4. 并行计算

主要的函数有`parApply(X, MARGIN, FUN, …)`，`parLapply(cl, X, FUN, …)`和`parSapply(cl, X, FUN, ...)`，作用与apply族的`apply()`，`lapply()`和`sapply()`相对应。

本例子不需要任何输出，就选择了`parSapply()`。cl为创建好的线程组，X为循环的变量，FUN为函数名。

parallel包循环的弊端是只能进行单变量循环。

```r
result <- parSapply(cl = cl,
                    X = rep(100,test_n),
                    FUN = test_fun)
```

## 5. 释放线程

结束后务必记得释放线程，否则占用状态会造成资源浪费和其他错误。

```r
stopCluster(cl)
```

最后完整运行一次程序观察效率的提高效果。

```r
> library(parallel)
> 
> cl_num <- detectCores() 
> cl <- makeCluster(cl_num)
> 
> # clusterExport(cl, c("f10"))
> # clusterEvalQ(cl, library(dplyr))
> 
> start <- Sys.time()
> result <- parSapply(cl = cl,
+                     X = rep(100,test_n),
+                     FUN = test_fun)
> end <- Sys.time()
> print(end - start)
Time difference of 8.583297 secs
```

&nbsp;

# 四、doparallel+foreach包

这种方法的运作模式除启动函数外，与parallel包是相同的。

`foreach()`函数用于循环变量：使用自定义的变量名定义需要循环的内容，可以同时循环多个变量；`.export`属性用于传入变量，`.packages`属性用于传入包；`%dopar%`将变量传给循环函数`test_fun(x)`。

```r
result <- foreach(x = rep(100,test_n),
                  .export = NULL,
                  .packages = NULL) %dopar% test_fun(x)
```

完整运行查看计算花费的时间。

```r
> library(doParallel)
> library(foreach)
> 
> cl_num <- detectCores()
> cl <- makeCluster(cl_num)
> 
> start <- Sys.time()
> result <- foreach(x = rep(100,test_n,),
+                   .export = NULL,
+                   .packages = NULL) %dopar% test_fun(x)
> end <- Sys.time()
> print(end - start)
Time difference of 9.902606 secs
```

&nbsp;

# 五、总结

从多次测试的结果来看，计算效率parallel包 > doparallel+foreach包 > for循环。
