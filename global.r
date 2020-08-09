library(shiny)
library(tidyverse)
library(shinydashboard)
library(RColorBrewer)
library(tidyr)
library(DT)
library(data.table)
#library(googleVis)
library(tibble)
library(plotly)
#csv of RockHall playlists from spotify
#obtained with spotipy using python
famer_original = read.csv('famer.csv')
famer = famer_original
# create function to remove first 2 and last 2 characters of a string
fun = function(x){
  str_sub(x, 3,-3)
}

#remove brackets and extra quotes from beginning and end of artists listings
famer$track_artists = sapply(famer$track_artists, fun )

#split artists into separate cells (lots of NAs are produced)
famer = separate(famer, track_artists, sep = "', '", c('first_artist','second_artist','third_artist','fourth_artist', 
          'fifth_artist', "sixth', 'seventh','eighth_artist(s)'"), extra = 'merge')

#use the number of NA's to determine the number of artists in a row 
famer$number_of_artists = apply(famer, 1, ( function(x) sum(is.na(x))*-1 +6) )

#There is one track with more than 6 artists
#manual change the number_of_artists count for that track
famer$number_of_artists[2883] = 8

############create dataframe with artist counts#####################
#combine the 5 artist columns into one vector
famer_index = famer #saves df with artists separate

x = unlist(famer[4:8])

#remove the NA's
x1 = x[!is.na(x)]

#Turn into a dataframe
x2 = as.data.frame(x1)

#add the 5 extra artists from the sixth spillover column
x3 = x2 %>% 
  rbind('Yo Gotti', 'Quavo', 'Desiigner', 'Paul Shaffer', 'Metallica')

### For tab - artist ###
#create total_tracks dataframe with tallies for number of tracks per artist
total_tracks = x3 %>% 
  count(x1, sort = TRUE, name = "Total_Artist_Tracks")

#change column name to Artist
total_tracks = total_tracks %>%  rename(Artist = x1)

### For tab - popularity ###
##Plot1##
#Total popularity plot by track
topten_popularity = famer_original %>%    
  arrange(popularity) %>%
  select(playlist_name, track_name, popularity, track_artists) %>% 
  mutate(pop_rank_decimal = rank(-popularity)) %>% 
  mutate(pop_rank_integer = as.numeric(ordered(pop_rank_decimal))) %>% 
  arrange(pop_rank_integer) %>% 
  filter(pop_rank_integer <=3)

##Plot 2##
#Create popularity by playlist dataframe 
popularity_playlist = famer %>%    
  group_by(playlist_name) %>% 
  summarize(playlist_average = mean(popularity)) %>% 
  arrange(desc(playlist_average)) 

##For tab - duration###
#convert milliseconds to rounded minutes and seconds
min_sec_famer = famer_original %>% 
  mutate(track_length = new_hms(duration_ms%/%1000))

#create a playlists list
unique_playlists = unique(famer$playlist_name)

#create playlist 
add_order_col = min_sec_famer %>% 
  group_by(playlist_name) %>% 
  mutate(row_number = row_number())

### For tab - data ###
 
data1 = add_order_col %>% 
  select(playlist_order = row_number , origin_album_track_number = track_number, everything()) 
data1 = data1[c(-3,-8)]
