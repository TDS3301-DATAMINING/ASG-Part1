# read data
setwd("")
sp <- read.csv("Speed Dating Data.csv",na.strings = "")
str(sp)

# remove duplicate rows
sp_unique <- sp[!duplicated(sp$iid), ]
nrow(sp_unique)
View(head(sp_unique))

# feature selection
sp_feature = sp_unique[,c("iid","age","gender","match","date","go_out","sports","tvsports","exercise","dining","museums",
                   "art","hiking","gaming","clubbing","reading","tv","theater","movies","concerts","music",
                   "shopping","yoga")]
View(sp_feature)
View(head(sp_feature))
sum(is.na(sp_feature))

# imputation using k-NN
install.packages("VIM")
library(VIM)
sp_imputed <- kNN(sp_feature)
sp_imputed <- sp_imputed[,names(sp_feature)]
sum(is.na(sp_imputed))

# convert to numeric
sp_numeric <- sapply(sp_imputed, as.numeric)
str(sp_numeric)
is.numeric(sp_numeric)
