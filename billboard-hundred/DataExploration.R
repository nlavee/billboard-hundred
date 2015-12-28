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
             xlim = c(0, 300), auto.key = TRUE,
             main = "Word Count for Different Decades")
histogram( ~ Weeks, data = topHundred, v = mean(topHundred$Weeks))
densityplot( ~ Weeks, groups = Decade, data = topHundred
             , auto.key = TRUE)
xyplot( WordCount ~ Year, data = topHundred)

## Confindence interval
sixties <- subset(topHundred, Decade == "1960s", replace = T)
seventies <- subset(topHundred, Decade == "1970s", replace = T)
eighties <- subset(topHundred, Decade == "1980s", replace = T)
nineties <- subset(topHundred, Decade == "1990s", replace = T)
twothousands <- subset(topHundred, Decade == "2000s", replace = T)
twotens <- subset(topHundred, Decade == "2010s", replace = T)

t.test(sixties$WordCount, conf.level = 0.95)$conf
t.test(seventies$WordCount, conf.level = 0.95)$conf
t.test(eighties$WordCount, conf.level = 0.95)$conf
t.test(nineties$WordCount, conf.level = 0.95)$conf
t.test(twothousands$WordCount, conf.level = 0.95)$conf
t.test(twotens$WordCount, conf.level = 0.95)$conf
