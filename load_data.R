TRAINING_DATA_PATH = 'training.csv'
MODEL_OUTPUT_PATH = 'trained_model.RData'  # Alter if not using .RData files
AICROWD_API_KEY = '33ebd9521fd143c13cb6398ce3713a14'  # You can get the key from https://aicrowd.com/participants/me

download_aicrowd_dataset(AICROWD_API_KEY)


install_packages <- function() {
  # install.packages("caret")
  # install.packages("rpart")
  
}
install_packages()
global_imports <- function() {
  # require("caret")
  # require("rpart")
  library(gridExtra)
  library(grid)
  library(ggplot2)
  library(plyr)
  library(lattice)
  library(corrplot)
  library(xgboost)
  library(caret)
  library(dplyr)
  library(Matrix)
}
global_imports()
# Load the dataset.
train_data = read.csv(TRAINING_DATA_PATH)

# Create a model, train it, then save it.
Xdata = within(train_data, rm('claim_amount'))
ydata = train_data['claim_amount']