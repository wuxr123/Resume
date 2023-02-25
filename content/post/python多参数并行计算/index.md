---
title: Python多参数并行计算
date: 2023-02-25T01:47:44.609Z
summary: Python并行计算需要输入多个参数的几种情况及解决方案。
draft: false
featured: false
image:
  filename: featured.png
  focal_point: Smart
  preview_only: false
---
Python使用multiprocessing模块可以实现多核并行计算显著提高重复性for循环的运行效率（实现方法可见[Python使用多核心进行并行计算 | Xiaoran Wu](https://www.wuxiaoran.top/post/python%E4%BD%BF%E7%94%A8%E5%A4%9A%E6%A0%B8%E5%BF%83%E8%BF%9B%E8%A1%8C%E5%B9%B6%E8%A1%8C%E8%AE%A1%E7%AE%97/)），但传统方法并行时只能接收一个参数。本文展示了需要输入多个参数的几种情况及解决方案。

---

以下是一个简单的并行计算例子：

```python
import multiprocessing

def workfun(m):
    return m

if __name__=='__main__':
    m = range(10)
    pool = multiprocessing.Pool(processes=2)
    res = pool.map(workfun, m)
    print(res)
```

其中`workfun()`函数是需要并行的函数，此时只有一个输入参数`m`。若定义一个新的`workfun()`为：

```python
def workfun(x, y, z):
    return x + y + z
```

由于`pool.map()`函数只能同时传入一个参数，因此无法对新的`workfun()`函数进行并行计算。对于输入的参数值为固定或非固定的几种情况有不同的处理方案。

### 一、只有一个参数为非固定值

若`x`是非固定的，`y`与`z`均传入一个定值，可以使用partial模块修饰原函数，其作用是复刻原函数，同时指定其中部分输入参数的值。

```python
import multiprocessing
from functools import partial

def workfun(x, y, z):
    return x + y + z

if __name__=='__main__':
    x = y = z = range(10)
    partial_work = partial(workfun, y=1, z=2)
    pool = multiprocessing.Pool(processes=2)
    res = pool.map(partial_work, x)
    print(res)
```

### 二、有多个参数为非固定值

若`x`, `y`与`z`均为非固定的，有两种方法可以解决。

##### 1. 将输入参数打包

当输入参数不多时，可以使用`zip()`函数将输入打包成一个成参数，并在`workfun()`函数中解包后继续计算。

```pyhton
import multiprocessing

def workfun(input):
    x, y, z = input
    return x + y + z

if __name__=='__main__':
    x = y = z = range(10)
    input = zip(x,y,z)
    pool = multiprocessing.Pool(processes=2)
    res = pool.map(workfun, input)
    print(res)
```

##### 2. 使用pathos模块并行计算

pathos.multiprocessing模块是multiprocessing模块的复刻和加强，模块下的ProcessingPool模块可以直接实现多变量的并行计算。

```python
from pathos.multiprocessing import ProcessingPool

def workfun(x, y, z):
    return x + y + z

if __name__=='__main__':
    x = y = z = range(10)
    pool = ProcessingPool(processes=2)
    res = pool.map(workfun, x, y, z)
    print(res)
```
