# Ship Image Classification

**Author:** Blake Zurman
**Course:** IST 691 - Deep Learning
**Instructor:** Professor Mohammed A. Syed

## Overview

This project applies deep learning to classify ship images into five categories: **Cargo**, **Military**, **Carrier**, **Cruise**, and **Tanker**. It demonstrates key concepts in image classification, CNNs, and transfer learning using TensorFlow and VGG16.

## Dataset

* Sourced from an Analytics Vidhya hackathon on Kaggle.
* Included labeled training images, a test set, and CSV label files.
* Preprocessing involved:

  * Mapping numeric labels to class names.
  * Building full image paths.
  * Performing train/validation/test splits.

## Project Workflow

### 1. Data Preparation

* Organized file paths and labels.
* Resized all images for consistency.
* Split into training and validation sets.

### 2. Exploratory Data Analysis

* Visualized class distributions (imbalanced with cargo dominating).
* Reviewed sample images for quality and variation.

### 3. Preprocessing & Augmentation

* Normalized pixel values.
* Augmented images via shear, zoom, and flip to reduce overfitting.

### 4. Baseline CNN Model

* Built a simple ConvNet with ReLU activations and max pooling.
* Used `softmax` for multi-class classification.
* Trained for 10 epochs using the Adam optimizer.

### 5. Transfer Learning with VGG16

* Used pretrained VGG16 with frozen base layers.
* Added custom dense layers for classification.
* Achieved significantly better accuracy and faster convergence.

## Evaluation

### CNN Results

* Reached \~72% validation accuracy after 10 epochs.
* Improved steadily, with low signs of overfitting.
* Demonstrated the effectiveness of data augmentation.

### VGG16 Results

* Started strong: 77% validation accuracy in epoch 1.
* Peaked at \~87% test accuracy with \~0.40 validation loss.
* Clearly outperformed the baseline CNN in both performance and stability.

### Overfitting Management

* Used validation set monitoring.
* Applied augmentation and avoided class balancing to test model robustness.

## Key Takeaways

* Transfer learning drastically improved performance.
* Augmentation and validation tracking helped prevent overfitting.
* Model learned to generalize well even with class imbalance.

## Future Improvements

* Try models like ResNet or EfficientNet.
* Fix the training pipeline to avoid early stopping issues.
* Add dropout/regularization.
* Experiment with hyperparameter tuning.
* Explore model explainability.

## Concepts Practiced

* CNN architecture and training
* Transfer learning
* Backpropagation and optimization (Adam)
* Data augmentation
* Performance evaluation and validation

## What I Learned

* How to prepare image data using TensorFlow and pandas.
* How to build and evaluate CNNs.
* The power of transfer learning in small datasets.
* The impact of augmentation and architecture choices.

## What's Next

* Expand to other architectures.
* Tackle class imbalance more directly.
* Fine-tune VGG16 layers.
* Incorporate Grad-CAM or saliency maps for interpretability.
