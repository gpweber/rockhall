dashboardPage(skin = 'black',
  dashboardHeader(title = "Rock&RollHallOfFame Spotify Playlists" #,
                  #image = img(src = 'rockhall_spotify.png')              NEITHER WORKED
                  #image = 'rockhall_spotify.png'#titleWidth = 225), 
  ),
              

  dashboardSidebar(
    #width = 225
   # sidebarUserPanel("Gregory Weber", img (src = 'IMG_3969.JPG')), #???Need this???
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
              img(src = "rockhall_spotify.png", width = '75%'),
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
            box(
              sliderInput(
                inputId = "SlideOneToFive",
                label = "View the Top 3 Artists by Popularity Index",
                min = 1,
                max = 3,
                value = 1
              )
            )
          ),
          fluidRow(
            plotOutput('popularityPlot1')
          ),
              
              br(),
              br(),
              br(),
              br(),
              
          
            fluidRow(
              box(
                sliderInput(
                  inputId = "bins",
                  label = "All Playlist Averages Below. You can cut into 4-20 sections.",
                  min = 4,
                  max = 20,
                  value = 12)
              ),
            ),
          fluidRow(
              plotOutput('popularityPlot2')
          )
      ),
            
      tabItem(tabName = 'career',
            fluidRow(
              selectInput(
                inputId = 'playlist',
                label = "Choose a Career Defining Playlist",
                choices = career_defining_list,
                selected = (sort(career_defining_list))[1]
                ),
              
              plotlyOutput('careerPlot1'),
              br(),
              br(),
              DT::dataTableOutput("my_grouped_table"),
              br(),
              br(),
              plotlyOutput('careerPlot2'),
            )
        
      )
    )
  )
)