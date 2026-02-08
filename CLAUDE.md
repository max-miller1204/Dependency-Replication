# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Replicates findings from Chetty et al. (2014) "Where is the Land of Opportunity?" and compares classical OLS inference with permutation-based inference methods. Demonstrates that the original mobility findings are robust to the choice of statistical inference method.

## Key Commands

### Run Analyses (from repo root)
```bash
cd analysis && Rscript -e 'rmarkdown::render("mobility_analysis.Rmd")'        # ~15 min
cd analysis && Rscript -e 'rmarkdown::render("subgroup_mobility_analysis.Rmd")' # ~75 min (5 subgroups x 35 covariates)
cd experimental && Rscript -e 'rmarkdown::render("hc3_permutation_test.Rmd")'  # ~22-25 min
```

### Install Required R Packages
```r
install.packages(c("tidyverse", "broom", "perk", "sandwich", "lmtest", "patchwork"))
```

## Architecture

### Three Analysis Pipelines

All three share the same data loading and permutation test implementation pattern:

```
data/Online_Data_Table_5.csv  →  Dependent variable(s): Relative Mobility (RM)
data/Online_Data_Table_8.csv  →  Independent variables: 35 Covariates
```

1. **Main analysis** (`analysis/mobility_analysis.Rmd`): Tests 35 covariates against baseline RM using 6 methods (4 classical + 2 permutation). Outputs to `results/main/`.

2. **Subgroup analysis** (`analysis/subgroup_mobility_analysis.Rmd`): Runs the same 6-method comparison for 5 RM variants (baseline, females, males, single parents, married parents). Replicates Table VI methodology from Chetty et al. Key test: does "Fraction Single Mothers" predict RM even for children of married parents (community-level effects)? Outputs to `results/subgroups/`.

3. **Experimental HC3** (`experimental/hc3_permutation_test.Rmd`): Adds a 7th method—HC3-based permutation regression. **Not formally proven** (DiCiccio & Romano only proved HC0). Investigates whether classical HC3's conservativeness on Violent Crime Rate persists in permutation framework. Outputs to `results/experimental/`.

### Statistical Methods
| Method | Type | Statistic | Key Property |
|--------|------|-----------|--------------|
| `cor.test` | Classical correlation | Pearson r | t-test |
| `summary(lm)` | Classical regression | t = β̂/SE(β̂) | Assumes homoskedasticity |
| `waldtest` HC0 | Classical regression | Wald F | Heteroskedasticity-robust |
| `waldtest` HC3 | Classical regression | Wald F | Small-sample correction |
| `perk::perk_test` | Permutation correlation | Pearson r | Distribution-free |
| `perm_test_regression` | Permutation regression | Robust Wald Sₙ | HC0, DiCiccio & Romano Thm 3.2 |
| `perm_test_regression_hc3` | Experimental | HC3 Wald Sₙ | No formal proof |

### Key Implementation Details

**Permutation regression** (`perm_test_regression()`) implements DiCiccio & Romano (2017) Theorem 3.2:
- Uses HC0 heteroskedasticity-robust variance estimator
- Requires mean-centered X and Y (standardize then re-center)
- Always includes an intercept per Remark 3.1
- P-value uses +1 correction (Phipson & Smyth, 2010): `(sum(S_perm >= S_obs) + 1) / (B + 1)`

**CSV loading gotchas:**
- Table 5: `skip = 49` rows of metadata; must filter rows matching `"^\\(\\d+\\)$"` pattern
- Table 8: `skip = 6` rows; filter rows where CZ code (col 1) is positive
- Column names: R converts spaces/special chars to dots. The `covariates_to_test` list maps these R-processed names to their human-readable equivalents via a `case_when` block.

**Table 5 subgroup column indices** (used in subgroup analysis):
- Col 6: RM (baseline, 80-82 cohort)
- Col 13: RM, Females
- Col 15: RM, Males
- Col 23: RM, Single Parents
- Col 25: RM, Married Parents

**`perm_test_regression()` is defined inline** in each Rmd file (not in a shared package/source file). Changes must be replicated across all three files.

## Data Sources

Data from the Equality of Opportunity Project:
- **Table 5**: Mobility estimates by CZ (derived from restricted IRS tax records, but published)
- **Table 8**: CZ characteristics from public sources (Census, CCD, IPEDS)
- Sample restricted to CZs with ≥250 children (709 of 741 total CZs)
