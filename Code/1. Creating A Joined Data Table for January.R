#I had to download the data for each day manually here. In this Code, I clean up the table a little :)

library(readxl)

MachiningReportJanuary = read_excel("./Data/Machining Report 31.xlsx")
 
for (i in 30:1){
  path = paste("./Data/Machining Report ",i,".xlsx",sep = "")
  MachiningReport = read_excel(path)
  MachiningReportJanuary = rbind(MachiningReportJanuary , MachiningReport)
  
}
data = MachiningReportJanuary

#Organizing Everything a Little

library(dplyr)
library(lubridate)

data$`ProducedAtFormatted`=   ymd_hms(data$`Produced At`)

data = data %>% mutate(`Time Difference (second)` = as.numeric(difftime(data$`ProducedAtFormatted`, lead(data$`ProducedAtFormatted`))))
data$`Time Difference`[nrow(data)] <- 0

data = data %>%  mutate(`Hour`= hour(data$`ProducedAtFormatted`))
data = data %>%  mutate(`Day`= day(data$`ProducedAtFormatted`))

#confirm_all_days = data %>% group_by(`Day`) %>% summarize(n())

?write.csv(data, file= "./Data/MachiningReportJanuary.csv",row.names = FALSE)