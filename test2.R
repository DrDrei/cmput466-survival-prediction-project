# CMPUT466 Term Project
# December 6th, 2016
# The command to run this sample R program from the command line is as follows:
#   Rscript --vanilla --default-packages=utils,randomForestSRC,survival,graphics,parallel test2.R
#

# Don't need this next line at the moment because the packages are defined in the command-line call
#install.packages("randomForestSRC", repos = "http://cran.us.r-project.org")

#Read in the data
data1 = read.csv("All_Data_updated_may2011_CLEANED.csv")
options(rf.cores=detectCores(), mc.cores=detectCores())
#Get training and test data, we will use 50% to train and 50% to test
train <- sample(1:nrow(data1), round(nrow(data1) * 0.50))
#Build model using training data
v.obj <- rfsrc(Surv(SURVIVAL, CENSORED) ~ ., data = data1[train, ], splitrule = "logrank", ntree = 600, tree.err=TRUE)
#Predict using all of the rows not used to train
p.obj <- predict.rfsrc(v.obj, data1[-train,])
print(v.obj)
print(p.obj)
#These two calls should generate a pdf document of two printed graphs.
#The first should show dropping error, the second should just be a line
plot(v.obj)
plot(p.obj)

#Get first 2 survival curves created for the test set (predicted set)
#This should print a smattering of data to the console after displaying the printed stats for the model and predict test.
p.obj$survival[1:2, ]
