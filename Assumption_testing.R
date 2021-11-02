# Assumption 1#
# If the proportion of cropland in a district treated with pesticides is used as the response
# variable, it is assumed that the amount of pesticides applied is correlated with the variable.
# But this assumption has to be tested. I will do so following Meehan et al. (2011)

# State-level pesticide consumption 2011-12
# Data source: 29th report of the Standing Committee on Agriculture
setwd("E:/PhD plans/Ideas/Agricultural landscapes/Pesticide use Idea")
pesticide_consump=read.csv("State-level pesticide consumption 2011-12.csv",header=TRUE)


# Area of cropland treated with pesticides (state-level)
# CAUTION: This data is from a sample survey so it may not be representative of the entire state
# Data source: Agricultural census input survey data (2011-12)
setwd("E:/PhD plans/Ideas/Agricultural landscapes/Pesticide use Idea/Agriculture input survey data/2011-12/State-level data")
library(data.table)
files=list.files(pattern = "*.csv") # Read all csv files in the folder
DT = do.call(rbind, lapply(files, fread)) # Create a dataframe where all these files are amended
cropland_area=data.frame(NULL) # Create a new dataframe
for(i in 1:length(files)) # Fill this dataframe with the total area treated with pesticide 
{
  cropland_area[i,1]=DT[24*i,3] # State name
  cropland_area[i,2]=DT[24*i,13]# The 24th row and last column has the total area treated with pesticide
}
library(tidyr)
# The State name column has to be cleaned up
cropland_area=cropland_area %>% separate(Textbox2, c("delete","State"),": ")
# Change column names
colnames(cropland_area)[c(3)]="Pesticide_area"
cropland_pestarea=cropland_area[,c(2,3)]

#Bring pesticide consumption and cropland area treated into one file
str(pesticide_consump)
str(cropland_pestarea)
pesticide_consump$State1=as.character(pesticide_consump$State) # In order to use tolower function, the column has to be a character
pesticide_consump=pesticide_consump[,c(2,3)]
colnames(pesticide_consump)=c("Amount","State")

pesticide_consump_tolower=pesticide_consump%>%mutate(State=tolower(State))
cropland_pestarea=cropland_pestarea%>%mutate(State=tolower(State))

library(dplyr)
pestarea_pesticideconsump_join=left_join(cropland_pestarea,pesticide_consump_tolower,by="State",all.x = TRUE)
pestarea_pesticideconsump_join_1=x[-(which(is.na(x$Amount))),]


plot(pestarea_pesticideconsump_join_1$Pesticide_area,pestarea_pesticideconsump_join_1$Amount)
summary(lm(pestarea_pesticideconsump_join_1$Amount~pestarea_pesticideconsump_join_1$Pesticide_area))

# The area treated with pesticides in the sampled farms at state level is positively correlated with amount of pestcides used at state level.
# This means that the area treated with pesticides in sampled farms is not confounded by the number of applications

# Use FRAGSTATS to

# I have made some changes to this file before adding and committing 
