# Speaker Notes: Regression Diagnostics for Chetty et al. (2014)

---

## Slide 1: Motivation

### What the slide says:
We are re-examining the statistical methods behind a famous economics paper by Chetty et al. (2014), which studied what community-level factors predict upward economic mobility in the United States.

### What you need to understand and say:

**The paper we are replicating:**
Chetty et al. (2014) is one of the most influential economics papers of the last decade. It used IRS tax records to measure "relative mobility" -- the idea that if you're born poor, how likely are you to end up in a higher income bracket as an adult? They measured this across 709 Commuting Zones (CZs), which are geographic clusters of counties that function as local labor markets (think: a city and its surrounding area).

**What they tested:**
They ran 35 separate simple OLS regressions, each testing whether one community characteristic (e.g., income inequality, racial composition, school quality) predicts relative mobility. OLS stands for Ordinary Least Squares -- the standard "draw a line of best fit" regression.

**The problem we are investigating:**
OLS makes three key assumptions:
1. **Homoskedasticity** -- the variance of the errors (how spread out the data points are from the line) is constant across all values of X.
2. **Normal residuals** -- the errors follow a bell-curve distribution.
3. **No extreme outliers** -- no single data point should dominate the regression line.

Our question is: **does Chetty et al.'s data actually satisfy these assumptions, and if not, does it matter?**

**What we did:**
For each of the 35 regressions, we computed 8 diagnostic statistics to test those assumptions. The sample is 709 Commuting Zones, and variables are standardized -- so the regression coefficient equals the Pearson correlation (r), which makes comparisons across covariates cleaner.

---

## Slide 2: The 8 Diagnostic Statistics

### What the slide says:
A table listing the 8 tests we computed for every regression.

### What you need to understand and say:

Think of these 8 statistics as 8 different "health checks" for each regression. Let me walk through each:

**1. Pearson r** -- This is the standard linear correlation coefficient. It measures how strongly and linearly two variables move together. Ranges from -1 to +1. Because variables are standardized, this equals the OLS beta coefficient.

**2. Spearman rho** -- This is the rank-based correlation. Instead of using the actual values, it uses their ranks (1st, 2nd, 3rd...). It captures any monotonic relationship (consistently going up or consistently going down), not just linear ones. It is resistant to outliers.

**3. |r - rho|** -- The absolute difference between Pearson and Spearman. If both are similar, the relationship is approximately linear. If they diverge a lot, it suggests the relationship is non-linear or that outliers are distorting the Pearson correlation. A large gap is a red flag.

**4. Breusch-Pagan p-value** -- A formal statistical test for heteroskedasticity (non-constant variance). It specifically tests for a linear form of heteroskedasticity. A small p-value (< 0.05) means the variance of residuals is not constant -- it changes with the value of the predictor. This violates OLS assumption #1.

**5. White test p-value** -- Also tests for heteroskedasticity, but more broadly. It can detect non-linear forms of heteroskedasticity that Breusch-Pagan misses. Think of White as the more powerful, general version.

**6. Jarque-Bera p-value** -- Tests whether the residuals are normally distributed by checking their skewness and kurtosis. A small p-value means the residuals are non-normal (fat tails, or lopsided distribution). This violates OLS assumption #2.

**7. Max Cook's D** -- Cook's Distance measures how much the regression line would change if you deleted a single observation. A value greater than 1 is a traditional concern threshold. If one CZ has a Cook's D of 12, it means that one city is almost entirely driving the result.

**8. Max Leverage** -- Leverage measures how "extreme" a data point is in the predictor (X) space -- i.e., how far it is from the average X value. A high-leverage point has unusual X values and therefore has the potential to strongly influence the regression, even if it doesn't look like an outlier in Y.

---

## Slide 3: Heteroskedasticity is Widespread

### What the slide says:
32 out of 35 regressions (91%) show statistically significant heteroskedasticity. The five most extreme cases are shown.

### What you need to understand and say:

**What heteroskedasticity means in plain English:**
Imagine you're predicting mobility from the Gini coefficient (income inequality). In low-inequality CZs, the mobility values are tightly clustered near the regression line. But in high-inequality CZs, they are all over the place. That's heteroskedasticity -- the spread of the errors depends on where you are on the X axis.

**Why it matters for OLS:**
Standard OLS t-tests assume the variance is constant. When it isn't, the standard errors are wrong, which means p-values are wrong, which means significance conclusions might be wrong.

**Our key finding:**
Despite 91% of regressions showing heteroskedasticity, when we applied heteroskedasticity-robust methods (HC0 and HC3 standard errors, permutation tests), the significance conclusions were identical for 34 out of 35 covariates. The violations are real, but at a sample size of ~700, they don't change who is significant and who is not -- with one important exception (Violent Crime Rate, addressed in Slide 5).

**Why mention the specific p-values?**
The p-values in the table (like 9.1e-11 for Violent Crime Rate) are extremely small -- essentially zero. This means we are not close to the borderline. The heteroskedasticity is severe and unambiguous. We are not worrying about noise; this is a real structural feature of the data.

---

## Slide 4: Non-Normal Residuals are Common

### What the slide says:
83% of regressions have non-normal residuals. The 5 most extreme cases are listed.

### What you need to understand and say:

**What non-normal residuals mean:**
After fitting the regression line, the leftover errors (residuals) should look like a bell curve if OLS assumptions hold. In 29 of 35 cases, they don't -- they are skewed (lopsided) or have fat tails (extreme values occur much more often than a normal distribution predicts).

**Why this happens:**
Many of these variables -- like fraction Black residents or fraction middle class -- are proportions bounded between 0 and 1, or are highly skewed counts. When X itself has an unusual distribution, the residuals often do too.

**The critical insight -- why it doesn't matter here:**
Classical t-tests rely on the Central Limit Theorem, which says that with a large enough sample, even if residuals aren't perfectly normal, the sampling distribution of the coefficient estimate is approximately normal. With n = 709, we are well past the threshold where this kicks in.

More importantly, we also ran **permutation tests** -- a method that makes absolutely no distributional assumptions. It works by randomly shuffling the Y values thousands of times and asking: how often does a shuffled dataset produce a correlation as large as what we observed? This is distribution-free by construction. The permutation tests agree with the classical t-tests on every single covariate. This is the strongest possible evidence that non-normality is irrelevant here.

---

## Slide 5: Outlier Alert -- Violent Crime Rate

### What the slide says:
Violent Crime Rate is extreme across every diagnostic. One CZ dominates the regression. Classical HC3 calls it non-significant; all 5 other methods call it significant.

### What you need to understand and say:

**This is the most interesting finding in the entire analysis.**

**What's happening:**
One single Commuting Zone -- likely a large city with extraordinarily high violent crime -- is so far from all the others that it essentially "pulls" the regression line toward itself. Cook's D = 12.28, when the standard concern threshold is 1.0. The next highest Cook's D in the entire dataset is 1.98. This CZ is more than 6 times more influential than any other outlier in any other regression.

**What the different methods say:**

- **5 out of 6 methods**: Violent Crime Rate significantly predicts mobility (p < 0.05).
- **HC3 only**: p = 0.247, not significant.

**Why does HC3 disagree?**
HC3 (Heteroskedasticity-Consistent estimator, version 3) is a "small-sample correction" variant of robust standard errors. It specifically upweights the variance contribution of high-leverage observations. Because this one CZ has a leverage of 0.487 (nearly 50% of all leverage is concentrated in one point!), HC3 inflates the standard error dramatically, wiping out statistical significance.

**Is HC3 right or wrong?**
This is genuinely debatable -- which is why it is interesting. HC3 is being appropriately cautious: "we have one data point doing almost all the work, so we should not be confident in this result." The other methods are saying: "the relationship is real and consistent, and this is just an extreme but legitimate observation." Our position is that this warrants caution and investigation, but that 5/6 methods agreeing provides reasonable evidence of a real relationship.

**The |r - rho| also tells a story:**
Pearson r = 0.217, Spearman rho = 0.330. The outlier is compressing the linear correlation downward. When you use rank-based Spearman (which is resistant to the outlier), the correlation is 50% larger. The relationship is real and monotonic, but the extreme outlier distorts the linear measure.

---

## Slide 6: Other High-Influence Covariates

### What the slide says:
Four other covariates have Cook's D > 0.5 or leverage > 0.1, making them noteworthy even if not as extreme as Violent Crime Rate.

### What you need to understand and say:

**Growth in Chinese Imports (Cook's D = 1.98):**
This variable measures how much a CZ was exposed to import competition from China in the 2000s (the "China Shock"). The distribution is very skewed -- most CZs had little exposure, but a handful of manufacturing-heavy CZs (think: furniture-producing regions in North Carolina, or textile regions) had extreme exposure. This creates a naturally high-leverage, high-influence situation.

**Local Government Expenditures (Cook's D = 1.50):**
Government spending per capita varies enormously across CZs -- some have very high spending (often in wealthier or larger urban areas). One CZ apparently has an extreme value here.

**Top 1% Income Share (Cook's D = 0.98):**
This is particularly interesting because we will discuss this more in Slide 7 -- it's also the most non-linear relationship in the dataset.

**The bottom line:**
Despite these high-influence observations, significance conclusions remain consistent across all methods for these covariates (unlike Violent Crime Rate). The outliers are real but not decisive -- the relationships hold even when we account for them.

---

## Slide 7: Non-Linearity -- Where Pearson and Spearman Diverge

### What the slide says:
Five covariates show large Pearson-Spearman gaps. Two are particularly notable: Top 1% Income Share and Growth in Chinese Imports.

### What you need to understand and say:

**The key concept:**
Pearson r measures linear correlation. Spearman rho measures monotonic (rank) correlation. If both are similar, the relationship is roughly linear. If Spearman > Pearson, it means the relationship is real and consistent (always going in the same direction) but the outliers or non-linearity are pulling the Pearson downward.

**Top 1% Income Share -- the most striking case:**
- Pearson r = 0.019 (essentially zero, non-significant by all 6 methods)
- Spearman rho = 0.176 (clearly positive, significant)
- |r - rho| = 0.157 -- the largest gap in the entire dataset

What this means: OLS finds no relationship between income inequality at the top and mobility. But if you look at ranks, there IS a positive, monotonic relationship. The reason Pearson finds nothing is likely that the data is highly non-linear -- perhaps there's a threshold effect, or a few extreme outliers are canceling out the trend in the linear space. OLS is literally blind to this relationship because it forces a straight line.

This is a substantively important finding: if you relied only on Chetty et al.'s OLS results, you would conclude Top 1% Income Share doesn't matter. But the data suggests it does -- you just need a method that can see the non-linear pattern.

**Growth in Chinese Imports:**
Spearman (0.331) is nearly double Pearson (0.171). The outlier CZs with extreme import exposure are compressing the linear correlation. The rank-based correlation is a better representation of the true relationship.

---

## Slide 8: Summary of Findings

### What the slide says:
A four-row summary table of violation prevalence and impact, followed by three bottom-line conclusions.

### What you need to understand and say:

This slide is your conclusion for the main analysis. Walk through each row:

**Heteroskedasticity (91%):**
Almost universal. But robust methods are designed for exactly this situation, and they agree with classical OLS. The violation is widespread but inconsequential for the significance conclusions.

**Non-normal residuals (83%):**
Very common. But at n ~ 700, the Central Limit Theorem saves us, and permutation tests confirm this. Again, inconsequential for significance conclusions.

**High-influence outliers (9%):**
Rare, but when it occurs (especially Violent Crime Rate), it can matter. Cook's D = 12.28 causes HC3 to flip from significant to non-significant. This is a genuine methodological concern for that specific covariate.

**Non-linearity (9%):**
Rare, but qualitatively important. Top 1% Income Share appears non-significant by OLS but has a real monotonic relationship (Spearman rho = 0.176). This is a case where OLS is giving a misleading answer.

**The three takeaways -- memorize these:**

1. **OLS violations are the norm, not the exception.** Chetty et al. used OLS throughout, and virtually all 35 regressions fail at least one assumption. This is not a criticism of their paper -- it's the reality of observational social science data.

2. **At n ~ 700, violations don't change significance conclusions.** This is the robustness result. The conclusions are not fragile.

3. **Diagnostics reveal things p-values hide.** Even when significance doesn't change, the diagnostics tell us qualitatively important things: one CZ dominates the violent crime result; Top 1% Income Share has a masked non-linear relationship; Chinese imports are outlier-driven. These insights would be invisible if you only looked at p-values.

---

## Slide 9: Subgroup Diagnostics -- Overview

### What the slide says:
We ran the same 35 regressions for 3 subgroup outcomes (Females, Males, Single Parents), giving 105 additional regressions. The overview table shows how violation rates compare to baseline.

### What you need to understand and say:

**Why subgroups?**
Chetty et al. didn't just measure one mobility number. They measured mobility separately for boys vs. girls, and for children born to single parents vs. married parents. These are separate outcome variables -- each CZ has a different mobility estimate depending on whose children you're tracking. We re-ran all 35 regressions using each of these alternate outcomes.

**Key patterns in the table:**

- **Heteroskedasticity decreases** slightly for Males (69%) and Single Parents (63%) compared to baseline (91%). The variance structure depends on which group's mobility you're measuring.

- **Non-normality increases dramatically for Males and Single Parents.** Males: 97%. Single Parents: 100%. Every single regression for Single Parents has non-normal residuals. This makes sense -- the single-parent mobility distribution is more skewed and has thinner tails because it's a more homogeneous subgroup.

- **Cook's D > 1 outliers are rare across all subgroups.** The pattern is similar to baseline (1-3 cases out of 35), suggesting extreme outliers are not systematically more common for any subgroup.

- **Non-linearity (|r - rho| > 0.1) is similar across subgroups.** 1-3 cases in each, consistent with the baseline.

**The headline:** The assumption violations are structural features of the data and the CZ characteristics, not artifacts of how the baseline mobility is defined. They persist across all subgroup outcomes.

---

## Slide 10: Violent Crime Rate is No Longer a Diagnostic Outlier

### What the slide says:
The extreme Cook's D = 12.28 from baseline disappears in all subgroup regressions. New high-influence covariates emerge.

### What you need to understand and say:

**This is a fascinating and unexpected finding.**

In the baseline, one CZ was so extreme in the Violent Crime Rate regression that it had a Cook's D of 12.28 -- 12 times the standard concern threshold. But when we switch to measuring mobility for Females, Males, or Single Parents, that same CZ's Cook's D drops to 0.07-0.20 -- completely normal.

**Why would this happen?**
The baseline mobility measure is an average across all children. If that one CZ has an extreme violent crime rate AND its mobility estimate is particularly unusual (high or low), it exerts massive leverage. But subgroup mobility estimates are more noisy -- there are fewer children per CZ in each subgroup, so the estimates are more variable and less likely to create the perfect storm of high leverage + high influence.

In other words: the Cook's D = 12.28 was partly an artifact of how the baseline RM is constructed (averaging across all children, which happens to make one CZ a statistical outlier for this particular regression).

**New outliers emerge:**
- Local Government Expenditures for Single Parents: Cook's D = 3.29
- Growth in Chinese Imports for Males: Cook's D = 2.35
- Top 1% Income Share for Females: Cook's D = 1.75

These weren't as extreme in the baseline. Different subgroup outcomes have different CZs that are "leverage points." This is not alarming -- it's telling us which specific communities are unusual for each subgroup.

---

## Slide 11: Non-Normality Intensifies for Single Parents

### What the slide says:
Single Parents has 100% of regressions with non-normal residuals (vs. 83% baseline), and 28 of 35 with JB p-value below 1e-10 (extreme non-normality). Permutation tests still agree.

### What you need to understand and say:

**Why Single Parents RM is more non-normal:**
Single-parent mobility is a noisier and more skewed outcome. CZs with large single-parent populations may look very different from CZs with small ones. The residuals from regressing any X on this outcome tend to have heavier tails.

**The critical robustness point:**
Despite 100% of regressions showing non-normal residuals -- with 28 of 35 showing catastrophically non-normal distributions (p < 1e-10 means the probability of getting this by chance under normality is essentially zero) -- the permutation tests still agree with classical methods.

This is the strongest stress test of the "n ~ 700 makes normality irrelevant" conclusion. We have essentially the worst possible violation of normality, applied to 35 regressions simultaneously, and it still doesn't change significance conclusions. You can say with confidence: **normality violations do not matter for these inferences at this sample size.**

**Non-linearity is stable:**
Top 1% Income Share and Growth in Chinese Imports both show |r - rho| > 0.1 for Females and Males. This means the non-linearity is not a baseline artifact -- it's a real structural feature of how these variables relate to mobility, regardless of which subgroup you measure.

---

## Slide 12: Subgroup Diagnostics Summary

### What the slide says:
A five-row summary table of subgroup findings, with a bottom-line conclusion.

### What you need to understand and say:

Walk through each row:

**"Heteroskedasticity persists (63-91%)":**
The range reflects that different subgroups have different variance structures, but heteroskedasticity is present everywhere. This is driven by the CZ characteristics themselves (X variables), not by which RM you're measuring.

**"Non-normality intensifies for Single Parents (100%)":**
The worst possible case, and permutation tests still agree. Normality violations are irrelevant at n ~ 700. Full stop.

**"Violent Crime Rate outlier disappears":**
The Cook's D = 12.28 was a baseline artifact. Subgroup outcomes don't produce the same extreme leverage situation. This partially reassures us about the baseline finding -- it was driven by an unusual interaction between the specific outcome variable and this one CZ.

**"New outliers emerge":**
High-influence CZs vary depending on which outcome you're measuring. This is expected and not alarming. The key point is that there are always 1-3 such cases, and they rarely change significance conclusions.

**"Top 1% Income Share remains non-linear":**
This is perhaps the most durable qualitative finding. Across multiple subgroups (Females, Males), Spearman rho > 0.14 while Pearson r is near 0. The non-linear relationship between top-end inequality and mobility is a consistent structural feature, not a statistical artifact.

**The bottom line:**
Diagnostic profiles are consistent across subgroups -- the violations are in the data, not in the methodology. The robustness conclusion holds for all subgroups: assumption violations are pervasive but do not change significance conclusions. And qualitative insights (non-linearity, specific outlier CZs) vary by subgroup in informative ways.

---

## Slide 13: References

### What to say:
These are the four papers underlying our methodology:

- **Chetty et al. (2014)**: The paper we are replicating. Published in one of the top economics journals (QJE). IRS tax record data, 709 Commuting Zones.

- **DiCiccio & Romano (2017)**: The theoretical basis for our permutation regression test. Proves that permutation inference with HC0 robust variance estimation is valid for correlation and regression. This is the method we call "perm_test_regression" in our code.

- **Breusch & Pagan (1979)** and **White (1980)**: The two classic papers proposing the heteroskedasticity tests we use. Standard tools in applied econometrics.

- **Jarque & Bera (1987)**: The normality test based on skewness and kurtosis. Also a standard diagnostic tool.

---

## Quick Reference: Key Numbers to Remember

| Statistic | Value |
|-----------|-------|
| Total regressions (main) | 35 |
| Commuting Zones in sample | 709 |
| Heteroskedastic regressions | 32/35 (91%) |
| Non-normal residual regressions | 29/35 (83%) |
| Violent Crime Rate Cook's D | 12.28 (next highest: 1.98) |
| Methods that disagreed on Violent Crime Rate | 1 of 6 (HC3 only) |
| Top 1% Income Share Pearson r | ~0 (non-significant) |
| Top 1% Income Share Spearman rho | 0.176 (significant) |
| Single Parents non-normality rate | 35/35 (100%) |
| Subgroup regressions total | 105 (35 x 3 subgroups) |
