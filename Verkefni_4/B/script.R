library(dplyr)
library(ggplot2)
library(reshape2)
load("datasets/weight_loss.rda")

# Liður 1
heavy_ind <- weigh_loss %>%
  filter(Jan == max(Jan))

d <- melt(heavy_ind[, c(1, 5:16)], id.vars = "Individuals")

p <- ggplot(d, aes(x = variable, y = value)) +
  geom_point(aes(col = Individuals), size = 3)

p

# Liður 2

indi_14_41 <- weigh_loss %>%
  filter(Individuals == "Person 14" | Individuals == "Person 41")

indi_14_41_melt <- melt(indi_14_41[, c(1, 5:16)], id.vars = "Individuals")

p2 <- ggplot(indi_14_41_melt, aes(x = variable, y = value)) +
  geom_point(aes(col = Individuals), size = 3) +
  labs(x = "Mánuður", y = "Kg")
p2

# Liður 3

indi_13_29 <- weigh_loss %>%
  filter(Individuals == "Person 13" | Individuals == "Person 29")

indi_13_29_melt <- melt(indi_13_29[, c(1, 5:16)], id.vars = "Individuals")

p3 <- ggplot(indi_13_29_melt, aes(x = variable, y = value)) +
  geom_point(aes(col = Individuals), size = 3) +
  xlim(c("Mai", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")) +
  ylim(c(85, 95)) +
  labs(x = "Mánuður", y = "Kg")

p3

# Liður 4

months_mean <- weigh_loss %>%
  summarise(Avg = "Meðaltal(kg)",
            Jan = mean(Jan),
            Feb = mean(Feb),
            Mar = mean(Mar),
            Apr = mean(Apr),
            Mai = mean(Mai),
            Jun = mean(Jun),
            Jul = mean(Jul),
            Aug = mean(Aug),
            Sep = mean(Sep),
            Oct = mean(Oct),
            Nov = mean(Nov),
            Dec = mean(Dec))

months_mean_melt <- melt(months_mean[, c(1:13)], id.vars = "Avg")

months_mean_melt

p4 <- ggplot(months_mean_melt, aes(x = variable, y = value)) +
  geom_point(aes(col = Avg), size = 3) +
  labs(x = "Mánuður", y = "Kg")

p4

# Liður 5

goal_5kg <- weigh_loss %>%
  filter(Goal == 5)

goal_5kg_melt <- melt(goal_5kg[, c(1, 5:16)], id.vars = "Individuals")

p5 <- ggplot(goal_5kg_melt, aes(x = variable, y = value)) +
  geom_point(aes(col = Individuals), size = 2) +
  labs(x = "Mánuður", y = "Kg")

p5


