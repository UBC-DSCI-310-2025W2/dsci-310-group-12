# Salary Income Classification Analysis

## Contributors
- Andy Xin
- Aryan Shah
- Lucas Ortiz Molina
- Taehyun Kim

## Project Summary
In this project, we applied a logistic regression model to the 1994 UCI Adult Census dataset to predict whether an individual earns ≤$50K or >$50K per year. The model achieved an accuracy of approximately 80.13%. Our exploratory data analysis showed that education level appears to be positively related to income, meaning individuals with higher levels of education tend to earn more. We also found a relationship between marital status and income, where married individuals were more likely to earn more than $50K compared to non-married individuals. 

These findings may help inform education and social policy discussions. Additionally, because the model performed well, this approach could be used as a starting point for similar analyses in economic research. The dataset can be found in https://archive-beta.ics.uci.edu/dataset/2/adult

## Report

The main analysis can be found in [salary_analysis.qmd](results/reports/salary_analysis.qmd) which is in `results/reports` directory. The Quarto file can be rendered into html using instructinons below. The latest version of the analysis can be found in [salary_analysis.html](results/reports/salary_analysis.html). In addition, an older version of the analysis can be viewed as a jupyter notebook in salary_analysis.ipynb.

## Cloning the Repository 

To start the analysis clone the repository to your local machine. First, navigate to where you want to store the folder by inputting 

```bash
cd <name>
```
into the termnial, unless stated otherwise, all inputs are done inside the terminal.

Inside the desired folder, clone the repostory by typing 

SSH key:
```bash
git clone git@github.com:UBC-DSCI-310-2025W2/dsci-310-group-12.git
```
HTTPS:
```bash
git clone https://github.com/UBC-DSCI-310-2025W2/dsci-310-group-12.git
```
into the terminal.

> **Note:** For guaranteed reproducibility, clone the latest release tag rather than `main`.
> You can find the latest release [here](https://github.com/UBC-DSCI-310-2025W2/dsci-310-group-12/releases).
> To clone a specific tag (e.g., `v2.0.0`):
> ```bash
> git clone --branch v2.0.0 https://github.com/UBC-DSCI-310-2025W2/dsci-310-group-12.git
> ```


Then navigate into the project directory.
```bash
cd dsci-310-group-12
```




## How to set up the environment

### Option 1: Using Conda (Reccomended for users)

Using conda-lock file for complete reproducibility. Requires Conda and Conda-lock to activate environment.

First install the environment from the lock file:

```bash
conda-lock install --name dsci310 conda-lock.yml
```
Then activate the environment:
```bash
conda activate dsci310
```
Then download R Package from Github:
```bash
Rscript -e 'pak::pak("UBC-DSCI-310-2025W2/wrangle-viz-tools-group-12")'
```
Optionally open jupyter labs using:
```bash
jupyter lab
```
 Jupyter notebooks should automatically open, if not, open the URL printed in the terminal starting in https://127.0...

When finished type Ctrl+C in termal and input:
```bash 
conda deactivate
```


### Option 2: Using Docker Compose (Reccomended if conda does not work properly)
Make sure Docker is installed and running. From the root directory of the repository (where the Dockerfile is located), input:

```bash
docker compose up
```
After the container starts, from the terminal open the link starting in https://127.0... 

When finished, stop the container with Ctrl+C and input:
```bash
docker compose down
```

### Option 3: Using Docker Locally (Least reccomended as it takes long time to build)

1. Building the Docker Image locally:

Make sure Docker is installed and running. From the root directory of the repository (where the Dockerfile is located), run:

```bash
docker build -t dsci-310-group-12 .
```

2. Run the Docker Image :

For windows:
```bash
docker run -it --rm -p 8888:8888 -v "/$(pwd)://home/jovyan" dsci-310-group-12
```
For Mac or linux
```bash
docker run -it --rm -p 8888:8888 -v "$(pwd):/home/jovyan" dsci-310-group-12
```

After the container starts, from the terminal open the link starting in https://127.0... 

When finished, stop the container with Ctrl+C.

## How to run the analysis:
After the environment is set up, navigate to terminal. If inside jupyter notebooks press

`File -> New -> Terminal`

Then 

to generate reports input:
```bash
make all
```
to remove all reports input:
```bash
make clean
```
The makefile automatically runs all the commends below. You can manually run scripts and generate the quarto file using:
```bash
Rscript src/01_preprocess.R data/raw/adult_raw.csv data/raw/adult_names_raw.csv data/processed/adult_processed.csv
```
```bash 
Rscript src/02_eda.R data/processed/adult_processed.csv results
```
```bash
Rscript src/03_model_train.R data/processed/adult_processed.csv
```
```bash
Rscript src/04_evaluate_model.R data/processed/adult_processed.csv
```
```bash
quarto render results/reports/salary_analysis.qmd
```
## Explanation of Scripts at Each Step:

### [Script 1](src/01_preprocess.R): Download, clean and process dateset to be used

The first scripts handles downloading and wrangling the dataset. It downloads data from https://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data and then wrangles the dataset to be useable in the data analysis. The datasets can be found under `data/raw` folder [adult_raw.csv](data/raw/adult_raw.csv) and `data/processed`folder [adult_processed.csv](data/processed/adult_processed.csv). If it successfully runs, 2 csv files will appear in the two folders mentioned. It is possible that website is not able to be opened due to bad gateway error 502, in that case skip script 1 and manually run the scripts using csv files in the main repostory. 

If it runs properly it will say:
```bash
Preprocessing complete.
```

### [Script 2](src/02_eda.R): Generates explanatory data analysis (EDA) artifacts for analysis.

The second script generates figures and tables which are used in the analysis. It will add [correlation_heatmap.png](results/figures/correlation_heatmap.png), [income_by_education.png](results/figures/income_by_education.png), [income_by_marriage.png](results/figures/income_by_marriage.png) under `results/tables`, and [class_counts.csv](results/tables/class_counts.csv) under `results/tables`.

If it runs properly, it will say: 
```
"EDA complete.
Saved table to: results/tables/class_counts.csv
Saved figure to: results/figures/correlation_heatmap.png
```
### [Script 3](src/03_model_train.R): Train a logistic regression model on the processed dataset.

The third script will generate accuracy and prediction of the model and save the result as [training_metric.csv](results/tables/training_metrics.csv) under `results/tables`.

If it runs properly, it will say:
```bash
Model training complete.
Accuracy: 0.8013
Precision: 0.645
```
### [Script 4](src/04_evaluate_model.R): Generates 2 more figures using outputs from previous scripts.

The fourth script generates [confusion_matrix](results/figures/confusion_matrix.png) and [roc curve](results/figures/roc_curve.png) under `results/figures`, which are used in the analysis.

If it runs properly it will say:
```bash
Setting levels: control = 0, case = 1
Setting direction: controls < cases
null device 
          1
```

### Make all and Quarto Render:

After running `Make all` or after running each step seperately then Quarto render` it will generate [salary_analysis.html](results/reports/salary_analysis.html)

If it runs properly it will say:
```bash
Output created: salary_analysis.html
```




## Dependencies

The main dependencies required to run this project are listed in [License](environment.yml) and include:

  - python=3.12.13
  - jupyterlab=4.5.6
  - numpy=2.4.2
  - pandas=3.0.1
  - matplotlib=3.10.8
  - seaborn=0.13.2
  - scikit-learn=1.8.0
  - statsmodels=0.14.6
  - r-base=4.3.3
  - r-irkernel=1.3.2
  - r-caret=6.0_94
  - r-dplyr=1.1.4
  - r-patchwork=1.3.2
  - r-tidyr=1.3.1
  - r-proc=1.19.0.1
  - r-ggplot2=3.5.2
  - r-docopt=0.7.2
  - r-readr=2.1.5
  - r-pROC=1.19.0.1
  - r-knitr=1.50
  - r-rmarkdown=2.29
  - r-tidyverse=2.0.0
  - r-testthat=3.2.3
  - r-usethis=3.2.1
  - r-devtools=2.4.5
  - r-pak=0.9.0
  - r-pointblank=0.12.2
  - quarto=1.8.27
  - pip
  - pip:
      - openpyxl==3.1.5

Additional environment details are locked in [conda-lock.yml](conda-lock.yml) to ensure reproducibility across platforms.

## License

This project is distributed under the following license:

- MIT License and CC BY-SA 4.0 (see [License](LICENSE.md) for full details)