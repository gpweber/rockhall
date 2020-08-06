library(shiny)    
ui <- fluidPage(
  
  ###Input(inputId = "playlist", 
            label = "Playlist",  ) ,
  
  
  ###Output$playlist( 
  )
  
server <- function(input, output) {         
  output$playlist <- renderPlot({
    ##_______(input$Playlist)
    
  }  )                                      
  
  
shinyApp(ui = ui, server = server)
  