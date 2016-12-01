# This wrapper deals with taking in an csv and parsing it into pssp input format.
# Make sure the first column is the survival time of the patient
# make sure the second column is the censored boolean

import csv
import io

file_in = "data.csv"
file_out = "formatedData.csv"

outputFile = open(file_out, 'w+')

with open(file_in) as inputFile:
	data = inputFile.read().splitlines(1)
	data.pop(0)
	for line in data:
		array = line.split(",")
		outputFile.write(array[0] + " " + array[1])
		for index in range(2,len(array)):
			outputFile.write(" " + str(index) + ":" + array[index])
		# outputFile.write("\n")
outputFile.close()
