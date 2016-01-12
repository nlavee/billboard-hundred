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

ggplot(dataL, aes(Rank, WordCount, colour = Decade)) + geom_smooth(method="lm", se = FALSE)

top25 <- filter(dataL, Rank <= 25)
ggplot(top25, aes(Rank, WordCount, colour = Decade)) + geom_smooth(method="lm", se = FALSE)

## Word Count over Time
topWordCount <- filter(dataL, WordCount >= 450)
ggplot(dataL, aes(Year, WordCount)) + 
  geom_point() + 
  geom_smooth(method="lm", se = FALSE) + 
  geom_text(data = topWordCount, aes(Year, WordCount, label = paste(Title, "(", as.character(WordCount), ")")), vjust = -1) + 
  labs( title = "Word Count of Billboard Top 100 songs over the year")


ggplot(dataL, aes(Artist)) + geom_bar() + coord_flip() ## too big, not very useful


## Top artist for each generation

#1960s
topArtist1960s <- sixties %>% group_by(Artist) %>%
  summarize(count_billboard = n()) %>%
  filter(count_billboard >= 6) %>%
  arrange(desc(count_billboard))

nrow(topArtist1960s)

ggplot(topArtist1960s, aes(x = factor(Artist), y = count_billboard, label = count_billboard)) + 
  geom_bar(stat = "identity", fill = "cornflowerblue") + 
  geom_label(aes(y = count_billboard + 0.5)) + 
  labs( title = "Top Artist in the 1960s", x = "Artist", y="Count on Billboard") + coord_flip()

#1970s
topArtist1970s <- seventies %>% group_by(Artist) %>%
  summarize(count_billboard = n()) %>%
  filter(count_billboard >= 6) %>%
  arrange(desc(count_billboard))

nrow(topArtist1970s)

ggplot(topArtist1970s, aes(x = factor(Artist), y = count_billboard, label = count_billboard)) + 
  geom_bar(stat = "identity", fill = "cornflowerblue") + 
  geom_label(aes(y = count_billboard + 0.5)) + 
  labs( title = "Top Artist in the 1970s", x = "Artist", y="Count on Billboard") + coord_flip()


#1980s
topArtist1980s <- eighties %>% group_by(Artist) %>%
  summarize(count_billboard = n()) %>%
  filter(count_billboard >= 6) %>%
  arrange(desc(count_billboard))

nrow(topArtist1980s)

ggplot(topArtist1980s, aes(x = factor(Artist), y = count_billboard, label = count_billboard)) + 
  geom_bar(stat = "identity", fill = "cornflowerblue") + 
  geom_label(aes(y = count_billboard + 0.5)) + 
  labs( title = "Top Artist in the 1980s", x = "Artist", y="Count on Billboard") + coord_flip()


#1990s
topArtist1990s <- nineties %>% group_by(Artist) %>%
  summarize(count_billboard = n()) %>%
  filter(count_billboard >= 5) %>%
  arrange(desc(count_billboard))

nrow(topArtist1990s)

ggplot(topArtist1990s, aes(x = factor(Artist), y = count_billboard, label = count_billboard)) + 
  geom_bar(stat = "identity", fill = "cornflowerblue") + 
  geom_label(aes(y = count_billboard + 0.5)) + 
  labs( title = "Top Artist in the 1990s", x = "Artist", y="Count on Billboard") + coord_flip()


#2000s
topArtist2000s <- twothousands %>% group_by(Artist) %>%
  summarize(count_billboard = n()) %>%
  filter(count_billboard >= 7) %>%
  arrange(desc(count_billboard))

nrow(topArtist2000s)

ggplot(topArtist2000s, aes(x = factor(Artist), y = count_billboard, label = count_billboard)) + 
  geom_bar(stat = "identity", fill = "cornflowerblue") + 
  geom_label(aes(y = count_billboard + 0.5)) + 
  labs( title = "Top Artist in the 2000s", x = "Artist", y="Count on Billboard") + coord_flip()

#2010s
topArtist2010s <- twotens %>% group_by(Artist) %>%
            summarize(count_billboard = n()) %>%
            filter(count_billboard >= 5) %>%
            arrange(desc(count_billboard))

nrow(topArtist2010s)

ggplot(topArtist2010s, aes(x = factor(Artist), y = count_billboard, label = count_billboard)) + 
  geom_bar(stat = "identity", fill = "cornflowerblue") + 
  geom_label(aes(y = count_billboard + 0.5)) + 
  labs( title = "Top Artist in the 2010s", x = "Artist", y="Count on Billboard") + coord_flip()



