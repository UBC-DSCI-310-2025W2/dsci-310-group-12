"Train a logistic regression model on the processed dataset.
- this will create a table called training metric that includes accuracy and percision data for the model
Usage:
  03_train_model.R <input_file>

Options:
  <input_file>   Path to processed dataset CSV
" -> doc

library(dplyr)
library(readr)
library(docopt)
library(WrangleVizTools)

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
  
  model <- train_logistic_model(
    adult_processed,
    income ~ education_num + married
  )

  # ---- Predictions ----
  pred_prob <- predict(model, type = "response")
  pred_class <- ifelse(pred_prob > 0.5, 1, 0)

  # ---- Accuracy ----
  accuracy <- mean(pred_class == adult_processed$income)

  # ---- precision ----
  tp <- sum(pred_class == 1 & adult_processed$income == 1)
  tn <- sum(pred_class == 0 & adult_processed$income == 0)
  fp <- sum(pred_class == 1 & adult_processed$income == 0)
  fn <- sum(pred_class == 0 & adult_processed$income == 1)
  precision <- tp / (tp + fp)
  # ---- Save metrics ----
metrics_tbl <- tibble(
  model = "logistic_regression",
  metric = c("accuracy", "precision"),
  value = c(accuracy, precision)
)

  write_csv(metrics_tbl, metrics_path)

  cat("Model training complete.\n")
  cat("Accuracy:", round(accuracy, 4), "\n")
  cat("Precision:", round(precision, 4), "\n")
}

main(opt$input_file)