library(dplyr)

# inner_join
student <- data.frame(
  name = c("张三", "李四", "王五", "马六"),
  score = c(65, 70, 61, 98))

class <- data.frame(
  name = c("张三", "王五", "马六", "小明"),
  grade = c("三年级", "二年级", "四年级", "四年级"))

inner_join(student, class, by = "name")

# left_join
student <- data.frame(
  name = c("张三", "李四", "王五", "马六"),
  score = c(65, 70, 61, 98))

class <- data.frame(
  name = c("张三", "王五", "马六", "小明"),
  grade = c("三年级", "二年级", "四年级", "四年级"))

left_join(student, class, by = "name", keep = TRUE)

# right_join
student <- data.frame(
  name1 = c("张三", "李四", "王五", "马六"),
  score = c(65, 70, 61, 98))

class <- data.frame(
  name2 = c("张三", "王五", "马六", "小明"),
  grade = c("三年级", "二年级", "四年级", "四年级"))

right_join(student, class, by = c("name1" = "name2"))

# full_join
student <- data.frame(
  name = c("张三", "李四", "王五", "马六"),
  sex = c("男", "男", "女", "男"),
  score = c(65, 70, 61, 98))

class <- data.frame(
  name = c("张三", "王五", "马六", "小明"),
  sex = c("男", "男", "男", "女"),
  grade = c("三年级", "二年级", "四年级", "四年级"))

full_join(student, class, by = c("name", "sex"))

# anti_join
student <- data.frame(
  name1 = c("张三", "李四", "王五", "马六"),
  sex1 = c("男", "男", "女", "男"),
  score = c(65, 70, 61, 98))

class <- data.frame(
  name2 = c("张三", "王五", "马六", "小明"),
  sex2 = c("男", "男", "男", "女"),
  grade = c("三年级", "二年级", "四年级", "四年级"))

anti_join(student, class, keep = True,
          by = c("name1" = "name2","sex1" = "sex2"))
