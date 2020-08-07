shinyUI(dashboardPage(
  dashboardHeader(title = "Rock & Roll Hall of Fame Spotify Playlists", 
                  image = 'rockhall_spotify.png'  )
              ),
  
  dashboardSidebar(
    sidebarUserPanel("Created by Gregory Weber", image = 'IMG_3969.JPG'),
    sidebarMenu(
      menuItem('Artist Frequency', tabName = 'artist' , icon = 'drum'),
      menuItem("Spotify's Popularity Ranking",tabName = 'popularity' , icon = 'spotify'),
      menuItem('Duration', tabName = 'duration', icon = 'headphones'),
      menuItem("Learn more about App's Creator: Gregory Weber", tabName = 'author', icon = 'info')
                  )   
              ),
    
  dashboardBody(
    tabItems(
      tabItem(tabName = 'artist',
              'to be replace with sideways bargraph'),
      tabItem(tabName = 'popularity',
              '3 options: Boxplot for each album, 
              with dotplot option & violin option'),
      tabItem(tabName = 'duration',
              'per album..show song lengths of tracks 
              with geom_line(need dot to say name of track)')
      
              )
          )
  )