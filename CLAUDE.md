# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Replicates findings from Chetty et al. (2014) "Where is the Land of Opportunity?" and compares classical OLS inference with permutation-based inference methods. Demonstrates that the original mobility findings are robust to the choice of statistical inference method.

## Environment

R runs inside a dev container (rocker tidyverse 4.4), not on the host. Use `docker exec <container_name> R -q -e '...'` to run R commands. Find the container name with `docker ps`. RStudio Server is on port 8787.

Package management uses `renv`. After modifying dependencies: `renv::snapshot()`. To restore: `renv::restore()`. The `perk` package is from GitHub (`hyu-ub/perk`, subdir `perk`), not CRAN — if it disappears after restart, use `renv::restore()`.

## Key Commands

### Run Analyses (from repo root)
```bash
cd analysis && Rscript -e 'rmarkdown::render("mobility_analysis.Rmd")'        # ~15 min
cd analysis && Rscript -e 'rmarkdown::render("subgroup_mobility_analysis.Rmd")' # ~75 min
cd experimental && Rscript -e 'rmarkdown::render("hc3_permutation_test.Rmd")'  # ~22-25 min
```

### Lint
```bash
docker exec <container> R -q -e 'lintr::lint("analysis/mobility_analysis.Rmd")'
```

`.lintr` config: line length 120, disabled object_name_linter (math variable convention), object_usage_linter (cross-chunk Rmd), indentation_linter.

## Architecture

### Three Analysis Pipelines

All three share the same data loading pattern and permutation test implementation:

```
data/Online_Data_Table_5.csv  →  Dependent variable(s): Relative Mobility (RM)
data/Online_Data_Table_8.csv  →  Independent variables: 35 Covariates
```

1. **Main analysis** (`analysis/mobility_analysis.Rmd`): Tests 35 covariates against baseline RM using 6 methods (4 classical + 2 permutation). Includes regression diagnostics table (8 stats per covariate). Outputs to `results/main/`.

2. **Subgroup analysis** (`analysis/subgroup_mobility_analysis.Rmd`): Runs the same 6-method comparison for 5 RM variants (baseline, females, males, single parents, married parents). Replicates Table VI methodology. Key test: does "Fraction Single Mothers" predict RM even for children of married parents (community-level effects)? Outputs to `results/subgroups/`.

3. **Experimental HC3** (`experimental/hc3_permutation_test.Rmd`): Adds a 7th method — HC3-based permutation regression. **Not formally proven** (DiCiccio & Romano only proved HC0). Investigates whether classical HC3's conservativeness on Violent Crime Rate persists in permutation framework. Outputs to `results/experimental/`.

### Statistical Methods
| Method | Type | Key Property |
|--------|------|-------------|
| `summary(lm)` | Classical regression | Assumes homoskedasticity |
| `cor.test` | Classical correlation | t-test |
| `waldtest` HC0 | Classical regression | Heteroskedasticity-robust |
| `waldtest` HC3 | Classical regression | Small-sample correction |
| `perk::perk_test` | Permutation correlation | Distribution-free |
| `perm_test_regression` | Permutation regression | HC0, DiCiccio & Romano Thm 3.2 |
| `perm_test_regression_hc3` | Experimental | HC3 variant, no formal proof |

### Key Implementation Details

**`perm_test_regression()` is defined inline** in each Rmd file (not in a shared package/source file). Changes must be replicated across all three files.

**Permutation regression** implements DiCiccio & Romano (2017) Theorem 3.2:
- Uses HC0 heteroskedasticity-robust variance estimator
- Requires mean-centered X and Y (standardize then re-center)
- Always includes an intercept per Remark 3.1
- P-value uses +1 correction (Phipson & Smyth, 2010): `(sum(S_perm >= S_obs) + 1) / (B + 1)`

**`diagnostics_fun(model, X, Y)`** (main analysis only) takes a pre-fitted `lm` object to avoid redundant model fitting. Computes: Pearson r, Spearman rho, |r - rho|, Breusch-Pagan p, White p, Jarque-Bera p, max Cook's D, max leverage.

**`covariate_name_map`** and **`clean_covariate_name()`** (main analysis) provide a single-source mapping from R-mangled column names to human-readable names, used by both the diagnostics and results tables.

**CSV loading gotchas:**
- Table 5: `skip = 49` rows of metadata; must filter rows matching `"^\\(\\d+\\)$"` pattern
- Table 8: `skip = 6` rows; filter rows where CZ code (col 1) is positive

**Table 5 subgroup column indices** (used in subgroup analysis):
- Col 6: RM (baseline, 80-82 cohort)
- Col 13: RM, Females
- Col 15: RM, Males
- Col 23: RM, Single Parents
- Col 25: RM, Married Parents

## Data Sources

Data from the Equality of Opportunity Project:
- **Table 5**: Mobility estimates by CZ (derived from restricted IRS tax records, but published)
- **Table 8**: CZ characteristics from public sources (Census, CCD, IPEDS)
- Sample restricted to CZs with >= 250 children (709 of 741 total CZs)

## Results Structure

```
results/
├── main/
│   ├── mobility_test_results.csv       # 6 methods × 35 covariates
│   ├── regression_diagnostics.csv      # 8 diagnostic stats × 35 covariates
│   ├── coefficient_plot.png
│   └── mobility_analysis_workspace.RData
├── subgroups/
│   ├── subgroup_mobility_results.csv   # 6 methods × 35 covariates × 5 RM variants
│   ├── subgroup_coefficient_plot.png
│   └── subgroup_analysis_workspace.RData
└── experimental/
    ├── mobility_test_results_hc3_experimental.csv
    ├── coefficient_plot_hc3_experimental.png
    └── mobility_analysis_hc3_experimental_workspace.RData
```
