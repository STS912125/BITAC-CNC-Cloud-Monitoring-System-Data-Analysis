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

# Time Difference = seconds between a log and the previous (older) log FROM THE SAME MACHINE.
# Logs from different stations are interleaved in the raw files, so we group by station and
# sort each station's logs newest-first before using lead(). Each station's oldest log has no
# earlier log to compare with, so its Time Difference is set to 0.
data = data %>%
  group_by(`Station Name`) %>%
  arrange(desc(`ProducedAtFormatted`), .by_group = TRUE) %>%
  mutate(`Time Difference` = as.numeric(difftime(`ProducedAtFormatted`, lead(`ProducedAtFormatted`), units = "secs"))) %>%
  mutate(`Time Difference` = coalesce(`Time Difference`, 0)) %>%
  ungroup() %>%
  arrange(desc(`ProducedAtFormatted`))

data = data %>%  mutate(`Hour`= hour(`ProducedAtFormatted`))
data = data %>%  mutate(`Day`= day(`ProducedAtFormatted`))

#confirm_all_days = data %>% group_by(`Day`) %>% summarize(n())

write.csv(data, file= "./Data/MachiningReportJanuary.csv",row.names = FALSE)