## Assignment 8 ##

library(tidyverse)

df <- read_csv("../../Data/mushroom_growth.csv")
glimpse(df)

# exploring relationship between response and predictors
ggplot(df, aes(x = Temperature, y = GrowthRate)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  theme_minimal()
    # growth slightly declines in lower temperatures

ggplot(df, aes(x = Humidity, y = GrowthRate)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  theme_minimal()
    # growth improves with high humidity

ggplot(df, aes(x = Humidity, y = GrowthRate)) +
  geom_boxplot() +
  theme_minimal()
    # shows the same as above but displays it better

ggplot(df, aes(x = Nitrogen, y = GrowthRate)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", se = FALSE) +
  theme_minimal()
    # amount of nitrogen does not seem to greatly impact growth on its own

ggplot(df, aes(x = Light, y = GrowthRate)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", se = FALSE) +
  theme_minimal()
    # more light is preferrable for growth


# 4 models to explain GrowthRate

mod1 <- lm(GrowthRate ~ Temperature, data = df)
  # control

mod2 <- lm(GrowthRate ~ Temperature + Humidity, data = df)
  # based on independent effects

mod3 <- lm(GrowthRate ~ Temperature * Humidity, data = df)
  # assumes these affect each other

mod4 <- lm(GrowthRate ~ Temperature + Humidity + Light, data = df)

mod5 <- lm(GrowthRate ~ Temperature + Humidity + Light + Nitrogen, data = df)

mean(mod1$residuals^2)
mean(mod2$residuals^2)
mean(mod3$residuals^2)
mean(mod4$residuals^2)
mean(mod5$residuals^2)

# mod1 mean = 9636.742
# mod2 mean = 7762.79
# mod3 mean = 7617.563
# mod4 mean = 5736.752
# mod5 mean = 5731.211 <- lowest number -- even though N factor looked weak, it might interact with other factor


# new hypothetical values to use with model 5
hypothetical_values <- data.frame(
  Temperature = c(20, 20, 25, 25),
  Humidity = c("Low", "High", "Low", "High"),
  Light = c(0, 10, 10, 20),
  Nitrogen = c(0, 20, 30, 45)
)

hypothetical_values$GrowthRate <- predict(mod5, newdata = hypothetical_values)
hypothetical_values$dataType <- "Predicted"
hypothetical_values

# make a copy of original data
real_data <- df %>%
  select(Temperature, Humidity, Light, Nitrogen, GrowthRate) %>%
  mutate(dataType = "Real")

# combine copy of original data with hypothetical data
combined_data <- bind_rows(real_data, hypothetical_values)

# plot combined dataset
ggplot(combined_data, aes(x = Light, y = GrowthRate, color = dataType)) +
  geom_point(alpha = 0.7) +
  theme_minimal()

ggplot(combined_data, aes(x = Humidity, y = GrowthRate, color = dataType)) +
  geom_point(alpha = 0.7, position = position_jitter(width = 0.1)) +
  theme_minimal()
