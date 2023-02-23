---
title: Python使用多核心进行并行计算
date: 2023-02-23T07:50:43.904Z
summary: Python中的多核心技术能够实现循环的并行计算，从而提高代码运行效率。
draft: false
featured: false
image:
  filename: featured.png
  focal_point: Smart
  preview_only: false
---
Python中的并行计算可用多线程和多核心两种技术实现。多线程技术在同一时间依旧只能运行一个线程，只是节约了每个线程的读写时间，未必能显著提升程序，因此更能充分发挥当代计算机性能的通常是后者。

## 一、调用multiprocessing模块

使用`import multiprocessing`调用multiprocessing模块。

## 二、定义池Pool

使用`pool = multiprocessing.Pool(processes = n)`定义一个池用于自动分配循环变量，其中processes参数表示调用的核心数量，这取决于计算机本身，缺省默认调用全部核心。

## 三、运行池Pool

使用pool对象对`map()`函数进行循环`res = pool.map(FUN, X)`。

## 四、传输数据

使用共享内存`multiprocessing.Value()`可在核之间传输数据：`v = multiprocessing.Value('DATA_TYPE', X)`。

## 五、保护进程数据

使用锁模块`multiprocessing.Lock()`可以保护进程中的数据。

```python
lock = multiprocessing.Lock()
lock.acquire()
lock.release()
```

## 六、效率测试

使用一个简单例子进行测试，输出for方法和并行计算的效率：

```python
import multiprocessing
import time

def work(m):
    m += 100
    m -= 100
    m *= 100
    m /= 100

if __name__=='__main__':
    m = [10]*100000000

    timetime_start = time.time()
    for n in m:
        work(n)
    time_end = time.time()
    print(f'for method: {time_end - timetime_start}')

    pool = multiprocessing.Pool(processes=6)
    timetime_start = time.time()
    res = pool.map(work, m)
    time_end = time.time()
    print(f'multiprocessing method: {time_end - timetime_start}')
```

输出结果如下：

```
for method: 11.149296998977661
multiprocessing method: 3.7635178565979004
```

可见并行计算仅使用6个核心，就能达到原来约3倍的效率。