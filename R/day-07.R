# Emily Wapman
# 08/12/2020
# Daily Assignment 07

# Read in Covid-19 Data

library(tidyverse)

url = 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv'

covid = read_csv(url)

library(ggplot2)

# Create a data.frame from state.abb, state.name, state.region data

library(USAboundaries)

state = USAboundaries::us_states(resolution = "low")  %>%
  select('state_name')
region = data.frame(state_name = state.name, region = state.region)

#Join and Pivot

library(tidyr)
covid_plot = covid %>%
  right_join(region, by = c("state" = "state_name" )) %>%
  group_by(region, date) %>%
  summarize(cases = sum(cases, na.rm = TRUE), deaths = sum(deaths, na.rm = TRUE)) %>%
  ungroup() %>%
  pivot_longer(c(`cases`, `deaths`), names_to = "state", values_to = "count")


# Plot

gg = ggplot(data = covid_plot, aes(x = date, y = count)) + geom_line(aes(col = region)) +
  labs(title = "Cummulative Cases and Deaths",
       subtitle = "COVID-19 data: NY Times",
       caption =  "Daily Exercise 07",
       color = "") +
  facet_grid(state~region, scales = "free_y")+
  theme_bw() +
  theme(legend.position = "NA")

# Save Plot

ggsave(gg, file = "~/github/geog176A-daily-exercises/img/exercise07.png")




