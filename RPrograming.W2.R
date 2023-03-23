

library(tidyverse)
library(data.table)


# PollutantMean -----------------------------------------------------------

pollutantmean <- function(directory, pollutant, ID = 1:332) {
    setwd(directory)
    id = ID
    data <- list.files(pattern = "*.csv") %>% 
        map_df(~fread(.)) %>% 
        filter( . , 
                ID >= id[1] & ID <= id[length(id)])
    data2 = data[[pollutant]]
    mean = mean(data2, na.rm = T)
    return(mean)
}

pollutantmean("C:\\Career\\Programming\\specdata", "sulfate", 1:10)

pollutantmean("C:\\Career\\Programming\\specdata", "nitrate", 23)











# Complete ----------------------------------------------------------------

complete <- function(directory, ID = 1:332) {
    setwd(directory)
    id = ID
    data <- list.files(pattern = "*.csv") %>% 
        map_df(~fread(.)) %>% 
        filter( . , 
                ID >= id[1] & ID <= id[length(id)]) %>%
        group_by(ID) %>%
        summarise(nobs = sum(!is.na(sulfate) & !is.na(nitrate)))
    
    table = as.data.frame(data)  
    return(table)
}

complete("C:\\Career\\Programming\\specdata", c(2, 3))

complete("C:\\Career\\Programming\\specdata", c(2, 4, 8, 10, 12))

complete("C:\\Career\\Programming\\specdata", 30:25)




