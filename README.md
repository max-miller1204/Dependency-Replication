# Replicating Chetty et al. (2014): Classical vs Permutation Inference

## Overview

This project replicates key findings from **"Where is the Land of Opportunity? The Geography of Intergenerational Mobility in the United States"** by Chetty, Hendren, Kline, and Saez (2014), then compares classical inference with permutation-based inference methods.

**Goal**: Demonstrate that the original findings are robust to the choice of statistical inference method.

## Key Findings

### Main Analysis: 6 Methods Compared

- **35 covariates** tested across 10 categories
- **32/35 (91.4%)** significantly associated with relative mobility
- **100% agreement** between all six methods on significance conclusions
- Results are **robust** to the choice of inference method

### Experimental: HC3 Permutation Test

We also ran an experimental HC3-based permutation test to investigate whether classical HC3's conservativeness persists in permutation inference.

**Key finding for Violent Crime Rate:**

| Method | p-value | Significant? |
|--------|---------|--------------|
| Classical HC0 | 0.030 | YES |
| Classical HC3 | 0.247 | NO |
| Permutation HC0 | 0.0001 | YES |
| **Permutation HC3** | **0.0001** | **YES** |

The HC3 permutation test agrees with HC0 permutation, not classical HC3. This suggests classical HC3's conservativeness is an artifact of the asymptotic approximation.

See `experimental/hc3_findings.md` for full details.

## Project Structure

```
Dependency-Replication/
├── README.md
├── CLAUDE.md                      # Claude Code instructions
├── .gitignore
│
├── analysis/                      # Main analysis code
│   ├── mobility_analysis.Rmd      # Primary analysis (RMarkdown)
│   ├── mobility_analysis.R        # Standalone R script
│   └── mobility_analysis.pdf      # Compiled report
│
├── experimental/                  # Experimental work
│   ├── README.md                  # Explains experimental status
│   ├── hc3_permutation_test.Rmd   # HC3 permutation test
│   └── hc3_findings.md            # Results summary
│
├── data/                          # Data files
│   ├── Online_Data_Table_5.csv    # Mobility estimates by CZ
│   ├── Online_Data_Table_8.csv    # CZ characteristics
│   └── all_tables/                # All 9 tables for reference
│
├── results/                       # Analysis outputs
│   ├── main/                      # Main analysis results
│   │   ├── mobility_test_results.csv
│   │   ├── coefficient_plot.png
│   │   └── mobility_analysis_workspace.RData
│   └── experimental/              # Experimental results
│       ├── mobility_test_results_hc3_experimental.csv
│       ├── coefficient_plot_hc3_experimental.png
│       └── mobility_analysis_hc3_experimental_workspace.RData
│
├── docs/                          # Documentation
│   ├── analysis_guide.md          # Detailed methodology
│   ├── DATA_FLOW_DOCUMENTATION.md # Data provenance
│   ├── output_explanation.md      # Output file docs
│   └── why_table_viii.md          # Why we replicate Table VIII
│
└── references/                    # Reference materials
    ├── papers/                    # Academic papers
    └── original_replication/      # Chetty et al. replication materials
```

## Methods Compared

### Non-Permutation Methods (4)

| Method | Test Statistic | Properties |
|--------|----------------|------------|
| **cor.test** | Pearson r | Classical correlation t-test |
| **summary(lm)** | t = β̂/SE(β̂) | Classical OLS (Chetty et al. approach) |
| **waldtest HC0** | Wald F | Heteroskedasticity-robust |
| **waldtest HC3** | Wald F | HC-robust with small-sample correction |

### Permutation Methods (2)

| Method | Test Statistic | Properties |
|--------|----------------|------------|
| **perk** | Pearson r | Permutation correlation test |
| **perm_test_regression** | Robust Wald Sₙ | DiCiccio & Romano (2017) |

### Experimental: HC3 Permutation (1)

| Method | Test Statistic | Properties |
|--------|----------------|------------|
| **perm_test_regression_hc3** | HC3 Wald Sₙ | Experimental, no theoretical backing |

## Quick Start

### Prerequisites

```r
install.packages(c("tidyverse", "broom", "perk", "sandwich", "lmtest"))
```

### Run Main Analysis

```r
setwd("analysis")
rmarkdown::render("mobility_analysis.Rmd")
```

**Expected runtime**: ~15 minutes

### Run Experimental Analysis

```r
setwd("experimental")
rmarkdown::render("hc3_permutation_test.Rmd")
```

**Expected runtime**: ~22-25 minutes

## Data Sources

| Table | Contents | Source |
|-------|----------|--------|
| Online Data Table 5 | Mobility estimates by CZ | IRS tax records (restricted, published) |
| Online Data Table 8 | CZ characteristics | Census, public data |

**Sample**: 709 Commuting Zones with ≥250 children

## Key Results

**Strongest Predictors of Low Mobility:**

| Covariate | β | p-value |
|-----------|---|---------|
| Fraction Single Mothers | 0.64 | < 0.001 |
| Fraction Black | 0.63 | < 0.001 |
| Gini Bottom 99% | 0.47 | < 0.001 |

**Non-Significant Covariates:**

| Covariate | β | p-value |
|-----------|---|---------|
| Top 1% Income Share | 0.02 | 0.617 |
| Teacher-Student Ratio | 0.01 | 0.805 |
| College Graduation Rate | -0.03 | 0.553 |

## References

1. **Chetty, R., Hendren, N., Kline, P., & Saez, E.** (2014). Where is the Land of Opportunity? The Geography of Intergenerational Mobility in the United States. *Quarterly Journal of Economics*, 129(4), 1553-1623.

2. **DiCiccio, C. J., & Romano, J. P.** (2017). Robust Permutation Tests For Correlation And Regression Coefficients. *Journal of the American Statistical Association*, 112(519), 1211-1220.

3. **Jaimes, A.** (2025). Where is the Land of Opportunity Replication.

4. **perk** R package: Permutation tests for correlation coefficients.

5. **sandwich** R package: Robust covariance matrix estimators.

6. **lmtest** R package: Testing linear regression models.

## License

This project uses publicly available data from the [Equality of Opportunity Project](https://opportunityinsights.org/data/).
