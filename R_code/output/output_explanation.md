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
| p_classical | p-value from classical OLS t-test |
| classical_sig | TRUE if classically significant (p_classical < 0.05) |
| p_perm | p-value from permutation regression test (DiCiccio & Romano 2017) |
| perm_sig | TRUE if permutation significant (p_perm < 0.05) |
| agree | TRUE if classical and permutation tests reach the same significance conclusion |

---

## Methods Compared

| Method | Test Statistic | Source |
|--------|----------------|--------|
| **Classical OLS** | t = β̂/SE(β̂) | Standard regression inference |
| **Permutation Regression** | Wald statistic Sn (heteroskedasticity-robust) | DiCiccio & Romano (2017) Theorem 3.2 |

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
- **100% agreement** between classical and permutation methods

### Strongest Predictors (highest |β|)
1. Fraction Single Mothers (β = 0.64)
2. Fraction Black (β = 0.63)
3. Gini Bottom 99% (β = 0.47)

### Non-Significant Covariates
1. Top 1% Income Share (p ≈ 0.62)
2. Teacher-Student Ratio (p ≈ 0.81)
3. College Graduation Rate (p ≈ 0.55)
