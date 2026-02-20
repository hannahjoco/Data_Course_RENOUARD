#Skills Test 1
library(tidyverse)

#Task I: Read data
covid <- read_csv("cleaned_covid_data.csv")
glimpse(covid)

#Task II: Subset/save A states
A_states <- covid %>%
  filter(grepl("^A", Province_State))

unique(A_states$Province_State)

#Task III: Plot deaths over time for A_states
ggplot(A_states, aes(x = Last_Update, y = Deaths)) +
  geom_point() +
  geom_smooth(method = "loess", se = FALSE) +
  facet_wrap(~ Province_State, scales = "free") +
  labs(
    title = "Deaths over time for states starting with A",
    x = "Date",
    y = "Deaths"
  )

#Task IV: Find peak of Case_Fatality_Ratio per state
state_max_fatality_rate <- covid %>%
  group_by(Province_State) %>%
  summarize(
    Maximum_Fatality_Ratio = max(Case_Fatality_Ratio, na.rm = TRUE)
  ) %>%
  arrange(desc(Maximum_Fatality_Ratio))

glimpse(state_max_fatality_rate)
n_distinct(covid$Province_State)
nrow(state_max_fatality_rate)
head(state_max_fatality_rate)
tail(state_max_fatality_rate)

#Task V: Bar plot of max fatality ratio by state (ordered)
state_max_fatality_rate <- state_max_fatality_rate %>%
  mutate(Province_State = factor(Province_State, levels = Province_State))

ggplot(state_max_fatality_rate, aes(x = Province_State, y = Maximum_Fatality_Ratio)) +
  geom_col() +
  labs(
    title = "Peak Case Fatality Ratio by State",
    x = "State",
    y = "Maximum Fatality Ratio"
  ) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))

#Task VI: Cumulative deaths for entire US over time
us_deaths <- covid %>%
  group_by(Last_Update) %>%
  summarize(Total_Deaths = sum(Deaths, na.rm = TRUE))

ggplot(us_deaths, aes(x = Last_Update, y = Total_Deaths)) +
  geom_line() +
  labs(
    title = "Cumulative US COVID Deaths Over Time",
    x = "Date",
    y = "Total Deaths"
  )
