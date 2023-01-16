library(ggplot2)

p <- ggplot(data = iris,
            mapping = aes(x = Sepal.Length,
                          y = Sepal.Width,
                          color = Species)) +
  geom_point() +
  theme_bw() +
  ggtitle("不同种类鸢尾花萼片长度与宽度的关系")
p

ggsave("pic1.jpg", width = 5, height = 3, dpi = 600)

# pic2
library(showtext)
font_add("Kaiti", "C:/Windows/Fonts/simkai.ttf")
showtext_auto()

p + theme(plot.title = element_text(family = "Kaiti"))

ggsave("pic2.jpg", width = 5, height = 3, dpi = 600)

# pic3
p + theme(text = element_text(size = 65),
          plot.title = element_text(family = "Kaiti"),
          legend.spacing.x = unit(0, "pt"))

ggsave("pic3.jpg", width = 5, height = 3, dpi = 600)
