# Basis
library(sf)
library(ggplot2)
library(ggspatial)
library(cowplot)

Boundary_China <- st_read('Boundary_China.shp')
Boundary_Heihe <- st_read('Boundary_Heihe.shp')
Jiuduanxian <- st_read('Jiuduanxian.shp')
Nanhai <- st_read('Nanhai.shp')

Boundary_Heihe$name <- "Heihe river basin"

# Plot
## Origin
ggplot()+
  geom_sf(data = Boundary_China,
          linewidth = 0.3,
          color = "black")+
  geom_sf(data = Boundary_Heihe,
          aes(color = name),
          fill = "#ffb75e",
          linewidth = 0.5) +
  geom_sf(data = Jiuduanxian)+
  geom_sf(data = Nanhai,
          linewidth = 0.3,
          color = "black")+
  coord_sf(crs = 4236) +
  scale_color_manual(values = "#ff645e") +
  labs(x = "Longitude (°)",
       y = "Latitude (°)",
       color = NULL) +
  theme_bw() +
  theme(text = element_text(family = "serif"),
        axis.text = element_text(color = "black"),
        panel.grid = element_blank(),
        legend.position = c(0.17,0.07),
        legend.key.size = unit(13, "pt"))

ggsave("fig1.jpg", width = 5, height = 4, dpi = 800)

## Projection
ggplot()+
  geom_sf(data = Boundary_China,
          linewidth = 0.3,
          color = "black")+
  geom_sf(data = Boundary_Heihe,
          aes(color = name),
          fill = "#ffb75e",
          linewidth = 0.5) +
  geom_sf(data = Jiuduanxian)+
  geom_sf(data = Nanhai,
          linewidth = 0.3,
          color = "black")+
  coord_sf(crs = "+proj=aea +ellps=krass +lon_0=105 +lat_1=25 +lat_2=47") +
  scale_color_manual(values = "#ff645e") +
  labs(x = "Longitude (°)",
       y = "Latitude (°)",
       color = NULL) +
  theme_bw() +
  theme(text = element_text(family = "serif"),
        axis.text = element_text(color = "black"),
        panel.grid = element_blank(),
        legend.position = c(0.23,0.07),
        legend.key.size = unit(13, "pt"))

ggsave("fig2.jpg", width = 4, height = 4, dpi = 800)

## North arrow
ggplot()+
  geom_sf(data = Boundary_China,
          linewidth = 0.3,
          color = "black") +
  geom_sf(data = Boundary_Heihe,
          aes(color = name),
          fill = "#ffb75e",
          linewidth = 0.5) +
  geom_sf(data = Jiuduanxian) +
  geom_sf(data = Nanhai,
          linewidth = 0.3,
          color = "black") +
  annotation_north_arrow(location = "tl",
                         pad_x = unit(5, "pt"),
                         pad_y = unit(7, "pt"),
                         height = unit(25, "pt"),
                         width = unit(25, "pt"),
                         which_north = "true",
                         style = north_arrow_fancy_orienteering(text_family = "serif"))+
  coord_sf(crs = "+proj=aea +ellps=krass +lon_0=105 +lat_1=25 +lat_2=47") +
  scale_color_manual(values = "#ff645e") +
  labs(x = "Longitude (°)",
       y = "Latitude (°)",
       color = NULL) +
  theme_bw() +
  theme(text = element_text(family = "serif"),
        axis.text = element_text(color = "black"),
        panel.grid = element_blank(),
        legend.position = c(0.23,0.07),
        legend.key.size = unit(13, "pt"))

ggsave("fig3.jpg", width = 4, height = 4, dpi = 800)

## Scale bar
ggplot()+
  geom_sf(data = Boundary_China,
          linewidth = 0.3,
          color = "black") +
  geom_sf(data = Boundary_Heihe,
          aes(color = name),
          fill = "#ffb75e",
          linewidth = 0.5) +
  geom_sf(data = Jiuduanxian) +
  geom_sf(data = Nanhai,
          linewidth = 0.3,
          color = "black") +
  annotation_north_arrow(location = "tl",
                         pad_x = unit(5, "pt"),
                         pad_y = unit(7, "pt"),
                         height = unit(25, "pt"),
                         width = unit(25, "pt"),
                         which_north = "true",
                         style = north_arrow_fancy_orienteering(text_family = "serif")) +
  annotation_scale(location = "bl",
                   pad_x = unit(10, "pt"),
                   pad_y = unit(10, "pt"),
                   height = unit(5, "pt"),
                   width_hint = 0.2,
                   style = "ticks",
                   unit_category = "metric",
                   text_family = "serif",
                   line_width = 1,
                   ) +
  coord_sf(crs = "+proj=aea +ellps=krass +lon_0=105 +lat_1=25 +lat_2=47") +
  scale_color_manual(values = "#ff645e") +
  labs(x = "Longitude (°)",
       y = "Latitude (°)",
       color = NULL) +
  theme_bw() +
  theme(text = element_text(family = "serif"),
        axis.text = element_text(color = "black"),
        panel.grid = element_blank(),
        legend.position = c(0.22,0.15),
        legend.key.size = unit(13, "pt"))

ggsave("fig4.jpg", width = 4, height = 4, dpi = 800)

## Sub-plot
main_polt <- ggplot()+
  geom_sf(data = Boundary_China,
          linewidth = 0.3,
          color = "black") +
  geom_sf(data = Boundary_Heihe,
          aes(color = name),
          fill = "#ffb75e",
          linewidth = 0.5) +
  geom_sf(data = Jiuduanxian) +
  geom_sf(data = Nanhai,
          linewidth = 0.3,
          color = "black") +
  annotation_north_arrow(location = "tl",
                         pad_x = unit(5, "pt"),
                         pad_y = unit(7, "pt"),
                         height = unit(25, "pt"),
                         width = unit(25, "pt"),
                         which_north = "true",
                         style = north_arrow_fancy_orienteering(text_family = "serif")) +
  annotation_scale(location = "bl",
                   pad_x = unit(10, "pt"),
                   pad_y = unit(8, "pt"),
                   height = unit(5, "pt"),
                   width_hint = 0.2,
                   style = "ticks",
                   unit_category = "metric",
                   text_family = "serif",
                   line_width = 1,
  ) +
  coord_sf(crs = "+proj=aea +ellps=krass +lon_0=105 +lat_1=25 +lat_2=47",
           ylim = c(1851151, 5863805), 
           xlim = c(-2601944, 2924108))+
  scale_color_manual(values = "#ff645e") +
  labs(x = "Longitude (°)",
       y = "Latitude (°)",
       color = NULL) +
  theme_bw() +
  theme(text = element_text(family = "serif"),
        axis.text = element_text(color = "black"),
        panel.grid = element_blank(),
        legend.position = c(0.197,0.16),
        legend.key.size = unit(11, "pt"),
        legend.background = element_blank())

sub_plot <- ggplot()+
  geom_sf(data = Boundary_China,
          linewidth = 0.3,
          color = "black") +
  geom_sf(data = Jiuduanxian) +
  geom_sf(data = Nanhai,
          linewidth = 0.3,
          color = "black") +
  coord_sf(crs = "+proj=aea +ellps=krass +lon_0=105 +lat_1=25 +lat_2=47",
           ylim = c(370910,2809416),
           xlim = c(200000,1870662))+
  theme_void() +
  theme(panel.border = element_rect(fill = "transparent"))

ggdraw() +
  draw_plot(main_polt) +
  draw_plot(sub_plot, x = 0.83, y = 0.12, width = 0.13, height = 0.39)

ggsave("fig5.jpg", width = 4, height = 3, dpi = 800)
