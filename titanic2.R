# Installing packages 
install.packages("reshape")
library(reshape)
library(ggplot2)

# Importing the data
titanic <- data.frame(Titanic)

# Finding total passengers
totalPassengers <- sum(titanic$Freq)

# Two separate data frames with casualties and survivors
survivors <- subset(titanic, titanic$Survived=="Yes")
casualties <- subset(titanic, titanic$Survived=="No")

# Let us define a function that aggregates the frequencies based on a factor.
# Class
aggregate(cbind(Freq) ~ Class, data=survivors, FUN=sum)
# Sex 
aggregate(cbind(Freq) ~ Sex, data=survivors, FUN=sum)
# Age
aggregate(cbind(Freq) ~ Age, data=survivors, FUN=sum)


titanic1 <- titanic
names(titanic)<- tolower(names(titanic))
names(titanic)
cast(titanic, class ~ survived ~ age)
cast(titanic, Class ~ Survived, mean, value = 'Frequency')

# casting the data frame with the sums of each variable that we wish
# to observe a correlation with.

cast(titanic, class ~ survived, value= "freq", sum)
ggplot(titanic, aes(class, survived))
cast(titanic, sex ~ survived, value= "freq", sum)

cast(titanic, age ~ survived, value= "freq", sum)

