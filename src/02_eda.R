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

  # ---- Correlation heatmap data ----
  num_df <- adult_processed |>
    select(where(is.numeric))

  cor_mat <- cor(num_df, use = "complete.obs")

  cor_long <- as.data.frame(cor_mat) |>
    tibble::rownames_to_column("Var1") |>
    pivot_longer(-Var1, names_to = "Var2", values_to = "Correlation")

  # ---- Plot heatmap ----
  heatmap_plot <- ggplot(cor_long, aes(x = Var1, y = Var2, fill = Correlation)) +
    geom_tile(color = "white") +
    scale_fill_gradient2(
      low = "steelblue",
      mid = "white",
      high = "firebrick",
      midpoint = 0,
      limits = c(-1, 1)
    ) +
    theme_minimal() +
    labs(
      title = "Correlation Heatmap of Adult Processed Dataset",
      x = "",
      y = "",
      fill = "Corr"
    ) +
    theme(
      axis.text.x = element_text(size = 14, angle = 45, hjust = 1),
      axis.text.y = element_text(size = 14),
      axis.title = element_text(size = 14),
      plot.title = element_text(size = 18, face = "bold")
    )

  ggsave(
    filename = file.path(figures_dir, "correlation_heatmap.png"),
    plot = heatmap_plot,
    width = 10,
    height = 8
  )

#displays text in terminal to indicate that the script ran successfully 
  cat("EDA complete.\n")
  cat("Saved table to:", file.path(tables_dir, "class_counts.csv"), "\n")
  cat("Saved figure to:", file.path(figures_dir, "correlation_heatmap.png"), "\n")
}

main(opt$input_file, opt$results_dir)