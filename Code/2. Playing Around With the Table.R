data = read.csv("./Data/MachiningReportJanuary.csv")

TimedataByProduct = data %>% filter(Day == 8 & Station.Name == "HAAS CM-1" & `Time.Difference` < 3600) %>% 
  group_by(`Program.Name`,`Hour`,`Power.Status`) %>%  
  summarise(sum(`Time.Difference`))

exp = data %>% filter(Day == 8 & Station.Name == "HAAS CM-1" & `Hour` == 9 & `Time.Difference` < 3600) #%>% 
  #group_by(`Hour`) %>%  
  #summarise(sum(`Time.Difference`))
#basically this is an experiment to confirm the very first time difference is very high

StationNamedata = count(data , `Station.Name` )
ThisCycleData = count(data , `This.Cycle` )

DImode = data %>% filter(`Machining.Mode`== "DI") %>%  group_by(`Machining.Mode`, `Station.Name`) %>%  summarise()


library(sqldf)
pl = sqldf("SELECT * from data limit 5")
jan8data = sqldf("select * from data where Day = 8 and `Station.Name` = 'HAAS CM-1'")
groupeddata = sqldf("select `Program.Name`, `Hour`, `Power.Status`,sum(`Time.Difference`) as TimeElapsed from jan8data group by `Program.Name`, `Hour`, `Power.Status` order by hour")

