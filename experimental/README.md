# Experimental Analyses

This directory contains experimental work that extends the main analysis but does not have full theoretical backing.

## Contents

| File | Description |
|------|-------------|
| `hc3_permutation_test.Rmd` | HC3-based permutation regression test |
| `hc3_findings.md` | Summary of HC3 experiment results |

## HC3 Permutation Test

### What It Does

Implements a permutation regression test using the HC3 variance estimator instead of HC0. This creates a full 2x2 comparison:

|                | Classical | Permutation |
|----------------|-----------|-------------|
| **HC0**        | waldtest HC0 | perm_test_reg (HC0) |
| **HC3**        | waldtest HC3 | perm_test_reg (HC3) |

### Why It's Experimental

DiCiccio & Romano (2017) only proved the validity of the permutation regression test using the **HC0** variance estimator. The HC3 variant implemented here:

- Does **NOT** have formal theoretical backing
- Is implemented for **diagnostic purposes only**
- Should be interpreted with caution

### Key Finding

The HC3 permutation test agrees with HC0 permutation, not with classical HC3. This suggests classical HC3's conservativeness is an artifact of the asymptotic approximation.

See `hc3_findings.md` for full details.

## Running the Analysis

```r
setwd("experimental")
rmarkdown::render("hc3_permutation_test.Rmd")
```

**Expected runtime:** ~22-25 minutes

## Output

Results are saved to `../results/experimental/`:
- `mobility_test_results_hc3_experimental.csv`
- `coefficient_plot_hc3_experimental.png`
- `mobility_analysis_hc3_experimental_workspace.RData`
