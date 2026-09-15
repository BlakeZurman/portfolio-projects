# Spotify Database with MongoDB and HIVE

## Project Overview
This project demonstrates how to efficiently handle and analyze Spotify playlist data using distributed databases. By integrating technologies such as **MongoDB**, **PySpark**, and **Hive**, we transformed raw Spotify API data into a structured format while enriching it with additional insights (e.g., song popularity). The goal was to showcase the use of distributed database technologies to handle real-world data challenges.

## Features
- **MongoDB** for storing and querying unstructured JSON data.
- **PySpark** for data transformation and manipulation.
- **Hive** for storing tabular data and performing SQL-like queries.
- Integration with the **Spotify API** to fetch playlist data.

---

## Setup

### 1. Configuring MongoDB
We used MongoDB to store unstructured JSON data fetched from the Spotify API.

#### MongoDB Configuration:
```python
mongo_uri = "mongodb://<username>:<password>@mongo:27017/demo.feedback?authSource=admin"
spark = SparkSession \
    .builder \
    .master("local") \
    .appName('jupyter-pyspark') \
    .config("spark.mongodb.input.uri", mongo_uri) \
    .config("spark.mongodb.output.uri", mongo_uri) \
    .config("spark.jars.packages", "org.mongodb.spark:mongo-spark-connector_2.12:3.0.1") \
    .getOrCreate()
```

---

### 2. Fetching Data from the Spotify API
We pulled playlist data in JSON format using the Spotify API and transformed it into a list of dictionaries for processing.

#### Code Example:
```python
import spotipy
from spotipy.oauth2 import SpotifyClientCredentials

# Spotify credentials
client_id = "your_client_id"
client_secret = "your_client_secret"

sp = spotipy.Spotify(client_credentials_manager=SpotifyClientCredentials(
    client_id=client_id,
    client_secret=client_secret
))

# Fetch playlist data
playlist_id = "your_playlist_id"
playlist = sp.playlist(playlist_id)

# Process data
tracks = []
for item in playlist['tracks']['items']:
    track = item['track']
    tracks.append({
        "track_name": track['name'],
        "artist": track['artists'][0]['name'],
        "album": track['album']['name'],
        "release_date": track['album']['release_date'],
        "popularity": track['popularity']
    })
```

---

### 3. Data Transformation in PySpark
The Spotify playlist data was transformed using **PySpark** for ingestion into MongoDB and Hive.

#### Key Steps:
1. Convert the playlist data into a PySpark DataFrame.
2. Add a new column `is_popular`, indicating whether the track's popularity exceeds 75.
3. Filter tracks released on or after January 1, 2020.

#### Code Example:
```python
from pyspark.sql.functions import col, when

# Create PySpark DataFrame
playlist_df = spark.createDataFrame(tracks)

# Add a popularity indicator
playlist_df = playlist_df.withColumn(
    'is_popular', when(playlist_df.popularity > 75, 'Yes').otherwise('No')
)

# Filter recent tracks
playlist_df = playlist_df.filter(col('release_date') >= '2020-01-01')

# Save to MongoDB
playlist_df.write \
    .format("mongo") \
    .mode("overwrite") \
    .save()
```

---

### 4. Using Hive for Tabular Storage
The transformed playlist data was stored in Hive for SQL-like analysis.

#### Key Steps:
1. Create a Hive database (`music`) and set it as the current context.
2. Write the PySpark DataFrame to a Hive table.
3. Perform SQL queries on the Hive table.

#### Code Example:
```python
# Enable Hive support
spark = SparkSession \
    .builder \
    .master("local") \
    .appName('jupyter-pyspark') \
    .config("hive.metastore.uris", "thrift://hive-metastore:9083") \
    .enableHiveSupport() \
    .getOrCreate()

# Create database and table
spark.sql("CREATE DATABASE IF NOT EXISTS music")
spark.sql("USE music")
spark.sql("DROP TABLE IF EXISTS music.spotify_tracks")

# Save DataFrame to Hive
df.write.mode("overwrite").saveAsTable("music.spotify_tracks")

# Query the Hive table
spark.sql("SELECT * FROM music.spotify_tracks").show()
```

---

## Results
### MongoDB
Stored unstructured JSON data from the Spotify API and processed it into a tabular format using PySpark.

#### Example Data from MongoDB:
| Album       | Artist    | Popularity | Is Popular | Release Date |
|-------------|-----------|------------|------------|--------------|
| Dreamland   | Ferdous   | 40         | No         | 2024-02-16   |
| 4:22        | MIKE DEAN | 27         | No         | 2021-04-23   |

---

### Hive
After transforming the data, we stored it in Hive for SQL analysis.

#### Example Data from Hive:
| Album                 | Artist      | Is Popular | Popularity | Release Date |
|-----------------------|-------------|------------|------------|--------------|
| Random Access Memories| Daft Punk  | No         | 46         | 2023-05-12   |
| The Last Dance, Pt 2  | Emmit Fenn | No         | 69         | 2022-03-24   |

---

## Technologies Used
- **MongoDB**: For storing JSON data.
- **PySpark**: For data manipulation and transformation.
- **Hive**: For SQL-based queries on transformed data.
- **Spotipy**: To fetch playlist data via the Spotify API.

---

## Conclusion
This project showcases a complete data pipeline—from fetching unstructured data to transforming it into tabular form and enabling SQL-like queries. The combination of MongoDB, PySpark, and Hive demonstrates how distributed databases can efficiently handle large-scale data and enable meaningful analysis.
