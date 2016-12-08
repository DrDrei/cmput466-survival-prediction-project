'''
This function simply grabs the first element in each line of a text file and prints that element to a new file called first_elements.txt
December 8th, 2016
'''
import sys
import re

class FileParser():
    def __init__(self, file_name):
        self.raw = self.read_file(file_name)
        self.FirstElements = []
        self.get_firstItem(self.raw)
        self.print_file(self.FirstElements)

    def read_file(self, file_name):
        with open(file_name, "r") as f:
            return f.read()

    def get_firstItem(self,raw_text_input):
        raw_text_input = raw_text_input.strip()
        lines = raw_text_input.split("\n")
        for line in lines:
            line = line.split(" ")
            self.FirstElements.append(line[0])

    def print_file(self,list_to_print):
        with open('first_elements.txt', 'w') as f:
            for i in self.FirstElements:
                f.write(str(i)+"\n")
        f.close()

if __name__ == "__main__":
    parser = FileParser(sys.argv[1])



