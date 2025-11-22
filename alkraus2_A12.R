#Set variable for where the files are located for script robustness
#The script should be in the same working directory as the folder containing the Fauchald datasets
seaDIRNAME <- "FauchaldEtAl2017/sea_ice.csv"
snowDIRNAME <- "FauchaldEtAl2017/snow.csv"

#Read in the necessary data
seaice <- read_tsv(seaDIRNAME)
snow <- read_tsv(snowDIRNAME)

#Transform the seaice dataset to be in tidy format and group years together
seaice %>% pivot_longer(3:14, names_to = "Month", values_to = "Cover")
seaice <- seaice %>% gather(Month, Cover, 3:14)

#Join the 2 dataset on their common columns "Herd" and "Year"
combined <- inner_join(seaice, snow, by = c("Herd", "Year"))

#Filter the combined dataset to include only data from the month of March
March <- combined %>% filter(Month == "Mar")

#Group by herd
Grouped_March <- March %>% group_by(Herd)

#Now that we have the data that we want, time to plot using ggplot2
plot <- ggplot(data = Grouped_March) + aes(x = Cover, y = Week_snowmelt, color = Herd) + geom_point()
plot + ylab("Snow Melt Week") + xlab("Proportion of Surface Covered by Ice") + ggtitle("Surface Ice Coverage vs Snow Melt Week Per Caribou Herd")
