library(dplyr)

data_kyn_victim <- read.csv("dataset/VST10001.csv", header = TRUE, stringsAsFactors = TRUE, skip = 1)
data_kyn_attacker <- read.csv("dataset/VST10002.csv", header = TRUE, stringsAsFactors = TRUE, skip = 1)

data_kyn_victim <- data_kyn_victim %>%
  rename(Karlar_victim = Karlar, Konur_victim = Konur)

data_kyn_attacker <- data_kyn_attacker %>%
  rename(Karlar_attacker = Karlar, Konur_attacker = Konur)


add_column(data_kyn_victim, data_kyn_attacker$Karlar_attacker, data_kyn_attacker$Konur_attacker)

data_combined <- data_kyn_victim %>%
  mutate(Karlar_attacker = data_kyn_attacker$Karlar_attacker, Konur_attacker = data_kyn_attacker$Konur_attacker)
data_combined <- data_combined %>% select(-Samtals, Samtals)

# Hreinsa datasettið aðeins
data_combined[data_combined == ".."] <- NA
data_combined$Karlar_victim <- as.integer(data_combined$Karlar_victim)
data_combined$Konur_victim <- as.integer(data_combined$Konur_victim)
data_combined$Karlar_attacker <- as.integer(data_combined$Karlar_attacker)
data_combined$Konur_attacker <- as.integer(data_combined$Konur_attacker)
data_combined$Samtals <- as.integer(data_combined$Samtals)


data_combined <- data_combined %>%
  rename(
    Ar = Ár,
    Manudur = Mánuður)

data_combined <- data_combined %>%
  select(-Samtals) %>%
  filter(Manudur == "Samtals")
# filter(!is.na(Karlar_victim) | as.character(Manudur) != "Samtals")

data_combined
# data_combined <- filter(data_combined, 4 != 3, !is.na(Karlar_victim))


# str(data_combined)

# summary(data_combined)


