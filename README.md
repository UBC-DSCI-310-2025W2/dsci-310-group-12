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

The main analysis can be found in salary_analysis.qmd. The Quarto file can be rendered into html using instructinons below. In addition, the analysis can also be viewed as a jupyter notebook in salary_analysis.ipynb.

## Cloning the Repository 

To start the analysis clone the repository to your local machine. First, navigate to where you want to store the folder by inputting 

```bash
cd <name>
```
into the termnial, unless stated otherwise, all inputs are done inside the terminal.

Inside the desired folder, clone the repostory:

SSH key:
```bash
git clone git@github.com:UBC-DSCI-310-2025W2/dsci-310-group-12.git
```
HTTPS:
```bash
git clone https://github.com/UBC-DSCI-310-2025W2/dsci-310-group-12.git
```

Then navigate into the project directory:
```bash
cd dsci-310-group-12
```




## How to set up the environment

### Option 1: Using Conda 

Using conda-lock file for complete reproducibility. Requires Conda and Conda-lock



```bash
conda-lock install --name dsci310 conda-lock.yml
```
Activate the environment:
```bash
conda activate dsci310
```
Then download R Package from Git Hub:
```bash
Rscript -e 'pak::pak("UBC-DSCI-310-2025W2/wrangle-viz-tools-group-12")'
```
Optionally open jupyter labs using:
```bash
jupyter lab
```
 Jupyter notebooks should automatically open, if not, open the URL printed in the terminal starting in https://127.0...

When finished type Ctrl+C in termal and input
```bash 
conda deactivate
```

### Option 2: Using Docker Locally

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

When finished, stop the container with Ctrl+C

### Option 3: Using Docker Compose
Make sure Docker is installed and running. From the root directory of the repository (where the Dockerfile is located), run:

```bash
docker compose up
```
After the container starts, from the terminal open the link starting in https://127.0... 

When finished, stop the container with Ctrl+C
```bash
docker compose down
```


## How to run the analysis:
After the environment is set up, navigate to terminal. If inside jupyter notebooks press

`File -> New -> Terminal`

inside the terminal you can 

Generate repots:
```bash
make all
```
Remove all reports:
```bash
make clean
```

Additionally, you can manually run scripts and generate the quarto file using:
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
quarto render salary_analysis.qmd
```

## Dependencies

The main dependencies required to run this project are listed in `environment.yml` and include:

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

Additional environment details are locked in `conda-lock.yml` to ensure reproducibility across platforms.

## License

This project is distributed under the following license:

- MIT License (see `LICENSE.md` for full details)
