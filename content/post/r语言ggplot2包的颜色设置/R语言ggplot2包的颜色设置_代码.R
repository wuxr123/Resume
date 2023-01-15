library(ggplot2)

# 1. Data
data <- data.frame(state = state.name,
                   area = state.area)
data <- dplyr::arrange(data, area)
data <- head(data, 8)


# 2. Plot
p1 <- ggplot(data = data,
            mapping = aes(x = state,
                          y = area,
                          fill = state)) +
        geom_col()

p2 <- ggplot(data = data,
            mapping = aes(x = state,
                          y = area,
                          fill = area)) +
        geom_col()


# 3. Color set
## discrete variable
### scale_fill_brewer()
RColorBrewer::display.brewer.all()
p1 + scale_fill_brewer(palette = "Set3",
                       direction = -1)

### scale_fill_grey()
p1 + scale_fill_grey(start = 0.2, end = 0.8)

### scale_fill_manual()
colors = as.character(palette.colors(8))
p1 + scale_fill_manual(values = colors)

### scale_fill_viridis_d()
p1 + scale_fill_viridis_d(begin = 0,
                          end = 1,
                          direction = -1)

### scale_fill_discrete()
colors = as.character(palette.colors(8))
p1 + scale_fill_discrete(type = colors)

### scale_fill_identity()
data$color = terrain.colors(8)
ggplot(data = data,
       mapping = aes(x = state,
                     y = area,
                     fill = color)) +
  geom_col() + 
  scale_fill_identity()

### scale_fill_ordinal()
colors = as.character(palette.colors(8))
p1 + scale_fill_ordinal()


## continuous variable
### scale_fill_gradient()
p2 + scale_fill_gradient(low = "red", high = "green")

### scale_fill_gradient2()
p2 + scale_fill_gradient2(low = "green",
                       mid = "yellow",
                       high = "red",
                       midpoint = 5000)

### scale_fill_gradientn()
p2 + scale_fill_gradientn(colours = terrain.colors(8))

### scale_color_distiller()
p2 + scale_fill_distiller(palette = "Set3",
                          direction = -1)

### scale_fill_steps()
p2 + scale_fill_steps(low = "blue",
                      high = "red",
                      n.breaks = 10)

### scale_fill_steps2()
p2 + scale_fill_steps2(low = "blue",
                       high = "red",
                       mid = "yellow",
                       midpoint = 5000,
                       n.breaks = 10)

### scale_fill_stepsn()
colors = as.character(palette.colors(3))
p2 + scale_fill_stepsn(colours = colors,
                       n.breaks = 10)

### scale_fill_fermenter()
p2 + scale_fill_fermenter(palette = "Set3",
                          direction = -1)

### scale_fill_viridis_c()
p2 + scale_fill_viridis_c(begin = 0,
                          end = 1,
                          direction = -1)

### scale_fill_viridis_b()
p2 + scale_fill_viridis_b(begin = 0,
                          end = 1,
                          direction = -1,
                          n.breaks = 10)

### scale_fill_continuous()
p2 + scale_fill_continuous(type = "viridis")

### scale_fill_hue()
p1 + scale_fill_hue(h = c(0,100),
                    l = 200,
                    c = 100,
                    direction = -1)

### scale_fill_binned()
p2 + scale_fill_binned(type = "viridis",
                       n.breaks = 10)


## date varible
### scale_fill_date()
data <- airquality
data$Date <- as.Date(paste("1973",
                           data$Month,
                           data$Day,
                           sep = "-"))
ggplot(data = data,
       mapping = aes(x = Date,
                     y = Temp,
                     fill = Date)) +
  geom_col() +
  scale_fill_date(low = "green",
                  high = "red")


## datetime varible
### scale_fill_datetime()
data <- head(beaver1, 50)
data$time <- as.POSIXct("2000-1-1 00:00") +
                data$time * 60
data$no <- 1:nrow(data)
ggplot(data = data,
       mapping = aes(x = no,
                     y = temp,
                     fill = time)) +
  geom_col() +
  scale_fill_datetime(low = "green",
                      high = "red")
