
###### TARA Metatranscriptome Analysis - Acetone Monooxygenase Abundance ######
# R version 4.1.0

library(maps)
library(ggmap)
library(mapdata)
library(ggplot2)
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)
library(nationalparkcolors)
library(patchwork)
library(tidyverse)

unfilt <- read.table("abd_mat_head.tsv", sep = '\t', header = T) %>%
  as_tibble()
metadata <- read_tsv("environmental_parameters.csv") %>%
  select(-1) %>%
  rename(OGA_ID = "OGA_ID_1") %>%
  mutate(Season = ifelse(Season == 'unknown', 'autumn', Season))
surface_samples <- metadata %>%
  filter(depth == 'SRF') %>%
  pull(sample_ID)
  
abd <- unfilt %>%
  select(3:ncol(unfilt)) %>%
  colSums() %>%
  as_tibble(rownames = "sample_ID") %>%
  rename(Abundance = "value")

abd_SRF <- unfilt %>%
  select(!!!surface_samples) %>%
  colSums() %>%
  as_tibble(rownames = "sample_ID") %>%
  rename(Abundance = "value")

abd_SAR11 <- unfilt %>%
  filter(grepl("Pelagibacter", taxonomy)) %>%
  select(3:ncol(unfilt)) %>%
  colSums() %>%
  as_tibble(rownames = "sample_ID") %>%
  rename(Abundance = "value")

new_data <- abd %>% left_join(metadata)
new_data_SRF <- abd_SRF %>% left_join(metadata)
new_data_SAR11 <- abd_SAR11 %>% left_join(metadata)
world <- ne_coastline(returnclass = "sf")

colpal <- c("orchid", "darkseagreen", "turquoise4", "cornflowerblue")

map_plot_new <- ggplot(data = world)+ 
  geom_sf(fill = "lightgray")+
  xlab("Longitude")+
  ylab("Latitude")+  
  geom_point(data = new_data, aes(x = longitude, y = latitude, size = Abundance, color = Season ))+ 
  scale_size_continuous(labels = function(x) format(x, scientific = TRUE),
                        name = "Proportion of Total Reads")+
  scale_color_manual(values = colpal)+
  scale_y_continuous(breaks = (-2:2)*30)+
  theme_bw()+
  coord_sf(expand = FALSE)

map_plot_new %>%
  cowplot::save_plot(filename="Tara_acmA_abd_new.tiff",
                     base_width = 8,
                     base_height = 4,
                     dpi = 300)

map_plot_new %>%
  cowplot::save_plot(filename="Tara_acmA_abd_new.png",
                     base_width = 8,
                     base_height = 4,
                     dpi = 300)

map_plot_new_SRF <- ggplot(data = world)+ 
  geom_sf(fill = "lightgray")+
  xlab("Longitude")+
  ylab("Latitude")+  
  geom_point(data = new_data_SRF, aes(x = longitude, y = latitude, size = Abundance, color = Season ))+ 
  scale_size_continuous(labels = function(x) format(x, scientific = TRUE),
                        name = "Proportion of Total Reads")+
  scale_color_manual(values = colpal)+
  scale_y_continuous(breaks = (-2:2)*30)+
  theme_bw()+
  coord_sf(expand = FALSE)

map_plot_new_SRF %>%
  cowplot::save_plot(filename="Tara_acmA_abd_new_SRF.tiff",
                     base_width = 8,
                     base_height = 4,
                     dpi = 300)

map_plot_new_SRF %>%
  cowplot::save_plot(filename="Tara_acmA_abd_new_SRF.png",
                     base_width = 8,
                     base_height = 4,
                     dpi = 300)

map_plot_new_SAR11 <- ggplot(data = world)+ 
  geom_sf(fill = "lightgray")+
  xlab("Longitude")+
  ylab("Latitude")+  
  geom_point(data = dplyr::filter(new_data_SAR11, Abundance == 0),
             aes(x = longitude, y = latitude, size = Abundance, color = Season),
             shape = 4,
             show.legend = F) + 
  geom_point(data = dplyr::filter(new_data_SAR11, Abundance > 0),
             aes(x = longitude, y = latitude, size = Abundance, color = Season))+ 
  scale_size_continuous(labels = function(x) format(x, scientific = TRUE),
                        name = "Proportion of Total Reads",
                        breaks = c(1e-08,
                                   1e-07,
                                   1e-06,
                                   1e-05,
                                   1e-04))+
  scale_color_manual(values = colpal)+
  scale_y_continuous(breaks = (-2:2)*30)+
  theme_bw()+
  coord_sf(expand = FALSE)

map_plot_new_SAR11 %>%
  cowplot::save_plot(filename="Tara_acmA_abd_new_SAR11.tiff",
                     base_width = 8,
                     base_height = 4,
                     dpi = 300)

map_plot_new_SAR11 %>%
  cowplot::save_plot(filename="Tara_acmA_abd_new_SAR11.png",
                     base_width = 8,
                     base_height = 4,
                     dpi = 300)