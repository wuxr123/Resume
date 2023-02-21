---
title: 超算系统使用指南
date: 2023-02-21T13:05:53.038Z
summary: 本文介绍了Linux对于目录和文件的管理命令，vi/vim编辑器的使用，module模块的相关命令和slurm的任务处理命令。
draft: false
featured: false
image:
  filename: featured.jpg
  focal_point: Smart
  preview_only: false
---
使用超算集群一般需要掌握Linux对于目录和文件的管理命令，vi/vim编辑器的使用，module模块的相关命令和slurm的任务处理命令。

&nbsp;

# 一、Linux基本命令

## 目录管理

1. 列出子目录：`ls DIR_NAME`

2. 进入目录：`cd DIR_NAME`

3. 进入根目录：`cd`

4. 进入上级目录：`cd ..`

5. 返回目录：`cd -`

6. 显示所在目录：`pwd`

7. 创建目录：`mkdir DIR_NAME`

8. 删除空目录：`rmdir DIR_NAME`

9. 删除非空目录：`rm -r DIR_NAME`

10. 复制目录：`cp -r DIR_NAME_FROM DIR_NAME_TO`

11. 移动目录：`mv DIR_NAME_FROM DIR_NAME_TO`

## 文件管理

1. 正序打印文件：`cat FILE_NAME`

2. 逆序打印文件：`tac FILE_NAME`

3. 打印文件同时打印行号：`nl FILE_NAME`

4. 逐页打印文件：`more FILE_NAME`，使用`space`或`enter`翻页，`q`键退出

5. 单独查看文件：`less FILE_NAME`，指针向下翻页，`q`键退出

6. 打印文件头/尾几行：`head/tail FILE_NAME`

7. 删除文件：`rm FILE_NAME`

8. 同目录复制文件：`cp FILE_NAME FILE_NAME`

9. 不同目录复制文件：`cp FILE_NAME DIR_NAME`

10. 移动文件：`mv FILE_NAME DIR_NAME`

## 其他命令

1. 终端清屏：`clear`

2. 将dos文件转换为unix格式：`dos2unix SHELL_NAME.sh`

&nbsp;

# 二、vi/vim编辑器

编辑文件：`vi FILE_NAME`

## 命令模式

1. 进入输入模式：`i`

2. 删除光标处字符：`x`

3. 进入底线命令模式：`:`

4. 保存后离开：`ZZ`

## 输入模式

1. 进入命令模式：`ESC`键

## 底线命令模式

1. 进入命令模式：`ESC`键

2. 保存文件：`:w`

3. 保存文件：`:w!`

4. 退出程序：`:q`

5. 强制关闭：`:q!`

6. 保存并关闭：`:wq`

7. 强制保存并关闭：`:wq!`

&nbsp;

# 三、module相关命令

1. 调用module命令：`source /public1/soft/modules/module.sh`

2. 查看MODULE_NAME的所有可用版本，缺省则列出所有可用的module：`module avail/av MODULE_NAME`

3. 加载特定版本软件：`module load/add MODUL_NAME`

4. 卸载特定版本软件：`module unload/rm MODULE_NAME`

5. 查看已加载的软件：`module list/li`

6. 卸载全部已加载的软件：`module purge`

7. 查看module配置文件、环境变量：`module show MODULE_NAME`

&nbsp;

# 四、slurm相关命令

1. 显示系统资源使用情况：`sinfo`

2. 显示节点NODE_ID的使用情况：`sinfo -n NODE_ID`

3. 查看账号提交的作业：`squeue`

4. 查看JOB_ID号作业的信息：`squeue -j JOB_ID`

5. 后台提交作业：`sbatch FILE_NAME`

6. 交互式提交作业：`srun`

7. 分配模式提交作业：`salloc -p PARTITION`

8. 取消JOB_ID号作业：`scancel JOB_ID`

9. 查看JOB_ID号（正在运行）作业信息：`scontrol show job JOB_ID`

10. 查看JOB_ID号（历史）作业信息，缺省为全部历史作业：`sacct -j JOB_ID`

&nbsp;

# 五、作业提交模板

## 文件头

```
#!/bin/bash
#SBATCH -J test 指定作业名称
#SBATCH -p PARTITION 指定队列名称
#SBATCH -t 20 限制作业运行时间（分钟）
#SBATCH -o out.log 指定标准输出文件名
#SBATCH -e err.log 指定错误输出文件名
#SBATCH -N 1 指定要提交的节点数量
#SBATCH -n 1 指定要提交的进程数
#SBATCH -c 10 指定每个进程的CPU核数（未指定为1）
#SBATCH --mem=40G 作业所需的每个节点的实内存量
```

## 提交R作业

```
source /public1/soft/modules/module.sh
module load R
Rscript program.R
```

## 提交Python作业

```
source /public1/soft/modules/module.sh
module load anaconda
python program.py
```

## 调用第三方R包/Python模块

1. 下载R/python模块的压缩包

2. 安装R包/python模块
   
   ```
   # R（在R文件中）
   install.packages("xxx.tgz", repo=NULL, type="source", lib="/your/path/")
   
   # Python（在命令行）
   pip install xxx.zip --target=/your/path
   ```

3. 添加R包/python模块路径（临时）
   
   ```
   # R（在R文件中）
   .libPaths("/public1/home/sch5187/Documents/test1")
   
   # Python（在命令行）
   export PYTHONPATH=$PYTHONPATH:/public1/home/sch5187/Documents/test1
   ```

## 同时提交多个作业

1. 在普通的作业提交脚本中，将R/Python文件名改为`$1`
   
   ```
   #!/bin/bash
   #SBATCH -J MLE_cs
   #SBATCH -p v3_64
   #SBATCH -N 1
   #SBATCH -n 1
   #SBATCH -c 4
   #SBATCH --mem=60G
   
   source /public1/soft/modules/module.sh 
   module load mpi/intel/17.0.7  gcc/8.3.0
   export PATH=/public1/home/sc32042/software/R-install/bin:$PATH
   srun Rscript $1
   ```

2. 在命令行使用`sbatch xxxx.sh xxxx.R`提交多次

3. 若次数很多，可以重新将sbatch命令写入sh脚本进行一键提交
