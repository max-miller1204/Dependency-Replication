# Subgroup Mobility Analysis: Testing Permutation Robustness Across Population Subgroups

**Max Miller**

---

## Slide 1: Title

# Subgroup Mobility Analysis
## Testing Permutation Robustness Across RM Variants

Max Miller
January 2026

---

## Slide 2: Recap - Main Analysis Results

### Previous Finding: Permutation Tests Confirm Classical Results

From the baseline analysis (RM, 80-82 Cohort):
- **34/35 covariates** showed identical significance across 6 methods
- Only 1 disagreement: Violent Crime Rate (HC3 sensitivity)
- **Conclusion**: Chetty et al.'s findings are robust to inference method

### This Extension Asks:
> Are permutation-based conclusions **also robust across different population subgroups**?

---

## Slide 3: Why Subgroup Analysis?

### Filling a Gap in the Paper

Chetty et al. (2014) establish two key results separately:

1. **Online Appendix Table VII**: Subgroup RM *levels* correlate >0.9 with baseline RM
2. **Online Appendix Table VIII Col 6**: 35 covariates correlate with baseline RM

But the paper never systematically tests whether **covariate relationships** also hold for subgroup-specific RM. We fill this gap: 35 covariates × 4 subgroups.

### Paper Quotes (Section V.D):

> "limiting the sample to male vs. female children, married vs. single parents [...] Measures of both absolute and relative mobility across areas in these subsamples generally have a correlation of more than 0.9 with the corresponding baseline measures"

---

## Slide 4: What the Paper Does Test

### Community-Level Effects (Section VI.F, Figure XIIb)

The paper tests **1 covariate** (fraction single mothers) × **1 subgroup** (married parents):

> "The correlation between upward mobility and the fraction of single parents in their CZ **remains at -0.66 even in this subgroup**."

> "Children of married parents also have higher rates of upward mobility in communities with fewer single parents." — Section I

### Our Generalization:
We extend this from 1 × 1 to **35 covariates × 4 subgroups**, with permutation inference.

---

## Slide 5: The Subgroups Tested

### 5 Relative Mobility (RM) Variants from Table 5

| Subgroup | Description | Sample Size | Paper Support |
|----------|-------------|-------------|---------------|
| **RM Baseline** | 80-82 Cohort (all children) | n = 709 | Appendix Table VIII Col 6 |
| **RM Females** | Female children only | n = 667 | Appendix Table VII Row 2 |
| **RM Males** | Male children only | n = 667 | Appendix Table VII Row 1 |
| **RM Single Parents** | Children of single parents | n = 595 | Appendix Table VII Row 4 |
| **RM Married Parents** | Children of married parents | n = 695 | Figure XIIb |

### Analysis:
- 35 covariates × 5 subgroups = **175 tests**
- Each test uses all 6 methods (4 classical + 2 permutation)

---

## Slide 6: Research Questions

### 1. Covariate Robustness Across Subgroups (New)
Appendix Table VII shows subgroup RM *levels* correlate >0.9 with baseline—do the *covariate relationships* also hold?

### 2. Gender Comparison
Do covariates predict RM similarly for females vs males?

### 3. Community-Level Effects (Key Test)
The paper shows this for 1 covariate (fraction single mothers, Figure XIIb). We generalize to all 35 covariates.

### 4. Permutation Robustness
Do permutation tests agree with classical methods across ALL subgroups?

---

## Slide 7: Methodology (Same 6 Methods)

### Non-Permutation Methods (4):

| Method | Test Statistic | Properties |
|--------|----------------|------------|
| summary(lm) | t = β/SE(β) | Assumes normality |
| cor.test | Pearson r | Classical t-test |
| waldtest HC0 | Wald F | Heteroskedasticity-robust |
| waldtest HC3 | Wald F | HC-robust + small-sample |

### Permutation Methods (2):

| Method | Test Statistic | Properties |
|--------|----------------|------------|
| perk | Pearson r | Simple permutation |
| DiCiccio & Romano | Robust Wald Sₙ | HC-robust, studentized |

---

## Slide 8: Main Results - Method Agreement

### Overall: ~95% Agreement Across All 175 Tests

| Subgroup | Disagreements | Agreement Rate |
|----------|---------------|----------------|
| Baseline | 1 | 97.1% |
| Females | 3 | 91.4% |
| Males | 3 | 91.4% |
| Single Parents | 2 | 94.3% |
| **Married Parents** | **0** | **100%** |

**Key Finding**: The married parents subgroup shows PERFECT agreement across all 6 methods for all 35 covariates.

---

## Slide 9: Significant Covariates by Subgroup

### Permutation Regression Significance (p < 0.05)

| Subgroup | Significant | Percentage |
|----------|-------------|------------|
| Baseline | 31/35 | 88.6% |
| Females | 31/35 | 88.6% |
| Males | 30/35 | 85.7% |
| **Single Parents** | **22/35** | **62.9%** |
| Married Parents | 31/35 | 88.6% |

### Notable:
- Single Parents subgroup shows **fewer significant covariates**
- This is expected: smaller, more homogeneous sample
- Different predictors matter for this population

---

## Slide 10: The 9 Disagreements

### All disagreements involve borderline p-values (~0.05)

| Subgroup | Covariate | Issue |
|----------|-----------|-------|
| Baseline | Violent Crime Rate | HC3 not significant (p=0.247) |
| Females | Top 1% Income Share | perm_reg significant, others not |
| Females | Colleges per Capita | perk not significant (p=0.053) |
| Females | College Tuition | perk significant (p=0.048) |
| Males | Household Income | HC0/HC3 not significant |
| Males | Colleges per Capita | HC0/HC3 not significant |
| Males | Growth in Chinese Imports | HC0/HC3 not significant |
| Single Parents | State Income Tax | perk not significant (p=0.058) |
| Single Parents | Labor Force Participation | perm_reg significant |

**Pattern**: HC3 tends to be most conservative

---

## Slide 11: Key Test - Community-Level Effects (Generalizing Figure XIIb)

### Does "Fraction Single Mothers" Predict RM for Married Parents?

The paper tests this for 1 covariate × 1 subgroup (Figure XIIb). Our results across all 5 subgroups:

| Subgroup | Beta | p_classical | p_perm_reg | Significant? |
|----------|------|-------------|------------|--------------|
| Baseline | 0.641 | <0.001 | <0.001 | YES |
| Females | 0.627 | <0.001 | <0.001 | YES |
| Males | 0.611 | <0.001 | <0.001 | YES |
| Single Parents | 0.170 | <0.001 | <0.001 | YES |
| **Married Parents** | **0.555** | **<0.001** | **<0.001** | **YES** |

---

## Slide 12: Community Effects - Interpretation

### The Critical Finding

**"Fraction Single Mothers" strongly predicts worse mobility outcomes EVEN for children whose own parents are married.**

- Beta = 0.555 (for Married Parents subgroup)
- p < 0.001 under BOTH classical AND permutation inference

### What This Means:

Living in a community with more single-parent households is associated with worse outcomes **regardless of your own family structure**.

This is a **COMMUNITY-LEVEL EFFECT**, not an individual-level effect.

> "The correlation... remains at -0.66 even in this subgroup" — Chetty et al. (2014), Section VI.F / Figure XIIb

---

## Slide 13: Gender Comparison

### Coefficients Are Highly Similar for Females vs Males

| Statistic | Value |
|-----------|-------|
| Correlation of betas (F vs M) | r ≈ 0.99 |
| Both genders significant | 28 covariates |
| Females only significant | 2 covariates |
| Males only significant | 1 covariate |
| Neither significant | 4 covariates |

### Minor Gender Differences:
- **Household Income**: Significant for females, not males (under HC0/HC3)
- **Growth in Chinese Imports**: Stronger effect for females

**Conclusion**: Mobility predictors are largely **gender-invariant**

---

## Slide 14: Covariates NOT Significant in ANY Subgroup

### Consistently Non-Significant (All 5 Subgroups)

These covariates show **no relationship** with relative mobility under any subgroup:

1. **Top 1% Income Share** (β ≈ 0.02-0.05)
2. **Teacher-Student Ratio** (β ≈ 0.01)
3. **College Graduation Rate** (β ≈ -0.02)

### Interpretation:
- Top earners' income share doesn't predict mobility
- Class sizes don't matter (after controlling for income)
- College completion rates (income-adjusted) are not predictive

---

## Slide 15: Strongest Predictors Across ALL Subgroups

### Consistently Significant (All 5 Subgroups)

| Covariate | Direction | Beta Range | Interpretation |
|-----------|-----------|------------|----------------|
| Fraction Single Mothers | + | 0.17 to 0.64 | More single parents → less mobility |
| Fraction Black | + | 0.18 to 0.63 | Racial composition correlate |
| Teen Labor Force Part. | − | −0.13 to −0.53 | Teen work → more mobility |
| Commute < 15 Mins | − | −0.15 to −0.51 | Short commutes → more mobility |
| Gini Bottom 99% | + | 0.13 to 0.50 | Inequality → less mobility |
| Manufacturing Share | + | 0.20 to 0.47 | Manufacturing → less mobility |

---

## Slide 16: Significance Comparison Table

### Permutation Regression (p < 0.05) by Subgroup

```
Covariate                        | Base | Fem | Male | Sing | Marr
---------------------------------|------|-----|------|------|-----
Fraction Single Mothers          |  *   |  *  |  *   |  *   |  *
Fraction Black Residents         |  *   |  *  |  *   |  *   |  *
Teen Labor Force Participation   |  *   |  *  |  *   |  *   |  *
Share with Commute < 15 Mins     |  *   |  *  |  *   |  *   |  *
Gini Bottom 99%                  |  *   |  *  |  *   |  *   |  *
...                              |      |     |      |      |
Top 1% Income Share              |      |     |      |      |
Teacher-Student Ratio            |      |     |      |      |
College Grad Rate                |      |     |      |      |
---------------------------------|------|-----|------|------|-----
TOTAL SIGNIFICANT                |  31  | 31  |  30  |  22  |  31
```

---

## Slide 17: Why Single Parents Subgroup Differs

### Fewer Significant Covariates (22/35 vs 30+/35)

Covariates that **lose significance** for Single Parents:
- Gini Coefficient
- Fraction Middle Class
- Test Scores
- Social Capital Index
- Fraction Married/Divorced

### Possible Explanations:
1. **Smaller sample** (n=595 vs 709)
2. **More homogeneous** population
3. **Different causal pathways** for this group
4. **Range restriction** on family structure variables

---

## Slide 18: Permutation vs Classical - P-Value Correlations

### High Correlation Across All Subgroups

| Comparison | Correlation (r) |
|------------|-----------------|
| cor.test vs perk | 0.99+ |
| summary(lm) vs perm_reg | 0.95+ |
| waldtest HC0 vs perm_reg | 0.93+ |
| waldtest HC3 vs perm_reg | 0.90+ |

### Interpretation:
- Permutation p-values are **highly correlated** with classical p-values
- When they disagree, it's at **borderline significance** (p ≈ 0.05)
- HC3 is most conservative (inflates SEs for high-leverage observations)

---

## Slide 19: Conclusion

### Research Question:
Are permutation-based significance conclusions robust across population subgroups?

### Answer: YES

1. **~95% agreement** across all 175 covariate-subgroup tests
2. **Community-level effects CONFIRMED**: Fraction Single Mothers predicts RM for married parents (β=0.555, p<0.001)
3. **Gender differences minimal**: Coefficients nearly identical for females vs males
4. **Core predictors robust**: Family structure, segregation, commute times matter across ALL subgroups

### Bottom Line:
**Permutation tests are as robust as—and often agree perfectly with—classical methods, providing strong validation that Chetty et al.'s findings do not depend on distributional assumptions.**

---

## Slide 20: References

- Chetty, R., Hendren, N., Kline, P., & Saez, E. (2014). Where is the land of opportunity? The geography of intergenerational mobility in the United States. *Quarterly Journal of Economics*, 129(4), 1553-1623.

- DiCiccio, C. J., & Romano, J. P. (2017). Robust permutation tests for correlation and regression coefficients. *Journal of the American Statistical Association*, 112(519), 1211-1220.

- Data: opportunityinsights.org

---

## Slide 21: Appendix - Sample Sizes by Subgroup

| Subgroup | Total CZs | Varies by Covariate |
|----------|-----------|---------------------|
| Baseline (RM, 80-82) | 709 | 580-709 |
| Females | 667 | 555-667 |
| Males | 667 | 556-667 |
| Single Parents | 595 | 492-595 |
| Married Parents | 695 | 576-695 |

Note: Sample sizes vary because some covariates have missing values for certain CZs.
