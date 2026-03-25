"Generate EDA artifacts for the processed Adult Census dataset.

Usage:
  02_eda.R <input_file> <results_dir>

Options:
  <input_file>   Path to processed dataset CSV
  <results_dir>  Directory where tables/ and figures/ will be saved
" -> doc

library(dplyr)
library(ggplot2)
library(tidyr)
library(readr)
library(docopt)

opt <- docopt(doc)

main <- function(input_file, results_dir) {

  # ---- Create output directories ----
  figures_dir <- file.path(results_dir, "figures")
  tables_dir <- file.path(results_dir, "tables")

  dir.create(figures_dir, recursive = TRUE, showWarnings = FALSE)
  dir.create(tables_dir, recursive = TRUE, showWarnings = FALSE)

  # ---- Read data ----
  adult_processed <- read_csv(input_file, show_col_types = FALSE)

  # ---- Table 1: class counts ----
  class_counts <- adult_processed |>
    count(income) |>
    mutate(prop = n / sum(n))

  write_csv(class_counts, file.path(tables_dir, "class_counts.csv"))

  source("R/05_correl_heatmap.R")
  heatmap_plot <- plot_correlation_heatmap(adult_processed, title = "Correlation Heatmap of Adult Processed Dataset")

  ggsave(
    filename = file.path(figures_dir, "correlation_heatmap.png"),
    plot = heatmap_plot,
    width = 10,
    height = 8
  )

  # ---- Additional plots: Education & Marital Status ----

  plot_df <- adult_processed |>
    mutate(
      income = factor(income, levels = c(0,1), labels = c("<=50K", ">50K")),
      married = factor(married, levels = c(0,1), labels = c("No", "Yes"))
    )

  # ---- Plot 1: Education vs Income ----
  p1 <- ggplot(plot_df, aes(x = factor(education_num), fill = income)) +
    geom_bar() +
    labs(
      title = "Income by Education Level",
      x = "Education Number",
      y = "Count",
      fill = "Income"
    ) +
    theme_minimal() +
    theme(
      axis.text.x = element_text(size = 14, angle = 45, hjust = 1),
      axis.text.y = element_text(size = 14),
      axis.title = element_text(size = 14),
      plot.title = element_text(size = 18, face = "bold")
    )

  # ---- Plot 2: Marital Status vs Income ----
  p2 <- ggplot(plot_df, aes(x = married, fill = income)) +
    geom_bar() +
    labs(
      title = "Income by Marital Status",
      x = "Married",
      y = "Count",
      fill = "Income"
    ) +
    theme_minimal() +
    theme(
      axis.text.x = element_text(size = 12),
      axis.text.y = element_text(size = 12),
      axis.title = element_text(size = 14),
      plot.title = element_text(size = 16, face = "bold")
    )

# ---- Save Plot 1 ----
ggsave(
  filename = file.path(figures_dir, "income_by_education.png"),
  plot = p1,
  width = 8,
  height = 5
)

# ---- Save Plot 2 ----
ggsave(
  filename = file.path(figures_dir, "income_by_marriage.png"),
  plot = p2,
  width = 8,
  height = 5
)

#displays text in terminal to indicate that the script ran successfully 
  cat("EDA complete.\n")
  cat("Saved table to:", file.path(tables_dir, "class_counts.csv"), "\n")
  cat("Saved figure to:", file.path(figures_dir, "correlation_heatmap.png"), "\n")
}

main(opt$input_file, opt$results_dir)