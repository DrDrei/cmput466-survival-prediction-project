# CMPUT466 Term Project
# December 6th, 2016
# The command to run this sample R program from the command line is as follows:
# TO RUN
# Rscript --vanilla test1.R
library("parallel")
library("randomForestSRC")
library("doParallel")

#Read in the data for training tree models 75% of 80%
data1 = read.csv("ALL_DATA1.csv")
data2 = read.csv("STAGES_121.csv")
data3 = read.csv("STAGES_31.csv")
data4 = read.csv("STAGES_41.csv")
data5 = read.csv("STAGES_12_TYPE_EBHM1.csv")
data6 = read.csv("STAGES_12_TYPE_OCSP1.csv")
data7 = read.csv("STAGES_3_TYPE_EBHM1.csv")
data8 = read.csv("STAGES_3_TYPE_OCSP1.csv")
data9 = read.csv("STAGES_4_TYPE_EBHM1.csv")
data10 = read.csv("STAGES_4_TYPE_OCSP1.csv")

#Read in the data for training the stacking models from the tree models 25% of 80%
data11 = read.csv("ALL_DATA2.csv")
data12 = read.csv("STAGES_122.csv")
data13 = read.csv("STAGES_32.csv")
data14 = read.csv("STAGES_42.csv")
data15 = read.csv("STAGES_12_TYPE_EBHM2.csv")
data16 = read.csv("STAGES_12_TYPE_OCSP2.csv")
data17 = read.csv("STAGES_3_TYPE_EBHM2.csv")
data18 = read.csv("STAGES_3_TYPE_OCSP2.csv")
data19 = read.csv("STAGES_4_TYPE_EBHM2.csv")
data20 = read.csv("STAGES_4_TYPE_OCSP2.csv")

#Read in the data for training the stacking models from the MTLR models 25% of 80%
# MTLR (PSSP) Output for Training Linear Reg. Model
indata1 = read.table("ALL_DATA.txt")
indata2 = read.table("STAGES_12.txt")
indata3 = read.table("STAGES_3.txt")
indata4 = read.table("STAGES_4.txt")
indata5 = read.table("STAGES_12_TYPE_EBHM.txt")
indata6 = read.table("STAGES_12_TYPE_OCSP.txt")
indata7 = read.table("STAGES_3_TYPE_EBHM.txt")
indata8 = read.table("STAGES_3_TYPE_OCSP.txt")
indata9 = read.table("STAGES_4_TYPE_EBHM.txt")
indata10 = read.table("STAGES_4_TYPE_OCSP.txt")

#Read in the true survival times for training the stacking models using linear regression
indata11 = read.table("fe_all2")
indata12 = read.table("fe_st122")
indata13 = read.table("fe_st32")
indata14 = read.table("fe_st42")
indata15 = read.table("fe_st12te")
indata16 = read.table("fe_st12to")
indata17 = read.table("fe_st3te")
indata18 = read.table("fe_st3to")
indata19 = read.table("fe_st4te")
indata20 = read.table("fe_st4to")

#Read in the data for testing the stacking models from the tree models 20% of the data
# Input for Stacking and Backoff Model Testing (Input to trees and MTLR)
data21 = read.csv("ALL_DATA_Test.csv")
data22 = read.csv("STAGES_12_Test.csv")
data23 = read.csv("STAGES_3_Test.csv")
data24 = read.csv("STAGES_4_Test.csv")
data25 = read.csv("STAGES_12_TYPE_EBHM_Test.csv")
data26 = read.csv("STAGES_12_TYPE_OCSP_Test.csv")
data27 = read.csv("STAGES_3_TYPE_EBHM_Test.csv")
data28 = read.csv("STAGES_3_TYPE_OCSP_Test.csv")
data29 = read.csv("STAGES_4_TYPE_EBHM_Test.csv")
data30 = read.csv("STAGES_4_TYPE_OCSP_Test.csv")

#Get training and test data, we will use 50% to train and 50% to test
# train <- sample(1:nrow(data1), round(nrow(data1) * 0.50))

#################################
#Build models using 75% of 80% of the data
m1.obj <- rfsrc(Surv(SURVIVAL, CENSORED) ~ ., data = data1, splitrule = "logrank", ntree = 300, tree.err=TRUE)
m2.obj <- rfsrc(Surv(SURVIVAL, CENSORED) ~ ., data = data2, splitrule = "logrank", ntree = 300, tree.err=TRUE)
m3.obj <- rfsrc(Surv(SURVIVAL, CENSORED) ~ ., data = data3, splitrule = "logrank", ntree = 300, tree.err=TRUE)
m4.obj <- rfsrc(Surv(SURVIVAL, CENSORED) ~ ., data = data4, splitrule = "logrank", ntree = 300, tree.err=TRUE)
m5.obj <- rfsrc(Surv(SURVIVAL, CENSORED) ~ ., data = data5, splitrule = "logrank", ntree = 300, tree.err=TRUE)
m6.obj <- rfsrc(Surv(SURVIVAL, CENSORED) ~ ., data = data6, splitrule = "logrank", ntree = 300, tree.err=TRUE)
m7.obj <- rfsrc(Surv(SURVIVAL, CENSORED) ~ ., data = data7, splitrule = "logrank", ntree = 300, tree.err=TRUE)
m8.obj <- rfsrc(Surv(SURVIVAL, CENSORED) ~ ., data = data8, splitrule = "logrank", ntree = 300, tree.err=TRUE)
m9.obj <- rfsrc(Surv(SURVIVAL, CENSORED) ~ ., data = data9, splitrule = "logrank", ntree = 300, tree.err=TRUE)
m10.obj <- rfsrc(Surv(SURVIVAL, CENSORED) ~ ., data = data10, splitrule = "logrank", ntree = 300, tree.err=TRUE)


############################################################################
#Predict using 25% of 80% of data to verify model and then train stacking
p1.obj <- predict.rfsrc(m1.obj, data11)
p2.obj <- predict.rfsrc(m2.obj, data12)
p3.obj <- predict.rfsrc(m3.obj, data13)
p4.obj <- predict.rfsrc(m4.obj, data14)
p5.obj <- predict.rfsrc(m5.obj, data15)
p6.obj <- predict.rfsrc(m6.obj, data16)
p7.obj <- predict.rfsrc(m7.obj, data17)
p8.obj <- predict.rfsrc(m8.obj, data18)
p9.obj <- predict.rfsrc(m9.obj, data19)
p10.obj <- predict.rfsrc(m10.obj, data20)

# Linear Regression Model, - Stacking Layer - Train using 25% of 80% of data
# Model - s12_OCSP
# Training data here must be from s12_OCSP run through the s12_OCSP model, the s12 model and the all data model
s12_OCSP_data = cbind(indata1,indata2,indata6)
s12_OCSP=lm(SURVIVAL~indata1+indata2+indata6,data=s12_OCSP_data)
# Model - s12_EBHM
# Training data here must be from s12_EBHM run through the s12_EBHM model, the s12 model, and he all data model
s12_EBHM_data = cbind(indata1,indata2,indata5)
s12_EBHM=lm(SURVIVAL~indata1+indata2+indata5,data=s12_EBHM_data)
# Model - s3_OCSP
s3_OCSP_data = cbind(indata1,indata3,indata8)
s3_OCSP=lm(SURVIVAL~indata1+indata3+indata8,data=s3_OCSP_data)
# Model - s3_EBHM
s3_EBHM_data = cbind(indata1,indata3,indata7)
s3_EBHM=lm(SURVIVAL~indata1+indata3+indata7,data=s3_EBHM_data)
# Model - s4_OCSP
s4_OCSP_data = cbind(indata1,indata4,indata10)
s4_OCSP=lm(SURVIVAL~indata1+indata4+indata10,data=s4_OCSP_data)
# Model - s4_EBHM
s4_EBHM_data = cbind(indata1,indata4,indata9)
s4_EBHM=lm(SURVIVAL~indata1+indata4+indata9,data=s4_EBHM_data)

########################################################
# Test Stacking and Backoff Models using 20% of the data
predictions = predict.lm(fit, data.test[1,],interval = "prediction")
s12_OCSP_test = predict.lm(s12_OCSP, data.test[1,],interval = "prediction")
# Model - s12_OCSP
s12_OCSP_data = cbind(indata1,indata2,indata6)
s12_OCSP=lm(SURVIVAL~indata1+indata2+indata6,data=s12_OCSP_data)
# Model - s12_EBHM
s12_EBHM_data = cbind(indata1,indata2,indata5)
s12_EBHM=lm(SURVIVAL~indata1+indata2+indata5,data=s12_EBHM_data)
# Model - s3_OCSP
s3_OCSP_data = cbind(indata1,indata3,indata8)
s3_OCSP=lm(SURVIVAL~indata1+indata3+indata8,data=s3_OCSP_data)
# Model - s3_EBHM
s3_EBHM_data = cbind(indata1,indata3,indata7)
s3_EBHM=lm(SURVIVAL~indata1+indata3+indata7,data=s3_EBHM_data)
# Model - s4_OCSP
s4_OCSP_data = cbind(indata1,indata4,indata10)
s4_OCSP=lm(SURVIVAL~indata1+indata4+indata10,data=s4_OCSP_data)
# Model - s4_EBHM
s4_EBHM_data = cbind(indata1,indata4,indata9)
s4_EBHM=lm(SURVIVAL~indata1+indata4+indata9,data=s4_EBHM_data)