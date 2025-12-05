* This program reproduces tables and figures from the paper "Where is the Land of Opportunity? The Geography of Intergenerational Mobility in the United States".
* The first section creates Stata datasets from the online data tables, which are in Excel format - this must always be run.
* The rest of the code produces tables and figures from the paper.

* PLEASE CHANGE THE DIRECTORY TO THE LOCATION OF THE REPLICATION FILES
run usmaptile_v064.ado
capture ssc install binscatter  // Install (update) binscatter from Stata's repository - requires an internet connection
global dir: pwd

* Load CZ-level IGE estimates (name as we load)
import excel ///
  cz=A ///
  czname=B ///
  state_id=C ///
  n_ige_rank_8082=D ///
  e_rank_b=E ///
  s_rank=F ///
  prob_p1_k5=G ///
  e_rank_b_c1821=H ///
  s_c1821=I ///
  e_rank_b_teenbirth_fem=J ///
  s_teenbirth_fem=K ///
  e_rank_b_femfam=L ///
  s_femfam=M ///
  e_rank_b_malefam=N ///
  s_malefam=O ///
  e_rank_b_indv_r_m=P ///
  s_indv_r_m=Q ///
  e_rank_b_coli4=R ///
  s_coli4=S ///
  e_rank_b_1112=T ///
  s_1112=U ///
  e_rank_b_singlepar=V ///
  s_singlepar=W ///
  e_rank_b_marriedpar=X ///
  s_marriedpar=Y ///
  e_rank_b_8385=Z ///
  s_8385=AA ///
  e_rank_b_8085=AB ///
  s_8085=AC ///
  e_rank_b_w80=AD ///
  s_w80=AE ///
  e_rank_b_povertyline=AF ///
  s_povertyline=AG ///
  e_rank_b_cq=AH ///
  s_cq=AI ///
  using online_data_tables.xls, clear ///
  sheet("Online Data Table 5") cellrange(A53:AI793)
foreach v of varlist * {
  cap replace `v' = . if `v' == 0
}
gen n250 = (n_ige_rank_8082 >= 250 & n_ige_rank_8082 != .)
tempfile ige_estimates
save `ige_estimates'

* Load CZ-level covariates(name as we load)
import excel ///
  cz=A ///
  czname=B ///
  state_id=C ///
  pop2000=D ///
  intersects_msa=E ///
  cs_race_bla=F ///
  cs_race_theil_2000=G ///
  cs00_seg_inc=H ///
  cs00_seg_inc_pov25=I ///
  cs00_seg_inc_aff75=J ///
  frac_traveltime_lt15=K ///
  hhinc00=L ///
  gini=M ///
  inc_share_1perc=N ///
  gini99=O ///
  frac_middleclass=P ///
  taxrate=Q ///
  subcty_total_expenditure_pc=R ///
  tax_st_diff_top20=S ///
  eitc_exposure=T ///
  ccd_exp_tot=U ///
  ccd_pup_tch_ratio=V ///
  score_r=W ///
  dropout_r=x ///
  num_inst_pc=Y ///
  tuition=Z ///
  gradrate_r=AA ///
  cs_labforce=AB ///
  cs_elf_ind_man=AC ///
  d_tradeusch_pw_1990=AD ///
  frac_worked1416=AE ///
  mig_inflow=AF ///
  mig_outflow=AG ///
  cs_born_foreign=AH ///
  scap_ski90pcm=AI ///
  rel_tot=AJ ///
  crime_violent=AK ///
  cs_fam_wkidsinglemom=AL ///
  cs_divorced=AM ///
  cs_married=AN ///
  incgrowth0010=AO ///
  using online_data_tables.xls, clear ///
  sheet("Online Data Table 8") cellrange(A9:AO749)
tempfile covariates
save `covariates'

* Combine CZ-level data
use `ige_estimates', clear
merge 1:1 cz using `covariates', nogen
gen cons = 1
save analysis.dta, replace

* Load centile-centile probabilities
import excel using online_data_tables.xls, clear ///
  sheet("Online Data Table 1") cellrange(A10:CW105)
local vn = 0
foreach v of varlist * {
  ren `v' par_frac_bin_`vn'
  local vn = `vn' + 1
}
ren par_frac_bin_0 kid_fam_bin
save centiles.dta, replace

capture log close
log using tables.smcl, replace

* Table II
use centiles.dta, clear
gen par_bin_1 = 0
gen par_bin_2 = 0
gen par_bin_3 = 0
gen par_bin_4 = 0
gen par_bin_5 = 0
gen kid_quint = floor((kid_fam_bin-1)/20)+1
tab kid_quint
tab kid_fam_bin
forvalues b = 1/20 {
  replace par_bin_1 = par_bin_1+par_frac_bin_`b'
}
forvalues b = 21/40 {
  replace par_bin_2 = par_bin_2+par_frac_bin_`b'
}
forvalues b = 41/60 {
  replace par_bin_3 = par_bin_3+par_frac_bin_`b'
}
forvalues b = 61/80 {
  replace par_bin_4 = par_bin_4+par_frac_bin_`b'
}
forvalues b = 81/100 {
  replace par_bin_5 = par_bin_5+par_frac_bin_`b'
}
collapse (sum) par_bin_1=par_bin_1 par_bin_2=par_bin_2 par_bin_3=par_bin_3 ///
  par_bin_4=par_bin_4 par_bin_5=par_bin_5, by(kid_quint)		
drop if kid_quint==.
forvalues v=1/5 {
  egen total_`v' = total(par_bin_`v')
  replace par_bin_`v' = round(par_bin_`v'/total_`v', .001)
  ren par_bin_`v' prob_p`v'_k
  drop total_`v'
}

* Table III
use analysis.dta, clear
gsort - pop2000
keep czname state_id e_rank_b s_rank pop2000 prob_p1_k5 e_rank_b_povertyline
keep in 1/50
gsort - e_rank_b
order czname state_id pop2000 e_rank_b prob_p1_k5 e_rank_b_povertyline s_rank
replace prob_p1_k5 = 100*prob_p1_k5
format %3.1f e_rank_b
format %3.1f prob_p1_k5
format %3.1f e_rank_b_povertyline
format %4.3f s_rank
list, sep(0)

* Table IV
use analysis.dta, clear
estimates drop _all
qui {
* 1 Racial Segration
reg e_rank_b cs_race_theil_2000 if n250
su e_rank_b if n250 & e(sample)
gen e_rank_b_n = (e_rank_b-r(mean))/r(sd) if n250 & e(sample)
su cs_race_theil_2000 if n250 & e(sample)
gen cs_race_theil_2000_n = (cs_race_theil_2000-r(mean))/r(sd) if n250 & e(sample)
reg e_rank_b_n cs_race_theil_2000_n if n250, cluster(state_id)
drop *_n
eststo m1
* 2 Racial Segregation - Urban Areas
reg e_rank_b cs_race_theil_2000 if intersects_msa
su e_rank_b if intersects_msa & e(sample)
gen e_rank_b_n = (e_rank_b-r(mean))/r(sd) if intersects_msa & e(sample)
su cs_race_theil_2000 if intersects_msa & e(sample)
gen cs_race_theil_2000_n = (cs_race_theil_2000-r(mean))/r(sd) if intersects_msa & e(sample)
reg e_rank_b_n cs_race_theil_2000_n if intersects_msa, cluster(state_id)
drop *_n
eststo m2
* 3 Income Segregation
reg e_rank_b cs00_seg_inc if n250
su e_rank_b if n250 & e(sample)
gen e_rank_b_n = (e_rank_b-r(mean))/r(sd) if n250 & e(sample)
su cs00_seg_inc if n250 & e(sample)
gen cs00_seg_inc_n = (cs00_seg_inc-r(mean))/r(sd) if n250 & e(sample)
reg e_rank_b_n cs00_seg_inc_n if n250, cluster(state_id)
drop *_n
eststo m3
* 4 Segregation of Poverty vs. Affluence
reg e_rank_b cs00_seg_inc_pov25 cs00_seg_inc_aff75 if n250
su e_rank_b if n250 & e(sample)
gen e_rank_b_n = (e_rank_b-r(mean))/r(sd) if n250 & e(sample)
su cs00_seg_inc_pov25 if n250 & e(sample)
gen cs00_seg_inc_pov25_n = (cs00_seg_inc_pov25-r(mean))/r(sd) if n250 & e(sample)
su cs00_seg_inc_aff75 if n250 & e(sample)
gen cs00_seg_inc_aff75_n = (cs00_seg_inc_aff75-r(mean))/r(sd) if n250 & e(sample)
reg e_rank_b_n cs00_seg_inc_pov25_n cs00_seg_inc_aff75_n if n250, cluster(state_id)
drop *_n
eststo m4
* 5 Segregation of Poverty vs. Affluence in MSAs
reg e_rank_b cs00_seg_inc_pov25 cs00_seg_inc_aff75 if intersects_msa
su e_rank_b if intersects_msa & e(sample)
gen e_rank_b_n = (e_rank_b-r(mean))/r(sd) if intersects_msa & e(sample)
su cs00_seg_inc_pov25 if intersects_msa & e(sample)
gen cs00_seg_inc_pov25_n = (cs00_seg_inc_pov25-r(mean))/r(sd) if intersects_msa & e(sample)
su cs00_seg_inc_aff75 if intersects_msa & e(sample)
gen cs00_seg_inc_aff75_n = (cs00_seg_inc_aff75-r(mean))/r(sd) if intersects_msa & e(sample)
reg e_rank_b_n cs00_seg_inc_pov25_n cs00_seg_inc_aff75_n if n250, cluster(state_id)
drop *_n
eststo m5
* 6 Transportation
reg e_rank_b frac_traveltime_lt15 if n250
su e_rank_b if n250 & e(sample)
gen e_rank_b_n = (e_rank_b-r(mean))/r(sd) if n250 & e(sample)
su frac_traveltime_lt15 if n250 & e(sample)
gen frac_traveltime_lt15_n = (frac_traveltime_lt15-r(mean))/r(sd) if n250 & e(sample)
reg e_rank_b_n frac_traveltime_lt15_n if n250, cluster(state_id)
drop *_n
eststo m6
* 7 Transporation vs. Segregation Measures
reg e_rank_b cs00_seg_inc_pov25 cs00_seg_inc_aff75 if n250
su e_rank_b if n250 & e(sample)
gen e_rank_b_n = (e_rank_b-r(mean))/r(sd) if n250 & e(sample)
su frac_traveltime_lt15 if n250 & e(sample)
gen frac_traveltime_lt15_n = (frac_traveltime_lt15-r(mean))/r(sd) if n250 & e(sample)
su cs00_seg_inc if n250 & e(sample)
gen cs00_seg_inc_n = (cs00_seg_inc-r(mean))/r(sd) if n250 & e(sample)
reg e_rank_b_n frac_traveltime_lt15_n cs00_seg_inc_n if n250, cluster(state_id)
eststo m7
}
* Print table
esttab m1 m2 m3 m4 m5 m6 m7, cells(b(fmt(3)) se(par fmt(3))) stats(N r2) style(tab) drop(_cons) replace

* Table V
use analysis.dta, clear
estimates drop _all
qui {
* Gini
reg e_rank_b gini if n250
su e_rank_b if n250 & e(sample)
gen e_rank_b_n = (e_rank_b-r(mean))/r(sd) if n250 & e(sample)
su gini if n250 & e(sample)
gen gini_n = (gini-r(mean))/r(sd) if n250 & e(sample)
reg e_rank_b_n gini_n if n250, cluster(state_id)
drop *_n
eststo m1
* Gini Bottom 99% and Top 1% Income Share
reg e_rank_b gini99 inc_share_1perc if n250
su e_rank_b if n250 & e(sample)
gen e_rank_b_n = (e_rank_b-r(mean))/r(sd) if n250 & e(sample)
su gini99 if n250 & e(sample)
gen gini99_n = (gini99-r(mean))/r(sd) if n250 & e(sample)
su inc_share_1perc if n250 & e(sample)
gen inc_share_1perc_n = (inc_share_1perc-r(mean))/r(sd) if n250 & e(sample)
reg e_rank_b_n gini99_n inc_share_1perc_n if n250, cluster(state_id)
drop *_n
eststo m2
* Gini Bottom 99% and Top 1% Income Share - Urban Areas
reg e_rank_b gini99 inc_share_1perc if intersects_msa
su e_rank_b if intersects_msa & e(sample)
gen e_rank_b_n = (e_rank_b-r(mean))/r(sd) if intersects_msa & e(sample)
su gini99 if intersects_msa & e(sample)
gen gini99_n = (gini99-r(mean))/r(sd) if intersects_msa & e(sample)
su inc_share_1perc if intersects_msa & e(sample)
gen inc_share_1perc_n = (inc_share_1perc-r(mean))/r(sd) if intersects_msa & e(sample)
reg e_rank_b_n gini99_n inc_share_1perc_n if intersects_msa, cluster(state_id)
drop *_n
eststo m3
* Size of Middle Class
reg e_rank_b gini if n250
su e_rank_b if n250 & e(sample)
gen e_rank_b_n = (e_rank_b-r(mean))/r(sd) if n250 & e(sample)
su frac_middleclass if n250 & e(sample)
gen frac_middleclass_n = (frac_middleclass-r(mean))/r(sd) if n250 & e(sample)
reg e_rank_b_n frac_middleclass_n if n250, cluster(state_id)
drop *_n
eststo m4
* Gini Bottom 99% and Top 1% Income Share - Relative Mobility
reg s_rank gini99 inc_share_1perc if n250
su s_rank if n250 & e(sample)
gen s_rank_n = (s_rank-r(mean))/r(sd) if n250 & e(sample)
su gini99 if n250 & e(sample)
gen gini99_n = (gini99-r(mean))/r(sd) if n250 & e(sample)
su inc_share_1perc if n250 & e(sample)
gen inc_share_1perc_n = (inc_share_1perc-r(mean))/r(sd) if n250 & e(sample)
reg s_rank_n gini99_n inc_share_1perc_n if n250, cluster(state_id)
eststo m5
}
esttab m1 m2 m3 m4 m5, cells(b(fmt(3)) se(par fmt(3))) stats(N r2) drop(_cons)

* Table VI
use analysis.dta, clear
estimates clear
* Generate missing dummy for dropout rates
gen miss_dropout = dropout_r == .
* Generate missing dummy for social capital var
gen miss_scap = scap_ski90pcm == .
* Generate normalized variables
qui foreach v of varlist e_rank_b s_rank gini99 frac_traveltime_lt15 dropout_r scap_ski90pcm cs_fam_wkidsinglemom cs_race_bla {
  su `v' if n250
  gen `v'_n = (`v'-r(mean))/r(sd) if n250
  su `v' if intersects_msa
  gen `v'_n_u = (`v'-r(mean))/r(sd) if n250
}
replace dropout_r_n = 0 if miss_dropout == 1 & n250
replace dropout_r_n_u = 0 if miss_dropout == 1 & n250
replace scap_ski90pcm_n = 0 if miss_scap == 1 & n250
replace scap_ski90pcm_n_u = 0 if miss_scap == 1 & n250
* 5 factors, baseline
reg e_rank_b_n frac_traveltime_lt15_n gini99_n dropout_r_n miss_dropout scap_ski90pcm_n miss_scap cs_fam_wkidsinglemom_n if n250, cluster(state_id)
eststo m1
* 5 factors, state fx
areg e_rank_b_n frac_traveltime_lt15_n gini99_n dropout_r_n miss_dropout scap_ski90pcm_n miss_scap cs_fam_wkidsinglemom_n if n250, cluster(state_id) a(state_id)
eststo m2
* 5 factors, MSA only
ren *_n *_n250
ren *_n_u *_n
reg e_rank_b_n frac_traveltime_lt15_n gini99_n dropout_r_n miss_dropout scap_ski90pcm_n miss_scap cs_fam_wkidsinglemom_n if intersects_msa == 1, cluster(state_id)
eststo m3
* 5 factors, rel mobility
drop *_n
ren *_n250 *_n
reg s_rank_n frac_traveltime_lt15_n gini99_n dropout_r_n miss_dropout scap_ski90pcm_n miss_scap cs_fam_wkidsinglemom_n if n250, cluster(state_id)
eststo m4
* 4 factors only
reg s_rank_n frac_traveltime_lt15_n gini99_n dropout_r_n miss_dropout scap_ski90pcm_n miss_scap if n250, cluster(state_id)
eststo m5
* 4 factors only
reg e_rank_b_n frac_traveltime_lt15_n gini99_n dropout_r_n miss_dropout scap_ski90pcm_n miss_scap if n250, cluster(state_id)
eststo m6
* Single moms knocks out race
reg e_rank_b_n cs_race_bla_n cs_fam_wkidsinglemom_n if n250, cluster(state_id)
eststo m7
* 8 factors, baseline + race
reg e_rank_b_n frac_traveltime_lt15_n gini99_n dropout_r_n miss_dropout scap_ski90pcm_n miss_scap cs_fam_wkidsinglemom_n cs_race_bla_n if n250, cluster(state_id)
eststo m8
esttab m1 m2 m3 m4 m5 m6 m7 m8, cells(b(fmt(3)) se(par fmt(3))) stats(N r2) drop(_cons miss*)

* Online Appendix Table VII
use analysis.dta, clear
use analysis.dta, clear
mat def corrs = J(11, 4, .)  // A matrix to store correlations
mat colnames corrs = "e_rank_b" "s_rank" "e_rank_bw" "s_rankw"
mat rownames corrs = ///
  "malefam" "femfam" "marriedpar" "singlepar" "c8385" ///
  "indvrm" "coli4" "probp1k5" "i1112" "c1821" "teenbirthfem"
local row = 1
qui foreach v in  malefam femfam marriedpar singlepar 8385 ///
	indv_r_m coli4 prob 1112 c1821 teenbirth_fem {
  if `row' == 8 {
    corr e_rank_b prob_p1_k5
    mat def corrs[8, 1] = round(r(rho), .01)
    corr e_rank_b prob_p1_k5 [w=pop2000]
    mat def corrs[8, 3] = round(r(rho), .01)
	local row = `row' + 1
  }
  else {
    corr e_rank_b e_rank_b_`v'
    mat def corrs[`row', 1] = round(r(rho), .01)
    corr s_rank s_`v'
    mat def corrs[`row', 2] = round(r(rho), .01)
    corr e_rank_b e_rank_b_`v' [w=pop2000]
    mat def corrs[`row', 3] = round(r(rho), .01)
    corr s_rank s_`v' [w=pop2000]
    mat def corrs[`row', 4] = round(r(rho), .01)
    local row = `row' + 1
  }
}
mat list corrs

* Online Appendix Table VIII (corrs only - fatios of std. dev. can be computed similarly)
* Table 7
use analysis.dta, clear
* Matrix to hold output
matrix def beta = J(35, 6, .)
matrix def se = J(35, 6, .)
mat rownames beta = ///
  cs_race_bla cs_race_theil_2000 cs00_seg_inc cs00_seg_inc_pov25 cs00_seg_inc_aff75 frac_traveltime_lt15 ///
  hhinc00 gini inc_share_1perc gini99 frac_middleclass ///
  taxrate subcty_total_expenditure_pc eitc_exposure tax_st_diff_top20 ///
  ccd_exp_tot ccd_pup_tch_ratio score_r dropout_r ///
  num_inst_pc hed_cz_allyr_tuition gradrate_r ///
  cs_labforce cs_elf_ind_man d_tradeusch_pw_1990 frac_worked1416 ///
  mig_inflow cs_born_foreign mig_outflow ///
  scap_ski90pcm rel_tot crime_violent ///
  cs_fam_wkidsinglemom cs_divorced cs_married
mat rownames se = ///
  cs_race_bla cs_race_theil_2000 cs00_seg_inc cs00_seg_inc_pov25 cs00_seg_inc_aff75 frac_traveltime_lt15 ///
  hhinc00 gini inc_share_1perc gini99 frac_middleclass ///
  taxrate subcty_total_expenditure_pc eitc_exposure tax_st_diff_top20 ///
  ccd_exp_tot ccd_pup_tch_ratio score_r dropout_r ///
  num_inst_pc hed_cz_allyr_tuition gradrate_r ///
  cs_labforce cs_elf_ind_man d_tradeusch_pw_1990 frac_worked1416 ///
  mig_inflow cs_born_foreign mig_outflow ///
  scap_ski90pcm rel_tot crime_violent ///
  cs_fam_wkidsinglemom cs_divorced cs_married 
* Regressions
local row = 1
foreach var of varlist ///
  cs_race_bla cs_race_theil_2000 cs00_seg_inc cs00_seg_inc_pov25 cs00_seg_inc_aff75 frac_traveltime_lt15 ///
  hhinc00 gini inc_share_1perc gini99 frac_middleclass ///
  taxrate subcty_total_expenditure_pc eitc_exposure tax_st_diff_top20 ///
  ccd_exp_tot ccd_pup_tch_ratio score_r dropout_r ///
  num_inst_pc tuition gradrate_r ///
  cs_labforce cs_elf_ind_man d_tradeusch_pw_1990 frac_worked1416 ///
  mig_inflow cs_born_foreign mig_outflow ///
  scap_ski90pcm rel_tot crime_violent ///
  cs_fam_wkidsinglemom cs_divorced cs_married {
  local col = 1
  reg e_rank_b `var' if n250
  su e_rank_b if e(sample)
  gen eb1 = (e_rank_b-r(mean))/r(sd) if e(sample)
  su `var' if e(sample)
  gen v1 = (`var'-r(mean))/r(sd) if e(sample)
  reg eb1 v1 if n250, cluster(state_id)
  matrix def beta[`row', `col'] = round(_b[v1], .001)
  matrix def se[`row', `col'] = round(_se[v1], .001)
  corr e_rank_b `var' if n250
  drop eb1 v1
  local col = 2
  reg e_rank_b `var' if n250
  su e_rank_b if e(sample)
  gen eb2 = (e_rank_b-r(mean))/r(sd) if e(sample)
  su `var' if e(sample)
  gen v2 = (`var'-r(mean))/r(sd) if e(sample)
  areg eb2 v2 if n250, cluster(state_id) absorb(state_id)
  matrix def beta[`row', `col'] = round(_b[v2], .001)
  matrix def se[`row', `col'] = round(_se[v2], .001)
  drop eb2 v2
  local col = 3
  reg e_rank_b `var' if n250 [w=pop2000]
  su e_rank_b if e(sample) [w=pop2000]
  gen eb3 = (e_rank_b-r(mean))/r(sd) if e(sample)
  su `var' if e(sample) [w=pop2000]
  gen v3 = (`var'-r(mean))/r(sd) if e(sample)
  reg eb3 v3 if n250 [w=pop2000], cluster(state_id)
  matrix def beta[`row', `col'] = round(_b[v3], .001)
  matrix def se[`row', `col'] = round(_se[v3], .001)
  corr e_rank_b `var' if n250 [w=pop2000]
  drop eb3 v3
  local col = 4
  reg e_rank_b `var' if intersects_msa
  su e_rank_b if intersects_msa & e(sample)
  gen eb4 = (e_rank_b-r(mean))/r(sd) if intersects_msa & e(sample)
  su `var' if intersects_msa & e(sample)
  gen v4 = (`var'-r(mean))/r(sd) if e(sample)
  reg eb4 v4 if n250 & intersects_msa, cluster(state_id)
  matrix def beta[`row', `col'] = round(_b[v4], .001)
  matrix def se[`row', `col'] = round(_se[v4], .001)
  corr e_rank_b `var' if intersects_msa
  drop eb4 v4
  local col = 5
  if "`var'" != "cs_race_bla" {
  * First residualize on race and income growth and then normalize
  * Residualize e_rank_b
  reg e_rank_b `var'
  gen sample = (e(sample) & n250)
  reg e_rank_b cs_race_bla incgrowth0010 if sample
  predict e_rank_b_r if sample, res
  * Residualize RHS
  reg `var' cs_race_bla incgrowth0010 if sample
  predict `var'_r if sample, res
  * Normalize
  reg e_rank_b_r `var'_r if n250
  su e_rank_b_r if e(sample)
  gen eb5 = (e_rank_b_r-r(mean))/r(sd) if e(sample)
  su `var'_r if e(sample)
  gen v5 = (`var'_r-r(mean))/r(sd) if e(sample)
  * Get correlation
  reg eb5 v5 if sample, cluster(state_id)
  matrix def beta[`row', `col'] = round(_b[v5], .001)
  matrix def se[`row', `col'] = round(_se[v5], .001)
  drop e_rank_b_r eb5 v5 sample
  }
  local col = 6
  reg s_rank `var' if n250
  su s_rank if e(sample)
  gen s6 = (s_rank-r(mean))/r(sd) if e(sample)
  su `var' if e(sample)
  gen v6 = (`var'-r(mean))/r(sd) if e(sample)
  reg s6 v6 if n250, cluster(state_id)
  matrix def beta[`row', `col'] = round(_b[v6], .001)
  matrix def se[`row', `col'] = round(_se[v6], .001)
  corr s_rank `var' if n250
  drop s6 v6
  local row = `row' + 1
}
* Print betas
mat list beta
* Print SEs
mat list se

log close

* Figure VI
* Panel A
use analysis.dta, clear
usmaptile e_rank_b, shapefolder("$dir") geo(cz) equ rev legdecimals(1) ndfcolor(gs14)
graph export fig_vi_a.png, replace
* Panel B
use analysis.dta, clear
usmaptile s_rank, shapefolder("$dir") geo(cz) equ legdecimals(3) ndfcolor(gs14)
graph export fig_vi_b.png, replace

* Figure VIII
use analysis.dta, clear
qui {
local v = 1
foreach var of varlist ///
	cs_born_foreign mig_outflow mig_inflow ///
	frac_worked1416  d_tradeusch_pw_1990 cs_elf_ind_man ///
	gradrate_r tuition num_inst_pc ///
	tax_st_diff_top20 eitc_exposure  taxrate /// 
	cs_married cs_divorced cs_fam_wkidsinglemom ///
    crime_violent rel_tot scap_ski90pcm ///
	dropout_r  score_r ccd_pup_tch_ratio ///
    inc_share_1perc gini hhinc00 ///
    frac_traveltime_lt15 cs00_seg_inc_pov25 cs_race_theil_2000 cs_race_bla {
  reg e_rank_b `var' if n250
  su e_rank_b if e(sample)
  gen eb = (e_rank_b - r(mean))/r(sd)
  su `var' if e(sample)
  gen vb = (`var' - r(mean))/r(sd)
  reg eb vb if n250, cluster(state_id)
  drop eb vb
  scalar b = round(_b[vb], 0.001)
  corr e_rank_b `var' if n250
  scalar corr = round(r(rho), 0.001)
  if b != corr {
    di in red "Normalization samples don't match"
  }
  gen rcoef_`v' = abs(_b[vb])
  gen rse_`v' = _se[vb]
  gen rcih_`v' = abs(_b[vb]) + 1.96*_se[vb]
  gen rcil_`v' = abs(_b[vb]) - 1.96*_se[vb]
  replace rcil_`v' = 0 if rcil_`v' < 0  // Cut-off at 0
  local v = `v' + 1
}
* Reshape
keep rcoef_* rse_* rcil* rcih*
duplicates drop
gen i = 1
reshape long rcoef_ rse_ rcih_ rcil_, i(i) j(vnum)
label drop _all
* Make scatter plot
expand 2
gen p = _n > 28
forval v = 1/28 {
  gen ci`v' = rcil_ if p==0 & vnum==`v'
  replace ci`v' = rcih_ if p==1 & vnum==`v'
  replace rcoef_ = . if p==1 & vnum==`v'
}
replace vnum = vnum+9 if vnum == 28
replace vnum = vnum+8 if inrange(vnum,25,27)
replace vnum = vnum+7 if inrange(vnum,22,24)
replace vnum = vnum+6 if inrange(vnum,19,21)
replace vnum = vnum+5 if inrange(vnum,16,18)
replace vnum = vnum+4 if inrange(vnum,13,15)
replace vnum = vnum+3 if inrange(vnum,10,12)
replace vnum = vnum+2 if inrange(vnum,7,9)
replace vnum = vnum+1 if inrange(vnum,4,6)
label define varname ///
  1 "Frac. Foreign Born (-)" 2 "Migration Outflow (-)" 3 "Migration Inflow (-)" ///
  5 "Teenage LFP Rate (+)" 6 "Chinese Import Growth (-)" 7 "Manufacturing Share (-)"  ///
  9 "Coll Grad Rate (Inc Adjusted) (+)" 10 "College Tuition (-)" 11 "Colleges per Capita (+)" ///
  13 "Tax Progressivity (+)" 14 "State EITC Exposure (+)" 15 "Local Tax Rate (+)" ///
  17 "Frac. Married (+)" 18 "Divorce Rate (-)" 19 "Frac. Single Moms (-)" ///
  21 "Violent Crime Rate (-)" 22 "Frac. Religious (+)" 23 "Social Capital Index (+)" ///
  25 "High School Dropout (-)" 26 "Test Scores (Inc Adjusted) (+)" 27 "Student-Teacher Ratio (-)" ///
  29 "Top 1% Inc. Share (-)" 30 "Gini Coef. (-)" 31 "Mean Household Income (+)" ///
  33  "Frac. < 15 Mins to Work (+)" 34 "Segregation of Poverty (-)" 35 "Racial Segregation (-)" 37 "Frac. Black Residents (-)" 
label values vnum varname
scatter vnum ci1, c(l) mcolor(gs0) lcolor(gs9) lwidth(thin) m(i) || scatter vnum ci2, c(l) mcolor(gs0) lcolor(gs9) lwidth(thin) m(i) || scatter vnum ci3, c(l) mcolor(gs0) lcolor(gs9) lwidth(thin) m(i) || ///
scatter vnum ci4, c(l) mcolor(gs0) lcolor(gs9) lwidth(thin) m(i) || scatter vnum ci5, c(l) mcolor(gs0) lcolor(gs9) lwidth(thin) m(i) || scatter vnum ci6, c(l) mcolor(gs0) lcolor(gs9) lwidth(thin) m(i) || ///
scatter vnum ci7, c(l) mcolor(gs0) lcolor(gs9) lwidth(thin) m(i) || scatter vnum ci8, c(l) mcolor(gs0) lcolor(gs9) lwidth(thin) m(i) || scatter vnum ci9, c(l) mcolor(gs0) lcolor(gs9) lwidth(thin) m(i) || ///
scatter vnum ci10, c(l) mcolor(gs0) lcolor(gs9) lwidth(thin) m(i) || scatter vnum ci11, c(l) mcolor(gs0) lcolor(gs9) lwidth(thin) m(i) || scatter vnum ci12, c(l) mcolor(gs0) lcolor(gs9) lwidth(thin) m(i) || ///
scatter vnum ci13, c(l) mcolor(gs0) lcolor(gs9) lwidth(thin) m(i) || scatter vnum ci14, c(l) mcolor(gs0) lcolor(gs9) lwidth(thin) m(i) || scatter vnum ci15, c(l) mcolor(gs0) lcolor(gs9) lwidth(thin) m(i) || ///
scatter vnum ci16, c(l) mcolor(gs0) lcolor(gs9) lwidth(thin) m(i) || scatter vnum ci17, c(l) mcolor(gs0) lcolor(gs9) lwidth(thin) m(i) || scatter vnum ci18, c(l) mcolor(gs0) lcolor(gs9) lwidth(thin) m(i) || ///
scatter vnum ci19, c(l) mcolor(gs0) lcolor(gs9) lwidth(thin) m(i) || scatter vnum ci20, c(l) mcolor(gs0) lcolor(gs9) lwidth(thin) m(i) || scatter vnum ci21, c(l) mcolor(gs0) lcolor(gs9) lwidth(thin) m(i) || ///
scatter vnum ci22, c(l) mcolor(gs0) lcolor(gs9) lwidth(thin) m(i) || scatter vnum ci23, c(l) mcolor(gs0) lcolor(gs9) lwidth(thin) m(i) || scatter vnum ci24, c(l) mcolor(gs0) lcolor(gs9) lwidth(thin) m(i) || ///
scatter vnum ci25, c(l) mcolor(gs0) lcolor(gs9) lwidth(thin) m(i) || scatter vnum ci26, c(l) mcolor(gs0) lcolor(gs9) lwidth(thin) m(i) || scatter vnum ci27, c(l) mcolor(gs0) lcolor(gs9) lwidth(thin) m(i) || scatter vnum ci28, c(l) mcolor(gs0) lcolor(gs9) lwidth(thin) m(i) || ///
scatter vnum rcoef_ if vnum==1, mcolor(navy) m(s) || scatter vnum rcoef_ if vnum==2, mcolor(navy) m(s) || scatter vnum rcoef_ if vnum==3, mcolor(navy) m(s) || ///  
scatter vnum rcoef_ if vnum==5, mcolor(navy) m(s) || scatter vnum rcoef_ if vnum==6, mcolor(navy) m(s) || scatter vnum rcoef_ if vnum==7, mcolor(navy) m(s) || ///  
scatter vnum rcoef_ if vnum==9, mcolor(navy) m(s) || scatter vnum rcoef_ if vnum==10, mcolor(navy) m(s) || scatter vnum rcoef_ if vnum==11, mcolor(navy) m(s) || ///
scatter vnum rcoef_ if vnum==13, mcolor(navy) m(s) || scatter vnum rcoef_ if vnum==14, mcolor(navy) m(s) || scatter vnum rcoef_ if vnum==15, mcolor(navy) m(s) || ///
scatter vnum rcoef_ if vnum==17, mcolor(navy) m(s) || scatter vnum rcoef_ if vnum==18, mcolor(navy) m(s) || scatter vnum rcoef_ if vnum==19, mcolor(navy) m(s) || ///
scatter vnum rcoef_ if vnum==21, mcolor(navy) m(s) || scatter vnum rcoef_ if vnum==22, mcolor(navy) m(s) || scatter vnum rcoef_ if vnum==23, mcolor(navy) m(s) || ///
scatter vnum rcoef_ if vnum==25, mcolor(navy) m(s) || scatter vnum rcoef_ if vnum==26, mcolor(navy) m(s) || scatter vnum rcoef_ if vnum==27, mcolor(navy) m(s) || ///
scatter vnum rcoef_ if vnum==29, mcolor(navy) m(s) || scatter vnum rcoef_ if vnum==30, mcolor(navy) m(s) || scatter vnum rcoef_ if vnum==31, mcolor(navy) m(s) || ///
scatter vnum rcoef_ if vnum==33, mcolor(navy) m(s) || scatter vnum rcoef_ if vnum==34, mcolor(navy) m(s) || scatter vnum rcoef_ if vnum==35, mcolor(navy) m(s) || scatter vnum rcoef_ if vnum==37, mcolor(navy) m(s) ///
  yline(4, lc(gs12) lp(dash)) yline(8, lc(gs12) lp(dash)) yline(12, lc(gs12) lp(dash)) yline(16, lc(gs12) lp(dash)) ///
  yline(20, lc(gs12) lp(dash)) yline(24, lc(gs12) lp(dash)) yline(28, lc(gs12) lp(dash)) yline(32, lc(gs12) lp(dash)) yline(36, lc(gs12) lp(dash)) ///
  ytitle("") xtitle("Correlation") xlabel(, grid) title("Spatial Correlates of Upward Mobility `ige'") ///
  ylab(1 2 3 5 6 7 9 10 11 13 14 15 17 18 19 21 22 23 25 26 27 29 30 31 33 34 35 37, valuelabel angle(0) labsize(vsmall) nogrid) ///
  graphregion(color(white)) legend(off) xlabel(0 "0" 0.2 "0.2" 0.4 "0.4" 0.6 "0.6" 0.8 "0.8" 1 "1.0")
}
graph export fig_viii.png, replace

* Figure IX
* Panel A
use analysis.dta, clear
usmaptile e_rank_b_w80, shapefolder("$dir") geo(cz) equ rev legdecimals(1) ndfcolor(gs14)
graph export fig_ix_a.png, replace
  
* Online Appendix Figure V
use analysis.dta, clear
gen e_rank_b_hybrid = e_rank_b
replace e_rank_b_hybrid = e_rank_b_8085 if e_rank_b == .
usmaptile e_rank_b_hybrid, shapefolder("$dir") geo(cz) equ rev legdecimals(1) ndfcolor(gs14)
graph export app_fig_v.png, replace

* Online Appendix Figure VI
* Panel A
use analysis.dta, clear
usmaptile e_rank_b_coli4, shapefolder("$dir") geo(cz) equ rev legdecimals(1) ndfcolor(gs14)
graph export appfig_vi_a.png, replace
* Panel B
use analysis.dta, clear
usmaptile prob_p1_k5, shapefolder("$dir") geo(cz) equ rev legdecimals(3) ndfcolor(gs14)
graph export app_fig_vi_b.png, replace

* Online Appendix Figure VII
* Panel A
use analysis.dta, clear
usmaptile s_c1821, shapefolder("$dir") geo(cz) equ legdecimals(3) ndfcolor(gs14)
graph export app_fig_vii_a.png, replace

* Online Appendix Figure VIII
* Panel A
use analysis.dta, clear
usmaptile s_teenbirth_fem, shapefolder("$dir") geo(cz) equ rev legdecimals(3) ndfcolor(gs14)
graph export app_fig_viii_a.png, replace

* Online Appendix Figure X
* Panel A
use analysis.dta, clear
gen l_cs_race_theil_2000 = log(cs_race_theil_2000)
binscatter e_rank_b l_cs_race_theil_2000, ///
  xtitle("Log of Theil Index of Racial Segregation in 2000 (log scale)") ///
  ytitle("Upward Mobility") ///
  lcolor(maroon) ylabel(35(5)55, gmin gmax) yscale(range(32 56))
graph export app_fig_x_a.png, replace
* Panel B
use analysis.dta, clear
gen l_cs00_seg_inc = log(cs00_seg_inc)
binscatter e_rank_b l_cs00_seg_inc, ///
  xtitle("Rank-Order Index of Income Segregation (log scale)") ///
  ytitle("Upward Mobility") ///
  lcolor(maroon) ylabel(35(5)55, gmin gmax) yscale(range(32 56))
graph export app_fig_x_b.png, replace

* Online Appendix Figure XI
* Panel A
use analysis.dta, clear
gen l_hhinc00 = log(hhinc00)
binscatter e_rank_b l_hhinc00, ///
  xtitle("Mean Income per Working Age Adult ($1000s, log scale)") ///
  ytitle("Upward Mobility") ///
  lcolor(maroon) ylabel(35(5)55, gmin gmax) yscale(range(32 56))
graph export app_fig_xi_a.png, replace
* Panel B
use analysis.dta, clear
binscatter e_rank_b gini, ///
  xtitle("Gini Coef. for Parent Family Income (1996-2000)") ///
  ytitle("Upward Mobility") ///
  lcolor(maroon) ylabel(35(5)55, gmin gmax) yscale(range(32 56))
graph export app_fig_xi_b.png, replace
* Panel C
use analysis.dta, clear
gen l_inc_share_1perc = log(inc_share_1perc)
binscatter e_rank_b l_inc_share_1perc, ///
  xtitle("Top 1% Income Share Based on Family Income (1996-2000, log scale)") ///
  ytitle("Upward Mobility") ///
  lcolor(maroon) ylabel(35(5)55, gmin gmax) yscale(range(32 56))
graph export app_fig_xi_c.png, replace

* Online Appendix Figure XII
* Panel A
use analysis.dta, clear
replace cs_fam_wkidsinglemom = 100*cs_fam_wkidsinglemom
binscatter e_rank_b cs_fam_wkidsinglemom, ///
  xtitle("% Single Moms") ///
  ytitle("Upward Mobility") ///
  lcolor(maroon) ylabel(35(5)55, gmin gmax) yscale(range(32 56))
graph export app_fig_xii_a.png, replace
* Panel B
use analysis.dta, clear
replace cs_fam_wkidsinglemom = 100*cs_fam_wkidsinglemom
binscatter e_rank_b_marriedpar cs_fam_wkidsinglemom, ///
  xtitle("% Single Moms") ///
  ytitle("Upward Mobility (married pars only)") ///
  lcolor(maroon) ylabel(35(5)55, gmin gmax) yscale(range(32 56))
graph export app_fig_xii_b.png, replace
