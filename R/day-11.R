library(sf)
library(tidyverse)

# Filter to State
state = USAboundaries::us_states() %>%
  filter(state_name == "Colorado")

# Touching States
state_touching =  st_filter(USAboundaries::us_states(), state, .predicate = st_touches)

# All US States
conus = USAboundaries::us_states() %>%
  filter(!state_name %in% c("Puerto Rico", "Alaska", "Hawaii"))

gg = ggplot() +
  geom_sf(data = conus) +
  geom_sf(data = state_touching, fill = 'red', alpha = 0.5) +
  labs(title = "States Bordering Colorado",
       subtitle = "By Emily Wapman",
       caption = "Daily Assignment 12") +
  theme_minimal()

ggsave(gg, file = "~/github/geog176A-daily-exercises/img/exercise12.png")

