CC=g++
CFLAGS=-O3
#CFLAGS=-g -Wall
LD=g++
LDFLAGS=-O3
PY=python
#LDFLAGS=-g
TRAIN_FILES 		:= $(wildcard cancerTypes/train/*.txt)
MODEL_FILES 		:= $(wildcard cancerTypes/train/*.model)
TEST_FILES  		:= $(wildcard cancerTypes/test/*.txt)
STACK_FILES  		:= $(wildcard cancerTypes/stack/*.txt)

TEST_NAMES			:= $(basename $(notdir $(TEST_FILES)))
MODEL_NAMES 		:= $(basename $(notdir $(MODEL_FILES)))
STACK_NAMES			:= $(basename $(notdir $(STACK_FILES)))


all: mtlr_train mtlr_test

clean:
	rm -f mtlr_train mtlr_test *.o testWrapperData.csv trainWrapperData.csv allWrapperData.csv Output.txt *.model *.test *.train *.interval
	rm -f -rf cancerTypes/train cancerTypes/test cancerTypes/stack
	rm -f cancerTypes/testData/*.txt cancerTypes/stackData/*.txt

mtlr_train: Sparm.o DenseVector.o SparseVector.o common.o Main.o 
	$(LD) $(LDFLAGS) Sparm.o DenseVector.o SparseVector.o common.o Main.o  -o mtlr_train

mtlr_test: Test.o Sparm.o DenseVector.o SparseVector.o common.o 
	$(LD) $(LDFLAGS) Test.o Sparm.o DenseVector.o SparseVector.o common.o  -o mtlr_test

data:
	$(PY) splitData.py

train:
	$(foreach var, $(TRAIN_FILES), ./mtlr_train -i $(var) -o $(basename $(var)).model;)
	
test:
	@for testname in $(TEST_NAMES); do \
		for model in $(MODEL_NAMES); do \
			./mtlr_test -i cancerTypes/test/$${testname}.txt -o cancerTypes/train/$${model}.model -f cancerTypes/testData/$${testname}_$${model}.txt; \
		done; \
	done

stack:
	@for stackname in $(STACK_NAMES); do \
		for model in $(MODEL_NAMES); do \
			./mtlr_test -i cancerTypes/stack/$${stackname}.txt -o cancerTypes/train/$${model}.model -f cancerTypes/stackData/$${stackname}_$${model}.txt; \
		done; \
	done

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
