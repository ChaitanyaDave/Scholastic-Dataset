
library(tidyverse)
library(funModeling)
library(gmodels)


#Scholastic_Challenge_Dataset <- read_csv("D:/UCD/BI/Project/Scholastic_Challenge_Dataset.csv")
#Scholastic_Challenge_Dataset <- read.delim("C:/Users/chait/Documents/BI project/SQl dataset/Sample.csv", sep = "\t", header = TRUE, skipNul = TRUE)
#Scholastic_Challenge_Dataset <- read.delim("C:/Users/chait/Documents/BI project/SQl dataset/DataFromSql.txt", sep = "\t", header = TRUE)
Scholastic_Challenge_Dataset <- read.delim("C:/Users/chait/Documents/BI project/SQl dataset/Scholastic_SQL_To_R_semicolon.csv", encoding = "UTF-16", sep = ";",
                                         header = TRUE,sep = ";" , dec = "." ,quote = "" , fileEncoding = "UTF-16", stringsAsFactors = FALSE,
                                         cols(
                                           .default = col_character(),
                                           TITLE_CODE = col_integer(),
                                           total_units = col_integer(),
                                           UNIT_PRICE = col_double()
                                         ), skip = 1)
Scholastic_Challenge_Dataset <- read.csv("C:/Users/chait/Documents/BI project/SQl dataset/Scholastic_SQL_To_R_semicolon.csv", skip = 1, fileEncoding = "UTF-16", sep = ";", header = FALSE)
raw1 <- Scholastic_Challenge_Dataset

##---without changing unit price---
ex <- Scholastic_Challenge_Dataset %>%
  mutate(
    Revenue = V12*V11
  )

ex %>% 
  summarise(
    sum(Revenue, na.rm = T)
  )

Mean_zip <- Scholastic_Challenge_Dataset %>% 
  group_by(V22) %>% 
  summarise(
    Mean_zip = mean(V12, na.rm = T)
  )

Ex2 <- inner_join(raw1, Mean_zip) %>% 
  mutate(
    V12 = ifelse(is.na(V12) == T, Mean_zip, V12),
    Revenue = V12 * V11
  )

Ex2 %>% 
  summarise(
    sum(Revenue)
  )

##---Group on channel, mutate unit price with channel mean---
mean_channel <- raw1 %>% 
  group_by(V3) %>% 
  summarise(
    mean_channel = mean(V12, na.rm = T)
  )

raw2 <- inner_join(raw1, mean_channel) %>% 
  mutate (
    V12 = ifelse(is.na(V12) == T, mean_channel, V12),
    Revenue = V12*V11
  )

raw2 %>% 
  summarise(
    sum(Revenue)
  )
##--- Revenue = $22,641,838

raw4 <- raw1 %>%  
  mutate(
    V10 = as.character(V10),
    temp = substr(
      V10, 1 , nchar(V10) -1),
    lexi = V10,
    num = as.numeric(gsub('[a-zA-Z]',"", V10)),
    char = ifelse(nchar(temp) > 1, gsub('[0-9]',"", temp),V10)
  )

write.csv(raw4, file = "Lexile_Analysis.csv")
#df_status(raw3)
#df_status(Scholastic_Challenge_Dataset)

write.csv(raw2, file = "schl_cleaned_R.csv")


c1 <- raw2 %>%
  filter(V3 == "CHANNEL 1") %>%
  group_by(V2) %>%
  summarise(Total_Units_Ch1 = sum(V11)) %>% ungroup()

c2 <- raw2 %>%
  filter(V3 == "CHANNEL 2") %>%
  group_by(V2) %>%
  summarise(Total_Units_Ch2 = sum(V11)) %>% ungroup()


c3<- inner_join(c1,c2, "V2") %>% select(V2)

c4 <- inner_join(raw3, c3)

c4 %>% filter(V3 == "V3 1") %>% summarise(sum(V11))




write.csv(c3, file = "Common_Books.csv")

