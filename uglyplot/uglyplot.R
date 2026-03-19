## Ugly Plot Contest ##

library(ggplot2)

tweets <- read.csv("trumptweets.csv", stringsAsFactors = FALSE)

str(tweets)

tweets$sleepy_mention <- ifelse(
  grepl("sleepy joe", tolower(tweets$content)),
  "Yes",
  "No"
)

install.packages("png")
library(png)
library(grid)

install.packages("ggrepel")
library(ggrepel)

fire <- readPNG("fire.png")
talking <- readPNG("talking.png")
trump <- readPNG("trump.png")

highlight <- tweets[sample(nrow(tweets), 50), ]

ggplot(tweets, aes(x = sleepy_mention, y = favorites)) +
  annotation_custom(
    rasterGrob(trump, interpolate = TRUE),
    xmin = -Inf, xmax = Inf,
    ymin = -Inf, ymax = Inf
  ) +
  geom_point(color = "orange", size = 4, alpha = 0.3) +
  geom_point(color = "orangered", size = 1.5) +
  geom_point(data = highlight,
             color = "pink",
             size = 5) +
  geom_text_repel(
    data = highlight,
    aes(label = content),
    size = 3,
    color = "pink",
    segment.color = "pink") +
  labs(x = "sleepy joe mentioned", y = NULL) +
  theme(axis.title.x = element_text(size = 50, family = "Impact")) +
  annotation_custom(
    rasterGrob(fire),
    xmin = -2.3, xmax = 2.5,
    ymin = 250000, ymax = 600000) +
  coord_cartesian(clip = "off") +
  theme(plot.margin = margin(10, 150, 10, 70)) +
  annotation_custom(
    rasterGrob(talking),
    xmin = 2.35, xmax = 4.5,
    ymin = -10000, ymax = -300000
  )


