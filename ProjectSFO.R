## Import dataset, zip/excel file found on https://www.flysfo.com/media/customer-survey-data
## Consists of customer feedback for SFO airport during 2018
setwd("C:/Users/Nikita/Desktop/POLI 5D/Project")
library(readxl)
sfo_2018_data <- read_excel("C:/Users/Nikita/Desktop/POLI 5D/Project/sfo 2018_data file_final_Weighted.xlsx")

## Calculate the mean of each categorization of satisfaction w/ roads for each specific overall customer satisfaction ranking
for (i in c(1:5)) {
        print(mean(sfo_2018_data$Q7ROADS[sfo_2018_data$Q7ALL==i]))
        }

## Bar graph to display dependent and independent variables overall 
sfo_2018_data$Q7ALL <- ordered(sfo_2018_data$Q7ALL, levels = 1:5,labels = c("unacceptable", "poor", "acceptable", "good", "outstanding"))
sfo_2018_data$Q7ROADS <- ordered(sfo_2018_data$Q7ROADS, levels = 1:5,labels = c("unacceptable", "poor", "acceptable", "good", "outstanding"))
bardata <- table(sfo_2018_data$Q7ROADS, sfo_2018_data$Q7ALL)
barplot(bardata, 
        main="Overall Airport Satisfaction, Including Satisfaction W/ Roads", 
        xlab = "Satisfaction w/ Airport Overall",
        ylab = "Number of Responses",
        ylim = c(0,2300),
        col = c("darkolivegreen3","limegreen","dodgerblue3","mediumslateblue","darkslateblue"),
        legend.text = rownames(bardata),
        args.legend=list(title="Satisfaction w/ Roads"))

## Getting a better idea of the distribution for each variable.
freqROADS <- table(sfo_2018_data$Q7ROADS)
relfreqROADS <- table(sfo_2018_data$Q7ROADS)/1772
cbind(freqROADS,relfreqROADS)

freqALL <- table(sfo_2018_data$Q7ALL)
relfreqALL <- table(sfo_2018_data$Q7ALL)/2625
cbind(freqALL,relfreqALL)

## Get joint and conditional distribution of variables using "gmodels" package
library("gmodels")
joint <- CrossTable(sfo_2018_data$Q7ROADS,sfo_2018_data$Q7ALL,prop.chisq = FALSE)
## To see individual tables within the above table:
joint        

## Better representation of barplot coded earlier:
joint_counts <- joint$t
barplot(joint_counts,
        beside = TRUE,
        main = "Overall Airport Satisfaction and Satisfaction w/ Roads",
        col = c("darkolivegreen3","limegreen","dodgerblue3","mediumslateblue","darkslateblue"),
        ylab = "Number of Responses",
        xlab = "Satisfaction w/ Airport Overall")
legend("topleft", 
       c("unacceptable", "poor", "acceptable", "good", "outstanding"),
       col = c("darkolivegreen3","limegreen","dodgerblue3","mediumslateblue","darkslateblue"),
       title = "Satisfaction w/ Roads",
       pch = 15)

## Display conditional proportion of road satisfaction given overall satisfaction
ROADS_given_ALL <- joint$prop.col
barplot(ROADS_given_ALL, 
        col = c("darkolivegreen3","limegreen","dodgerblue3","mediumslateblue","darkslateblue"),
        xlab = "Satisfaction w/ Airport Overall",
        ylab = "Proportion of Road Satisfaction",
        main = "Proportion of Road Satisfaction in Given Overall Satisfaction",
        legend.text = rownames(ALL_given_ROADS),
        args.legend=list(title="Satisfaction w/ Roads"))

## Use Pearson chi-square test of independence to see if the two variables are independent or dependent.
## Need to generate a sample of less than 500 so that Pearson chi-square test is more accurate.
## Null hypothesis: row and column variables are independent. Alternative hypothesis: row and column variables are dependent.
sample <- sfo_2018_data[sample(nrow(sfo_2018_data),450),]
jointsample <- CrossTable(sample$Q7ROADS,sample$Q7ALL,prop.chisq = FALSE)
joint_counts_sample <- jointsample$t
chisq <- chisq.test(joint_counts_sample)
chisq 

## P-value = zero, meaning the two variables are statistically significantly associated,
## must reject null hypothesis that the two variables are independent. 
## In order to visualize negative and positive associations, create a correlation plot of residuals (observed values minus expected values)
## NOTE: Positive residuals are in blue, specify a positive association between the corresponding row and column variables
## Negative residuals are in red, imply a negative association between the corresponding row and column variables
library("corrplot")
round(chisq$residuals,3)
corrplot(chisq$residuals,
         is.corr = FALSE,
         method = "color",
         addCoef.col = "gray")



