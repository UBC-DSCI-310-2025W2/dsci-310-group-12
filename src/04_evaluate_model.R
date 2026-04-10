"Create confusion matrix and ROC curve plots for logistic regression.

Usage:
  04_model_evaluate.R <input_file>

Options:
  <input_file>   Path to processed dataset CSV
" -> doc

library(docopt)
library(readr)
library(caret)
library(ggplot2)
library(pROC)
library(WrangleVizTools)

opt <- docopt(doc)

main <- function(input_file) {

  dir.create("results/figures", recursive = TRUE, showWarnings = FALSE)

  adult_processed <- read_csv(input_file, show_col_types = FALSE)

  # Simple logistic regression classification
  model <- glm(
    income ~ education_num + married,
    data = adult_processed,
    family = binomial()
  )

  # Predict probabilities
  pred_prob <- predict(model, type = "response")

  # Convert to class predictions (0/1)
  pred_class <- ifelse(pred_prob > 0.5, 1, 0)

  actual_f <- factor(adult_processed$income)
  pred_f <- factor(pred_class)

  cm <- confusionMatrix(pred_f, actual_f)

  confusion_plot <- create_confusion_matrix_plot(cm$table)

  ggsave(
    filename = "results/figures/confusion_matrix.png",
    plot = confusion_plot,
    width = 8,
    height = 6
  )

  roc_obj <- roc(adult_processed$income, pred_prob)

  png("results/figures/roc_curve.png", width = 800, height = 600)
  plot(
    roc_obj,
    main = paste("ROC Curve (AUC =", round(auc(roc_obj), 3), ")"),
    cex.axis = 1.3,
    cex.lab = 1.4,
    cex.main = 1.5
  )
  dev.off()
}

main(opt$input_file)
