import csv
import io
import sys, getopt
import numpy as np
import os, shutil
import glob

path = '/cancerTypes'

firstLayerPath = '/firstLayer'
secondLayerPath = '/secondLayer'
thirdLayerPath = '/thirdLayer'

extension = '.csv'

firstLayerSplit = 0.6
secondLayerSplit = 0.8

def writeToFile(file, line):
	array = line.split(",")
	file.write(array[0] + " " + array[1])
	for index in range(2,len(array)):
		file.write(" " + str(index) + ":" + array[index])


def main(argv):
	print("test")
	full_path = os.path.dirname(os.path.abspath(__file__)) + path
	os.chdir(full_path)
	print(full_path)
	for filename in os.listdir(full_path):
		print(filename)
		if ".csv" in filename:
			with open(filename) as file:
				filenameFirst = filename[:-4] + "1.txt"
				filenameSecond = filename[:-4] + "2.txt"
				filenameThird = filename[:-4] + "3.txt"

				firstFile = open(filenameFirst, 'w+')
				secondFile = open(filenameSecond, 'w+')
				thirdFile = open(filenameThird, 'w+')
				print(file)
				data = file.read().splitlines(1)
				data.pop(0)

				count = 0
				for line in data:
					count += 1
					if (count < len(data)*firstLayerSplit):
						writeToFile(firstFile, line)
					elif (count < len(data)*secondLayerSplit):	
						writeToFile(secondFile, line)
					else:
						writeToFile(thirdFile, line)

				shutil.move(filenameFirst, full_path+"/split1")
				shutil.move(filenameSecond, full_path+"/split2")
				shutil.move(filenameThird, full_path+"/split3")

if __name__ == "__main__":
   main(sys.argv[1:])