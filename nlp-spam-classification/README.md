# Spam Email Detection Using NLP

**Author:** Blake Zurman
**Course:** IST 664 - Natural Language Processing
**Instructor:** Preeti Mahaveer Jagadev
**Date:** June 10, 2025

## Overview

This project focuses on classifying emails as spam or ham using Natural Language Processing (NLP) techniques. The dataset is derived from the Enron email collection. The project compares performance between two Naive Bayes classifiers — one from NLTK and another from scikit-learn — using both unigram and combined feature sets.

## Table of Contents

1. [Introduction](#introduction)
2. [Methodology](#methodology)

   * [Dataset](#dataset)
   * [Loading and Preprocessing](#loading-and-preprocessing)
   * [Feature Extraction](#feature-extraction)
   * [Classifiers](#classifiers)
3. [Experiments and Results](#experiments-and-results)
4. [Discussion](#discussion)
5. [Conclusion](#conclusion)
6. [Future Work](#future-work)

## Introduction

Spam detection remains an important application of NLP. This project aims to evaluate how different features and tools impact spam classification performance.

## Methodology

### Dataset

* Based on the Enron public email dataset.
* Used 100 spam and 100 ham emails (balanced for training speed).

### Loading and Preprocessing

* Tokenized text using NLTK.
* Removed punctuation, lowercased text, and created two versions (with and without stopwords).

### Feature Extraction

1. **Unigrams** – Presence of top individual words.
2. **Combined** – Unigrams + bigrams + number of exclamation points.

### Classifiers

* **NLTK Naive Bayes**: Evaluated with 5-fold cross-validation.
* **Scikit-learn MultinomialNB**: 80/20 train-test split using `DictVectorizer`.

## Experiments and Results

### Metrics Used

* **Precision**
* **Recall**
* **F1 Score**
* **Accuracy**
* **Confusion Matrix**

### NLTK Unigram Results (5-fold CV)

* Precision: 0.9290
* Recall: 0.6252
* F1 Score: 0.7456

### NLTK Combined Features (5-fold CV)

* Precision: 0.9183
* Recall: 0.5341
* F1 Score: 0.6714

### Scikit-learn Combined Features (Train-Test)

* Accuracy: 0.9500
* Precision: 1.0000
* Recall: 0.9048
* F1 Score: 0.9500

**Summary:** The scikit-learn classifier outperformed the NLTK version across all metrics.

## Discussion

Unigram features were more effective than combined features when using NLTK. However, the scikit-learn model with combined features yielded the best results. Its ability to handle sparse data and efficient implementation likely contributed to its performance.

## Conclusion

The project demonstrated the importance of feature selection and tool choice in spam detection. Scikit-learn’s Naive Bayes classifier with combined features was the most effective, showing strong performance across all evaluation metrics.

## Future Work

* Use the full Enron dataset.
* Explore TF-IDF and word embeddings.
* Experiment with other classifiers (e.g., logistic regression, neural nets).
* Perform hyperparameter tuning.
* Apply advanced text preprocessing.
