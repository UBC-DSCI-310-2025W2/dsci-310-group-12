"Train a logistic regression model on the processed dataset.

Usage:
  03_train_model.R <input_file>

Options:
  <input_file>   Path to processed dataset CSV
" -> doc

library(dplyr)
library(readr)
library(docopt)

opt <- docopt(doc)

main <- function(input_file) {

  # ---- Define output paths ----
  model_path <- "results/models/logistic_model.rds"
  metrics_path <- "results/tables/training_metrics.csv"

  # ---- Create directories ----
  dir.create(dirname(model_path), recursive = TRUE, showWarnings = FALSE)
  dir.create(dirname(metrics_path), recursive = TRUE, showWarnings = FALSE)

  # ---- Read data ----
  adult_processed <- read_csv(input_file, show_col_types = FALSE)

  # ---- Train model ----
  source("R/06_train_logistic_model.R")
  
  model <- train_logistic_model(
    adult_processed,
    income ~ education_num + married
  )

  # ---- Predictions ----
  pred_prob <- predict(model, type = "response")
  pred_class <- ifelse(pred_prob > 0.5, 1, 0)

  # ---- Accuracy ----
  accuracy <- mean(pred_class == adult_processed$income)

  # ---- Save metrics ----
  metrics_tbl <- tibble(
    model = "logistic_regression",
    metric = "accuracy",
    value = accuracy
  )

  write_csv(metrics_tbl, metrics_path)

  cat("Model training complete.\n")
  cat("Accuracy:", round(accuracy, 4), "\n")
}

main(opt$input_file)