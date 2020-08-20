library(tidyverse)
library(sf)
library(units)

cities = readr::read_csv("~/github/geog-176A-labs/data/uscities.csv")

cities_sf = data.frame(y = c(-121.7608, -119.7202), x = c(34.4285, 37.6861))

cities_sf = st_as_sf(cities, coords = c("lng", "lat"), crs = 4326) %>%
  filter(city %in% c("Santa Barbara", "Livermore"), state_name == "California")


cities5070 = st_transform(cities_sf, 5070)

eqdc = '+proj=eqdc +lat_0=40 +lon_0=-96 +lat_1=20 +lat_2=60 +x_0=0 +y_0=0 +datum=NAD83 +units=m +no_defs'

# Euclidean Distance
st_distance(cities_sf, which = "Euclidean")

plot(cities_sf$geometry)
# Equal Area Distance - change units to km and drop units
st_distance(st_transform(cities5070)) %>%
  units::set_units("km") %>%
  units::drop_units()

# Equal Distance
st_distance(st_transform(cities_sf, eqdc))




