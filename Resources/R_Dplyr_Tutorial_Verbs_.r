library(dplyr)
library(hflights)
data(hflights)
# Skoðum fyrstu færslurnar í hflight data.frame-inu
head(hflights)

# setjum nú flugið í lókal data.frame:
# as_tibble þvingar matrixur og lista yfir í data.frame
flights <- as_tibble(hflights)

# skoðum nú hausinn á flights:
head(flights)
# skoðum flights án head()
flights

# talað er um DPLYR verbs sem eru basically aðferðir(eða föll) sem eru mikið notaðar í R.
# dplyr verbs er eftirfarandi:
#   filter
#   select
#   arrange
#   mutate
#   summarise

# --------------------------------------- filter: Velja raðir! ---------------------------------------

# "venjuleg" R aðferð við að nota filter.
# hérna viljum við sjá öll flug sem fóru fyrsta janúar.
flights[flights$Month==1 & flights$DayofMonth==1, ]
 
# dplyr aðferðin er svona:   # Athugið að fliter() skilar data.frame!
filter(flights, Month==1, DayofMonth==1)
# komman á milli filter-skilyrða er í raun and operator(&)
# það má líka nota & í staðinn, læk só:
filter(flights, Month==1 & DayofMonth==1)

# or operatorinn er svo | 
filter(flights, UniqueCarrier== 'AA' | UniqueCarrier== 'UA')

# það getur verið þægilegra að not in operatorinn hérna, einhvernveginn svona:
filter(flights, UniqueCarrier %in% c('AA', 'UA'))
 
# --------------------------------------- select: Velja dálka(eftir nafni)! ---------------------------------------

# "venjuleg" R aðferð við að nota select
# hérna viljum við sjá gögn úr DepTime,ArrTime og FlightNum dálkunum
flights[, c('DepTime', 'ArrTime', 'FlightNum')]

# dplyr leiðin:
select(flights, DepTime, ArrTime, FlightNum)

# smá svona "fancy stuff" hérna:
select(flights,Year:DayofMonth, contains('Taxi'), contains('Delay'))

#   Chaining and pipelining:
# hérna viljum við skoða UniqueCarrier og DepDelay þar sem seinkun(DepDelay) er meiri en klukkustund(60míon):
# Aðferð 1:
filter(select(flights,UniqueCarrier,DepDelay), DepDelay > 60)
# Aðferð 2, chaining
flights %>%
  select(UniqueCarrier,DepDelay) %>%
  filter(DepDelay > 60)
# ATH:  það má nota  %>% operatorinn annarsstaðar er í dplyr pakkanaum(%>% kemur úr öðrum pakka)

# Á ensku er %>% lesið sem "then"  sem gæti verið "og svo" á íslensku.
# Dæmið hér að ofan yrði þá:  flights og svo select-a UniqueCarrier,DepDelay og svo filtera DepDelay :-)

# --------------------------------------- arrange: röðun---------------------------------------

# "venjuleg" R aðferð við að raða:
flights[order(flights$DepDelay), c('UniqueCarrier','DepDelay')]

# dplyr leiðin:
flights %>%
  select(UniqueCarrier,DepDelay) %>%
  arrange(DepDelay)
# ef við viljum descending:
flights %>%
  select(UniqueCarrier,DepDelay) %>%
  arrange(desc(DepDelay))

# --------------------------------------- mutate: bæta við breytum(dálkum)---------------------------------------

# "venjuleg" R aðferð við að bæta við dálkum(breytum):
flights$Speed <- flights$Distance / flights$AirTime * 60
flights[,c('Distance','AirTime','Speed')]

# dplyr leiðin:
# Býr til Speed en vistar ekki í flights data.frame-inu!
flights %>%
  select(Distance,AirTime) %>%
  mutate(Speed = Distance / AirTime * 60)
# ef við viljum bæta Speed við flights þá erum við svona:
flights <- flights %>%
  mutate(Speed = Distance / AirTime * 60)

flights %>%
  select(Speed)

# --------------------------------------- summarise: summa upp dálka---------------------------------------

# ATH: summarise sem er skrifað með s en ekki z notar mikið group_by fallið!!!

# "venjuleg" R aðferð við að breikna meðalseinkun á komu flugvéla á sérhvern áfangastað:
head(with(flights, tapply(ArrDelay, Dest, mean, na.rm=TRUE)))
head(aggregate(ArrDelay ~ Dest, flights, mean))

# dplyr leiðin:
flights %>%
  group_by(Dest) %>%
  summarise(avg_delay = mean(ArrDelay,na.rm = TRUE))

# summarise_each leyfir að summarise sé keyrt á fleiri en einn dálk í einu!
# notum það til að finna hlutfall flugferða sem var aflýst eða beint annað(diverted)
flights %>%
  group_by(UniqueCarrier) %>%
  summarise_each(funs(mean), Cancelled, Diverted)

# nú reiknum við min og max seinkanir á brottför flugferða.
flights %>%
  group_by(UniqueCarrier) %>%
  summarise_each(funs(min(.,na.rm = TRUE), max(.,na.rm = TRUE)),matches('Delay'))

# tvær hjálpar- functions sem gott er að kunna:
# n()  Telur raðir í hverri grúppu(sem group_by skilar)
# n_distinct(vector) telur einkvæm gildi í vektor.
# Smá demonstration:
flights %>%
  group_by(Month, DayofMonth) %>%
  summarise(flight_count = n()) %>%
  arrange(desc(flight_count))

#einfaldari útgáfa:
flights %>%
  group_by(Month,DayofMonth) %>%
  tally(sort = TRUE)

# fyrir hvern áfangastað finnum við nú heildarfjölda flugferða og fjölda þeirra flugvéla sem
# flugu þangað(sama flugvélin aðeins talin einu sinni = distinct)
flights %>%
  group_by(Dest) %>%
  summarise(flight_count = n(), plane_count = n_distinct(TailNum))

# using group_by án þess að nota summarise.
flights %>%
  group_by(Dest) %>%
  select(Cancelled) %>%
  table() %>%
  head()

# svo má nota select distinct(svipað og í SQL)
flights %>%
  distinct(TailNum)

# það má svo nota summarise til að summa upp fjölda flugvéla
flights %>%
  summarise(n_distinct(TailNum))
