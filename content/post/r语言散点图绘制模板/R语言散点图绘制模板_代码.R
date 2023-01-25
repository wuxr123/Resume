# fig1
## library
library(ggplot2)

## plot
ggplot(data = iris,
       mapping = aes(x = Sepal.Length,
                     y = Sepal.Width,
                     color = Species))+
  geom_point(size = 0.7) +
  geom_smooth(formula = 'y ~ x',
              method = 'lm',
              se = F,
              linewidth = 0.7) +
  labs(y = "Sepal.Width (cm)",
       x = "Sepal.Length (cm)")+
  theme_bw() +
  theme(text = element_text(family="serif",
                            size = 7),
        panel.grid = element_blank(),
        legend.position = c(0.11, 0.9),
        legend.title = element_blank(),
        legend.box.spacing = unit(0, "cm"),
        legend.key.size = unit(10, "pt"),
        legend.background = element_blank(),
        axis.ticks = element_line(linewidth = 0.3),
        axis.text = element_text(color = "black"))

## save
ggsave("fig1.jpg",
       width = 9,
       height = 7,
       units = "cm",
       dpi = 600)


# fig2
## library
library(ggplot2)
library(ggpubr)

## read data
re <- read.csv("fig2.csv")
re$Station <- as.character(re$Station)

## plotfun
plotfun <- function(data, ylab, label){
  ggplot(data = data,
         mapping = aes(x = Station,
                       y = Values,
                       color = Method,
                       shape = Method)) +
    geom_point(size = 0.7) +
    scale_x_discrete(labels = c("Dashalong",
                                "Tuole",
                                "Yakou",
                                "Heihe_RS",
                                "Linze",
                                "Dingxin",
                                "Sidaoqiao")) +
    labs(x = "Station",
         y = ylab) +
    annotate("text",
             x = 0.7,
             y = max(data$Values)*0.99,
             label = label,
             family="serif",
             size = 2.5) +
    theme_bw() +
    theme(text = element_text(family="serif",
                              size = 7),
          panel.grid = element_blank(),
          legend.position = "bottom",
          legend.title = element_blank(),
          legend.key.size = unit(7, "pt"),
          legend.box.spacing = unit(0, "cm"),
          axis.ticks = element_line(linewidth=0.3),
          axis.text = element_text(color = "black"))
}

## plot
a <- plotfun(re[re$Metric=="CC",], "CC", "(a)")
b <- plotfun(re[re$Metric=="MAE",], "MAE (mm)", "(b)")
c <- plotfun(re[re$Metric=="RMSE",], "RMSE (mm)", "(c)")
d <- plotfun(re[re$Metric=="POD",], "POD", "(d)")
e <- plotfun(re[re$Metric=="FAR",], "FAR", "(e)")
f <- plotfun(re[re$Metric=="CSI",], "CSI", "(f)")

ggarrange(a,b,c,d,e,f,
          ncol = 2,
          nrow = 3,
          align = "hv",
          common.legend = T,
          legend = "bottom")

## save
ggsave("fig2.jpg",
       width = 14,
       height = 12,
       units = "cm",
       dpi = 600)