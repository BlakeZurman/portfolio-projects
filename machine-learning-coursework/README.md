# Machine Learning Coursework

Graduate machine learning assignments from my MS in Applied Data Science at
Syracuse University. Each folder holds the notebook, the assignment brief (PDF),
and the datasets it operates on.

> Original note: *"These folders contain notebooks with code related to their
> respective titles. The notebooks show my skills and passion for Machine
> Learning in Data Science."*

## Contents

### `imputation/` — Missing-data imputation & evaluation
Handling missing values, then measuring the downstream cost of each strategy.
Z-score outlier screening, label encoding, and standard scaling feed a logistic
regression evaluated by confusion matrix and classification report.
Files: `ZURMAN_HW2.ipynb`, brief, training/test data, `answers.csv`.

### `classification/` — Classification challenge
A model bake-off: logistic regression, SGD, k-nearest neighbours, SVC, and
random forest, with recursive feature elimination (RFE) for feature selection
and cross-validated F1 as the comparison metric.
Files: `ZURMAN_homework_3.ipynb`, brief, train/test data, `test_predictions.csv`.

### `clustering/` — Unsupervised clustering on 20 Newsgroups
TF-IDF vectors joined to GloVe embeddings, reduced with PCA, then clustered with
K-Means and hierarchical agglomerative clustering (HAC); UMAP/t-SNE for
visualization and silhouette score for cluster quality.
Files: `ZURMAN_HW4-Clustering.ipynb`, brief.

## Stack

Python · scikit-learn · hdbscan · pandas · numpy · seaborn · matplotlib · scipy
