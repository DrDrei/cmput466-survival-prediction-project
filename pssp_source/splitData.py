import csv
import io
import sys, getopt
import numpy as np
import os, shutil
import glob
import csv

cancerPath = '/cancerTypes'
dataPath = '/cancerTypes/data'
splitFolderArray = ['/test','/train','/stack']

extension = '.csv'

firstLayerSplit = 0.6
secondLayerSplit = 0.8

def writeToFile(file, line):
	array = line.split(",")
	file.write(array[0] + " " + array[1])
	for index in range(2,len(array)):
		file.write(" " + str(index) + ":" + array[index])

def initFolder(folderPath):
	if not os.path.exists(folderPath):
		os.makedirs(folderPath)
	for file in os.listdir(folderPath):
		filePath = os.path.join(folderPath, file)
		try:
			if os.path.isfile(filePath):
				os.unlink(filePath)
		except Exception as e:
			print(e)

def main(argv):
	data_path = os.path.dirname(os.path.abspath(__file__)) + dataPath
	cancer_path = os.path.dirname(os.path.abspath(__file__)) + cancerPath
	os.chdir(data_path)

	for folder in splitFolderArray:
		initFolder(cancer_path + folder)
	
	for filename in os.listdir(data_path):
		print(filename)
		if extension in filename:
			with open(filename) as file:
				filenameFirst = filename[:-4] + "T.txt"
				filenameSecond = filename[:-4] + "R.txt"
				filenameThird = filename[:-4] + "Split.csv"

				firstFile = open(filenameFirst, 'w+')
				secondFile = open(filenameSecond, 'w+')
				thirdFile = open(filenameThird, 'w+')

				data = file.read().splitlines(1)
				dataHeader = data.pop(0)
				thirdFile.write(dataHeader)

				count = 0
				for line in data:
					count += 1
					if (count < len(data)*firstLayerSplit):
						writeToFile(firstFile, line+"")
					elif (count < len(data)*secondLayerSplit):	
						writeToFile(secondFile, line+"")
					else:
						thirdFile.write(line+"")

				
				shutil.move(filenameFirst, cancer_path + splitFolderArray[0])
				shutil.move(filenameSecond, cancer_path + splitFolderArray[1])
				shutil.move(filenameThird, cancer_path + splitFolderArray[2])

if __name__ == "__main__":
   main(sys.argv[1:])