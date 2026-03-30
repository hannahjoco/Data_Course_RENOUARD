## Exam 2 ##

unicef <- read.csv("unicef-u5mr.csv", stringsAsFactors = FALSE)

library(tidyverse)

unicef_long <- unicef %>%
  pivot_longer(
    cols = starts_with("U5MR"),
    names_to = "Year",
    values_to = "U5MR"
  )

unicef_long$Year <- as.numeric(gsub("U5MR.", "", unicef_long$Year))

head(unicef_long)

unicef_long <- unicef_long %>%
  drop_na(U5MR)

ggplot(unicef_long, aes(x = Year, y = U5MR, group = CountryName)) +
  geom_line(alpha = 0.3) +
  facet_wrap(~ Continent) +
  labs(
    title = "Under-5 Mortality Rate Over Time by Country",
    x = "Year",
    y = "U5MR (deaths per 1000)"
  )

unicef_summary <- unicef_long %>%
  group_by(Continent, Year) %>%
  summarize(mean_U5MR = mean(U5MR), .groups = "drop")

ggplot(unicef_summary, aes(x = Year, y = mean_U5MR, color = Continent)) +
  geom_line() +
  labs(
    title = "Mean U5MR by Continent Over Time",
    x = "Year",
    y = "Mean U5MR"
  )

mod1 <- lm(U5MR ~ Year, data = unicef_long)
mod2 <- lm(U5MR ~ Year + Continent, data = unicef_long)
mod3 <- lm(U5MR ~ Year * Continent, data = unicef_long)

summary(mod1)
summary(mod2)
summary(mod3)

AIC(mod1, mod2, mod3)

# model 3 is best based on higher adjusted R-squared and lower AIC. the interaction between year and continent allows different trends over time for different continents # 

pred_data <- expand.grid(
  Year = seq(min(unicef_long$Year), max(unicef_long$Year)),
  Continent = unique(unicef_long$Continent)
)

pred_data$mod1 <- predict(mod1, newdata = pred_data)
pred_data$mod2 <- predict(mod2, newdata = pred_data)
pred_data$mod3 <- predict(mod3, newdata = pred_data)

pred_long <- pred_data %>%
  pivot_longer(
    cols = starts_with("mod"),
    names_to = "model",
    values_to = "pred"
  )

ggplot(pred_long, aes(x =Year, y=pred, color = Continent)) +
  geom_line() +
  facet_wrap( ~ model) +
  labs(
    title = "Model Predictions of U5MR",
    y = "Predicted U5MR"
  )

ecuador_2020 <- data.frame(
  Year = 2020,
  Continent = "Americas"
)

pred_value <- predict(mod3, newdata = ecuador_2020)
pred_value

real_value <- 13
difference <- pred_value - real_value

difference

# the difference is -23.58018 #

mod4 <- lm(log(U5MR) ~ Year * Continent, data = unicef_long)

pred_log <- predict(mod4, newdata = ecuador_2020)
pred_value_new <- exp(pred_log)

pred_value_new

# new prediction is 11.99908, much closer to 13 #