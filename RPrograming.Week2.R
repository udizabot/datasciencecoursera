

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

pollutantmean("C:\\Career\\Programming\\specdata", "nitrate", 70:72)

pollutantmean("C:\\Career\\Programming\\specdata", "nitrate", 23)



# Complete ----------------------------------------------------------------

complete <- function(directory, ID = 1:332) {
    setwd(directory)
    id = ID
    data <- list.files(pattern = "*.csv") %>% 
        map_df(~fread(.)) %>% 
        filter( . , 
                ID %in% id) %>%
        group_by(ID) %>%
        summarise(nobs = sum(!is.na(sulfate) & !is.na(nitrate))) %>%
        arrange( . , id)
    table = as.data.frame(data)  
    return(table)
}

complete("C:\\Career\\Programming\\specdata", 1)

complete("C:\\Career\\Programming\\specdata", c(2, 3))

complete("C:\\Career\\Programming\\specdata", c(2, 4, 8, 10, 12))

complete("C:\\Career\\Programming\\specdata", 30:25)



# Correlation -------------------------------------------------------------


corr <- function(directory, threshold = 0) {
    "directory" = directory
    Table <- complete(directory) 
    threshold = threshold
    Table2 <- filter(Table, nobs > threshold)
    index <- Table2$ID
    data <- list.files(pattern = "*.csv") %>% 
        map_df(~fread(.)) %>% 
        filter( . , 
                ID %in% index, 
                !is.na(sulfate) & !is.na(nitrate)) %>%
        group_by(ID) %>%
        summarize(corr = as.numeric(cor(sulfate, nitrate)))
    corr = data$corr
    return(corr)
}

cr <- corr("C:\\Career\\Programming\\specdata", 150)
head(cr)
summary(cr)

cr <- corr("C:\\Career\\Programming\\specdata", 400)
head(cr)
summary(cr)

cr <- corr("C:\\Career\\Programming\\specdata", 5000)
summary(cr)
length(cr)

cr <- corr("C:\\Career\\Programming\\specdata")
length(cr)



