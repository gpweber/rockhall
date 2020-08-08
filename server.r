shinyServer(function(input, output) {
  output$artistPlot = renderPlot({  
    ### tab #1 ###
    # number of artist appearances
    ##Next Step: make it so that slider starts with just #1...then slide to more
    
    
    total_tracks %>% 
      slice_max(Total_Artist_Tracks, n = 3) %>% 
      head(input$OneToFive) %>% 
      ggplot() +
      geom_col(mapping = aes(x = Artist, 
                             y = Total_Artist_Tracks, 
                             fill = Artist)) + 
      labs(title = "Which Artists appear most?", 
           y ='Number of tracks' , 
           x = 'Performer' ) +
      coord_flip() +
      theme(legend.position = "none")     
  })
  #2nd tab - 1st plot
  ##popularity histogram by track
  output$popularityPlot1 = renderPlot({
    #still need to work on input selecter ##worse comes to worse reuse above selector
    topten_popularity = topten_popularity[ 1:input$SlideOneToFive, ]
    ggplot(topten_popularity, mapping = aes(y = popularity, x = pop_rank_integer, fill = track_artists)) +
      geom_col() +
      geom_label(label= topten_popularity$track_name ) +
      labs(title = "Top Tracks by Spotify's Popularity Index" , y ='Popularity' , x = 'Performer' ) +
      guides(guide_legend(title.theme = element_blank, reverse = TRUE, title = 'Artist'))
  })
  #2nd tab - 2nd plot 
  ##popularity histogram of popularity scores by playlist
  #bins <- seq(min(x), max(x), length.out = input$bins + 1)
  output$popularityPlot2 = renderPlot({
    mean1 = mean(popularity_playlist$playlist_average)
    popularity_playlist %>% 
      ggplot() +
      geom_histogram(mapping = aes(x = playlist_average,fill=..x..), bins = input$bins + 1, boundary = 0, show.legend = FALSE) +
      scale_fill_gradient(low="yellow", high="orange") +
      labs(title = 'Average Spotify Popularity Score by Playlist', x = "Playlist's Spotify Popularity", y = 'Number of playlists in this range') +
      geom_label(mapping = aes(x =38, y = 35), label = 'Average Score', hjust = 0) +
      geom_vline(xintercept = mean1, label = 'Average Playlist Score', )
  })
  output$durationPlot1 = renderPlot({
    add_order_col %>% 
      filter(playlist_name == input$playlist) %>% 
      ggplot(mapping = aes(x = row_number, y = track_length, color = track_name)) +
      geom_point() +
      scale_y_time() +
      scale_fill_continuous(guide = guide_legend()) +
      theme(legend.position="bottom")
    
    
   
  
  })
})