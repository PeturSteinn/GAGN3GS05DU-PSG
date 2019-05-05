# viljum testa hvort hægt sé að:
#   a) nota texta sem merkingar á x-ásnum
#   b) teikna fleiri en eina línu inná sama grafið

# búum þess vegna til prófunargögn
months <- c('jan','feb','mar','apr','may','jun','jul','aug','sep','oct','nov','dec')
data1 <- c(99,96,94,90,89,87,87,85,82,80,79,77)
data2 <- c(85,83,82,81,80,79,80,81,79,78,76,75)

# byrjum svo á því að plotta fyrstu línuna með gögnum úr data1 og stillum það sem þarf að stilla:
# ath1: ylim = c(70,100) setur min og max gildi á y-ásinn.
# ath2: það þarf að hindra að x-ásinn sé merktur og það er gert með xaxt = 'n'
plot(data1, xaxt = 'n', type = 'l', xlab = 'Months', col = 'darkblue', ylim = c(70,100))
# lína plottuð ,með gögnum úr data2
lines(xaxt = 'n', data2, col = 'red')
# hérna eru svo mánaðaheitin sett á x-ásinn.
axis(1, at=1:12, labels = months)