library(reshape2)
library(ggplot2)

# melt
head(iris)
data <- iris
data$Index <- 1:nrow(data)
data_long <- melt(data = data, 
                  id.vars = c("Species","Index"))
head(data_long)

# plot1
ggplot(data = data_long,
       mapping = aes(x = variable, y = value, color = Species))+
  geom_boxplot()+
  theme_bw()+
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        legend.position = c(0.88,0.82))

# dcast
data_wide <- dcast(data = data_long,
                   formula = Index + Species ~ variable,
                   value.var = "value",
                   fun.aggregate = NULL)
head(data_wide)

# plot2
ggplot(data = data_wide,
       mapping = aes(x = Sepal.Length,
                     y = Sepal.Width,
                     size = Petal.Length,
                     color = Petal.Width))+
  geom_point(alpha = 0.8)+
  facet_wrap(Species~., nrow = 3)+
  scale_size_continuous(range = c(2,5))+
  scale_color_gradient2(low = "blue",
                        mid = "yellow",
                        high = "red",
                        midpoint = mean(data_wide$Petal.Width))
