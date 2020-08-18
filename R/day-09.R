data = USAboundaries::us_states(resolution = "low") %>%
  filter(state_name != "Puerto Rico", "Alaska", "Hawaii")
attributes(data)


df = data.frame(name = state_name,
                geometry = geometry)
head(df)





