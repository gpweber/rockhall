dashboardPage(
  dashboardHeader(title = "Rock & Roll Hall of Fame Spotify Playlists"),
  
  dashboardSidebar(
    sidebarUserPanel("Created by Gregory Weber")
    sidebarMenu(
      menuItem('Artist Frequency', tabName = 'artist' , icon = 'drum'),
      menuItem("Spotify's Popularity Ranking",tabName = 'popularity' , icon = 'spotify'),
      menuItem('Duration', tabName = 'duration', icon = 'headphones'),
      menuItem("Learn more about App's Creator: Gregory Weber", tabName = 'author', icon = 'info')
    ),
    
  dashboardBody(
    tabItems(
      tabItem(tabName = 'artist'),
        fluidRow()
    )
    )
    valueBox(100, "Basic example"),
    tableOutput("some_datafram")
  )