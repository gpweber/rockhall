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
      scale_fill_manual(values = c("#FC4E07" ,"#00AFBB", "#E7B800" )) + #c("#00AFBB", "#E7B800", "#FC4E07")
      labs(title = "Which Artists has the most tracks?",               # (blue,         yellow,      red)
           y ='Total Number of Tracks' , 
           x = 'Performer' ) +
      
      coord_flip() +
      geom_text(aes(x = Artist, 
                    label = Artist, 
                    y = Total_Artist_Tracks/2), 
                    size = 12) +
      theme(plot.title = element_text(color = "red", 
                                      size = 36, 
                                      face = "bold", 
                                      hjust = 0.5),
            legend.position = "none", 
            axis.text.y=element_blank(),
            axis.title.x = element_text(size = 30),
            axis.title.y = element_text(size = 30))
  })
  
  
  ####not finished yet####
  output$artistPlot1 = renderPlot({  
    ### tab #1 ###
    # number of artist appearances
    q %>% 
      slice_max(n, n = 3) %>% 
      head(input$OneToFive) %>% 
      ggplot() +
      geom_col(mapping = aes(x = reorder(artists, n), 
                             y = n, 
                             fill = artists)) + 
      scale_fill_manual(values = c("#E7B800","#FC4E07","#00AFBB")) +
      labs(title = "Which Artists appears on the most playlists?", 
           y ='Total Number of Playlists' , 
           x = 'Performer' ) +
      
      coord_flip() +
      scale_y_reverse() +
      geom_text(aes(x = artists, 
                    label = artists, 
                    y = n/2), 
                    size = 12) +
      theme(plot.title = element_text(color = "red", 
                                      size = 36, 
                                      face = "bold", 
                                      hjust = 0.5),
            legend.position = "none", 
            axis.text.y=element_blank(),
            axis.title.x = element_text(size = 30),
            axis.title.y = element_text(size = 30))
  })
  ####not finished yet####
  
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
                    label = track_name, 
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
  output$maxpopBox <- renderInfoBox({
    infoBox("Maximum Popularity", 
             max((input$playlist)$popularity), 
             icon = icon("thumbs-up", 
                         lib = 'glyphicon'),
             color = "green"
    )
  })
  output$minpopBox <- renderInfoBox({
    infoBox(
      "Minimum Popularity", 
      "80%", 
      icon = icon("thumbs-down", 
                  lib = "glyphicon"),
      color = "red"
    )
  })
  output$careerPlot1 = renderPlotly({
    
    plot = career_defining %>% 
      filter(playlist_name == input$playlist) %>% 
      ggplot(mapping = aes(x = playlist_order, 
                           y = popularity, 
                           color = track_name)) +
      geom_point() +
      theme(legend.position= 'none') +
      labs(title = 'Career Defining Playlists', 
           x = "Playlist Track Order", 
           y = 'Track Popularity') +
      scale_x_continuous()
    ggplotly(plot) %>%
      layout(xaxis = list(dtick = 2))#, x = -10, y =-100))
  })
  output$my_grouped_table = DT::renderDataTable({datatable(
    data1 %>% filter(playlist_name == input$playlist), rownames = FALSE)
  }) 
})
  