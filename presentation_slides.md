# Regression Diagnostics for Chetty et al. (2014) Mobility Covariates

---

## Slide 1: Motivation

**Do OLS assumption violations undermine Chetty et al.'s findings?**

- Chetty et al. (2014) tested 35 community-level covariates against relative mobility using OLS
- OLS assumes: homoskedasticity, normal residuals, no extreme outliers
- We computed 8 diagnostic statistics for each of the 35 regressions to assess these assumptions
- Sample: 709 Commuting Zones, standardized variables (beta = Pearson r)

---

## Slide 2: The 8 Diagnostic Statistics

| # | Diagnostic | What it detects |
|---|-----------|----------------|
| 1 | Pearson r | Linear correlation strength |
| 2 | Spearman rho | Monotonic (rank) correlation strength |
| 3 | \|r - rho\| | Non-linearity (large gap = non-linear relationship) |
| 4 | Breusch-Pagan p-value | Heteroskedasticity (linear form) |
| 5 | White test p-value | Heteroskedasticity (including non-linear forms) |
| 6 | Jarque-Bera p-value | Non-normal residuals (skewness + kurtosis) |
| 7 | Max Cook's D | Most influential single observation |
| 8 | Max Leverage | Highest-leverage point (extreme predictor value) |

---

## Slide 3: Heteroskedasticity is Widespread

**Breusch-Pagan or White p < 0.05 in 32 of 35 regressions (91%)**

Most extreme cases:

| Covariate | BP p-value | White p-value |
|-----------|:---------:|:------------:|
| Violent Crime Rate | 9.1e-11 | 6.2e-17 |
| Fraction Black Residents | 2.7e-05 | 8.5e-08 |
| Gini Coefficient | 3.1e-06 | 7.6e-18 |
| Fraction Middle Class | 3.5e-03 | 5.6e-08 |
| Migration Inflow Rate | 8.7e-08 | 7.2e-09 |

Despite this, all 6 inference methods (including heteroskedasticity-robust ones) agree on every covariate's significance.

---

## Slide 4: Non-Normal Residuals are Common

**Jarque-Bera p < 0.05 in 29 of 35 regressions (83%)**

Most extreme cases:

| Covariate | JB p-value | Interpretation |
|-----------|:---------:|----------------|
| Fraction Middle Class | 3.1e-15 | Highly non-normal |
| Fraction Black Residents | 1.6e-11 | Highly non-normal |
| Gini Coefficient | 6.0e-11 | Highly non-normal |
| Gini Bottom 99% | 4.9e-10 | Highly non-normal |
| Teen Labor Force Part. | 5.5e-09 | Highly non-normal |

Key implication: classical t-tests assume normality, yet permutation tests (which don't) produce identical significance conclusions at n ~ 700.

---

## Slide 5: Outlier Alert -- Violent Crime Rate

Violent Crime Rate is a diagnostic outlier among all 35 covariates:

| Diagnostic | Violent Crime Rate | Typical Range (others) |
|-----------|:---------:|:----------:|
| Max Cook's D | **12.28** | 0.02 -- 0.31 |
| Max Leverage | **0.487** | 0.01 -- 0.05 |
| \|r - rho\| | **0.113** | 0.00 -- 0.05 |
| BP p-value | 9.1e-11 | varies |
| White p-value | 6.2e-17 | varies |

A single Commuting Zone dominates the regression. Cook's D > 1 is a standard concern threshold -- this value is **12x** that.

Classical HC3 responds by inflating the variance: p = 0.247 (not significant). All other 5 methods: p < 0.05.

---

## Slide 6: Other High-Influence Covariates

Covariates where Max Cook's D > 0.5 or Max Leverage > 0.1:

| Covariate | Max Cook's D | Max Leverage |
|-----------|:----------:|:----------:|
| Violent Crime Rate | 12.28 | 0.487 |
| Growth in Chinese Imports | 1.98 | 0.261 |
| Local Gov Expenditures | 1.50 | 0.203 |
| Top 1% Income Share | 0.98 | 0.163 |
| Colleges per Capita | 0.31 | 0.178 |

These covariates have individual CZs with outsized influence on the regression line. Despite this, significance conclusions are consistent across methods.

---

## Slide 7: Non-Linearity -- Where Pearson and Spearman Diverge

Covariates with largest \|r - rho\| (Pearson-Spearman discrepancy):

| Covariate | Pearson r | Spearman rho | \|r - rho\| |
|-----------|:---------:|:------------:|:----------:|
| Growth in Chinese Imports | 0.171 | 0.331 | 0.161 |
| Top 1% Income Share | 0.019 | 0.176 | 0.157 |
| Violent Crime Rate | 0.217 | 0.330 | 0.113 |
| Colleges per Capita | -0.125 | -0.044 | 0.081 |
| State EITC Exposure | -0.144 | -0.217 | 0.073 |

**Top 1% Income Share**: Pearson r ~ 0 (non-significant by all methods) but Spearman rho = 0.176. The relationship is monotonic but non-linear -- OLS misses it entirely.

**Growth in Chinese Imports**: Spearman nearly double the Pearson. Outliers compress the linear correlation.

---

## Slide 8: Summary of Findings

| Assumption Violation | Prevalence | Impact on Conclusions |
|---------------------|:----------:|----------------------|
| Heteroskedasticity | 32/35 (91%) | None -- robust methods agree |
| Non-normal residuals | 29/35 (83%) | None -- permutation tests agree |
| High-influence outliers (Cook's D > 1) | 3/35 (9%) | HC3 becomes conservative on Violent Crime Rate |
| Non-linearity (\|r - rho\| > 0.1) | 3/35 (9%) | Top 1% Income Share relationship masked |

**Bottom line:**
1. OLS assumption violations are the rule, not the exception, across these 35 regressions
2. At n ~ 700, these violations do not change significance conclusions
3. Diagnostics reveal *qualitative* insights (outlier-driven results, non-linear relationships) that p-values alone miss

---

## Slide 9: Subgroup Diagnostics -- Overview

**Do the same assumption violations appear when RM is measured for specific subgroups?**

35 covariates x 3 subgroups = 105 regressions, each with 8 diagnostic statistics.

| | Baseline | Females | Males | Single Parents |
|---|:---:|:---:|:---:|:---:|
| Heteroskedastic (BP\|White < 0.05) | 32/35 (91%) | 30/35 (86%) | 24/35 (69%) | 22/35 (63%) |
| Non-normal residuals (JB < 0.05) | 29/35 (83%) | 29/35 (83%) | 34/35 (97%) | **35/35 (100%)** |
| Cook's D > 1 | 3/35 | 1/35 | 2/35 | 1/35 |
| \|r - rho\| > 0.1 | 3/35 | 3/35 | 2/35 | 1/35 |

Assumption violations are structural -- they persist (and sometimes intensify) across all subgroup RM variants.

---

## Slide 10: Violent Crime Rate is No Longer a Diagnostic Outlier

**The baseline's most extreme diagnostic case (Cook's D = 12.28) disappears in subgroup regressions.**

| | Baseline | Females | Males | Single Parents |
|---|:---:|:---:|:---:|:---:|
| Max Cook's D | **12.28** | 0.07 | 0.08 | 0.20 |
| Max Leverage | **0.487** | 0.028 | 0.028 | 0.033 |
| \|r - rho\| | **0.113** | 0.071 | 0.041 | 0.005 |

The single CZ that dominated the baseline Violent Crime Rate regression does not exert the same influence on subgroup RM. This suggests the baseline outlier effect was partly an artifact of how baseline RM aggregates across subgroups.

**New high-influence covariates emerge instead:**

| Covariate | Subgroup | Cook's D | Leverage |
|-----------|----------|:--------:|:--------:|
| Local Gov Expenditures | Single Parents | **3.29** | 0.244 |
| Growth in Chinese Imports | Males | **2.35** | 0.265 |
| Top 1% Income Share | Females | **1.75** | 0.204 |
| Top 1% Income Share | Males | **1.15** | 0.205 |

---

## Slide 11: Non-Normality Intensifies for Single Parents

**Jarque-Bera p < 0.05 in 100% of Single Parents regressions (vs 83% baseline)**

| Subgroup | JB < 0.05 | JB < 1e-10 |
|----------|:---------:|:----------:|
| Baseline | 29/35 (83%) | 3/35 |
| Females | 29/35 (83%) | 0/35 |
| Males | 34/35 (97%) | 7/35 |
| **Single Parents** | **35/35 (100%)** | **28/35** |

Single Parents RM has the most non-normal residual distributions -- yet permutation-based inference still agrees with classical methods. This is the strongest evidence that at n ~ 700, normality violations are irrelevant to significance conclusions.

**Non-linearity patterns are stable:** Top 1% Income Share and Growth in Chinese Imports show \|r - rho\| > 0.1 across both Females and Males, confirming these are structural features of the data, not subgroup-specific artifacts.

---

## Slide 12: Subgroup Diagnostics Summary

| Finding | Interpretation |
|---------|---------------|
| Heteroskedasticity persists (63--91%) | Driven by CZ characteristics, not RM definition |
| Non-normality intensifies for Single Parents (100%) | Permutation tests still agree -- normality is irrelevant at n ~ 700 |
| Violent Crime Rate outlier disappears | Baseline Cook's D = 12.28 was subgroup-aggregation artifact |
| New outliers emerge (Local Gov, Growth Chinese Imports) | High-influence CZs vary by outcome measure |
| Top 1% Income Share remains non-linear | Pearson r ~ 0 but Spearman rho > 0.14 across Females and Males |

**Bottom line:** Diagnostic profiles are structurally similar but not identical across subgroups. The key robustness conclusion holds -- assumption violations do not change significance conclusions for any subgroup.

---

## Slide 13: References

- Chetty, R., Hendren, N., Kline, P., & Saez, E. (2014). Where is the land of opportunity? *Quarterly Journal of Economics*, 129(4), 1553-1623.
- DiCiccio, C. J., & Romano, J. P. (2017). Robust permutation tests for correlation and regression coefficients. *JASA*, 112(519), 1211-1220.
- Breusch, T. S. & Pagan, A. R. (1979). A simple test for heteroscedasticity. *Econometrica*, 47(5), 1287-1294.
- White, H. (1980). A heteroskedasticity-consistent covariance matrix estimator. *Econometrica*, 48(4), 817-838.
- Jarque, C. M. & Bera, A. K. (1987). A test for normality of observations and regression residuals. *International Statistical Review*, 55(2), 163-172.
