# Portfolio Projects

A consolidated archive of selected **older data science and academic projects**,
collected from my MS in Applied Data Science at **Syracuse University** and my BS
in Applied Computational Mathematics at **Florida State University**.

Each project lives in its own folder with its original documentation preserved.

> **This repository is an archive, not active work.** It exists so that earlier
> coursework and student projects stay browsable in one place. Newer and ongoing
> projects each live in their own dedicated repository.

---

## Projects

### 🚢 [Deep Learning — Ship Image Classification](./deep-learning-ship-classification/)
A convolutional neural network that classifies a photograph of a ship as a Cargo
ship, Military ship, Carrier, Cruise ship, or Tanker — an image-classification
take on a real-world analytics problem.
**Python · TensorFlow/Keras · Jupyter**

### 📧 [NLP — Email Spam Classification](./nlp-spam-classification/)
Spam-versus-ham email classification over a labelled corpus of ~5,200 messages,
with NLTK tokenization and feature engineering. Includes the full project data
and the final presentation.
**Python · NLTK · scikit-learn · Jupyter**

### 📝 [Text Mining](./text-mining/)
Three IST 736 assignments: public sentiment toward AI (VADER vs. TextBlob),
a bag-of-words versus TF-IDF vectorization comparison, and classifying deceptive
versus truthful hotel reviews.
**Python · NLTK · scikit-learn · TextBlob**

### 🤖 [Machine Learning Coursework](./machine-learning-coursework/)
Graduate ML assignments in three parts: missing-data **imputation** and its
downstream cost, a **classification** model bake-off with recursive feature
elimination, and unsupervised **clustering** of the 20 Newsgroups corpus using
TF-IDF plus GloVe embeddings.
**Python · scikit-learn · hdbscan · pandas**

### 🎵 [Spotify — Song Recommendation (R)](./spotify-song-recommendation/)
A recommendation study in R applying support vector machines, Euclidean distance,
and K-means clustering to Spotify audio features, covering the full pipeline from
cleaning through visualization.
**R · SVM · K-Means**

### 🎧 [Spotify — Sentiment Analysis](./spotify-sentiment-analysis/)
Combines Spotify audio-feature datasets with lyrics from the Genius API to rank
artists' songs by popularity and score lyrical sentiment with VADER, including
word-cloud analysis.
**Python · lyricsgenius · NLTK/VADER · wordcloud · pandas**

### 🗄️ [Spotify — Distributed Database](./spotify-distributed-database/)
A distributed-data pipeline that lands raw Spotify API JSON in **MongoDB**,
transforms it with **PySpark**, and exposes it as queryable tables in **Hive**.
Documentation-led write-up with embedded code walkthroughs.
**MongoDB · PySpark · Hive · Spotipy**

### 🏠 [Realtor SQL Database](./realtor-sql-database/)
A complete relational database design for a real-estate agency: conceptual and
logical ER models, schema DDL, stored procedures, performance indexes, and
sample data — with step-by-step run instructions.
**T-SQL · draw.io**

### 📈 [SPY Predictive Model](./spy-predictive-model/)
An FSU group project predicting the S&P 500's next-day closing price from a
rolling window of SPY price/volume plus VIX data, using PCA-derived features fed
into LSTM and feed-forward neural networks.
**Python · Keras · scikit-learn**

### 🎲 [Game Theory Simulations](./game-theory-simulations/)
Two small simulations of strategic bidding: Nash-equilibrium checking in an
ascending-bid auction, and risk-weighted aggressive-versus-conservative bidding
for a car.
**Python · numpy · matplotlib**

---

## Repository conventions

- One folder per project, named for what the project does.
- Each folder keeps its **original README** and documentation.
- No credentials are committed. Where a project needs an API key, it reads it
  from an environment variable.
- Datasets that these projects depend on are committed intentionally so the
  notebooks remain reproducible; `.gitignore` covers caches, virtual
  environments, and OS/editor clutter.

## About

**Blake Zurman** — Data Scientist, Pinellas County Property Appraiser's Office.
MS Applied Data Science, Syracuse University (2025).
BS Applied Computational Mathematics, Florida State University (2024).

More at [github.com/BlakeZurman](https://github.com/BlakeZurman).
