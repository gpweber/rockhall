shinyServer(function(input, output) {
  
  output$mytable = DT::renderDataTable({
    data1
  }) 
  
  output$artistPlot = renderPlot({  
    ### tab #1 ###
    # number of artist appearances
  
    
    
    total_tracks %>% 
      slice_max(Total_Artist_Tracks, n = 3) %>% 
      head(input$OneToFive) %>% 
      ggplot() +
      geom_col(mapping = aes(x = Artist, 
                             y = Total_Artist_Tracks, 
                             fill = Artist)) + 
      labs(title = "Which Artists appear most?", 
           y ='Total Number of Tracks' , 
           x = 'Performer' ) +
      
      coord_flip() +
      geom_text(aes(x = Artist, 
                    label = Artist, 
                    y = Total_Artist_Tracks/2), 
                    size = 25) +
      theme(plot.title = element_text(color = "red", 
                                      size = 36, 
                                      face = "bold", 
                                      hjust = 0.5),
            legend.position = "none", 
            axis.text.y=element_blank())
  })
  #2nd tab - 1st plot
  ##popularity histogram by track
  output$popularityPlot1 = renderPlot({
    #still need to work on input selecter ##worse comes to worse reuse above selector
    topten_popularity
    topten_popularity = topten_popularity[ 1:input$SlideOneToFive, ]
    ggplot(topten_popularity, 
           mapping = aes(y = popularity, 
                         x = pop_rank_integer, 
                         fill = str_sub(track_artists,2,-2), 
                         show.legend = FALSE) 
    )+
      geom_col() +
      #geom_label(aes(label= str_sub(track_artists,2,-2)), show.legend = FALSE) +
      geom_text(aes(x = pop_rank_integer, 
                    label = topten_popularity$track_name, 
                    y = popularity/2), size = 25) +
      labs(title = "Top Tracks by Spotify's Popularity Index" , 
           y ='Popularity' , 
           x = 'Performer' ) +
      guides(guide_legend(title.theme = element_blank) )+
      coord_flip() +
      theme(plot.title = element_text(color = "green", 
                                      size = 48, 
                                      face = "bold", 
                                      hjust = 0.5))
  })
  #2nd tab - 2nd plot 
  ##popularity histogram of popularity scores by playlist
  #bins <- seq(min(x), max(x), length.out = input$bins + 1)
  output$popularityPlot2 = renderPlot({
    mean1 = mean(popularity_playlist$playlist_average)
    popularity_playlist %>% 
      ggplot() +
      geom_histogram(mapping = aes(x = playlist_average,
                                   fill=..x..), 
                     bins = input$bins + 1, 
                     boundary = 0, 
                     show.legend = FALSE) +
      scale_fill_gradient(low="yellow", high="orange") +
      labs(title = 'Average Spotify Popularity Score by Playlist', 
           x = "Playlist's Spotify Popularity", 
           y = 'Number of playlists in this range') +
      geom_label(mapping = aes(x =38, y = 35), 
                 label = 'Average Score', 
                 hjust = 0) +
      geom_vline(xintercept = mean1, 
                 label = 'Average Playlist Score', ) +
      theme(plot.title = element_text(color = "orange", 
                                      size = 48, 
                                      face = "bold", 
                                      hjust = 0.5))
  })
  output$durationPlot1 = renderPlotly({
    plot = data1 %>% 
      filter(playlist_name == input$playlist) %>% 
      ggplot(mapping = aes(x = playlist_order, y = track_length, color = track_name)) +
      geom_point() +
      scale_y_time() +
     # scale_fill_continuous(guide = guide_legend()) +
      #theme(legend.position="bottom",) +
      labs(title = 'Track Length Variation per Playlist', 
           x = "Playlist Track Order", 
           y = 'Length of Track') +
      scale_x_continuous()
    ggplotly(plot) %>%
      layout(xaxis = list(dtick = 2), legend = list(orientation = "v"))#, x = -10, y =-100))
  })
  output$my_grouped_table = DT::renderDataTable({datatable(
    data1 %>% filter(playlist_name == input$playlist), rownames = FALSE)
  }) 
})
  