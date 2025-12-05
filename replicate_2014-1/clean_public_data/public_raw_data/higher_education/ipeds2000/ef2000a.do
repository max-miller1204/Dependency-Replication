* Created: 6/12/2004 10:26:18 PM
*                                                        
* Modify the path below to point to your data file.      
* The specified subdirectory was not created on          
* your computer. You will need to do this.               
*                                                        
* The stat program must be run against the specified     
* data file. This file is specified in the program       
* and must be saved separately.                          
*                                                        
* This program does not provide tab or summarize for all 
* variables.                                             
*                                                        
* There may be missing data for some institutions due    
* to the merge used to create this file.                 
*                                                        
* This program does not include reserved values in its   
* calculations for missing values.                       
*                                                        
* You may need to adjust your memory settings depending  
* upon the number of variables and records.              
*                                                        
* The save command may need to be modified per user      
* requirements.                                          
*                                                        
* For long lists of value labels, the titles may be      
* shortened per program requirements. 
*                                                        
clear all                                         
insheet using ef2000a_data_stata.csv, comma clear
label data "dct_ef2000a"
label variable unitid "unitid"
label variable line "Type of student counted"
label variable section "Attendance status"
label variable lstudy "Level of study"
label variable xefrac01 "Imputation field for EFRACE01 - Nonresident alien men"
label variable efrace01 "Nonresident alien men"
label variable xefrac02 "Imputation field for EFRACE02 - Nonresident alien women"
label variable efrace02 "Nonresident alien women"
label variable xefrac03 "Imputation field for EFRACE03 - Black, non-Hispanic men"
label variable efrace03 "Black, non-Hispanic men"
label variable xefrac04 "Imputation field for EFRACE04 - Black, non-Hispanic women"
label variable efrace04 "Black, non-Hispanic women"
label variable xefrac05 "Imputation field for EFRACE05 - American Indian or Alaskan Native men"
label variable efrace05 "American Indian or Alaskan Native men"
label variable xefrac06 "Imputation field for EFRACE06 - American Indian or Alaskan Native women"
label variable efrace06 "American Indian or Alaskan Native women"
label variable xefrac07 "Imputation field for EFRACE07 - Asian or Pacific Islander men"
label variable efrace07 "Asian or Pacific Islander men"
label variable xefrac08 "Imputation field for EFRACE08 - Asian or Pacific Islander women"
label variable efrace08 "Asian or Pacific Islander women"
label variable xefrac09 "Imputation field for EFRACE09 - Hispanic men"
label variable efrace09 "Hispanic men"
label variable xefrac10 "Imputation field for EFRACE10 - Hispanic women"
label variable efrace10 "Hispanic women"
label variable xefrac11 "Imputation field for EFRACE11 - White, non-Hispanic men"
label variable efrace11 "White, non-Hispanic men"
label variable xefrac12 "Imputation field for EFRACE12 - White, non-Hispanic women"
label variable efrace12 "White, non-Hispanic women"
label variable xefrac13 "Imputation field for EFRACE13 - Race/ethnicity unknown men"
label variable efrace13 "Race/ethnicity unknown men"
label variable xefrac14 "Imputation field for EFRACE14 - Race/ethnicity unknown women"
label variable efrace14 "Race/ethnicity unknown women"
label variable xefrac15 "Imputation field for EFRACE15 - Grand total men"
label variable efrace15 "Grand total men"
label variable xefrac16 "Imputation field for EFRACE16 - Grand total women"
label variable efrace16 "Grand total women"
label define line 1 "Full-time, first-time, first-year, degree-seeking undergraduates" 
label define line 11 "Total, full-time graduates", add 
label define line 14 "Total, full-time", add 
label define line 15 "Part-time, first-time, first-year, degree-seeking undergraduates", add 
label define line 17 "Other part-time undergraduates", add 
label define line 22 "Total, part-time undergraduates", add 
label define line 23 "Total, part-time first-professional", add 
label define line 25 "Total, part-time graduates", add 
label define line 28 "Total, part-time", add 
label define line 29 "Total enrollment", add 
label define line 3 "Other, full-time undergraduates", add 
label define line 8 "Total, full-time undergraduates", add 
label define line 9 "Total, full-time first-professional", add 
label values line line
label define section 1 "Full-time" 
label define section 2 "Part-time", add 
label define section 3 "All students", add 
label values section section
label define lstudy 1 "Undergraduate" 
label define lstudy 2 "First-professional", add 
label define lstudy 3 "Graduate", add 
label define lstudy 4 "All students", add 
label values lstudy lstudy
label define xefrac01 10 "Reported" 
label define xefrac01 11 "Analyst corrected reported value", add 
label define xefrac01 12 "Data generated from other data values", add 
label define xefrac01 13 "Implied zero", add 
label define xefrac01 20 "Imputed using Carry Forward procedure", add 
label define xefrac01 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xefrac01 30 "Not applicable", add 
label define xefrac01 31 "Institution left item blank", add 
label define xefrac01 32 "Do not know", add 
label define xefrac01 40 "Suppressed to protect confidentiality", add 
label values xefrac01 xefrac01
label define xefrac02 10 "Reported" 
label define xefrac02 11 "Analyst corrected reported value", add 
label define xefrac02 12 "Data generated from other data values", add 
label define xefrac02 13 "Implied zero", add 
label define xefrac02 20 "Imputed using Carry Forward procedure", add 
label define xefrac02 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xefrac02 30 "Not applicable", add 
label define xefrac02 31 "Institution left item blank", add 
label define xefrac02 32 "Do not know", add 
label define xefrac02 40 "Suppressed to protect confidentiality", add 
label values xefrac02 xefrac02
label define xefrac03 10 "Reported" 
label define xefrac03 11 "Analyst corrected reported value", add 
label define xefrac03 12 "Data generated from other data values", add 
label define xefrac03 13 "Implied zero", add 
label define xefrac03 20 "Imputed using Carry Forward procedure", add 
label define xefrac03 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xefrac03 30 "Not applicable", add 
label define xefrac03 31 "Institution left item blank", add 
label define xefrac03 32 "Do not know", add 
label define xefrac03 40 "Suppressed to protect confidentiality", add 
label values xefrac03 xefrac03
label define xefrac04 10 "Reported" 
label define xefrac04 11 "Analyst corrected reported value", add 
label define xefrac04 12 "Data generated from other data values", add 
label define xefrac04 13 "Implied zero", add 
label define xefrac04 20 "Imputed using Carry Forward procedure", add 
label define xefrac04 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xefrac04 30 "Not applicable", add 
label define xefrac04 31 "Institution left item blank", add 
label define xefrac04 32 "Do not know", add 
label define xefrac04 40 "Suppressed to protect confidentiality", add 
label values xefrac04 xefrac04
label define xefrac05 10 "Reported" 
label define xefrac05 11 "Analyst corrected reported value", add 
label define xefrac05 12 "Data generated from other data values", add 
label define xefrac05 13 "Implied zero", add 
label define xefrac05 20 "Imputed using Carry Forward procedure", add 
label define xefrac05 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xefrac05 30 "Not applicable", add 
label define xefrac05 31 "Institution left item blank", add 
label define xefrac05 32 "Do not know", add 
label define xefrac05 40 "Suppressed to protect confidentiality", add 
label values xefrac05 xefrac05
label define xefrac06 10 "Reported" 
label define xefrac06 11 "Analyst corrected reported value", add 
label define xefrac06 12 "Data generated from other data values", add 
label define xefrac06 13 "Implied zero", add 
label define xefrac06 20 "Imputed using Carry Forward procedure", add 
label define xefrac06 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xefrac06 30 "Not applicable", add 
label define xefrac06 31 "Institution left item blank", add 
label define xefrac06 32 "Do not know", add 
label define xefrac06 40 "Suppressed to protect confidentiality", add 
label values xefrac06 xefrac06
label define xefrac07 10 "Reported" 
label define xefrac07 11 "Analyst corrected reported value", add 
label define xefrac07 12 "Data generated from other data values", add 
label define xefrac07 13 "Implied zero", add 
label define xefrac07 20 "Imputed using Carry Forward procedure", add 
label define xefrac07 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xefrac07 30 "Not applicable", add 
label define xefrac07 31 "Institution left item blank", add 
label define xefrac07 32 "Do not know", add 
label define xefrac07 40 "Suppressed to protect confidentiality", add 
label values xefrac07 xefrac07
label define xefrac08 10 "Reported" 
label define xefrac08 11 "Analyst corrected reported value", add 
label define xefrac08 12 "Data generated from other data values", add 
label define xefrac08 13 "Implied zero", add 
label define xefrac08 20 "Imputed using Carry Forward procedure", add 
label define xefrac08 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xefrac08 30 "Not applicable", add 
label define xefrac08 31 "Institution left item blank", add 
label define xefrac08 32 "Do not know", add 
label define xefrac08 40 "Suppressed to protect confidentiality", add 
label values xefrac08 xefrac08
label define xefrac09 10 "Reported" 
label define xefrac09 11 "Analyst corrected reported value", add 
label define xefrac09 12 "Data generated from other data values", add 
label define xefrac09 13 "Implied zero", add 
label define xefrac09 20 "Imputed using Carry Forward procedure", add 
label define xefrac09 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xefrac09 30 "Not applicable", add 
label define xefrac09 31 "Institution left item blank", add 
label define xefrac09 32 "Do not know", add 
label define xefrac09 40 "Suppressed to protect confidentiality", add 
label values xefrac09 xefrac09
label define xefrac10 10 "Reported" 
label define xefrac10 11 "Analyst corrected reported value", add 
label define xefrac10 12 "Data generated from other data values", add 
label define xefrac10 13 "Implied zero", add 
label define xefrac10 20 "Imputed using Carry Forward procedure", add 
label define xefrac10 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xefrac10 30 "Not applicable", add 
label define xefrac10 31 "Institution left item blank", add 
label define xefrac10 32 "Do not know", add 
label define xefrac10 40 "Suppressed to protect confidentiality", add 
label values xefrac10 xefrac10
label define xefrac11 10 "Reported" 
label define xefrac11 11 "Analyst corrected reported value", add 
label define xefrac11 12 "Data generated from other data values", add 
label define xefrac11 13 "Implied zero", add 
label define xefrac11 20 "Imputed using Carry Forward procedure", add 
label define xefrac11 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xefrac11 30 "Not applicable", add 
label define xefrac11 31 "Institution left item blank", add 
label define xefrac11 32 "Do not know", add 
label define xefrac11 40 "Suppressed to protect confidentiality", add 
label values xefrac11 xefrac11
label define xefrac12 10 "Reported" 
label define xefrac12 11 "Analyst corrected reported value", add 
label define xefrac12 12 "Data generated from other data values", add 
label define xefrac12 13 "Implied zero", add 
label define xefrac12 20 "Imputed using Carry Forward procedure", add 
label define xefrac12 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xefrac12 30 "Not applicable", add 
label define xefrac12 31 "Institution left item blank", add 
label define xefrac12 32 "Do not know", add 
label define xefrac12 40 "Suppressed to protect confidentiality", add 
label values xefrac12 xefrac12
label define xefrac13 10 "Reported" 
label define xefrac13 11 "Analyst corrected reported value", add 
label define xefrac13 12 "Data generated from other data values", add 
label define xefrac13 13 "Implied zero", add 
label define xefrac13 20 "Imputed using Carry Forward procedure", add 
label define xefrac13 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xefrac13 30 "Not applicable", add 
label define xefrac13 31 "Institution left item blank", add 
label define xefrac13 32 "Do not know", add 
label define xefrac13 40 "Suppressed to protect confidentiality", add 
label values xefrac13 xefrac13
label define xefrac14 10 "Reported" 
label define xefrac14 11 "Analyst corrected reported value", add 
label define xefrac14 12 "Data generated from other data values", add 
label define xefrac14 13 "Implied zero", add 
label define xefrac14 20 "Imputed using Carry Forward procedure", add 
label define xefrac14 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xefrac14 30 "Not applicable", add 
label define xefrac14 31 "Institution left item blank", add 
label define xefrac14 32 "Do not know", add 
label define xefrac14 40 "Suppressed to protect confidentiality", add 
label values xefrac14 xefrac14
label define xefrac15 10 "Reported" 
label define xefrac15 11 "Analyst corrected reported value", add 
label define xefrac15 12 "Data generated from other data values", add 
label define xefrac15 13 "Implied zero", add 
label define xefrac15 20 "Imputed using Carry Forward procedure", add 
label define xefrac15 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xefrac15 30 "Not applicable", add 
label define xefrac15 31 "Institution left item blank", add 
label define xefrac15 32 "Do not know", add 
label define xefrac15 40 "Suppressed to protect confidentiality", add 
label values xefrac15 xefrac15
label define xefrac16 10 "Reported" 
label define xefrac16 11 "Analyst corrected reported value", add 
label define xefrac16 12 "Data generated from other data values", add 
label define xefrac16 13 "Implied zero", add 
label define xefrac16 20 "Imputed using Carry Forward procedure", add 
label define xefrac16 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xefrac16 30 "Not applicable", add 
label define xefrac16 31 "Institution left item blank", add 
label define xefrac16 32 "Do not know", add 
label define xefrac16 40 "Suppressed to protect confidentiality", add 
label values xefrac16 xefrac16
tab line
tab section
tab lstudy
tab xefrac01
tab xefrac02
tab xefrac03
tab xefrac04
tab xefrac05
tab xefrac06
tab xefrac07
tab xefrac08
tab xefrac09
tab xefrac10
tab xefrac11
tab xefrac12
tab xefrac13
tab xefrac14
tab xefrac15
tab xefrac16
summarize efrace01
summarize efrace02
summarize efrace03
summarize efrace04
summarize efrace05
summarize efrace06
summarize efrace07
summarize efrace08
summarize efrace09
summarize efrace10
summarize efrace11
summarize efrace12
summarize efrace13
summarize efrace14
summarize efrace15
summarize efrace16
save working_data/dct_ef2000a.dta, replace

