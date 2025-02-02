data = read.csv("./Data/MachiningReportJanuary.csv")

TimedataByProduct = data %>%  group_by(`Program.Name`,`Hour`,`Power.Status`) %>%  summarise(sum(`Time.Difference`))

StationNamedata = count(data , `Station.Name` )

DImode = data %>% filter(`Machining.Mode`== "DI") %>%  group_by(`Machining.Mode`, `Station.Name`) %>%  summarise()

install.packages("sqldf")
library(sqldf)
pl = sqldf("SELECT * from data limit 5")