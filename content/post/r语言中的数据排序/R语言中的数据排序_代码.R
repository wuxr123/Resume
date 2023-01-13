# sort
v <- c(3,2,5,7,1)
sort(v)
sort(v, decreasing = T)

# order
v <- c(3,2,5,7,1)
order(v)
order(v, decreasing = T)

df <- data.frame(x=c(3,2,5,7,1,3),
                y=c(7,6,4,9,3,2))
df[order(df$x,df$y),]

# rank
v <- c(3,2,5,7,1)
rank(v)
rev(rank(v))

# arrange
library(dplyr)
df <- data.frame(x=c(3,2,5,7,1,3),
                y=c(7,6,4,9,3,2))
arrange(mtcars, cyl, desc(disp))
