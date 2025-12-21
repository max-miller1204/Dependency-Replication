# Analysis Guide: Classical vs Permutation Testing for Relative Mobility

## Overview

This analysis replicates key findings from **"Where is the Land of Opportunity? The Geography of Intergenerational Mobility in the United States"** by Chetty et al., comparing classical OLS inference with permutation-based inference.

The analysis implements a **two-phase approach** that tests both **correlation** and **regression** methods:
- **Phase 1**: Replicate classical results (validate correlation = regression for standardized variables)
- **Phase 2**: Add permutation tests (compare to classical)

This demonstrates that:
1. When variables are standardized, correlation and regression tests are mathematically equivalent
2. Permutation methods provide robust inference even when classical assumptions are violated

## Why These Specific Results Were Chosen

### 1. **Focus on Relative Mobility (Rank-Rank Slope)**

**What it is**: The Pearson correlation between parent income rank and child income rank within each Commuting Zone (CZ).

**Why it matters**:
- Pretty much we're using tables 5 and 8 to replicate "Online Appendix Table 8". 
- The paper's primary measure of intergenerational mobility
- More robust than alternatives (IGE) according to Section II
- Scale-invariant and comparable across regions
- Values range from 0 (perfect mobility) to 1 (no mobility)
- The analysis tests whether CZ characteristics (Table 8) predict mobility outcomes (Table 5)
- The code uses CZ RM values (which vary around the 0.341 national average) as the dependent variable (Y).
- The independent variables (X) are the CZ characteristics being tested as predictors (ex: Does racial segregation predict lower mobility). 
- It tests what predicts variation in RM across commuting zones (segregation, inequality, education, family structure, and social capital).
- Each regression answers: "In CZs with higher values of X, is relative mobility higher or lower?" The standardized β coefficient shows the direction and strength of that relationship.

**Where referenced**:
- Introduced in Section II (PDF pp. 5-8)
- Main results in Section V and Online Appendix Table VIII
- National estimate: **0.341** (Table I, Row 4)

---

### 2. **Segregation Covariates** (Section VI.B)

#### Variables Tested:
1. **Racial Segregation** (Multi-group Theil Index)
2. **Income Segregation** (Rank-order index)
3. **Segregation of Poverty** (below 25th percentile)
4. **Segregation of Affluence** (above 75th percentile)

#### Why Chosen:
- **Paper finding**: "areas that are more residentially segregated by race and income have lower levels of mobility" (Abstract/Introduction)
- **Magnitude**: Racial segregation has correlation of **-0.361** (Online Appendix Table VIII)
- **Geographic variation**: Segregation is lowest in rural areas, highest in industrial cities

#### Where Referenced:
- **Main text**: Section VI.B (PDF pp. 34-36)
- **Figures**: Figure VIII (correlates summary), Online Appendix Figure X (scatter plots)
- **Tables**: Table IV, Online Appendix Table VIII

---

### 3. **Income Inequality Covariates** (Section VI.C)

#### Variables Tested:
1. **Gini Coefficient** (overall inequality)
2. **Top 1% Income Share**
3. **Gini Bottom 99%** (inequality excluding top 1%)
4. **Fraction Middle Class** (between p25-p75)

#### Why Chosen:
- **Paper finding**: "upward mobility is strongly positively correlated with the size of the middle class" (Section VI.C)
- **Magnitude**: Gini coefficient correlation of **-0.578** (strong negative); Top 1% share correlation of only **-0.190**
- **Decomposition**: The paper tests whether inequality at the top or bottom matters more

#### Where Referenced:
- **Main text**: Section VI.C (PDF pp. 36-38)
- **Figures**: Online Appendix Figure XI (scatter plots)
- **Tables**: Table V, Online Appendix Table VIII

---

### 4. **K-12 Education Covariates** (Section VI.D)

#### Variables Tested:
1. **School Expenditure per Student**
2. **Test Score Percentile** (income-adjusted)
3. **High School Dropout Rate** (income-adjusted)

#### Why Chosen:
- **Paper finding**: Income-adjusted test scores and dropout rates are "very highly correlated with upward mobility across all specifications" (Section VI.D)
- **Magnitude**: Test scores have correlation of **+0.588**; High school dropout rate has correlation of **-0.574**
- **Policy relevance**: Education is a key policy lever

#### Where Referenced:
- **Main text**: Section VI.D (PDF pp. 38-39)
- **Figures**: Figure VIII
- **Tables**: Online Appendix Table VIII

---

### 5. **Family Structure Covariates** (Section VI.F) - **MOST IMPORTANT**

#### Variables Tested:
1. **Fraction of Children in Single-Parent Households**
2. **Fraction of Adults Divorced**
3. **Fraction of Adults Married**

#### Why Chosen:
- **Paper finding**: **"The fraction of children living in single-parent households is the single strongest correlate of upward income mobility among all the variables we explored"** (Section VI.F)
- **Magnitude**: Fraction single-parent households has **correlation of -0.764** - by far the strongest correlation in the entire paper
- **Robustness**: This finding holds even when controlling for race, income, and other factors

#### Where Referenced:
- **Main text**: Section VI.F (PDF pp. 39-40) - **Emphasized as the most important finding**
- **Figures**: Figure VIII, Online Appendix Figure XII (scatter plot)
- **Tables**: Table VI, Online Appendix Table VIII

---

### 6. **Social Capital Covariates** (Section VI.E)

#### Variables Tested:
1. **Social Capital Index** (Rupasingha & Goetz 2008)
2. **Fraction Religious**
3. **Violent Crime Rate**

#### Why Chosen:
- **Paper finding**: "The correlation between upward mobility and social capital is 0.641 in our baseline specification" (Section VI.E)
- **Magnitude**: Social capital index has correlation of **+0.641** (strong positive); Religiosity has correlation of **+0.521**
- **Interpretation**: Measures community cohesion, trust, and civic engagement

#### Where Referenced:
- **Main text**: Section VI.E (PDF p. 39)
- **Figures**: Figure VIII
- **Tables**: Online Appendix Table VIII

---

## Correlation vs Regression: Why Test Both?

### The Mathematical Equivalence

When both X and Y are **standardized** (mean 0, SD 1):

**Correlation coefficient** (rho):
```
rho = Cov(X,Y) / (SD(X) * SD(Y)) = Cov(X,Y) / (1 * 1) = Cov(X,Y)
```

**Regression coefficient** (beta):
```
beta = Cov(X,Y) / Var(X) = Cov(X,Y) / 1 = Cov(X,Y)
```

**Therefore**: rho = beta when both variables are standardized!

### Why This Matters

1. **Validation**: If correlation does not equal regression, something is wrong with standardization
2. **Robustness check**: Both methods should give identical p-values
3. **Paper replication**: The paper uses regression framework, but relative mobility IS a correlation
4. **Permutation theory**: DiCiccio & Romano (2017) prove results for both approaches

### Methods in Our Analysis

| Method | Framework | Test Statistic | Null Hypothesis | Implementation |
|--------|-----------|----------------|-----------------|----------------|
| **1. Classical Correlation** | Pearson | t = r*sqrt(n-2)/sqrt(1-r^2) | H0: rho = 0 | `cor.test()` |
| **2. Classical Regression** | OLS | t = beta_hat/SE(beta_hat) | H0: beta = 0 | `lm()` |
| **3. Permutation Correlation** | Pearson | max(T*) from permutations | H0: rho = 0 | `perk_test()` (if available) |
| **4. Permutation Regression** | OLS | max(S*) from permutations | H0: beta = 0 | Custom function |

**Expected agreement**:
- Methods 1 & 2: 100% (mathematical equivalence)
- Methods 3 & 4: ~100% (should be equivalent in theory)
- Classical vs Permutation: 80-100% (depends on distributional assumptions)

---

## Why Classical vs Permutation Testing Matters

### The Problem with Classical Inference

1. **Spatial Correlation**: Nearby CZs may have correlated outcomes, violating the independence assumption of OLS
2. **Non-Normal Residuals**: Income data is often skewed
3. **Heteroskedasticity**: The variance of mobility may differ across CZs with different characteristics
4. **Multiple Testing**: The paper tests 30+ covariates, raising concerns about false discoveries

### What Permutation Testing Offers

From DiCiccio & Romano (2017):
- **No distributional assumptions**: Doesn't assume normality of residuals
- **Valid under dependence**: Asymptotically valid even if errors are correlated
- **Exact finite-sample validity**: Under certain conditions, provides exact p-values
- **Robust to outliers**: Less sensitive to extreme values

### Expected Findings

Based on statistical theory:

1. **High agreement for strong effects** (|correlation| > 0.5): Both tests should reject null
2. **Potential disagreement for moderate effects** (0.1 < |correlation| < 0.4): Permutation may be more conservative
3. **High agreement for non-significant effects**: Both should fail to reject

If permutation tests are systematically more conservative (higher p-values), this suggests:
- Classical standard errors are **underestimated** (t-statistics too large)
- Some significant results may be **false positives**
- Spatial correlation or heteroskedasticity is present

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

### Standardized Coefficients (correlation/beta)

Since both X and Y are standardized (mean 0, SD 1):
- **|r| = 0.20**: A 1 SD increase in X leads to 0.20 SD change in relative mobility (weak-moderate effect)
- **|r| = 0.40**: Moderate-strong effect
- **|r| = 0.60**: Strong effect
- **|r| = 0.76**: Very strong effect (only fraction single-parent households reaches this)

### Direction of Effects

**Negative correlation = Lower mobility** (bad for children):
- Higher segregation leads to lower mobility (r = -0.36)
- Higher inequality leads to lower mobility (r = -0.58)
- More single-parent households leads to **much lower mobility** (r = -0.76)

**Positive correlation = Higher mobility** (good for children):
- Better test scores leads to higher mobility (r = +0.59)
- More social capital leads to higher mobility (r = +0.64)
- Larger middle class leads to higher mobility (r = +0.68)

### Summary of Key Correlations from Online Appendix Table VIII

| Variable | Correlation with Upward Mobility |
|----------|----------------------------------|
| Fraction Single-Parent Households | **-0.764** |
| Fraction Middle Class | +0.679 |
| Social Capital Index | +0.641 |
| Test Score Percentile (adj.) | +0.588 |
| Gini Coefficient | -0.578 |
| High School Dropout Rate (adj.) | -0.574 |
| Fraction Religious | +0.521 |
| Income Segregation | -0.393 |
| Violent Crime Rate | -0.380 |
| Racial Segregation | -0.361 |
| Top 1% Income Share | -0.190 |

---

## Paper Context

### Full Citation
Chetty, Raj, Nathaniel Hendren, Patrick Kline, and Emmanuel Saez. 2014. "Where is the Land of Opportunity? The Geography of Intergenerational Mobility in the United States." *Quarterly Journal of Economics* 129(4): 1553-1623.

### Key Contributions
1. First comprehensive geographic analysis of intergenerational mobility in the U.S.
2. Identifies areas of high and low mobility (San Jose, CA has highest at 12.9%; Charlotte, NC has lowest at 4.4% for bottom-to-top quintile transition)
3. Shows variation within the U.S. is comparable to variation across developed countries
4. Identifies family structure as the strongest predictor

### Policy Implications
From the conclusion (Section VII):
- Local factors matter for mobility - place-based policies could help
- Reducing segregation may increase mobility
- Family structure is important, but hard to change via policy
- Education quality matters, especially for disadvantaged children

---

## Running the Analysis

### Prerequisites
```r
# Core packages (required)
install.packages(c("tidyverse", "broom"))

# Permutation test packages (optional but recommended)
install.packages("devtools")
devtools::install_github("hyu-ub/perk/perk")
install.packages("PermCor")
```

**Note**: Script will run without `perk` or `PermCor`, but only regression permutation tests will be performed. Correlation permutation tests require one of these packages.

### Execution
```r
# Set working directory to the Data folder
setwd("C:/Users/maxmi/DLQF/Dependency/Data")

# Run the analysis
source("R_code/mobility_analysis.R")
```

### Expected Runtime
- **Phase 1** (classical): ~1 minute
- **Phase 2** (permutation): ~5-10 minutes (10,000 permutations per covariate)
- **Total**: ~6-11 minutes

### Outputs

All files saved to `R_code/output/`:

1. **mobility_test_results.csv**: Comprehensive results table
   - Columns: category, covariate, n_obs
   - Classical correlation: cor_coefficient, cor_t_stat, cor_pval
   - Classical regression: reg_coefficient, reg_se, reg_t_stat, reg_pval
   - Permutation: perm_cor_pval, perm_reg_pval
   - Agreement: methods_agree, classical_sig, perm_cor_sig, perm_reg_sig, all_agree

2. **coefficient_plot.png**: Forest plot visualization
   - Shows standardized beta +/- 1.96*SE for all covariates
   - Color-coded by significance agreement:
     - Green: Both classical and permutation significant
     - Gray: Neither significant
     - Red: Disagreement between methods

3. **mobility_analysis_workspace.RData**: R workspace for further analysis
   - `phase1_results`: Classical correlation and regression results
   - `phase2_results`: All methods including permutation
   - `df`: Filtered data (n >= 250)
   - `covariates_to_test`: List of variables tested by category

---

## Expected Results

Based on the paper and statistical theory:

### Phase 1: Classical Methods Should Match
- **Correlation = Regression**: 100% agreement (all tests)
- **Coefficient equivalence**: |rho - beta| < 0.001 for all tests
- **P-value equivalence**: |p_cor - p_reg| < 0.001 for all tests

**If not 100%**: Check that variables are properly standardized with mean 0, SD 1

### Phase 2: High Agreement Expected (Strong Effects)
- **Fraction single-parent households**: r = -0.764, all methods p < 0.001
- **Social capital index**: r = +0.641, all methods p < 0.001
- **Test scores**: r = +0.588, all methods p < 0.001
- **Gini coefficient**: r = -0.578, all methods p < 0.001

### Phase 2: Potential Disagreements (Moderate Effects)
- **Top 1% income share**: r = -0.190, may show borderline significance
- **Violent crime**: r = -0.380, classical and permutation should agree
- **Variables near alpha = 0.05 boundary**: May show disagreement

### Interpretation of Disagreements

If permutation p-values are systematically higher than classical p-values:
1. **Spatial correlation**: Nearby CZs may have correlated residuals
2. **Heteroskedasticity**: Variance differs across CZ characteristics
3. **Non-normality**: Residuals are skewed or heavy-tailed
4. **False positives**: Some classical "significant" results may be spurious

If disagreements are rare (1-2 out of 15):
- Normal statistical variation
- Permutation p-values have Monte Carlo error (+/-0.01 typically)
- Not concerning unless systematic pattern

---

## References

1. **Main Paper**: Chetty, R., Hendren, N., Kline, P., & Saez, E. (2014). Where is the Land of Opportunity? The Geography of Intergenerational Mobility in the United States. *Quarterly Journal of Economics*, 129(4), 1553-1623.
2. **Permutation Tests**: DiCiccio, T. J., & Romano, J. P. (2017). Robust Permutation Tests For Correlation And Regression Coefficients. *Journal of the American Statistical Association*, 112(519), 1211-1220.
3. **R Package (perk)**: https://github.com/hyu-ub/perk
4. **Online Data Tables**: Available at https://opportunityinsights.org/data/

---

## Questions for Further Analysis

1. **Do disagreements cluster spatially?** Are CZs with disagreements located in specific regions?
2. **Does sample size matter?** Are disagreements more common in small CZs (n around 250)?
3. **Multivariate analysis**: How do results change when testing multiple covariates simultaneously?
4. **Clustering**: Should standard errors be clustered at the state level (as in the paper)?

---

## Contact

For questions about this analysis, refer to:
- **Paper**: https://opportunityinsights.org/paper/land-of-opportunity/
- **Replication code**: Included in this data package
- **Original authors**: Raj Chetty (Harvard), Nathaniel Hendren (MIT), Patrick Kline (Berkeley), Emmanuel Saez (Berkeley)
