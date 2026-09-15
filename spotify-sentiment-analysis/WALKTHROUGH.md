### README: Song Sentiment Analysis and Musical Analysis  

#### Project Overview  
This project combines Spotify CSV datasets and the Genius API to analyze song sentiment and musical elements. By exploring song lyrics and their musical properties, the analysis provides rankings of artists' songs by popularity and evaluates sentiment and word clouds for deeper insights.  

#### Key Components  

1. **Loading the CSV Data**  
   - Two CSV files (`30000_spotify_songs.csv` and `spotify_data_2017_2021.csv`) are loaded into pandas DataFrames for analysis.  

   ```python
   import pandas as pd
   song_analytics_df = pd.read_csv('30000_spotify_songs.csv')
   spotify_df = pd.read_csv('spotify_data_2017_2021.csv')
   ```

2. **Artist-Specific Rankings**  
   - Artist data is filtered to create rankings by average popularity (rank), with lower ranks indicating higher popularity. Examples include Coldplay, Post Malone, and Drake.  

   Example (Coldplay):  
   ```python
   coldplay_df = spotify_df[spotify_df['Artist'] == 'Coldplay']
   coldplay_avg_rank = coldplay_df.groupby('Track').agg({'Rank': 'mean'}).reset_index()
   coldplay_top_songs = coldplay_avg_rank.sort_values(by='Rank', ascending=True)
   print(coldplay_top_songs)
   ```

3. **Lyrics Data and Sentiment Analysis**  
   - Using the Genius API, song lyrics are fetched and analyzed for sentiment using VADER (Valence Aware Dictionary and sEntiment Reasoner).  
   - Sentiments are classified as positive, negative, or neutral based on compound scores.  

   Example function:  
   ```python
   from nltk.sentiment.vader import SentimentIntensityAnalyzer
   
   def analyze_sentiment_vader(df):
       sid = SentimentIntensityAnalyzer()
       sentiment_score = sid.polarity_scores(df['lyrics'].values[0])
       sentiment = sentiment_score['compound']
       if sentiment > 0:
           return f"Positive sentiment with a score of {sentiment:.2f}"
       elif sentiment < 0:
           return f"Negative sentiment with a score of {sentiment:.2f}"
       else:
           return f"Neutral sentiment with a score of {sentiment:.2f}"
   ```

4. **Word Cloud Visualization**  
   - A word cloud is generated from the lyrics to visualize common themes in a song’s lyrics.  

   Example function:  
   ```python
   from wordcloud import WordCloud
   import matplotlib.pyplot as plt
   
   def create_word_cloud(df):
       wordcloud = WordCloud(width=800, height=400).generate(df['lyrics'].values[0])
       plt.imshow(wordcloud, interpolation='bilinear')
       plt.axis('off')
       plt.show()
   ```

5. **Retrieving Music Elements**  
   - Extracts musical features (e.g., danceability, tempo) for a given song from the CSV datasets.  

   Example function:  
   ```python
   def retrieve_music_elements(song_name, song_analytics_df):
       song_data = song_analytics_df[song_analytics_df['track_name'] == song_name]
       if song_data.empty:
           return f"Song '{song_name}' not found in the dataset."
       columns_of_interest = [
           'danceability', 'energy', 'tempo', 'valence', 'liveness'
       ]
       return song_data[columns_of_interest].iloc[0]
   ```

6. **Comprehensive Song Analysis**  
   - Combines data retrieval, sentiment analysis, and word cloud visualization for a detailed look at any song.  

   Example workflow:  
   ```python
   def get_song_details(song_title, artist_name):
       # Fetch song data from Genius API
       song_df = get_song_data(song_title, artist_name)
       # Analyze sentiment
       sentiment_result = analyze_sentiment_vader(song_df)
       # Create word cloud
       create_word_cloud(song_df)
       # Retrieve music elements
       music_elements = retrieve_music_elements(song_title, song_analytics_df)
       return sentiment_result, music_elements
   ```

#### Dependencies  
- Python libraries: `pandas`, `nltk`, `matplotlib`, `wordcloud`, `lyricsgenius`.  
- CSV datasets: `30000_spotify_songs.csv`, `spotify_data_2017_2021.csv`.  

#### Data Sources  
- Spotify: CSV datasets containing musical features and rankings.  
- Genius API: For fetching song lyrics.  

#### How to Use  
1. Install required Python libraries using `pip install pandas nltk matplotlib wordcloud lyricsgenius`.  
2. Add your Genius API token to the code.  
3. Load the CSV files into pandas DataFrames.  
4. Run the functions for analysis on your favorite songs or artists.  

#### Example Usage  
```python
# Example: Analyze a Coldplay song
get_song_details("Yellow", "Coldplay")
```
