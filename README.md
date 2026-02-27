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

### Subgroup Analysis: 5 RM Variants

Extends the main analysis to subgroup-specific relative mobility measures (females, males, single parents, married parents), testing 35 covariates across 5 RM variants (175 total tests).

- **166/175 (94.9%)** of covariate-subgroup pairs have full agreement across all 6 methods
- **All 35/35** covariates agree across methods for RM of children of married parents
- Fraction Single Mothers remains a strong predictor even for children of **married** parents (β = 0.56, p < 0.001), confirming community-level effects documented in Chetty et al. Figure XIIb

| RM Subgroup | Agreement |
|-------------|-----------|
| Baseline (80-82 Cohort) | 34/35 |
| Females | 32/35 |
| Males | 32/35 |
| Single Parents | 33/35 |
| Married Parents | 35/35 |

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
├── .gitignore
├── .devcontainer/                 # Dev container configuration
│   └── devcontainer.json          # Rocker R 4.4 + RStudio Server
├── renv.lock                      # Locked R package dependencies
├── renv/                          # renv library cache
├── .Rprofile                      # Activates renv on R startup
│
├── analysis/                      # Main analysis code
│   ├── mobility_analysis.Rmd      # Primary analysis (RMarkdown)
│   ├── mobility_analysis.R        # Standalone R script
│   ├── mobility_analysis.pdf      # Compiled report
│   └── subgroup_mobility_analysis.Rmd  # Subgroup analysis
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
│   ├── subgroups/                 # Subgroup analysis results
│   │   ├── subgroup_mobility_results.csv
│   │   ├── subgroup_coefficient_plot.png
│   │   ├── beta_comparison_plots.png
│   │   └── subgroup_analysis_workspace.RData
│   └── experimental/              # Experimental results
│       ├── mobility_test_results_hc3_experimental.csv
│       ├── coefficient_plot_hc3_experimental.png
│       └── mobility_analysis_hc3_experimental_workspace.RData
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

## Replication Instructions

### Option 1: Dev Container (Recommended)

The easiest way to replicate this project is using the included dev container, which provides a fully configured R environment with RStudio Server.

**Prerequisites**: [Docker](https://docs.docker.com/get-docker/) and [VS Code](https://code.visualstudio.com/) with the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

#### Using VS Code

1. Clone the repository:
   ```bash
   git clone https://github.com/max-miller1204/Dependency-Replication.git
   cd Dependency-Replication
   ```
2. **Windows users**: Reset line endings to LF before opening the container:
   ```bash
   git rm --cached -r .
   git reset --hard
   ```
   This is needed because Git on Windows may convert line endings to CRLF, which causes failures inside the Linux container. The `.gitattributes` file in this repo enforces LF endings, but existing checkouts need this one-time reset.
3. Open the folder in VS Code.
3. When prompted **"Reopen in Container"**, click yes (or run the command **Dev Containers: Reopen in Container** from the command palette).
4. The container will build, install all R packages from `renv.lock`, and start RStudio Server automatically.

#### Accessing RStudio Server

Once the container is running, RStudio Server is available at:

```
http://localhost:8787
```

#### Running Analyses from the Terminal

Inside the container, all dependencies are already installed via `renv`. Run analyses from the project root:

```bash
# Main analysis (~15 min)
cd analysis && Rscript -e 'rmarkdown::render("mobility_analysis.Rmd")'

# Subgroup analysis (~75 min)
cd analysis && Rscript -e 'rmarkdown::render("subgroup_mobility_analysis.Rmd")'

# Experimental HC3 analysis (~22-25 min)
cd experimental && Rscript -e 'rmarkdown::render("hc3_permutation_test.Rmd")'
```

### Option 2: Local R Installation

If you prefer to run outside the container:

**Prerequisites**: R >= 4.4.3

1. Clone the repository:
   ```bash
   git clone <repo-url>
   cd Dependency-Replication
   ```
2. Restore the `renv` lockfile to install exact package versions:
   ```r
   # renv should activate automatically via .Rprofile
   renv::restore()
   ```
3. Run analyses as shown above, or open `.Rmd` files in RStudio and knit them.

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
