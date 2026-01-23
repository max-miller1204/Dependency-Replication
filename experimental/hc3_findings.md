# HC3 Permutation Test Findings

## Summary

This experimental analysis adds an HC3-based permutation regression test to investigate whether the HC3 variance estimator's conservativeness in classical inference carries over to permutation inference.

**Key Finding:** It does not. The HC3 permutation test agrees with HC0 permutation, not with classical HC3.

---

## Background

### The Disagreement

In our main analysis, **Violent Crime Rate** showed disagreement between methods:

| Method | p-value | Significant? |
|--------|---------|--------------|
| Classical OLS | 0.0000 | YES |
| waldtest HC0 | 0.0298 | YES |
| waldtest HC3 | 0.2473 | **NO** |
| perk (permutation) | 0.0000 | YES |
| perm_reg HC0 | 0.0001 | YES |

The HC3 small-sample correction makes Violent Crime Rate non-significant, while all other methods agree it's significant.

### The Question

Does this HC3 conservativeness persist in permutation inference?

---

## Experimental Design

We implemented `perm_test_regression_hc3()`, which is identical to the DiCiccio & Romano (2017) permutation test but uses HC3 variance estimation instead of HC0:

```r
# HC3: leverage-corrected residuals
H <- X %*% solve(XtX) %*% t(X)
h <- diag(H)
r2 <- resid^2 / (1 - h)^2  # HC3 adjustment
```

**Important Caveat:** DiCiccio & Romano (2017) only proved validity for HC0. This HC3 variant is experimental and does NOT have formal theoretical backing.

---

## Results

### Violent Crime Rate (Key Diagnostic)

| Method | p-value | Significant? |
|--------|---------|--------------|
| **Classical HC0** | 0.0298 | YES |
| **Classical HC3** | 0.2473 | NO |
| **Permutation HC0** | 0.0001 | YES |
| **Permutation HC3** | **0.0001** | **YES** |

**The HC3 permutation test disagrees with classical HC3.** It agrees with HC0 permutation.

### All 35 Covariates

- **100% agreement** between HC0 and HC3 permutation tests on significance conclusions
- With identical random seeds, p-values are nearly identical between HC0 and HC3 permutation

---

## Interpretation

### Why Does This Happen?

In **classical inference**:
```
Test statistic (using HC3) → compared to → Fixed theoretical distribution (F or t)
```
HC3 inflates the variance estimate → smaller test statistic → looks less extreme relative to the **fixed** reference distribution → larger p-value.

In **permutation inference**:
```
Test statistic (using HC3) → compared to → Permutation distribution (also using HC3)
```
HC3 inflates **both** the observed statistic **and** all 10,000 permuted statistics. The relative ranking stays roughly the same.

### Analogy

Imagine measuring how tall someone is:
- **Classical**: Measure height in inches, compare to a standard height chart
- **Permutation**: Measure height, then measure 10,000 random people the same way, see where they rank

If you switch from inches to centimeters:
- Classical: Your number changes relative to the fixed chart
- Permutation: Everyone's number changes the same way, ranking preserved

---

## Conclusion

The classical HC3's conservativeness for Violent Crime Rate (p=0.03 → p=0.25) appears to be an **artifact of the asymptotic approximation**, not a fundamental property of the data relationship.

The permutation framework, which doesn't rely on asymptotic distributions, suggests:

1. **Violent Crime Rate has a real association** with relative mobility that's robust to variance estimation method
2. **HC3's small-sample correction** inflates variance in classical tests but has minimal impact when both observed and null statistics use the same estimator
3. **Permutation inference is more robust** to the choice of HC0 vs HC3 than classical inference

---

## Caveat

This experimental analysis:
- Does **NOT** have formal theoretical backing from DiCiccio & Romano (2017)
- Is implemented for **diagnostic purposes only**
- Results should be interpreted with caution

The HC3 permutation test is not recommended for production use without further theoretical validation.

---

## Data

Full results: `results/experimental/mobility_test_results_hc3_experimental.csv`

### P-Value Correlations

| Comparison | Correlation |
|------------|-------------|
| waldtest HC3 vs perm_reg HC3 | High |
| perm_reg HC0 vs perm_reg HC3 | ~1.00 |

---

## References

- DiCiccio, C. J., & Romano, J. P. (2017). Robust Permutation Tests For Correlation And Regression Coefficients. *Journal of the American Statistical Association*, 112(519), 1211-1220.
