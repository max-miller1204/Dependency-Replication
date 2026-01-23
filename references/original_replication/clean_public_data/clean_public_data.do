**********************
* RACE AND SEGREGATION
**********************

* WHITE SHARE BY CZ
insheet using "$root/data/public_raw_data/race_and_segregation/p008_zcta/DEC_00_SF1_P008_with_ann.csv", clear
gen cs_race_whi = vd03/vd01
ren geoid2 zcta5
ren vd01 pop_tot
ren vd03 count_white
keep zcta5 pop_tot cs_race_whi count_white
save "$root/data/clean_data/zcta_share_white.dta", replace

* BLACK SHARE BY CZ
insheet using "$root/data/public_raw_data/race_and_segregation/nhgis0048_csv/nhgis0048_ds146_2000_tract.csv", clear
gen county_id = 1000*statea + countya 
merge m:1 county_id using "$root/crosswalks/county_2000.dta"
gen count_black = fms002
egen count_total = rowtotal(fms*)
collapse (sum) count_black count_total, by(cz)
gen cs_race_bla = count_black/count_total
keep cz cs_race_bla
save "$root/data/clean_data/share_black.dta", replace

* THEIL INDEX (MULTI-GROUP) OVER CENSUS TRACTS WITHIN CZS (http://www.census.gov/hhes/www/housing/resseg/multigroup_entropy.pdf)
insheet using "$root/data/public_raw_data/race_and_segregation/nhgis0048_csv/nhgis0048_ds146_2000_tract.csv", clear
gen county_id = 1000*statea + countya 
merge m:1 county_id using "$root/crosswalks/county_2000.dta"

gen count_black = fms002
gen count_white = fms001
egen count_hisp = rowtotal(fms008 fms009 fms010 fms011 fms012 fms013 fms014)
egen count_total = rowtotal(fms*) 
gen count_other = count_total - count_black - count_white - count_hisp 
keep cz count*
egen cz_count_total = total(count_total), by(cz) 

foreach r in black white hisp other {
  gen share_`r' = count_`r'/count_total 
  egen cz_count_`r' = total(count_`r'), by(cz) 
  gen cz_share_`r' = cz_count_`r'/cz_count_total
}

foreach r in black white hisp other {
  gen term_`r' = -(share_`r' * log(share_`r')) 
  bys cz: gen cz_term_`r' = -(cz_share_`r' * log(cz_share_`r'))
} 

egen tract_entropy = rowtotal(term_black term_white term_hisp term_other)
egen cz_entropy = rowtotal(cz_term_black cz_term_white cz_term_hisp cz_term_other)

gen tract_term = ((count_total)/(cz_count_total * cz_entropy)) * (cz_entropy - tract_entropy)  

egen cs_race_theil_2000 = total(tract_term), by(cz) 
keep cz cs_race_theil_2000

duplicates drop
save "$root/data/clean_data/race_theil.dta", replace

* SEGREGATION OF INCOME OVER CENSUS TRACTS WITHIN CZS (Reardon 2011)
insheet using "$root/data/public_raw_data/race_and_segregation/nhgis0049_csv/nhgis0049_ds151_2000_tract.csv", clear

local i = 1
foreach var of varlist gmx001-gmx016 {
  ren `var' tr_hhinc`i'
  local i = `i'+1
}

gen county_id = 1000*statea + countya
keep tracta county_id tr_hhinc*
order tracta county_id tr_hhinc*
merge m:1 county_id using "$root/crosswalks/county_2000.dta", keepusing(cz) nogen

egen tr_hh = rowtotal(tr_hhinc*)
bys cz: egen cz_hh = total(tr_hh)

tempvar hhinc_sum
gen `hhinc_sum' = 0
forvalues i = 1/16 {
  replace `hhinc_sum' = `hhinc_sum'+tr_hhinc`i'
  gen tr_cdf`i' = `hhinc_sum'/tr_hh
}

tempvar cz_hhinc_sum
gen `cz_hhinc_sum' = 0
forvalues i = 1/16 {
  tempvar cz`i'
  bys cz: egen `cz`i'' = total(tr_hhinc`i')
  replace `cz_hhinc_sum' = `cz_hhinc_sum'+`cz`i''
  gen cz_cdf`i' = `cz_hhinc_sum'/cz_hh
}

forvalues i = 1/16 {
  gen tr_entropy`i' = tr_cdf`i'*ln(1/tr_cdf`i')/ln(2)+(1-tr_cdf`i')*ln(1/(1-tr_cdf`i'))/ln(2)
}

forvalues i = 1/16 {
  gen cz_entropy`i' = cz_cdf`i'*ln(1/cz_cdf`i')/ln(2)+(1-cz_cdf`i')*ln(1/(1-cz_cdf`i'))/ln(2)
}

* Reardon's (Thiel) H(p_k) for those p_k given by census income cuts
forvalues i = 1/16 {
  bys cz: egen h`i' = sum((tr_hh*tr_entropy`i')/(cz_hh*cz_entropy`i'))
  replace h`i' = 1-h`i'
}

* Estimate H(p) within each CZ using (12) from Reardon 2011
* We only need CZ-level data
keep cz cz_cdf* h* cz_entropy*
duplicates drop
* Reshape so that the unit of observation is a CZ income bin
reshape long cz_cdf h cz_entropy, i(cz) j(bin)
* Calculate powers of p_k and E_k to estimate (12)
gen cz_cdf2 = cz_cdf^2
gen cz_cdf3 = cz_cdf^3
gen cz_cdf4 = cz_cdf^4
gen cz_entropy2 = cz_entropy^2
* CZ identifiers that are easy to loop through
egen cz_n = group(cz)
* Variables to store coefficients
gen b0 = .
gen b1 = .
gen b2 = .
gen b3 = .
gen b4 = .
* Regressions by CZ
qui forvalues c = 1/741 {
  reg h cz_cdf* [w=cz_entropy2] if cz_n == `c'
  replace b0 = _b[_cons] if cz_n == `c'
  replace b1 = _b[cz_cdf] if cz_n == `c'
  replace b2 = _b[cz_cdf2] if cz_n == `c'
  replace b3 = _b[cz_cdf3] if cz_n == `c'
  replace b4 = _b[cz_cdf4] if cz_n == `c'
}
* We only need the coefficients
keep cz b?
duplicates drop

* Segregation of poverty and affluence
gen cs00_seg_inc_pov25 = b0+b1*.25+b2*.25^2+b3*.25^3+b4*.25^4
gen cs00_seg_inc_aff75 = b0+b1*.75+b2*.75^2+b3*.75^3+b4*.75^4

* Rank-Order Index H^R from equation (13)
* Take deltas from table 1
gen d0 = 1
gen d1 = 1/2
gen d2 = 11/36
gen d3 = 5/24
gen d4 = 137/900
* H^R
gen cs00_seg_inc = d0*b0+d1*b1+d2*b2+d3*b3+d4*b4

keep cz cs00_seg_inc*
save "$root/data/clean_data/income_segregation.dta", replace

* TRAVEL TIME LESS THAN 15 MINUTES BY CZ
insheet using "$root/data/public_raw_data/race_and_segregation/p031_county/DEC_00_SF3_P031_with_ann.csv", clear
ren geoid2 county_id
merge m:1 county_id using "$root/crosswalks/county_2000.dta"
egen travel_lt15 = rowtotal(vd03 vd04 vd05)
collapse (sum) travel_lt15 vd02, by(cz)
gen frac_traveltime_lt15 = travel_lt15/vd02
keep cz frac_traveltime_lt15
save "$root/data/clean_data/travel_time.dta", replace



*********************
* INCOME DISTRIBUTION
*********************

* HOUSEHOLD INCOME PER WORKING AGE ADULT BY CZ 2000
insheet using "$root/data/public_raw_data/income_distributions/p054_county/DEC_00_SF3_P054_with_ann.csv", clear
ren vd01 aggregate_income
drop geoid vd02 vd03
tempfile aggregate_income
save `aggregate_income'

insheet using "$root/data/public_raw_data/income_distributions/p008_county/DEC_00_SF3_P008_with_ann.csv", clear
merge 1:1 geoid2 using `aggregate_income', nogen
egen pop_working_age = rowtotal(vd19-vd34 vd58-vd73)

ren geoid2 county_id
merge m:1 county_id using "$root/crosswalks/county_2000.dta", nogen

collapse (sum) aggregate_income pop_working_age, by(cz)
gen hhinc_pc_2000_cpiu2007 = 207.3/172.2*aggregate_income/pop_working_age
keep cz hhinc_pc_2000_cpiu2007
save "$root/data/clean_data/hhinc.dta", replace

* HOUSEHOLD INCOME PER WORKING AGE ADULT BY CZ 1990
insheet using "$root/data/public_raw_data/income_distributions/nhgis0012_ds125_1990_county.csv", clear
gen county_id = 1000*statea + countya
ren fgw001 aggregate_income
keep county_id aggregate_income
tempfile aggregate_income
save `aggregate_income'

insheet using "$root/data/public_raw_data/income_distributions/nhgis0013_ds123_1990_county.csv", clear
gen county_id = 1000*statea + countya
egen pop_working_age = rowtotal(e1l011-e1l026)
keep county_id pop_working_age
merge 1:1 county_id using `aggregate_income', nogen
merge m:1 county_id using "$root/crosswalks/county_1990.dta", nogen

collapse (sum) aggregate_income pop_working_age, by(cz)
gen hhinc_pc_1990_cpiu2007 = 207.3/130.7*aggregate_income/pop_working_age
keep cz hhinc_pc_1990_cpiu2007
merge 1:1 cz using "$root/data/clean_data/hhinc.dta", nogen
save "$root/data/clean_data/hhinc.dta", replace



*************************************
* TAXES AND GOVERNMENT EXPENDITURES *
*************************************

* LOCAL EXPENDITURE AND TAXES (CENSUS OF GOVT. COUNTY AREA SUMMARIES)
use "$root/data/public_raw_data/taxes_and_govt_expenditure/county_finance_summaries.dta", clear

* Aggregation tables are given at http://www.census.gov/govs/www/class_ch13.html
gen total_expenditure = 0
qui foreach v in ///
E01 F01 G01 I01 L01 M01 N01 O01 P01 R01 E02 F02 ///
G02 I02 L02 M02 E03 F03 G03 E04 F04 G04 I04 L04 ///
M04 E05 F05 G05 L05 M05 N05 O05 P05 S05 E06 F06 ///
G06 I06 L06 M06 E12 F12 G12 L12 M12 N12 O12 P12 ///
Q12 R12 E14 F14 G14 I14 E16 F16 G16 E18 F18 G18 ///
L18 M18 N18 O18 P18 Q18 R18 E19 E20 F20 G20 I20 ///
L20 M20 E21 F21 G21 I21 L21 M21 N21 O21 P21 Q21 ///
S21 E22 F22 G22 I22 L22 M22 E23 F23 G23 I23 L23 ///
M23 N23 O23 P23 E24 F24 G24 L24 M24 N24 O24 P24 ///
R24 E25 F25 G25 I25 L25 M25 N25 O25 P25 S25 E26 F26 ///
G26 E28 F28 G28 I28 L28 M28 E29 F29 G29 I29 L29 ///
M29 N29 O29 P29 M30 N30 O30 P30 R30 E31 F31 G31 ///
E32 F32 G32 I32 L32 M32 N32 O32 P32 R32 E36 F36 ///
G36 E37 F37 G37 I37 L37 M37 E38 F38 G38 I38 L38 ///
M38 N38 O38 P38 R38 E39 F39 G39 I39 L39 M39 E44 ///
F44 G44 I44 L44 M44 N44 O44 P44 R44 E45 F45 G45 ///
E47 I47 L47 M47 N47 O47 P47 R47 E50 F50 G50 I50 ///
L50 M50 N50 O50 P50 R50 E51 I51 L51 M51 E52 F52 ///
G52 I52 L52 M52 N52 O52 P52 R52 E53 F53 G53 I53 ///
L53 M53 E54 F54 G54 I54 L54 M54 N54 O54 P54 R54 ///
E55 F55 G55 M55 N55 O55 P55 R55 E56 F56 G56 I56 ///
L56 M56 N56 O56 P56 R56 E57 F57 G57 I57 L57 M57 ///
E58 F58 G58 I58 L58 M58 E59 F59 G59 I59 L59 M59 ///
N59 O59 P59 R59 S59 E60 F60 G60 I60 L60 M60 N60 ///
O60 P60 R60 E61 F61 G61 I61 L61 M61 N61 O61 P61 ///
R61 E62 F62 G62 I62 L62 M62 N62 O62 P62 R62 E66 ///
F66 G66 I66 L66 M66 N66 O66 P66 R66 E67 I67 L67 ///
M67 N67 O67 P67 S67 E68 I68 M68 N68 O68 P68 E74 ///
E75 E77 F77 G77 E79 G79 F79 I79 L79 M79 N79 O79 ///
P79 R79 E80 F80 G80 I80 L80 M80 N80 O80 P80 R80 ///
E81 F81 G81 I81 L81 M81 N81 O81 P81 R81 E84 E85 ///
F85 G85 I85 E87 F87 G87 I87 L87 M87 N87 O87 P87 ///
R87 E89 F89 G89 I89 J89 L89 M89 N89 O89 P89 R89 ///
S89 E90 F90 G90 E91 F91 G91 I91 E92 F92 G92 I92 ///
E93 F93 G93 I93 E94 F94 G94 I94 L91 L92 L93 L94 ///
M91 M92 M93 M94 N91 N92 N93 N94 R91 R92 R93 R94 ///
X11 X12 Y05 Y06 Y14 Y53 Y25 Y34 Y45 {
  capture replace total_expenditure = total_expenditure + V_`v'
}

gen total_taxes = 0
foreach v in ///
T01 T08 T09 T10 T11 T12 T13 T14 T15 T16 T19 T20 T21 ///
T22 T23 T24 T25 T27 T28 T29 T40 T41 T50 T51 T53 T99 {
  capture replace  total_taxes = total_taxes + V_`v'
}

gen county_id = 1000*fipstate + fipsco
keep county_id popest total_expenditure total_taxes
merge 1:1 county_id using "$root/crosswalks/county_1990.dta"

collapse (rawsum) subcty_total_expenditure = total_expenditure ///
  subcty_total_taxes = total_taxes popest, by(cz)

gen subcty_total_expenditure_pc = subcty_total_expenditure / popest
gen subcty_total_taxes_pc = subcty_total_taxes / popest

keep cz subcty_total_expenditure_pc subcty_total_taxes_pc
drop if cz == .
save "$root/data/clean_data/subcty.dta", replace

* STATE EITC
import excel using "$root/data/public_raw_data/taxes_and_govt_expenditure/state_codes.xls", ///
  clear sheet("State-codes") firstrow cellrange(A1:S53)
drop in 1
drop state
ren B state
ren abbrev stateabbrv
ren D y1986
ren E y1987
ren F y1988
ren G y1989
ren H y1990
ren I y1991
ren J y1992
ren K y1993
ren L y1994
ren M y1995
ren N y1996
ren O y1997
ren P y1998
ren Q y1999
ren R y2000
ren S y2001

* We use the 2-child EITC for WI - the following code extracts this
replace y1994 = "ab20" if stateabbrv == "WI" 
forvalues y=1989/2001 {
  replace y`y' = substr(y`y', 3, 2) if stateabbrv == "WI"
  destring y`y', ignore("oth?") replace
}

forvalues y=1986/2001 {
  recode y`y' (. = 0)
}

* Compute mean exposure from 1981-2001 - no state EITC prior to 1986, so set to zero
forvalues y=1981/1985 {
  gen y`y' = 0
}

egen eitc_sum = rowtotal(y*)
gen eitc_exposure = eitc_sum/21
keep stateabbrv eitc_exposure
save "$root/data/clean_data/eitc_exposure.dta", replace

* TAX PROGRESSIVITY
import excel using "$root/data/public_raw_data/taxes_and_govt_expenditure/state_taxrates_2008.xlsx", ///
  clear firstrow
drop st_tax40
ren st_diff_tax_top20 tax_st_diff_top20 
ren state stateabbrv
save "$root/data/clean_data/tax_progressivity.dta", replace



******************
* K-12 EDUCATION *
******************

* SCHOOL EXPENDITURES PER STUDENT AND STUDENT-TEACHER RATIO
use "$root/data/public_raw_data/k-12/CCD_school_96.dta", clear
ren ncessch nces_sch_id
ren fips state_id 
ren leaid district_id 
gen zip99nov = real(zip96)  // We merge ZIPs to CZs using a ZIP to county crosswalk for November 1999
destring nces_sch_id state_id district_id, replace
drop if state_id > 56
* Student-teacher ratio
ren puptch96 ccd_pup_tch_ratio
* Recode the missing to . (from .m and .n)  3432 missing
replace ccd_pup_tch_ratio = . if (ccd_pup_tch_ratio == .m | ccd_pup_tch_ratio == .n)
* Recode the top 0.1% to be missing - they all have pupil to teacher ratios above 100
gsort - ccd_pup_tch_ratio
replace ccd_pup_tch_ratio = . in 1/86
replace ccd_pup_tch_ratio = . if ccd_pup_tch_ratio < 1
* Students per school
rename member96 ccd_stu_tot
replace ccd_stu_tot = . if (ccd_stu_tot == .m | ccd_stu_tot == .n)
gen ccd_stu_tot_miss = (ccd_stu_tot == .)
keep *_id ccd_* zip99nov
tempfile school
save `school'

use "$root/data/public_raw_data/k-12/CCD_sd_96.dta", clear
ren fips state_id 
ren leaid district_id
drop if CONUM96 == "N"
destring state_id district_id, replace
drop if state_id > 56
* Students per district
rename MEMBER96 ccd_dstu_tot
replace ccd_dstu_tot = . if (ccd_dstu_tot == .m | ccd_dstu_tot == .n)
gen ccd_dstu_tot_miss = (ccd_dstu_tot == .)
keep *_id ccd_*
tempfile district
save `district'

use "$root/data/public_raw_data/k-12/CCD_sd_finance_96.dta", clear
ren fipst state_id 
ren leaid district_id 
destring state_id district_id, replace
drop if state_id > 56 | district_id == .
* Total expenditures
ren totalexp ccd_exp_tot
keep *_id ccd_*
* Expenditures Per Stu
merge 1:1 district_id using `district', nogen
replace ccd_exp_tot = ccd_exp_tot/ccd_dstu_tot/(10^3)
save `district', replace

use `school', clear
merge m:1 district_id using `district', nogen update
keep if nces_sch_id != .
merge m:1 zip99nov using "$root/crosswalks/cw_zip99_cz.dta", keep(master match) nogen
collapse (mean) ccd_exp_tot ccd_pup_tch_ratio [w=ccd_stu_tot], by(cz)
keep cz ccd_exp_tot ccd_pup_tch_ratio
drop if cz == .
save "$root/data/clean_data/ccd.dta", replace

* HIGH SCHOOL DROPOUT RATE
use "$root/data/public_raw_data/k-12/dr001b", clear
keep leaid mzip DRP912 EBS912 gshi
ren DRP912 ccd_drpout912
replace ccd_drpout912 = . if ccd_drpout912 == .n | ccd_drpout912 == .m
replace EBS912 = . if EBS912 == .n | EBS912 == .m
destring leaid, replace
destring gshi, force replace
drop if gshi < 9 | gshi == .
gen ccd_drpout912_miss = (ccd_drpout912 == .)
gen zip = real(mzip)
ren zip zip99nov
merge m:1 zip99nov using "$root/crosswalks/cw_zip99_cz.dta", keepusing(cz) keep(3) nogen
preserve
gen cons = 1
collapse (rawsum) ccd_drpout912_miss cons, by(cz)
replace ccd_drpout912_miss = ccd_drpout912_miss / cons
keep cz ccd_drpout912_miss
tempfile miss
save `miss'
restore
collapse (mean) ccd_drpout912 [w=EBS912], by(cz)
merge 1:1 cz using `miss', nogen
replace ccd_drpout912 = ccd_drpout912/100
keep cz ccd_drpout912 ccd_drpout912_miss
drop if cz == .
save "$root/data/clean_data/dropout.dta", replace

* SCHOOL GRADE RANKS 
insheet using "$root/data/public_raw_data/k-12/Global-Report-Card-Data-11.14.12.csv", clear names
ren nationalmathpercentile mathp2004
ren v22 mathp2005
ren v23 mathp2006
ren v24 mathp2007
ren v25 mathp2008
ren v26 mathp2009
ren nationalreadingpercentile readp2004
ren v28 readp2005
ren v29 readp2006
ren v30 readp2007
ren v31 readp2008
ren v32 readp2009

keep ncesdistrictid state county zip totalpk12enrollment mathp2* readp2*

destring mathp* readp* totalpk12enrollment, force ignore("%") replace
reshape long mathp readp, i(ncesdistrictid state) j(year)

* Seperate mean percentile and coverage indicator (including only 2004, 2005, 2007 when no interpolation of scores or other year state/national adj.)
keep if inlist(year,2004,2005,2007)
foreach subj in math read {
  bys ncesdistrictid state: egen `subj'p_mean = mean(`subj'p)
  by ncesdistrictid state: egen `subj'p_mean_miss_f = count(`subj'p)
  replace `subj'p_mean_miss_f = (3-`subj'p_mean_miss_f)/3
  gen `subj'p_mean_miss = (`subj'p_mean==.)
}

ren zip zip99nov
merge m:1 zip99nov using "$root/crosswalks/cw_zip99_cz.dta", keep(1 3) nogen

* Merge on counties for non-matches to get 100% match rate
preserve
insheet using "$root/crosswalks/US_FIPS_Codes.csv", clear
gen county = subinstr(subinstr(upper(countyname),".","",.)," ","",.)
gen county_id = 1000*fipsstate + fipscounty
keep county county_id state 
tempfile countys
save `countys', replace
restore

replace county = subinstr(subinstr(county,".","",.)," ","",.)
merge m:1 state county using `countys', keep(1 3) nogen
replace county_id = 51121 if ncesdistrictid == 5103180 // Radford, VA gets combined with neighboring Montgomery County for statistical purposes
replace county_id = 56013 if ncesdistrictid == 5900002 // from school_2000.dta cw
merge m:1 county_id using "$root/crosswalks/county_2000.dta", keep(1 3) nogen update

gen scorep_mean = (mathp + readp)/2
keep cz scorep_mean totalpk12enrollment
collapse scorep_mean [w=totalpk12enrollment], by(cz)
drop if cz == .
save "$root/data/clean_data/reportcard.dta", replace



********************
* HIGHER EDUCATION *
********************

* NUMBER OF INSTITUTIONS PER CAPITA AND TUITION
* Prepare the data from each IPEDS data file individually and save as tempfiles
tempfile hd ef ic sfa

* Institutional details
use "$root/data/public_raw_data/higher_education/ipeds2000/working_data/dct_fa2000hd.dta", clear
* Impose sample restrictions
gen sample = 1
replace sample = 0 if inlist(stabbr, "AS", "FM", "GU", "MH", "MP", "PR", "PW", "VI")
label list sector
replace sample = 0 if inlist(sector, 0, 99)
label list pset4flg
replace sample = 0 if pset4flg != 1
label list ugoffer
replace sample = 0 if ugoffer != 1
label list deggrant
replace sample = 0 if deggrant != 1
ren zip ziplong
gen zip = real(substr(string(ziplong, "%9.0f"), 1, 5))
list zip ziplong in 1/10
keep unitid zip fips sector sample  // Keep unitid and county for merging
* Save
su
save "`hd'"

* Enrollments
use "$root/data/public_raw_data/higher_education/ipeds2000/working_data/dct_ef2000a.dta", clear
label list line  
keep if line == 1  // Counts of FTFTU and full-time undergrads
gen eftotlt = efrace15 + efrace16
keep unitid line eftotlt
reshape wide eftotlt, i(unitid) j(line)
ren eftotlt1 tot_ftftu
label var tot_ftftu "Total full-time first-time undergrads"
* Save
su
save "`ef'"

* Tuition
use "$root/data/public_raw_data/higher_education/ipeds2000/working_data/dct_ic2000_ay.dta", clear
corr chg2ay2 tuition2
ren tuition2 tuition
keep unitid tuition
* Save
su
save "`ic'"

* Merge IPEDS data together
use "`hd'", clear
merge 1:1 unitid using "`ef'", nogen
merge 1:1 unitid using "`ic'", nogen
keep if sample
ren zip zip99nov
merge m:1 zip99nov using "$root/crosswalks/cw_zip99_cz.dta", nogen keep(match master) keepusing(cz)

* Collapse to CZ level
collapse (count) num_inst = unitid (mean) tuition [w=tot_ftftu], by(cz)
drop if cz == .
save "$root/data/clean_data/ipeds2000.dta", replace

* 150%-OF-NORMAL-TIME GRADUATION RATE
* Prepare the data from each IPEDS data file individually and save as tempfiles
tempfile hd ef ic sfa gr

* Institutional details
use "$root/data/public_raw_data/higher_education/ipeds2009/working_data/dct_hd2009.dta", clear
* Impose sample restrictions
gen sample = 1
replace sample = 0 if inlist(stabbr, "AS", "FM", "GU", "MH", "MP", "PR", "PW", "VI")
label list sector
replace sample = 0 if inlist(sector, 0, 99)
label list pset4flg
replace sample = 0 if pset4flg != 1
label list ugoffer
replace sample = 0 if ugoffer != 1
label list deggrant
replace sample = 0 if deggrant != 1
keep unitid countycd sector sample  // Keep unitid and zip for merging
* Save
su
save "`hd'"

* Enrollments
use "$root/data/public_raw_data/higher_education/ipeds2009/working_data/dct_ef2009a_rv.dta", clear
label list line  // We need counts of FTFTU and full-time undergrads
keep if line == 1
keep unitid line eftotlt
reshape wide eftotlt, i(unitid) j(line)
ren eftotlt1 total_ftftu
label var total_ftftu "Total full-time first-time undergrads"
* Save
su
save "`ef'"

* Graduation rates
use "$root/data/public_raw_data/higher_education/ipeds2009/working_data/dct_gr2009_rv.dta", clear
label list grtype  // We want 4-year completion rate and 2-year completion rate
keep if inlist(grtype, 2, 3, 29, 30)
keep unitid grtype grtotlt
reshape wide grtotlt, i(unitid) j(grtype)
gen gradrate = grtotlt3/grtotlt2 if grtotlt2 != . & grtotlt3 != .
replace gradrate = grtotlt30/grtotlt29 if grtotlt29 != . & grtotlt30 != .
keep unitid gradrate
* Save
d
save "`gr'"

* Merge IPEDS data together
use "`hd'", clear
merge 1:1 unitid using "`ef'", nogen
merge 1:1 unitid using "`gr'", nogen
keep if sample

* Merge county-cz crosswalk
ren countycd county_id
merge m:1 county_id using "$root/crosswalks/county_2000.dta", keepusing(cz)
list unitid county_id if _merge == 1  // To-do: deal with this county
replace cz = 28900 if county_id == 8014
drop if _merge == 2
drop _merge

* Collapse to CZ level
collapse (mean) gradrate [w=total_ftftu], by(cz)
drop if cz == .
save "$root/data/clean_data/ipeds2009.dta", replace



**********************
* LOCAL LABOR MARKET *
**********************

* LABOR-FORCE PARTICIPATION
insheet using "$root/data/public_raw_data/local_labor_market/p043_zcta/DEC_00_SF3_P043_with_ann.csv", clear
ren geoid2 zcta5
gen inlf = vd03 + vd10
merge 1:1 zcta5 using "$root/crosswalks/cw_zcta00_cz.dta", nogen keep(3)  // Failed match in Puerto Rico
collapse inlf vd01, by(cz)
gen cs_labforce = inlf/vd01
keep cz cs_labforce
save "$root/data/clean_data/lfp.dta", replace

* MANUFACTURING EMPLOYMENT SHARE
insheet using "$root/data/public_raw_data/local_labor_market/p049_zcta/DEC_00_SF3_P049_with_ann.csv", clear
ren geoid2 zcta5
gen count_manuf = vd07 + vd34
merge 1:1 zcta5 using "$root/crosswalks/cw_zcta00_cz.dta", nogen keep(3)  // Failed match in Puerto Rico
collapse count_manuf vd01, by(cz)
gen cs_elf_ind_man = count_manuf/vd01
keep cz cs_elf_ind_man
save "$root/data/clean_data/emp_manuf.dta", replace

* IMPORT GROWTH FROM CHINA PER WORKER (AUTOR AND DORN)
use "$root/data/public_raw_data/local_labor_market/AutorDornHanson_TradeExposure_CZ.dta", clear
rename (d*) (d*_)
reshape wide d*, i(czone) j(yr)
rename czone cz
keep cz d_tradeusch_pw_1990
save "$root/data/clean_data/tradeexposure.dta", replace



*******************
* MIGRATION RATES *
*******************

* INFLOW AND OUTFLOW
* Prepare crosswalk 
use "$root/crosswalks/county_2000.dta", replace 
gen dest_county = county_id
gen orig_county = county_id 
keep cz dest_county orig_county

preserve
drop dest_county 
rename cz cz_orig
tempfile cz_cw_orig
save `cz_cw_orig'
restore

drop orig_county
rename cz cz_dest
tempfile cz_cw_dest
save `cz_cw_dest' 

insheet using "$root/data/public_raw_data/migration_rates/countyinflow0405.csv", clear 
drop if regexm(county_name, "Tot") | regexm(county_name,"Other")
gen dest_county=1000*state_code_dest + county_code_dest
gen orig_county=1000*state_code_origin + county_code_origin
rename exmpt_num flow 
keep flow dest_county orig_county 

merge m:1 dest_county using `cz_cw_dest', nogen
merge m:1 orig_county using `cz_cw_orig', nogen
replace cz_dest=28900 if dest_county==8014
replace cz_orig=28900 if dest_county==8014
drop if missing(cz_dest) | missing(cz_orig) 

* Exclude within-cz flows
drop if cz_dest == cz_orig

preserve
collapse (sum) flow, by(cz_dest)
rename cz_dest cz 
rename flow mig_inflow 
tempfile inflows
save `inflows'
restore

collapse (sum) flow, by(cz_orig)
rename cz_orig cz 
rename flow mig_outflow 
merge 1:1 cz using `inflows', nogen

replace mig_inflow = 0 if missing(mig_inflow)
replace mig_outflow = 0 if missing(mig_outflow) 

save "$root/data/clean_data/migration_rates.dta", replace

* SHARE FOREIGN BORN
insheet using "$root/data/public_raw_data/migration_rates/p021_zcta/DEC_00_SF3_P021_with_ann.csv", clear 
ren geoid2 zcta5
gen count_foreign = vd13
merge 1:1 zcta5 using "$root/crosswalks/cw_zcta00_cz.dta", nogen keep(3)  // Failed match in Puerto Rico
collapse (sum) vd01 count_foreign, by(cz)
gen cs_born_foreign = count_foreign/vd01
keep cz cs_born_foreign
save "$root/data/clean_data/foreignborn.dta", replace



******************
* SOCIAL CAPITAL *
******************

* SOCIAL CAPITAL INDEX
import excel using "$root/data/public_raw_data/social_capital/SocCapVariables.xls", firstrow clear
drop AREANAME
rename fips county_id
merge m:1 county_id using "$root/crosswalks/county_1990.dta", nogen keep(1 3)
collapse (mean) ski90pcm (rawsum) bowl90 pop90 [fw=pop1990], by(cz)
ren ski90pcm scap_ski90pcm
gen scap_bowl90 = bowl90/pop90
keep cz scap_ski90pcm scap_bowl90
save "$root/data/clean_data/social_capital.dta", replace

* SHARE RELIGIOUS
use "$root/data/public_raw_data/social_capital/Religious Congregations and Membership Study, 2000 (Counties File).dta", clear
keep totad POP200 fip
ren fip county_id
merge 1:1 county_id using "$root/crosswalks/county_2000.dta", nogen keep(1 3)
replace cz = 34109 if county_id == 2231
replace cz = 34402 if county_id == 30113
collapse totad POP200, by(cz)
gen rel_tot = totad/POP200
keep cz rel_tot
save "$root/data/clean_data/religious.dta", replace

* VIOLENT CRIMES
use "$root/data/public_raw_data/social_capital/ICPSR_03451/DS0001/03451-0001-Data.dta", clear
* Identify missing data (Use the table on page 17 of the codebook)
* If any of the variables for an observation are positive, then the missings should be coded as zeros.
gen byte missing = 1
foreach var of varlist COVIND-RUNAWAY {
  qui replace missing = 0 if `var' > 0
}
drop if missing == 1
* Keep violent crimes
drop if FIPS_CTY == 999
gen county_id = 1000*FIPS_ST + FIPS_CTY
keep county_id CPOPARST P1VLNT
merge 1:1 county_id using "$root/crosswalks/county_1990.dta", nogen keep(1 3)
replace cz = 34109 if inlist(county_id, 2232, 2282)
collapse (sum) CPOPARST P1VLNT, by(cz)
gen crime_violent = P1VLNT/CPOPARST
keep cz crime_violent
save "$root/data/clean_data/violent_crime.dta", replace

********************
* FAMILY STRUCTURE *
********************

* SHARE SINGLE-FEMALE HOUSEHOLDER
insheet using "$root/data/public_raw_data/family_structure/p018_zcta_wkid/DEC_00_SF1_P018_with_ann.csv", clear 
ren geoid2 zcta5
gen count_withchildren = vd08 + vd12 + vd15
keep zcta5 vd15 count_withchildren
merge 1:1 zcta5 using "$root/crosswalks/cw_zcta00_cz.dta", nogen keep(3)  // Failed match in Puerto Rico
collapse (sum) vd15 count_withchildren, by(cz)
gen cs_fam_wkidsinglemom = vd15/count_withchildren
keep cz cs_fam_wkidsinglemom
save "$root/data/clean_data/singlemom.dta", replace

* SHARE MARRIED AND DIVORCED
insheet using "$root/data/public_raw_data/family_structure/p018_zcta_married/DEC_00_SF3_P018_with_ann.csv", clear 
ren geoid2 zcta5
gen count_married = vd04 + vd13 - vd07 - vd16
gen count_divorced = vd10 + vd19
merge 1:1 zcta5 using "$root/crosswalks/cw_zcta00_cz.dta", nogen keep(3)  // Failed match in Puerto Rico
collapse (sum) count_married count_divorced vd01, by(cz)
gen cs_married = count_married/vd01
gen cs_divorced = count_divorced/vd01
keep cz cs_married cs_divorced
save "$root/data/clean_data/family_structure.dta", replace



***************************
* MISCELLANEOUS VARIABLES *
***************************

* INCOME GROWTH 2000 - 2006-10
insheet using "$root/data/public_raw_data/income_distributions/ACS_10_5YR_B19025/ACS_10_5YR_B19025_with_ann.csv", clear
ren geoid2 county_id
ren hd01_vd01 aggregate_income
keep county_id aggregate_income
tempfile income
save `income'
insheet using "$root/data/public_raw_data/income_distributions/aff_download/DEC_10_SF1_QTP2_with_ann.csv", clear
keep geoid2 subhd0101_*
egen working_age = rowtotal(subhd0101_s22-subhd0101_s79)
replace working_age = working_age - ///
  (subhd0101_s26 + subhd0101_s32 + subhd0101_s38 + subhd0101_s44 + ///
   subhd0101_s50 + subhd0101_s56 + subhd0101_s62 + subhd0101_s68 + subhd0101_s74)
ren geoid2 county_id
keep county_id working_age
merge 1:1 county_id using `income', nogen
merge 1:1 county_id using "$root/crosswalks/county_2010.dta", keepusing(cz) nogen
collapse (sum) aggregate_income working_age, by(cz)
gen hhinc2010 = aggregate_income/working_age
* CPI-U: http://www.minneapolisfed.org/community_education/teacher/calc/hist1913.cfm
* 2000: 172.2
* 2007: 207.3
* 2010: 218.1
gen hhinc2010_cpiu2007 = 207.3/218.1*hhinc2010
merge 1:1 cz using "$root/data/clean_data/hhinc.dta", keepusing(hhinc_pc_2000_cpiu2007) nogen
gen incgrowth0010 = (hhinc2010_cpiu2007/hhinc_pc_2000_cpiu2007)^(1/8) - 1
keep cz incgrowth0010
save "$root/data/clean_data/incgrowth0010.dta", replace

* URBAN AREAS
import excel using "$root/crosswalks/List1.xls", clear first
keep if MetropolitanMicropolitanStatist == "Metropolitan Statistical Area"
gen county_id = real(FIPSStateCode + FIPSCountyCode)
merge 1:1 county_id using "$root/crosswalks/county_2000.dta"
* Failed in using just means the counties aren't in an MSA
* Failed in master are all in Peurto Rico and one county in Colorado
replace cz = 28900 if county_id == 8014  // Manually assign the one county in Colorado
drop if _merge == 1 & county_id != 8014  // Drop Peurto Rico
gen intersects_msa = _merge == 3
collapse (max) intersects_msa, by(cz)
label var intersects_msa ""
save "$root/data/clean_data/intersects_msa.dta", replace

* STATE_ID
use "$root/crosswalks/county_2000.dta", clear
keep cz state_id stateabbrv
duplicates drop
save "$root/data/clean_data/state_id.dta", replace



***********
* COMBINE *
***********
use "$root/crosswalks/county_2000.dta", clear
keep cz czname stateabbrv pop2000
ren pop2000 county_pop2000
egen pop2000 = total(county_pop2000), by(cz)
drop county_pop2000
duplicates drop
foreach d in share_black race_theil income_segregation travel_time hhinc ///
    subcty eitc_exposure tax_progressivity ccd dropout reportcard ipeds2000 ///
	ipeds2009 lfp emp_manuf tradeexposure migration_rates foreignborn ///
    social_capital religious violent_crime singlemom family_structure ///
	incgrowth0010 intersects_msa state_id {
  if "`d'" != "eitc_exposure" & "`d'" != "tax_progressivity" {
    merge 1:1 cz using "$root/data/clean_data/`d'.dta", nogen
  }
  else {
    merge m:1 stateabbrv using "$root/data/clean_data/`d'.dta", nogen
  }
}

foreach var of varlist * {
  label var `var' ""
}

save "$root/data/clean_data/covariates.dta", replace
