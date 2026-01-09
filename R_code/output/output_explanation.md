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
| p_perk | p-value from perk permutation correlation test |
| perk_sig | TRUE if perk significant (p_perk < 0.05) |
| p_perm_reg | p-value from DiCiccio & Romano permutation regression test |
| perm_reg_sig | TRUE if permutation regression significant (p_perm_reg < 0.05) |
| all_agree | TRUE if all three methods reach the same significance conclusion |

---

## Methods Compared

| Method | Test Statistic | Source |
|--------|----------------|--------|
| **Classical OLS** | t = β̂/SE(β̂) | Standard regression inference |
| **perk** | Pearson r | `perk` R package (permutation correlation) |
| **Permutation Regression** | Wald statistic Sₙ (heteroskedasticity-robust) | DiCiccio & Romano (2017) Theorem 3.2 |

---

## The Comparison Structure

```
                    Classical OLS (Chetty et al.'s original method)
                                    ↑
                         Compare significance
                           ↗              ↖
            perk (perm correlation)    DiCiccio & Romano (perm regression)
```

### Why Compare to Classical OLS?

Classical OLS is what Chetty et al. used. We're checking whether their findings are **robust** — would they have reached the same conclusions using permutation methods that don't rely on normality assumptions?

### Why Two Permutation Methods?

Both test the **same null hypothesis** (H₀: no relationship), but use **different test statistics**:

| Test | Test Statistic | Properties |
|------|----------------|------------|
| perk | Pearson r | Simple, not studentized |
| DiCiccio & Romano | Robust Wald Sₙ | Studentized, heteroskedasticity-robust |

| If... | Then... |
|-------|---------|
| All three agree | Very strong evidence the findings are robust |
| Classical ≠ permutation | Normality assumption might be affecting conclusions |
| perk ≠ DiCiccio & Romano | Heteroskedasticity might be an issue |

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
- **100% agreement** between all three methods

### Strongest Predictors (highest |β|)
1. Fraction Single Mothers (β = 0.64)
2. Fraction Black (β = 0.63)
3. Gini Bottom 99% (β = 0.47)

### Non-Significant Covariates (all three methods agree p > 0.05)
1. Top 1% Income Share (p ≈ 0.62)
2. Teacher-Student Ratio (p ≈ 0.81)
3. College Graduation Rate (p ≈ 0.55)

---

## A Note on P-Values

A p-value greater than 0.05 **never** leads to rejecting the null hypothesis when using α = 0.05.

- "Fail to reject" ≠ "accept the null" or "prove no effect"
- It means the data aren't sufficiently improbable under H₀

We use α = 0.05 without multiple testing correction, consistent with Chetty et al.'s original analysis.
