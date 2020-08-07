library(shiny)
library(tidyverse)
library(shinydashboard)
library(RColorBrewer)
library(tidyr)
famer = read.csv('famer.csv')


fun = function(x){
  str_sub(x, 3,-3)
}

famer$track_artists = sapply(famer$track_artists, fun )
famer = separate(famer, track_artists, sep = "', '", c('first_artist','second_artist','third_artist','fourth_artist', 
          'fifth_artist', "sixth', 'seventh','eighth_artist(s)'"), extra = 'merge')

famer$number_of_artists = apply(famer, 1, ( function(x) sum(is.na(x))*-1 +6) )

famer$number_of_artists[2883] = 8

