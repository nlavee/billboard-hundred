library(mosaic); library(dplyr); library(ggplot2)

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
ggplot(dataL, aes(WordCount, color = Decade)) + geom_density() + xlim(c(0,400))

ggplot(dataL, aes(Rank, WordCount, color = Decade)) + geom_point()

ggplot(dataL, aes(Decade, WordCount)) + geom_boxplot()
ggplot(dataL, aes(Decade, Weeks)) + geom_boxplot()

weekPerDecade <- dataL %>% group_by(Decade)
weekPerDecade <- weekPerDecade %>% summarize(avg_week = mean(Weeks))

ggplot(dataL, aes(Weeks, colour = Decade)) + geom_density()