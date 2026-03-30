## Assignment 7 ##

library(tidyverse)

dat <- read_csv("Utah_Religions_by_County.csv")

glimpse(dat)

dat_long <- dat %>%
  pivot_longer(
    cols = -c(County, Pop_2010),
    names_to = "Religion",
    values_to = "Proportion"
  )

glimpse(dat_long)


# does population correlate with religion proportion?

ggplot(dat_long, aes(x = Pop_2010, y = Proportion)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  facet_wrap(~ Religion, scales = "free_y") +
  theme_minimal()
 
  #looks like theres not a consistent relationship between large counties and certain religions
  #smaller populations seems to have more religous poeple than larger populations

# plot LDS religion against population specifically

dat_long %>%
  filter(Religion == "LDS") %>%
  ggplot(aes(x = Pop_2010, y = Proportion)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "blue") +
  theme_minimal()


# does proportion of specific religion in a county correlate with proportion of non-religious people?

none_data <- dat_long %>%
  filter(Religion == "Non-Religious") %>%
  select(County, NonRel = Proportion)

compare_data <- dat_long %>%
  left_join(none_data, by = "County") %>%
  filter(Religion != "Non-Religious")

ggplot(compare_data, aes(x = NonRel, y = Proportion)) +
  geom_point() +
  facet_wrap(~ Religion, scales = "free_y") +
  theme_minimal()

  #strong negative relationshis, which makes sense, but especially between religious and not religious


# let's see how common each religion is

ggplot(dat_long, aes(x = Proportion)) +
  geom_histogram(bins = 20) +
  facet_wrap(~ Religion, scales = "free") +
  theme_minimal()

# let's narrow it down to major religions

dat_long %>%
  filter(Religion %in% c("LDS", "Catholic", "Evangelical", "Non-Religious")) %>%
  ggplot(aes(x = Pop_2010, y = Proportion, color = Religion)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  theme_minimal()

# cool