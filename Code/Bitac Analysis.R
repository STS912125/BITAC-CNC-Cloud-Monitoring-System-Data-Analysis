library(readxl)
Machining_Report30 <- read_excel("F:/Sumaiya/R/Playing Around With BITAC Data/Data/Machining Report 30.xlsx")
Machining_Report29 <- read_excel("F:/Sumaiya/R/Playing Around With BITAC Data/Data/Machining Report 29.xlsx")
Machining_Report28 <- read_excel("F:/Sumaiya/R/Playing Around With BITAC Data/Data/Machining Report 28.xlsx")
Machining_Report27 <- read_excel("F:/Sumaiya/R/Playing Around With BITAC Data/Data/Machining Report 27.xlsx")
Machining_Report26 <- read_excel("F:/Sumaiya/R/Playing Around With BITAC Data/Data/Machining Report 26.xlsx")

Machining_Report8 <- read_excel("F:/Sumaiya/R/Playing Around With BITAC Data/Data/Machining Report 8.xlsx")


library(dplyr)
Machining_Report_26_30 <- rbind(Machining_Report30,Machining_Report29,Machining_Report28,Machining_Report27,Machining_Report26)

data <- Machining_Report8

library(lubridate)

data$`ProducedAtFormatted`=   ymd_hms(data$`Produced At`)

data = data %>%  mutate(`Hour`= hour(data$`ProducedAtFormatted`))


data = data %>% mutate(`Time Difference` = as.numeric(difftime(data$`ProducedAtFormatted`, lead(data$`ProducedAtFormatted`))))
data$`Time Difference`[nrow(data)] <- 0

TimedataByProduct = data %>%  group_by(`Program Name`,`Hour`,`Power Status`) %>%  summarise(sum(`Time Difference`))

StationNamedata = count(Machining_Report_26_30 , `Station Name` )

DImode = Machining_Report_26_30 %>% filter(`Machining Mode`== "DI") %>%  group_by(`Machining Mode`, `Station Name`) %>%  summarise()
