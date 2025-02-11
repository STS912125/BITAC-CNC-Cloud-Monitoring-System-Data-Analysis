data = read.csv("./Data/MachiningReportJanuary.csv")
library(dplyr)

StationWise_Hourly_Availability = data %>% filter(`Time.Difference` < 7200) %>% 
  group_by(`Day`,`Station.Name`,`Hour`) %>%  
  summarise(`Active Time` = sum(`Time.Difference`[`Power.Status` == "ACTIVE"]),
            `Stopped Time` = sum(`Time.Difference`[`Power.Status` == "STOPPED"])) %>% 
  arrange(Day, Hour) %>% ungroup() %>% 
  group_by(`Day`,`Station.Name`) %>% mutate(`Sum of Active Time` = cumsum(`Active Time`)) %>% 
  mutate(`Elapsed time` = 3600 ) %>% mutate(`Total Elapsed time` = cumsum(`Elapsed time`) ) %>% 
  mutate(`Availability` = round((`Sum of Active Time`)*100/(`Total Elapsed time`),digits = 2))

StationWise_Daily_Availability = StationWise_Hourly_Availability %>% group_by(`Day`,`Station.Name`) %>% 
  summarise(`Daily Availability` = last(`Availability`))

ProductWise_Hourly_Availability = 
# StationNamedata = count(data , `Station.Name` )
# ThisCycleData = count(data , `This.Cycle` )

library(sqldf)
# pl = sqldf("SELECT * from data limit 5")
# jan8data = sqldf("select * from data where Day = 8 and `Station.Name` = 'HAAS CM-1'")
# groupeddata = sqldf("select `Program.Name`, `Hour`, `Power.Status`,sum(`Time.Difference`) as TimeElapsed from jan8data group by `Program.Name`, `Hour`, `Power.Status` order by hour")

