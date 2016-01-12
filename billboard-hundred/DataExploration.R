library(mosaic); library(dplyr)

# shorter name
dataL <- na.omit(topHundredExtended)

# get rid of songs without lyrics
dataL <- filter(dataL, WordCount > 0)

# per decade dataset
sixties <- filter(dataL, Decade == "1960s")
seventies <- filter(dataL, Decade == "1970s")
eighties <- filter(dataL, Decade == "1980s")
nineties <- filter(dataL, Decade == "1990s")
twothousands <- filter(dataL, Decade == "2000s")
twotens <- filter(dataL, Decade == "2010s")

# favstats
favstats(dataL$Weeks)
favstats(dataL$Rank)
favstats(dataL$WordCount)

# exploratory graph
densityplot( ~ WordCount, data = dataL, 
             groups = Decade, xlim = c(0,350),
             auto.key = TRUE)

xyplot(Rank ~ WordCount, data = dataL, groups = Decade)

bwplot( WordCount ~ Decade, data = dataL)
