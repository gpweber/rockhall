library(shiny)
library(tidyverse)
library(shinydashboard)
library(RColorBrewer)
library(tidyr)
library(DT)
library(googleVis)
library(tibble)
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
famer_index = famer

x = unlist(famer[4:8])

#remove the NA's
x1 = x[!is.na(x)]

#Turn into a dataframe
x2 = as.data.frame(x1)

#add the 5 extra artists from the sixth spillover column
x3 = x2 %>% 
  rbind('Yo Gotti', 'Quavo', 'Desiigner', 'Paul Shaffer', 'Metallica')

#create total_tracks dataframe with tallies for number of tracks per artist
total_tracks = x3 %>% 
  count(x1, sort = TRUE, name = "Total_Artist_Tracks")

#Top 3 artist by number of tracks
total_tracks %>% 
  slice_max(Total_Artist_Tracks, n = 3)

#########VISUALS##########
### tab #1 ###
# number of artist appearances
##Next Step: make it so that slider starts with just #1...then slide to more
total_tracks$Artist = total_tracks$x1
total_tracks %>% 
  slice_max(Total_Artist_Tracks, n = 3) %>% 
  ggplot() +
  geom_col(mapping = aes(x = Artist, y = Total_Artist_Tracks, fill = Artist)) + 
  labs(title = "Which Artists appear most?", y ='Number of tracks' , x = 'Performer' ) +
  coord_flip() +
  theme(legend.position = "none")
  

### tab #2 ###
#Total popularity plot by track
topten_popularity = famer_original %>%    
  arrange(popularity) %>%
  select(playlist_name, track_name, popularity, track_artists) %>% 
  mutate(pop_rank_decimal = rank(-popularity)) %>% 
  mutate(pop_rank_integer = as.numeric(ordered(pop_rank_decimal))) %>% 
  arrange(pop_rank_integer) %>% 
  filter(pop_rank_integer <=3)
topten_popularity

ggplot(topten_popularity, mapping = aes(y = popularity, x = pop_rank_integer, fill = track_artists)) +
  geom_col() +
  geom_label(label= topten_popularity$track_name ) +
  labs(title = "Top Tracks by Spotify's Popularity Index" , y ='Popularity' , x = 'Performer' ) +
  guides(fill = guide_legend(reverse = TRUE))