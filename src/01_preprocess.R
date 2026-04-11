"Download, clean, and preprocess the Adult Census dataset.
First downloads the dataset, then will wrangle and download that version

Usage:
  01_preprocess.R <raw_data_path> <names_path> <processed_output_path>

Options:
  <raw_data_path>           Path to save raw adult.data file
  <names_path>              Path to save adult.names file
  <processed_output_path>   Path to save cleaned dataset
" -> doc

library(tidyverse)
library(docopt)
library(WrangleVizTools)

opt <- docopt(doc)

main <- function(raw_data_path, names_path, processed_output_path) {

  # ---- Create directories if needed ----
  dir.create(dirname(raw_data_path), recursive = TRUE, showWarnings = FALSE)
  dir.create(dirname(names_path), recursive = TRUE, showWarnings = FALSE)
  dir.create(dirname(processed_output_path), recursive = TRUE, showWarnings = FALSE)

  # ---- Download data ----
  url_data <- "https://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data"
  url_names <- "https://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.names"

  download.file(url_data, raw_data_path, mode = "wb")
  download.file(url_names, names_path, mode = "wb")

  # ---- Read data ----
  adult_raw <- read.csv(
    raw_data_path,
    header = FALSE,
    na.strings = "?"
  )

  colnames(adult_raw) <- c(
    "age", "workclass", "fnlwgt", "education", "education_num",
    "marital_status", "occupation", "relationship", "race", "sex",
    "capital_gain", "capital_loss", "hours_per_week", "native_country", "income"
  )

  # ---- Preprocess ----
adult_processed <- adult_raw |> filter(workclass != " Never-worked" & #filtering those that never worked as its all below 50k
                                        workclass != " ?" &  #removing missing values
                                        occupation != " ?" &
                                        native_country != " ?") |>
                                make_dummy_col("marital_status", "married", c(" Widowed", " Never-married"))|>
                                make_dummy_col("sex", "male", c(" Male"))|>
                                make_dummy_col("race", "race_white", c(" White"))|>
                                make_dummy_col("race", "race_asian_pac_islander", c(" Asian-Pac-Islander"))|>
                                make_dummy_col("race", "race_amer_indian_eskimo", c(" Amer-Indian-Eskimo"))|>
                                make_dummy_col("race", "race_black", c(" Black"))|>
                                make_dummy_col("race", "race_other", c(" Other"))|>
                                make_dummy_col("income", "income", c(" >50K"))|>
                                select(-education, -fnlwgt, -marital_status, 
                                        -workclass, -occupation, -relationship,
                                        -race, -sex)
  # ---- Save output ----
  write.csv(adult_processed, processed_output_path, row.names = FALSE)
  
  cat("Preprocessing complete.\n")}

main(opt$raw_data_path, opt$names_path, opt$processed_output_path)