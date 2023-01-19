# Basis
library(sf)
library(raster)
library(ggplot2)
library(ggrepel)

# Data
Boundary_China <- st_read('Boundary_China.shp')
County_China <- st_read('County_China.shp')
Province_China <- st_read('Province_China.shp')
Road_China <- st_read('Road_China.shp')
Train_China <- st_read('Train_China.shp')

Boundary_Heihe <- st_read('Boundary_Heihe.shp')
Elevation_Heihe <- raster("Elevation_Heihe.tif")
Station_Heihe <- read.csv("Station_Heihe.csv")
temperature_Heihe <- read.csv("temperature_Heihe.csv",
                              header = F)

# Plot
## 1. vector data
### 1.1
ggplot()+
  geom_sf(data = Boundary_China,
          linewidth = 0.3,
          color = "black")+
  geom_sf(data = Boundary_Heihe,
          color = "#ff645e",
          fill = "#ffb75e",
          linewidth = 0.5) +
  geom_text(aes(x = 100, y = 36),
            label = "Heihe river basin",
            family = "serif") +
  coord_sf(crs = 4236) +
  labs(x = "Longitude (°)",
       y = "Latitude (°)") +
  theme_bw() +
  theme(text = element_text(family = "serif"),
        axis.text = element_text(color = "black"),
        panel.grid = element_blank())
  
ggsave("fig1.1.jpg", width = 5, height = 4, dpi = 800)

### 1.2
ggplot()+
  geom_sf(data = Boundary_China,
          color = "black",
          linewidth = 0.4)+
  geom_sf(data = County_China,
          aes(color = CLASS),
          size = 0.3) + 
  coord_sf(crs = 4236) +
  scale_color_manual(values = c("#e85a71", "#4ea1d3")) +
  theme_bw() +
  labs(x = "Longitude (°)",
       y = "Latitude (°)", 
       color = "County class") +
  theme(text = element_text(family = "serif"),
        panel.grid = element_blank(),
        axis.text = element_text(color = "black"),
        legend.background = element_blank(),
        legend.position = c(0.12, 0.13))

ggsave("fig1.2.jpg", width = 5, height = 4, dpi = 800)

### 1.3
Road_China$name <- "Road"
Train_China$name <- "Train"

ggplot()+
  geom_sf(data = Boundary_China,
          color = "black",
          linewidth = 0.4)+
  geom_sf(data = Road_China,
          aes(color = name)) + 
  geom_sf(data = Train_China,
          aes(color = name)) +
  coord_sf(crs = 4236) +
  scale_color_manual(values = c("red", "blue")) +
  theme_bw() +
  labs(x = "Longitude (°)",
       y = "Latitude (°)", 
       color = NULL) +
  theme(text = element_text(family = "serif",
                            size = 12),
        panel.grid = element_blank(),
        axis.text = element_text(color = "black"),
        legend.background = element_blank(),
        legend.position = c(0.1, 0.12))

ggsave("fig1.3.jpg", width = 5, height = 4, dpi = 800)

### 1.4
ggplot()+
  geom_sf(data = Province_China,
          aes(fill = GDP_2000.)) + 
  geom_sf(data = Boundary_China,
          fill = "transparent",
          color = "black",
          linewidth = 0.3)+
  coord_sf(crs = st_crs(Province_China)) +
  theme_bw() +
  scale_fill_distiller(palette = "RdYlBu") +
  labs(x = "Longitude (°)",
       y = "Latitude (°)",
       fill = "地区生产总值（亿）") +
  theme(text = element_text(family = "serif",
                            size = 12),
        panel.grid = element_blank(),
        axis.text = element_text(color = "black"),
        legend.position = "bottom",
        legend.key.width = unit(27, "pt"),
        legend.key.height = unit(10, "pt"),
        legend.margin = margin(0,0,0,0),
        legend.title = element_text(vjust = 0.9))

ggsave("fig1.4.jpg", width = 4.5, height = 4, dpi = 800)


## 2. raster data
Elevation_Heihe_mask <- mask(Elevation_Heihe,Boundary_Heihe)
Elevation_Heihe_mask_df <- as.data.frame(as(Elevation_Heihe_mask,"Raster"),xy=T)

ggplot() +
  geom_raster(data = Elevation_Heihe_mask_df,
              mapping = aes(x=x,
                            y=y,
                            fill = Elevation_Heihe)) + 
  geom_sf(data = Boundary_Heihe,
          color = "black",
          fill = "transparent",
          linewidth = 0.4)+
  scale_fill_gradientn(colors = terrain.colors(6),
                       na.value = "transparent",
                       n.breaks = 5) +
  scale_x_continuous(limits = c(96.9,102.1),
                     expand = c(0,0)) +
  scale_y_continuous(limits = c(37.6,42.8)
                     ,expand = c(0,0)) +
  labs(x = "Longitude (°)",
       y = "Latitude (°)",
       fill = "Elevation (m)") +
  theme_bw() +
  theme(text = element_text(family = "serif"),
        panel.grid = element_blank(),
        axis.text = element_text(color = "black"),
        legend.key.height = unit(40, "pt"))

ggsave("fig2.jpg", width = 4.5, height = 4, dpi = 800)

## 3. table data
### 3.1
ggplot() +
  geom_sf(data = Boundary_Heihe,
          color = "black",
          linewidth = 0.4)+
  geom_point(data = Station_Heihe,
             mapping = aes(x = lng,
                           y = lat,
                           color = station_name),
             size = 0.5) +
  geom_text_repel(data = Station_Heihe,
                  mapping = aes(x = lng,
                                y = lat,
                                label = station_name),
                  family = "serif",
                  size = 3.3) + 
  scale_color_grey(start = 0, end = 0,
                   breaks = c("Ejinaqi")) +
  scale_x_continuous(limits = c(96.9,102.1),
                     expand = c(0,0)) +
  scale_y_continuous(limits = c(37.6,42.8)
                     ,expand = c(0,0)) +
  labs(x = "Longitude (°)",
       y = "Latitude (°)",
       color = "Station") +
  theme_bw() +
  theme(text = element_text(size = 12, family = "serif"),
        panel.grid = element_blank(),
        axis.text = element_text(color = "black"))

ggsave("fig3.1.jpg", width = 4.5, height = 4, dpi = 800)

### 3.2
temperature_Heihe <- temperature_Heihe - 273.15
temperature_Heihe <- as.matrix(temperature_Heihe)
temperature_Heihe <- raster(temperature_Heihe, 
                            xmn = 96,
                            xmx = 103,
                            ymn = 36,
                            ymx = 44)
temperature_Heihe_mask <- mask(temperature_Heihe,Boundary_Heihe)
temperature_Heihe_mask_df <- as.data.frame(as(temperature_Heihe_mask,"Raster"),xy=T)

ggplot() +
  geom_raster(data = temperature_Heihe_mask_df,
              mapping = aes(x=x,
                            y=y,
                            fill = layer),
              alpha = 0.8) + 
  geom_sf(data = Boundary_Heihe,
          color = "black",
          fill = "transparent",
          linewidth = 0.4)+
  scale_fill_steps2(low = "blue",
                    mid = "yellow",
                    high = "red",
                    na.value = "transparent",
                    n.breaks = 6) +
  scale_x_continuous(limits = c(96.9,102.1),
                     expand = c(0,0)) +
  scale_y_continuous(limits = c(37.6,42.8)
                     ,expand = c(0,0)) +
  labs(x = "Longitude (°)",
       y = "Latitude (°)",
       fill = "Temperature (℃)") +
  theme_bw() +
  theme(text = element_text(size = 12, family = "serif"),
        panel.grid = element_blank(),
        axis.text = element_text(color = "black"),
        legend.key.height = unit(25, "pt"),
        legend.key = element_rect(fill = "transparent"))

ggsave("fig3.2.jpg", width = 4.8, height = 4, dpi = 800)
