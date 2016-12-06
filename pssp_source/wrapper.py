# This wrapper deals with taking in an csv and parsing it into pssp input format.
# Make sure the first column is the survival time of the patient
# make sure the second column is the censored boolean
# -t: slits the data as per _PERCENT_SPLIT ratio into test/train files.
# -a: formats the entire data set into pssp format

# USERFUL TERMINAL FUNCTIONS
# Compiles test/train data from CANCERDATA.csv
# 	python wrapper.py -t
# trains the data
# 	./mtlr_train -c 10 -d 1 -m 60 -i trainWrapperData.csv -o example.model
# tests the data with L1 loss
# 	./mtlr_test -p -m 60 -i testWrapperData.csv -o example.model

import csv
import io
import sys, getopt
import numpy as np
import os, shutil

PERCENT_SPLIT = 0.8

def writeToFile(file, line):
	array = line.split(",")
	file.write(array[0] + " " + array[1])
	for index in range(2,len(array)):
		file.write(" " + str(index) + ":" + array[index])

def main(argv):
	try:
		options, args = getopt.getopt(argv, "ta",["ifile="])

	except:
		print("Nope. Did something wrong.")


	file_in = "CANCERDATA.csv"
	for option, args in options:
		if (option == '-t'):
			file_train = "trainWrapperData.csv"
			file_test = "testWrapperData.csv"

			outputTrain = open(file_train, 'w+')
			outputTest = open(file_test, "w+")

			with open(file_in) as inputFile:
				print("Compiling train/test data.")
				data = inputFile.read().splitlines(1)
				data.pop(0)
				for line in data:
					if (np.random.random_sample() > PERCENT_SPLIT):
						writeToFile(outputTest, line)
					else:
						writeToFile(outputTrain, line)
			outputTest.close()
			outputTrain.close()

		elif (option == '-a'):
			file_out = "allWrapperData.csv"

			outputFile = open(file_out, 'w+')

			with open(file_in) as inputFile:
				print("Compiling all data.")
				data = inputFile.read().splitlines(1)
				data.pop(0)
				for line in data:
					writeToFile(outputFile, line)
			outputFile.close()


if __name__ == "__main__":
   main(sys.argv[1:])