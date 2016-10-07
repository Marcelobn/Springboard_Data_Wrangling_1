getwd()
setwd("C:/Users/Bohrer/Documents/Springboard")
mydata <- read.csv("refine_original.csv")
library(tidyr)
library(dplyr)


table(mydata$company)
mydata$company <- tolower(mydata$company)

mydata$company <-gsub("0", "o", mydata$company )
mydata$company <- gsub("ak zo", "akzo", mydata$company)
mydata$company <- gsub("f", "ph", mydata$company)
mydata$company <- gsub("lv", "lev", mydata$company)
mydata$company <- gsub("llps", "llips", mydata$company)
mydata$company <- gsub("phl", "phil", mydata$company)
mydata$company <- gsub("ili", "illi", mydata$company)



mydata <- separate(mydata, col = Product.code...number, into = c("product_code", "product_number"), sep = "\\-")


mydata$p <- ifelse(mydata$product_code == "p", "Smartphone", NA)
mydata$v <- ifelse(mydata$product_code == "v", "TV", NA)
mydata$x <- ifelse(mydata$product_code == "x", "Laptop", NA)
mydata$q <- ifelse(mydata$product_code == "q", "Tablet", NA)

mydata <- cbind(mydata, product_category = apply(mydata[8:11],1,function(x) paste(na.omit(x))))
mydata <- mydata[,-c(8:11)]

mydata$full_address <- paste(mydata$address, mydata$city, mydata$country, sep = ",")


mydata$company_akzo <- ifelse(mydata$company=="akzo",1, 0)
mydata$company_phillips <- ifelse(mydata$company=="phillips",1, 0)
mydata$company_unilever <- ifelse(mydata$company=="unilever",1, 0)
mydata$company_van_houten <- ifelse(mydata$company=="van houten",1, 0)


mydata$product_smartphone <- ifelse(mydata$product_code=="p",1, 0)
mydata$product_tv <- ifelse(mydata$product_code=="v",1, 0)
mydata$product_laptop <- ifelse(mydata$product_code=="x",1, 0)
mydata$product_tablet <- ifelse(mydata$product_code=="q",1, 0)


write.csv(mydata, file = "refine_clean.csv")



