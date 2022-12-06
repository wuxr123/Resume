---
title: 如何使用Markdown提高笔记效率？
date: 2022-12-06T08:45:42.835Z
summary: Markdown是一种轻量级标记语言，它允许人们使用易读易写的纯文本格式编写文档。这种语言吸收了很多在电子邮件中已有的纯文本标记的特性。
draft: false
featured: false
categories:
  - Tutorial
image:
  filename: ""
  focal_point: Smart
  preview_only: false
---
## 1. 什么是Markdown？

Markdown是一种轻量级标记语言，它允许人们使用易读易写的纯文本格式编写文档。这种语言吸收了很多在电子邮件中已有的纯文本标记的特性。

由于Markdown的轻量化、易读易写特性，并且对于图片，图表、数学式都有支持，目前许多网站都广泛使用Markdown来撰写帮助文档或是用于论坛上发表消息。如GitHub、Reddit、Diaspora、Stack Exchange、OpenStreetMap 、SourceForge、简书等，甚至还能被用来撰写电子书。

更多关于Markdown的介绍请移步[Wikipedia](https://zh.wikipedia.org/wiki/Markdown)。

## 2. Markdown快速入门

### 2.1 标题

输入1-6个"#"加一个空格，接所需的文字来表示。

> # 这是一级标题
> 
> ## 这是二级标题
> 
> ### 这是三级标题

### 2.2 段落与换行

分段的两种方式：

    1）在文段末使用两个空格加回车；

    2）使用一个空行间隔两个段。

> 这是第一段
> 
> 这是第二段

### 2.3 字体效果

斜体用"\*这是斜体\*"表示，粗体用"\*\*这是粗体\*\*"表示，粗斜体使用"\*\*\*这是粗斜体\*\*\*"。

> *这是斜体*
> 
> **这是粗体**
> 
> ***这是粗斜体***

### 2.4 划线效果

删除线使用"这里有\~\~删除线\~\~"，下划线"这里有\<u\>下划线\</u\>"。（没错，Markdown支持部分html语言。）

> 这里有~~这里有删除线~~
> 
> 这里有<u>下划线</u>

还有一种特殊的划线是分隔行，使用"\*\*\*"，此行不添加任何其他文字和符号。

> ---

### 2.5 列表

markdown的列表包括无序列表与有序列表。

    无序列表使用"\* 列表项"表示：

> - 列表项1
>   
> - 列表项2

    有序列表用". "将数字和列表内容隔开：

> 1. 列表项1
>   
> 2. 列表项2

    嵌套列表需要在内容前加4个空格：

> 1. 一级列表1
>   
> 2. 一级列表2
>   
>     1. 二级列表1
>     
>        1. 三级列表1

### 2.6 区块

引用块"\> 这是引用块"
> > 这是引用块

"\`函数名称\`"
> `函数名称`


"\`\`\`python

代码在这里

a = 3

print(a)

\`\`\`"
> ```python
> 代码在这里
> a = 3
> print(a)
> ```


### 2.7 图片

图片的代码格式为"\!\[图片名称\]\(图片地址\)"：

> ![图片名称](https://static.runoob.com/images/runoob-logo.png)

可以为图片添加一个链接，则格式为"\[\!\[图片名称\]\(图片地址\)\]\(链接地址\)"，点击图片可进入网址https://www.runoob.com：

> [![图片名称](http://static.runoob.com/images/runoob-logo.png)](https://www.runobb.com)

### 2.8 链接

为文本添加链接可使用"\[显示名称\]\(链接地址\)"

> [百度](https://www.baidu.com)

## 3. Markdown编辑器推荐

我认为比较好用的Markdown编辑器是Mark Text，是一款MIT许可开源项目，是免费与多平台的，可从[这里](https://github.com/marktext/marktext)下载。