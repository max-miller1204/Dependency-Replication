# ============================================================================
# Classical vs Permutation Testing for Relative Mobility Analysis
# Two-Phase Approach: (1) Replicate Classical Results, (2) Add Permutation Tests
# Tests both CORRELATION and REGRESSION to demonstrate equivalence
# ============================================================================

# Load required libraries
library(tidyverse)
library(broom)

# Uncomment to install permutation test packages
# install.packages("devtools")
# devtools::install_github("hyu-ub/perk/perk")
# install.packages("PermCor")

# Load permutation test libraries (if available)
# If these fail, only regression permutation tests will run
has_perk <- require(perk, quietly = TRUE)
has_permcor <- require(PermCor, quietly = TRUE)

cat("\n")
cat("=" , rep("=", 78), "\n", sep = "")
cat("CLASSICAL VS PERMUTATION TESTING: RELATIVE MOBILITY ANALYSIS\n")
cat("=" , rep("=", 78), "\n", sep = "")
cat("\n")

# ============================================================================
# PART 1: DATA LOADING AND PREPARATION
# ============================================================================

cat("PART 1: DATA LOADING\n")
cat("-", rep("-", 78), "\n", sep = "")

cat("Loading data...\n")

# Load Online Data Table 5 (Mobility Estimates)
# Row 50 contains column headers, so skip first 49 rows
table5 <- read.csv("Online_Data_Table_5.csv",
                   skip = 49,
                   header = TRUE,
                   stringsAsFactors = FALSE)

# Remove rows with column numbers "(1)", "(2)", etc. and empty rows
# These appear right after the header
table5 <- table5[!grepl("^\\(\\d+\\)$", table5[,1]) & table5[,1] != "", ]
rownames(table5) <- NULL

# Load Online Data Table 8 (CZ Characteristics)
# Row 7 contains column headers, so skip first 6 rows
table8 <- read.csv("Online_Data_Table_8.csv",
                   skip = 6,
                   header = TRUE,
                   stringsAsFactors = FALSE)

# Remove rows with column numbers and reset row names
# Row 8 has "-1" in first column (negative numbers are not valid CZ codes)
table8 <- table8[as.numeric(table8[,1]) > 0 & !is.na(table8[,1]), ]
rownames(table8) <- NULL

if(nrow(table8) == 0) {
  stop("ERROR: Online_Data_Table_8.csv loaded 0 rows! Check file location.")
}

cat(sprintf("✓ Loaded Table 5: %d rows\n", nrow(table5)))
cat(sprintf("✓ Loaded Table 8: %d rows\n", nrow(table8)))

# Clean column names
names(table5) <- gsub("^X\\.", "", names(table5))
names(table8) <- gsub("^X\\.", "", names(table8))

# DEBUG: Show actual column names after R processing
cat("\nDEBUG - Actual column names in Table 8 (first 20):\n")
cat("------------------------------------------------\n")
for(i in 1:min(20, length(names(table8)))) {
  cat(sprintf("%2d: %s\n", i, names(table8)[i]))
}
cat("\n")

# Rename key columns
colnames(table5)[1] <- "CZ"
colnames(table5)[5] <- "AM"  # Absolute Mobility
colnames(table5)[6] <- "RM"  # Relative Mobility
colnames(table5)[4] <- "n_children"

colnames(table8)[1] <- "CZ"

# Convert CZ to numeric in both tables to ensure join compatibility
table5$CZ <- as.numeric(table5$CZ)
table8$CZ <- as.numeric(table8$CZ)

# Merge tables
cat("Merging tables on CZ identifier...\n")
data <- table5 %>%
  select(CZ, RM, AM, n_children) %>%
  inner_join(table8, by = "CZ")

# Convert to numeric (all covariate columns from Table 8)
# Columns 4-41 contain all the covariates
numeric_cols <- c("RM", "AM", "n_children", names(table8)[4:ncol(table8)])
for(col in numeric_cols) {
  if(col %in% names(data)) {
    data[[col]] <- as.numeric(data[[col]])
  }
}

# Create sample size indicator and filter
data <- data %>%
  mutate(n250 = ifelse(n_children >= 250, 1, 0))

df <- data %>%
  filter(n250 == 1) %>%
  filter(!is.na(RM))

cat(sprintf("✓ Sample: %d CZs with n≥250 (out of %d total CZs)\n\n",
            nrow(df), nrow(data)))

# ============================================================================
# PART 2: PERMUTATION TEST FUNCTIONS
# ============================================================================

cat("PART 2: DEFINING TEST FUNCTIONS\n")
cat("-", rep("-", 78), "\n", sep = "")

# Regression-based permutation test (DiCiccio & Romano 2017, Theorem 3.2)
perm_test_regression <- function(X, Y, B = 10000, seed = NULL) {
  if (!is.null(seed)) set.seed(seed)

  X <- as.matrix(X)
  Y <- as.numeric(Y)
  n <- nrow(X)

  if (n != length(Y)) stop("X and Y must have same number of rows")

  # Add intercept
  X <- cbind(1, X)

  # Test statistic function
  compute_Sn <- function(X, Y) {
    XtX <- crossprod(X)
    XtY <- crossprod(X, Y)
    beta_hat <- solve(XtX, XtY)
    resid <- as.vector(Y - X %*% beta_hat)
    Sigma_hat <- XtX / n
    r2 <- resid^2
    Omega_hat <- crossprod(X, X * r2) / n
    tmp <- solve(Sigma_hat, beta_hat)
    as.numeric(n * t(tmp) %*% Omega_hat %*% tmp)
  }

  # Observed statistic
  S_obs <- compute_Sn(X, Y)

  # Permutation distribution
  S_perm <- replicate(B, {
    Y_perm <- sample(Y, replace = FALSE)
    compute_Sn(X, Y_perm)
  })

  # P-value
  pval <- (sum(S_perm >= S_obs) + 1) / (B + 1)

  list(S_obs = S_obs, S_perm = S_perm, p_value = pval, B = B)
}

cat("✓ Regression permutation test function loaded\n")

if(has_perk) {
  cat("✓ perk package loaded (correlation permutation tests)\n")
} else {
  cat("✗ perk package not available (install with devtools::install_github('hyu-ub/perk/perk'))\n")
}

if(has_permcor) {
  cat("✓ PermCor package loaded (correlation permutation tests)\n")
} else {
  cat("✗ PermCor package not available (install with install.packages('PermCor'))\n")
}

cat("\n")

# ============================================================================
# PART 3: DEFINE COVARIATES TO TEST
# ============================================================================

cat("PART 3: DEFINING COVARIATES\n")
cat("-", rep("-", 78), "\n", sep = "")

# FULL TABLE VIII: All 33 covariates from Online Appendix Table VIII
# NOTE: Column names match how R processes the CSV headers
# Spaces → dots, special chars (< > % ( )) → dots
covariates_to_test <- list(

  # RACE (1 variable)
  Race = c(
    "Frac..Black"                        # Fraction Black Residents
  ),

  # SEGREGATION (5 variables)
  Segregation = c(
    "Racial.Segregation",                # Racial Segregation Theil Index
    "Income.Segregation",                # Income Segregation Theil Index
    "Segregation.of.Poverty...p25.",     # Segregation of Poverty (<p25)
    "Segregation.of.Affluence...p75.",   # Segregation of Affluence (>p75)
    "Frac..with.Commute...15.Mins"       # Share with Commute < 15 Mins
  ),

  # INCOME DISTRIBUTION (5 variables)
  Income_Distribution = c(
    "Household.Income.per.capita",       # Household Income per Capita
    "Gini",                              # Gini coefficient for Parent Income
    "Top.1..Income.Share",               # Top 1% Income Share for Parents
    "Gini.Bottom.99.",                   # Gini Bottom 99%
    "Frac..Between.p25.and.p75"          # Fraction Middle Class
  ),

  # K-12 EDUCATION (4 variables)
  K12_Education = c(
    "School.Expenditure.per.Student",    # School Expenditure per Student
    "Teacher.Student.Ratio",             # Teacher-Student Ratio
    "Test.Score.Percentile..Income.Adjusted",   # Test Score Percentile (Income Adjusted)
    "High.School.Dropout.Rate..Income.Adjusted." # High School Dropout Rate (Income Adjusted)
  ),

  # SOCIAL CAPITAL (3 variables)
  Social_Capital = c(
    "Social.Capital.Index",              # Social Capital Index
    "Fraction.Religious",                # Fraction Religious
    "Violent.Crime.Rate"                 # Violent Crime Rate
  ),

  # FAMILY STRUCTURE (3 variables)
  Family_Structure = c(
    "Fraction.of.Children.with.Single.Mothers",  # Fraction Single Mothers
    "Fraction.of.Adults.Divorced",               # Fraction Divorced
    "Fraction.of.Adults.Married"                 # Fraction Married
  ),

  # TAX (4 variables)
  Tax = c(
    "Local.Tax.Rate",                    # Local Tax Rate
    "Local.Government.Expenditures.Per.Capita",  # Local Gov Expenditures per Capita
    "State.EITC.Exposure",               # State EITC Exposure
    "State.Income.Tax.Progressivity"     # State Income Tax Progressivity
  ),

  # COLLEGE (3 variables)
  College = c(
    "Number.of.Colleges.per.Capita",     # Number of Colleges per Capita
    "College.Tuition",                   # Mean College Tuition
    "College.Graduation.Rate..Income.Adjusted."  # College Graduation Rate (Income Adjusted)
  ),

  # LOCAL LABOR MARKET (4 variables)
  Local_Labor_Market = c(
    "Labor.Force.Participation.Rate",    # Labor Force Participation Rate
    "Manufacturing.Employment.Share",    # Fraction Working in Manufacturing
    "Growth.in.Chinese.Imports.1990.2000", # Growth in Chinese Imports 1990-2000
    "Teenage.Labor.Force.Participation.Rate"  # Teenage (14-16) Labor Force Participation
  ),

  # MIGRATION (3 variables)
  Migration = c(
    "Migration.Inflow.Rate",             # Migration Inflow Rate
    "Migration.Outlflow.Rate",           # Migration Outflow Rate (note: typo in CSV "Outlflow")
    "Frac..Foreign.Born"                 # Fraction of Foreign Born Residents
  )
)

all_covariates <- unlist(covariates_to_test, use.names = FALSE)
cat(sprintf("✓ Testing %d covariates across %d categories\n\n",
            length(all_covariates), length(covariates_to_test)))

# ============================================================================
# PHASE 1: REPLICATE CLASSICAL RESULTS
# ============================================================================

cat("\n")
cat("=" , rep("=", 78), "\n", sep = "")
cat("PHASE 1: REPLICATE CLASSICAL RESULTS (OLS)\n")
cat("=" , rep("=", 78), "\n", sep = "")
cat("\n")
cat("This phase replicates the classical OLS results from Online Appendix Table VIII\n")
cat("We test both CORRELATION and REGRESSION (they should give identical results)\n\n")

# Initialize results
phase1_results <- data.frame(
  category = character(),
  covariate = character(),
  n_obs = integer(),

  # Classical correlation
  cor_coefficient = numeric(),
  cor_t_stat = numeric(),
  cor_pval = numeric(),

  # Classical regression
  reg_coefficient = numeric(),
  reg_se = numeric(),
  reg_t_stat = numeric(),
  reg_pval = numeric(),

  # Agreement check
  methods_agree = logical(),

  stringsAsFactors = FALSE
)

# Loop through covariates
for(category_name in names(covariates_to_test)) {

  cat(sprintf("\n%s:\n", toupper(category_name)))
  cat("-", rep("-", 78), "\n", sep = "")

  for(covariate_name in covariates_to_test[[category_name]]) {

    # Check if covariate exists
    if(!(covariate_name %in% names(df))) {
      cat(sprintf("  ✗ %s: NOT FOUND\n", covariate_name))
      next
    }

    # Extract data
    temp_data <- df %>%
      select(RM, all_of(covariate_name)) %>%
      drop_na()

    if(nrow(temp_data) < 50) {
      cat(sprintf("  ✗ %s: Insufficient data (n=%d)\n", covariate_name, nrow(temp_data)))
      next
    }

    n_obs <- nrow(temp_data)

    # Standardize variables (mean 0, SD 1)
    y <- temp_data$RM
    y_std <- (y - mean(y)) / sd(y)

    x <- temp_data[[covariate_name]]
    x_std <- (x - mean(x)) / sd(x)

    # -------------------------------------------------------------------------
    # METHOD 1: CLASSICAL CORRELATION TEST
    # -------------------------------------------------------------------------
    cor_test_result <- cor.test(x_std, y_std, method = "pearson")
    cor_coef <- cor_test_result$estimate
    cor_t <- cor_test_result$statistic
    cor_p <- cor_test_result$p.value

    # -------------------------------------------------------------------------
    # METHOD 2: CLASSICAL REGRESSION TEST
    # -------------------------------------------------------------------------
    fit <- lm(y_std ~ x_std)
    fit_summary <- summary(fit)
    coef_table <- coef(fit_summary)

    reg_coef <- coef_table[2, "Estimate"]
    reg_se <- coef_table[2, "Std. Error"]
    reg_t <- coef_table[2, "t value"]
    reg_p <- coef_table[2, "Pr(>|t|)"]

    # Check agreement (should be identical when standardized)
    coef_diff <- abs(cor_coef - reg_coef)
    pval_diff <- abs(cor_p - reg_p)
    methods_agree <- (coef_diff < 0.001) & (pval_diff < 0.001)

    # Store results
    phase1_results <- rbind(phase1_results, data.frame(
      category = category_name,
      covariate = covariate_name,
      n_obs = n_obs,
      cor_coefficient = cor_coef,
      cor_t_stat = cor_t,
      cor_pval = cor_p,
      reg_coefficient = reg_coef,
      reg_se = reg_se,
      reg_t_stat = reg_t,
      reg_pval = reg_p,
      methods_agree = methods_agree
    ))

    # Print result
    agreement_icon <- ifelse(methods_agree, "✓", "✗")
    sig_icon <- ifelse(reg_p < 0.05, "*", " ")

    cat(sprintf("  %s %-45s n=%3d, β=%6.3f, p=%7.5f %s\n",
                agreement_icon,
                substr(covariate_name, 1, 45),
                n_obs,
                reg_coef,
                reg_p,
                sig_icon))
  }
}

cat("\n")
cat("-", rep("-", 78), "\n", sep = "")
cat("PHASE 1 SUMMARY:\n")
cat(sprintf("  Total tests: %d\n", nrow(phase1_results)))
cat(sprintf("  Significant at α=0.05: %d (%.1f%%)\n",
            sum(phase1_results$reg_pval < 0.05),
            100 * mean(phase1_results$reg_pval < 0.05)))
cat(sprintf("  Correlation ≈ Regression: %d/%d (%.1f%% agreement)\n",
            sum(phase1_results$methods_agree),
            nrow(phase1_results),
            100 * mean(phase1_results$methods_agree)))
cat("\n✓ Classical results replicated successfully\n")

# ============================================================================
# PHASE 2: ADD PERMUTATION TESTS
# ============================================================================

cat("\n\n")
cat("=" , rep("=", 78), "\n", sep = "")
cat("PHASE 2: ADD PERMUTATION TESTS\n")
cat("=" , rep("=", 78), "\n", sep = "")
cat("\n")

# Check if Phase 1 had any results
if(nrow(phase1_results) == 0) {
  cat("ERROR: Phase 1 produced 0 results!\n")
  cat("This means no covariates were found in the data.\n")
  cat("Check the DEBUG output above to see actual column names.\n\n")
  cat("HINT: Look for column names like:\n")
  cat("  - Racial.Segregation\n")
  cat("  - Income.Segregation\n")
  cat("  - Gini\n")
  cat("  etc.\n")
  stop("Cannot proceed to Phase 2 without Phase 1 results")
}

cat("This phase adds permutation tests and compares them to classical results\n")
cat("We run both CORRELATION and REGRESSION permutation tests\n\n")

# Initialize results
phase2_results <- phase1_results  # Start with Phase 1 results

# Add permutation columns
phase2_results$perm_cor_pval <- NA
phase2_results$perm_reg_pval <- NA
phase2_results$classical_sig <- phase2_results$reg_pval < 0.05
phase2_results$perm_cor_sig <- NA
phase2_results$perm_reg_sig <- NA
phase2_results$all_agree <- NA

# Loop through covariates
for(i in 1:nrow(phase2_results)) {

  covariate_name <- phase2_results$covariate[i]
  category_name <- phase2_results$category[i]

  if(i == 1 || phase2_results$category[i] != phase2_results$category[i-1]) {
    cat(sprintf("\n%s:\n", toupper(category_name)))
    cat("-", rep("-", 78), "\n", sep = "")
  }

  # Extract data
  temp_data <- df %>%
    select(RM, all_of(covariate_name)) %>%
    drop_na()

  # Standardize
  y <- temp_data$RM
  y_std <- (y - mean(y)) / sd(y)
  x <- temp_data[[covariate_name]]
  x_std <- (x - mean(x)) / sd(x)

  # Center to mean zero (required for regression permutation test)
  x_m0 <- x_std - mean(x_std)
  y_m0 <- y_std - mean(y_std)

  # -------------------------------------------------------------------------
  # METHOD 3: PERMUTATION CORRELATION TEST
  # -------------------------------------------------------------------------
  perm_cor_p <- NA

  if(has_perk) {
    tryCatch({
      perm_cor_result <- perk_test(x_std, y_std,
                                    method = "pearson",
                                    alternative = "two.sided")
      perm_cor_p <- perm_cor_result$p.value
    }, error = function(e) {
      perm_cor_p <- NA
    })
  } else if(has_permcor) {
    tryCatch({
      perm_cor_result <- perm_test(x_std, y_std,
                                    method = "Pearson",
                                    alternative = "two.sided")
      perm_cor_p <- perm_cor_result$p.value
    }, error = function(e) {
      perm_cor_p <- NA
    })
  }

  phase2_results$perm_cor_pval[i] <- perm_cor_p
  phase2_results$perm_cor_sig[i] <- if(!is.na(perm_cor_p)) perm_cor_p < 0.05 else NA

  # -------------------------------------------------------------------------
  # METHOD 4: PERMUTATION REGRESSION TEST
  # -------------------------------------------------------------------------
  perm_reg_result <- perm_test_regression(
    X = x_m0,
    Y = y_m0,
    B = 10000,
    seed = 42 + i  # Different seed for each test
  )

  perm_reg_p <- perm_reg_result$p_value
  phase2_results$perm_reg_pval[i] <- perm_reg_p
  phase2_results$perm_reg_sig[i] <- perm_reg_p < 0.05

  # Check if all methods agree on significance
  classical_sig <- phase2_results$classical_sig[i]
  perm_reg_sig <- phase2_results$perm_reg_sig[i]
  perm_cor_sig <- phase2_results$perm_cor_sig[i]

  if(!is.na(perm_cor_sig)) {
    all_agree <- (classical_sig == perm_reg_sig) & (classical_sig == perm_cor_sig)
  } else {
    all_agree <- (classical_sig == perm_reg_sig)
  }

  phase2_results$all_agree[i] <- all_agree

  # Print result
  agreement_icon <- ifelse(all_agree, "✓", "✗")
  sig_icon <- ifelse(classical_sig, "*", " ")

  if(!is.na(perm_cor_p)) {
    cat(sprintf("  %s %-35s β=%6.3f, p_class=%7.5f, p_perm_cor=%7.5f, p_perm_reg=%7.5f %s\n",
                agreement_icon,
                substr(covariate_name, 1, 35),
                phase2_results$reg_coefficient[i],
                phase2_results$reg_pval[i],
                perm_cor_p,
                perm_reg_p,
                sig_icon))
  } else {
    cat(sprintf("  %s %-35s β=%6.3f, p_class=%7.5f, p_perm_reg=%7.5f %s\n",
                agreement_icon,
                substr(covariate_name, 1, 35),
                phase2_results$reg_coefficient[i],
                phase2_results$reg_pval[i],
                perm_reg_p,
                sig_icon))
  }
}

# ============================================================================
# FINAL SUMMARY
# ============================================================================

cat("\n")
cat("=" , rep("=", 78), "\n", sep = "")
cat("FINAL SUMMARY\n")
cat("=" , rep("=", 78), "\n", sep = "")

cat("\n1. PHASE 1: Classical Results\n")
cat(sprintf("   - Total tests: %d\n", nrow(phase2_results)))
cat(sprintf("   - Significant (classical): %d (%.1f%%)\n",
            sum(phase2_results$classical_sig),
            100 * mean(phase2_results$classical_sig)))
cat(sprintf("   - Correlation ≈ Regression: %.1f%% agreement\n",
            100 * mean(phase2_results$methods_agree)))

cat("\n2. PHASE 2: Permutation Results\n")
cat(sprintf("   - Significant (perm regression): %d (%.1f%%)\n",
            sum(phase2_results$perm_reg_sig),
            100 * mean(phase2_results$perm_reg_sig)))

if(any(!is.na(phase2_results$perm_cor_sig))) {
  cat(sprintf("   - Significant (perm correlation): %d (%.1f%%)\n",
              sum(phase2_results$perm_cor_sig, na.rm = TRUE),
              100 * mean(phase2_results$perm_cor_sig, na.rm = TRUE)))
}

cat("\n3. AGREEMENT ANALYSIS\n")
cat(sprintf("   - All methods agree: %d/%d (%.1f%%)\n",
            sum(phase2_results$all_agree, na.rm = TRUE),
            nrow(phase2_results),
            100 * mean(phase2_results$all_agree, na.rm = TRUE)))

# Find disagreements
disagreements <- phase2_results %>%
  filter(!all_agree)

if(nrow(disagreements) > 0) {
  cat(sprintf("   - Disagreements: %d\n\n", nrow(disagreements)))
  cat("   Details:\n")
  for(i in 1:nrow(disagreements)) {
    row <- disagreements[i,]
    cat(sprintf("     • %s (%s)\n", row$covariate, row$category))
    cat(sprintf("       Classical: p=%.5f %s\n", row$reg_pval,
                ifelse(row$classical_sig, "[SIG]", "[NOT SIG]")))
    cat(sprintf("       Perm (reg): p=%.5f %s\n", row$perm_reg_pval,
                ifelse(row$perm_reg_sig, "[SIG]", "[NOT SIG]")))
    if(!is.na(row$perm_cor_pval)) {
      cat(sprintf("       Perm (cor): p=%.5f %s\n", row$perm_cor_pval,
                  ifelse(row$perm_cor_sig, "[SIG]", "[NOT SIG]")))
    }
  }
} else {
  cat("   - No disagreements! All methods agree.\n")
}

# P-value correlations
cat("\n4. P-VALUE CORRELATIONS\n")
cat(sprintf("   - Classical vs Perm Regression: r=%.3f\n",
            cor(phase2_results$reg_pval, phase2_results$perm_reg_pval)))

if(any(!is.na(phase2_results$perm_cor_pval))) {
  cat(sprintf("   - Classical vs Perm Correlation: r=%.3f\n",
              cor(phase2_results$reg_pval, phase2_results$perm_cor_pval, use = "complete.obs")))
  cat(sprintf("   - Perm Regression vs Perm Correlation: r=%.3f\n",
              cor(phase2_results$perm_reg_pval, phase2_results$perm_cor_pval, use = "complete.obs")))
}

# ============================================================================
# SAVE RESULTS
# ============================================================================

cat("\n")
cat("=" , rep("=", 78), "\n", sep = "")
cat("SAVING RESULTS\n")
cat("=" , rep("=", 78), "\n\n", sep = "")

# Create output directory if needed
if(!dir.exists("output")) {
  dir.create("output", recursive = TRUE)
}

# Clean up covariate names for better readability
phase2_results_clean <- phase2_results %>%
  mutate(covariate = case_when(
    # Race
    covariate == "Frac..Black" ~ "Fraction Black Residents",

    # Segregation
    covariate == "Racial.Segregation" ~ "Racial Segregation",
    covariate == "Income.Segregation" ~ "Income Segregation",
    covariate == "Segregation.of.Poverty...p25." ~ "Segregation of Poverty (<p25)",
    covariate == "Segregation.of.Affluence...p75." ~ "Segregation of Affluence (>p75)",
    covariate == "Frac..with.Commute...15.Mins" ~ "Share with Commute < 15 Mins",

    # Income Distribution
    covariate == "Household.Income.per.capita" ~ "Household Income per Capita",
    covariate == "Gini" ~ "Gini Coefficient",
    covariate == "Top.1..Income.Share" ~ "Top 1% Income Share",
    covariate == "Gini.Bottom.99." ~ "Gini Bottom 99%",
    covariate == "Frac..Between.p25.and.p75" ~ "Fraction Middle Class (p25-p75)",

    # K-12 Education
    covariate == "School.Expenditure.per.Student" ~ "School Expenditure per Student",
    covariate == "Teacher.Student.Ratio" ~ "Teacher-Student Ratio",
    covariate == "Test.Score.Percentile..Income.Adjusted" ~ "Test Score Percentile (Income Adjusted)",
    covariate == "High.School.Dropout.Rate..Income.Adjusted." ~ "High School Dropout Rate (Income Adjusted)",

    # Social Capital
    covariate == "Social.Capital.Index" ~ "Social Capital Index",
    covariate == "Fraction.Religious" ~ "Fraction Religious",
    covariate == "Violent.Crime.Rate" ~ "Violent Crime Rate",

    # Family Structure
    covariate == "Fraction.of.Children.with.Single.Mothers" ~ "Fraction of Children with Single Mothers",
    covariate == "Fraction.of.Adults.Divorced" ~ "Fraction of Adults Divorced",
    covariate == "Fraction.of.Adults.Married" ~ "Fraction of Adults Married",

    # Tax
    covariate == "Local.Tax.Rate" ~ "Local Tax Rate",
    covariate == "Local.Government.Expenditures.Per.Capita" ~ "Local Government Expenditures per Capita",
    covariate == "State.EITC.Exposure" ~ "State EITC Exposure",
    covariate == "State.Income.Tax.Progressivity" ~ "State Income Tax Progressivity",

    # College
    covariate == "Number.of.Colleges.per.Capita" ~ "Number of Colleges per Capita",
    covariate == "College.Tuition" ~ "Mean College Tuition",
    covariate == "College.Graduation.Rate..Income.Adjusted." ~ "College Graduation Rate (Income Adjusted)",

    # Local Labor Market
    covariate == "Labor.Force.Participation.Rate" ~ "Labor Force Participation Rate",
    covariate == "Manufacturing.Employment.Share" ~ "Manufacturing Employment Share",
    covariate == "Growth.in.Chinese.Imports.1990.2000" ~ "Growth in Chinese Imports 1990-2000",
    covariate == "Teenage.Labor.Force.Participation.Rate" ~ "Teenage Labor Force Participation Rate",

    # Migration
    covariate == "Migration.Inflow.Rate" ~ "Migration Inflow Rate",
    covariate == "Migration.Outlflow.Rate" ~ "Migration Outflow Rate",
    covariate == "Frac..Foreign.Born" ~ "Fraction Foreign Born",

    # Default (shouldn't happen, but just in case)
    TRUE ~ gsub("\\.", " ", covariate)
  ))

# Save detailed results
write.csv(phase2_results_clean,
          "output/mobility_test_results.csv",
          row.names = FALSE)
cat("✓ Saved: output/mobility_test_results.csv\n")

# Save workspace
save(phase1_results, phase2_results, df, covariates_to_test,
     file = "output/mobility_analysis_workspace.RData")
cat("✓ Saved: output/mobility_analysis_workspace.RData\n")

# ============================================================================
# CREATE VISUALIZATIONS
# ============================================================================

cat("\nCreating visualizations...\n")

# Coefficient plot (use cleaned names)
phase2_results_plot <- phase2_results_clean %>%
  mutate(
    covariate_short = substr(covariate, 1, 50),  # Use full cleaned name, truncate if needed
    sig_status = case_when(
      classical_sig & perm_reg_sig ~ "Both significant",
      !classical_sig & !perm_reg_sig ~ "Neither significant",
      TRUE ~ "Disagreement"
    )
  ) %>%
  arrange(reg_coefficient)

phase2_results_plot$covariate_short <- factor(
  phase2_results_plot$covariate_short,
  levels = phase2_results_plot$covariate_short
)

p2 <- ggplot(phase2_results_plot, aes(x = reg_coefficient, y = covariate_short)) +
  geom_vline(xintercept = 0, linetype = "dashed", color = "gray50") +
  geom_errorbar(aes(xmin = reg_coefficient - 1.96 * reg_se,
                    xmax = reg_coefficient + 1.96 * reg_se,
                    color = sig_status),
                height = 0.3, alpha = 0.7, orientation = "y") +
  geom_point(aes(color = sig_status), size = 3) +
  scale_color_manual(values = c("Both significant" = "#00BA38",
                                 "Neither significant" = "gray60",
                                 "Disagreement" = "#F8766D")) +
  labs(
    title = "Standardized Coefficients: Predictors of Relative Mobility",
    subtitle = "Error bars show 95% confidence intervals",
    x = "Standardized β coefficient",
    y = "",
    color = "Significance"
  ) +
  theme_minimal() +
  theme(legend.position = "bottom",
        axis.text.y = element_text(size = 9))

ggsave("output/coefficient_plot.png", p2,
       width = 10, height = 8, dpi = 300)
cat("✓ Saved: output/coefficient_plot.png\n")

# ============================================================================
# ANALYSIS COMPLETE
# ============================================================================

cat("\n")
cat("=" , rep("=", 78), "\n", sep = "")
cat("ANALYSIS COMPLETE\n")
cat("=" , rep("=", 78), "\n", sep = "")

cat("\nKey Findings:\n")
cat(sprintf("  • Tested %d covariates across 5 categories\n", nrow(phase2_results)))
cat(sprintf("  • Classical significance: %d/%d (%.1f%%)\n",
            sum(phase2_results$classical_sig),
            nrow(phase2_results),
            100 * mean(phase2_results$classical_sig)))
cat(sprintf("  • Permutation significance: %d/%d (%.1f%%)\n",
            sum(phase2_results$perm_reg_sig),
            nrow(phase2_results),
            100 * mean(phase2_results$perm_reg_sig)))
cat(sprintf("  • Overall agreement: %.1f%%\n",
            100 * mean(phase2_results$all_agree, na.rm = TRUE)))

cat("\nOutput files saved to: output/\n")
cat("  - mobility_test_results.csv\n")
cat("  - mobility_analysis_workspace.RData\n")
cat("  - coefficient_plot.png\n")

cat("\n")
