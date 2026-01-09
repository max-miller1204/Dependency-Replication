# Why Replicate Table VIII?

## Motivation for Choosing Table VIII

We chose to replicate Online Appendix Table VIII because it represents the core empirical contribution of Chetty et al. (2014): identifying which community-level characteristics are associated with intergenerational mobility. While the paper's mobility estimates themselves (Tables 1-7) were computed from restricted IRS tax records and cannot be independently reproduced, Table VIII's correlational analysis uses these published mobility estimates as the dependent variable and publicly available community characteristics as predictors.

This makes it both **replicable** and **substantively important**:

- It is this analysis that identifies single-parent household rates as "the single strongest correlate of upward income mobility among all the variables we explored" (Chetty et al., 2014, p. 1594)
- It links segregation, inequality, and social capital to children's economic outcomes
- Policy discussions citing this paper typically draw on Table VIII's findings

By verifying that these correlations are robust to alternative statistical methods (specifically, permutation-based inference that does not rely on asymptotic normality), we strengthen confidence in the paper's policy-relevant conclusions.

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

## Reference

Chetty, R., Hendren, N., Kline, P., & Saez, E. (2014). Where is the land of opportunity? The geography of intergenerational mobility in the United States. *Quarterly Journal of Economics*, 129(4), 1553-1623.
