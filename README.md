# Analysis-of-Factors-Affecting-Vehicle-Selling-Price

## Overview
This R script performs analysis and prediction on a dataset containing details about cars and their attributes. The goal is to build a predictive model for car prices using multiple linear regression.

## Dataset
 The Dataset contains the following columns:

- **Price**: Selling price of the car (dependent variable).
- **Kilometer**: Distance traveled by the car.
- **Year**: Year of manufacturing.
- **Engine_numeric**: Engine capacity in numeric format.
- **Max_Power_numeric**: Maximum power of the car's engine in numeric format.
- **Fuel.Type**: Type of fuel used by the car.
- **Transmission**: Transmission type of the car.
- **Owner**: Number of previous owners.
- **Seller.Type**: Type of seller.
- **Seating.Capacity**: Seating capacity of the car.

## Workflow
1. **Data Preparation and Exploration**:
   - Loading the dataset and exploring its structure.
   - Visualizing data distributions and relationships.

2. **Data Preprocessing**:
   - Handling missing values.
   - Encoding categorical variables.
   - Removing duplicate rows.
   - Handling outliers using Winsorization.

3. **Model Building**:
   - Splitting the data into training and testing sets.
   - Building multiple linear regression models with different combinations of predictor variables.

4. **Model Evaluation**:
   - Assessing the assumptions of linear regression models.
   - Evaluating model performance using metrics such as MAE, RMSE, and R-squared.

5. **Additional Analysis**:
   - Calculating Pearson correlation coefficients between numeric variables.
   - Visualizing correlations using a correlation plot.
   - Making predictions on the test dataset and comparing them with actual prices.

## Files
- **car_price_prediction_script.R**: The main R script containing all the code for data analysis, preprocessing, modeling, and evaluation.
- **car_details_v4.csv**: The dataset used for analysis.
- ** Report**: FInal report of the project.

## Usage
1. Ensure you have R and the required libraries installed (listed in the script).
2. Download the dataset file `car_details_v4.csv` and place it in the appropriate directory.
3. Run the R script `car_price_prediction_script.R` in an R environment or RStudio.

## Dependencies
- R (version X.X.X)
- Required R libraries: ggplot2, dplyr, DescTools, caret, lmtest

## Author
Ganesh Vannam

