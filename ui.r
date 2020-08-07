dashboardPage(skin = 'black',
  dashboardHeader(title = "Rock & Roll Hall of Fame Spotify Playlists" #,
                  #image = img(src = 'rockhall_spotify.png')              NEITHER WORKED
                  #image = 'rockhall_spotify.png'#titleWidth = 225), 
  ),
              
  
  dashboardSidebar(
    #width = 225
   # sidebarUserPanel("Gregory Weber", image = img(src = 'IMG_3969.JPG')), #???Need this???
    sidebarMenu(
      menuItem('Artist Frequency', tabName = 'artist' , icon = icon('drum')),
      menuItem("Spotify's Popularity Ranking",tabName = 'popularity' , icon = icon('spotify')),
      menuItem('Duration', tabName = 'duration', icon = icon('headphones')),
      menuItem("Learn more about App's Creator: Gregory Weber", tabName = 'author', icon = icon('info'))
    )   
  ),
    
  dashboardBody(
    #tags$head
    tabItems(
      #???fluidRow( ???
      tabItem(tabName = 'artist',
              fluidRow(
                selectizeInput(
                    inputId = '1-5',
                    label = "Choose Top 1-5",
                            choices = c(1:5)
                )
              )
              #  box(plotOutput('artist')),
      ),
      tabItem(tabName = 'popularity',
              sliderInput(
                inputId = "Also1-5",
                label = "View the 5 Most Popular Artists",
                min = 1,
                max = 5,
                value = 1,
                step = 1
              )
      ),
              # boxplot?
      tabItem(tabName = 'duration',
              
              'per album..show song lengths of tracks 
              with geom_line(need dot to say name of track)')
    )
  )
)