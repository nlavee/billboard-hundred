library(mosaic)

summary(topHundredExtended)

topHundred <- na.omit(topHundredExtended)
summary(topHundred)

colnames(topHundred)

## Fastats for all variables
favstats(topHundred$Year)
favstats(topHundred$WordCount)
favstats(topHundred$Weeks)
favstats(topHundred$Rank)

## Simple graphs
histogram( ~ WordCount, data = topHundred, v = mean(topHundred$WordCount))
bwplot(Decade ~ WordCount, data = topHundred)
densityplot( ~ WordCount, groups = Decade, data = topHundred, 
             xlim = c(0, 300), auto.key = TRUE)
histogram( ~ Weeks, data = topHundred, v = mean(topHundred$Weeks))
densityplot( ~ Weeks, groups = Decade, data = topHundred
             , auto.key = TRUE)
xyplot( WordCount ~ Year, data = topHundred)
