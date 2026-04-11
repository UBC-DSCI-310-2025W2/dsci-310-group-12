# Final target
all: salary_analysis.html

# Processed data
data/processed/adult_processed.csv:
	Rscript src/01_preprocess.R \
		data/raw/adult_raw.csv \
		data/raw/adult_names_raw.csv \
		data/processed/adult_processed.csv

# EDA outputs
results/figures/correlation_heatmap.png \
results/figures/income_by_education.png \
results/figures/income_by_marriage.png \
results/tables/class_counts.csv: data/processed/adult_processed.csv
	Rscript src/02_eda.R data/processed/adult_processed.csv results

# Model training outputs
results/models/logistic_model.rds \
results/tables/training_metrics.csv: data/processed/adult_processed.csv
	Rscript src/03_model_train.R data/processed/adult_processed.csv

# Model evaluation outputs
results/figures/confusion_matrix.png \
results/figures/roc_curve.png: data/processed/adult_processed.csv \
	results/models/logistic_model.rds
	Rscript src/04_evaluate_model.R data/processed/adult_processed.csv

# Data validation output
results/reports/validation_report.html: data/processed/adult_processed.csv 
	Rscript src/data_validation.R data/processed/adult_processed.csv 


# Quarto report
salary_analysis.html: \
	results/figures/correlation_heatmap.png \
	results/figures/income_by_education.png \
	results/figures/income_by_marriage.png \
	results/figures/confusion_matrix.png \
	results/figures/roc_curve.png \
	results/tables/class_counts.csv \
	results/tables/training_metrics.csv \
	results/models/logistic_model.rds
	quarto render results/reports/salary_analysis.qmd

# Clean target
clean:
	rm -rf data/raw/*
	rm -rf data/processed/*
	rm -rf results/figures/*
	rm -rf results/tables/*
	rm -rf results/models/*
	rm -f results/reports/salary_analysis.html
	rm -f results/reports/validation_report.html

.PHONY: all clean