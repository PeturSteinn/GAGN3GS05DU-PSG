#=========================================================================================
# Byggt á: R Basics - R Programming Language Introduction
#          Created by R-Tutorials Training
#          http://r-tutorials.com/home/   Sótt: 08.04.2019
#=========================================================================================

# plottum Lynx datasettið(sem er TimeSeries). default er plottað með
# línum(line plot)
plot(lynx)

# fiktum aðeins í útlitinu á plottinu.
# main=  setur fyrirsögn(texta) á plotið
# col= setur lit á plot- línuna/línurnar
# col.main= setur litinn á "fyrirsögnina" (hérna 52 sem er blár)
# cex.main= cex er stækkunarfaktorinn í R-plottum.  hérna er fyrirsögnin stækkuð um 0,5.
plot(lynx, main='Lynx trappings', col='red',col.main=52,cex.main=1.5)
# svo má setja litinn með nafni og stækka letrið í leiðinni
plot(lynx, main='Lynx trappings', col='red',col.main='orange',cex.main=2.5)

# merkingar(label names):
plot(lynx,ylab='Lynx Trappings',xlab='')

# uppsetning á merkingum(label orientation) Prófið líka las=0, las=1 og las=3.
plot(lynx,ylab='Lynx Trappings',xlab='', las=0)

# fallið par() er notað til að stilla plot fallið og glidir sú stilling sem sett er með par()
# út alla lotuna(session).
# hér fyrir neðan notum við par() til að birta 4 plot í einu og með rauðum texta.  
# Þegar þetta fall er keyr eitt og sér er ekki mikið að gerast sjónrænt.
par(mfrow=c(2,2),col.axis = 'red')

plot(1:8,las = 0,xlab = 'x-stuff',ylab = 'y-stuff', main = 'LAS = 0')
plot(1:8,las = 1,xlab = 'x-stuff',ylab = 'y-stuff', main = 'LAS = 1')
plot(1:8,las = 2,xlab = 'x-stuff',ylab = 'y-stuff', main = 'LAS = 2')
plot(1:8,las = 3,xlab = 'x-stuff',ylab = 'y-stuff', main = 'LAS = 3')

# upplýsingar um litaheiti og númer þeirra má fá með colors() fallinu.
colors()

# svo eru svokölluð benditákn(point symbols) líka til.  
# skoðum þeu með eftirfarandi:
?pch
# táknin eru númeruð frá 0 - 25.
# ATH:  það er hægt að lita tákn 21, 22, 23, 24 og 25!!
# prófum að breyta um tákn í plotti:
x2 <- c(1,4,8,2,9,3,3,7,8,1,0,5)
plot(x2, pch= 19)
# eða
plot(x2, pch= 8)
# eða
plot(x2, pch= 0)
# eða 
plot(x2, pch= 11)

# áður en lengra er haldið þá breytum við stillingunum á plot aftur í það sem þær voru.
par(mfrow=c(1,1),col.axis = 'black')

# það eru til ýmsar gerðir af plot sem hægt er að skoða með:
?plot

# prófum þetta:
plot(x2,type = 'p')
plot(x2,type = 'l')
plot(x2,type = 's')
plot(x2,type = 'h')

# notum nú ablineclip() fallið sem er í pakkanum plotrix.
# fallið teiknar lóðréttar línum á plott(skurðpunktar)
#fyrst þetta:
plot(1:7,ylab = '',main = 'Line types lty 0:6',xlab = 'lty 0:6')
# nú teiknum við lóðrétt. ATH að fyrsti parameterinn, v er gildið á x-ás plottsins
ablineclip(v=1,lty=1, col='sienna2',lwd=2)
ablineclip(v=2,lty=2, col='blue',lwd=2)
ablineclip(v=3,lty=3, col='green',lwd=2)
ablineclip(v=4,lty=4, col='orange',lwd=2)
ablineclip(v=5,lty=5, col='gray',lwd=2)
ablineclip(v=6,lty=6, col='sienna',lwd=2)

# Skoðum nú dæmi um það hvernig tvö sjálfstæð plott eru sett saman.  Hvort plottið' fyrir sig fær
# sér gildi á y-ásinn.
# datasettið sem þeir nota hér er cars sem hægt er að skoða:
cars

# jaðrar(margins) á plottinu stilltir
par(mar=c(4,3,3,3),col.axis='darkgreen')

# plottað(step plot) hraði í mph
plot(cars$speed, type = 's', col='red',bty='n',xlab = 'Cars ID',ylab = '')
# texti settur inná plottið. ATH: tölurnar 8 og 14 eru hnitin á textanum(þar sem hann byrjar)
text(8,14,'Speed in mph',cex = 0.85,col = 'red')
# nú á að setja annað plott á myndina þá þarf að fara í parametrana:
par(new = T)
# nýja plottið plottað!
plot(cars$dist,type = 's',bty='n',ann = F,axes = F,col='darkblue')
# nýr y-ás hægra megin fyrir bremsuvegalengdina(stopping distance)
axis(side = 4, col = 'darkblue')
# líka settur texti þar
text(37,18,'Stopping distance in ft',cex = 0.85, col = 'darkblue')
# heiti á plotti'
title(main = 'Speed and Stopping\n Distances of cars')


