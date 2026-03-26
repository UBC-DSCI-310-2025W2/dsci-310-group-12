library(testthat)

source("../../R/07_make_dummy_col.R", encoding = "UTF-8")

# ---- Test 1: Simple expected use case ----
test_that("...", {
  df <- data.frame(
    x = c(1,2,3,4),
    y = c(0,1,0,1)
  )
  
  model <- train_logistic_model(df, y ~ x)
  
  expect_true("glm" %in% class(model))
})