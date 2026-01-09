# Replicating Chetty et al. (2014): Classical vs Permutation Inference

## Overview

This project replicates key findings from **"Where is the Land of Opportunity? The Geography of Intergenerational Mobility in the United States"** by Chetty, Hendren, Kline, and Saez (2014), then compares classical OLS inference with permutation-based inference.

**Goal**: Demonstrate that the original findings are robust to the choice of statistical inference method.

## Methods Compared

| Method | Description | Source |
|--------|-------------|--------|
| **Classical OLS** | Standard regression with t-test inference | Chetty et al. (2014) |
| **Permutation Regression** | Heteroskedasticity-robust permutation test | DiCiccio & Romano (2017) |

## Key Findings

- **35 covariates** tested across 10 categories
- **32/35 (91.4%)** significantly associated with relative mobility
- **100% agreement** between classical and permutation methods on significance conclusions
- Results are **robust** to the choice of inference method

## Project Structure

```
Dependency-Replication/
├── R_code/
│   ├── mobility_analysis.Rmd      # Main analysis (RMarkdown)
│   ├── mobility_analysis.pdf      # Compiled results
│   ├── analysis_guide.md          # Detailed methodology guide
│   ├── Online_Data_Table_5.csv    # Mobility estimates by CZ
│   ├── Online_Data_Table_8.csv    # CZ characteristics (covariates)
│   └── output/
│       ├── mobility_test_results.csv      # Full results table
│       ├── coefficient_plot.png           # Visualization
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
install.packages(c("tidyverse", "broom"))
```

### Run the Analysis

```r
setwd("path/to/R_code")
rmarkdown::render("mobility_analysis.Rmd")
```

### Expected Runtime
- ~10 minutes (10,000 permutations per covariate)

## The Analysis

### What We're Testing

For each of 35 community-level characteristics, we test:

> "Is this characteristic significantly associated with intergenerational mobility?"

Using both:
1. **Classical OLS**: Standard t-test (assumes normality)
2. **Permutation Regression**: DiCiccio & Romano's robust test (no distributional assumptions)

### Why Permutation Tests?

Classical inference relies on asymptotic theory that may be unreliable when:
- Sample sizes are moderate (n ≈ 700 CZs)
- Residuals are non-normal or heteroskedastic
- Spatial correlation exists between nearby CZs

Permutation tests provide:
- No distributional assumptions
- Heteroskedasticity robustness
- Exact p-values under the null hypothesis

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
| Online Data Table 5 | Mobility estimates by CZ | IRS tax records (restricted) |
| Online Data Table 8 | CZ characteristics | Census, public data |

**Sample**: 709 Commuting Zones with ≥250 children

## References

1. **Chetty, R., Hendren, N., Kline, P., & Saez, E.** (2014). Where is the Land of Opportunity? The Geography of Intergenerational Mobility in the United States. *Quarterly Journal of Economics*, 129(4), 1553-1623.

2. **DiCiccio, C. J., & Romano, J. P.** (2017). Robust Permutation Tests For Correlation And Regression Coefficients. *Journal of the American Statistical Association*, 112(519), 1211-1220.

3. **Jaimes, A.** (2025). Where is the Land of Opportunity Replication. [Implementation of permutation regression test]

## License

This project uses publicly available data from the [Equality of Opportunity Project](https://opportunityinsights.org/data/).
