# 简单分组计算
head(InsectSprays)

result <- aggregate(x = InsectSprays$count,
                    by = list(spray = InsectSprays$spray),
                    FUN = mean)
result

# 交叉分组计算
head(warpbreaks)

result <- aggregate(warpbreaks$breaks,
                    by = list(wool = warpbreaks$wool,
                              tension = warpbreaks$tension),
                    FUN = median)
result

# 自定义函数分组计算
cv <- function(vector){
  sd(vector)/mean(vector)
}

result <- aggregate(warpbreaks$breaks,
                    by = list(wool = warpbreaks$wool,
                              tension = warpbreaks$tension),
                    FUN = cv)
result
