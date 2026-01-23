# Why Replicate Table VIII?

## Motivation for Choosing Table VIII

We chose to replicate Online Appendix Table VIII because it represents the core empirical contribution of Chetty et al. (2014): identifying which community-level characteristics are associated with intergenerational mobility.

### Data Availability

| Tables | Source | Reproducible? |
|--------|--------|---------------|
| **Tables 1-7** | Restricted IRS tax records | No - requires data access agreement |
| **Table VIII** | Published mobility estimates + public covariates | **Yes** - fully reproducible! |

Table VIII's correlational analysis uses:
- **Dependent variable**: Published mobility estimates from Table 5
- **Independent variables**: Public data from Table 8 (Census, education databases, etc.)

### Substantive Importance

This is where the key policy findings come from:

- **"The fraction of children living in single-parent households is the single strongest correlate of upward income mobility among all the variables we explored"** (Chetty et al., 2014, p. 1594)
- Links between segregation, inequality, and children's economic outcomes
- Social capital's strong association with mobility

Policy discussions citing this paper typically draw on Table VIII's findings, making it essential to verify these correlations are robust to alternative statistical methods.

---

## The Comparison: Classical vs Permutation Inference

### Structure

```
                    Classical OLS (Chetty et al.'s original method)
                                    ↑
                         Compare significance
                           ↗              ↖
            perk (perm correlation)    DiCiccio & Romano (perm regression)
```

### Why Compare to Classical OLS?

Classical OLS is what Chetty et al. used. It's the published result. We're checking whether their findings are **robust** — would they have reached the same conclusions using permutation methods that don't rely on normality assumptions?

### Why Two Permutation Methods?

Both test the **same null hypothesis** (H₀: no relationship between X and Y), but use **different test statistics**:

| Test | Test Statistic | Properties |
|------|----------------|------------|
| **perk** | Pearson r | Simple, not studentized |
| **DiCiccio & Romano** | Robust Wald Sₙ | Studentized, heteroskedasticity-robust |

**Key insight**: For standardized data, r = β̂ (same number!). But Sₙ ≠ r² because Sₙ uses a **robust variance estimator** that adjusts for non-constant error variance.

Comparing them answers: **"Does accounting for heteroskedasticity change our conclusions?"**

| If... | Then... |
|-------|---------|
| All three agree | Very strong evidence the findings are robust |
| Classical ≠ permutation | Normality assumption might be affecting conclusions |
| perk ≠ DiCiccio & Romano | Heteroskedasticity might be an issue |

---

## A Note on P-Values and Hypothesis Testing

### Can p > 0.05 Lead to Rejecting the Null?

**No.** A p-value greater than 0.05 **never** leads to rejecting the null hypothesis when using α = 0.05 as the significance threshold.

By definition, we reject H₀ only when p < α. When p ≥ 0.05, we "fail to reject" the null. This is **not** the same as:
- Accepting the null hypothesis
- Proving no effect exists

It simply means the observed data are not sufficiently improbable under H₀ to warrant rejection at our chosen confidence level.

### Important Clarifications

| Scenario | Explanation |
|----------|-------------|
| **Different α levels** | If a researcher uses α = 0.10, then p = 0.07 would lead to rejection. The choice of α is made *before* seeing the data. |
| **One-tailed vs. two-tailed** | A two-tailed p = 0.08 corresponds to a one-tailed p = 0.04, which would reject under a one-tailed test. Our analysis uses two-tailed tests throughout. |
| **Multiple testing corrections** | When testing many hypotheses (35 covariates), some apply Bonferroni correction: α_adjusted = 0.05/35 ≈ 0.0014. This makes rejection *more* stringent, not less. |

### Our Approach

In this analysis, we use the conventional α = 0.05 two-tailed threshold **without** multiple testing correction, consistent with Chetty et al.'s original analysis.

---

## The Data: Tables 5 and 8

### Table 5: Mobility Estimates (Dependent Variable)

- Contains relative mobility estimates for 741 Commuting Zones
- Computed from IRS tax records (40+ million children, 1980-1991 birth cohorts)
- Key variable: **rank-rank slope** (regression of child income rank on parent income rank)
- Higher slope = less mobility (children's outcomes more tied to parents')
- National average: 0.34

### Table 8: CZ Characteristics (Independent Variables)

- 35 community-level characteristics per CZ
- Categories: segregation, inequality, education, social capital, family structure, labor markets, etc.
- Sources: Census, IRS public stats, education databases

### Sample Restriction

- 709 CZs with ≥250 children
- Ensures reliable mobility estimates

---

## Reference

Chetty, R., Hendren, N., Kline, P., & Saez, E. (2014). Where is the land of opportunity? The geography of intergenerational mobility in the United States. *Quarterly Journal of Economics*, 129(4), 1553-1623.

DiCiccio, C. J., & Romano, J. P. (2017). Robust permutation tests for correlation and regression coefficients. *Journal of the American Statistical Association*, 112(519), 1211-1220.
