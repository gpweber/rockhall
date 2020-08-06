library(shiny)
library(tidyverse)
library(shinydashboard)
library(RColorBrewer)
library(tidyr)
famer = read.csv('famer.csv')
dim(famer)

fun = function(x){
  str_sub(x, 3,-3)
}
head(famer$track_artists) = sapply(famer$track_artists, fun )
famer = separate(famer, track_artists, sep = "', '", c('first_artist','second_artist','third_artist','fourth_artist', 
          'fifth_artist', "sixth', 'seventh', ', 'eighth_artist(s)"), extra = 'merge')

famer$na_count <- apply(famer, 1, function(x) sum(is.na(x)))
famer %>% 
  separate(c("first_artist":'fifth_artist'), count = NA, append = TRUE, var = 'number_of_artists')
famer
