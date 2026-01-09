# Replicating Chetty et al. (2014): Classical vs Permutation Inference

## Overview

This project replicates key findings from **"Where is the Land of Opportunity? The Geography of Intergenerational Mobility in the United States"** by Chetty, Hendren, Kline, and Saez (2014), then compares classical OLS inference with two permutation-based inference methods.

**Goal**: Demonstrate that the original findings are robust to the choice of statistical inference method.

## Methods Compared

| Method | Test Statistic | Source |
|--------|----------------|--------|
| **Classical OLS** | t = β̂/SE(β̂) | Chetty et al. (2014) original approach |
| **perk (Permutation Correlation)** | Pearson r | `perk` R package |
| **Permutation Regression** | Robust Wald Sₙ | DiCiccio & Romano (2017) |

### The Comparison Structure

```
                    Classical OLS (Chetty et al.'s original method)
                                    ↑
                         Compare significance
                           ↗              ↖
            perk (perm correlation)    DiCiccio & Romano (perm regression)
```

### Why Two Permutation Methods?

| If... | Then... |
|-------|---------|
| All three agree | Very strong evidence the findings are robust |
| Classical ≠ permutation | Normality assumption might be affecting conclusions |
| perk ≠ DiCiccio & Romano | Heteroskedasticity might be an issue |

## Key Findings

- **35 covariates** tested across 10 categories
- **32/35 (91.4%)** significantly associated with relative mobility
- **100% agreement** between all three methods on significance conclusions
- Results are **robust** to the choice of inference method

## Project Structure

```
Dependency-Replication/
├── R_code/
│   ├── mobility_analysis.Rmd      # Main analysis (RMarkdown)
│   ├── mobility_analysis.pdf      # Compiled results
│   ├── analysis_guide.md          # Detailed methodology guide
│   ├── why_table_viii.md          # Why we replicate Table VIII
│   ├── Online_Data_Table_5.csv    # Mobility estimates by CZ
│   ├── Online_Data_Table_8.csv    # CZ characteristics (covariates)
│   └── output/
│       ├── mobility_test_results.csv      # Full results table
│       ├── coefficient_plot.png           # Visualization
│       ├── output_explanation.md          # Output documentation
│       └── mobility_analysis_workspace.RData
├── context/
│   └── DATA_FLOW_DOCUMENTATION.md # Data provenance documentation
├── paper_info/
│   └── where_is_the_land_of_opportunity_replication.pdf  # Alex Jaimes' paper
└── README.md
```

## Quick Start

### Prerequisites

```r
install.packages(c("tidyverse", "broom", "perk"))
```

### Run the Analysis

```r
setwd("path/to/R_code")
rmarkdown::render("mobility_analysis.Rmd")
```

### Expected Runtime
- ~15 minutes (10,000 permutations × 35 covariates × 2 methods)

## The Analysis

### What We're Testing

For each of 35 community-level characteristics, we test:

> "Is this characteristic significantly associated with intergenerational mobility?"

Using three methods:
1. **Classical OLS**: Standard t-test (assumes normality)
2. **perk**: Permutation correlation test (simple, not studentized)
3. **Permutation Regression**: DiCiccio & Romano's robust test (heteroskedasticity-robust)

### Why Permutation Tests?

Classical inference relies on asymptotic theory that may be unreliable when:
- Sample sizes are moderate (n ≈ 700 CZs)
- Residuals are non-normal or heteroskedastic
- Spatial correlation exists between nearby CZs

Permutation tests provide:
- No distributional assumptions
- Heteroskedasticity robustness (DiCiccio & Romano)
- Exact p-values under the null hypothesis

### Why Both Permutation Tests?

Both test the **same null hypothesis** (H₀: no relationship), but use **different test statistics**:

| Test | Test Statistic | Properties |
|------|----------------|------------|
| perk | Pearson r | Simple, not studentized |
| DiCiccio & Romano | Robust Wald Sₙ | Studentized, heteroskedasticity-robust |

Comparing them answers: **"Does accounting for heteroskedasticity change our conclusions?"**

### Key Results

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

## Data Sources

| Table | Contents | Source |
|-------|----------|--------|
| Online Data Table 5 | Mobility estimates by CZ | IRS tax records (restricted, published) |
| Online Data Table 8 | CZ characteristics | Census, public data |

**Sample**: 709 Commuting Zones with ≥250 children

### Why Table VIII?

We replicate Online Appendix Table VIII because:
- Tables 1-7 use restricted IRS data (cannot be reproduced from raw data)
- Table VIII uses *published* mobility estimates + public covariates (reproducible!)
- This is where the key policy findings come from

## References

1. **Chetty, R., Hendren, N., Kline, P., & Saez, E.** (2014). Where is the Land of Opportunity? The Geography of Intergenerational Mobility in the United States. *Quarterly Journal of Economics*, 129(4), 1553-1623.

2. **DiCiccio, C. J., & Romano, J. P.** (2017). Robust Permutation Tests For Correlation And Regression Coefficients. *Journal of the American Statistical Association*, 112(519), 1211-1220.

3. **Jaimes, A.** (2025). Where is the Land of Opportunity Replication. [Implementation of permutation regression test]

4. **perk** R package: Permutation tests for correlation coefficients. Available on CRAN.

## License

This project uses publicly available data from the [Equality of Opportunity Project](https://opportunityinsights.org/data/).
