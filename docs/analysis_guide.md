# Analysis Guide: Replicating Chetty et al. (2014) with Permutation Inference

## Overview

This analysis replicates key findings from **"Where is the Land of Opportunity? The Geography of Intergenerational Mobility in the United States"** by Chetty et al. (2014), then compares classical inference with permutation-based inference methods.

**Six methods are compared:**

### Non-Permutation Methods (4)
| Method | Test Statistic | Source |
|--------|----------------|--------|
| **cor.test** | Pearson r | R's `cor.test()` function |
| **summary(lm)** | t = β̂/SE(β̂) | Chetty et al. (2014) original approach |
| **waldtest HC0** | Wald F | `lmtest::waldtest()` with `sandwich::vcovHC(type="HC0")` |
| **waldtest HC3** | Wald F | `lmtest::waldtest()` with `sandwich::vcovHC(type="HC3")` |

### Permutation Methods (2)
| Method | Test Statistic | Source |
|--------|----------------|--------|
| **perk** | Pearson r | `perk` R package |
| **perm_test_regression** | Robust Wald Sₙ | DiCiccio & Romano (2017) Theorem 3.2 |

---

## The Goal: Comparing Methods

The structure of our comparison:

```
┌─────────────────────────────────────────────────────────────┐
│                    NON-PERMUTATION                          │
│  cor.test ──┬── summary(lm) ──┬── waldtest HC0/HC3         │
└─────────────┼─────────────────┼─────────────────────────────┘
              │   Compare       │
              │  significance   │
┌─────────────┼─────────────────┼─────────────────────────────┐
│             │   PERMUTATION   │                             │
│           perk            perm_test_regression              │
└─────────────────────────────────────────────────────────────┘
```

**The question being answered:**

> "Do we reach the same conclusions about which covariates significantly predict mobility using different inference methods?"

**Why multiple non-permutation methods?**

- **cor.test vs summary(lm)**: Should give identical p-values for standardized data (verification)
- **waldtest HC0/HC3**: Account for heteroskedasticity without permutation
- Allows us to ask: "Does heteroskedasticity correction alone change conclusions?"

**Why permutation methods?**

- Test whether asymptotic assumptions affect conclusions
- Provide exact p-values under the null

**What agreement tells us:**

| If... | Then... |
|-------|---------|
| All six agree | Very strong evidence the findings are robust |
| Non-perm ≠ permutation | Distributional assumptions might be affecting conclusions |
| summary(lm) ≠ waldtest | Heteroskedasticity is present |
| perk ≠ perm_test_regression | Heteroskedasticity affects permutation inference too |

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

---

## The Six Methods Explained

### Non-Permutation Methods

#### Method 1: cor.test (Classical Correlation)

R's built-in `cor.test()` function tests H₀: ρ = 0 using a t-test.

- **Test statistic**: t = r√(n-2)/√(1-r²)
- **Assumption**: Bivariate normality
- **Implementation**: `cor.test(x, y, method = "pearson")`

#### Method 2: summary(lm) (Classical OLS)

Chetty et al.'s original approach. For each covariate X:

$$\text{Relative Mobility}_i = \alpha + \beta X_i + \epsilon_i$$

where both Y and X are standardized (mean 0, SD 1). The standardized coefficient β equals the Pearson correlation r.

- **Test statistic**: t = β̂/SE(β̂)
- **Assumption**: ε ~ N(0, σ²) (homoskedasticity)
- **Implementation**: `summary(lm(y ~ x))`

**Note**: For standardized data, cor.test and summary(lm) give identical p-values.

#### Method 3: waldtest HC0 (Heteroskedasticity-Robust)

Uses the Wald test with HC0 (White's) robust standard errors:

- **Test statistic**: Wald F with robust variance
- **Assumption**: None about error variance
- **Implementation**: `waldtest(fit, vcov = vcovHC(fit, type = "HC0"))`

#### Method 4: waldtest HC3 (Small-Sample Robust)

Uses HC3 robust standard errors with a small-sample correction:

- **Test statistic**: Wald F with HC3 variance
- **Assumption**: More conservative than HC0
- **Implementation**: `waldtest(fit, vcov = vcovHC(fit, type = "HC3"))`

### Permutation Methods

#### Method 5: perk (Permutation Correlation)

The `perk` package implements permutation tests for Pearson correlation:

1. Compute the observed correlation r between X and Y
2. Permute Y values 10,000 times to generate null distribution
3. p-value = proportion of permuted |r*| ≥ |r_obs|

- **Test statistic**: Pearson r (simple, not studentized)
- **Assumption**: None (permutation-based)
- **Implementation**: `perk::perk_test()` function

#### Method 6: perm_test_regression (DiCiccio & Romano)

The permutation regression test uses a heteroskedasticity-robust Wald statistic:

$$S_n = n \hat{\beta}^T \left( \hat{\Sigma}_{XX}^{-1} \hat{\Omega} \hat{\Sigma}_{XX}^{-1} \right) \hat{\beta}$$

where Ω̂ is the HC0 robust covariance estimator. The test:

1. Computes Sₙ from the observed data
2. Permutes Y values 10,000 times to generate null distribution
3. p-value = proportion of permuted Sₙ* ≥ Sₙ_obs

- **Test statistic**: Robust Wald statistic (studentized, heteroskedasticity-robust)
- **Assumption**: None (permutation-based)
- **Implementation**: Custom `perm_test_regression()` function

### Why Multiple Methods?

**Correlation tests** (cor.test vs perk):
- Both test H₀: ρ = 0 using Pearson r
- cor.test uses asymptotic t-distribution
- perk uses permutation distribution
- If they agree → normality assumption is fine

**Regression tests** (summary(lm) vs waldtest vs perm_test_regression):
- All test H₀: β = 0
- summary(lm) assumes homoskedasticity
- waldtest HC0/HC3 corrects for heteroskedasticity
- perm_test_regression uses permutation + robust variance

**Key insight**: For standardized data, r = β̂. But p-values may differ due to:
- Heteroskedasticity (waldtest catches this)
- Non-normality (permutation catches this)

If all six agree → findings are very robust!

---

## Why Replicate Table VIII?

We chose to replicate Online Appendix Table VIII because it represents the core empirical contribution of Chetty et al. (2014): identifying which community-level characteristics are associated with intergenerational mobility.

- **Tables 1-7**: Computed from restricted IRS data (cannot be reproduced)
- **Table VIII**: Uses published mobility estimates + public covariates (reproducible!)

This is where the key policy findings come from:
- Single-parent household rates as "the single strongest correlate of upward income mobility"
- Links between segregation, inequality, social capital and children's economic outcomes

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

## Methods Comparison Summary

| Method | Type | Test Statistic | Handles Heteroskedasticity? |
|--------|------|----------------|----------------------------|
| **cor.test** | Non-perm | Pearson r | No |
| **summary(lm)** | Non-perm | t = β̂/SE(β̂) | No |
| **waldtest HC0** | Non-perm | Wald F | Yes (White's) |
| **waldtest HC3** | Non-perm | Wald F | Yes (small-sample) |
| **perk** | Permutation | Pearson r | No |
| **perm_test_regression** | Permutation | Robust Wald Sₙ | Yes (robust variance) |

**Expected agreement**:
- Strong effects (|r| > 0.3): All six methods should agree
- Weak effects (|r| < 0.1): All six methods should agree (not significant)
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
[OK] Racial.Segregation  b=0.406  p_class=0.000  p_perk=0.000  p_reg=0.000*
```

| Symbol | Description |
|--------|-------------|
| `[OK]` | All six methods agree on significance |
| `[X]` | At least one method disagrees |
| `b` | Standardized regression coefficient (= Pearson r) |
| `p_class` | p-value from summary(lm) |
| `p_cor_test` | p-value from cor.test |
| `p_waldtest_hc0` | p-value from waldtest with HC0 |
| `p_waldtest_hc3` | p-value from waldtest with HC3 |
| `p_perk` | p-value from perk permutation correlation |
| `p_perm_reg` | p-value from DiCiccio & Romano permutation regression |
| `*` | Statistically significant at α = 0.05 |

---

## Running the Analysis

### Prerequisites
```r
# Core packages (required)
install.packages(c("tidyverse", "broom", "perk", "sandwich", "lmtest"))
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
- **Permutation tests**: ~10-15 minutes (10,000 permutations × 35 covariates × 2 methods)
- **Total**: ~11-16 minutes

### Outputs

All files saved to `R_code/output/`:

1. **mobility_test_results.csv**: Comprehensive results table
   - Columns: category, covariate, n_obs, beta, se, t_stat
   - Non-permutation: p_classical, p_cor_test, p_waldtest_hc0, p_waldtest_hc3
   - Permutation: p_perk, p_perm_reg
   - Significance flags: classical_sig, perk_sig, perm_reg_sig
   - Agreement: all_agree

2. **coefficient_plot.png**: Forest plot visualization
   - Shows standardized β ± 1.96×SE for all covariates
   - Color-coded by significance agreement:
     - Green: All six methods significant
     - Gray: None significant
     - Red: Disagreement

3. **mobility_analysis_workspace.RData**: R workspace for further analysis

---

## Expected Results

### Strong Effects (All Six Should Agree)
- **Fraction single-parent households**: β ≈ 0.64, all p < 0.001
- **Social capital index**: β ≈ -0.33, all p < 0.001
- **Gini coefficient**: β ≈ 0.35, all p < 0.001

### Non-Significant Effects (All Six Should Agree)
- **Top 1% income share**: β ≈ 0.02, all p > 0.05
- **Teacher-student ratio**: β ≈ 0.01, all p > 0.05
- **College graduation rate**: β ≈ -0.03, all p > 0.05

### Interpretation of Disagreements

If disagreements occur:
1. **Near the 0.05 boundary**: Normal statistical variation
2. **summary(lm) ≠ waldtest**: Heteroskedasticity is present
3. **cor.test ≠ perk**: Permutation changes correlation inference
4. **waldtest ≠ perm_test_regression**: Permutation vs asymptotic difference
5. **Non-perm ≠ permutation**: Distributional assumptions are problematic

---

## A Note on P-Values

A p-value greater than 0.05 **never** leads to rejecting the null hypothesis when using α = 0.05. By definition, we reject H₀ only when p < α.

- "Fail to reject" ≠ "accept the null" or "prove no effect"
- It means the data aren't sufficiently improbable under H₀

**Important clarifications**:
- Different α levels change the threshold (α = 0.10 → p = 0.07 would reject)
- Multiple testing corrections make rejection more stringent
- We use α = 0.05 without correction, consistent with Chetty et al.

---

## References

1. **Main Paper**: Chetty, R., Hendren, N., Kline, P., & Saez, E. (2014). Where is the Land of Opportunity? The Geography of Intergenerational Mobility in the United States. *Quarterly Journal of Economics*, 129(4), 1553-1623.

2. **Permutation Tests**: DiCiccio, C. J., & Romano, J. P. (2017). Robust Permutation Tests For Correlation And Regression Coefficients. *Journal of the American Statistical Association*, 112(519), 1211-1220.

3. **Implementation**: Jaimes, A. (2025). Where is the Land of Opportunity Replication.

4. **perk Package**: Permutation tests for correlation coefficients. Available on CRAN.

5. **sandwich Package**: Robust covariance matrix estimators. Used for `vcovHC()`.

6. **lmtest Package**: Testing linear regression models. Used for `waldtest()`.

7. **Online Data Tables**: Available at https://opportunityinsights.org/data/
