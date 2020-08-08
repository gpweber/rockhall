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
                label = "Choose Top 1-3",
                choices = 1:3,
                selected = 1
            ),
            plotOutput('artistPlot'),# width = 12)
          )
      ),
      
      tabItem(tabName = 'popularity',
            fluidRow(
              sliderInput(
                inputId = "SlideOneToFive",
                label = "View the 3 Most Popular Artists",
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
            fluidRow(
              selectInput(
                inputId = 'playlist',
                label = "Choose Playlist",
                choices = unique_playlists,
                selected = 1
                ),
              plotlyOutput('durationPlot1', width = "125%")
            )
      )
    )
  )
)