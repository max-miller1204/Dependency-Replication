# Output Explanation: mobility_test_results.csv

## Column Descriptions

| Column | Description |
|--------|-------------|
| category | Thematic grouping (Race, Segregation, Income Distribution, K-12 Education, Social Capital, Family Structure, Tax, College, Local Labor Market, Migration) |
| covariate | Predictor variable name (e.g., "Racial Segregation", "Gini Coefficient") |
| n_obs | Number of CZs used after removing missing values |
| beta | Standardized regression coefficient (= Pearson r when both X and Y are standardized) |
| se | Standard error of the regression coefficient |
| t_stat | t-statistic from regression (β/SE) |
| **Non-Permutation P-Values** | |
| p_classical | p-value from summary(lm) - classical OLS t-test |
| p_cor_test | p-value from cor.test - classical correlation t-test |
| p_waldtest_hc0 | p-value from waldtest with HC0 robust standard errors |
| p_waldtest_hc3 | p-value from waldtest with HC3 robust standard errors |
| **Permutation P-Values** | |
| p_perk | p-value from perk permutation correlation test |
| p_perm_reg | p-value from DiCiccio & Romano permutation regression test |
| **Significance Flags** | |
| classical_sig | TRUE if summary(lm) significant (p_classical < 0.05) |
| perk_sig | TRUE if perk significant (p_perk < 0.05) |
| perm_reg_sig | TRUE if permutation regression significant (p_perm_reg < 0.05) |
| all_agree | TRUE if all six methods reach the same significance conclusion |

---

## Methods Compared

### Non-Permutation Methods (4)
| Method | Test Statistic | Properties |
|--------|----------------|------------|
| **cor.test** | Pearson r | Classical correlation t-test |
| **summary(lm)** | t = β̂/SE(β̂) | Classical OLS (Chetty et al. approach) |
| **waldtest HC0** | Wald F | Heteroskedasticity-robust (White's) |
| **waldtest HC3** | Wald F | HC-robust with small-sample correction |

### Permutation Methods (2)
| Method | Test Statistic | Properties |
|--------|----------------|------------|
| **perk** | Pearson r | Permutation correlation test |
| **perm_test_regression** | Robust Wald Sₙ | DiCiccio & Romano (2017) Theorem 3.2 |

---

## The Comparison Structure

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

### Why Six Methods?

| If... | Then... |
|-------|---------|
| All six agree | Very strong evidence the findings are robust |
| Non-perm ≠ permutation | Distributional assumptions might be affecting conclusions |
| cor.test ≠ perk | Permutation changes correlation inference |
| summary(lm) ≠ waldtest | Heteroskedasticity is present |
| waldtest ≠ perm_test_regression | Permutation vs asymptotic difference |

---

## Interpreting Results

### Significance
- **p < 0.05**: Statistically significant association with mobility
- **p ≥ 0.05**: No significant association detected

### Coefficient Direction
- **Positive β**: Higher values of covariate → lower mobility (worse for children)
- **Negative β**: Higher values of covariate → higher mobility (better for children)

Note: The sign depends on how relative mobility is coded. In this analysis, higher relative mobility values indicate less mobility (stronger parent-child income correlation).

### Effect Size
Since both X and Y are standardized:
- |β| = 0.20: Weak-moderate effect
- |β| = 0.40: Moderate-strong effect
- |β| = 0.60: Strong effect

---

## Key Findings

- **35 covariates** tested across 10 categories
- **32/35 (91.4%)** significantly associated with relative mobility
- **100% agreement** between all six methods

### Strongest Predictors (highest |β|)
1. Fraction Single Mothers (β = 0.64)
2. Fraction Black (β = 0.63)
3. Gini Bottom 99% (β = 0.47)

### Non-Significant Covariates (all six methods agree p > 0.05)
1. Top 1% Income Share (p ≈ 0.62)
2. Teacher-Student Ratio (p ≈ 0.81)
3. College Graduation Rate (p ≈ 0.55)

---

## A Note on P-Values

A p-value greater than 0.05 **never** leads to rejecting the null hypothesis when using α = 0.05.

- "Fail to reject" ≠ "accept the null" or "prove no effect"
- It means the data aren't sufficiently improbable under H₀

We use α = 0.05 without multiple testing correction, consistent with Chetty et al.'s original analysis.
