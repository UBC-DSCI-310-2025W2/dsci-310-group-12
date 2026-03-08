# Salary Income Classification Analysis

## Contributors
- Andy Xin
- Aryan Shah
- Lucas Ortiz Molina
- Taehyun Kim

## Project Summary
This project analyzes factors that influence whether an individual earns more than $50,000 per year. Using a publicly available income dataset, we apply a logistic regression classification model to predict whether an individual's income falls above or below the $50K threshold.

The analysis explores relationships between income and variables such as education level and marital status, and evaluates the performance of the predictive model using metrics including accuracy, a confusion matrix, and a Receiver Operating Characteristic (ROC) curve. The results help illustrate how statistical modeling can be used to understand income patterns and evaluate predictive performance.

## How to run the analysis

### Option 1: Using Conda 

Using conda-lock file for complete reproducibility, 

conda-lock install --name dsci310 conda-lock.yml

After, open and run the Jupyter notebook:
salary_analysis.ipynb

### Option 2: Using Docker

#### How to Build the Docker Image:

Make sure Docker is installed and running. From the root directory of the repository (where the Dockerfile is located), run:

docker build -t dsci-310-group-12 .

How to Run the Docker Image:

docker run --rm -p 8888:8888 dsci-310-group-12

After the container starts, open a browser and navigate to:

http://localhost:8888

Then open and run: salary_analysis.ipynb

