# TO RUN
# Rscript --vanilla test1.R
data1 = read.csv("data.csv")
# install.packages("doParallel",repos = "https://cran.r-project.org")
library("parallel")
library("randomForestSRC")
library("doParallel")
options(rf.cores=detectCores()-1, mc.cores=detectCores()-1)

ptm <- proc.time()
v.obj <- rfsrc(Surv(SURVIVAL, CENSORED) ~ ., data = data1, splitrule = "logrank", ntree = 1000, tree.err=TRUE)
proc.time() - ptm

print(v.obj)
plot(v.obj)
