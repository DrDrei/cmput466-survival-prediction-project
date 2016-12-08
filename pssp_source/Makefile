CC=g++
CFLAGS=-O3
#CFLAGS=-g -Wall
LD=g++
LDFLAGS=-O3
PY=python
#LDFLAGS=-g
DIR1=/cancerTypes/split1/
DIR2=/cancerTypes/split2/
DIR3=/cancerTypes/split3/
IN_FILES := $(wildcard cancerTypes/split2/*.txt)
OUT_TEST := $(wildcard cancerTypes/split1/*.model)
OUT_FILES := $(patsubst cancerTypes/split1/%.txt, cancerTypes/split1/%.model, $(wildcard cancerTypes/split1/*.txt))

.PHONY: train

all: mtlr_train mtlr_test

clean:
	rm -f mtlr_train mtlr_test *.o testWrapperData.csv trainWrapperData.csv allWrapperData.csv Output.txt example.model

mtlr_train: Sparm.o DenseVector.o SparseVector.o common.o Main.o 
	$(LD) $(LDFLAGS) Sparm.o DenseVector.o SparseVector.o common.o Main.o  -o mtlr_train

mtlr_test: Test.o Sparm.o DenseVector.o SparseVector.o common.o 
	$(LD) $(LDFLAGS) Test.o Sparm.o DenseVector.o SparseVector.o common.o  -o mtlr_test


wrappera: 
	$(PY) wrapper.py -a
wrappert: 
	$(PY) wrapper.py -t
testNtrain:
	./mtlr_train -m 60 -i trainWrapperData.csv -o example.model
	./mtlr_test -p -m 60 -i testWrapperData.csv -o example.model
	# ./mtlr_test -p -m 60 -i patientZero.csv -o example.model
train: $(IN_FILES)
	./mtlr_train -m 60 -i $(IN_FILES) -o $(basename $(IN_FILES)).model
Test.o:
	$(CC) -c $(CFLAGS) Test.cpp -o Test.o
Sparm.o:
	$(CC) -c $(CFLAGS) Sparm.cpp -o Sparm.o
DenseVector.o:
	$(CC) -c $(CFLAGS) DenseVector.cpp -o DenseVector.o
SparseVector.o:
	$(CC) -c $(CFLAGS) SparseVector.cpp -o SparseVector.o
common.o:
	$(CC) -c $(CFLAGS) common.cpp -o common.o
Main.o:
	$(CC) -c $(CFLAGS) Main.cpp -o Main.o
