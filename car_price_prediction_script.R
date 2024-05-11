car_data <- read.csv("C:/Users/GaneshVannam/Downloads/new car details v4.csv")


# View the structure of the data set
str(car_data)

# View the first few rows of the data set
head(car_data)

# Summary statistics of the data set
summary(car_data)


#Box plot denoting the variation in selling price according to the fuel type of the cars
# Load necessary library
library(ggplot2)

ggplot(car_data, aes(x = Fuel.Type, y = Price, fill = Fuel.Type)) +
  geom_boxplot() +
  labs(title = "Variation in Selling Price by Fuel Type",
       x = "Fuel Type",
       y = "Selling Price") +
  theme_minimal() +
  theme(legend.position = "none")



# a boxplot for distribution of selling price considering owner as a factor
ggplot(car_data, aes(x = Owner, y = Price, fill = Owner)) +
  geom_boxplot() +
  labs(title = "Distribution of Cars by Owner and Selling Price",
       x = "Owner",
       y = "Selling Price") +
  theme_minimal()


# Calculate the age of each car
car_data$Age <- 2024 - car_data$Year

# Create a histogram for the distribution of car age
ggplot(car_data, aes(x = Age)) +
  geom_histogram(binwidth = 1, fill = "skyblue", color = "black") +
  labs(title = "Distribution of Cars by Age",
       x = "Age of Car",
       y = "Frequency") +
  theme_minimal()



# Create a bar plot for distribution of owner vs fuel type
ggplot(car_data, aes(x = Fuel.Type, fill = Owner)) +
  geom_bar(position = "stack") +
  labs(title = "Distribution of Owner vs Fuel Type",
       x = "Fuel Type",
       y = "Count",
       fill = "Owner") +
  theme_minimal()


# Load necessary libraries
library(dplyr)

missing_values <- sapply(car_data, function(x) sum(is.na(x)))
print(missing_values)

# Impute missing values (if necessary)
# For example, you can replace missing values with the median for numerical variables
car_data$Price[is.na(car_data$Price)] <- median(car_data$Price, na.rm = TRUE)
car_data$Kilometer[is.na(car_data$Kilometer)] <- median(car_data$Kilometer, na.rm = TRUE)
car_data$Year[is.na(car_data$Year)] <- median(car_data$Year, na.rm = TRUE)
car_data$Engine_numeric[is.na(car_data$Engine_numeric)] <- median(car_data$Engine_numeric, na.rm = TRUE)
car_data$Max_Power_numeric[is.na(car_data$Max_Power_numeric)] <- median(car_data$Max_Power_numeric, na.rm = TRUE)

# For categorical variables, replace missing values with the most common category
car_data$Fuel.Type[is.na(car_data$Fuel.Type)] <- mode(car_data$Fuel.Type)
car_data$Transmission[is.na(car_data$Transmission)] <- mode(car_data$Transmission)

# Step 3: Check if missing values have been handled
missing_values_after <- sapply(car_data, function(x) sum(is.na(x)))
print(missing_values_after)

# Define encoding function
encode_categorical <- function(data, var) {
  levels <- unique(data[[var]])
  encoding <- seq_along(levels)
  names(encoding) <- levels
  data[[var]] <- encoding[data[[var]]]
  return(data)
}


# Specify the categorical variables to be encoded
categorical_vars <- c("Fuel.Type", "Transmission", "Owner", "Seller.Type")

# Convert categorical variables to numerical format
for (var in categorical_vars) {
  car_data[[var]] <- as.numeric(as.factor(car_data[[var]]))
}


# Display the first 30 rows of the data set
head(car_data, 30)


# Step 1: Identify duplicate rows
duplicate_rows <- car_data[duplicated(car_data), ]
print("Duplicate Rows:")
print(duplicate_rows)

# Step 2: Remove duplicate rows
cleaned_car_data <- unique(car_data)

# Step 3: Check if duplicate rows have been removed
if (nrow(cleaned_car_data) == nrow(car_data)) {
  print("No duplicate rows found. Dataset is now cleaned.")
} else {
  print("Duplicate rows have been removed. Dataset is now cleaned.")
}


# Set up a multi-panel plot
par(mfrow=c(3, 2))

# Boxplot for Price
boxplot(car_data$Price, main="Price")

# Boxplot for Kilometer
boxplot(car_data$Kilometer, main="Kilometer")

# Boxplot for Year
boxplot(car_data$Year, main="Year")


# Extracting the numeric part from Engine using regex
car_data$Engine_numeric <- as.numeric(gsub("[^0-9.]", "", car_data$Engine))
boxplot(car_data$Engine_numeric, main="Engine")

# Extracting the numeric part from Max Power using regex
car_data$Max_Power_numeric <- as.numeric(gsub("[^0-9.]", "", car_data$Max.Power))
boxplot(car_data$Max_Power_numeric, main="Max Power")


# Load necessary library
library(DescTools)

# Apply Winsorization to Price variable
car_data$Price <- Winsorize(car_data$Price, probs = c(0.1, 0.9))

# Apply Winsorization to Kilometer variable
car_data$Kilometer <- Winsorize(car_data$Kilometer, probs = c(0.05, 0.95))

# Apply Winsorization to Year variable
car_data$Year <- Winsorize(car_data$Year, probs = c(0.05, 0.95))

car_data <- car_data[!is.na(car_data$Engine_numeric), ]
car_data$Engine_numeric <- Winsorize(car_data$Engine_numeric, probs = c(0.05, 0.95))


# Apply Winsorization to Max Power variable (using the previously extracted numeric version)
car_data$Max_Power_numeric <- Winsorize(car_data$Max_Power_numeric, probs = c(0.05, 0.95))



# Re-create boxplots to visualize the effect of Winsorization
par(mfrow=c(3, 2))

# Boxplot for Price after Winsorization
boxplot(car_data$Price, main="Price (Winsorized)")

# Boxplot for Kilometer after Winsorization
boxplot(car_data$Kilometer, main="Kilometer (Winsorized)")

# Boxplot for Year after Winsorization
boxplot(car_data$Year, main="Year (Winsorized)")

# Boxplot for Engine after Winsorization
boxplot(car_data$Engine_numeric, main="Engine (Winsorized)")

# Boxplot for Max Power after Winsorization
boxplot(car_data$Max_Power_numeric, main="Max Power (Winsorized)")



# Load necessary library
library(ggplot2)  

# Select the variables for linearity check
vars <- c("Kilometer", "Year", "Engine_numeric", "Max_Power_numeric", "Fuel.Type", "Transmission", "Owner", "Seller.Type", "Seating.Capacity")

# Create scatterplots for linearity check
scatterplots <- lapply(vars, function(var) {
  ggplot(car_data, aes_string(x = var, y = "Price")) +
    geom_point() +
    geom_smooth(method = "lm", se = FALSE) +
    labs(x = var, y = "Price")
})

# Print scatter plots
print(scatterplots)



#train and test data set 

# Load necessary library
library(caret)

# Set seed for reproducibility
set.seed(123)

# Define the proportion of data to be used for training (e.g., 80%)
train_proportion <- 0.8

# Create the training and testing sets
train_index <- createDataPartition(car_data$Price, p = train_proportion, list = FALSE)
train_data <- car_data[train_index, ]
test_data <- car_data[-train_index, ]

# Check the dimensions of the training and testing sets
dim(train_data)
dim(test_data)



# 1st time with all variables 

# Fit the multiple linear regression model with adjusted variable names
multiple_lm <- lm(Price ~ Kilometer + Year + Engine_numeric + Max_Power_numeric + Fuel.Type + Transmission + Owner + Seller.Type + Seating.Capacity, data = car_data)

# Summarize the model
summary(multiple_lm)


#2nd time

# Fit a multiple linear regression model with selected variables
model <- lm(Price ~ Year + Max_Power_numeric + Kilometer, data = car_data)

# Summary of the model
summary(model)

#3rd time

# Fit a multiple linear regression model with selected variables
model <- lm(Price ~ Year + Max_Power_numeric + Kilometer + Fuel.Type + Transmission , data = car_data)

# Summary of the model
summary(model)



# Assessing the assumptions of Linear regression
# Assuming you have a model called 'model'
# Plot residuals vs fitted values
plot(model$fitted.values, resid(model),
     xlab = "Fitted Values",
     ylab = "Residuals",
     main = "Residuals vs Fitted")
abline(h = 0, col = "red")


# Create partial regression plots for the model
avPlots(model)


library(lmtest)

# Assuming your model is named 'model'
# Perform the Durbin-Watson test
dw_test <- dwtest(model)

# Print the results
print(dw_test)


vif_values <- vif(model)
print(vif_values)





# Obtain residuals from the model
residuals <- residuals(model)

# Plot residuals against predicted values
plot(predict(model), residuals, 
     xlab = "Predicted Values", ylab = "Residuals",
     main = "Residual Plot")
abline(h = 0, col = "red")  # Add horizontal line at y = 0




# Generate QQ plot of residuals
qqnorm(residuals)
qqline(residuals)



# Plot residuals against predictor variables
par(mfrow=c(2, 2))  # Set up a 2x2 grid for multiple plots
plot(model)



# Select only the relevant columns
selected_data <- car_data[, c("Year", "Max_Power_numeric", "Kilometer", "Fuel.Type", "Transmission")]

numeric_data <- selected_data[, sapply(selected_data, is.numeric)]
pearson_cor <- cor(numeric_data, method = "pearson")
print("Pearson Correlation Matrix:")
print(pearson_cor)


# Visualizing Pearson Correlations
corrplot(pearson_cor, method = "circle", title = "Pearson Correlation Matrix")


# Make predictions on the test data using the fitted model
predicted_prices <- predict(model, newdata = test_data)

# Display the predicted prices
print(predicted_prices)


# Extract actual prices from the test dataset
actual_prices <- test_data$Price

# Compare predicted prices with actual prices
comparison <- data.frame(Actual_Price = actual_prices, Predicted_Price = predicted_prices)

# Print the comparison
print(comparison)





# Convert Actual_Price and Predicted_Price to numeric
comparison$Actual_Price <- as.numeric(comparison$Actual_Price)
comparison$Predicted_Price <- as.numeric(comparison$Predicted_Price)

# Calculate Mean Absolute Error (MAE)
mae <- mean(abs(comparison$Actual_Price - comparison$Predicted_Price))

# Calculate Root Mean Squared Error (RMSE)
rmse <- sqrt(mean((comparison$Actual_Price - comparison$Predicted_Price)^2))

# Calculate R-squared (R2) value
actual_mean <- mean(comparison$Actual_Price)
ss_total <- sum((comparison$Actual_Price - actual_mean)^2)
ss_residual <- sum((comparison$Actual_Price - comparison$Predicted_Price)^2)
r_squared <- 1 - (ss_residual / ss_total)

# Print evaluation metrics
print(paste("Mean Absolute Error (MAE):", mae))
print(paste("Root Mean Squared Error (RMSE):", rmse))
print(paste("R-squared (R2) value:", r_squared))


