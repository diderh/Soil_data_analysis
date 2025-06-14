This R script is focused on the statistical analysis of soil chemistry data, specifically examining microbial carbon (Cmic) and nitrogen (Nmic) contents in soil samples under different treatments. Here’s a summary of what the file does:

1. Data Loading and Preparation:

Loads required libraries for statistical analysis and visualization.
Reads CSV data files containing soil chemistry measurements and explanatory variables.
Sets the working directory for file access.

2. Normality Checks and Data Transformation:

Checks the normality of Cmic and Nmic data distributions using density plots and Shapiro-Wilk tests.
Compares mean and median values to assess skewness.
Applies various data transformations to Cmic (square root, log, Box-Cox) to achieve normality, selecting Box-Cox due to the best p-value.

3. Visualization:

Generates Q-Q plots and boxplots to visually inspect distributions and treatment effects for both Cmic and Nmic after transformation.
Adds customized labels and annotations for clarity.

4. Statistical Testing:

Performs ANOVA and Tukey HSD post-hoc tests to determine if there are significant differences in Cmic and Nmic across treatments.

5. Multiple Linear Regression Analysis:

Prepares a subset of numeric explanatory variables (e.g., C/N ratio, total C, total N, humus, CEC, pH, clay content).
Imputes missing values with the mean.
Splits data into training and validation sets.
Fits multiple linear regression models to predict Cmic and Nmic based on soil properties.
Iteratively refines models by removing variables and checking model fit (R² values reported).
Checks for multicollinearity using Variance Inflation Factor (VIF).

6. Further Statistical Analysis on Explanatory Variables:

Examines treatment effects on explanatory variables (C/N ratio, Ctot, Ntot, humus, clay content, pH) using boxplots.
Applies normality tests, Bartlett’s test for homogeneity of variance, ANOVA, Kruskal-Wallis, and Dunn’s post-hoc tests as appropriate for each variable.

Conclusion:
This script is a comprehensive workflow for analyzing soil microbial biomass and related chemical properties, involving data cleaning, transformation, exploratory data analysis, visualization, hypothesis testing, and regression modeling to understand the influence of soil properties and treatments on microbial C and N.



# Soil Data Analysis: Microbial Carbon and Nitrogen in Soil

This project provides an R script for comprehensive statistical analysis of soil chemistry data, focusing on microbial carbon (Cmic) and nitrogen (Nmic) contents under different treatments. The workflow includes data cleaning, transformation, exploratory analysis, visualization, and advanced statistical modeling to uncover key insights into soil microbial biomass and its chemical properties.

---

## Table of Contents

- [Project Overview](#project-overview)
- [Getting Started](#getting-started)
- [Workflow Steps](#workflow-steps)
- [Outputs](#outputs)
- [Citation](#citation)
- [License](#license)
- [Contributing](#contributing)

---

## Project Overview

This repository contains tools and scripts for:
- Analyzing microbial carbon and nitrogen in soil samples.
- Testing for normality and transforming data distributions.
- Visualizing distributions and treatment effects.
- Performing ANOVA, post-hoc, and regression analyses to understand the relationship between soil properties and microbial content.

---

## Getting Started

### Prerequisites

- R (version >= 4.0 recommended)
- R packages: `ggplot2`, `dplyr`, `car`, `MASS`, `psych`, `caret`, `nortest`, `multcomp`, `DescTools`, `ggpubr`
- Soil chemistry data in CSV format

### Installation

1. **Clone the repository:**
   

2. **Install required R packages**
   install.packages(c('ggplot2', 'dplyr', 'car', 'MASS', 'psych', 'caret', 'nortest', 'multcomp', 'DescTools', 'ggpubr'))

