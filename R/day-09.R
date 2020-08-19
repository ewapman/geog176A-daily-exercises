library(sf)
library(tidyverse)
data = USAboundaries::us_states() %>%
  filter(!state_name %in% c("Puerto Rico", "Alaska", "Hawaii"))

usa_geom = data$geometry
(ca_c_ml = st_combine(usa_geom) %>%
    st_cast("MULTILINESTRING"))

plot(ca_c_ml)


usa_geom2 = data$geometry
(ca_u_ml = st_union(usa_geom2)  %>%
    st_cast("MULTILINESTRING"))
plot(usa_geom2)
plot(ca_u_ml)
