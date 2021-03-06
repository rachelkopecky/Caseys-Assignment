library(tidyverse)
library(tm)
library(readxl)

getTweets <- function() {
  # Read individual data files
  
  first <- read.csv("Posts from 2017-01-25.csv")
  second <- read.csv("Posts from 2017-04-21.csv")
  third <- read.csv("Posts from 2017-07-01.csv")
  fourth <- read.csv("Posts from 2017-08-07.csv")
  fifth <- read.csv("Posts from 2017-09-21.csv")
  one <- read.csv("1.csv")
  two <- read.csv("2.csv")
  three <- read.csv("3.csv")
  four <- read.csv("4.csv")
  five <- read.csv("5.csv")
  six <- read.csv("6.csv")
  seven <- read.csv("7.csv")
  eight <- read.csv("8.csv")
  nine <- read.csv("9.csv")
  ten <- read.csv("10.csv")
  
  # Combine into one df
  
  tweets <-
    rbind(
      first,
      second,
      third,
      fourth,
      fifth,
      one,
      two,
      three,
      four,
      five,
      six,
      seven,
      eight,
      nine,
      ten
    )
  
  # Filter only the tweets that we know are from Brazil
  
  tweets <- filter(tweets, Country == "Brazil")
  
  return(tweets)
  
}


getStopwords <- function() {
  # Portuguese stopwords
  
  stop <- read.csv("stopwords_raw.csv")
  return(stop)
  
}

cleanData <- function(df1, df2) {
  tweets <- df1
  stop <- df2
  
  # Clean the tweets
  
  tweets$Contents <- tolower(tweets$Contents)
  
  # Cleaning Jack
  
  tweets$Contents <- gsub("jack daniels honey", "jack_honey", tweets$Contents)
  tweets$Contents <- gsub("jack daniel's honey", "jack_honey", tweets$Contents)
  tweets$Contents <- gsub("jack honey", "jack_honey", tweets$Contents)
  tweets$Contents <- gsub("jack daniels fire", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jack daniel's fire", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jack fire", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jack daniel honey", "jack_honey", tweets$Contents)
  tweets$Contents <- gsub("jack daniels tennessee honey", "jack_honey", tweets$Contents)
  tweets$Contents <- gsub("jack daniels tennessee fire", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jack daniel's tennessee honey", "jack_honey", tweets$Contents)
  tweets$Contents <- gsub("jack daniel's tennessee fire", "jack_fire", tweets$Contents)
  
  tweets$Contents <- gsub("jack de mel", "jack_honey", tweets$Contents)
  tweets$Contents <- gsub("jack daniels fogo", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jack daniels red", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jack daniels vermelho", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jack daniels de mel", "jack_honey", tweets$Contents)
  tweets$Contents <- gsub("jack fogo", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jack red", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jack vermelho", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jack mel", "jack_honey", tweets$Contents)
  tweets$Contents <- gsub("jack canela", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jack de canela", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jack daniels de canela", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jack caneleira", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jack de caneleira", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jack daniels de caneleira", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jack daniels mel", "jack_honey", tweets$Contents)
  tweets$Contents <- gsub("jack daniels canela", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jack daniels caneleira", "jack_fire", tweets$Contents)
  
  tweets$Contents <- gsub("jack daniels fogo", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jack daniel's red", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jack daniel's vermelho", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jack daniel's de mel", "jack_honey", tweets$Contents)
  tweets$Contents <- gsub("jack daniel's red", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jack daniels red", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jack daniel's de red", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jack daniels de red", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jack daniel's de vermelho", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jack daniels de vermelho", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jack daniel's mel", "jack_honey", tweets$Contents)
  tweets$Contents <- gsub("jack daniels mel", "jack_honey", tweets$Contents)
  tweets$Contents <- gsub("jack canela", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jack de canela", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jack daniel's de canela", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jack daniel's de caneleira", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jack daniel's mel", "jack_honey", tweets$Contents)
  tweets$Contents <- gsub("jack daniel's canela", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jack daniel's caneleira", "jack_fire", tweets$Contents)
  
  tweets$Contents <- gsub("jack daniel fogo", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jack daniel red", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jack daniel vermelho", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jack daniel de mel", "jack_honey", tweets$Contents)
  tweets$Contents <- gsub("jack daniel red", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jack daniel red", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jack daniel de red", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jack daniel de red", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jack daniel de vermelho", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jack daniel de vermelho", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jack daniel mel", "jack_honey", tweets$Contents)
  tweets$Contents <- gsub("jack daniel mel", "jack_honey", tweets$Contents)
  tweets$Contents <- gsub("jack daniel de canela", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jack daniel de caneleira", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jack daniel mel", "jack_honey", tweets$Contents)
  tweets$Contents <- gsub("jack daniel canela", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jack daniel caneleira", "jack_fire", tweets$Contents)
  
  tweets$Contents <- gsub("jack daniels brasil", "jack_daniels_brasil", tweets$Contents)
  tweets$Contents <- gsub("jack daniels brazil", "jack_daniels_brasil", tweets$Contents)
  tweets$Contents <- gsub("jack daniel's brasil", "jack_daniels_brasil", tweets$Contents)
  tweets$Contents <- gsub("jack daniel's brazil", "jack_daniels_brasil", tweets$Contents)
  tweets$Contents <- gsub("jack daniel brasil", "jack_daniels_brasil", tweets$Contents)
  tweets$Contents <- gsub("jack daniel brazil", "jack_daniels_brasil", tweets$Contents)
  
  tweets$Contents <- gsub("jackdanielshoney", "jack_honey", tweets$Contents)
  tweets$Contents <- gsub("jackdanielhoney", "jack_honey", tweets$Contents)
  tweets$Contents <- gsub("jackhoney", "jack_honey", tweets$Contents)
  tweets$Contents <- gsub("jackdanielsfire", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jackdanielfire", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jackfire", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jackdanielshoney", "jack_honey", tweets$Contents)
  tweets$Contents <- gsub("jackdanielhoney", "jack_honey", tweets$Contents)
  tweets$Contents <- gsub("jackdaniels", "jack_daniels", tweets$Contents)
  tweets$Contents <- gsub("jackdaniel", "jack_daniels", tweets$Contents)
  tweets$Contents <- gsub("jackmel", "jack_honey", tweets$Contents)
  tweets$Contents <- gsub("jackdanielsdemel", "jack_honey", tweets$Contents)
  tweets$Contents <- gsub("jackcanela", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jackdanielsdecanela", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jackdecanela", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jackdanielscanela", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jackfogo", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jackdefogo", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jackdanielsdefogo", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jackdanieldemel", "jack_honey", tweets$Contents)
  tweets$Contents <- gsub("jackcanela", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jackdanieldecanela", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jackdecanela", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jackdanielcanela", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jackfogo", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jackdefogo", "jack_fire", tweets$Contents)
  tweets$Contents <- gsub("jackdanieldefogo", "jack_fire", tweets$Contents)
  
  tweets$Contents <- gsub("jack daniels tennessee whiskey", "jack_daniels_tennessee_whiskey", tweets$Contents)
  tweets$Contents <- gsub("jack daniels tennessee whisky", "jack_daniels_tennessee_whiskey", tweets$Contents)
  tweets$Contents <- gsub("jack daniel's tennessee whiskey", "jack_daniels_tennessee_whiskey", tweets$Contents)
  tweets$Contents <- gsub("jack daniel's tennessee whisky", "jack_daniels_tennessee_whiskey", tweets$Contents)
  
  tweets$Contents <- gsub("jack daniels tennessee uisque", "jack_daniels_tennessee_whiskey", tweets$Contents)
  tweets$Contents <- gsub("jack daniel's tennessee uisque", "jack_daniels_tennessee_whiskey", tweets$Contents)
  
  tweets$Contents <- gsub("jack daniel tennessee whiskey", "jack_daniels_tennessee_whiskey", tweets$Contents)
  tweets$Contents <- gsub("jack daniel tennessee whisky", "jack_daniels_tennessee_whiskey", tweets$Contents)
  
  tweets$Contents <- gsub("jack daniel tennessee uisque", "jack_daniels_tennessee_whiskey", tweets$Contents)
  
  tweets$Contents <- gsub("jack tennessee uisque", "jack_daniels_tennessee_whiskey", tweets$Contents)
  tweets$Contents <- gsub("jack tennessee whiskey", "jack_daniels_tennessee_whiskey", tweets$Contents)
  tweets$Contents <- gsub("jack tennessee whisky", "jack_daniels_tennessee_whiskey", tweets$Contents)
  tweets$Contents <- gsub("jack daniels tennessee whisk", "jack_daniels_tennessee_whiskey", tweets$Contents)
  tweets$Contents <- gsub("jack daniel's tennessee whisk", "jack_daniels_tennessee_whiskey", tweets$Contents)
  tweets$Contents <- gsub("jack daniel tennessee whisk", "jack_daniels_tennessee_whiskey", tweets$Contents)
  
  tweets$Contents <- gsub("jack daniels tradicional", "jack_traditional", tweets$Contents)
  tweets$Contents <- gsub("jack daniel's tradicional", "jack_traditional", tweets$Contents)
  tweets$Contents <- gsub("jack tradicional", "jack_traditional", tweets$Contents)
  tweets$Contents <- gsub("jack daniel tradicional", "jack_traditional", tweets$Contents)
  
  tweets$Contents <- gsub("jack daniels", "jack_daniels", tweets$Contents)
  tweets$Contents <- gsub("jack daniel's", "jack_daniels", tweets$Contents)
  tweets$Contents <- gsub("jack daniel", "jack_daniels", tweets$Contents)
  
  # Cleaning Fireball
  
  tweets$Contents <- gsub("fire ball", "fireball", tweets$Contents)
  tweets$Contents <- gsub("fire bal", "fireball", tweets$Contents)
  
  # Cleaning Jager
  
  tweets$Contents <- gsub("jager bomb", "jager_bomb", tweets$Contents)
  tweets$Contents <- gsub("jager bom", "jager_bomb", tweets$Contents)
  tweets$Contents <- gsub("yager bomb", "jager_bomb", tweets$Contents)
  tweets$Contents <- gsub("yager bom", "jager_bomb", tweets$Contents)
  
  tweets$Contents <- gsub("jager meister", "jagermeister", tweets$Contents)
  tweets$Contents <- gsub("yager meister", "jagermeister", tweets$Contents)
  tweets$Contents <- gsub("jager mister", "jagermeister", tweets$Contents)
  tweets$Contents <- gsub("yager mister", "jagermeister", tweets$Contents)
  
  tweets$Contents <- gsub("j�ger bomb", "jager_bomb", tweets$Contents)
  tweets$Contents <- gsub("j�ger bom", "jager_bomb", tweets$Contents)
  tweets$Contents <- gsub("y�ger bomb", "jager_bomb", tweets$Contents)
  tweets$Contents <- gsub("y�ger bom", "jager_bomb", tweets$Contents)
  tweets$Contents <- gsub("j�gerbomb", "jager_bomb", tweets$Contents)
  tweets$Contents <- gsub("j�gerbom", "jager_bomb", tweets$Contents)
  tweets$Contents <- gsub("y�gerbomb", "jager_bomb", tweets$Contents)
  tweets$Contents <- gsub("y�gerbom", "jager_bomb", tweets$Contents)
  tweets$Contents <- gsub("jagerbomb", "jager_bomb", tweets$Contents)
  tweets$Contents <- gsub("jagerbom", "jager_bomb", tweets$Contents)
  tweets$Contents <- gsub("yagerbomb", "jager_bomb", tweets$Contents)
  tweets$Contents <- gsub("yagerbom", "jager_bomb", tweets$Contents)
  
  tweets$Contents <- gsub("j�ger meister", "jagermeister", tweets$Contents)
  tweets$Contents <- gsub("y�ger meister", "jagermeister", tweets$Contents)
  tweets$Contents <- gsub("j�ger mister", "jagermeister", tweets$Contents)
  tweets$Contents <- gsub("y�ger mister", "jagermeister", tweets$Contents)
  tweets$Contents <- gsub("j�germister", "jagermeister", tweets$Contents)
  tweets$Contents <- gsub("y�germister", "jagermeister", tweets$Contents)
  tweets$Contents <- gsub("j�germeister", "jagermeister", tweets$Contents)
  tweets$Contents <- gsub("y�germeister", "jagermeister", tweets$Contents)
  
  tweets$Contents <- gsub("jagermeister", "jagermeister", tweets$Contents)
  tweets$Contents <- gsub("yagermeister", "jagermeister", tweets$Contents)
  
  tweets$Contents <- gsub("j�ger", "jager", tweets$Contents)
  tweets$Contents <- gsub("y�ger", "jager", tweets$Contents)
  tweets$Contents <- gsub("yager", "jager", tweets$Contents)
  
  # Cleaning Other Stuff
  
  tweets$Contents <- gsub("tennessee whiskey", "tennessee_whiskey", tweets$Contents)
  tweets$Contents <- gsub("tennessee whisky", "tennessee_whiskey", tweets$Contents)
  tweets$Contents <- gsub("tennessee whisk", "tennessee_whiskey", tweets$Contents)
  tweets$Contents <- gsub("tennessee uisque", "tennessee_whiskey", tweets$Contents)
  
  tweets$Contents <- gsub("whisky", "whiskey", tweets$Contents)
  tweets$Contents <- gsub("uisque", "whiskey", tweets$Contents)
  
  tweets$Contents <- gsub("gelo de coco", "gelo_de_coco", tweets$Contents)
  tweets$Contents <- gsub("gelodecoco", "gelo_de_coco", tweets$Contents)
  tweets$Contents <- gsub("gelos de coco", "gelo_de_coco", tweets$Contents)
  tweets$Contents <- gsub("gelosdecoco", "gelo_de_coco", tweets$Contents)
  
  tweets$Contents <- gsub("red bul", "redbull", tweets$Contents)
  tweets$Contents <- gsub("red bull", "redbull", tweets$Contents)
  
  tweets$Contents <- gsub("�gua de coco", "agua_de_coco", tweets$Contents)
  tweets$Contents <- gsub("�guadecoco", "agua_de_coco", tweets$Contents)
  tweets$Contents <- gsub("agua de coco", "agua_de_coco", tweets$Contents)
  tweets$Contents <- gsub("aguadecoco", "agua_de_coco", tweets$Contents)
  tweets$Contents <- gsub("�gua de coc�", "agua_de_coco", tweets$Contents)
  tweets$Contents <- gsub("�guadecoc�", "agua_de_coco", tweets$Contents)
  tweets$Contents <- gsub("agua de coc�", "agua_de_coco", tweets$Contents)
  tweets$Contents <- gsub("aguadecoc�", "agua_de_coco", tweets$Contents)
  tweets$Contents <- gsub("�gua de c�co", "agua_de_coco", tweets$Contents)
  tweets$Contents <- gsub("�guadec�co", "agua_de_coco", tweets$Contents)
  tweets$Contents <- gsub("agua de c�co", "agua_de_coco", tweets$Contents)
  tweets$Contents <- gsub("aguadec�co", "agua_de_coco", tweets$Contents)
  
  tweets$Contents <- gsub("�guas de coco", "agua_de_coco", tweets$Contents)
  tweets$Contents <- gsub("�guasdecoco", "agua_de_coco", tweets$Contents)
  tweets$Contents <- gsub("aguas de coco", "agua_de_coco", tweets$Contents)
  tweets$Contents <- gsub("aguasdecoco", "agua_de_coco", tweets$Contents)
  tweets$Contents <- gsub("�guas de coc�", "agua_de_coco", tweets$Contents)
  tweets$Contents <- gsub("�guasdecoc�", "agua_de_coco", tweets$Contents)
  tweets$Contents <- gsub("aguas de coc�", "agua_de_coco", tweets$Contents)
  tweets$Contents <- gsub("aguasdecoc�", "agua_de_coco", tweets$Contents)
  tweets$Contents <- gsub("�guas de c�co", "agua_de_coco", tweets$Contents)
  tweets$Contents <- gsub("�guasdec�co", "agua_de_coco", tweets$Contents)
  tweets$Contents <- gsub("aguas de c�co", "agua_de_coco", tweets$Contents)
  tweets$Contents <- gsub("aguasdec�co", "agua_de_coco", tweets$Contents)
  
  tweets$Contents <- gsub("gelo de coc�", "gelo_de_coco", tweets$Contents)
  tweets$Contents <- gsub("gelodecoc�", "gelo_de_coco", tweets$Contents)
  
  tweets$Contents <- gsub("gelo de c�co", "gelo_de_coco", tweets$Contents)
  tweets$Contents <- gsub("gelodec�co", "gelo_de_coco", tweets$Contents)
  
  tweets$Contents <- gsub("gelos de coc�", "gelo_de_coco", tweets$Contents)
  tweets$Contents <- gsub("gelosdecoc�", "gelo_de_coco", tweets$Contents)
  
  tweets$Contents <- gsub("gelos de c�co", "gelo_de_coco", tweets$Contents)
  tweets$Contents <- gsub("gelosdec�co", "gelo_de_coco", tweets$Contents)
  
  
  stop <<- stop
  
  # Rename columns
  
  colnames(tweets)[c(2, 6, 7)] <- c("Date", "State", "City")
  
  # Fix Date column
  
  tweets$Date <- as.character(tweets$Date)
  
  tweets$Date <- substr(tweets$Date, 1, nchar(tweets$Date) - 5)
  
  tweets$Date <- stripWhitespace(tweets$Date)
  
  tweets$Date <- as.Date(tweets$Date, "%m/%d/%Y")
  
  tweets <<- tweets
  
}

tweets <- getTweets()
stop <- getStopwords()
cleanData(tweets, stop)







write.csv(tweets, "data.csv")
write.csv(stop, "stopwords.csv")
write_excel_csv(tweets, "data.xls")


