library(dplyr)
load("datasets/weight_loss.rda")

# Liður 1
weigh_loss %>%
  transmute(Individuals,
            EndResult = Dec - Jan)

# Liður 2
weigh_loss %>%
  transmute(Individuals,
            WeightRatio = (Dec - Goal) /Jan)

# Liður 3

# Versta hlutfall á upphafsþyngd og lokaþyngd
weigh_loss[which.max(weigh_loss$Dec / weigh_loss$Jan), ]

# Fæstu töpuðu kíló
weigh_loss[which.min(weigh_loss$Jan - weigh_loss$Dec), ]

# Liður 4
weigh_loss %>%
  transmute(Individuals,
            ArangurMarSep = if_else(Feb - Mar > 0 & Aug - Sep > 0, "Gekk vel", "Gekk ekki vel"))

# Liður 5
weight_loss_extended <- weigh_loss %>%
  mutate(Success_Rate = -(Dec / Jan - 1) * 100)

View(weight_loss_extended)
