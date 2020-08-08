dashboardPage(skin = 'black',
  dashboardHeader(title = "Rock&RollHallOfFame Spotify Playlists" #,
                  #image = img(src = 'rockhall_spotify.png')              NEITHER WORKED
                  #image = 'rockhall_spotify.png'#titleWidth = 225), 
  ),
              
  
  dashboardSidebar(
    #width = 225
   # sidebarUserPanel("Gregory Weber", image = img(src = 'IMG_3969.JPG')), #???Need this???
    sidebarMenu(
      menuItem('Artist Frequency', tabName = 'artist' , icon = icon('drum')),
      menuItem("Spotify's Popularity Ranking",tabName = 'popularity' , icon = icon('spotify')),
      menuItem('Duration', tabName = 'duration', icon = icon('headphones'))
     # menuItem("Learn more about App's Creator: Gregory Weber", tabName = 'author', icon = icon('info'))
    )   
  ),
    
  dashboardBody(
    #tags$head
    tabItems(
      #???fluidRow( ???
      tabItem(tabName = 'artist',
          fluidRow(
            selectInput(
                inputId = 'OneToFive',
<<<<<<< HEAD
                label = "Choose Top 1-3",
                choices = 1:3,
=======
                label = "Choose Top 1-5",
                choices = 1:5,
>>>>>>> 787d2960e64740a722370ab8af1ca996e4bc2362
                selected = 1
            ),
            plotOutput('artistPlot'),# width = 12)
          )
      ),
      
      tabItem(tabName = 'popularity',
            fluidRow(
              sliderInput(
                inputId = "SlideOneToFive",
<<<<<<< HEAD
                label = "View the 3 Most Popular Artists",
=======
                label = "View the 5 Most Popular Artists",
>>>>>>> 787d2960e64740a722370ab8af1ca996e4bc2362
                min = 1,
                max = 3,
                value = 1
              ),
              plotOutput('popularityPlot1'),
            ) ,
            fluidRow(
              sliderInput(
                inputId = "bins",
                label = "Divide into this many pieces:",
                min = 2,
                max = 27,
                value = 14),
              
              plotOutput('popularityPlot2')
            )
      ),
            
      tabItem(tabName = 'duration',
              
              'per album..show song lengths of tracks 
              with geom_line(need dot to say name of track)')
    )
  )
)