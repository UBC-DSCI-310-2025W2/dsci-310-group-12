#' Transforms a column into dummy variables 1 or 0
#'
#' Converts one column into dummy variables and renames the colum 
#'
#' @param data_frame A data frame or data frame extension (e.g. a tibble).
#' @param col_name The column to check (string) to convert its values to binary
#' @param values A vector of values to be treated as one c(...)
#' @return A data frame with a one column as binary variables
#'
#' @export
#' @examples
#' count_classes(adult_raw, " marital_status", c(" Widowed"))
#' 
#' 
make_dummy_col <- function(data_frame, col_name, values) {
  #checking that it is a data frame
  if (!is.data.frame(data_frame)) {
    stop("`data_frame` must be a data frame or tibble.")
  }
    # checking that the column is a string
    if (!rlang::is_string(col_name)) {
    stop("Both `col_name` and `new_col_name` must be single strings.")
  }
  #checking that the column exists
    if (!col_name %in% names(data_frame)) {
    stop(paste("Column", col_name, "not found in data frame."))
  }
    # checking that the data class is same for values and column
    if (class(data_frame[[col_name]]) != class(values)) {
    warning("Type mismatch: The provided values are not the same class as the column values.")
  }
  #this converts the column into characters 
  column_data <- as.character(data_frame[[col_name]])
  #this converts the column into characters 
  search_values <- <- as.character(values)
  # this generates a vector of dummy varaibles
  dummy_vector <- ifelse(column_data %in% search_values, 1, 0)
  #overriding the old column as a dummy variable
  data_frame[[col_name]] <- dummy_vector
  return(data_frame)
} 