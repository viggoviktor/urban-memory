exec_cmd <- function(cmd) {
  cat(system(paste(cmd, "2>&1"), intern=TRUE), sep="\n")
}

aicrowd_login <- function(api_key) {
  if (system(paste("aicrowd login --api-key", api_key, sep=" ")) != 0) {
    message("🚫 Failed to login to AIcrowd")
    message("Please recheck the API key provided")
    return(FALSE)
  }
  return(TRUE)
}

download_aicrowd_dataset <- function(api_key) {
  if(aicrowd_login(api_key)) {
    message("💾 Downloading dataset...")
    exec_cmd("aicrowd dataset download -c insurance-pricing-game")
  }
}


capture_source_code <- function(api_key) {
  capture.output(install_packages, file='install_packages.R')
  capture.output(fit_model, file='fit_model.R')
  capture.output(save_model, file='save_model.R')
  capture.output(load_model, file='load_model.R')
  capture.output(load_model, file='global_imports.R')
  capture.output(predict_expected_claim, file='predict_expected_claim.R')
  capture.output(predict_premium, file='predict_premium.R')
  capture.output(preprocess_X_data, file='preprocess_X_data.R')
  capture.output(global_imports, file='global_imports.R')
  writeLines(api_key, 'api.key')
}

aicrowd_submit <- function(api_key) {
  capture_source_code(api_key)
  exec_cmd('curl -sL https://gitlab.aicrowd.com/jyotish/pricing-game-notebook-scripts/raw/r-functions/r/submit.sh > submit.sh && bash submit.sh')
}
