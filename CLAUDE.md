# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This project replicates findings from Chetty et al. (2014) "Where is the Land of Opportunity?" and compares classical OLS inference with permutation-based inference methods. The goal is to demonstrate that the original mobility findings are robust to the choice of statistical inference method.

## Key Commands

### Run the Main Analysis
```r
setwd("analysis")
rmarkdown::render("mobility_analysis.Rmd")
```

### Run Experimental Analysis (HC3 permutation test)
```r
setwd("experimental")
rmarkdown::render("hc3_permutation_test.Rmd")
```

### Install Required R Packages
```r
install.packages(c("tidyverse", "broom", "perk", "sandwich", "lmtest"))
```

**Expected runtime**:
- Main analysis: ~15 minutes
- Experimental: ~22-25 minutes

## Architecture

### Data Flow
```
data/Online_Data_Table_5.csv  →  Relative Mobility (Y) - dependent variable
data/Online_Data_Table_8.csv  →  35 Covariates (X)    - independent variables
         ↓
   analysis/mobility_analysis.Rmd
         ↓
┌────────────────┬────────────────┐
│ NON-PERMUTATION│  PERMUTATION   │
├────────────────┼────────────────┤
│ cor.test       │ perk           │
│ summary(lm)    │ perm_test_reg  │
│ waldtest HC0   │                │
│ waldtest HC3   │                │
└────────────────┴────────────────┘
         ↓
   Compare p-values and significance
         ↓
   results/main/
```

### Statistical Methods
| Method | Type | Test Statistic | Properties |
|--------|------|----------------|------------|
| cor.test | Non-perm (correlation) | Pearson r | Classical t-test |
| summary(lm) | Non-perm (regression) | t = β̂/SE(β̂) | Assumes homoskedasticity |
| waldtest HC0 | Non-perm (regression) | Wald F | Heteroskedasticity-robust |
| waldtest HC3 | Non-perm (regression) | Wald F | HC-robust, small-sample correction |
| perk | Permutation (correlation) | Pearson r | Permutation-based |
| perm_test_regression | Permutation (regression) | Robust Wald Sₙ | HC-robust, permutation-based |
| perm_test_regression_hc3 | Permutation (experimental) | HC3 Wald Sₙ | Experimental, no formal proof |

### Project Structure
```
Dependency-Replication/
├── analysis/                      # Main analysis code
│   ├── mobility_analysis.Rmd      # Primary analysis
│   ├── mobility_analysis.R        # Standalone R script
│   └── mobility_analysis.pdf      # Compiled report
│
├── experimental/                  # Experimental work
│   ├── hc3_permutation_test.Rmd   # HC3 permutation test
│   ├── hc3_findings.md            # Results summary
│   └── README.md
│
├── data/                          # Data files
│   ├── Online_Data_Table_5.csv    # Mobility estimates
│   ├── Online_Data_Table_8.csv    # CZ characteristics
│   └── all_tables/                # All 9 tables
│
├── results/                       # Analysis outputs
│   ├── main/                      # Main analysis results
│   └── experimental/              # Experimental results
│
├── docs/                          # Documentation
│   ├── analysis_guide.md
│   ├── DATA_FLOW_DOCUMENTATION.md
│   ├── output_explanation.md
│   └── why_table_viii.md
│
└── references/                    # Reference materials
    ├── papers/
    └── original_replication/
```

### Key Implementation Details

The permutation regression test (`perm_test_regression()`) implements DiCiccio & Romano (2017) Theorem 3.2:
- Uses HC0 heteroskedasticity-robust variance estimator
- Requires mean-centered X and Y
- Always includes an intercept per Remark 3.1

The experimental HC3 variant (`perm_test_regression_hc3()`) uses HC3 instead of HC0. **Caveat:** Not formally proven.

CSV column names are processed by R (spaces → dots, special chars → dots). The covariate mapping in the code handles this translation.

## Data Sources

Data comes from the Equality of Opportunity Project:
- Tables 1-7: Derived from restricted IRS tax records (not reproducible)
- Table 8: Public data (Census, CCD, IPEDS) - reproducible
- Sample restricted to CZs with ≥250 children (709 of 741 total CZs)
