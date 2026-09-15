library(tidyverse)
library(e1071)
library(caret)
library(dplyr)
library(ggplot2)

spotify_data <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-01-21/spotify_songs.csv')

summary(spotify_data)

# Cleaning the set
# Removing the ID rows. These rows are useful for a database, but not an analysis.

spotify_data$track_id <- NULL
spotify_data$track_album_id <- NULL
spotify_data$playlist_id <- NULL

# cleaning duplicates

# Remove duplicate songs based on the combination of track_name and track_artist
spotify_data_cleaned <- spotify_data %>%
  distinct(track_name, track_artist, .keep_all = TRUE)

# Inspect the cleaned data
head(spotify_data_cleaned)

# Check the number of rows before and after removing duplicates
nrow(spotify_data)  # Before
nrow(spotify_data_cleaned)  # After

# Convert release date to a date format and extract the year in a new column
spotify_data_cleaned <- spotify_data_cleaned %>%
  mutate(release_year = as.numeric(format(as.Date(track_album_release_date, "%Y-%m-%d"), "%Y")))



################################################################################################

# ANALYSIS SECTION 2000's

# Top genres by year from 2000s
years_2000s <- seq(2000, 2010)

# Initialize an empty data frame to store the combined results
top_genres_combined_2000s <- data.frame()

# Loop over each year and combine the results
for (year in years_2000s) {
  top_genres_year_2000s <- spotify_data_cleaned %>%
    filter(release_year == year) %>%
    group_by(playlist_genre) %>%
    summarize(count = n()) %>%
    arrange(desc(count))
  
  # Add the year as a column
  top_genres_year_2000s$year <- year
  
  # Combine with the main data frame
  top_genres_combined_2000s <- rbind(top_genres_combined_2000s, top_genres_year_2000s)
}

# Bar plot of the top genres for each year

ggplot(top_genres_combined_2000s, aes(x = reorder(playlist_genre, count), y = count)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(title = "Top Genres by Year", x = "Genre", y = "Count") +
  theme_minimal() +
  facet_wrap(~ year, scales = "free_y") +
  scale_fill_brewer(palette = "Set3")



# Top artist per year

# Initialize an empty data frame to store the combined results
top_artists_combined_2000s <- data.frame()

# Loop over each year and find the top 5 artists
for (year in years_2000s) {
  top_artists_year_2000s <- spotify_data_cleaned %>%
    filter(release_year == year) %>%
    group_by(track_artist) %>%
    summarize(count = n()) %>%
    arrange(desc(count), track_artist) %>%
    slice(1:5)
  
  # Add the year as a column
  top_artists_year_2000s$year <- year
  
  # Combine with the main data frame
  top_artists_combined_2000s <- rbind(top_artists_combined_2000s, top_artists_year_2000s)
}


# Top songs per year

# Initialize an empty data frame to store the combined results
top_songs_combined_2000s <- data.frame()

# Loop over each year and find the top 5 most popular songs
for (year in years_2000s) {
  top_songs_year_2000s <- spotify_data_cleaned %>%
    filter(release_year == year) %>%
    arrange(desc(track_popularity)) %>%  # Sort by popularity in descending order
    slice(1:5)  # Select the top 5 songs
  
  # Add the year as a column
  top_songs_year_2000s$year <- year
  
  # Combine with the main data frame
  top_songs_combined_2000s <- rbind(top_songs_combined_2000s, top_songs_year_2000s)
}



# Cluster 2000s
spotify_features <- spotify_data_cleaned %>%
  filter(release_year %in% years_2000s) %>%
  select(track_popularity, danceability, energy, tempo, acousticness, instrumentalness, loudness)

# K-Means clustering
set.seed(123)
kmeans_result <- kmeans(spotify_features, centers = 5, nstart = 25)
spotify_data_cleaned$cluster <- NA
spotify_data_cleaned$cluster[spotify_data_cleaned$release_year %in% years_2000s] <- as.factor(kmeans_result$cluster)

# Plot 
ggplot(spotify_data_cleaned %>% filter(release_year %in% years_2000s), aes(x = track_popularity, y = tempo, color = cluster)) +
  geom_point() +
  theme_minimal() +
  labs(title = "K-Means Clustering of Songs (Years: 2000-2010)")

# evaluate clusters

library(cluster)
silhouette_score <- silhouette(kmeans_result$cluster, dist(spotify_features))
mean(silhouette_score[, 3])  # The average silhouette score




##############################################################################################

# ANALYSIS SECTION 2010's

# Top genres by year from 2010s
years_2010s <- seq(2010, 2020)

# Initialize an empty data frame to store the combined results
top_genres_combined_2010s <- data.frame()

# Loop over each year and combine the results
for (year in years_2010s) {
  top_genres_year_2010s <- spotify_data_cleaned %>%
    filter(release_year == year) %>%
    group_by(playlist_genre) %>%
    summarize(count = n()) %>%
    arrange(desc(count))
  
  # Add the year as a column
  top_genres_year_2010s$year <- year
  
  # Combine with the main data frame
  top_genres_combined_2010s <- rbind(top_genres_combined_2010s, top_genres_year_2010s)
}

# Bar plot of the top genres for each year

ggplot(top_genres_combined_2010s, aes(x = reorder(playlist_genre, count), y = count)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(title = "Top Genres by Year", x = "Genre", y = "Count") +
  theme_minimal() +
  facet_wrap(~ year, scales = "free_y") +
  scale_fill_brewer(palette = "Set3")



# Top artist per year

# Initialize an empty data frame to store the combined results
top_artists_combined_2010s <- data.frame()

# Loop over each year and find the top 5 artists
for (year in years_2010s) {
  top_artists_year_2010s <- spotify_data_cleaned %>%
    filter(release_year == year) %>%
    group_by(track_artist) %>%
    summarize(count = n()) %>%
    arrange(desc(count), track_artist) %>%
    slice(1:5)
  
  # Add the year as a column
  top_artists_year_2010s$year <- year
  
  # Combine with the main data frame
  top_artists_combined_2010s <- rbind(top_artists_combined_2010s, top_artists_year_2010s)
}


# Top songs per year

# Initialize an empty data frame to store the combined results
top_songs_combined_2010s <- data.frame()

# Loop over each year and find the top 5 most popular songs
for (year in years_2010s) {
  top_songs_year_2010s <- spotify_data_cleaned %>%
    filter(release_year == year) %>%
    arrange(desc(track_popularity)) %>%  # Sort by popularity in descending order
    slice(1:5)  # Select the top 5 songs
  
  # Add the year as a column
  top_songs_year_2010s$year <- year
  
  # Combine with the main data frame
  top_songs_combined_2010s <- rbind(top_songs_combined_2010s, top_songs_year_2010s)
}

##############################################################################################

# Cluster 2010s
spotify_features <- spotify_data_cleaned %>%
  filter(release_year %in% years_2010s) %>%
  select(track_popularity, danceability, energy, tempo, acousticness, instrumentalness, loudness)

# K-Means clustering
set.seed(123)
kmeans_result <- kmeans(spotify_features, centers = 5, nstart = 25)
spotify_data_cleaned$cluster <- NA
spotify_data_cleaned$cluster[spotify_data_cleaned$release_year %in% years_2010s] <- as.factor(kmeans_result$cluster)

# Plot 
ggplot(spotify_data_cleaned %>% filter(release_year %in% years_2010s), aes(x = track_popularity, y = tempo, color = cluster)) +
  geom_point() +
  theme_minimal() +
  labs(title = "K-Means Clustering of Songs (Years: 2010-2020)")

# evaluate clusters

library(cluster)
silhouette_score <- silhouette(kmeans_result$cluster, dist(spotify_features))
mean(silhouette_score[, 3])  # The average silhouette score


##############################################################################################


# SVM

# Load and clean the dataset
spotify_data <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-01-21/spotify_songs.csv')

spotify_data_cleaned <- spotify_data %>%
  select(track_popularity, danceability, energy, tempo, acousticness, instrumentalness, loudness, key, mode, playlist_genre) %>%
  filter(!is.na(playlist_genre)) %>%
  mutate(playlist_genre = as.factor(playlist_genre))  # Ensure the target is a factor for classification

# Split data into training and testing sets
set.seed(123)
train_index <- createDataPartition(spotify_data_cleaned$playlist_genre, p = 0.8, list = FALSE)
train_data <- spotify_data_cleaned[train_index, ]
test_data <- spotify_data_cleaned[-train_index, ]

# Train the SVM model with radial kernel for classification
svm_model <- svm(playlist_genre ~ ., data = train_data, type = "C-classification", kernel = "radial", cost = 1, gamma = 0.5)

# Make predictions on the test set
predictions <- predict(svm_model, newdata = test_data)

# Evaluate the model performance
confusion_matrix <- confusionMatrix(predictions, test_data$playlist_genre)
print(confusion_matrix)
cat("Accuracy: ", confusion_matrix$overall['Accuracy'], "\n")


