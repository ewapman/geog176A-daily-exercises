# Emily Wapman
# 8/11/2020
#Daily Assignment 06: Plotting

library(tidyverse)

url = 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv'

covid = read_csv(url)

library(ggplot2)

top_states = covid %>%
  filter(date == max(date)) %>%
  group_by(state) %>%
  summarize(cases = sum(cases, na.rm = TRUE)) %>%
  ungroup() %>%
  slice_max(cases, n = 6) %>%
  pull(state)

covid_plot = covid %>%
  filter(state%in%top_states) %>%
  group_by(state, date) %>%
  summarize(cases = sum(cases, na.rm = TRUE)) %>%
  ungroup()

gg = ggplot(data = covid_plot, aes(x = date, y = cases)) + geom_line(aes(col = state)) +
  labs(title = "Cummulative Case Counts: COVID-19 Pandemic",
       caption =  "Daily Exercise 06",
       color = "") +
  facet_wrap(~state) +
  theme_bw() +

ggsave(gg, file = "~/github/geog176A-daily-exercises/img/my-beatuiful-plot.png")


covid_plot2 = covid %>%
  group_by(date) %>%
  summarize(cases = sum(cases, na.rm = TRUE)) %>%
  ungroup()

gg = ggplot(data = covid_plot2, aes(x = date, y = cases)) + geom_col(col = "red") +
  labs(title = "National Cummulative Case Counts: COVID-19 Pandemic",
       caption = "Daily Exercise 06") +
  theme_minimal()
ggsave(gg, file = "~/github/geog176A-daily-exercises/img/plot-two.png")











