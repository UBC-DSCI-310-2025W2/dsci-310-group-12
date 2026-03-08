# Salary Income Classification Analysis

## Contributors
- Andy Xin
- Aryan Shah
- Lucas Ortiz Molina
- Taehyun Kim

## Project Summary
In this project, we applied a logistic regression model to the 1994 UCI Adult Census dataset to predict whether an individual earns ≤$50K or >$50K per year. The model achieved an accuracy of approximately 80.13%. Our exploratory data analysis showed that education level appears to be positively related to income, meaning individuals with higher levels of education tend to earn more. We also found a relationship between marital status and income, where married individuals were more likely to earn more than $50K compared to non-married individuals. 

These findings may help inform education and social policy discussions. Additionally, because the model performed well, this approach could be used as a starting point for similar analyses in economic research.

## How to run the analysis

### Option 1: Using Conda 

Using conda-lock file for complete reproducibility, 

`conda-lock install --name dsci310 conda-lock.yml`

After, open and run the Jupyter notebook:
`salary_analysis.ipynb`

### Option 2: Using Docker

#### How to Build the Docker Image:

Make sure Docker is installed and running. From the root directory of the repository (where the Dockerfile is located), run:

`docker build -t dsci-310-group-12 .`

#### How to Run the Docker Image:

`docker run --rm -p 8888:8888 dsci-310-group-12`

After the container starts, open a browser and navigate to:

http://localhost:8888

Then open and run: `salary_analysis.ipynb`

## Dependencies

The main dependencies required to run this project are listed in `environment.yml` and include:

- python=3.12
  - jupyterlab
  - numpy
  - pandas
  - matplotlib
  - seaborn
  - scikit-learn
  - statsmodels
  - pip
  - pip:
      - openpyxl

Additional environment details are locked in `conda-lock.yml` to ensure reproducibility across platforms.

## License

This project is distributed under the following license:

- MIT License (see `LICENSE.md` for full details)