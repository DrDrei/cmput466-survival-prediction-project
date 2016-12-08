file=read.csv("All_Data_updated_may2011_CLEANED.csv",header = TRUE)
attach(file)
set.seed(1)
train=sample(1:nrow(data), round(nrow(data) * 0.80))
data.train=data[train, ]
data.test=data[-train, ]
#linear regression
fit=lm(SURVIVAL~AGE+BMI,data=data.train)
summary(fit)
predictions = predict.lm(fit, data.test[1,],interval = "prediction")
predictions