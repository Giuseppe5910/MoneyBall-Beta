batting <- read.csv('C:/Users/giuse/Documents/MoneyBall-Beta/Batting.csv')

head(batting)
str(batting)

head(batting$AB)
head(batting$X2B)

#adding a column for batting average
batting$BA <- batting$H / batting$AB
#check
head(batting)
tail(batting$BA,5)


#adding a column for On Base Percentage (OBP)
batting$OBP<-(batting$H+batting$IBB+batting$HBP)/(batting$AB+batting$BB+batting$HBP+batting$SF)
#adding a column for 1B as singles, 1B
batting$X1B<-(batting$H-batting$X2B-batting$X3B-batting$HR)
#adding a column for SLG, Slugging Percentage
batting$SLG <- ((1 * batting$X1B) + (2 * batting$X2B) + (3 * batting$X3B) + (4 * batting$HR) ) / batting$AB

str(batting)

#we load the salaries from salaries.csv
sal<-read.csv('C:/Users/giuse/Documents/MoneyBall-Beta/Salaries.csv')

summary(sal)

batting<-subset(batting,yearID>=1985)
summary(batting)

#Use the merge() function to merge the batting and 
#sal data frames by c('playerID','yearID'). Call the new data frame combo
combo<-merge(batting,sal,by=c('playerID','yearID'))
summary(combo)
#Use the subset() function to get a data frame called lost_players 
#from the combo data frame consisting of those 3 players.
lost_players<-subset(combo,playerID %in% c('giambja01','damonjo01','saenzol01'))
lost_players<-subset(lost_players,yearID==2001)
lost_players <- lost_players[,c('playerID','H','X2B','X3B','HR','OBP','SLG','BA','AB')]
lost_players

combo<-subset(combo,yearID==2001)

combo<-subset(combo,salary<8000000 & OBP>0 & AB>=450)
str(combo)

library(dplyr)
avail.players <- filter(combo,yearID==2001)
ggplot(combo,aes(x=OBP,y=salary))+geom_point()

#we choose 8milion as a cut off point
#get rid of the players OBP =0
avail.players <- filter(avail.players,salary<8000000,OBP>0)

#The total AB of the lost players is 1469. 
#This is about 1500, meaning I should probably cut off my avail.players at 1500/3= 500 AB.
avail.players <- filter(avail.players,AB >= 500)

#SORTING
possible <- head(arrange(avail.players,desc(OBP)),10)


possible <- possible[,c('playerID','OBP','AB','salary')]

possible



