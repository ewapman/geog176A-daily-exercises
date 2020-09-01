# Daily Excercise 14

library(tidyverse)
library(sf)
library(USAboundaries)

data = USAboundaries::us_states(resolution = "low") %>%
  filter(!state_name %in% c("Puerto Rico", "Alaska", "Hawaii"))

cities = read_csv("~/github/geog-176A-labs/data/uscities.csv") %>%
  st_as_sf(coords = c("lng", "lat"), crs = 4326)


point_in_polygon = function(points, polygon, id){
  st_join(polygon, points) %>%
    st_drop_geometry() %>%
    count(get(id)) %>%
    setNames(c(id, "n")) %>%
    left_join(polygon, by = id) %>%
    st_as_sf()}

plot_pip = function(data){
  ggplot() +
    geom_sf(data = data, aes(fill = log(n)), alpha = .9, size = .2) +
    scale_fill_gradient(low = "white", high = "blue") +
    theme_void() +
    theme(legend.position = 'none',
          plot.title = element_text(face = "bold", color = "darkgreen", hjust = .5, size = 24)) +
    labs(title = "Number of Cities per US County",
         caption = paste0(sum(data$n), "locations represented"))}

point_in_polygon(cities, county_name, "geoid") %>%
  plot_pip()

ggsave = ()
