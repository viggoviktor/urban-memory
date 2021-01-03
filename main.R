cat(system('curl -sL https://gitlab.aicrowd.com/jyotish/pricing-game-notebook-scripts/raw/r-functions/r/setup.sh > setup.sh && bash setup.sh', intern=TRUE), sep='\n')

source("aicrowd_helpers.R")
source("load_data.R")

source("preprocesDataFunctions.R")

preprocess_X_data <- function(x_raw){
  # Data preprocessing function: given X_raw, clean the data for training or prediction.
  
  # Parameters
  # ----------
  # X_raw : Dataframe, with the columns described in the data dictionary.
  # 	Each row is a different contract. This data has not been processed.
  
  # Returns
  # -------
  # A cleaned / preprocessed version of the dataset
  tmp <- proprocessData_local(x_raw)
  # YOUR CODE HERE ------------------------------------------------------
  
  
  # ---------------------------------------------------------------------
  return(tmp) # change this to return the cleaned data
}

fit_model <- function (x_raw, y_raw){
  # Model training function: given training data (X_raw, y_raw), train this pricing model.
  
  # Parameters
  # ----------
  # X_raw : Dataframe, with the columns described in the data dictionary.
  # 	Each row is a different contract. This data has not been processed.
  # y_raw : a array, with the value of the claims, in the same order as contracts in X_raw.
  # 	A one dimensional array, with values either 0 (most entries) or >0.
  
  # Returns
  # -------
  # self: (optional), this instance of the fitted model.
  
  
  # This function trains your models and returns the trained model.
  
  # YOUR CODE HERE ------------------------------------------------------
  
  # x_clean = preprocess_X_data(x_raw)  # preprocess your data before fitting
  
  trained_model = lm(unlist(ydata) ~  1 ) # toy linear model
  
  # ---------------------------------------------------------------------
  # The result trained_model is something that you will save in the next section
  return(trained_model)
}
model = fit_model(Xdata, ydata)
predict_expected_claim <- function(model, x_raw){
  # Model prediction function: predicts the average claim based on the pricing model.
  
  # This functions estimates the expected claim made by a contract (typically, as the product
  # of the probability of having a claim multiplied by the average cost of a claim if it occurs),
  # for each contract in the dataset X_raw.
  
  # This is the function used in the RMSE leaderboard, and hence the output should be as close
  # as possible to the expected cost of a contract.
  
  # Parameters
  # ----------
  # X_raw : Dataframe, with the columns described in the data dictionary.
  # 	Each row is a different contract. This data has not been processed.
  
  # Returns
  # -------
  # avg_claims: a one-dimensional array of the same length as X_raw, with one
  #     average claim per contract (in same order). These average claims must be POSITIVE (>0).
  
  
  # YOUR CODE HERE ------------------------------------------------------
  
  # x_clean = preprocess_X_data(x_raw)  # preprocess your data before fitting
  expected_claims = exp(log(predict(model, newdata = x_raw)))*1.01+1000  # tweak this to work with your model
  
  return(expected_claims)  
}
claims <- predict_expected_claim(model, Xdata)

predict_premium <- function(model, x_raw){
  # Model prediction function: predicts premiums based on the pricing model.
  
  # This function outputs the prices that will be offered to the contracts in X_raw.
  # premium will typically depend on the average claim predicted in 
  # predict_expected_claim, and will add some pricing strategy on top.
  
  # This is the function used in the average profit leaderboard. Prices output here will
  # be used in competition with other models, so feel free to use a pricing strategy.
  
  # Parameters
  # ----------
  # X_raw : Dataframe, with the columns described in the data dictionary.
  # 	Each row is a different contract. This data has not been processed.
  
  # Returns
  # -------
  # prices: a one-dimensional array of the same length as X_raw, with one
  #     price per contract (in same order). These prices must be POSITIVE (>0).
  
  
  # YOUR CODE HERE ------------------------------------------------------
  
  # x_clean = preprocess_X_data(x_raw)  # preprocess your data before fitting
  
  return(predict_expected_claim(model, x_raw))
}
prices <- predict_premium(model, Xdata)
as.matrix(head(prices))

print(paste('Income:', sum(prices)))
print(paste('Losses:', sum(ydata)))

if (sum(prices) < sum(ydata)) {
  print('Your model loses money on the training data! It does not satisfy market rule 1: Non-negative training profit.')
  print('This model will be disqualified from the weekly profit leaderboard, but can be submitted for educational purposes to the RMSE leaderboard.')
} else {
  print('Your model passes the non-negative training profit test!')
}

