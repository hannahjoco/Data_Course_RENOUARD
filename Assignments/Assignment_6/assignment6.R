## Assignment 6 ##

library(tidyverse)

dat <- read_csv("../../Data/BioLog_Plate_Data.csv")

glimpse(dat)

dat_long <- dat %>%
  pivot_longer(
    cols = starts_with("Hr_"),
    names_to = "Time",
    values_to = "Absorbance"
  )

dat_long$Time <- as.numeric(gsub("Hr_", "", dat_long$Time))

dat_long <- dat_long %>%
  mutate(Type = ifelse(grepl("Soil", `Sample ID`), "Soil", "Water"))

glimpse(dat_long)

table(dat_long$Type)

dat_summary <- dat_long %>%
  group_by(`Sample ID`, Type, Substrate, Dilution, Time) %>%
  summarize(
    mean_absorbance = mean(Absorbance),
    .groups = "drop"
  )

glimpse(dat_summary)

plot_data <- dat_long %>%
  group_by(Type, Substrate, Dilution, Time) %>%
  summarize(
    mean_absorbance = mean(Absorbance),
    .groups = "drop"
  ) %>%
  filter(Dilution == 0.1)

ggplot(plot_data, aes(x = Time, y = mean_absorbance, color = Type)) +
  geom_line() +
  facet_wrap(~ Substrate) +
  labs(
    title = "Carbon Utilization Over Time",
    x = "Time",
    y = "Absorbance"
  ) +
  theme_minimal()

itaconic_summary <- dat_long %>%
  filter(Substrate == "Itaconic Acid") %>%
  group_by(`Sample ID`, Dilution, Time) %>%
  summarize(
    mean_absorbance = mean(Absorbance),
    .groups = "drop"
  )

ggplot(itaconic_summary, aes(x = Time, y = mean_absorbance, color = `Sample ID`)) +
  geom_line() +
  facet_wrap(~ Dilution) +
  labs(
    title = "Itaconic Acid",
    x = "Time",
    y = "Mean Absorbance"
  ) +
  theme_minimal()

library(gganimate)

anim_plot <- ggplot(
  itaconic_summary,
  aes(x = Time, y = mean_absorbance, color = `Sample ID`, group = `Sample ID`)
) +
  geom_line() +
  facet_wrap(~ Dilution) +
  labs(
    title = "Itaconic Acid",
    x = "Time",
    y = "Mean Absorbance"
  ) +
  theme_minimal() +
  transition_reveal(Time)

animate(anim_plot)

anim_save("itatonic_acid_animated.gif")
