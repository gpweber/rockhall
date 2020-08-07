shinyServer(function(input, output) {
  output$artistPlot = renderPlot({
    ### tab #1 ###
    # number of artist appearances
    ##Next Step: make it so that slider starts with just #1...then slide to more
    
    total_tracks %>% 
      slice_max(Total_Artist_Tracks, n = 3) %>% 
      ggplot() +
      geom_col(mapping = aes(x = Artist, y = Total_Artist_Tracks, fill = Artist)) + 
      labs(title = "Which Artists appear most?", y ='Number of tracks' , x = 'Performer' ) +
      coord_flip() +
      theme(legend.position = "none")     
   })      
})