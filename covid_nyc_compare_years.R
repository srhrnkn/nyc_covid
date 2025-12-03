library(tidyverse)
library(magrittr)
covid_data <- read_csv("https://raw.githubusercontent.com/nychealth/coronavirus-data/master/trends/data-by-day.csv")
#glimpse(covid_data)

covid_data <- covid_data |> 
    mutate(date_of_interest = mdy(date_of_interest))
    #start after Omicron to get a usable y scale
    start_date <- ymd(20220601)

concurrent_calendar_year <- function(df){
    df$plot_date <- df$date_of_interest
    year(df$plot_date) <- max(year(df$date_of_interest))

    return(df)
}


library(plotly)
plot_ly((covid_data |> 
    filter(date_of_interest>start_date) |> 
    concurrent_calendar_year() |> mutate(year = as.factor(year(date_of_interest)))), 
x = ~plot_date, 
y = ~CASE_COUNT_7DAY_AVG,
color = ~year) 


plot_ly((covid_data |> 
    filter(date_of_interest>start_date) |> 
    concurrent_calendar_year() |> mutate(year = as.factor(year(date_of_interest)))), 
x = ~plot_date, 
y = ~DEATH_COUNT_7DAY_AVG,
color = ~year) 


plot_ly((covid_data |> 
    filter(date_of_interest>start_date) |> 
    concurrent_calendar_year() |> mutate(year = as.factor(year(date_of_interest)))), 
x = ~plot_date, 
y = ~HOSP_COUNT_7DAY_AVG,
color = ~year) 
    

