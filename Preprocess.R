########## PART A GRAPH PLOTTING ##########
install.packages('plyr')
library(plyr)

# 1.) graph for match column
count(asg, 'match')
x=count(asg, 'match')
class(x)
x$match <- as.character(x$match)
x$match[x$match == "0"] <- "Unmatch"
x$match[x$match == "1"] <- "Match"
x$match <- as.factor(x$match)
barplot(x$freq, names.arg=x$match, main = "Frequency of Unmatch and Match", col = 'blue')

# 2.) graph for race column
count(asg, 'race')
y=count(asg, 'race')
class(y)
y$race <- as.character(y$race)
y$race[y$race == "1"] <- "Black/African American"
y$race[y$race == "2"] <- "European/Caucasian-American"
y$race[y$race == "3"] <- "Latino/Hispanic American"
y$race[y$race == "4"] <- "Asian/Pacific Islander/Asian-American"
y$race[y$race == "5"] <- "Native American"
y$race[y$race == "6"] <- "Other"
y$race <- as.factor(y$race)

install.packages('ggplot2')
library(ggplot2)
ggplot(y, aes(x=y$race, y=y$freq)) + 
  geom_bar(stat="identity", fill="blue", color="grey50")+coord_flip()+ xlab("Races")+ ylab("Frequency")+ggtitle("Frequency of Difference Races")

# 3.) graph for age column
mean(asg$age,na.rm = TRUE)
count(asg, 'age')
z=count(asg, 'age')
class(z)
barplot(z$freq, names.arg=z$age,main="Frequency of Age Difference of Participant",col='blue',xlab = "Age of Participant",ylab = "Frequency")

# 4.) box-and-whisker plot for identifying outliers
boxplot.stats(z$age)$out
boxplot(z$age,data=z, xlab='Frequency',ylab='Age' )



########## PART E PRE-PROCESSING ##########

# 1.) read data
sp <- read.csv("Speed Dating Data.csv", na.strings = "")
str(sp)

# 2.) remove duplicate rows
sp_unique <- sp[!duplicated(sp$iid), ]
nrow(sp_unique)
View(head(sp_unique))

# 3.) feature selection
sp_feature = sp_unique[,c("iid","age","gender","match","date","sports","dining",
                   "art","gaming","clubbing","reading","movies","concerts",
                   "shopping")]
View(sp_feature)
View(head(sp_feature))
sum(is.na(sp_feature))

# 4.) imputation using k-NN
install.packages("VIM")
library(VIM)
sp_imputed <- kNN(sp_feature)
sp_imputed <- sp_imputed[,names(sp_feature)]
sum(is.na(sp_imputed))
