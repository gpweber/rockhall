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
  output$popularityPlot = renderPlot({
    #still need to work on input selecter ##worse comes to worse reuse above selector
    ggplot(topten_popularity, mapping = aes(y = popularity, x = pop_rank_integer, fill = track_artists)) +
      geom_col() +
      geom_label(label= topten_popularity$track_name ) +
      labs(title = "Top Tracks by Spotify's Popularity Index" , y ='Popularity' , x = 'Performer' ) +
      guides(guide_legend(title.theme = element_blank, reverse = TRUE, title = 'Artist'))
  })
})