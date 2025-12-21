| Column          | Description                                                                                                  |
  |-----------------|--------------------------------------------------------------------------------------------------------------|
  | category        | The thematic grouping of the covariate (Segregation, Inequality, Education, Family, or Social)               |
  | covariate       | The predictor variable name (e.g., "Racial Segregation", "Gini Coefficient")                                 |
  | n_obs           | Number of observations (CZs) used in the analysis after removing missing values                              |
  | cor_coefficient | Pearson correlation coefficient from cor.test() — Method 1                                                   |
  | cor_t_stat      | t-statistic from the correlation test                                                                        |
  | cor_pval        | p-value from the correlation test                                                                            |
  | reg_coefficient | Regression slope (β) from lm() — Method 2. Identical to cor_coefficient when both X and Y are standardized   |
  | reg_se          | Standard error of the regression coefficient                                                                 |
  | reg_t_stat      | t-statistic from regression (should equal cor_t_stat)                                                        |
  | reg_pval        | p-value from regression (should equal cor_pval)                                                              |
  | methods_agree   | TRUE if correlation and regression give the same results (coefficient diff < 0.001 and p-value diff < 0.001) |
  | perm_cor_pval   | p-value from permutation correlation test using perk or PermCor — Method 3                                   |
  | perm_reg_pval   | p-value from permutation regression test (DiCiccio & Romano Theorem 3.2) — Method 4                          |
  | classical_sig   | TRUE if classically significant (reg_pval < 0.05)                                                            |
  | perm_cor_sig    | TRUE if permutation correlation significant (perm_cor_pval < 0.05)                                           |
  | perm_reg_sig    | TRUE if permutation regression significant (perm_reg_pval < 0.05)                                            |
  | all_agree       | TRUE if all methods agree on significance (all significant or all not significant)                           |

  ---
  Key observations from the data:

  - All 17 covariates show methods_agree = TRUE — confirming correlation ≈ regression for standardized variables
  - All 17 covariates show all_agree = TRUE — classical and permutation tests reach the same conclusions
  - 16 of 17 covariates are significant; only "Top 1% Income Share" is not significant (p ≈ 0.62)
  - The strongest predictor is "Fraction of Children with Single Mothers" (r = 0.64, p ≈ 10⁻⁸³)