# Analysis Guide: Replicating Chetty et al. (2014) with Permutation Inference

## Overview

This analysis replicates key findings from **"Where is the Land of Opportunity? The Geography of Intergenerational Mobility in the United States"** by Chetty et al. (2014), then compares classical OLS inference with permutation-based inference.

**Two methods are compared:**

| Method | Description | Source |
|--------|-------------|--------|
| **Classical OLS** | Standard regression with t-test inference | Chetty et al. (2014) |
| **Permutation Regression** | DiCiccio & Romano (2017) Theorem 3.2 | Alex Jaimes implementation |

This demonstrates that:
1. The original findings are robust to the choice of inference method
2. Permutation methods provide valid inference without distributional assumptions

---

## Why Permutation Tests?

### The Problem with Classical Inference

Classical OLS regression relies on asymptotic theory. The t-statistic approximately follows a t-distribution as sample sizes grow large. However, this approximation may be unreliable when:

1. **Sample sizes are moderate**: Here, n ≈ 700 CZs
2. **Non-Normal Residuals**: Income data is often skewed
3. **Heteroskedasticity**: Variance of mobility may differ across CZs
4. **Spatial Correlation**: Nearby CZs may have correlated outcomes

### What Permutation Testing Offers

From DiCiccio & Romano (2017):
- **No distributional assumptions**: Doesn't assume normality of residuals
- **Valid under dependence**: Asymptotically valid even if errors are correlated
- **Heteroskedasticity-robust**: Uses a studentized test statistic
- **Exact finite-sample validity**: Under certain conditions, provides exact p-values

### The DiCiccio & Romano Test

The permutation regression test uses a heteroskedasticity-robust Wald statistic:

$$S_n = n \hat{\beta}^T \left( \hat{\Sigma}_{XX}^{-1} \hat{\Omega} \hat{\Sigma}_{XX}^{-1} \right) \hat{\beta}$$

where $\hat{\Omega}$ is the HC0 robust covariance estimator. The test:
1. Computes $S_n$ from the observed data
2. Permutes Y values B times (default: 10,000) to generate null distribution
3. Computes p-value as proportion of permuted statistics ≥ observed

---

## Focus on Relative Mobility (Rank-Rank Slope)

**What it is**: The Pearson correlation between parent income rank and child income rank within each Commuting Zone (CZ).

**Why it matters**:
- We use Tables 5 and 8 to replicate "Online Appendix Table VIII"
- The paper's primary measure of intergenerational mobility
- More robust than alternatives (IGE) according to Section II
- Scale-invariant and comparable across regions
- Values range from 0 (perfect mobility) to 1 (no mobility)

**The regression framework**:
- Dependent variable (Y): CZ relative mobility values (vary around 0.341 national average)
- Independent variables (X): CZ characteristics (segregation, inequality, education, etc.)
- Each regression answers: "In CZs with higher values of X, is relative mobility higher or lower?"
- The standardized β coefficient shows the direction and strength of that relationship

**Where referenced**:
- Introduced in Section II (PDF pp. 5-8)
- Main results in Section V and Online Appendix Table VIII
- National estimate: **0.341** (Table I, Row 4)

---

## The 35 Covariates Tested

### 1. Race (1 variable)
- Fraction Black Residents

### 2. Segregation (5 variables)
- Racial Segregation (Theil Index)
- Income Segregation (Theil Index)
- Segregation of Poverty (<p25)
- Segregation of Affluence (>p75)
- Share with Commute < 15 Mins

**Paper finding**: "Areas that are more residentially segregated by race and income have lower levels of mobility"

### 3. Income Distribution (5 variables)
- Household Income per Capita
- Gini Coefficient
- Top 1% Income Share
- Gini Bottom 99%
- Fraction Middle Class (p25-p75)

**Paper finding**: "Upward mobility is strongly positively correlated with the size of the middle class"

### 4. K-12 Education (4 variables)
- School Expenditure per Student
- Teacher-Student Ratio
- Test Score Percentile (Income Adjusted)
- High School Dropout Rate (Income Adjusted)

**Paper finding**: Income-adjusted test scores and dropout rates are "very highly correlated with upward mobility"

### 5. Social Capital (3 variables)
- Social Capital Index
- Fraction Religious
- Violent Crime Rate

**Paper finding**: "The correlation between upward mobility and social capital is 0.641"

### 6. Family Structure (3 variables) - **STRONGEST PREDICTORS**
- Fraction of Children with Single Mothers
- Fraction of Adults Divorced
- Fraction of Adults Married

**Paper finding**: **"The fraction of children living in single-parent households is the single strongest correlate of upward income mobility among all the variables we explored"** (r = -0.764)

### 7. Tax (4 variables)
- Local Tax Rate
- Local Government Expenditures per Capita
- State EITC Exposure
- State Income Tax Progressivity

### 8. College (3 variables)
- Number of Colleges per Capita
- Mean College Tuition
- College Graduation Rate (Income Adjusted)

### 9. Local Labor Market (4 variables)
- Labor Force Participation Rate
- Manufacturing Employment Share
- Growth in Chinese Imports 1990-2000
- Teenage Labor Force Participation Rate

### 10. Migration (3 variables)
- Migration Inflow Rate
- Migration Outflow Rate
- Fraction Foreign Born

---

## Methods Comparison

| Method | Test Statistic | Null Hypothesis | Implementation |
|--------|----------------|-----------------|----------------|
| **Classical OLS** | t = β̂/SE(β̂) | H0: β = 0 | `lm()` |
| **Permutation Regression** | Wald statistic Sn (robust) | H0: β = 0 | `perm_test_regression()` |

**Expected agreement**:
- Strong effects (|r| > 0.3): Both methods should agree
- Weak effects (|r| < 0.1): Both methods should agree (not significant)
- Borderline effects (p ≈ 0.05): May show occasional disagreement

---

## Data Structure and Sample Sizes

### Online Data Table 5 (Mobility Estimates)
- **Total CZs**: 741
- **CZs with n >= 250**: 709 (used in analysis)
- **Key variable**: Column 6 = "RM, 80-82 Cohort" (relative mobility)

### Online Data Table 8 (CZ Characteristics)
- **Total CZs**: 741
- **Covariates**: 41 variables across 10 categories
- **Data sources**: 2000 Census, IRS tax records, NCES education data, etc.

### Sample Restriction
Following the paper's methodology:
- Filter to CZs with at least 250 children in the core sample
- Ensures reliable mobility estimates
- Drops small rural CZs with high sampling error

---

## Interpretation of Results

### Standardized Coefficients

Since both X and Y are standardized (mean 0, SD 1):
- **|β| = 0.20**: A 1 SD increase in X → 0.20 SD change in mobility (weak-moderate)
- **|β| = 0.40**: Moderate-strong effect
- **|β| = 0.60**: Strong effect
- **|β| = 0.76**: Very strong effect (only single-parent households reaches this)

### Direction of Effects

**Negative coefficient = Lower mobility** (bad for children):
- Higher segregation → lower mobility (β ≈ -0.40)
- Higher inequality → lower mobility (β ≈ -0.45)
- More single-parent households → **much lower mobility** (β ≈ -0.64)

**Positive coefficient = Higher mobility** (good for children):
- Better test scores → higher mobility (β ≈ +0.32)
- More social capital → higher mobility (β ≈ +0.33)
- Larger middle class → higher mobility (β ≈ +0.45)

---

## Console Output Format

Results are printed as:
```
[OK] Racial.Segregation  b=0.406  p_class=0.000  p_perm=0.000*
```

| Symbol | Description |
|--------|-------------|
| `[OK]` | Classical and permutation methods agree on significance |
| `[X]` | Methods disagree on significance |
| `b` | Standardized regression coefficient (= Pearson r) |
| `p_class` | p-value from classical OLS t-test |
| `p_perm` | p-value from permutation regression test |
| `*` | Statistically significant at α = 0.05 |

---

## Running the Analysis

### Prerequisites
```r
# Core packages (required)
install.packages(c("tidyverse", "broom"))
```

### Execution
```r
# Set working directory to R_code folder
setwd("path/to/R_code")

# Knit the RMarkdown file
rmarkdown::render("mobility_analysis.Rmd")
```

### Expected Runtime
- **Classical OLS**: ~1 minute
- **Permutation tests**: ~5-10 minutes (10,000 permutations × 35 covariates)
- **Total**: ~6-11 minutes

### Outputs

All files saved to `R_code/output/`:

1. **mobility_test_results.csv**: Comprehensive results table
   - Columns: category, covariate, n_obs, beta, se, t_stat
   - Classical: p_classical, classical_sig
   - Permutation: p_perm, perm_sig
   - Agreement: agree

2. **coefficient_plot.png**: Forest plot visualization
   - Shows standardized β ± 1.96×SE for all covariates
   - Color-coded by significance agreement:
     - Green: Both methods significant
     - Gray: Neither significant
     - Red: Disagreement

3. **mobility_analysis_workspace.RData**: R workspace for further analysis

---

## Expected Results

### Strong Effects (Should Agree)
- **Fraction single-parent households**: β ≈ 0.64, both p < 0.001
- **Social capital index**: β ≈ -0.33, both p < 0.001
- **Gini coefficient**: β ≈ 0.35, both p < 0.001

### Non-Significant Effects (Should Agree)
- **Top 1% income share**: β ≈ 0.02, both p > 0.05
- **Teacher-student ratio**: β ≈ 0.01, both p > 0.05
- **College graduation rate**: β ≈ -0.03, both p > 0.05

### Interpretation of Disagreements

If disagreements occur:
1. **Near the 0.05 boundary**: Normal statistical variation
2. **Permutation more conservative**: Suggests heteroskedasticity or non-normality
3. **Permutation more liberal**: Unusual, may indicate coding issue

---

## References

1. **Main Paper**: Chetty, R., Hendren, N., Kline, P., & Saez, E. (2014). Where is the Land of Opportunity? The Geography of Intergenerational Mobility in the United States. *Quarterly Journal of Economics*, 129(4), 1553-1623.

2. **Permutation Tests**: DiCiccio, C. J., & Romano, J. P. (2017). Robust Permutation Tests For Correlation And Regression Coefficients. *Journal of the American Statistical Association*, 112(519), 1211-1220.

3. **Implementation**: Jaimes, A. (2025). Where is the Land of Opportunity Replication.

4. **Online Data Tables**: Available at https://opportunityinsights.org/data/
