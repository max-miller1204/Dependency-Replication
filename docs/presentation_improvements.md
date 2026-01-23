# Presentation Improvements Guide

## Summary of Changes

Your original has 14 slides. Here are the key fixes and additions:

---

## CRITICAL FIXES

### Slide 7 (Methodology) - UPDATE NEEDED
Your slide shows only 3 methods, but the analysis uses **6 methods**. Update the table:

| Method | Test Statistic | Properties |
|--------|---------------|------------|
| summary(lm) | t-statistic | Assumes normality |
| cor.test | Pearson r | Classical correlation test |
| waldtest HC0 | Wald F | Heteroskedasticity-robust |
| waldtest HC3 | Wald F | HC-robust + small-sample |
| perk | Pearson r | Simple permutation |
| DiCiccio & Romano | Robust Wald | HC-robust permutation |

---

### Slide 12 (Empty) - ADD THIS CONTENT

**Title: Significance Testing Code Flow**

For each covariate:
1. Compute classical p-value from `summary(lm)`
2. Compute robust p-values from `waldtest` with HC0 and HC3
3. Compute `cor.test` p-value
4. Run `perk` permutation test (B = 10,000)
5. Run DiCiccio & Romano permutation regression (B = 10,000)
6. Compare: Do all 6 methods agree on significance (p < 0.05)?

**Key parameters:**
- 10,000 permutations per test
- alpha = 0.05 (two-tailed)
- ~15 minute runtime

---

### Slide 13 (Empty) - ADD THIS CONTENT

**Title: Significance Results**

| Metric | Result |
|--------|--------|
| Total covariates tested | 35 |
| Significant (all 6 methods) | 32 (91.4%) |
| Not significant (all 6 methods) | 3 (8.6%) |
| **Disagreements** | **0 (0%)** |

**Non-significant covariates:**
- Top 1% Income Share (beta = 0.019, p = 0.62)
- Teacher-Student Ratio (beta = 0.009, p = 0.81)
- College Grad Rate (beta = -0.025, p = 0.55)

**Key finding: 100% agreement across all 6 methods**

---

### Slide 14 (Coefficient Plot) - FIX ERROR

Your slide says "No Significance: Single Mothers" - this is WRONG.

Single Mothers is the **MOST significant** predictor (beta = 0.641, p < 0.001)

Correct interpretation:
- **Least Mobility (highest positive beta):** Single Mothers, Fraction Black
- **Most Mobility (most negative beta):** Teen Labor Force Participation
- **No Significance (gray):** Top 1% Share, Teacher-Student Ratio, College Grad Rate

---

## RECOMMENDED ADDITIONS

### Add: Slide 15 - Main Findings

**Title: Key Takeaways**

1. **Exact Replication:** All 35 betas match paper Table VIII
2. **Complete Robustness:** 100% agreement across 6 inference methods
3. **Substantive Findings Confirmed:**
   - Single mothers: strongest predictor of LOW mobility
   - Teen employment: strongest predictor of HIGH mobility
   - Top 1% wealth: NOT a significant predictor

---

### Add: Slide 16 - Why This Matters

**Chetty et al.'s findings are NOT artifacts of:**
- Normality assumptions (permutation tests don't need them)
- Heteroskedasticity (DiCiccio & Romano handles this)
- Small sample issues (HC3 corrects for this)

**Implication:** The correlations are real, not statistical flukes.

---

### Add: Slide 17 - Conclusion

**Research Question:** Do Chetty et al.'s findings hold under permutation inference?

**Answer: Yes, completely.**

- All 6 statistical methods agree
- Classical and permutation p-values nearly identical (r > 0.97)
- The "Land of Opportunity" findings are methodologically robust

---

## OPTIONAL ENHANCEMENTS

### Improve Slide 6 (Why Permutation Tests)
Add a visual showing the permutation process:

```
Observed data: Y₁, Y₂, Y₃, ..., Yₙ paired with X₁, X₂, ..., Xₙ
Compute observed test statistic T_obs

Permutation 1: Shuffle Y → compute T₁*
Permutation 2: Shuffle Y → compute T₂*
...
Permutation 10,000: Shuffle Y → compute T₁₀₀₀₀*

p-value = (# permuted stats >= observed stat) / 10,000
```

### Add to Slide 11 (Beta Results)
Highlight the strongest effects:

**Most positive (predict LESS mobility):**
1. Fraction Single Mothers: +0.641
2. Fraction Black Residents: +0.631
3. Gini Bottom 99%: +0.473

**Most negative (predict MORE mobility):**
1. Teen Labor Force: -0.516
2. Fraction Middle Class: -0.451
3. Share Commute < 15 Min: -0.447

---

## QUICK CHECKLIST

- [ ] Fix Slide 7 (update from 3 methods to 6 methods)
- [ ] Fill in Slide 12 (significance testing code flow)
- [ ] Fill in Slide 13 (significance results: 100% agreement)
- [ ] Fix Slide 14 (Single Mothers IS significant, not non-significant)
- [ ] Add conclusion slide with main takeaways
- [ ] Update title slide with latest date

---

## FIGURES TO INCLUDE

1. **Online Appendix Figure XIIa** (you have this - Slide 2)
2. **Figure II - Rank-Rank Slope** (you have this - Slide 3)
3. **Online Appendix Table VIII** (you have this - Slide 8)
4. **Your coefficient_plot.png** (R_code/output/) - Updated version with 6 methods
