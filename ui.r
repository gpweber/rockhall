dashboardPage(skin = 'black',
  dashboardHeader(title = "Rock&RollHallOfFame Spotify Playlists" #,
                  #image = img(src = 'rockhall_spotify.png')              NEITHER WORKED
                  #image = 'rockhall_spotify.png'#titleWidth = 225), 
  ),
              
  
  dashboardSidebar(
    #width = 225
   # sidebarUserPanel("Gregory Weber", image = img(src = 'IMG_3969.JPG')), #???Need this???
    sidebarMenu(
      menuItem('The Data', 
                tabName = 'data', 
                icon = icon('info')),
      menuItem('Artist Frequency', 
                tabName = 'artist' , 
                icon = icon('drum')),
      menuItem("Spotify's Popularity Ranking",
                tabName = 'popularity' , 
                icon = icon('spotify')),
      menuItem('Career Defining Playlists', 
                tabName = 'career', 
                icon = icon('headphones'))
     #menuItem("Learn more about App's Creator: Gregory Weber", tabName = 'author', icon = icon('info'))
    )   
  ),
    
  dashboardBody(
    tabItems(
      tabItem(tabName = 'data',
        fluidRow(
          DT::dataTableOutput("mytable")        
        )
      ),
      tabItem(tabName = 'artist',
          fluidRow(
            box(
              selectInput(
                inputId = 'OneToFive',
                label = "Choose Top 1-3",
                choices = 0:3,
                selected = 0
              )
            )
          ),
          fluidRow(  
            box(
              plotOutput('artistPlot')
            ),
            box(
              plotOutput('artistPlot1')
            ), 
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
              plotOutput('popularityPlot1', 
                         width = '75%' ),
              
              br(),
              br(),
              br(),
              br(),
              
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
            
      tabItem(tabName = 'career',
            fluidRow(
              infoBoxOutput("maxpopBox"),
              infoBoxOutput("minpopBox"),
              selectInput(
                inputId = 'playlist',
                label = "Choose Playlist",
                choices = career_defining_list,
                selected = (sort(career_defining_list))[1]
                ),
              plotlyOutput('careerPlot1'),
              br(),
              br(),
              DT::dataTableOutput("my_grouped_table")        
            )
        
      )
    )
  )
)