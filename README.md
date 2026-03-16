# Salary Income Classification Analysis

## Contributors
- Andy Xin
- Aryan Shah
- Lucas Ortiz Molina
- Taehyun Kim

## Project Summary
In this project, we applied a logistic regression model to the 1994 UCI Adult Census dataset to predict whether an individual earns ≤$50K or >$50K per year. The model achieved an accuracy of approximately 80.13%. Our exploratory data analysis showed that education level appears to be positively related to income, meaning individuals with higher levels of education tend to earn more. We also found a relationship between marital status and income, where married individuals were more likely to earn more than $50K compared to non-married individuals. 

These findings may help inform education and social policy discussions. Additionally, because the model performed well, this approach could be used as a starting point for similar analyses in economic research. The dataset can be found in https://archive-beta.ics.uci.edu/dataset/2/adult

## How to run the analysis

### Option 1: Using Conda 

Using conda-lock file for complete reproducibility. Requires Conda and Conda-lock

You can install the Environment using conda-lock file, activate and run jupyter notebooks using:

```bash
conda-lock install --name dsci310 conda-lock.yml
conda activate dsci310
jupyter lab
```
 Jupyter notebooks should be open, if not open the URL printed in the terminal starting in https://127.0...

When finished type Ctrl+C and 
```bash 
conda deactivate
```

### Option 2: Using Docker Locally

1. Building the Docker Image locally:

Make sure Docker is installed and running. From the root directory of the repository (where the Dockerfile is located), run:

```bash
docker build -t dsci-310-group-12 .
```

2. How to Run the Docker Image :

For windows:
```bash
docker run -it --rm -p 8888:8888 -v "/$(pwd)://home/jovyan" dsci310-image
```
For Mac or linux
```bash
docker run -it --rm -p 8888:8888 -v "$(pwd):/home/jovyan" dsci310-image
```

After the container starts, open a browser and navigate to:

starting in https://127.0...

Then open and run: `salary_analysis.ipynb`

When finished, stop the container with Ctrl+C

### Option 3: Using Docker Compose
Make sure Docker is installed and running. From the root directory of the repository (where the Dockerfile is located), run:

```bash
docker compose up
```
After the container starts, open a browser and navigate to:

starting in https://127.0...

Then open and run: `salary_analysis.ipynb`

When finished, stop the container with Ctrl+C, then:
```bash
docker compose down
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
  - pip
  - pip:
      - openpyxl==3.1.5

Additional environment details are locked in `conda-lock.yml` to ensure reproducibility across platforms.

## License

This project is distributed under the following license:

- MIT License (see `LICENSE.md` for full details)
