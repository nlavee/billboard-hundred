import csv
import billboard

"""

	Python script that runs through billboard hot 100 chart
	and collect the title, artist, weeks on the chart and 
	ranking for the 100 songs each year from 1960 till 2015.

	Output is a csv file consisting of the songs' information
	
"""

years = 1960
yearlyCollection = {}

## Getting songs for each year using billboard API
while years < 2016:
	day = 31
	dateRequest = str(years) + '-12-' + str(day)
	print dateRequest
	chart = billboard.ChartData(name = 'hot-100', date = dateRequest)
	while len(chart) == 0:
		day = day - 1
		dateRequest = str(years) + '-12-' + str(day)
		print "switch date -- " + str(dateRequest)
		chart = billboard.ChartData(name = 'hot-100', date = dateRequest)	
		yearlyCollection[years] = chart
	else:
		print len(chart)
		yearlyCollection[years] = chart
	years = years + 1


## Write data out to a csv file
outputFile = open('topHundred.csv', 'w')
outputWriter = csv.writer(outputFile)
outputWriter.writerow( ('Year', 'Title', 'Artist', 'Weeks', 'Rank') )

for year in yearlyCollection:
	print str(year) + ' -> start'
	chart = yearlyCollection[year]
	index = 0
	while index < len(chart):
		song = chart[index]
		outputWriter.writerow( ( year, song.title.encode(encoding='UTF-8',errors='strict'), song.artist.encode(encoding='UTF-8',errors='strict'), song.weeks, song.rank) )		
		index = index + 1
	print str(year) + ' -> end'

print "Finish"