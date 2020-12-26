export SUBMISSION_DIR="submission_dir"
export BRANCH="r-functions"

execute_fn() {
    if ! eval "$@"; then
        echo "🚫 Failed to `echo $1 | tr '_' ' '` 😢"
        exit 1
    fi
}

download_helper_script() {
  curl -sL "https://gitlab.aicrowd.com/jyotish/pricing-game-notebook-scripts/raw/${BRANCH}/r/aicrowd_helpers.R" > aicrowd_helpers.R
}

download_prediction_script() {
    rm -rf ${SUBMISSION_DIR}
    mkdir -p ${SUBMISSION_DIR}
    curl -sL "https://gitlab.aicrowd.com/jyotish/pricing-game-notebook-scripts/raw/${BRANCH}/r/predict.R" > ${SUBMISSION_DIR}/predict.R
}

install_aicrowd_utilities() {
  pip3 install git+https://gitlab.aicrowd.com/yoogottamk/aicrowd-cli > /dev/null && mkdir -p ~/.config/aicrowd-cli && touch ~/.config/aicrowd-cli/config.toml
}

echo "⚙️ Installing AIcrowd utilities..."
execute_fn install_aicrowd_utilities
execute_fn download_helper_script
echo "✅ Installed AIcrowd utilities"

execute_fn download_prediction_script
#execute_fn download_dataset

