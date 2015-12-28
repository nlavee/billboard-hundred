from bs4 import BeautifulSoup, Comment
import csv
import requests
import urllib
import re
import sys

"""

	Python script to get lyrics of each song from the csv
	file of hot 100 from 1960 till 2015.

	THe script first reads in song title and artist from 
	external csv file. After that, make requests to lyrics.wikia.com
	for the lyrics. Request call returns snippet of lyrics and 
	url to the full lyrics.

	Use Beautifulsoup to get the lyrics. Did some regex to 
	match pattern to get actual song lyrics. For those whose
	lyrics are unavailable, get count as N/A.

	From lyrics, run count of distinctive words for each song 
	and create a new csv file with count of distinctive words as
	a new column for each song.

	Added another column based on year to reflect the era, 
	e.g. 60s, 70s, 80s, etc.

	Apparently, those with copyright issues have 28 words. Remember
	to double check before using them for analysis

"""


reload(sys)
sys.setdefaultencoding('utf-8') # Avoiding encoding errors
url = 'http://lyrics.wikia.com/api.php?'

## input csv
inputFile = open('topHundred.csv', 'rb')
reader = csv.reader(inputFile)
firstLine = True

## output csv
# outputFile = open('topHundredExtended.csv', 'w')
outputFile = open('topHundredExtended.csv', 'a') # Used if writing is disrupted midway
outputWriter = csv.writer(outputFile)
outputWriter.writerow( ('Year', 'Title', 'Artist', 'Weeks', 'Rank', 'WordCount', "Decade") )

## Tags that should be processed differently
illegal_tag = [ "span", "p", "a", "img", "sup", "hr", "u", "div", "small" ]
formatting_tag = [ "b", "i" ]

## Get url to wiki page with full lyrics: 
## http://api.wikia.com/wiki/LyricWiki_API
rowcount = 0

for row in reader:
	rowcount = rowcount +1

	if rowcount < 5410: # Picked up from where writing was disrupted
		continue
	# if firstLine:
	# 	firstLine = False
	# 	continue
	else:
		year = row[0]
		print "CURRENT ROW: " + str(rowcount) + " -- YEAR: " + str(year)
		print

		title = row[1].replace (" ", "_")
		artist = row[2].replace (" ", "_")
		weeks = row[3]
		rank = row[4]
		word_count = "N/A"
		#print title + ' -- ' + artist
		
		data = 'action=lyrics&artist=' + artist + '&song=' + title + '&fmt=xml'
		response =  requests.get(url, params=data)
		# print response.url
		# print response.text
		soup = BeautifulSoup(response.text, 'xml')
		url_full_container = soup.findAll('url')
		if len(url_full_container) > 0:
			url_full = url_full_container[0].string

			print url_full

			r = urllib.urlopen(url_full).read()
			soup = BeautifulSoup(r, "html.parser")

			#print soup.prettify()

			for script in soup.find_all('script'):
				script.extract()

			for lyricsbreak in soup.find_all('div', class_='lyricsbreak'):
				lyricsbreak.extract()
			
			lyrics_div = soup.find('div', class_='lyricbox')
			if lyrics_div:
				for element in lyrics_div(text=lambda text: isinstance(text, Comment)):
					element.extract()
				lyrics_json = lyrics_div.contents

				word_list = []

				for ele in lyrics_json:
					filter_list = '<br/>'
					print ele
					if str(ele).encode('utf-8').strip() != filter_list:
						if ele.name in illegal_tag:
							break
						if ele:
							if ele.name in formatting_tag:
								ele = ele.get_text()
							if ele == "Unfortunately, we are not licensed to display the full lyrics for this song at the moment. Hopefully we will be able to in the future. Until then... how about a ":
								break
							wordList = ele.split()
							for word in wordList:
								trimmed_word = word.replace(',', '').replace('.', '').upper()
								print trimmed_word
								if trimmed_word not in word_list:
									word_list.append(trimmed_word)
				word_count = len(word_list)
				print word_count

		decade = "1960s"
		if int(year) < 1970:
			decade = "1960s"
		elif int(year) < 1980:
			decade = "1970s"
		elif int(year) < 1990:
			decade = "1980s"
		elif int(year) < 2000:
			decade = "1990s"
		elif int(year) < 2010:
			decade = "2000s"
		else:
			decade = "2010s"

		outputWriter.writerow( (year, row[1], row[2], weeks, rank, word_count, decade.encode(encoding='UTF-8',errors='strict')) )	


		print
		print("(########################################################)")
		print

print "FINISH"