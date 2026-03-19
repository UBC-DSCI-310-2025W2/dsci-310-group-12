### To run 01_preprocess.R
- ``Rscript src/01_preprocess.R data/raw/adult_raw.csv data/raw/adult_names_raw.csv data/processed/adult_processed.csv``

### To run 02_eda.R
- ``Rscript src/02_eda.R data/processed/adult_processed.csv results``

### To run 03_model_train.R
- ``Rscript src/03_model_train.R data/processed/adult_processed.csv``

### 04_evaluate_model.R
- ``Rscript src/04_evaluate_model.R data/processed/adult_processed.csv``