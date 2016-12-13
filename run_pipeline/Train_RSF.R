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
indata1 = read.table("s12ocspT_allDataR.txt")
indata2 = read.table("s12ocspT_s12ocspR.txt")
indata3 = read.table("s12ocspT_s12allR.txt")
indata4 = read.table("s3ebhmT_allDataR.txt")
indata5 = read.table("s3ebhmT_s3ebhmR.txt")
indata6 = read.table("s3ebhmT_s3AllR.txt")
indata7 = read.table("s3ocspT_allDataR.txt")
indata8 = read.table("s3ocspT_s3ocspR.txt")
indata9 = read.table("s3ocspT_s3AllR.txt")
indata10 = read.table("s4ebhmT_allDataR.txt")
indata11 = read.table("s4ebhmT_s4ebhmR.txt")
indata12 = read.table("s4ebhmT_s4allR.txt")
indata13 = read.table("s4ocspT_allDataR.txt")
indata14 = read.table("s4ocspT_s4ocspR.txt")
indata15 = read.table("s4ocspT_s4allR.txt")
indata16 = read.table("s12ebhmT_s12ebhmR.txt")
indata17 = read.table("s12ebhmT_s12allR.txt")
indata18 = read.table("s12ebhmT_allDataR.txt")

#Read in the data for testing the stacking models from the MTLR models 20%
# MTLR (PSSP) Output for Training Linear Reg. Model
indata19 = read.table("s3ebhmS_allDataR.txt")
indata20 = read.table("s3ebhmS_s3ebhmR.txt")
indata21 = read.table("s3ebhmS_s3AllR.txt")
indata22 = read.table("s3ocspS_allDataR.txt")
indata23 = read.table("s3ocspS_s3ocspR.txt")
indata24 = read.table("s3ocspS_s3AllR.txt")
indata25 = read.table("s4ebhmS_allDataR.txt")
indata26 = read.table("s4ebhmS_s4ebhmR.txt")
indata27 = read.table("s4ebhmS_s4allR.txt")
indata28 = read.table("s4ocspS_allDataR.txt")
indata29 = read.table("s4ocspS_s4ocspR.txt")
indata30 = read.table("s4ocspS_s4allR.txt")
indata31 = read.table("s12ebhmS_allDataR.txt")
indata32 = read.table("s12ebhmS_s12ebhmR.txt")
indata33 = read.table("s12ebhmS_s12allR.txt")
indata34 = read.table("s12ocspS_allDataR.txt")
indata35 = read.table("s12ocspS_s12ocspR.txt")
indata36 = read.table("s12ocspS_s12allR.txt")

#Read in the true survival times for training the stacking models using linear regression
indata37 = read.table("fe_all2.txt")
indata38 = read.table("fe_st122.txt")
indata39 = read.table("fe_st32.txt")
indata40 = read.table("fe_st42.txt")
indata41 = read.table("fe_s12ebhmT.txt")
indata42 = read.table("fe_s12ocspT.txt")
indata43 = read.table("fe_s3ebhmT.txt")
indata44 = read.table("fe_s3ocspT.txt")
indata45 = read.table("fe_s4ebhmT.txt")
indata46 = read.table("fe_s4ocspT.txt")

#Read in the true survival times for testing the stacking models using lm
indata47 = read.table("fe_s12ocspS.txt")
indata48 = read.table("fe_s12ebhmS.txt")
indata49 = read.table("fe_s3ocspS.txt")
indata50 = read.table("fe_s3ebhmS.txt")
indata51 = read.table("fe_s4ocspS.txt")
indata52 = read.table("fe_s4ebhmS.txt")

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
s12_OCSP_data = data.frame(indata42,indata1,indata2,indata3)
s12_OCSP=lm(s12_OCSP_data[,1]~V1.1+V1.2+V1.3,data=s12_OCSP_data)
# Model - s12_EBHM
# Training data here must be from s12_EBHM run through the s12_EBHM model, the s12 model, and he all data model
s12_EBHM_data = data.frame(indata41,indata16,indata17,indata18)
s12_EBHM=lm(s12_EBHM_data[,1]~V1.1+V1.2+V1.3,data=s12_EBHM_data)
# Model - s3_OCSP
s3_OCSP_data = data.frame(indata44,indata7,indata8,indata9)
s3_OCSP=lm(s3_OCSP_data[,1]~V1.1+V1.2+V1.3,data=s3_OCSP_data)
# Model - s3_EBHM
s3_EBHM_data = data.frame(indata43,indata4,indata5,indata6)
s3_EBHM=lm(s3_EBHM_data[,1]~V1.1+V1.2+V1.3,data=s3_EBHM_data)
# Model - s4_OCSP
s4_OCSP_data = data.frame(indata46,indata13,indata14,indata15)
s4_OCSP=lm(s4_OCSP_data[,1]~V1.1+V1.2+V1.3,data=s4_OCSP_data)
# Model - s4_EBHM
s4_EBHM_data = data.frame(indata45,indata10,indata11,indata12)
s4_EBHM=lm(s4_EBHM_data[,1]~V1.1+V1.2+V1.3,data=s4_EBHM_data)

########################################################
# Test Stacking and Backoff Models using 20% of the data
predictions = predict.lm(fit, data.test[1,],interval = "prediction")
# Model - s12_OCSP
s12_OCSP_test_data = data.frame(indata47,indata34,indata35,indata36)
s12_OCSP_test = predict.lm(s12_OCSP, s12_OCSP_test_data[1,])
# Model - s12_EBHM
s12_EBHM_test_data = data.frame(indata48,indata32,indata33,indata31)
s12_EBHM_test = predict.lm(s12_EBHM, s12_EBHM_test_data[1,])
# Model - s3_OCSP
s3_OCSP_test_data = data.frame(indata49,indata22,indata23,indata24)
s3_OCSP_test = predict.lm(s3_OCSP, s3_OCSP_test_data[1,])
# Model - s3_EBHM
s3_EBHM_test_data = data.frame(indata50,indata19,indata20,indata21)
s3_EBHM_test = predict.lm(s3_EBHM, s3_EBHM_test_data[1,])
# Model - s4_OCSP
s4_OCSP_test_data = data.frame(indata51,indata28,indata29,indata30)
s4_OCSP_test = predict.lm(s4_OCSP, s4_OCSP_test_data[1,])
# Model - s4_EBHM
s4_EBHM_test_data = data.frame(indata52,indata25,indata26,indata27)
s4_EBHM_test = predict.lm(s4_EBHM, s4_EBHM_test_data[1,])


