# Soil Data Analysis: Microbial Carbon and Nitrogen in Soil

This project provides an R script for comprehensive statistical analysis of soil chemistry data, focusing on microbial carbon (Cmic) and nitrogen (Nmic) contents under different treatments. The workflow includes data cleaning, transformation, exploratory analysis, visualization, and advanced statistical modeling to uncover key insights into soil microbial biomass and its chemical properties.

---

## Table of Contents

- [Project Overview](#project-overview)
- [Getting Started](#getting-started)
- [Workflow Steps](#workflow-steps)
- [Outputs](#outputs)
- [Conclusion](#contributing)

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

#### **Install required R packages**
   - install.packages(c('ggplot2', 'dplyr', 'car', 'MASS', 'psych', 'caret', 'nortest', 'multcomp', 'DescTools', 'ggpubr'))

---

## Workflow Steps

1. Data Loading and Preparation

- Load necessary libraries.
- Read CSV files and set working directory.

2. Normality Checks & Data Transformation

- Check Cmic and Nmic distributions (density plots, Shapiro-Wilk).
- Compare mean/median, apply transformations (square root, log, Box-Cox).

3. Visualization

- Generate Q-Q plots and boxplots for visual inspection.
- Annotate plots for clarity.

4. Statistical Testing

- Perform ANOVA and Tukey HSD post-hoc tests for treatment differences.

5. Multiple Linear Regression

- Subset numeric explanatory variables (C/N ratio, Ctot, Ntot, humus, CEC, pH, clay).
- Impute missing values, split data, fit regression models.
- Check model fit (R²) and multicollinearity (VIF).

6. Further Statistical Analysis

- Analyze treatment effects on explanatory variables.
- Use normality tests, Bartlett’s test, ANOVA, Kruskal-Wallis, Dunn’s test as appropriate.

---

## Outputs
- Plots (density, Q-Q, boxplots)
- Statistical tables (ANOVA, regression summaries)
- Model summaries (R², VIF)
- Workflow conclusions and recommended next steps

---

## Conclusion
This script is a comprehensive workflow for analyzing soil microbial biomass and related chemical properties, involving data cleaning, transformation, exploratory data analysis, visualization, hypothesis testing, and regression modeling to understand the influence of soil properties and treatments on microbial C and N.

