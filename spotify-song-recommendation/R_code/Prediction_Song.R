library(shiny)
library(dplyr)
library(stringdist)
library(shinyWidgets)

# Load your cleaned dataset
spotify_data <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-01-21/spotify_songs.csv')

# Cleaning the dataset
spotify_data$track_id <- NULL
spotify_data$track_album_id <- NULL
spotify_data$playlist_id <- NULL
spotify_data_cleaned <- spotify_data %>%
  distinct(track_name, track_artist, .keep_all = TRUE) %>%
  mutate(release_year = as.numeric(format(as.Date(track_album_release_date, "%Y-%m-%d"), "%Y")))

# Shiny UI
ui <- fluidPage(
  titlePanel("Song Recommendation System"),
  sidebarLayout(
    sidebarPanel(
      pickerInput("artist", "Artist:", 
                  choices = unique(spotify_data_cleaned$track_artist), 
                  options = list(`live-search` = TRUE), 
                  multiple = FALSE),
      selectInput("song", "Song:", choices = NULL),  # Dynamic song suggestions
      actionButton("recommend", "Recommend")
    ),
    mainPanel(
      textOutput("selected_song"),  # Display selected song and artist
      tableOutput("recommendations")
    )
  )
)

# Shiny server function
server <- function(input, output, session) {
  
  observeEvent(input$artist, {
    # Update song suggestions based on artist input
    if (input$artist != "") {
      songs <- spotify_data_cleaned %>%
        filter(track_artist == input$artist) %>%
        pull(track_name)
      
      updateSelectInput(session, "song", choices = unique(songs))
    } else {
      updateSelectInput(session, "song", choices = NULL)
    }
  })
  
  observeEvent(input$recommend, {
    # Validate input
    if (input$artist == "" || input$song == "") {
      showModal(modalDialog(
        title = "Input Error",
        "Please provide both song and artist."
      ))
      return()
    }
    
    # Fuzzy match for artist name
    closest_artist <- spotify_data_cleaned %>%
      mutate(artist_distance = stringdist::stringdist(input$artist, track_artist)) %>%
      arrange(artist_distance) %>%
      slice(1)  # Get the closest artist match
    
    if (nrow(closest_artist) == 0) {
      showModal(modalDialog(
        title = "Artist Not Found",
        "No similar artist names match."
      ))
      return()
    }
    
    # Fuzzy match for song name based on the closest artist found
    closest_song <- spotify_data_cleaned %>%
      filter(track_artist == closest_artist$track_artist) %>%
      mutate(song_distance = stringdist::stringdist(input$song, track_name)) %>%
      arrange(song_distance) %>%
      slice(1)  # Get the closest song match
    
    if (nrow(closest_song) == 0) {
      showModal(modalDialog(
        title = "Song Not Found",
        "The specified artist was found, but no similar song titles match."
      ))
      return()
    }
    
    input_song_features <- closest_song %>%
      select(danceability, energy, valence, tempo, track_popularity, mode, playlist_genre)
    
    # Output the selected song and artist
    output$selected_song <- renderText({
      paste("Selected Song:", closest_song$track_name, "by", closest_song$track_artist)
    })
    
    genre <- input_song_features$playlist_genre
    filtered_data <- spotify_data_cleaned %>%
      filter(playlist_genre == !!genre) %>%
      filter(!is.na(danceability) & !is.na(energy) & !is.na(valence) &
               !is.na(tempo) & !is.na(track_popularity) & !is.na(mode))
    
    # Recommendation Section
    # Calculate Euclidean distance for filtered data
    filtered_data$distance <- sqrt(
      1.0 * (filtered_data$danceability - input_song_features$danceability)^2 +
        1.0 * (filtered_data$energy - input_song_features$energy)^2 +
        1.0 * (filtered_data$valence - input_song_features$valence)^2 +
        0.01 * (filtered_data$tempo - input_song_features$tempo)^2 +
        0.01 * (filtered_data$track_popularity - input_song_features$track_popularity)^2 +
        1.0 * (filtered_data$mode - input_song_features$mode)^2
    )
    
    # Find and display the top 20 most similar tracks
    recommended_tracks <- filtered_data %>%
      arrange(distance) %>%
      select(track_name, track_artist, distance) %>%
      head(20)
    
    output$recommendations <- renderTable({
      recommended_tracks
    })
  })
}

# Run the Shiny app
shinyApp(ui, server)
