UK_DOSI <- UKDriverDeaths

# Row/dálka heiti
m_mon <- c('Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec')
m_yrs <- c(1969:1984)

# Converta draslinu í matrix með viðeigandi mikið af rows/columns
m_dosi <- matrix(UK_DOSI,length(m_yrs),length(m_mon))

# Setja row/column heitin sem ár/mánuðir
rownames(m_dosi) <- m_yrs
colnames(m_dosi) <- m_mon

# ----- 1. ----- #

library(xts)

# Converta yfir í xts
xts.dosi <- as.xts(UKDriverDeaths)

# Filtera
# Einungis innihalda observations sem eru með >= 2000 slys
xts.dosi.2k <- xts.dosi[xts.dosi >= 2000]

# Merkja dálkinn sem slys
colnames(xts.dosi.2k) <- "Accidents"

# Sýna niðurstöður
xts.dosi.2k

# ----- 2. ----- #

# Sýna niðurstöður

# Árlegt meðaltal
rowMeans(m_dosi)

# Mánaðarlegt meðalal
colMeans(m_dosi)

# ----- 3. ----- #

# Lesa inn mannsfjölda dataset
countries.pop <- read.csv("population_countries.csv", header = TRUE)

# Gera heitið á þjóðinni nafnið á observation, til þess að létta fyrir leit
rownames(countries.pop) <- as.vector(countries.pop$Country.Name)

# Sækja fólksfjölda í UK á árunum 1969 - 1984 og setja í vector
uk.pop <- as.numeric(countries.pop["United Kingdom",c(14:29)])

# Sækja total slys per ár og setja í vector
yearly.dosi <- as.numeric(rowSums(m_dosi))

# Reikna út % ratio á milli fólksfjölda og slysa á hverju ári
yearly.dosi.ratio <- yearly.dosi / uk.pop

# Setja nöfn á vectorana (auðveldar að skoða vectorinn)
names(yearly.dosi.ratio) <- m_yrs
names(yearly.dosi) <- m_yrs
names(uk.pop) <- m_yrs

# Sýna niðurstöður
paste(round(yearly.dosi.ratio * 100, digits=4), '%', sep = '')

# ----- 4. ----- #

# Sækja Íslenska íbúafjölda á milli 1969 - 1984
iceland.pop <- as.numeric(countries.pop["Iceland",c(14:29)])

# Setja ár sem labels
names(iceland.pop) <- m_yrs

# "Population Ratio"
# Reikna hlutfallið á UK og Íslandi, bæta svo við "1/" (einn Íslendingur fyrir x Englendinga)
uk.iceland.ratio <- paste("1/", round(uk.pop / iceland.pop), sep="") # Population Ratio

# "Iceland Accidents"
# Reikna slys á Íslandi miðað við hlutfall
# UK_Slys * (íbúarfjöldi Íslendinga / íbúarfjöldi Englendinga)
calc.iceland.dosi <- round(yearly.dosi * (iceland.pop / uk.pop)) # Iceland accidents

# Comparison iceland/uk dataframe búinn til
# Splæsa saman þessum þremur vectors í eitt dataframe
comp.ice.uk.df <- cbind.data.frame(calc.iceland.dosi, yearly.dosi, uk.iceland.ratio)

# Setja almennileg heiti á columns
colnames(comp.ice.uk.df) <- c("Iceland Accidents", "United Kingdom Accidents", "Population Ratio")

# Sýna niðurstöður
comp.ice.uk.df

# ----- 5. ----- #
