# How Each Online Data Table Was Created

## Overview

This document explains the complete data flow for the intergenerational mobility project and clarifies which data files can be reproduced from the replication materials.

---

## Key Finding

**The replicate_2014-1 folder does NOT create most of the online data tables.**

The online data tables come from two different sources:
- **Tables 1-7**: Restricted IRS tax records (NOT reproducible)
- **Table 8**: Public data processed by `clean_public_data.do` (CAN be reproduced)
- **Table 9**: Documentation only

---

## Online Data Tables 1-7: Mobility Statistics (IRS Data)

**Source**: Restricted-access IRS tax records (1996-2012 tax data for 40M+ children)
**Created by**: Proprietary analysis by the researchers - **NOT reproducible from this folder**

### These tables contain:

1. **Table 1**: National 100×100 transition matrix (parent centile → child centile)
2. **Table 2**: National marginal income distributions by centile
3. **Table 3**: Mobility statistics by County
4. **Table 4**: Mobility statistics by MSA
5. **Table 5**: Mobility statistics by Commuting Zone (741 CZs)
   - Used in `replicate.do` lines 11-48
   - Contains variables: `e_rank_b`, `s_rank`, `prob_p1_k5`, etc.
6. **Table 6**: Quintile-quintile transition matrices by CZ
7. **Table 7**: Income distributions by CZ

**Important**: These mobility estimates were computed from restricted data and published as final statistics. The replication folder cannot recreate them from scratch.

---

## Online Data Table 8: CZ Characteristics (Covariates)

**Source**: Public data from Census, IRS, education databases, etc.
**Created by**: `clean_public_data.do` (880 lines) - **CAN be reproduced**

### Data Processing Pipeline

```
Public Data Sources
        ↓
clean_public_data.do (880 lines)
        ↓
clean_data/*.dta (20+ individual files)
        ↓
covariates.dta (merged file with 741 CZs × 41 covariates)
        ↓
(manually assembled by authors)
        ↓
Online Data Table 8 in online_data_tables.xls
```

### Detailed Covariate Creation

#### 1. Race & Segregation (clean_public_data.do lines 1-164)

| File | Script Lines | Table 8 Column | Variable Name | Description |
|------|--------------|----------------|---------------|-------------|
| `share_black.dta` | 10-25 | Column 6 | `cs_race_bla` | Fraction Black |
| `race_theil.dta` | 27-58 | Column 7 | `cs_race_theil_2000` | Racial Segregation (Theil index) |
| `income_segregation.dta` | 60-154 | Columns 8-10 | `cs00_seg_inc`, `cs00_seg_inc_pov25`, `cs00_seg_inc_aff75` | Income Segregation (Reardon 2011), Segregation of Poverty (<p25), Segregation of Affluence (>p75) |
| `travel_time.dta` | 156-164 | Column 11 | `frac_traveltime_lt15` | Frac. with Commute < 15 Mins |

**Data Sources**:
- Census 2000 tract-level data (NHGIS)
- Household income distributions by census tract
- Commuting time data from SF3

#### 2. Income Distribution (lines 165-210)

| File | Script Lines | Table 8 Columns | Variable Names | Description |
|------|--------------|-----------------|----------------|-------------|
| `hhinc.dta` | 172-210 | Column 12 | `hhinc_pc_2000_cpiu2007`, `hhinc_pc_1990_cpiu2007` | Household Income per capita (2000 & 1990, adjusted to 2007 dollars) |

**Note**: Table 8 also includes Gini coefficients, top 1% income share, and middle class fraction (Columns 13-16), which appear to come from the IRS data merged in by the authors.

#### 3. Taxes & Government Expenditures (lines 214-337)

| File | Script Lines | Table 8 Columns | Variable Names | Description |
|------|--------------|-----------------|----------------|-------------|
| `subcty.dta` | 218-283 | Columns 17-18 | `subcty_total_taxes_pc`, `subcty_total_expenditure_pc` | Local Tax Rate, Local Govt Expenditures Per Capita |
| `eitc_exposure.dta` | 285-328 | Column 20 | `eitc_exposure` | State EITC Exposure (1981-2001 average) |
| `tax_progressivity.dta` | 330-336 | Column 19 | `tax_st_diff_top20` | State Income Tax Progressivity |

**Data Sources**:
- Census of Government County Area Summaries
- State tax code data (1986-2001)
- State tax rates (2008)

#### 4. K-12 Education (lines 341-484)

| File | Script Lines | Table 8 Columns | Variable Names | Description |
|------|--------------|-----------------|----------------|-------------|
| `ccd.dta` | 344-402 | Columns 21-22 | `ccd_exp_tot`, `ccd_pup_tch_ratio` | School Expenditure per Student ($1000s), Teacher-Student Ratio |
| `dropout.dta` | 404-430 | Column 24 | `ccd_drpout912`, `ccd_drpout912_miss` | High School Dropout Rate (9-12), Missing indicator |
| `reportcard.dta` | 432-484 | Column 23 | `scorep_mean` | Test Score Percentile (Income Adjusted) |

**Data Sources**:
- Common Core of Data (CCD) 1996 school and district files
- Global Report Card Data (2004-2009 test scores)

#### 5. Higher Education (lines 488-616)

| File | Script Lines | Table 8 Columns | Variable Names | Description |
|------|--------------|-----------------|----------------|-------------|
| `ipeds2000.dta` | 492-550 | Columns 25-26 | `num_inst_pc`, `tuition` | Number of Colleges per Capita, College Tuition |
| `ipeds2009.dta` | 552-616 | Column 27 | `gradrate_r` | College Graduation Rate (150% normal time) |

**Data Sources**:
- IPEDS (Integrated Postsecondary Education Data System) 2000 and 2009
- Institution characteristics, enrollment, tuition data

#### 6. Local Labor Market (lines 620-649)

| File | Script Lines | Table 8 Columns | Variable Names | Description |
|------|--------------|-----------------|----------------|-------------|
| `lfp.dta` | 624-632 | Column 28 | `cs_labforce` | Labor Force Participation Rate |
| `emp_manuf.dta` | 634-642 | Column 29 | `cs_elf_ind_man` | Manufacturing Employment Share |
| `tradeexposure.dta` | 644-649 | Column 30 | `d_tradeusch_pw_1990` | Growth in Chinese Imports 1990-2000 (per worker, Autor & Dorn) |

**Note**: Column 31 (Teen labor force participation) also created from Census 2000 data.

**Data Sources**:
- Census 2000 SF3 (ZCTA level)
- Autor, Dorn, and Hanson trade exposure data

#### 7. Migration Rates (lines 654-719)

| File | Script Lines | Table 8 Columns | Variable Names | Description |
|------|--------------|-----------------|----------------|-------------|
| `migration_rates.dta` | 658-709 | Columns 32-33 | `mig_inflow`, `mig_outflow` | Migration Inflow Rate, Migration Outflow Rate |
| `foreignborn.dta` | 711-719 | Column 34 | `cs_born_foreign` | Frac. Foreign Born |

**Data Sources**:
- IRS County-to-County Migration Data (2004-2005)
- Census 2000 SF3 place of birth data

#### 8. Social Capital (lines 723-768)

| File | Script Lines | Table 8 Columns | Variable Names | Description |
|------|--------------|-----------------|----------------|-------------|
| `social_capital.dta` | 727-736 | Column 35 | `scap_ski90pcm`, `scap_bowl90` | Social Capital Index (combining multiple measures) |
| `religious.dta` | 738-748 | Column 36 | `rel_tot` | Fraction Religious |
| `violent_crime.dta` | 750-768 | Column 37 | `crime_violent` | Violent Crime Rate |

**Data Sources**:
- Social Capital Variables dataset
- Religious Congregations and Membership Study (2000)
- ICPSR Uniform Crime Reports county-level data

#### 9. Family Structure (lines 770-795)

| File | Script Lines | Table 8 Columns | Variable Names | Description |
|------|--------------|-----------------|----------------|-------------|
| `singlemom.dta` | 774-783 | Column 38 | `cs_fam_wkidsinglemom` | Fraction of Children with Single Mothers |
| `family_structure.dta` | 785-795 | Columns 39-40 | `cs_divorced`, `cs_married` | Fraction of Adults Divorced, Fraction of Adults Married |

**Data Sources**:
- Census 2000 SF1 and SF3 (ZCTA level)
- Household composition data

#### 10. Miscellaneous Variables (lines 799-850)

| File | Script Lines | Table 8 Column | Variable Name | Description |
|------|--------------|----------------|---------------|-------------|
| `incgrowth0010.dta` | 803-830 | Column 41 | `incgrowth0010` | Income Growth 2000-2006/10 |
| `intersects_msa.dta` | 832-844 | Column 5 | `intersects_msa` | Urban Areas (CZ intersects MSA indicator) |
| `state_id.dta` | 846-850 | Column 3 | `state_id`, `stateabbrv` | State identifier |

**Data Sources**:
- ACS 2006-2010 5-year estimates
- Census 2010
- OMB Metropolitan Statistical Area definitions

### Final Assembly (lines 854-880)

The script merges all individual covariate files together:

```stata
# Start with CZ-county crosswalk
use county_2000.dta
keep cz czname stateabbrv pop2000

# Merge all covariate files
foreach d in share_black race_theil income_segregation travel_time hhinc ///
    subcty eitc_exposure tax_progressivity ccd dropout reportcard ipeds2000 ///
    ipeds2009 lfp emp_manuf tradeexposure migration_rates foreignborn ///
    social_capital religious violent_crime singlemom family_structure ///
    incgrowth0010 intersects_msa state_id {

  if "`d'" != "eitc_exposure" & "`d'" != "tax_progressivity" {
    merge 1:1 cz using "$root/data/clean_data/`d'.dta", nogen
  }
  else {
    # State-level variables merged by state
    merge m:1 stateabbrv using "$root/data/clean_data/`d'.dta", nogen
  }
}

# Save final merged file
save "$root/data/clean_data/covariates.dta", replace
```

**Output**: `covariates.dta` - 741 CZs × 41+ covariates

---

## Online Data Table 9: Definitions

**Source**: Documentation written by the authors
**Not created by code** - describes variable definitions and data sources

---

## How replicate.do Uses These Tables

The main replication script (`replicate.do`) imports data from the Excel file and creates the analysis dataset:

### Step 1: Import Mobility Estimates (lines 11-48)
```stata
import excel ///
  cz=A czname=B state_id=C ///
  n_ige_rank_8082=D e_rank_b=E s_rank=F ///
  prob_p1_k5=G ... ///
  using online_data_tables.xls, clear ///
  sheet("Online Data Table 5") cellrange(A53:AI793)

gen n250 = (n_ige_rank_8082 >= 250 & n_ige_rank_8082 != .)
save ige_estimates.dta
```

### Step 2: Import Covariates (lines 57-100)
```stata
import excel ///
  cz=A czname=B state_id=C pop2000=D intersects_msa=E ///
  cs_race_bla=F cs_race_theil_2000=G ///
  cs00_seg_inc=H ... ///
  using online_data_tables.xls, clear ///
  sheet("Online Data Table 8") cellrange(A9:AO749)

save covariates.dta
```

### Step 3: Merge to Create Analysis Dataset (lines 105-108)
```stata
use ige_estimates, clear
merge 1:1 cz using covariates, nogen
gen cons = 1
save analysis.dta, replace
```

**Output**: `analysis.dta` - 741 CZs × 75 variables (mobility measures + covariates)

### Step 4: Import Transition Matrix (lines 111-119)
```stata
import excel using online_data_tables.xls, clear ///
  sheet("Online Data Table 1") cellrange(A10:CW105)

# Rename columns to par_frac_bin_0 through par_frac_bin_100
save centiles.dta, replace
```

**Output**: `centiles.dta` - 100 rows (child centiles) × 101 columns (parent centile probabilities)

---

## Summary Table: What Can Be Reproduced?

| Table | Description | Can Reproduce? | Source Code | Data Source |
|-------|-------------|----------------|-------------|-------------|
| **Table 1** | National transition matrix | ❌ No | Not available | IRS restricted data |
| **Table 2** | National income distributions | ❌ No | Not available | IRS restricted data |
| **Table 3** | Mobility by County | ❌ No | Not available | IRS restricted data |
| **Table 4** | Mobility by MSA | ❌ No | Not available | IRS restricted data |
| **Table 5** | Mobility by CZ | ❌ No | Not available | IRS restricted data |
| **Table 6** | Quintile transitions by CZ | ❌ No | Not available | IRS restricted data |
| **Table 7** | Income distributions by CZ | ❌ No | Not available | IRS restricted data |
| **Table 8** | CZ characteristics | ✅ Yes | `clean_public_data.do` | Public data (Census, etc.) |
| **Table 9** | Variable definitions | N/A | Documentation | N/A |

---

## CSV Conversion

The CSV files in `online_data_tables/` folder were created by:

1. Starting with the original Excel file: `online_data_tables.xls`
2. Running the Python notebook: `dta_to_csv.ipynb`
3. Using pandas to read each Excel sheet:
   ```python
   all_sheets = pd.read_excel('online_data_tables.xls', sheet_name=None)

   for sheet_name, df in all_sheets.items():
       safe_name = sheet_name.replace(" ", "_")
       df.to_csv(f'online_data_tables/{safe_name}.csv', index=False)
   ```

**Important**: The CSV conversion is just a format change. It does not create new data - it simply exports the Excel sheets to CSV format for easier access.

---

## Data Provenance

### Restricted Data (Tables 1-7)
- **Source**: IRS 1040 tax records (1996-2012)
- **Sample**: 40+ million children (1980-1991 birth cohorts)
- **Processing**: Proprietary analysis by Equality of Opportunity Project
- **Publication**: Summary statistics only (microdata not released)

### Public Data (Table 8)
- **Sources**: Census 2000/2010, ACS, CCD, IPEDS, IRS public statistics, etc.
- **Processing**: Documented in `clean_public_data.do`
- **Availability**: Raw data in `public_raw_data/` subdirectories
- **Reproducibility**: Full replication possible

---

## Geographic Aggregation

All data is aggregated to **Commuting Zones (CZ)** level:
- 741 CZs cover the entire United States
- CZs are clusters of counties with strong commuting ties
- Larger than counties, smaller than states
- Crosswalks in `replicate_2014-1/clean_public_data/crosswalks/` map:
  - Counties → CZs (`county_1990.dta`, `county_2000.dta`, `county_2010.dta`)
  - ZIP codes → CZs (`cw_zip99_cz.dta`)
  - ZCTAs → CZs (`cw_zcta00_cz.dta`)

---

## Notes

1. **Line 185 in replicate.do**: The reference to "gre" was actually `eststo m1`, which stores regression model 1 results - not related to creating the data tables.

2. **Missing data handling**: Some covariates (dropout rates, social capital) have missing values for certain CZs. The analysis code creates indicator variables (`miss_dropout`, `miss_scap`) and imputes to 0 in normalized variables.

3. **Sample restrictions**: Most analyses use `if n250` filter, restricting to CZs with ≥250 children in the mobility sample.

4. **Version control**: The online data tables were published June 3, 2014, as indicated in the Table of Contents.

---

## Connection to R Analysis

This project uses two data tables from the Chetty et al. online data:

### Data Used in R Analysis

| Table | File | Contents | Used For |
|-------|------|----------|----------|
| Table 5 | `Online_Data_Table_5.csv` | Mobility estimates by CZ | Dependent variable (relative mobility) |
| Table 8 | `Online_Data_Table_8.csv` | CZ characteristics | Independent variables (35 covariates) |

### Analysis Flow

```
Online_Data_Table_5.csv  →  Relative Mobility (Y)
         +                         ↓
Online_Data_Table_8.csv  →  Covariates (X₁...X₃₅)
                                   ↓
                        mobility_analysis.Rmd
                                   ↓
┌─────────────────────────────────────────────────────────────┐
│                    NON-PERMUTATION                          │
│  cor.test ──┬── summary(lm) ──┬── waldtest HC0/HC3         │
└─────────────┼─────────────────┼─────────────────────────────┘
              │   Compare       │
              │  significance   │
┌─────────────┼─────────────────┼─────────────────────────────┐
│             │   PERMUTATION   │                             │
│           perk            perm_test_regression              │
└─────────────────────────────────────────────────────────────┘
                                   ↓
                    Compare significance conclusions
                                   ↓
                   All six agree? → Robust findings
```

### The Six Methods

#### Non-Permutation Methods (4)
| Method | Test Statistic | Properties |
|--------|----------------|------------|
| **cor.test** | Pearson r | Classical correlation t-test |
| **summary(lm)** | t = β̂/SE(β̂) | Classical OLS (Chetty et al. approach) |
| **waldtest HC0** | Wald F | Heteroskedasticity-robust |
| **waldtest HC3** | Wald F | HC-robust, small-sample correction |

#### Permutation Methods (2)
| Method | Test Statistic | Properties |
|--------|----------------|------------|
| **perk** | Pearson r | Permutation correlation test |
| **perm_test_regression** | Robust Wald Sₙ | DiCiccio & Romano (2017) |

### Why Six Methods?

| If... | Then... |
|-------|---------|
| All six agree | Very strong evidence the findings are robust |
| Non-perm ≠ permutation | Distributional assumptions might be affecting conclusions |
| cor.test ≠ perk | Permutation changes correlation inference |
| summary(lm) ≠ waldtest | Heteroskedasticity is present |
| waldtest ≠ perm_test_regression | Permutation vs asymptotic difference |

### Key Variables

**Dependent Variable** (from Table 5):
- `RM, 80-82 Cohort`: Relative mobility (rank-rank slope) for 1980-82 birth cohort

**Independent Variables** (from Table 8):
- 35 covariates across 10 categories (see `R_code/analysis_guide.md`)

**Sample Restriction**:
- 709 CZs with ≥250 children (filtered using `count` column from Table 5)

---

## File Locations

### Original Chetty et al. Replication Files

```
Data/
├── replicate_2014-1/
│   ├── replicate/
│   │   ├── replicate.do              # Master analysis script
│   │   ├── online_data_tables.xls    # Original Excel data source
│   │   ├── analysis.dta              # Combined dataset (created by replicate.do)
│   │   └── centiles.dta              # Transition matrix (created by replicate.do)
│   └── clean_public_data/
│       ├── clean_public_data.do      # Covariate creation script
│       ├── clean_data/               # Processed .dta files (created by script)
│       │   ├── share_black.dta
│       │   ├── race_theil.dta
│       │   ├── income_segregation.dta
│       │   ├── ... (20+ more files)
│       │   └── covariates.dta        # Final merged covariates
│       ├── public_raw_data/          # Raw public data sources
│       │   ├── race_and_segregation/
│       │   ├── income_distributions/
│       │   ├── taxes_and_govt_expenditure/
│       │   ├── k-12/
│       │   ├── higher_education/
│       │   ├── local_labor_market/
│       │   ├── migration_rates/
│       │   ├── social_capital/
│       │   └── family_structure/
│       └── crosswalks/               # Geographic crosswalk files
├── online_data_tables/               # CSV exports (created by dta_to_csv.ipynb)
│   ├── Online_Data_Table_1.csv
│   ├── ... (through 9)
│   └── Table_of_Contents.csv
└── dta_to_csv.ipynb                 # Python notebook for format conversion
```

### This Project

```
Dependency-Replication/
├── R_code/
│   ├── mobility_analysis.Rmd         # Main R analysis
│   ├── mobility_analysis.pdf         # Compiled results
│   ├── analysis_guide.md             # Methodology documentation
│   ├── Online_Data_Table_5.csv       # Mobility estimates (from Chetty et al.)
│   ├── Online_Data_Table_8.csv       # CZ characteristics (from Chetty et al.)
│   └── output/
│       ├── mobility_test_results.csv # Analysis results
│       ├── coefficient_plot.png      # Visualization
│       └── mobility_analysis_workspace.RData
├── context/
│   └── DATA_FLOW_DOCUMENTATION.md    # This file
├── paper_info/
│   └── where_is_the_land_of_opportunity_replication.pdf
└── README.md
```
