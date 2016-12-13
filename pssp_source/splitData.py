import csv
import io
import sys, getopt
import numpy as np
import os, shutil
import glob
import csv

cancerPath = '/cancerTypes'
dataPath = '/cancerTypes/data'
testDataPath = '/cancerTypes/testData'
stackDataPath = '/cancerTypes/stackData'
splitFolderArray = ['/train','/test','/stack']

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
	testData_path = os.path.dirname(os.path.abspath(__file__)) + testDataPath
	stackData_path = os.path.dirname(os.path.abspath(__file__)) + stackDataPath

	os.chdir(data_path)

	for folder in splitFolderArray:
		initFolder(cancer_path + folder)
	
	for filename in os.listdir(data_path):
		print(filename)
		if extension in filename:
			with open(filename) as file:
				filenameTrain = filename[:-4] + "R.txt"
				filenameTest = filename[:-4] + "T.txt"
				filenameStackCSV = filename[:-4] + "Stack.csv"
				filenameStackTXT = filename[:-4] + "S.txt"

				trainFile = open(filenameTrain, 'w+')
				testFile = open(filenameTest, 'w+')
				stackFileCSV = open(filenameStackCSV, 'w+')
				stackFileTXT = open(filenameStackTXT, 'w+')

				filenameTestExp = filename[:-4] + "Texpected.txt"
				filenameStackExp = filename[:-4] + "Sexpected.txt"

				testExpFile = open(filenameTestExp, 'w+')
				stackExpFile = open(filenameStackExp, 'w+')

				data = file.read().splitlines(1)
				dataHeader = data.pop(0)
				stackFileCSV.write(dataHeader)

				count = 0
				for line in data:
					count += 1
					arrayData = line.split(",")
					if (count < len(data)*firstLayerSplit):
						writeToFile(trainFile, line+"")
					elif (count < len(data)*secondLayerSplit):	
						if (arrayData[1] == '0'): # filter by cencored patients
							writeToFile(testExpFile, arrayData[0] + ",\n")
							writeToFile(testFile, line+"")
					else:
						writeToFile(stackExpFile, arrayData[0] + ",\n")
						writeToFile(stackFileTXT, line+"")
						stackFileCSV.write(line+"")

				
				shutil.move(filenameTrain, cancer_path + splitFolderArray[0])
				shutil.move(filenameTest, cancer_path + splitFolderArray[1])
				shutil.move(filenameStackCSV, cancer_path + splitFolderArray[2])
				shutil.move(filenameStackTXT, cancer_path + splitFolderArray[2])


				shutil.move(filenameTestExp, testData_path + splitFolderArray[1])
				shutil.move(filenameStackExp, stackData_path + splitFolderArray[2])

if __name__ == "__main__":
   main(sys.argv[1:])