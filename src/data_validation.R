"Validate the processed Adult Census dataset using pointblank.

Usage:
  05_data_validation.R <input_file>

Options:
  <input_file>   Path to processed dataset CSV
" -> doc

library(docopt)
library(readr)
library(pointblank)

opt <- docopt(doc)

main <- function(input_file) {

  if (!grepl("\\.csv$", input_file, ignore.case = TRUE)) {           
    stop("Input file must be a CSV file.")
  }

  adult_processed <- read_csv(input_file, show_col_types = FALSE)

  agent <- create_agent(                                           
    tbl = adult_processed,
    label = "Processed Adult Census data validation"
  ) |>
    col_schema_match(                                                
      schema = col_schema(
        age = "numeric",
        education_num = "numeric",
        capital_gain = "numeric",
        capital_loss = "numeric",
        hours_per_week = "numeric",
        native_country = "character",
        married = "numeric",
        male = "numeric",
        race_white = "numeric",
        race_asian_pac_islander = "numeric",
        race_amer_indian_eskimo = "numeric",
        race_black = "numeric",
        race_other = "numeric",
        income = "numeric"
      )
    ) |>
    rows_complete() |>                                              
    col_vals_not_null(
      columns = c(                                                  
        age, education_num, capital_gain, capital_loss,
        hours_per_week, native_country, married, male,
        race_white, race_asian_pac_islander,
        race_amer_indian_eskimo, race_black,
        race_other, income
      )
    ) |>
    rows_distinct() |>         
    col_vals_in_set(
      columns = c(
        married, male, race_white, race_asian_pac_islander,
        race_amer_indian_eskimo, race_black, race_other, income
      ),
      set = c(0, 1)
    ) |>
    col_vals_between(age, left = 0, right = 120) |>
    col_vals_between(education_num, left = 1, right = 16) |>
    col_vals_between(hours_per_week, left = 1, right = 70) |>
    col_vals_gt(capital_gain, value = -1) |>
    col_vals_gt(capital_loss, value = -1) 

  agent |>
    interrogate()
  
  print(agent)
}

main(opt$input_file)