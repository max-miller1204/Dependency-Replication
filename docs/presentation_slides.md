# Classical vs Permutation Testing for Relative Mobility Analysis
## Presentation Slides - Max Miller

---

## Slide 1: Title

**Classical vs Permutation Testing for Relative Mobility Analysis**

Max Miller

Replicating Chetty et al. (2014) "Where is the Land of Opportunity?"

---

## Slide 2: Research Question

**Do the significance conclusions from Chetty et al.'s classical OLS analysis hold up under permutation-based inference?**

Why this matters:
- If classical and permutation methods agree, findings are robust
- If they disagree, original conclusions may depend on statistical assumptions

**Main Finding: 97% agreement (34/35) across all 6 statistical methods**

---

## Slide 3: Why This Paper Matters

**Policy-Relevant Findings:**
- Identified single-parent households as strongest predictor of mobility
- Linked segregation, inequality, and social capital to children's outcomes
- Cited in policy discussions about economic opportunity

> "The fraction of children living in single-parent households is the single strongest correlate of upward income mobility among all the variables we explored" (Chetty et al. 2014, p. 40)

*[Include: Online Appendix Figure XIIa - Upward Mobility vs. Fraction Single Mothers]*

---

## Slide 4: What Is Relative Mobility?

**The Dependent Variable**

- **Rank-rank slope**: Regression coefficient from child income rank on parent income rank
- Higher value = less mobility (children's outcomes more tied to parents')
- National average: 0.34 (10 percentile increase in parent rank = 3.4 percentile increase in child rank)

**Interpretation:**
- Low slope (e.g., 0.2) = More mobile area (parents' income matters less)
- High slope (e.g., 0.5) = Less mobile area (parents' income matters more)

*[Include: Figure II - Mean Child Income Rank vs. Parent Income Rank]*

---

## Slide 5: Data Sources

| Dataset | Contents | Role |
|---------|----------|------|
| **Online Data Table 5** | Mobility estimates for 741 CZs | Dependent variable (Y) |
| **Online Data Table 8** | 35 community characteristics | Independent variables (X) |

**Sample:** 709 Commuting Zones with n >= 250 children (per Chetty et al.)

**Data source:** opportunityinsights.org

---

## Slide 6: Why Replicate Table VIII?

**Table VIII = The core empirical contribution**

- Section VI (p. 31): "We correlate our measures of intergenerational mobility with local area characteristics"
- These correlations drive policy discussions

**In simple terms:**
- Table 5 = Neighborhoods + their "mobility scores"
- Table 8 = Same neighborhoods + facts about them
- Table VIII = "Do neighborhoods with more ___ have kids who do better or worse?"

**Pipeline:** Table 5 (data) + Table 8 (data) --> R code --> Table VIII (results)

---

## Slide 7: Why Permutation Tests?

### Classical OLS Assumes:
1. **Normal residuals** - Errors follow normal distribution
2. **Homoskedasticity** - Constant error variance across X
3. **Large sample approximations** - t-test relies on asymptotic theory

### Permutation Tests Offer:
1. **No distributional assumptions** - Uses data itself for null distribution
2. **Exact p-values** - Under exchangeability, p-values are exact (not approximate)
3. **Robustness** - Less sensitive to violations (with proper studentization)

---

## Slide 8: Six Statistical Methods

### Non-Permutation Methods (4):

| Method | Test Statistic | Properties |
|--------|---------------|------------|
| summary(lm) | t = beta/SE(beta) | Assumes normality |
| cor.test | Pearson r | Classical t-test for correlation |
| waldtest HC0 | Wald F | Heteroskedasticity-robust |
| waldtest HC3 | Wald F | HC-robust + small-sample correction |

### Permutation Methods (2):

| Method | Test Statistic | Properties |
|--------|---------------|------------|
| perk | Pearson r | Simple permutation correlation |
| DiCiccio & Romano | Robust Wald Sn | HC-robust, studentized (Theorem 3.2) |

---

## Slide 9: Why Multiple Methods?

**Diagnostic Logic:**

| If... | Then... |
|-------|---------|
| All methods agree | Findings are **robust** |
| Classical != Permutation | **Normality assumption** issue |
| perk != DiCiccio & Romano | **Heteroskedasticity** issue |
| HC0 != HC3 | **Small sample** issue |

**Our Goal:** Test whether Chetty et al.'s findings are robust to ALL these concerns

---

## Slide 10: The 35 Covariates

| Category | # | Examples |
|----------|---|----------|
| Race | 1 | Fraction Black Residents |
| Segregation | 5 | Racial Segregation, Income Segregation |
| Income Distribution | 5 | Gini Coefficient, Top 1% Income Share |
| K-12 Education | 4 | School Expenditure, Test Scores |
| Social Capital | 3 | Social Capital Index, Crime Rate |
| Family Structure | 3 | Single Mothers, Fraction Married |
| Tax | 4 | Local Tax Rate, EITC Exposure |
| College | 3 | Colleges per Capita, Tuition |
| Local Labor Market | 4 | Manufacturing Share, Teen Employment |
| Migration | 3 | Inflow Rate, Foreign Born |

*[Include: Screenshot of Online Appendix Table VIII]*

---

## Slide 11: Code Flow - Beta Replication

**Step 1: Replicate the original coefficients**

1. Load Table 5 (mobility) and Table 8 (covariates)
2. Merge by Commuting Zone (CZ)
3. Filter to CZs with n >= 250 children
4. For each covariate:
   - Standardize both X and Y (mean=0, SD=1)
   - Run OLS: Y = alpha + beta*X + error
   - **Standardized beta = Pearson correlation**
5. Compare to Table VIII Column 6 (Relative Mobility)

**Result: All 35 betas match exactly (difference = 0)**

---

## Slide 12: Beta Replication Results

| Covariate | Paper | Replication | Diff |
|-----------|-------|-------------|------|
| Fraction Black Residents | 0.631 | 0.631 | 0 |
| Fraction Single Mothers | 0.641 | 0.641 | 0 |
| Gini Bottom 99% | 0.473 | 0.473 | 0 |
| Teen Labor Force Part. | -0.516 | -0.516 | 0 |
| Share Commute < 15 Mins | -0.447 | -0.447 | 0 |
| Social Capital Index | -0.327 | -0.327 | 0 |
| ... | ... | ... | 0 |

**All 35/35 coefficients replicated exactly**

---

## Slide 13: Code Flow - Significance Testing

**Step 2: Compare inference methods**

For each of 35 covariates:

```
1. Compute 4 non-permutation p-values:
   - summary(lm)     --> p_classical
   - cor.test        --> p_cor_test
   - waldtest(HC0)   --> p_waldtest_hc0
   - waldtest(HC3)   --> p_waldtest_hc3

2. Compute 2 permutation p-values (B = 10,000):
   - perk            --> p_perk
   - DiCiccio-Romano --> p_perm_reg

3. Check significance at alpha = 0.05
4. Compare: Do all 6 methods agree?
```

---

## Slide 14: Permutation Test Implementation

**DiCiccio & Romano (2017) Theorem 3.2:**

```
Test statistic: Sn = n * beta' * (Sigma^-1 * Omega * Sigma^-1) * beta

Where:
- beta = OLS coefficient
- Sigma = (1/n) X'X
- Omega = HC0 robust covariance (handles heteroskedasticity)

Procedure:
1. Compute Sn from observed data
2. Permute Y values B = 10,000 times
3. Compute Sn* for each permutation
4. p-value = (# Sn* >= Sn + 1) / (B + 1)
```

**Key:** Studentization makes test robust to heteroskedasticity

---

## Slide 15: Main Results

### Near-Perfect Agreement Across All 6 Methods

| Statistic | Value |
|-----------|-------|
| Total covariates | 35 |
| Significant (p < 0.05) | 32 (91.4%) |
| Not significant | 3 (8.6%) |
| **Methods agreeing** | **34/35 (97.1%)** |

**5 of 6 methods agree for all covariates; HC3 disagrees on 1 (Violent Crime Rate)**

---

## Slide 16: Significant Covariates (32/35)

**Strongest Predictors of LESS Mobility (positive beta):**
| Covariate | Beta | p-value |
|-----------|------|---------|
| Fraction Single Mothers | 0.641 | <0.001 |
| Fraction Black Residents | 0.631 | <0.001 |
| Gini Bottom 99% | 0.473 | <0.001 |
| Racial Segregation | 0.406 | <0.001 |
| Manufacturing Employment | 0.393 | <0.001 |

**Strongest Predictors of MORE Mobility (negative beta):**
| Covariate | Beta | p-value |
|-----------|------|---------|
| Teen Labor Force Participation | -0.516 | <0.001 |
| Fraction Middle Class | -0.451 | <0.001 |
| Share Commute < 15 Mins | -0.447 | <0.001 |
| Fraction Married | -0.370 | <0.001 |
| Social Capital Index | -0.327 | <0.001 |

---

## Slide 17: Non-Significant Covariates (3/35)

**These covariates showed NO significant relationship with mobility:**

| Covariate | Beta | p_classical | p_perm |
|-----------|------|-------------|--------|
| Top 1% Income Share | 0.019 | 0.617 | 0.412 |
| Teacher-Student Ratio | 0.009 | 0.805 | 0.791 |
| College Grad Rate (Inc. Adj.) | -0.025 | 0.553 | 0.563 |

**Interpretation:**
- Effect sizes near zero (betas < 0.03)
- All 6 methods agree these are NOT significant
- Top 1% wealth concentration doesn't predict mobility (but Gini/inequality does)

---

## Slide 18: The One Disagreement - Violent Crime Rate

**Why HC3 disagrees with the other 5 methods:**

| Method | p-value | Significant? |
|--------|---------|--------------|
| summary(lm) | 9.73e-09 | YES |
| cor.test | 9.73e-09 | YES |
| waldtest HC0 | 0.030 | YES (barely) |
| **waldtest HC3** | **0.247** | **NO** |
| perk | <0.001 | YES |
| perm_reg | <0.001 | YES |

**What's happening:**
- HC0 p-value: 0.030 (just under 0.05)
- HC3 p-value: 0.247 (not even close)
- HC3 inflates standard errors for high-leverage observations: `1/(1-hᵢᵢ)²`
- Some CZs have unusual violent crime rates AND unusual mobility → high leverage

**Interpretation:** The Violent Crime Rate finding is **sensitive to outliers/leverage**. The most conservative classical method (HC3) does not find it significant.

---

## Slide 19: P-Value Correlations

**How similar are the p-values across methods?**

| Comparison | Correlation |
|------------|-------------|
| cor.test vs perk | r = 0.999 |
| summary(lm) vs perm_reg | r = 0.997 |
| waldtest HC0 vs perm_reg | r = 0.985 |
| waldtest HC3 vs perm_reg | r = 0.979 |

**Near-perfect agreement** - Classical and permutation p-values are virtually identical

---

## Slide 19: Coefficient Plot

*[Include: coefficient_plot.png]*

**Visual Summary:**
- X-axis: Standardized coefficient (beta = Pearson r)
- Green dots: All 6 methods significant
- Gray dots: No method significant
- Error bars: 95% confidence intervals
- Ordered by effect size

**One red dot: Violent Crime Rate (HC3 disagrees with other 5 methods)**

---

## Slide 20: Key Findings Summary

### 1. Exact Replication
- All 35 coefficients match Chetty et al. Table VIII exactly

### 2. Near-Complete Robustness
- 97% agreement across 6 inference methods (34/35 covariates)
- One exception: Violent Crime Rate (sensitive to leverage correction in HC3)

### 3. Substantive Conclusions Confirmed
- Single mothers: strongest negative predictor of mobility (beta = 0.64)
- Teen labor force participation: strongest positive predictor (beta = -0.52)
- Top 1% income share: NOT significant (beta = 0.02, p = 0.62)

---

## Slide 21: Why Does This Matter?

**Robustness to Statistical Method:**
- Chetty et al.'s findings do NOT depend on asymptotic normality
- Results are NOT driven by heteroskedasticity
- Conclusions are NOT artifacts of classical inference assumptions

**Implication for Policy:**
- Community characteristics associated with mobility are real, not statistical artifacts
- Same conclusions whether using 1900s-era t-tests or modern permutation methods

---

## Slide 22: Limitations & Future Work

**What This Analysis Does:**
- Tests robustness of univariate correlations
- Confirms significance conclusions hold across methods

**What This Analysis Does NOT Do:**
- Test multivariate/causal models
- Address omitted variable bias
- Replicate absolute mobility results

**Future Extensions:**
- Apply permutation tests to multivariate specifications
- Test robustness of heterogeneity analyses
- Extend to other Opportunity Insights datasets

---

## Slide 23: Technical Details

**Software & Parameters:**
- R version 4.x with tidyverse, perk, sandwich, lmtest packages
- B = 10,000 permutations per covariate
- Runtime: ~15 minutes (35 covariates x 10,000 permutations x 2 methods)

**Reproducibility:**
- All code and data available on GitHub
- Random seeds set for exact reproducibility
- Output saved to CSV and RData files

---

## Slide 24: Conclusion

**Research Question:** Do Chetty et al.'s findings depend on classical inference assumptions?

**Answer: No.**

- 34/35 covariates show identical significance across 6 methods
- Classical OLS, robust standard errors, and permutation tests largely agree
- One exception (Violent Crime Rate) reveals sensitivity to high-leverage observations

**Bottom Line:** The Land of Opportunity findings are methodologically sound.

---

## Slide 25: References

- Chetty, R., Hendren, N., Kline, P., & Saez, E. (2014). Where is the land of opportunity? The geography of intergenerational mobility in the United States. *Quarterly Journal of Economics*, 129(4), 1553-1623.

- DiCiccio, C. J., & Romano, J. P. (2017). Robust permutation tests for correlation and regression coefficients. *Journal of the American Statistical Association*, 112(519), 1211-1220.

- Data: opportunityinsights.org

---

## Appendix A: Method Comparison Details

| Method | Type | Assumes Normality | Handles Heterosk. | Exact p-value |
|--------|------|-------------------|-------------------|---------------|
| summary(lm) | Classical | Yes | No | No |
| cor.test | Classical | Yes | No | No |
| waldtest HC0 | Classical | No | Yes | No |
| waldtest HC3 | Classical | No | Yes (better) | No |
| perk | Permutation | No | No | Yes |
| DiCiccio-Romano | Permutation | No | Yes | Yes |

---

## Appendix B: Full Results Table

| Category | Covariate | Beta | Classical p | Perm p | Sig? |
|----------|-----------|------|-------------|--------|------|
| Race | Fraction Black | 0.631 | <0.001 | <0.001 | Yes |
| Segregation | Racial Seg. | 0.406 | <0.001 | <0.001 | Yes |
| Segregation | Income Seg. | 0.183 | <0.001 | <0.001 | Yes |
| Family | Single Mothers | 0.641 | <0.001 | <0.001 | Yes |
| Family | Fraction Married | -0.370 | <0.001 | <0.001 | Yes |
| Income | Gini | 0.346 | <0.001 | <0.001 | Yes |
| Income | Top 1% Share | 0.019 | 0.617 | 0.412 | No |
| ... | ... | ... | ... | ... | ... |

*[Full 35-row table in output/mobility_test_results.csv]*
