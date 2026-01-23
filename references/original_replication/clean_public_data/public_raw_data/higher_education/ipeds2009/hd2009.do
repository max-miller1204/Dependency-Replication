* Modified by Alex Olssen <alex.olssen@gmail.com>
* I did the following:
* 1. changed paths
* 2. commented out two sections that tried to add value labels to strings...
* 3. fixed some strings being split across lines
* 4. changed value label names from label_name to name

* Created: 10/1/2010 11:35:34 PM
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
insheet using hd2009_data_stata.csv, comma clear
label data "dct_hd2009"
label variable unitid "unitid"
label variable addr "Street address or post office box"
label variable city "City location of institution"
label variable stabbr "State abbreviation"
label variable zip "ZIP code"
label variable fips "FIPS state code"
label variable obereg "Geographic region"
label variable chfnm "Name of chief administrator"
label variable chftitle "Title of chief administrator"
label variable gentele "General information telephone number"
label variable ein "Employer Identification Number"
label variable opeid "Office of Postsecondary Education (OPE) ID Number"
label variable opeflag "OPE Title IV eligibility indicator code"
label variable webaddr "Institution^s internet website address"
label variable adminurl "Admissions office web address"
label variable faidurl "Financial aid office web address"
label variable applurl "Online application web address"
label variable sector "Sector of institution"
label variable iclevel "Level of institution"
label variable control "Control of institution"
label variable hloffer "Highest level of offering"
label variable ugoffer "Undergraduate offering"
label variable groffer "Graduate offering"
label variable hdegofr1 "Highest degree offered"
label variable deggrant "Degree-granting status"
label variable hbcu "Historically Black College or University"
label variable hospital "Institution has hospital"
label variable medical "Institution grants a medical degree"
label variable tribal "Tribal college"
label variable locale "Degree of urbanization (Urban-centric locale)"
label variable openpubl "Institution open to the general public"
label variable act "Status of institution"
label variable newid "UNITID for merged schools"
label variable deathyr "Year institution was deleted from IPEDS"
label variable closedat "Date institution closed"
label variable cyactive "Institution is active in current year"
label variable postsec "Primarily postsecondary indicator"
label variable pseflag "Postsecondary institution indicator"
label variable pset4flg "Postsecondary and Title IV institution indicator"
label variable rptmth "Reporting method for student charges, graduation rates, retention rates and student financial aid"
label variable ialias "Institution name alias"
label variable instcat "Institutional category"
label variable ccbasic "Carnegie Classification 2005"
label variable ccipug "Carnegie Classification 2005"
label variable ccipgrad "Carnegie Classification 2005"
label variable ccugprof "Carnegie Classification 2005"
label variable ccenrprf "Carnegie Classification 2005"
label variable ccsizset "Carnegie Classification 2005"
label variable carnegie "Carnegie Classification 2000"
label variable tenursys "Does institution have a tenure system"
label variable landgrnt "Land Grant Institution"
label variable instsize "Institution size category"
label variable cbsa "Core Based Statistical Area (CBSA)"
label variable cbsatype "CBSA Type Metropolitan or Micropolitan"
label variable csa "Combined Statistical Area (CSA)"
label variable necta "New England City and Town Area (NECTA)"
label variable longitud "Longitude location of institution"
label variable latitude "Latitude location of institution"
label variable countycd "Fips County code"
label variable countynm "County name"
label variable cngdstcd "Congressional district code"
label variable dfrcgid "Data Feedback Report comparison group category"
/*label define stabbr AK "Alaska"  ... can't label strings
label define stabbr AL "Alabama", add 
label define stabbr AR "Arkansas", add 
label define stabbr AS "American Samoa", add 
label define stabbr AZ "Arizona", add 
label define stabbr CA "California", add 
label define stabbr CO "Colorado", add 
label define stabbr CT "Connecticut", add 
label define stabbr DC "District of Columbia", add 
label define stabbr DE "Delaware", add 
label define stabbr FL "Florida", add 
label define stabbr FM "Federated States of Micronesia", add 
label define stabbr GA "Georgia", add 
label define stabbr GU "Guam", add 
label define stabbr HI "Hawaii", add 
label define stabbr IA "Iowa", add 
label define stabbr ID "Idaho", add 
label define stabbr IL "Illinois", add 
label define stabbr IN "Indiana", add 
label define stabbr KS "Kansas", add 
label define stabbr KY "Kentucky", add 
label define stabbr LA "Louisiana", add 
label define stabbr MA "Massachusetts", add 
label define stabbr MD "Maryland", add 
label define stabbr ME "Maine", add 
label define stabbr MH "Marshall Islands", add 
label define stabbr MI "Michigan", add 
label define stabbr MN "Minnesota", add 
label define stabbr MO "Missouri", add 
label define stabbr MP "Northern Marianas", add 
label define stabbr MS "Mississippi", add 
label define stabbr MT "Montana", add 
label define stabbr NC "North Carolina", add 
label define stabbr ND "North Dakota", add 
label define stabbr NE "Nebraska", add 
label define stabbr NH "New Hampshire", add 
label define stabbr NJ "New Jersey", add 
label define stabbr NM "New Mexico", add 
label define stabbr NV "Nevada", add 
label define stabbr NY "New York", add 
label define stabbr OH "Ohio", add 
label define stabbr OK "Oklahoma", add 
label define stabbr OR "Oregon", add 
label define stabbr PA "Pennsylvania", add 
label define stabbr PR "Puerto Rico", add 
label define stabbr PW "Palau", add 
label define stabbr RI "Rhode Island", add 
label define stabbr SC "South Carolina", add 
label define stabbr SD "South Dakota", add 
label define stabbr TN "Tennessee", add 
label define stabbr TX "Texas", add 
label define stabbr UT "Utah", add 
label define stabbr VA "Virginia", add 
label define stabbr VI "Virgin Islands", add 
label define stabbr VT "Vermont", add 
label define stabbr WA "Washington", add 
label define stabbr WI "Wisconsin", add 
label define stabbr WV "West Virginia", add 
label define stabbr WY "Wyoming", add 
label values stabbr stabbr*/
label define fips 1 "Alabama" 
label define fips 10 "Delaware", add 
label define fips 11 "District of Columbia", add 
label define fips 12 "Florida", add 
label define fips 13 "Georgia", add 
label define fips 15 "Hawaii", add 
label define fips 16 "Idaho", add 
label define fips 17 "Illinois", add 
label define fips 18 "Indiana", add 
label define fips 19 "Iowa", add 
label define fips 2 "Alaska", add 
label define fips 20 "Kansas", add 
label define fips 21 "Kentucky", add 
label define fips 22 "Louisiana", add 
label define fips 23 "Maine", add 
label define fips 24 "Maryland", add 
label define fips 25 "Massachusetts", add 
label define fips 26 "Michigan", add 
label define fips 27 "Minnesota", add 
label define fips 28 "Mississippi", add 
label define fips 29 "Missouri", add 
label define fips 30 "Montana", add 
label define fips 31 "Nebraska", add 
label define fips 32 "Nevada", add 
label define fips 33 "New Hampshire", add 
label define fips 34 "New Jersey", add 
label define fips 35 "New Mexico", add 
label define fips 36 "New York", add 
label define fips 37 "North Carolina", add 
label define fips 38 "North Dakota", add 
label define fips 39 "Ohio", add 
label define fips 4 "Arizona", add 
label define fips 40 "Oklahoma", add 
label define fips 41 "Oregon", add 
label define fips 42 "Pennsylvania", add 
label define fips 44 "Rhode Island", add 
label define fips 45 "South Carolina", add 
label define fips 46 "South Dakota", add 
label define fips 47 "Tennessee", add 
label define fips 48 "Texas", add 
label define fips 49 "Utah", add 
label define fips 5 "Arkansas", add 
label define fips 50 "Vermont", add 
label define fips 51 "Virginia", add 
label define fips 53 "Washington", add 
label define fips 54 "West Virginia", add 
label define fips 55 "Wisconsin", add 
label define fips 56 "Wyoming", add 
label define fips 6 "California", add 
label define fips 60 "American Samoa", add 
label define fips 64 "Federated States of Micronesia", add 
label define fips 66 "Guam", add 
label define fips 68 "Marshall Islands", add 
label define fips 69 "Northern Marianas", add 
label define fips 70 "Palau", add 
label define fips 72 "Puerto Rico", add 
label define fips 78 "Virgin Islands", add 
label define fips 8 "Colorado", add 
label define fips 9 "Connecticut", add 
label values fips fips
label define obereg 0 "US Service schools" 
label define obereg 1 "New England CT ME MA NH RI VT", add 
label define obereg 2 "Mid East DE DC MD NJ NY PA", add 
label define obereg 3 "Great Lakes IL IN MI OH WI", add 
label define obereg 4 "Plains IA KS MN MO NE ND SD", add 
label define obereg 5 "Southeast AL AR FL GA KY LA MS NC SC TN VA WV", add 
label define obereg 6 "Southwest AZ NM OK TX", add 
label define obereg 7 "Rocky Mountains CO ID MT UT WY", add 
label define obereg 8 "Far West AK CA HI NV OR WA", add 
label define obereg 9 "Outlying areas AS FM GU MH MP PR PW VI", add 
label values obereg obereg
label define opeflag 1 "Participates in Title IV federal financial aid programs" 
label define opeflag 2 "Branch campus of a main campus that participates in Title IV", add 
label define opeflag 3 "Deferment only - limited participation", add 
label define opeflag 4 "New participants (became eligible during winter collection)", add 
label define opeflag 5 "Not currently participating in Title IV, has an OPE ID number", add 
label define opeflag 6 "Not currently participating in Title IV, does not have OPE ID number", add 
label define opeflag 7 "Stopped participating during the survey year", add 
label define opeflag 8 "New participants (became eligible during spring collection)", add 
label values opeflag opeflag
label define sector 0 "Administrative Unit" 
label define sector 1 "Public, 4-year or above", add 
label define sector 2 "Private not-for-profit, 4-year or above", add 
label define sector 3 "Private for-profit, 4-year or above", add 
label define sector 4 "Public, 2-year", add 
label define sector 5 "Private not-for-profit, 2-year", add 
label define sector 6 "Private for-profit, 2-year", add 
label define sector 7 "Public, less-than 2-year", add 
label define sector 8 "Private not-for-profit, less-than 2-year", add 
label define sector 9 "Private for-profit, less-than 2-year", add 
label define sector 99 "Sector unknown (not active)", add 
label values sector sector
label define iclevel -3 "{Not available}" 
label define iclevel 1 "Four or more years", add 
label define iclevel 2 "At least 2 but less than 4 years", add 
label define iclevel 3 "Less than 2 years (below associate)", add 
label values iclevel iclevel
label define control -3 "{Not available}" 
label define control 1 "Public", add 
label define control 2 "Private not-for-profit", add 
label define control 3 "Private for-profit", add 
label values control control
label define hloffer -2 "Not applicable, first-professional only" 
label define hloffer -3 "{Not available}", add 
label define hloffer 1 "Award of less than one academic year", add 
label define hloffer 2 "At least 1, but less than 2 academic yrs", add 
label define hloffer 3 "Associates degree", add 
label define hloffer 4 "At least 2, but less than 4 academic yrs", add 
label define hloffer 5 "Bachelors degree", add 
label define hloffer 6 "Postbaccalaureate certificate", add 
label define hloffer 7 "Masters degree", add 
label define hloffer 8 "Post-masters certificate", add 
label define hloffer 9 "Doctors degree", add 
label values hloffer hloffer
label define ugoffer -3 "{Not available}" 
label define ugoffer 1 "Undergraduate degree or certificate offering", add 
label define ugoffer 2 "No undergraduate offering", add 
label values ugoffer ugoffer
label define groffer -3 "{Not available}" 
label define groffer 1 "Graduate degree or certificate offering", add 
label define groffer 2 "No graduate offering", add 
label values groffer groffer
label define hdegofr1 -3 "{Not available}" 
label define hdegofr1 0 "Non-degree granting", add 
label define hdegofr1 11 "Doctors degree - research/scholarship and professional practice", add 
label define hdegofr1 12 "Doctors degree - research/scholarship", add 
label define hdegofr1 13 "Doctors degree -  professional practice", add 
label define hdegofr1 14 "Doctors degree - other", add 
label define hdegofr1 20 "Masters degree", add 
label define hdegofr1 30 "Bachelors degree", add 
label define hdegofr1 40 "Associates degree", add 
label values hdegofr1 hdegofr1
label define deggrant -3 "{Not available}" 
label define deggrant 1 "Degree-granting", add 
label define deggrant 2 "Nondegree-granting, primarily postsecondary", add 
label values deggrant deggrant
label define hbcu 1 "Yes" 
label define hbcu 2 "No", add 
label values hbcu hbcu
label define hospital -1 "Not reported" 
label define hospital -2 "Not applicable", add 
label define hospital 1 "Yes", add 
label define hospital 2 "No", add 
label values hospital hospital
label define medical -1 "Not reported" 
label define medical -2 "Not applicable", add 
label define medical 1 "Yes", add 
label define medical 2 "No", add 
label values medical medical
label define tribal 1 "Yes" 
label define tribal 2 "No", add 
label values tribal tribal
label define locale -3 "{Not available}" 
label define locale 11 "City Large", add 
label define locale 12 "City Midsize", add 
label define locale 13 "City Small", add 
label define locale 21 "Suburb Large", add 
label define locale 22 "Suburb Midsize", add 
label define locale 23 "Suburb Small", add 
label define locale 31 "Town Fringe", add 
label define locale 32 "Town Distant", add 
label define locale 33 "Town Remote", add 
label define locale 41 "Rural Fringe", add 
label define locale 42 "Rural Distant", add 
label define locale 43 "Rural Remote", add 
label values locale locale
label define openpubl 0 "Institution is not open to the public" 
label define openpubl 1 "Institution is open to the public", add 
label values openpubl openpubl
/*label define act A "Active - institution active and not an add" ...
label define act C "Combined with other institution", add 
label define act D "Delete out of business", add 
label define act I "Inactive due to hurricane related problems", add 
label define act M "Death with data - closed in current yr", add 
label define act N "New - added during the current year", add 
label define act P "Potential new/add institution", add 
label define act Q "Potential restore institution", add 
label define act R "Restore - restored to the current universe", add 
label define act W "Potential add not within scope of IPEDS", add 
label define act X "Potential restore not within scope of IPEDS", add 
label values act act*/
label define deathyr -2 "Not applicable" 
label define deathyr 2005 "2005", add 
label define deathyr 2006 "2006", add 
label define deathyr 2007 "2007", add 
label values deathyr deathyr
label define cyactive 1 "Yes" 
label define cyactive 2 "No, potential add or restore", add 
label define cyactive 3 "No, closed, combined, or out-of-scope", add 
label values cyactive cyactive
label define postsec 1 "Primarily postsecondary institution" 
label define postsec 2 "Not primarily postsecondary", add 
label values postsec postsec
label define pseflag 1 "Active postsecondary institution" 
label define pseflag 2 "Not primarily postsecondary or open to public", add 
label define pseflag 3 "Not active", add 
label values pseflag pseflag
label define pset4flg 1 "Title IV postsecondary institution" 
label define pset4flg 2 "Non-Title IV postsecondary institution", add 
label define pset4flg 3 "Title IV NOT primarily postsecondary institution", add 
label define pset4flg 4 "Non-Title IV NOT primarily postsecondary institution", add 
label define pset4flg 5 "Title IV postsecondary institution that is NOT open to the public", add 
label define pset4flg 6 "Non-Title IV postsecondary institution that is NOT open to the public", add 
label define pset4flg 9 "Institution is not active in current universe", add 
label values pset4flg pset4flg
label define rptmth -1 "Not reported" 
label define rptmth -2 "Not applicable", add 
label define rptmth 1 "Student charges for full academic year and fall GRS cohort", add 
label define rptmth 2 "Student charges by program and full-year GRS cohort", add 
label define rptmth 3 "Student charges for full academic year and full-year GRS cohort", add 
label values rptmth rptmth
label define instcat -1 "Not reported" 
label define instcat -2 "Not applicable", add 
label define instcat 1 "Degree-granting, graduate with no undergraduate degrees", add 
label define instcat 2 "Degree-granting, primarily baccalaureate or above", add 
label define instcat 3 "Degree-granting, not primarily baccalaureate or above", add 
label define instcat 4 "Degree-granting, associates and certificates ", add 
label define instcat 5 "Nondegree-granting, above the baccalaureate", add 
label define instcat 6 "Nondegree-granting, sub-baccalaureate", add 
label values instcat instcat
label define ccbasic -3 "Not applicable, not in Carnegie universe (not accredited or nondegree-granting)" 
label define ccbasic 0 "Not classified", add 
label define ccbasic 1 "Associates--Public Rural-serving Small", add 
label define ccbasic 10 "Associates--Private For-profit", add 
label define ccbasic 11 "Associates--Public 2-year colleges under 4-year universities", add 
label define ccbasic 12 "Associates--Public 4-year Primarily Associates", add 
label define ccbasic 13 "Associates--Private Not-for-profit 4-year Primarily Associates", add 
label define ccbasic 14 "Associates--Private For-profit 4-year Primarily Associates", add 
label define ccbasic 15 "Research Universities (very high research activity)", add 
label define ccbasic 16 "Research Universities (high research activity)", add 
label define ccbasic 17 "Doctoral/Research Universities", add 
label define ccbasic 18 "Masters Colleges and Universities (larger programs)", add 
label define ccbasic 19 "Masters Colleges and Universities (medium programs)", add 
label define ccbasic 2 "Associates--Public Rural-serving Medium", add 
label define ccbasic 20 "Masters Colleges and Universities (smaller programs)", add 
label define ccbasic 21 "Baccalaureate Colleges--Arts & Sciences", add 
label define ccbasic 22 "Baccalaureate Colleges--Diverse Fields", add 
label define ccbasic 23 "Baccalaureate/Associates Colleges", add 
label define ccbasic 24 "Special Focus Institutions--Theological seminaries, Bible colleges, and other faith-related institutions", add 
label define ccbasic 25 "Special Focus Institutions--Medical schools and medical centers", add 
label define ccbasic 26 "Special Focus Institutions--Other health professions schools", add 
label define ccbasic 27 "Special Focus Institutions--Schools of engineering", add 
label define ccbasic 28 "Special Focus Institutions--Other technology-related schools", add 
label define ccbasic 29 "Special Focus Institutions--Schools of business and management", add 
label define ccbasic 3 "Associates--Public Rural-serving Large", add 
label define ccbasic 30 "Special Focus Institutions--Schools of art, music, and design", add 
label define ccbasic 31 "Special Focus Institutions--Schools of law", add 
label define ccbasic 32 "Special Focus Institutions--Other special-focus institutions", add 
label define ccbasic 33 "Tribal Colleges", add 
label define ccbasic 4 "Associates--Public Suburban-serving Single Campus", add 
label define ccbasic 5 "Associates--Public Suburban-serving Multicampus", add 
label define ccbasic 6 "Associates--Public Urban-serving Single Campus", add 
label define ccbasic 7 "Associates--Public Urban-serving Multicampus", add 
label define ccbasic 8 "Associates--Public Special Use", add 
label define ccbasic 9 "Associates--Private Not-for-profit", add 
label values ccbasic ccbasic
label define ccipug -1 "Not applicable, graduate institution" 
label define ccipug -2 "Not applicable, special focus institution", add 
label define ccipug -3 "Not applicable, not in Carnegie universe (not accredited or nondegree-granting)", add 
label define ccipug 0 "Not classified", add 
label define ccipug 1 "Associates", add 
label define ccipug 10 "Balanced arts & sciences/professions, some graduate coexistence", add 
label define ccipug 11 "Balanced arts & sciences/professions, high graduate coexistence", add 
label define ccipug 12 "Professions plus arts & sciences, no graduate coexistence", add 
label define ccipug 13 "Professions plus arts & sciences, some graduate coexistence", add 
label define ccipug 14 "Professions plus arts & sciences, high graduate coexistence", add 
label define ccipug 15 "Professions focus, no graduate coexistence", add 
label define ccipug 16 "Professions focus, some graduate coexistence", add 
label define ccipug 17 "Professions focus, high graduate coexistence", add 
label define ccipug 2 "Associates Dominant", add 
label define ccipug 3 "Arts & sciences focus, no graduate coexistence", add 
label define ccipug 4 "Arts & sciences focus, some graduate coexistence", add 
label define ccipug 5 "Arts & sciences focus, high graduate coexistence", add 
label define ccipug 6 "Arts & sciences plus professions, no graduate coexistence", add 
label define ccipug 7 "Arts & sciences plus professions, some graduate coexistence", add 
label define ccipug 8 "Arts & sciences plus professions, high graduate coexistence", add 
label define ccipug 9 "Balanced arts & sciences/professions, no graduate coexistence", add 
label values ccipug ccipug
label define ccipgrad -1 "Not applicable" 
label define ccipgrad -2 "Not applicable, special focus institution", add 
label define ccipgrad -3 "Not applicable, not in Carnegie universe (not accredited or nondegree-granting)", add 
label define ccipgrad 0 "Not classified", add 
label define ccipgrad 1 "Single postbaccalaureate (education)", add 
label define ccipgrad 10 "Postbaccalaureate professional (business dominant)", add 
label define ccipgrad 11 "Postbaccalaureate professional (other dominant fields)", add 
label define ccipgrad 12 "Single doctoral (education)", add 
label define ccipgrad 13 "Single doctoral (other field)", add 
label define ccipgrad 14 "Comprehensive doctoral with medical/veterinary", add 
label define ccipgrad 15 "Comprehensive doctoral (no medical/veterinary)", add 
label define ccipgrad 16 "Doctoral, humanities/social sciences dominant", add 
label define ccipgrad 17 "STEM dominant", add 
label define ccipgrad 18 "Doctoral, professional dominant", add 
label define ccipgrad 2 "Single postbaccalaureate (business)", add 
label define ccipgrad 3 "Single postbaccalaureate (other field)", add 
label define ccipgrad 4 "Postbaccalaureate comprehensive", add 
label define ccipgrad 5 "Postbaccalaureate, arts & sciences dominant", add 
label define ccipgrad 6 "Postbaccalaureate with arts & sciences (education dominant)", add 
label define ccipgrad 7 "Postbaccalaureate with arts & sciences (business dominant)", add 
label define ccipgrad 8 "Postbaccalaureate with arts & sciences (other dominant fields)", add 
label define ccipgrad 9 "Postbaccalaureate professional (education dominant)", add 
label values ccipgrad ccipgrad
label define ccugprof -1 "Not applicable" 
label define ccugprof -2 "Not applicable, special focus institution", add 
label define ccugprof -3 "Not applicable, not in Carnegie universe (not accredited or nondegree-granting)", add 
label define ccugprof 0 "Not classified", add 
label define ccugprof 1 "Higher part-time two-year", add 
label define ccugprof 10 "Full-time four-year, selective, lower transfer-in", add 
label define ccugprof 11 "Full-time four-year, selective, higher transfer-in", add 
label define ccugprof 12 "Full-time four-year, more selective, lower transfer-in", add 
label define ccugprof 13 "Full-time four-year, more selective, higher transfer-in", add 
label define ccugprof 2 "Mixed part/full-time two-year", add 
label define ccugprof 3 "Medium full-time two-year", add 
label define ccugprof 4 "Higher full-time two-year", add 
label define ccugprof 5 "Higher part-time four-year", add 
label define ccugprof 6 "Medium full-time four-year, inclusive", add 
label define ccugprof 7 "Medium full-time four-year, selective, lower transfer-in", add 
label define ccugprof 8 "Medium full-time four-year, selective, higher transfer-in", add 
label define ccugprof 9 "Full-time four-year, inclusive", add 
label values ccugprof ccugprof
label define ccenrprf -3 "Not applicable, not in Carnegie universe (not accredited or nondegree-granting)" 
label define ccenrprf 0 "Not classified", add 
label define ccenrprf 1 "Exclusively undergraduate two-year", add 
label define ccenrprf 2 "Exclusively undergraduate four-year", add 
label define ccenrprf 3 "Very high undergraduate", add 
label define ccenrprf 4 "High undergraduate", add 
label define ccenrprf 5 "Majority undergraduate", add 
label define ccenrprf 6 "Majority graduate/professional", add 
label define ccenrprf 7 "Exclusively graduate/professional", add 
label values ccenrprf ccenrprf
label define ccsizset -2 "Not applicable, special focus institution" 
label define ccsizset -3 "Not applicable, not in Carnegie universe (not accredited or nondegree-granting)", add 
label define ccsizset 0 "Not classified", add 
label define ccsizset 1 "Very small two-year", add 
label define ccsizset 10 "Small four-year, primarily residential", add 
label define ccsizset 11 "Small four-year, highly residential", add 
label define ccsizset 12 "Medium four-year, primarily nonresidential", add 
label define ccsizset 13 "Medium four-year, primarily residential", add 
label define ccsizset 14 "Medium four-year, highly residential", add 
label define ccsizset 15 "Large four-year, primarily nonresidential", add 
label define ccsizset 16 "Large four-year, primarily residential", add 
label define ccsizset 17 "Large four-year, highly residential", add 
label define ccsizset 18 "Exclusively graduate/professional", add 
label define ccsizset 2 "Small two-year", add 
label define ccsizset 3 "Medium two-year", add 
label define ccsizset 4 "Large two-year", add 
label define ccsizset 5 "Very large two-year", add 
label define ccsizset 6 "Very small four-year, primarily nonresidential", add 
label define ccsizset 7 "Very small four-year, primarily residential", add 
label define ccsizset 8 "Very small four-year, highly residential", add 
label define ccsizset 9 "Small four-year, primarily nonresidential", add 
label values ccsizset ccsizset
label define carnegie -3 "{Item not available}" 
label define carnegie 15 "Doctoral/Research Universities--Extensive", add 
label define carnegie 16 "Doctoral/Research Universities--Intensive", add 
label define carnegie 21 "Masters Colleges and Universities I", add 
label define carnegie 22 "Masters Colleges and Universities II", add 
label define carnegie 31 "Baccalaureate Colleges--Liberal Arts", add 
label define carnegie 32 "Baccalaureate Colleges--General", add 
label define carnegie 33 "Baccalaureate/Associates Colleges", add 
label define carnegie 40 "Associates Colleges", add 
label define carnegie 51 "Theological seminaries and other specialized faith-related institutions", add 
label define carnegie 52 "Medical schools and medical centers", add 
label define carnegie 53 "Other separate health profession schools", add 
label define carnegie 54 "Schools of engineering and technology", add 
label define carnegie 55 "Schools of business and management", add 
label define carnegie 56 "Schools of art, music, and design", add 
label define carnegie 57 "Schools of law", add 
label define carnegie 58 "Teachers colleges", add 
label define carnegie 59 "Other specialized institutions", add 
label define carnegie 60 "Tribal colleges", add 
label values carnegie carnegie
label define tenursys -1 "Not reported" 
label define tenursys -2 "Not applicable", add 
label define tenursys 1 "Has tenure system", add 
label define tenursys 2 "No tenure system", add 
label values tenursys tenursys
label define landgrnt 1 "Land Grant Institution" 
label define landgrnt 2 "Not a Land Grant Institution", add 
label values landgrnt landgrnt
label define instsize -1 "Not reported" 
label define instsize -2 "Not applicable", add 
label define instsize 1 "Under 1,000", add 
label define instsize 2 "1,000 - 4,999", add 
label define instsize 3 "5,000 - 9,999", add 
label define instsize 4 "10,000 - 19,999", add 
label define instsize 5 "20,000 and above", add 
label values instsize instsize
label define cbsa -2 "Not applicable" 
label define cbsa 10020 "Abbeville, LA", add 
label define cbsa 10100 "Aberdeen, SD", add 
label define cbsa 10140 "Aberdeen, WA", add 
label define cbsa 10180 "Abilene, TX", add 
label define cbsa 10220 "Ada, OK", add 
label define cbsa 10300 "Adrian, MI", add 
label define cbsa 10380 "Aguadilla-Isabela-San Sebastián, PR", add 
label define cbsa 10420 "Akron, OH", add 
label define cbsa 10460 "Alamogordo, NM", add 
label define cbsa 10500 "Albany, GA", add 
label define cbsa 10540 "Albany-Lebanon, OR", add 
label define cbsa 10580 "Albany-Schenectady-Troy, NY", add 
label define cbsa 10620 "Albemarle, NC", add 
label define cbsa 10700 "Albertville, AL", add 
label define cbsa 10740 "Albuquerque, NM", add 
label define cbsa 10760 "Alexander City, AL", add 
label define cbsa 10780 "Alexandria, LA", add 
label define cbsa 10820 "Alexandria, MN", add 
label define cbsa 10900 "Allentown-Bethlehem-Easton, PA-NJ", add 
label define cbsa 10940 "Alma, MI", add 
label define cbsa 10980 "Alpena, MI", add 
label define cbsa 11020 "Altoona, PA", add 
label define cbsa 11060 "Altus, OK", add 
label define cbsa 11100 "Amarillo, TX", add 
label define cbsa 11140 "Americus, GA", add 
label define cbsa 11180 "Ames, IA", add 
label define cbsa 11220 "Amsterdam, NY", add 
label define cbsa 11260 "Anchorage, AK", add 
label define cbsa 11300 "Anderson, IN", add 
label define cbsa 11340 "Anderson, SC", add 
label define cbsa 11420 "Angola, IN", add 
label define cbsa 11460 "Ann Arbor, MI", add 
label define cbsa 11500 "Anniston-Oxford, AL", add 
label define cbsa 11540 "Appleton, WI", add 
label define cbsa 11620 "Ardmore, OK", add 
label define cbsa 11660 "Arkadelphia, AR", add 
label define cbsa 11700 "Asheville, NC", add 
label define cbsa 11740 "Ashland, OH", add 
label define cbsa 11780 "Ashtabula, OH", add 
label define cbsa 11820 "Astoria, OR", add 
label define cbsa 11860 "Atchison, KS", add 
label define cbsa 11900 "Athens, OH", add 
label define cbsa 11940 "Athens, TN", add 
label define cbsa 11980 "Athens, TX", add 
label define cbsa 12020 "Athens-Clarke County, GA", add 
label define cbsa 12060 "Atlanta-Sandy Springs-Marietta, GA", add 
label define cbsa 12100 "Atlantic City-Hammonton, NJ", add 
label define cbsa 12180 "Auburn, NY", add 
label define cbsa 12220 "Auburn-Opelika, AL", add 
label define cbsa 12260 "Augusta-Richmond County, GA-SC", add 
label define cbsa 12300 "Augusta-Waterville, ME", add 
label define cbsa 12380 "Austin, MN", add 
label define cbsa 12420 "Austin-Round Rock, TX", add 
label define cbsa 12460 "Bainbridge, GA", add 
label define cbsa 12540 "Bakersfield, CA", add 
label define cbsa 12580 "Baltimore-Towson, MD", add 
label define cbsa 12620 "Bangor, ME", add 
label define cbsa 12700 "Barnstable Town, MA", add 
label define cbsa 12740 "Barre, VT", add 
label define cbsa 12780 "Bartlesville, OK", add 
label define cbsa 12820 "Bastrop, LA", add 
label define cbsa 12860 "Batavia, NY", add 
label define cbsa 12900 "Batesville, AR", add 
label define cbsa 12940 "Baton Rouge, LA", add 
label define cbsa 12980 "Battle Creek, MI", add 
label define cbsa 13020 "Bay City, MI", add 
label define cbsa 13140 "Beaumont-Port Arthur, TX", add 
label define cbsa 13220 "Beckley, WV", add 
label define cbsa 13300 "Beeville, TX", add 
label define cbsa 13340 "Bellefontaine, OH", add 
label define cbsa 13380 "Bellingham, WA", add 
label define cbsa 13420 "Bemidji, MN", add 
label define cbsa 13460 "Bend, OR", add 
label define cbsa 13540 "Bennington, VT", add 
label define cbsa 13620 "Berlin, NH-VT", add 
label define cbsa 13660 "Big Rapids, MI", add 
label define cbsa 13700 "Big Spring, TX", add 
label define cbsa 13740 "Billings, MT", add 
label define cbsa 13780 "Binghamton, NY", add 
label define cbsa 13820 "Birmingham-Hoover, AL", add 
label define cbsa 13900 "Bismarck, ND", add 
label define cbsa 13980 "Blacksburg-Christiansburg-Radford, VA", add 
label define cbsa 14020 "Bloomington, IN", add 
label define cbsa 14060 "Bloomington-Normal, IL", add 
label define cbsa 14100 "Bloomsburg-Berwick, PA", add 
label define cbsa 14140 "Bluefield, WV-VA", add 
label define cbsa 14180 "Blytheville, AR", add 
label define cbsa 14220 "Bogalusa, LA", add 
label define cbsa 14260 "Boise City-Nampa, ID", add 
label define cbsa 14380 "Boone, NC", add 
label define cbsa 14420 "Borger, TX", add 
label define cbsa 14460 "Boston-Cambridge-Quincy, MA-NH", add 
label define cbsa 14500 "Boulder, CO", add 
label define cbsa 14540 "Bowling Green, KY", add 
label define cbsa 14580 "Bozeman, MT", add 
label define cbsa 14600 "Bradenton-Sarasota-Venice, FL", add 
label define cbsa 14620 "Bradford, PA", add 
label define cbsa 14660 "Brainerd, MN", add 
label define cbsa 14700 "Branson, MO", add 
label define cbsa 14740 "Bremerton-Silverdale, WA", add 
label define cbsa 14780 "Brenham, TX", add 
label define cbsa 14820 "Brevard, NC", add 
label define cbsa 14860 "Bridgeport-Stamford-Norwalk, CT", add 
label define cbsa 15100 "Brookings, SD", add 
label define cbsa 15180 "Brownsville-Harlingen, TX", add 
label define cbsa 15220 "Brownwood, TX", add 
label define cbsa 15260 "Brunswick, GA", add 
label define cbsa 15380 "Buffalo-Niagara Falls, NY", add 
label define cbsa 15420 "Burley, ID", add 
label define cbsa 15460 "Burlington, IA-IL", add 
label define cbsa 15500 "Burlington, NC", add 
label define cbsa 15540 "Burlington-South Burlington, VT", add 
label define cbsa 15580 "Butte-Silver Bow, MT", add 
label define cbsa 15620 "Cadillac, MI", add 
label define cbsa 15740 "Cambridge, OH", add 
label define cbsa 15780 "Camden, AR", add 
label define cbsa 15820 "Campbellsville, KY", add 
label define cbsa 15900 "Canton, IL", add 
label define cbsa 15940 "Canton-Massillon, OH", add 
label define cbsa 15980 "Cape Coral-Fort Myers, FL", add 
label define cbsa 16020 "Cape Girardeau-Jackson, MO-IL", add 
label define cbsa 16060 "Carbondale, IL", add 
label define cbsa 16100 "Carlsbad-Artesia, NM", add 
label define cbsa 16180 "Carson City, NV", add 
label define cbsa 16220 "Casper, WY", add 
label define cbsa 16260 "Cedar City, UT", add 
label define cbsa 16300 "Cedar Rapids, IA", add 
label define cbsa 16380 "Celina, OH", add 
label define cbsa 16500 "Centralia, WA", add 
label define cbsa 16540 "Chambersburg, PA", add 
label define cbsa 16580 "Champaign-Urbana, IL", add 
label define cbsa 16620 "Charleston, WV", add 
label define cbsa 16660 "Charleston-Mattoon, IL", add 
label define cbsa 16700 "Charleston-North Charleston-Summerville, SC", add 
label define cbsa 16740 "Charlotte-Gastonia-Concord, NC-SC", add 
label define cbsa 16820 "Charlottesville, VA", add 
label define cbsa 16860 "Chattanooga, TN-GA", add 
label define cbsa 16940 "Cheyenne, WY", add 
label define cbsa 16980 "Chicago-Naperville-Joliet, IL-IN-WI", add 
label define cbsa 17020 "Chico, CA", add 
label define cbsa 17060 "Chillicothe, OH", add 
label define cbsa 17140 "Cincinnati-Middletown, OH-KY-IN", add 
label define cbsa 17200 "Claremont, NH", add 
label define cbsa 17220 "Clarksburg, WV", add 
label define cbsa 17260 "Clarksdale, MS", add 
label define cbsa 17300 "Clarksville, TN-KY", add 
label define cbsa 17380 "Cleveland, MS", add 
label define cbsa 17420 "Cleveland, TN", add 
label define cbsa 17460 "Cleveland-Elyria-Mentor, OH", add 
label define cbsa 17540 "Clinton, IA", add 
label define cbsa 17580 "Clovis, NM", add 
label define cbsa 17620 "Coamo, PR", add 
label define cbsa 17660 "Coeur dAlene, ID", add 
label define cbsa 17700 "Coffeyville, KS", add 
label define cbsa 17740 "Coldwater, MI", add 
label define cbsa 17780 "College Station-Bryan, TX", add 
label define cbsa 17820 "Colorado Springs, CO", add 
label define cbsa 17860 "Columbia, MO", add 
label define cbsa 17900 "Columbia, SC", add 
label define cbsa 17940 "Columbia, TN", add 
label define cbsa 17980 "Columbus, GA-AL", add 
label define cbsa 18020 "Columbus, IN", add 
label define cbsa 18060 "Columbus, MS", add 
label define cbsa 18140 "Columbus, OH", add 
label define cbsa 18180 "Concord, NH", add 
label define cbsa 18260 "Cookeville, TN", add 
label define cbsa 18300 "Coos Bay, OR", add 
label define cbsa 18340 "Corbin, KY", add 
label define cbsa 18420 "Corinth, MS", add 
label define cbsa 18460 "Cornelia, GA", add 
label define cbsa 18500 "Corning, NY", add 
label define cbsa 18580 "Corpus Christi, TX", add 
label define cbsa 18620 "Corsicana, TX", add 
label define cbsa 18660 "Cortland, NY", add 
label define cbsa 18700 "Corvallis, OR", add 
label define cbsa 18820 "Crawfordsville, IN", add 
label define cbsa 18900 "Crossville, TN", add 
label define cbsa 18940 "Crowley, LA", add 
label define cbsa 18980 "Cullman, AL", add 
label define cbsa 19020 "Culpeper, VA", add 
label define cbsa 19060 "Cumberland, MD-WV", add 
label define cbsa 19100 "Dallas-Fort Worth-Arlington, TX", add 
label define cbsa 19140 "Dalton, GA", add 
label define cbsa 19180 "Danville, IL", add 
label define cbsa 19220 "Danville, KY", add 
label define cbsa 19260 "Danville, VA", add 
label define cbsa 19300 "Daphne-Fairhope-Foley, AL", add 
label define cbsa 19340 "Davenport-Moline-Rock Island, IA-IL", add 
label define cbsa 19380 "Dayton, OH", add 
label define cbsa 19500 "Decatur, IL", add 
label define cbsa 19580 "Defiance, OH", add 
label define cbsa 19620 "Del Rio, TX", add 
label define cbsa 19660 "Deltona-Daytona Beach-Ormond Beach, FL", add 
label define cbsa 19740 "Denver-Aurora-Broomfield, CO", add 
label define cbsa 19780 "Des Moines-West Des Moines, IA", add 
label define cbsa 19820 "Detroit-Warren-Livonia, MI", add 
label define cbsa 19860 "Dickinson, ND", add 
label define cbsa 19940 "Dixon, IL", add 
label define cbsa 19980 "Dodge City, KS", add 
label define cbsa 20020 "Dothan, AL", add 
label define cbsa 20060 "Douglas, GA", add 
label define cbsa 20100 "Dover, DE", add 
label define cbsa 20140 "Dublin, GA", add 
label define cbsa 20180 "DuBois, PA", add 
label define cbsa 20220 "Dubuque, IA", add 
label define cbsa 20260 "Duluth, MN-WI", add 
label define cbsa 20340 "Duncan, OK", add 
label define cbsa 20380 "Dunn, NC", add 
label define cbsa 20420 "Durango, CO", add 
label define cbsa 20460 "Durant, OK", add 
label define cbsa 20500 "Durham-Chapel Hill, NC", add 
label define cbsa 20540 "Dyersburg, TN", add 
label define cbsa 20580 "Eagle Pass, TX", add 
label define cbsa 20620 "East Liverpool-Salem, OH", add 
label define cbsa 20660 "Easton, MD", add 
label define cbsa 20700 "East Stroudsburg, PA", add 
label define cbsa 20740 "Eau Claire, WI", add 
label define cbsa 20900 "El Campo, TX", add 
label define cbsa 20940 "El Centro, CA", add 
label define cbsa 20980 "El Dorado, AR", add 
label define cbsa 21020 "Elizabeth City, NC", add 
label define cbsa 21060 "Elizabethtown, KY", add 
label define cbsa 21140 "Elkhart-Goshen, IN", add 
label define cbsa 21220 "Elko, NV", add 
label define cbsa 21260 "Ellensburg, WA", add 
label define cbsa 21300 "Elmira, NY", add 
label define cbsa 21340 "El Paso, TX", add 
label define cbsa 21380 "Emporia, KS", add 
label define cbsa 21420 "Enid, OK", add 
label define cbsa 21460 "Enterprise-Ozark, AL", add 
label define cbsa 21500 "Erie, PA", add 
label define cbsa 21540 "Escanaba, MI", add 
label define cbsa 21580 "Espanola, NM", add 
label define cbsa 21660 "Eugene-Springfield, OR", add 
label define cbsa 21700 "Eureka-Arcata-Fortuna, CA", add 
label define cbsa 21780 "Evansville, IN-KY", add 
label define cbsa 21820 "Fairbanks, AK", add 
label define cbsa 21900 "Fairmont, WV", add 
label define cbsa 21940 "Fajardo, PR", add 
label define cbsa 22020 "Fargo, ND-MN", add 
label define cbsa 22060 "Faribault-Northfield, MN", add 
label define cbsa 22100 "Farmington, MO", add 
label define cbsa 22140 "Farmington, NM", add 
label define cbsa 22180 "Fayetteville, NC", add 
label define cbsa 22220 "Fayetteville-Springdale-Rogers, AR-MO", add 
label define cbsa 22260 "Fergus Falls, MN", add 
label define cbsa 22300 "Findlay, OH", add 
label define cbsa 22340 "Fitzgerald, GA", add 
label define cbsa 22380 "Flagstaff, AZ", add 
label define cbsa 22420 "Flint, MI", add 
label define cbsa 22500 "Florence, SC", add 
label define cbsa 22520 "Florence-Muscle Shoals, AL", add 
label define cbsa 22540 "Fond du Lac, WI", add 
label define cbsa 22580 "Forest City, NC", add 
label define cbsa 22620 "Forrest City, AR", add 
label define cbsa 22660 "Fort Collins-Loveland, CO", add 
label define cbsa 22700 "Fort Dodge, IA", add 
label define cbsa 22780 "Fort Leonard Wood, MO", add 
label define cbsa 22800 "Fort Madison-Keokuk, IA-MO", add 
label define cbsa 22820 "Fort Morgan, CO", add 
label define cbsa 22840 "Fort Payne, AL", add 
label define cbsa 22860 "Fort Polk South, LA", add 
label define cbsa 22900 "Fort Smith, AR-OK", add 
label define cbsa 22980 "Fort Valley, GA", add 
label define cbsa 23020 "Fort Walton Beach-Crestview-Destin, FL", add 
label define cbsa 23060 "Fort Wayne, IN", add 
label define cbsa 23180 "Frankfort, KY", add 
label define cbsa 23300 "Freeport, IL", add 
label define cbsa 23340 "Fremont, NE", add 
label define cbsa 23380 "Fremont, OH", add 
label define cbsa 23420 "Fresno, CA", add 
label define cbsa 23460 "Gadsden, AL", add 
label define cbsa 23500 "Gaffney, SC", add 
label define cbsa 23540 "Gainesville, FL", add 
label define cbsa 23580 "Gainesville, GA", add 
label define cbsa 23620 "Gainesville, TX", add 
label define cbsa 23660 "Galesburg, IL", add 
label define cbsa 23700 "Gallup, NM", add 
label define cbsa 23780 "Garden City, KS", add 
label define cbsa 23900 "Gettysburg, PA", add 
label define cbsa 23980 "Glasgow, KY", add 
label define cbsa 24020 "Glens Falls, NY", add 
label define cbsa 24140 "Goldsboro, NC", add 
label define cbsa 24220 "Grand Forks, ND-MN", add 
label define cbsa 24260 "Grand Island, NE", add 
label define cbsa 24300 "Grand Junction, CO", add 
label define cbsa 24340 "Grand Rapids-Wyoming, MI", add 
label define cbsa 24380 "Grants, NM", add 
label define cbsa 24420 "Grants Pass, OR", add 
label define cbsa 24460 "Great Bend, KS", add 
label define cbsa 24500 "Great Falls, MT", add 
label define cbsa 24540 "Greeley, CO", add 
label define cbsa 24580 "Green Bay, WI", add 
label define cbsa 24620 "Greeneville, TN", add 
label define cbsa 24660 "Greensboro-High Point, NC", add 
label define cbsa 24740 "Greenville, MS", add 
label define cbsa 24780 "Greenville, NC", add 
label define cbsa 24860 "Greenville-Mauldin-Easley, SC", add 
label define cbsa 24900 "Greenwood, MS", add 
label define cbsa 24940 "Greenwood, SC", add 
label define cbsa 24980 "Grenada, MS", add 
label define cbsa 25020 "Guayama, PR", add 
label define cbsa 25060 "Gulfport-Biloxi, MS", add 
label define cbsa 25100 "Guymon, OK", add 
label define cbsa 25180 "Hagerstown-Martinsburg, MD-WV", add 
label define cbsa 25220 "Hammond, LA", add 
label define cbsa 25260 "Hanford-Corcoran, CA", add 
label define cbsa 25300 "Hannibal, MO", add 
label define cbsa 25340 "Harriman, TN", add 
label define cbsa 25380 "Harrisburg, IL", add 
label define cbsa 25420 "Harrisburg-Carlisle, PA", add 
label define cbsa 25460 "Harrison, AR", add 
label define cbsa 25500 "Harrisonburg, VA", add 
label define cbsa 25540 "Hartford-West Hartford-East Hartford, CT", add 
label define cbsa 25580 "Hastings, NE", add 
label define cbsa 25620 "Hattiesburg, MS", add 
label define cbsa 25660 "Havre, MT", add 
label define cbsa 25700 "Hays, KS", add 
label define cbsa 25740 "Helena, MT", add 
label define cbsa 25760 "Helena-West Helena, AR", add 
label define cbsa 25780 "Henderson, NC", add 
label define cbsa 25860 "Hickory-Lenoir-Morganton, NC", add 
label define cbsa 25900 "Hilo, HI", add 
label define cbsa 25940 "Hilton Head Island-Beaufort, SC", add 
label define cbsa 26020 "Hobbs, NM", add 
label define cbsa 26100 "Holland-Grand Haven, MI", add 
label define cbsa 26140 "Homosassa Springs, FL", add 
label define cbsa 26180 "Honolulu, HI", add 
label define cbsa 26260 "Hope, AR", add 
label define cbsa 26300 "Hot Springs, AR", add 
label define cbsa 26340 "Houghton, MI", add 
label define cbsa 26380 "Houma-Bayou Cane-Thibodaux, LA", add 
label define cbsa 26420 "Houston-Sugar Land-Baytown, TX", add 
label define cbsa 26460 "Hudson, NY", add 
label define cbsa 26480 "Humboldt, TN", add 
label define cbsa 26500 "Huntingdon, PA", add 
label define cbsa 26540 "Huntington, IN", add 
label define cbsa 26580 "Huntington-Ashland, WV-KY-OH", add 
label define cbsa 26620 "Huntsville, AL", add 
label define cbsa 26660 "Huntsville, TX", add 
label define cbsa 26740 "Hutchinson, KS", add 
label define cbsa 26780 "Hutchinson, MN", add 
label define cbsa 26820 "Idaho Falls, ID", add 
label define cbsa 26860 "Indiana, PA", add 
label define cbsa 26900 "Indianapolis-Carmel, IN", add 
label define cbsa 26940 "Indianola, MS", add 
label define cbsa 26980 "Iowa City, IA", add 
label define cbsa 27060 "Ithaca, NY", add 
label define cbsa 27100 "Jackson, MI", add 
label define cbsa 27140 "Jackson, MS", add 
label define cbsa 27180 "Jackson, TN", add 
label define cbsa 27260 "Jacksonville, FL", add 
label define cbsa 27300 "Jacksonville, IL", add 
label define cbsa 27340 "Jacksonville, NC", add 
label define cbsa 27380 "Jacksonville, TX", add 
label define cbsa 27420 "Jamestown, ND", add 
label define cbsa 27460 "Jamestown-Dunkirk-Fredonia, NY", add 
label define cbsa 27500 "Janesville, WI", add 
label define cbsa 27620 "Jefferson City, MO", add 
label define cbsa 27660 "Jennings, LA", add 
label define cbsa 27700 "Jesup, GA", add 
label define cbsa 27740 "Johnson City, TN", add 
label define cbsa 27780 "Johnstown, PA", add 
label define cbsa 27860 "Jonesboro, AR", add 
label define cbsa 27900 "Joplin, MO", add 
label define cbsa 27940 "Juneau, AK", add 
label define cbsa 27980 "Kahului-Wailuku, HI", add 
label define cbsa 28020 "Kalamazoo-Portage, MI", add 
label define cbsa 28060 "Kalispell, MT", add 
label define cbsa 28100 "Kankakee-Bradley, IL", add 
label define cbsa 28140 "Kansas City, MO-KS", add 
label define cbsa 28180 "Kapaa, HI", add 
label define cbsa 28260 "Kearney, NE", add 
label define cbsa 28300 "Keene, NH", add 
label define cbsa 28380 "Kennett, MO", add 
label define cbsa 28420 "Kennewick-Pasco-Richland, WA", add 
label define cbsa 28500 "Kerrville, TX", add 
label define cbsa 28580 "Key West, FL", add 
label define cbsa 28660 "Killeen-Temple-Fort Hood, TX", add 
label define cbsa 28700 "Kingsport-Bristol-Bristol, TN-VA", add 
label define cbsa 28740 "Kingston, NY", add 
label define cbsa 28780 "Kingsville, TX", add 
label define cbsa 28820 "Kinston, NC", add 
label define cbsa 28860 "Kirksville, MO", add 
label define cbsa 28900 "Klamath Falls, OR", add 
label define cbsa 28940 "Knoxville, TN", add 
label define cbsa 29020 "Kokomo, IN", add 
label define cbsa 29060 "Laconia, NH", add 
label define cbsa 29100 "La Crosse, WI-MN", add 
label define cbsa 29140 "Lafayette, IN", add 
label define cbsa 29180 "Lafayette, LA", add 
label define cbsa 29220 "La Follette, TN", add 
label define cbsa 29260 "La Grande, OR", add 
label define cbsa 29300 "LaGrange, GA", add 
label define cbsa 29340 "Lake Charles, LA", add 
label define cbsa 29380 "Lake City, FL", add 
label define cbsa 29420 "Lake Havasu City-Kingman, AZ", add 
label define cbsa 29460 "Lakeland-Winter Haven, FL", add 
label define cbsa 29540 "Lancaster, PA", add 
label define cbsa 29580 "Lancaster, SC", add 
label define cbsa 29620 "Lansing-East Lansing, MI", add 
label define cbsa 29660 "Laramie, WY", add 
label define cbsa 29700 "Laredo, TX", add 
label define cbsa 29740 "Las Cruces, NM", add 
label define cbsa 29780 "Las Vegas, NM", add 
label define cbsa 29820 "Las Vegas-Paradise, NV", add 
label define cbsa 29860 "Laurel, MS", add 
label define cbsa 29900 "Laurinburg, NC", add 
label define cbsa 29940 "Lawrence, KS", add 
label define cbsa 29980 "Lawrenceburg, TN", add 
label define cbsa 30020 "Lawton, OK", add 
label define cbsa 30060 "Lebanon, MO", add 
label define cbsa 30100 "Lebanon, NH-VT", add 
label define cbsa 30140 "Lebanon, PA", add 
label define cbsa 30220 "Levelland, TX", add 
label define cbsa 30260 "Lewisburg, PA", add 
label define cbsa 30300 "Lewiston, ID-WA", add 
label define cbsa 30340 "Lewiston-Auburn, ME", add 
label define cbsa 30380 "Lewistown, PA", add 
label define cbsa 30460 "Lexington-Fayette, KY", add 
label define cbsa 30500 "Lexington Park, MD", add 
label define cbsa 30580 "Liberal, KS", add 
label define cbsa 30620 "Lima, OH", add 
label define cbsa 30660 "Lincoln, IL", add 
label define cbsa 30700 "Lincoln, NE", add 
label define cbsa 30780 "Little Rock-North Little Rock-Conway, AR", add 
label define cbsa 30820 "Lock Haven, PA", add 
label define cbsa 30860 "Logan, UT-ID", add 
label define cbsa 30940 "London, KY", add 
label define cbsa 30980 "Longview, TX", add 
label define cbsa 31020 "Longview, WA", add 
label define cbsa 31060 "Los Alamos, NM", add 
label define cbsa 31100 "Los Angeles-Long Beach-Santa Ana, CA", add 
label define cbsa 31140 "Louisville-Jefferson County, KY-IN", add 
label define cbsa 31180 "Lubbock, TX", add 
label define cbsa 31260 "Lufkin, TX", add 
label define cbsa 31300 "Lumberton, NC", add 
label define cbsa 31340 "Lynchburg, VA", add 
label define cbsa 31380 "Macomb, IL", add 
label define cbsa 31420 "Macon, GA", add 
label define cbsa 31460 "Madera-Chowchilla, CA", add 
label define cbsa 31500 "Madison, IN", add 
label define cbsa 31540 "Madison, WI", add 
label define cbsa 31580 "Madisonville, KY", add 
label define cbsa 31620 "Magnolia, AR", add 
label define cbsa 31660 "Malone, NY", add 
label define cbsa 31700 "Manchester-Nashua, NH", add 
label define cbsa 31740 "Manhattan, KS", add 
label define cbsa 31820 "Manitowoc, WI", add 
label define cbsa 31860 "Mankato-North Mankato, MN", add 
label define cbsa 31900 "Mansfield, OH", add 
label define cbsa 31940 "Marinette, WI-MI", add 
label define cbsa 31980 "Marion, IN", add 
label define cbsa 32020 "Marion, OH", add 
label define cbsa 32060 "Marion-Herrin, IL", add 
label define cbsa 32100 "Marquette, MI", add 
label define cbsa 32140 "Marshall, MN", add 
label define cbsa 32180 "Marshall, MO", add 
label define cbsa 32220 "Marshall, TX", add 
label define cbsa 32260 "Marshalltown, IA", add 
label define cbsa 32270 "Marshfield-Wisconsin Rapids, WI", add 
label define cbsa 32280 "Martin, TN", add 
label define cbsa 32300 "Martinsville, VA", add 
label define cbsa 32340 "Maryville, MO", add 
label define cbsa 32380 "Mason City, IA", add 
label define cbsa 32420 "Mayagüez, PR", add 
label define cbsa 32460 "Mayfield, KY", add 
label define cbsa 32500 "Maysville, KY", add 
label define cbsa 32540 "McAlester, OK", add 
label define cbsa 32580 "McAllen-Edinburg-Mission, TX", add 
label define cbsa 32620 "McComb, MS", add 
label define cbsa 32660 "McMinnville, TN", add 
label define cbsa 32700 "McPherson, KS", add 
label define cbsa 32740 "Meadville, PA", add 
label define cbsa 32780 "Medford, OR", add 
label define cbsa 32820 "Memphis, TN-MS-AR", add 
label define cbsa 32860 "Menomonie, WI", add 
label define cbsa 32900 "Merced, CA", add 
label define cbsa 32940 "Meridian, MS", add 
label define cbsa 33060 "Miami, OK", add 
label define cbsa 33100 "Miami-Fort Lauderdale-Pompano Beach, FL", add 
label define cbsa 33140 "Michigan City-La Porte, IN", add 
label define cbsa 33180 "Middlesborough, KY", add 
label define cbsa 33220 "Midland, MI", add 
label define cbsa 33260 "Midland, TX", add 
label define cbsa 33300 "Milledgeville, GA", add 
label define cbsa 33340 "Milwaukee-Waukesha-West Allis, WI", add 
label define cbsa 33380 "Minden, LA", add 
label define cbsa 33460 "Minneapolis-St. Paul-Bloomington, MN-WI", add 
label define cbsa 33500 "Minot, ND", add 
label define cbsa 33540 "Missoula, MT", add 
label define cbsa 33580 "Mitchell, SD", add 
label define cbsa 33620 "Moberly, MO", add 
label define cbsa 33660 "Mobile, AL", add 
label define cbsa 33700 "Modesto, CA", add 
label define cbsa 33740 "Monroe, LA", add 
label define cbsa 33780 "Monroe, MI", add 
label define cbsa 33820 "Monroe, WI", add 
label define cbsa 33860 "Montgomery, AL", add 
label define cbsa 33980 "Morehead City, NC", add 
label define cbsa 34020 "Morgan City, LA", add 
label define cbsa 34060 "Morgantown, WV", add 
label define cbsa 34100 "Morristown, TN", add 
label define cbsa 34140 "Moscow, ID", add 
label define cbsa 34180 "Moses Lake, WA", add 
label define cbsa 34220 "Moultrie, GA", add 
label define cbsa 34260 "Mountain Home, AR", add 
label define cbsa 34340 "Mount Airy, NC", add 
label define cbsa 34380 "Mount Pleasant, MI", add 
label define cbsa 34420 "Mount Pleasant, TX", add 
label define cbsa 34460 "Mount Sterling, KY", add 
label define cbsa 34500 "Mount Vernon, IL", add 
label define cbsa 34540 "Mount Vernon, OH", add 
label define cbsa 34580 "Mount Vernon-Anacortes, WA", add 
label define cbsa 34620 "Muncie, IN", add 
label define cbsa 34660 "Murray, KY", add 
label define cbsa 34740 "Muskegon-Norton Shores, MI", add 
label define cbsa 34780 "Muskogee, OK", add 
label define cbsa 34820 "Myrtle Beach-North Myrtle Beach-Conway, SC", add 
label define cbsa 34860 "Nacogdoches, TX", add 
label define cbsa 34900 "Napa, CA", add 
label define cbsa 34940 "Naples-Marco Island, FL", add 
label define cbsa 34980 "Nashville-Davidson--Murfreesboro--Franklin, TN", add 
label define cbsa 35020 "Natchez, MS-LA", add 
label define cbsa 35060 "Natchitoches, LA", add 
label define cbsa 35100 "New Bern, NC", add 
label define cbsa 35140 "Newberry, SC", add 
label define cbsa 35260 "New Castle, PA", add 
label define cbsa 35300 "New Haven-Milford, CT", add 
label define cbsa 35340 "New Iberia, LA", add 
label define cbsa 35380 "New Orleans-Metairie-Kenner, LA", add 
label define cbsa 35420 "New Philadelphia-Dover, OH", add 
label define cbsa 35580 "New Ulm, MN", add 
label define cbsa 35620 "New York-Northern New Jersey-Long Island, NY-NJ-PA", add 
label define cbsa 35660 "Niles-Benton Harbor, MI", add 
label define cbsa 35740 "Norfolk, NE", add 
label define cbsa 35820 "North Platte, NE", add 
label define cbsa 35900 "North Wilkesboro, NC", add 
label define cbsa 35980 "Norwich-New London, CT", add 
label define cbsa 36060 "Oak Hill, WV", add 
label define cbsa 36100 "Ocala, FL", add 
label define cbsa 36220 "Odessa, TX", add 
label define cbsa 36260 "Ogden-Clearfield, UT", add 
label define cbsa 36300 "Ogdensburg-Massena, NY", add 
label define cbsa 36340 "Oil City, PA", add 
label define cbsa 36420 "Oklahoma City, OK", add 
label define cbsa 36460 "Olean, NY", add 
label define cbsa 36500 "Olympia, WA", add 
label define cbsa 36540 "Omaha-Council Bluffs, NE-IA", add 
label define cbsa 36580 "Oneonta, NY", add 
label define cbsa 36620 "Ontario, OR-ID", add 
label define cbsa 36660 "Opelousas-Eunice, LA", add 
label define cbsa 36700 "Orangeburg, SC", add 
label define cbsa 36740 "Orlando-Kissimmee, FL", add 
label define cbsa 36780 "Oshkosh-Neenah, WI", add 
label define cbsa 36820 "Oskaloosa, IA", add 
label define cbsa 36860 "Ottawa-Streator, IL", add 
label define cbsa 36900 "Ottumwa, IA", add 
label define cbsa 36980 "Owensboro, KY", add 
label define cbsa 37020 "Owosso, MI", add 
label define cbsa 37060 "Oxford, MS", add 
label define cbsa 37100 "Oxnard-Thousand Oaks-Ventura, CA", add 
label define cbsa 37140 "Paducah, KY-IL", add 
label define cbsa 37260 "Palatka, FL", add 
label define cbsa 37340 "Palm Bay-Melbourne-Titusville, FL", add 
label define cbsa 37460 "Panama City-Lynn Haven-Panama City Beach, FL", add 
label define cbsa 37500 "Paragould, AR", add 
label define cbsa 37540 "Paris, TN", add 
label define cbsa 37580 "Paris, TX", add 
label define cbsa 37620 "Parkersburg-Marietta-Vienna, WV-OH", add 
label define cbsa 37660 "Parsons, KS", add 
label define cbsa 37700 "Pascagoula, MS", add 
label define cbsa 37800 "Pella, IA", add 
label define cbsa 37820 "Pendleton-Hermiston, OR", add 
label define cbsa 37860 "Pensacola-Ferry Pass-Brent, FL", add 
label define cbsa 37900 "Peoria, IL", add 
label define cbsa 37980 "Philadelphia-Camden-Wilmington, PA-NJ-DE-MD", add 
label define cbsa 38020 "Phoenix Lake-Cedar Ridge, CA", add 
label define cbsa 38060 "Phoenix-Mesa-Scottsdale, AZ", add 
label define cbsa 38100 "Picayune, MS", add 
label define cbsa 38220 "Pine Bluff, AR", add 
label define cbsa 38260 "Pittsburg, KS", add 
label define cbsa 38300 "Pittsburgh, PA", add 
label define cbsa 38340 "Pittsfield, MA", add 
label define cbsa 38380 "Plainview, TX", add 
label define cbsa 38420 "Platteville, WI", add 
label define cbsa 38460 "Plattsburgh, NY", add 
label define cbsa 38500 "Plymouth, IN", add 
label define cbsa 38540 "Pocatello, ID", add 
label define cbsa 38580 "Point Pleasant, WV-OH", add 
label define cbsa 38620 "Ponca City, OK", add 
label define cbsa 38660 "Ponce, PR", add 
label define cbsa 38740 "Poplar Bluff, MO", add 
label define cbsa 38780 "Portales, NM", add 
label define cbsa 38820 "Port Angeles, WA", add 
label define cbsa 38860 "Portland-South Portland-Biddeford, ME", add 
label define cbsa 38900 "Portland-Vancouver-Beaverton, OR-WA", add 
label define cbsa 38940 "Port St. Lucie, FL", add 
label define cbsa 39020 "Portsmouth, OH", add 
label define cbsa 39060 "Pottsville, PA", add 
label define cbsa 39100 "Poughkeepsie-Newburgh-Middletown, NY", add 
label define cbsa 39140 "Prescott, AZ", add 
label define cbsa 39220 "Price, UT", add 
label define cbsa 39300 "Providence-New Bedford-Fall River, RI-MA", add 
label define cbsa 39340 "Provo-Orem, UT", add 
label define cbsa 39380 "Pueblo, CO", add 
label define cbsa 39420 "Pullman, WA", add 
label define cbsa 39460 "Punta Gorda, FL", add 
label define cbsa 39500 "Quincy, IL-MO", add 
label define cbsa 39540 "Racine, WI", add 
label define cbsa 39580 "Raleigh-Cary, NC", add 
label define cbsa 39660 "Rapid City, SD", add 
label define cbsa 39740 "Reading, PA", add 
label define cbsa 39820 "Redding, CA", add 
label define cbsa 39860 "Red Wing, MN", add 
label define cbsa 39900 "Reno-Sparks, NV", add 
label define cbsa 39940 "Rexburg, ID", add 
label define cbsa 39980 "Richmond, IN", add 
label define cbsa 40060 "Richmond, VA", add 
label define cbsa 40080 "Richmond-Berea, KY", add 
label define cbsa 40140 "Riverside-San Bernardino-Ontario, CA", add 
label define cbsa 40180 "Riverton, WY", add 
label define cbsa 40220 "Roanoke, VA", add 
label define cbsa 40260 "Roanoke Rapids, NC", add 
label define cbsa 40340 "Rochester, MN", add 
label define cbsa 40380 "Rochester, NY", add 
label define cbsa 40420 "Rockford, IL", add 
label define cbsa 40460 "Rockingham, NC", add 
label define cbsa 40540 "Rock Springs, WY", add 
label define cbsa 40580 "Rocky Mount, NC", add 
label define cbsa 40620 "Rolla, MO", add 
label define cbsa 40660 "Rome, GA", add 
label define cbsa 40700 "Roseburg, OR", add 
label define cbsa 40740 "Roswell, NM", add 
label define cbsa 40760 "Ruidoso, NM", add 
label define cbsa 40780 "Russellville, AR", add 
label define cbsa 40820 "Ruston, LA", add 
label define cbsa 40860 "Rutland, VT", add 
label define cbsa 40900 "Sacramento--Arden-Arcade--Roseville, CA", add 
label define cbsa 40940 "Safford, AZ", add 
label define cbsa 40980 "Saginaw-Saginaw Township North, MI", add 
label define cbsa 41060 "St. Cloud, MN", add 
label define cbsa 41100 "St. George, UT", add 
label define cbsa 41140 "St. Joseph, MO-KS", add 
label define cbsa 41180 "St. Louis, MO-IL", add 
label define cbsa 41420 "Salem, OR", add 
label define cbsa 41460 "Salina, KS", add 
label define cbsa 41500 "Salinas, CA", add 
label define cbsa 41540 "Salisbury, MD", add 
label define cbsa 41580 "Salisbury, NC", add 
label define cbsa 41620 "Salt Lake City, UT", add 
label define cbsa 41660 "San Angelo, TX", add 
label define cbsa 41700 "San Antonio, TX", add 
label define cbsa 41740 "San Diego-Carlsbad-San Marcos, CA", add 
label define cbsa 41780 "Sandusky, OH", add 
label define cbsa 41820 "Sanford, NC", add 
label define cbsa 41860 "San Francisco-Oakland-Fremont, CA", add 
label define cbsa 41900 "San Germán-Cabo Rojo, PR", add 
label define cbsa 41940 "San Jose-Sunnyvale-Santa Clara, CA", add 
label define cbsa 41980 "San Juan-Caguas-Guaynabo, PR", add 
label define cbsa 42020 "San Luis Obispo-Paso Robles, CA", add 
label define cbsa 42060 "Santa Barbara-Santa Maria-Goleta, CA", add 
label define cbsa 42100 "Santa Cruz-Watsonville, CA", add 
label define cbsa 42140 "Santa Fe, NM", add 
label define cbsa 42220 "Santa Rosa-Petaluma, CA", add 
label define cbsa 42300 "Sault Ste. Marie, MI", add 
label define cbsa 42340 "Savannah, GA", add 
label define cbsa 42380 "Sayre, PA", add 
label define cbsa 42420 "Scottsbluff, NE", add 
label define cbsa 42540 "Scranton--Wilkes-Barre, PA", add 
label define cbsa 42580 "Seaford, DE", add 
label define cbsa 42620 "Searcy, AR", add 
label define cbsa 42660 "Seattle-Tacoma-Bellevue, WA", add 
label define cbsa 42700 "Sebring, FL", add 
label define cbsa 42740 "Sedalia, MO", add 
label define cbsa 42780 "Selinsgrove, PA", add 
label define cbsa 42820 "Selma, AL", add 
label define cbsa 42900 "Seneca Falls, NY", add 
label define cbsa 43060 "Shawnee, OK", add 
label define cbsa 43100 "Sheboygan, WI", add 
label define cbsa 43140 "Shelby, NC", add 
label define cbsa 43180 "Shelbyville, TN", add 
label define cbsa 43260 "Sheridan, WY", add 
label define cbsa 43300 "Sherman-Denison, TX", add 
label define cbsa 43320 "Show Low, AZ", add 
label define cbsa 43340 "Shreveport-Bossier City, LA", add 
label define cbsa 43420 "Sierra Vista-Douglas, AZ", add 
label define cbsa 43460 "Sikeston, MO", add 
label define cbsa 43500 "Silver City, NM", add 
label define cbsa 43580 "Sioux City, IA-NE-SD", add 
label define cbsa 43620 "Sioux Falls, SD", add 
label define cbsa 43660 "Snyder, TX", add 
label define cbsa 43700 "Somerset, KY", add 
label define cbsa 43780 "South Bend-Mishawaka, IN-MI", add 
label define cbsa 43860 "Southern Pines-Pinehurst, NC", add 
label define cbsa 43900 "Spartanburg, SC", add 
label define cbsa 43940 "Spearfish, SD", add 
label define cbsa 44020 "Spirit Lake, IA", add 
label define cbsa 44060 "Spokane, WA", add 
label define cbsa 44100 "Springfield, IL", add 
label define cbsa 44140 "Springfield, MA", add 
label define cbsa 44180 "Springfield, MO", add 
label define cbsa 44220 "Springfield, OH", add 
label define cbsa 44260 "Starkville, MS", add 
label define cbsa 44300 "State College, PA", add 
label define cbsa 44340 "Statesboro, GA", add 
label define cbsa 44380 "Statesville-Mooresville, NC", add 
label define cbsa 44420 "Staunton-Waynesboro, VA", add 
label define cbsa 44500 "Stephenville, TX", add 
label define cbsa 44540 "Sterling, CO", add 
label define cbsa 44580 "Sterling, IL", add 
label define cbsa 44620 "Stevens Point, WI", add 
label define cbsa 44660 "Stillwater, OK", add 
label define cbsa 44700 "Stockton, CA", add 
label define cbsa 44740 "Storm Lake, IA", add 
label define cbsa 44780 "Sturgis, MI", add 
label define cbsa 44940 "Sumter, SC", add 
label define cbsa 44980 "Sunbury, PA", add 
label define cbsa 45000 "Susanville, CA", add 
label define cbsa 45020 "Sweetwater, TX", add 
label define cbsa 45060 "Syracuse, NY", add 
label define cbsa 45140 "Tahlequah, OK", add 
label define cbsa 45180 "Talladega-Sylacauga, AL", add 
label define cbsa 45220 "Tallahassee, FL", add 
label define cbsa 45260 "Tallulah, LA", add 
label define cbsa 45300 "Tampa-St. Petersburg-Clearwater, FL", add 
label define cbsa 45340 "Taos, NM", add 
label define cbsa 45460 "Terre Haute, IN", add 
label define cbsa 45500 "Texarkana, TX-Texarkana, AR", add 
label define cbsa 45520 "The Dalles, OR", add 
label define cbsa 45580 "Thomaston, GA", add 
label define cbsa 45620 "Thomasville, GA", add 
label define cbsa 45640 "Thomasville-Lexington, NC", add 
label define cbsa 45660 "Tiffin, OH", add 
label define cbsa 45700 "Tifton, GA", add 
label define cbsa 45740 "Toccoa, GA", add 
label define cbsa 45780 "Toledo, OH", add 
label define cbsa 45820 "Topeka, KS", add 
label define cbsa 45860 "Torrington, CT", add 
label define cbsa 45900 "Traverse City, MI", add 
label define cbsa 45940 "Trenton-Ewing, NJ", add 
label define cbsa 45980 "Troy, AL", add 
label define cbsa 46060 "Tucson, AZ", add 
label define cbsa 46100 "Tullahoma, TN", add 
label define cbsa 46140 "Tulsa, OK", add 
label define cbsa 46180 "Tupelo, MS", add 
label define cbsa 46220 "Tuscaloosa, AL", add 
label define cbsa 46260 "Tuskegee, AL", add 
label define cbsa 46300 "Twin Falls, ID", add 
label define cbsa 46340 "Tyler, TX", add 
label define cbsa 46380 "Ukiah, CA", add 
label define cbsa 46420 "Union, SC", add 
label define cbsa 46500 "Urbana, OH", add 
label define cbsa 46540 "Utica-Rome, NY", add 
label define cbsa 46580 "Utuado, PR", add 
label define cbsa 46620 "Uvalde, TX", add 
label define cbsa 46660 "Valdosta, GA", add 
label define cbsa 46700 "Vallejo-Fairfield, CA", add 
label define cbsa 46780 "Van Wert, OH", add 
label define cbsa 46820 "Vermillion, SD", add 
label define cbsa 46900 "Vernon, TX", add 
label define cbsa 47020 "Victoria, TX", add 
label define cbsa 47080 "Vidalia, GA", add 
label define cbsa 47180 "Vincennes, IN", add 
label define cbsa 47220 "Vineland-Millville-Bridgeton, NJ", add 
label define cbsa 47260 "Virginia Beach-Norfolk-Newport News, VA-NC", add 
label define cbsa 47300 "Visalia-Porterville, CA", add 
label define cbsa 47340 "Wabash, IN", add 
label define cbsa 47380 "Waco, TX", add 
label define cbsa 47420 "Wahpeton, ND-MN", add 
label define cbsa 47460 "Walla Walla, WA", add 
label define cbsa 47580 "Warner Robins, GA", add 
label define cbsa 47660 "Warrensburg, MO", add 
label define cbsa 47700 "Warsaw, IN", add 
label define cbsa 47820 "Washington, NC", add 
label define cbsa 47900 "Washington-Arlington-Alexandria, DC-VA-MD-WV", add 
label define cbsa 47940 "Waterloo-Cedar Falls, IA", add 
label define cbsa 47980 "Watertown, SD", add 
label define cbsa 48020 "Watertown-Fort Atkinson, WI", add 
label define cbsa 48060 "Watertown-Fort Drum, NY", add 
label define cbsa 48140 "Wausau, WI", add 
label define cbsa 48180 "Waycross, GA", add 
label define cbsa 48260 "Weirton-Steubenville, WV-OH", add 
label define cbsa 48300 "Wenatchee-East Wenatchee, WA", add 
label define cbsa 48460 "West Plains, MO", add 
label define cbsa 48500 "West Point, MS", add 
label define cbsa 48540 "Wheeling, WV-OH", add 
label define cbsa 48580 "Whitewater, WI", add 
label define cbsa 48620 "Wichita, KS", add 
label define cbsa 48660 "Wichita Falls, TX", add 
label define cbsa 48700 "Williamsport, PA", add 
label define cbsa 48740 "Willimantic, CT", add 
label define cbsa 48780 "Williston, ND", add 
label define cbsa 48820 "Willmar, MN", add 
label define cbsa 48900 "Wilmington, NC", add 
label define cbsa 48940 "Wilmington, OH", add 
label define cbsa 48980 "Wilson, NC", add 
label define cbsa 49020 "Winchester, VA-WV", add 
label define cbsa 49060 "Winfield, KS", add 
label define cbsa 49100 "Winona, MN", add 
label define cbsa 49180 "Winston-Salem, NC", add 
label define cbsa 49260 "Woodward, OK", add 
label define cbsa 49300 "Wooster, OH", add 
label define cbsa 49340 "Worcester, MA", add 
label define cbsa 49420 "Yakima, WA", add 
label define cbsa 49460 "Yankton, SD", add 
label define cbsa 49500 "Yauco, PR", add 
label define cbsa 49620 "York-Hanover, PA", add 
label define cbsa 49660 "Youngstown-Warren-Boardman, OH-PA", add 
label define cbsa 49700 "Yuba City, CA", add 
label define cbsa 49740 "Yuma, AZ", add 
label define cbsa 49780 "Zanesville, OH", add 
label values cbsa cbsa
label define cbsatype -2 "Not applicable" 
label define cbsatype 1 "Metropolitan Statistical Area", add 
label define cbsatype 2 "Micropolitan Statistical Area", add 
label values cbsatype cbsatype
label define csa -2 "Not applicable" 
label define csa 102 "Albany-Corvallis-Lebanon, OR", add 
label define csa 104 "Albany-Schenectady-Amsterdam, NY", add 
label define csa 112 "Ames-Boone, IA", add 
label define csa 118 "Appleton-Oshkosh-Neenah, WI", add 
label define csa 120 "Asheville-Brevard, NC", add 
label define csa 122 "Atlanta-Sandy Springs-Gainesville, GA-AL", add 
label define csa 132 "Baton Rouge-Pierre Part, LA", add 
label define csa 138 "Beckley-Oak Hill, WV", add 
label define csa 140 "Bend-Prineville, OR", add 
label define csa 142 "Birmingham-Hoover-Cullman, AL", add 
label define csa 148 "Boston-Worcester-Manchester, MA-RI-NH", add 
label define csa 154 "Brownsville-Harlingen-Raymondville, TX", add 
label define csa 160 "Buffalo-Niagara-Cattaraugus, NY", add 
label define csa 164 "Cape Girardeau-Sikeston-Jackson, MO-IL", add 
label define csa 166 "Carbondale-Marion-Herrin, IL", add 
label define csa 172 "Charlotte-Gastonia-Salisbury, NC-SC", add 
label define csa 174 "Chattanooga-Cleveland-Athens, TN-GA", add 
label define csa 176 "Chicago-Naperville-Michigan City, IL-IN-WI", add 
label define csa 178 "Cincinnati-Middletown-Wilmington, OH-KY-IN", add 
label define csa 180 "Claremont-Lebanon, NH-VT", add 
label define csa 184 "Cleveland-Akron-Elyria, OH", add 
label define csa 188 "Clovis-Portales, NM", add 
label define csa 192 "Columbia-Newberry, SC", add 
label define csa 194 "Columbus-Auburn-Opelika, GA-AL", add 
label define csa 198 "Columbus-Marion-Chillicothe, OH", add 
label define csa 200 "Columbus-West Point, MS", add 
label define csa 202 "Corbin-London, KY", add 
label define csa 204 "Corpus Christi-Kingsville, TX", add 
label define csa 206 "Dallas-Fort Worth, TX", add 
label define csa 212 "Dayton-Springfield-Greenville, OH", add 
label define csa 216 "Denver-Aurora-Boulder, CO", add 
label define csa 218 "Des Moines-Newton-Pella, IA", add 
label define csa 220 "Detroit-Warren-Flint, MI", add 
label define csa 222 "Dothan-Enterprise-Ozark, AL", add 
label define csa 232 "Eau Claire-Menomonie, WI", add 
label define csa 242 "Fairmont-Clarksburg, WV", add 
label define csa 244 "Fargo-Wahpeton, ND-MN", add 
label define csa 248 "Findlay-Tiffin, OH", add 
label define csa 252 "Fond du Lac-Beaver Dam, WI", add 
label define csa 256 "Fort Polk South-De Ridder, LA", add 
label define csa 258 "Fort Wayne-Huntington-Auburn, IN", add 
label define csa 260 "Fresno-Madera, CA", add 
label define csa 266 "Grand Rapids-Muskegon-Holland, MI", add 
label define csa 268 "Greensboro--Winston-Salem--High Point, NC", add 
label define csa 273 "Greenville-Spartanburg-Anderson, SC", add 
label define csa 274 "Gulfport-Biloxi-Pascagoula, MS", add 
label define csa 276 "Harrisburg-Carlisle-Lebanon, PA", add 
label define csa 278 "Hartford-West Hartford-Willimantic, CT", add 
label define csa 288 "Houston-Baytown-Huntsville, TX", add 
label define csa 290 "Huntsville-Decatur, AL", add 
label define csa 292 "Idaho Falls-Blackfoot, ID", add 
label define csa 294 "Indianapolis-Anderson-Columbus, IN", add 
label define csa 296 "Ithaca-Cortland, NY", add 
label define csa 297 "Jackson-Humboldt, TN", add 
label define csa 298 "Jackson-Yazoo City, MS", add 
label define csa 304 "Johnson City-Kingsport-Bristol (Tri-Cities), TN-VA", add 
label define csa 308 "Jonesboro-Paragould, AR", add 
label define csa 312 "Kansas City-Overland Park-Kansas City, MO-KS", add 
label define csa 314 "Knoxville-Sevierville-La Follette, TN", add 
label define csa 316 "Kokomo-Peru, IN", add 
label define csa 318 "Lafayette-Acadiana, LA", add 
label define csa 320 "Lafayette-Frankfort, IN", add 
label define csa 324 "Lake Charles-Jennings, LA", add 
label define csa 330 "Lansing-East Lansing-Owosso, MI", add 
label define csa 332 "Las Vegas-Paradise-Pahrump, NV", add 
label define csa 336 "Lexington-Fayette--Frankfort--Richmond, KY", add 
label define csa 338 "Lima-Van Wert-Wapakoneta, OH", add 
label define csa 340 "Little Rock-North Little Rock-Pine Bluff, AR", add 
label define csa 346 "Longview-Marshall, TX", add 
label define csa 348 "Los Angeles-Long Beach-Riverside, CA", add 
label define csa 350 "Louisville-Jefferson County--Elizabethtown-Scottsburg, KY-IN", add 
label define csa 352 "Lubbock-Levelland, TX", add 
label define csa 354 "Lumberton-Laurinburg, NC", add 
label define csa 356 "Macon-Warner Robins-Fort Valley, GA", add 
label define csa 358 "Madison-Baraboo, WI", add 
label define csa 360 "Mansfield-Bucyrus, OH", add 
label define csa 364 "Mayagüez-San Germán-Cabo Rojo, PR", add 
label define csa 372 "Midland-Odessa, TX", add 
label define csa 376 "Milwaukee-Racine-Waukesha, WI", add 
label define csa 378 "Minneapolis-St. Paul-St. Cloud, MN-WI", add 
label define csa 380 "Mobile-Daphne-Fairhope, AL", add 
label define csa 384 "Monroe-Bastrop, LA", add 
label define csa 388 "Montgomery-Alexander City, AL", add 
label define csa 396 "Myrtle Beach-Conway-Georgetown, SC", add 
label define csa 400 "Nashville-Davidson--Murfreesboro--Columbia, TN", add 
label define csa 406 "New Orleans-Metairie-Bogalusa, LA", add 
label define csa 408 "New York-Newark-Bridgeport, NY-NJ-CT-PA", add 
label define csa 416 "Oklahoma City-Shawnee, OK", add 
label define csa 420 "Omaha-Council Bluffs-Fremont, NE-IA", add 
label define csa 422 "Orlando-Deltona-Daytona Beach, FL", add 
label define csa 424 "Paducah-Mayfield, KY-IL", add 
label define csa 426 "Peoria-Canton, IL", add 
label define csa 428 "Philadelphia-Camden-Vineland, PA-NJ-DE-MD", add 
label define csa 430 "Pittsburgh-New Castle, PA", add 
label define csa 434 "Ponce-Yauco-Coamo, PR", add 
label define csa 438 "Portland-Lewiston-South Portland, ME", add 
label define csa 442 "Port St. Lucie-Sebastian-Vero Beach, FL", add 
label define csa 450 "Raleigh-Durham-Cary, NC", add 
label define csa 456 "Reno-Sparks-Fernley, NV", add 
label define csa 464 "Rochester-Batavia-Seneca Falls, NY", add 
label define csa 466 "Rockford-Freeport-Rochelle, IL", add 
label define csa 472 "Sacramento--Arden-Arcade--Yuba City, CA-NV", add 
label define csa 474 "Saginaw-Bay City-Saginaw Township North, MI", add 
label define csa 476 "St. Louis-St. Charles-Farmington, MO-IL", add 
label define csa 480 "Salisbury-Ocean Pines, MD", add 
label define csa 482 "Salt Lake City-Ogden-Clearfield, UT", add 
label define csa 488 "San Jose-San Francisco-Oakland, CA", add 
label define csa 490 "San Juan-Caguas-Fajardo, PR", add 
label define csa 492 "Santa Fe-Espanola, NM", add 
label define csa 494 "Sarasota-Bradenton-Punta Gorda, FL", add 
label define csa 496 "Savannah-Hinesville-Fort Stewart, GA", add 
label define csa 500 "Seattle-Tacoma-Olympia, WA", add 
label define csa 508 "Shreveport-Bossier City-Minden, LA", add 
label define csa 512 "Sioux City-Vermillion, IA-NE-SD", add 
label define csa 515 "South Bend-Elkhart-Mishawaka, IN-MI", add 
label define csa 526 "Sunbury-Lewisburg-Selinsgrove, PA", add 
label define csa 532 "Syracuse-Auburn, NY", add 
label define csa 534 "Toledo-Fremont, OH", add 
label define csa 538 "Tulsa-Bartlesville, OK", add 
label define csa 540 "Tyler-Jacksonville, TX", add 
label define csa 542 "Union City-Martin, TN-KY", add 
label define csa 548 "Washington-Baltimore-Northern Virginia, DC-MD-VA-WV", add 
label define csa 554 "Wausau-Merrill, WI", add 
label define csa 556 "Wichita-Winfield, KS", add 
label define csa 558 "Williamsport-Lock Haven, PA", add 
label define csa 564 "York-Hanover-Gettysburg, PA", add 
label define csa 566 "Youngstown-Warren-East Liverpool, OH-PA", add 
label values csa csa
label define necta -2 "Not applicable" 
label define necta 70300 "Amherst Center, MA", add 
label define necta 70600 "Augusta, ME", add 
label define necta 70750 "Bangor, ME", add 
label define necta 70900 "Barnstable Town, MA", add 
label define necta 71050 "Barre, VT", add 
label define necta 71350 "Bennington, VT", add 
label define necta 71500 "Berlin, NH", add 
label define necta 71650 "Boston-Cambridge-Quincy, MA-NH", add 
label define necta 71950 "Bridgeport-Stamford-Norwalk, CT", add 
label define necta 72250 "Brunswick, ME", add 
label define necta 72400 "Burlington-South Burlington, VT", add 
label define necta 72500 "Claremont, NH", add 
label define necta 72700 "Concord, NH", add 
label define necta 72850 "Danbury, CT", add 
label define necta 73000 "Danielson, CT", add 
label define necta 73300 "Greenfield, MA", add 
label define necta 73450 "Hartford-West Hartford-East Hartford, CT", add 
label define necta 73750 "Keene, NH", add 
label define necta 73900 "Laconia, NH", add 
label define necta 74350 "Lebanon, NH-VT", add 
label define necta 74500 "Leominster-Fitchburg-Gardner, MA", add 
label define necta 74650 "Lewiston-Auburn, ME", add 
label define necta 74950 "Manchester, NH", add 
label define necta 75550 "New Bedford, MA", add 
label define necta 75700 "New Haven, CT", add 
label define necta 76150 "North Adams, MA-VT", add 
label define necta 76450 "Norwich-New London, CT-RI", add 
label define necta 76600 "Pittsfield, MA", add 
label define necta 76750 "Portland-South Portland-Biddeford, ME", add 
label define necta 76900 "Portsmouth, NH-ME", add 
label define necta 77200 "Providence-Fall River-Warwick, RI-MA", add 
label define necta 77350 "Rochester-Dover, NH-ME", add 
label define necta 77650 "Rutland, VT", add 
label define necta 77950 "Sanford, ME", add 
label define necta 78100 "Springfield, MA-CT", add 
label define necta 78400 "Torrington, CT", add 
label define necta 78700 "Waterbury, CT", add 
label define necta 78850 "Waterville, ME", add 
label define necta 79300 "Willimantic, CT", add 
label define necta 79600 "Worcester, MA-CT", add 
label values necta necta
label define countycd -2 "Not applicable" 
label define countycd 10001 "Kent, DE", add 
label define countycd 10003 "New Castle, DE", add 
label define countycd 10005 "Sussex, DE", add 
label define countycd 1003 "Baldwin, AL", add 
label define countycd 1015 "Calhoun, AL", add 
label define countycd 1031 "Coffee, AL", add 
label define countycd 1033 "Colbert, AL", add 
label define countycd 1035 "Conecuh, AL", add 
label define countycd 1039 "Covington, AL", add 
label define countycd 1043 "Cullman, AL", add 
label define countycd 1045 "Dale, AL", add 
label define countycd 1047 "Dallas, AL", add 
label define countycd 1049 "DeKalb, AL", add 
label define countycd 1051 "Elmore, AL", add 
label define countycd 1053 "Escambia, AL", add 
label define countycd 1055 "Etowah, AL", add 
label define countycd 1069 "Houston, AL", add 
label define countycd 1073 "Jefferson, AL", add 
label define countycd 1077 "Lauderdale, AL", add 
label define countycd 1081 "Lee, AL", add 
label define countycd 1083 "Limestone, AL", add 
label define countycd 1087 "Macon, AL", add 
label define countycd 1089 "Madison, AL", add 
label define countycd 1095 "Marshall, AL", add 
label define countycd 1097 "Mobile, AL", add 
label define countycd 1099 "Monroe, AL", add 
label define countycd 11001 "District of Columbia, DC", add 
label define countycd 1101 "Montgomery, AL", add 
label define countycd 1105 "Perry, AL", add 
label define countycd 1109 "Pike, AL", add 
label define countycd 1111 "Randolph, AL", add 
label define countycd 1113 "Russell, AL", add 
label define countycd 1117 "Shelby, AL", add 
label define countycd 1119 "Sumter, AL", add 
label define countycd 1121 "Talladega, AL", add 
label define countycd 1123 "Tallapoosa, AL", add 
label define countycd 1125 "Tuscaloosa, AL", add 
label define countycd 1127 "Walker, AL", add 
label define countycd 12001 "Alachua, FL", add 
label define countycd 12005 "Bay, FL", add 
label define countycd 12007 "Bradford, FL", add 
label define countycd 12009 "Brevard, FL", add 
label define countycd 12011 "Broward, FL", add 
label define countycd 12015 "Charlotte, FL", add 
label define countycd 12017 "Citrus, FL", add 
label define countycd 12019 "Clay, FL", add 
label define countycd 12021 "Collier, FL", add 
label define countycd 12023 "Columbia, FL", add 
label define countycd 12031 "Duval, FL", add 
label define countycd 12033 "Escambia, FL", add 
label define countycd 12055 "Highlands, FL", add 
label define countycd 12057 "Hillsborough, FL", add 
label define countycd 12063 "Jackson, FL", add 
label define countycd 12069 "Lake, FL", add 
label define countycd 12071 "Lee, FL", add 
label define countycd 12073 "Leon, FL", add 
label define countycd 12079 "Madison, FL", add 
label define countycd 12081 "Manatee, FL", add 
label define countycd 12083 "Marion, FL", add 
label define countycd 12085 "Martin, FL", add 
label define countycd 12086 "Miami-Dade, FL", add 
label define countycd 12087 "Monroe, FL", add 
label define countycd 12091 "Okaloosa, FL", add 
label define countycd 12095 "Orange, FL", add 
label define countycd 12097 "Osceola, FL", add 
label define countycd 12099 "Palm Beach, FL", add 
label define countycd 12101 "Pasco, FL", add 
label define countycd 12103 "Pinellas, FL", add 
label define countycd 12105 "Polk, FL", add 
label define countycd 12107 "Putnam, FL", add 
label define countycd 12109 "St. Johns, FL", add 
label define countycd 12111 "St. Lucie, FL", add 
label define countycd 12113 "Santa Rosa, FL", add 
label define countycd 12115 "Sarasota, FL", add 
label define countycd 12117 "Seminole, FL", add 
label define countycd 12121 "Suwannee, FL", add 
label define countycd 12123 "Taylor, FL", add 
label define countycd 12127 "Volusia, FL", add 
label define countycd 12133 "Washington, FL", add 
label define countycd 13009 "Baldwin, GA", add 
label define countycd 13015 "Bartow, GA", add 
label define countycd 13017 "Ben Hill, GA", add 
label define countycd 13021 "Bibb, GA", add 
label define countycd 13023 "Bleckley, GA", add 
label define countycd 13031 "Bulloch, GA", add 
label define countycd 13045 "Carroll, GA", add 
label define countycd 13051 "Chatham, GA", add 
label define countycd 13057 "Cherokee, GA", add 
label define countycd 13059 "Clarke, GA", add 
label define countycd 13063 "Clayton, GA", add 
label define countycd 13067 "Cobb, GA", add 
label define countycd 13069 "Coffee, GA", add 
label define countycd 13071 "Colquitt, GA", add 
label define countycd 13073 "Columbia, GA", add 
label define countycd 13083 "Dade, GA", add 
label define countycd 13085 "Dawson, GA", add 
label define countycd 13087 "Decatur, GA", add 
label define countycd 13089 "DeKalb, GA", add 
label define countycd 13095 "Dougherty, GA", add 
label define countycd 13097 "Douglas, GA", add 
label define countycd 13107 "Emanuel, GA", add 
label define countycd 13113 "Fayette, GA", add 
label define countycd 13115 "Floyd, GA", add 
label define countycd 13119 "Franklin, GA", add 
label define countycd 13121 "Fulton, GA", add 
label define countycd 13127 "Glynn, GA", add 
label define countycd 13135 "Gwinnett, GA", add 
label define countycd 13137 "Habersham, GA", add 
label define countycd 13139 "Hall, GA", add 
label define countycd 13143 "Haralson, GA", add 
label define countycd 13153 "Houston, GA", add 
label define countycd 13171 "Lamar, GA", add 
label define countycd 13175 "Laurens, GA", add 
label define countycd 13185 "Lowndes, GA", add 
label define countycd 13187 "Lumpkin, GA", add 
label define countycd 13209 "Montgomery, GA", add 
label define countycd 13215 "Muscogee, GA", add 
label define countycd 13223 "Paulding, GA", add 
label define countycd 13225 "Peach, GA", add 
label define countycd 13227 "Pickens, GA", add 
label define countycd 13243 "Randolph, GA", add 
label define countycd 13245 "Richmond, GA", add 
label define countycd 13247 "Rockdale, GA", add 
label define countycd 13255 "Spalding, GA", add 
label define countycd 13257 "Stephens, GA", add 
label define countycd 13261 "Sumter, GA", add 
label define countycd 13275 "Thomas, GA", add 
label define countycd 13277 "Tift, GA", add 
label define countycd 13279 "Toombs, GA", add 
label define countycd 13281 "Towns, GA", add 
label define countycd 13285 "Troup, GA", add 
label define countycd 13293 "Upson, GA", add 
label define countycd 13295 "Walker, GA", add 
label define countycd 13299 "Ware, GA", add 
label define countycd 13303 "Washington, GA", add 
label define countycd 13305 "Wayne, GA", add 
label define countycd 13311 "White, GA", add 
label define countycd 13313 "Whitfield, GA", add 
label define countycd 15001 "Hawaii, HI", add 
label define countycd 15003 "Honolulu, HI", add 
label define countycd 15007 "Kauai, HI", add 
label define countycd 15009 "Maui, HI", add 
label define countycd 16001 "Ada, ID", add 
label define countycd 16005 "Bannock, ID", add 
label define countycd 16019 "Bonneville, ID", add 
label define countycd 16027 "Canyon, ID", add 
label define countycd 16031 "Cassia, ID", add 
label define countycd 16055 "Kootenai, ID", add 
label define countycd 16057 "Latah, ID", add 
label define countycd 16065 "Madison, ID", add 
label define countycd 16069 "Nez Perce, ID", add 
label define countycd 16083 "Twin Falls, ID", add 
label define countycd 17001 "Adams, IL", add 
label define countycd 17005 "Bond, IL", add 
label define countycd 17019 "Champaign, IL", add 
label define countycd 17027 "Clinton, IL", add 
label define countycd 17029 "Coles, IL", add 
label define countycd 17031 "Cook, IL", add 
label define countycd 17033 "Crawford, IL", add 
label define countycd 17037 "DeKalb, IL", add 
label define countycd 17043 "DuPage, IL", add 
label define countycd 17057 "Fulton, IL", add 
label define countycd 17077 "Jackson, IL", add 
label define countycd 17081 "Jefferson, IL", add 
label define countycd 17083 "Jersey, IL", add 
label define countycd 17089 "Kane, IL", add 
label define countycd 17091 "Kankakee, IL", add 
label define countycd 17093 "Kendall, IL", add 
label define countycd 17095 "Knox, IL", add 
label define countycd 17097 "Lake, IL", add 
label define countycd 17099 "LaSalle, IL", add 
label define countycd 17103 "Lee, IL", add 
label define countycd 17107 "Logan, IL", add 
label define countycd 17109 "McDonough, IL", add 
label define countycd 17111 "McHenry, IL", add 
label define countycd 17113 "McLean, IL", add 
label define countycd 17115 "Macon, IL", add 
label define countycd 17117 "Macoupin, IL", add 
label define countycd 17119 "Madison, IL", add 
label define countycd 17133 "Monroe, IL", add 
label define countycd 17135 "Montgomery, IL", add 
label define countycd 17137 "Morgan, IL", add 
label define countycd 17143 "Peoria, IL", add 
label define countycd 17153 "Pulaski, IL", add 
label define countycd 17159 "Richland, IL", add 
label define countycd 17161 "Rock Island, IL", add 
label define countycd 17163 "St. Clair, IL", add 
label define countycd 17165 "Saline, IL", add 
label define countycd 17167 "Sangamon, IL", add 
label define countycd 17173 "Shelby, IL", add 
label define countycd 17177 "Stephenson, IL", add 
label define countycd 17179 "Tazewell, IL", add 
label define countycd 17183 "Vermilion, IL", add 
label define countycd 17185 "Wabash, IL", add 
label define countycd 17187 "Warren, IL", add 
label define countycd 17191 "Wayne, IL", add 
label define countycd 17195 "Whiteside, IL", add 
label define countycd 17197 "Will, IL", add 
label define countycd 17199 "Williamson, IL", add 
label define countycd 17201 "Winnebago, IL", add 
label define countycd 17203 "Woodford, IL", add 
label define countycd 18003 "Allen, IN", add 
label define countycd 18005 "Bartholomew, IN", add 
label define countycd 18011 "Boone, IN", add 
label define countycd 18019 "Clark, IN", add 
label define countycd 18035 "Delaware, IN", add 
label define countycd 18039 "Elkhart, IN", add 
label define countycd 18043 "Floyd, IN", add 
label define countycd 18051 "Gibson, IN", add 
label define countycd 18053 "Grant, IN", add 
label define countycd 18057 "Hamilton, IN", add 
label define countycd 18059 "Hancock, IN", add 
label define countycd 18063 "Hendricks, IN", add 
label define countycd 18067 "Howard, IN", add 
label define countycd 18069 "Huntington, IN", add 
label define countycd 18073 "Jasper, IN", add 
label define countycd 18077 "Jefferson, IN", add 
label define countycd 18081 "Johnson, IN", add 
label define countycd 18083 "Knox, IN", add 
label define countycd 18085 "Kosciusko, IN", add 
label define countycd 18089 "Lake, IN", add 
label define countycd 18091 "LaPorte, IN", add 
label define countycd 18095 "Madison, IN", add 
label define countycd 18097 "Marion, IN", add 
label define countycd 18099 "Marshall, IN", add 
label define countycd 18105 "Monroe, IN", add 
label define countycd 18107 "Montgomery, IN", add 
label define countycd 18127 "Porter, IN", add 
label define countycd 18133 "Putnam, IN", add 
label define countycd 18141 "St. Joseph, IN", add 
label define countycd 18147 "Spencer, IN", add 
label define countycd 18149 "Starke, IN", add 
label define countycd 18151 "Steuben, IN", add 
label define countycd 18157 "Tippecanoe, IN", add 
label define countycd 18163 "Vanderburgh, IN", add 
label define countycd 18167 "Vigo, IN", add 
label define countycd 18169 "Wabash, IN", add 
label define countycd 18173 "Warrick, IN", add 
label define countycd 18177 "Wayne, IN", add 
label define countycd 19013 "Black Hawk, IA", add 
label define countycd 19017 "Bremer, IA", add 
label define countycd 19021 "Buena Vista, IA", add 
label define countycd 19033 "Cerro Gordo, IA", add 
label define countycd 19045 "Clinton, IA", add 
label define countycd 19049 "Dallas, IA", add 
label define countycd 19053 "Decatur, IA", add 
label define countycd 19057 "Des Moines, IA", add 
label define countycd 19059 "Dickinson, IA", add 
label define countycd 19061 "Dubuque, IA", add 
label define countycd 19063 "Emmet, IA", add 
label define countycd 19065 "Fayette, IA", add 
label define countycd 19083 "Hardin, IA", add 
label define countycd 19087 "Henry, IA", add 
label define countycd 19089 "Howard, IA", add 
label define countycd 19101 "Jefferson, IA", add 
label define countycd 19103 "Johnson, IA", add 
label define countycd 19105 "Jones, IA", add 
label define countycd 19111 "Lee, IA", add 
label define countycd 19113 "Linn, IA", add 
label define countycd 19123 "Mahaska, IA", add 
label define countycd 19125 "Marion, IA", add 
label define countycd 19127 "Marshall, IA", add 
label define countycd 19153 "Polk, IA", add 
label define countycd 19155 "Pottawattamie, IA", add 
label define countycd 19157 "Poweshiek, IA", add 
label define countycd 19163 "Scott, IA", add 
label define countycd 19167 "Sioux, IA", add 
label define countycd 19169 "Story, IA", add 
label define countycd 19175 "Union, IA", add 
label define countycd 19179 "Wapello, IA", add 
label define countycd 19181 "Warren, IA", add 
label define countycd 19187 "Webster, IA", add 
label define countycd 19189 "Winnebago, IA", add 
label define countycd 19191 "Winneshiek, IA", add 
label define countycd 19193 "Woodbury, IA", add 
label define countycd 20001 "Allen, KS", add 
label define countycd 20005 "Atchison, KS", add 
label define countycd 20009 "Barton, KS", add 
label define countycd 20011 "Bourbon, KS", add 
label define countycd 20015 "Butler, KS", add 
label define countycd 20021 "Cherokee, KS", add 
label define countycd 20029 "Cloud, KS", add 
label define countycd 20035 "Cowley, KS", add 
label define countycd 20037 "Crawford, KS", add 
label define countycd 20043 "Doniphan, KS", add 
label define countycd 20045 "Douglas, KS", add 
label define countycd 20051 "Ellis, KS", add 
label define countycd 20055 "Finney, KS", add 
label define countycd 20057 "Ford, KS", add 
label define countycd 20059 "Franklin, KS", add 
label define countycd 20079 "Harvey, KS", add 
label define countycd 20091 "Johnson, KS", add 
label define countycd 20097 "Kiowa, KS", add 
label define countycd 20099 "Labette, KS", add 
label define countycd 20103 "Leavenworth, KS", add 
label define countycd 20111 "Lyon, KS", add 
label define countycd 20113 "McPherson, KS", add 
label define countycd 20115 "Marion, KS", add 
label define countycd 20123 "Mitchell, KS", add 
label define countycd 20125 "Montgomery, KS", add 
label define countycd 20133 "Neosho, KS", add 
label define countycd 20151 "Pratt, KS", add 
label define countycd 20155 "Reno, KS", add 
label define countycd 20159 "Rice, KS", add 
label define countycd 20161 "Riley, KS", add 
label define countycd 20169 "Saline, KS", add 
label define countycd 20173 "Sedgwick, KS", add 
label define countycd 20175 "Seward, KS", add 
label define countycd 20177 "Shawnee, KS", add 
label define countycd 20181 "Sherman, KS", add 
label define countycd 20193 "Thomas, KS", add 
label define countycd 2020 "Anchorage Municipality, AK", add 
label define countycd 20209 "Wyandotte, KS", add 
label define countycd 2090 "Fairbanks North Star Borough, AK", add 
label define countycd 21001 "Adair, KY", add 
label define countycd 21003 "Allen, KY", add 
label define countycd 21009 "Barren, KY", add 
label define countycd 21013 "Bell, KY", add 
label define countycd 21015 "Boone, KY", add 
label define countycd 21019 "Boyd, KY", add 
label define countycd 21021 "Boyle, KY", add 
label define countycd 21025 "Breathitt, KY", add 
label define countycd 21035 "Calloway, KY", add 
label define countycd 21037 "Campbell, KY", add 
label define countycd 21043 "Carter, KY", add 
label define countycd 21047 "Christian, KY", add 
label define countycd 21051 "Clay, KY", add 
label define countycd 21053 "Clinton, KY", add 
label define countycd 21059 "Daviess, KY", add 
label define countycd 21067 "Fayette, KY", add 
label define countycd 21071 "Floyd, KY", add 
label define countycd 21073 "Franklin, KY", add 
label define countycd 21083 "Graves, KY", add 
label define countycd 21089 "Greenup, KY", add 
label define countycd 21093 "Hardin, KY", add 
label define countycd 21095 "Harlan, KY", add 
label define countycd 2110 "Juneau City and Borough, AK", add 
label define countycd 21101 "Henderson, KY", add 
label define countycd 21107 "Hopkins, KY", add 
label define countycd 21111 "Jefferson, KY", add 
label define countycd 21113 "Jessamine, KY", add 
label define countycd 21117 "Kenton, KY", add 
label define countycd 21119 "Knott, KY", add 
label define countycd 21121 "Knox, KY", add 
label define countycd 21125 "Laurel, KY", add 
label define countycd 21131 "Leslie, KY", add 
label define countycd 21133 "Letcher, KY", add 
label define countycd 21145 "McCracken, KY", add 
label define countycd 21151 "Madison, KY", add 
label define countycd 21161 "Mason, KY", add 
label define countycd 21173 "Montgomery, KY", add 
label define countycd 21193 "Perry, KY", add 
label define countycd 21195 "Pike, KY", add 
label define countycd 21199 "Pulaski, KY", add 
label define countycd 21205 "Rowan, KY", add 
label define countycd 21209 "Scott, KY", add 
label define countycd 21217 "Taylor, KY", add 
label define countycd 2122 "Kenai Peninsula Borough, AK", add 
label define countycd 21227 "Warren, KY", add 
label define countycd 21229 "Washington, KY", add 
label define countycd 21235 "Whitley, KY", add 
label define countycd 21239 "Woodford, KY", add 
label define countycd 2185 "North Slope Borough, AK", add 
label define countycd 22001 "Acadia Parish, LA", add 
label define countycd 22003 "Allen Parish, LA", add 
label define countycd 22005 "Ascension Parish, LA", add 
label define countycd 22009 "Avoyelles Parish, LA", add 
label define countycd 22015 "Bossier Parish, LA", add 
label define countycd 22017 "Caddo Parish, LA", add 
label define countycd 22019 "Calcasieu Parish, LA", add 
label define countycd 22029 "Concordia Parish, LA", add 
label define countycd 22031 "De Soto Parish, LA", add 
label define countycd 22033 "East Baton Rouge Parish, LA", add 
label define countycd 22037 "East Feliciana Parish, LA", add 
label define countycd 22039 "Evangeline Parish, LA", add 
label define countycd 22041 "Franklin Parish, LA", add 
label define countycd 22045 "Iberia Parish, LA", add 
label define countycd 22047 "Iberville Parish, LA", add 
label define countycd 22051 "Jefferson Parish, LA", add 
label define countycd 22053 "Jefferson Davis Parish, LA", add 
label define countycd 22055 "Lafayette Parish, LA", add 
label define countycd 22057 "Lafourche Parish, LA", add 
label define countycd 22061 "Lincoln Parish, LA", add 
label define countycd 22063 "Livingston Parish, LA", add 
label define countycd 22065 "Madison Parish, LA", add 
label define countycd 22067 "Morehouse Parish, LA", add 
label define countycd 22069 "Natchitoches Parish, LA", add 
label define countycd 22071 "Orleans Parish, LA", add 
label define countycd 22073 "Ouachita Parish, LA", add 
label define countycd 22077 "Pointe Coupee Parish, LA", add 
label define countycd 22079 "Rapides Parish, LA", add 
label define countycd 22085 "Sabine Parish, LA", add 
label define countycd 22087 "St. Bernard Parish, LA", add 
label define countycd 22089 "St. Charles Parish, LA", add 
label define countycd 22091 "St. Helena Parish, LA", add 
label define countycd 22095 "St. John the Baptist Parish, LA", add 
label define countycd 22097 "St. Landry Parish, LA", add 
label define countycd 22099 "St. Martin Parish, LA", add 
label define countycd 22101 "St. Mary Parish, LA", add 
label define countycd 22103 "St. Tammany Parish, LA", add 
label define countycd 22105 "Tangipahoa Parish, LA", add 
label define countycd 22109 "Terrebonne Parish, LA", add 
label define countycd 22111 "Union Parish, LA", add 
label define countycd 22113 "Vermilion Parish, LA", add 
label define countycd 22115 "Vernon Parish, LA", add 
label define countycd 22117 "Washington Parish, LA", add 
label define countycd 22119 "Webster Parish, LA", add 
label define countycd 22127 "Winn Parish, LA", add 
label define countycd 2261 "Valdez-Cordova Census Area, AK", add 
label define countycd 23001 "Androscoggin, ME", add 
label define countycd 23003 "Aroostook, ME", add 
label define countycd 23005 "Cumberland, ME", add 
label define countycd 23007 "Franklin, ME", add 
label define countycd 23009 "Hancock, ME", add 
label define countycd 23011 "Kennebec, ME", add 
label define countycd 23019 "Penobscot, ME", add 
label define countycd 23025 "Somerset, ME", add 
label define countycd 23027 "Waldo, ME", add 
label define countycd 23029 "Washington, ME", add 
label define countycd 23031 "York, ME", add 
label define countycd 24001 "Allegany, MD", add 
label define countycd 24003 "Anne Arundel, MD", add 
label define countycd 24005 "Baltimore, MD", add 
label define countycd 24013 "Carroll, MD", add 
label define countycd 24015 "Cecil, MD", add 
label define countycd 24017 "Charles, MD", add 
label define countycd 24021 "Frederick, MD", add 
label define countycd 24023 "Garrett, MD", add 
label define countycd 24025 "Harford, MD", add 
label define countycd 24027 "Howard, MD", add 
label define countycd 24029 "Kent, MD", add 
label define countycd 24031 "Montgomery, MD", add 
label define countycd 24033 "Prince Georges, MD", add 
label define countycd 24037 "St. Marys, MD", add 
label define countycd 24039 "Somerset, MD", add 
label define countycd 24041 "Talbot, MD", add 
label define countycd 24043 "Washington, MD", add 
label define countycd 24045 "Wicomico, MD", add 
label define countycd 24510 "Baltimore city, MD", add 
label define countycd 25001 "Barnstable, MA", add 
label define countycd 25003 "Berkshire, MA", add 
label define countycd 25005 "Bristol, MA", add 
label define countycd 25009 "Essex, MA", add 
label define countycd 25011 "Franklin, MA", add 
label define countycd 25013 "Hampden, MA", add 
label define countycd 25015 "Hampshire, MA", add 
label define countycd 25017 "Middlesex, MA", add 
label define countycd 25021 "Norfolk, MA", add 
label define countycd 25023 "Plymouth, MA", add 
label define countycd 25025 "Suffolk, MA", add 
label define countycd 25027 "Worcester, MA", add 
label define countycd 26007 "Alpena, MI", add 
label define countycd 26015 "Barry, MI", add 
label define countycd 26017 "Bay, MI", add 
label define countycd 26021 "Berrien, MI", add 
label define countycd 26023 "Branch, MI", add 
label define countycd 26025 "Calhoun, MI", add 
label define countycd 26027 "Cass, MI", add 
label define countycd 26033 "Chippewa, MI", add 
label define countycd 26035 "Clare, MI", add 
label define countycd 26039 "Crawford, MI", add 
label define countycd 26041 "Delta, MI", add 
label define countycd 26045 "Eaton, MI", add 
label define countycd 26047 "Emmet, MI", add 
label define countycd 26049 "Genesee, MI", add 
label define countycd 26053 "Gogebic, MI", add 
label define countycd 26055 "Grand Traverse, MI", add 
label define countycd 26057 "Gratiot, MI", add 
label define countycd 26059 "Hillsdale, MI", add 
label define countycd 26061 "Houghton, MI", add 
label define countycd 26065 "Ingham, MI", add 
label define countycd 26073 "Isabella, MI", add 
label define countycd 26075 "Jackson, MI", add 
label define countycd 26077 "Kalamazoo, MI", add 
label define countycd 26081 "Kent, MI", add 
label define countycd 26091 "Lenawee, MI", add 
label define countycd 26093 "Livingston, MI", add 
label define countycd 26099 "Macomb, MI", add 
label define countycd 26103 "Marquette, MI", add 
label define countycd 26105 "Mason, MI", add 
label define countycd 26107 "Mecosta, MI", add 
label define countycd 26111 "Midland, MI", add 
label define countycd 26115 "Monroe, MI", add 
label define countycd 26117 "Montcalm, MI", add 
label define countycd 26121 "Muskegon, MI", add 
label define countycd 26125 "Oakland, MI", add 
label define countycd 26139 "Ottawa, MI", add 
label define countycd 26143 "Roscommon, MI", add 
label define countycd 26145 "Saginaw, MI", add 
label define countycd 26147 "St. Clair, MI", add 
label define countycd 26149 "St. Joseph, MI", add 
label define countycd 26155 "Shiawassee, MI", add 
label define countycd 26157 "Tuscola, MI", add 
label define countycd 26161 "Washtenaw, MI", add 
label define countycd 26163 "Wayne, MI", add 
label define countycd 26165 "Wexford, MI", add 
label define countycd 27003 "Anoka, MN", add 
label define countycd 27005 "Becker, MN", add 
label define countycd 27007 "Beltrami, MN", add 
label define countycd 27013 "Blue Earth, MN", add 
label define countycd 27015 "Brown, MN", add 
label define countycd 27017 "Carlton, MN", add 
label define countycd 27021 "Cass, MN", add 
label define countycd 27025 "Chisago, MN", add 
label define countycd 27027 "Clay, MN", add 
label define countycd 27035 "Crow Wing, MN", add 
label define countycd 27037 "Dakota, MN", add 
label define countycd 27041 "Douglas, MN", add 
label define countycd 27049 "Goodhue, MN", add 
label define countycd 27053 "Hennepin, MN", add 
label define countycd 27059 "Isanti, MN", add 
label define countycd 27061 "Itasca, MN", add 
label define countycd 27067 "Kandiyohi, MN", add 
label define countycd 27071 "Koochiching, MN", add 
label define countycd 27083 "Lyon, MN", add 
label define countycd 27085 "McLeod, MN", add 
label define countycd 27087 "Mahnomen, MN", add 
label define countycd 27099 "Mower, MN", add 
label define countycd 27103 "Nicollet, MN", add 
label define countycd 27109 "Olmsted, MN", add 
label define countycd 27111 "Otter Tail, MN", add 
label define countycd 27113 "Pennington, MN", add 
label define countycd 27115 "Pine, MN", add 
label define countycd 27119 "Polk, MN", add 
label define countycd 27123 "Ramsey, MN", add 
label define countycd 27131 "Rice, MN", add 
label define countycd 27137 "St. Louis, MN", add 
label define countycd 27139 "Scott, MN", add 
label define countycd 27141 "Sherburne, MN", add 
label define countycd 27145 "Stearns, MN", add 
label define countycd 27149 "Stevens, MN", add 
label define countycd 27159 "Wadena, MN", add 
label define countycd 27163 "Washington, MN", add 
label define countycd 27169 "Winona, MN", add 
label define countycd 27173 "Yellow Medicine, MN", add 
label define countycd 28001 "Adams, MS", add 
label define countycd 28003 "Alcorn, MS", add 
label define countycd 28007 "Attala, MS", add 
label define countycd 28011 "Bolivar, MS", add 
label define countycd 28021 "Claiborne, MS", add 
label define countycd 28025 "Clay, MS", add 
label define countycd 28027 "Coahoma, MS", add 
label define countycd 28029 "Copiah, MS", add 
label define countycd 28033 "DeSoto, MS", add 
label define countycd 28035 "Forrest, MS", add 
label define countycd 28043 "Grenada, MS", add 
label define countycd 28047 "Harrison, MS", add 
label define countycd 28049 "Hinds, MS", add 
label define countycd 28051 "Holmes, MS", add 
label define countycd 28057 "Itawamba, MS", add 
label define countycd 28059 "Jackson, MS", add 
label define countycd 28067 "Jones, MS", add 
label define countycd 28069 "Kemper, MS", add 
label define countycd 28071 "Lafayette, MS", add 
label define countycd 28073 "Lamar, MS", add 
label define countycd 28075 "Lauderdale, MS", add 
label define countycd 28079 "Leake, MS", add 
label define countycd 28081 "Lee, MS", add 
label define countycd 28083 "Leflore, MS", add 
label define countycd 28087 "Lowndes, MS", add 
label define countycd 28089 "Madison, MS", add 
label define countycd 28093 "Marshall, MS", add 
label define countycd 28101 "Newton, MS", add 
label define countycd 28105 "Oktibbeha, MS", add 
label define countycd 28109 "Pearl River, MS", add 
label define countycd 28113 "Pike, MS", add 
label define countycd 28117 "Prentiss, MS", add 
label define countycd 28121 "Rankin, MS", add 
label define countycd 28127 "Simpson, MS", add 
label define countycd 28131 "Stone, MS", add 
label define countycd 28133 "Sunflower, MS", add 
label define countycd 28137 "Tate, MS", add 
label define countycd 28139 "Tippah, MS", add 
label define countycd 28151 "Washington, MS", add 
label define countycd 29001 "Adair, MO", add 
label define countycd 29019 "Boone, MO", add 
label define countycd 29021 "Buchanan, MO", add 
label define countycd 29023 "Butler, MO", add 
label define countycd 29027 "Callaway, MO", add 
label define countycd 29029 "Camden, MO", add 
label define countycd 29031 "Cape Girardeau, MO", add 
label define countycd 29037 "Cass, MO", add 
label define countycd 29047 "Clay, MO", add 
label define countycd 29051 "Cole, MO", add 
label define countycd 29053 "Cooper, MO", add 
label define countycd 29069 "Dunklin, MO", add 
label define countycd 29071 "Franklin, MO", add 
label define countycd 29077 "Greene, MO", add 
label define countycd 29079 "Grundy, MO", add 
label define countycd 29083 "Henry, MO", add 
label define countycd 29089 "Howard, MO", add 
label define countycd 29091 "Howell, MO", add 
label define countycd 29095 "Jackson, MO", add 
label define countycd 29097 "Jasper, MO", add 
label define countycd 29099 "Jefferson, MO", add 
label define countycd 29101 "Johnson, MO", add 
label define countycd 29105 "Laclede, MO", add 
label define countycd 29107 "Lafayette, MO", add 
label define countycd 29111 "Lewis, MO", add 
label define countycd 29117 "Livingston, MO", add 
label define countycd 29127 "Marion, MO", add 
label define countycd 29131 "Miller, MO", add 
label define countycd 29145 "Newton, MO", add 
label define countycd 29147 "Nodaway, MO", add 
label define countycd 29151 "Osage, MO", add 
label define countycd 29155 "Pemiscot, MO", add 
label define countycd 29159 "Pettis, MO", add 
label define countycd 29161 "Phelps, MO", add 
label define countycd 29163 "Pike, MO", add 
label define countycd 29165 "Platte, MO", add 
label define countycd 29167 "Polk, MO", add 
label define countycd 29169 "Pulaski, MO", add 
label define countycd 29175 "Randolph, MO", add 
label define countycd 29183 "St. Charles, MO", add 
label define countycd 29187 "St. Francois, MO", add 
label define countycd 29189 "St. Louis, MO", add 
label define countycd 29195 "Saline, MO", add 
label define countycd 29201 "Scott, MO", add 
label define countycd 29213 "Taney, MO", add 
label define countycd 29215 "Texas, MO", add 
label define countycd 29217 "Vernon, MO", add 
label define countycd 29510 "St. Louis city, MO", add 
label define countycd 30001 "Beaverhead, MT", add 
label define countycd 30003 "Big Horn, MT", add 
label define countycd 30005 "Blaine, MT", add 
label define countycd 30013 "Cascade, MT", add 
label define countycd 30017 "Custer, MT", add 
label define countycd 30021 "Dawson, MT", add 
label define countycd 30029 "Flathead, MT", add 
label define countycd 30031 "Gallatin, MT", add 
label define countycd 30035 "Glacier, MT", add 
label define countycd 30041 "Hill, MT", add 
label define countycd 30047 "Lake, MT", add 
label define countycd 30049 "Lewis and Clark, MT", add 
label define countycd 30063 "Missoula, MT", add 
label define countycd 30085 "Roosevelt, MT", add 
label define countycd 30087 "Rosebud, MT", add 
label define countycd 30093 "Silver Bow, MT", add 
label define countycd 30111 "Yellowstone, MT", add 
label define countycd 31001 "Adams, NE", add 
label define countycd 31019 "Buffalo, NE", add 
label define countycd 31045 "Dawes, NE", add 
label define countycd 31053 "Dodge, NE", add 
label define countycd 31055 "Douglas, NE", add 
label define countycd 31063 "Frontier, NE", add 
label define countycd 31079 "Hall, NE", add 
label define countycd 31109 "Lancaster, NE", add 
label define countycd 31111 "Lincoln, NE", add 
label define countycd 31119 "Madison, NE", add 
label define countycd 31127 "Nemaha, NE", add 
label define countycd 31151 "Saline, NE", add 
label define countycd 31153 "Sarpy, NE", add 
label define countycd 31157 "Scotts Bluff, NE", add 
label define countycd 31159 "Seward, NE", add 
label define countycd 31173 "Thurston, NE", add 
label define countycd 31177 "Washington, NE", add 
label define countycd 31179 "Wayne, NE", add 
label define countycd 31185 "York, NE", add 
label define countycd 32003 "Clark, NV", add 
label define countycd 32007 "Elko, NV", add 
label define countycd 32031 "Washoe, NV", add 
label define countycd 32510 "Carson City, NV", add 
label define countycd 33001 "Belknap, NH", add 
label define countycd 33005 "Cheshire, NH", add 
label define countycd 33007 "Coos, NH", add 
label define countycd 33009 "Grafton, NH", add 
label define countycd 33011 "Hillsborough, NH", add 
label define countycd 33013 "Merrimack, NH", add 
label define countycd 33015 "Rockingham, NH", add 
label define countycd 33017 "Strafford, NH", add 
label define countycd 33019 "Sullivan, NH", add 
label define countycd 34001 "Atlantic, NJ", add 
label define countycd 34003 "Bergen, NJ", add 
label define countycd 34005 "Burlington, NJ", add 
label define countycd 34007 "Camden, NJ", add 
label define countycd 34011 "Cumberland, NJ", add 
label define countycd 34013 "Essex, NJ", add 
label define countycd 34015 "Gloucester, NJ", add 
label define countycd 34017 "Hudson, NJ", add 
label define countycd 34021 "Mercer, NJ", add 
label define countycd 34023 "Middlesex, NJ", add 
label define countycd 34025 "Monmouth, NJ", add 
label define countycd 34027 "Morris, NJ", add 
label define countycd 34029 "Ocean, NJ", add 
label define countycd 34031 "Passaic, NJ", add 
label define countycd 34033 "Salem, NJ", add 
label define countycd 34035 "Somerset, NJ", add 
label define countycd 34037 "Sussex, NJ", add 
label define countycd 34039 "Union, NJ", add 
label define countycd 34041 "Warren, NJ", add 
label define countycd 35001 "Bernalillo, NM", add 
label define countycd 35005 "Chaves, NM", add 
label define countycd 35006 "Cibola, NM", add 
label define countycd 35009 "Curry, NM", add 
label define countycd 35013 "Doña Ana, NM", add 
label define countycd 35015 "Eddy, NM", add 
label define countycd 35017 "Grant, NM", add 
label define countycd 35025 "Lea, NM", add 
label define countycd 35027 "Lincoln, NM", add 
label define countycd 35028 "Los Alamos, NM", add 
label define countycd 35031 "McKinley, NM", add 
label define countycd 35035 "Otero, NM", add 
label define countycd 35037 "Quay, NM", add 
label define countycd 35039 "Rio Arriba, NM", add 
label define countycd 35041 "Roosevelt, NM", add 
label define countycd 35043 "Sandoval, NM", add 
label define countycd 35045 "San Juan, NM", add 
label define countycd 35047 "San Miguel, NM", add 
label define countycd 35049 "Santa Fe, NM", add 
label define countycd 35053 "Socorro, NM", add 
label define countycd 35055 "Taos, NM", add 
label define countycd 35061 "Valencia, NM", add 
label define countycd 36001 "Albany, NY", add 
label define countycd 36003 "Allegany, NY", add 
label define countycd 36005 "Bronx, NY", add 
label define countycd 36007 "Broome, NY", add 
label define countycd 36009 "Cattaraugus, NY", add 
label define countycd 36011 "Cayuga, NY", add 
label define countycd 36013 "Chautauqua, NY", add 
label define countycd 36015 "Chemung, NY", add 
label define countycd 36017 "Chenango, NY", add 
label define countycd 36019 "Clinton, NY", add 
label define countycd 36021 "Columbia, NY", add 
label define countycd 36023 "Cortland, NY", add 
label define countycd 36025 "Delaware, NY", add 
label define countycd 36027 "Dutchess, NY", add 
label define countycd 36029 "Erie, NY", add 
label define countycd 36031 "Essex, NY", add 
label define countycd 36033 "Franklin, NY", add 
label define countycd 36037 "Genesee, NY", add 
label define countycd 36043 "Herkimer, NY", add 
label define countycd 36045 "Jefferson, NY", add 
label define countycd 36047 "Kings, NY", add 
label define countycd 36051 "Livingston, NY", add 
label define countycd 36053 "Madison, NY", add 
label define countycd 36055 "Monroe, NY", add 
label define countycd 36057 "Montgomery, NY", add 
label define countycd 36059 "Nassau, NY", add 
label define countycd 36061 "New York, NY", add 
label define countycd 36063 "Niagara, NY", add 
label define countycd 36065 "Oneida, NY", add 
label define countycd 36067 "Onondaga, NY", add 
label define countycd 36069 "Ontario, NY", add 
label define countycd 36071 "Orange, NY", add 
label define countycd 36075 "Oswego, NY", add 
label define countycd 36077 "Otsego, NY", add 
label define countycd 36081 "Queens, NY", add 
label define countycd 36083 "Rensselaer, NY", add 
label define countycd 36085 "Richmond, NY", add 
label define countycd 36087 "Rockland, NY", add 
label define countycd 36089 "St. Lawrence, NY", add 
label define countycd 36091 "Saratoga, NY", add 
label define countycd 36093 "Schenectady, NY", add 
label define countycd 36095 "Schoharie, NY", add 
label define countycd 36099 "Seneca, NY", add 
label define countycd 36101 "Steuben, NY", add 
label define countycd 36103 "Suffolk, NY", add 
label define countycd 36105 "Sullivan, NY", add 
label define countycd 36109 "Tompkins, NY", add 
label define countycd 36111 "Ulster, NY", add 
label define countycd 36113 "Warren, NY", add 
label define countycd 36117 "Wayne, NY", add 
label define countycd 36119 "Westchester, NY", add 
label define countycd 36123 "Yates, NY", add 
label define countycd 37001 "Alamance, NC", add 
label define countycd 37007 "Anson, NC", add 
label define countycd 37011 "Avery, NC", add 
label define countycd 37013 "Beaufort, NC", add 
label define countycd 37017 "Bladen, NC", add 
label define countycd 37019 "Brunswick, NC", add 
label define countycd 37021 "Buncombe, NC", add 
label define countycd 37023 "Burke, NC", add 
label define countycd 37025 "Cabarrus, NC", add 
label define countycd 37027 "Caldwell, NC", add 
label define countycd 37031 "Carteret, NC", add 
label define countycd 37035 "Catawba, NC", add 
label define countycd 37039 "Cherokee, NC", add 
label define countycd 37045 "Cleveland, NC", add 
label define countycd 37047 "Columbus, NC", add 
label define countycd 37049 "Craven, NC", add 
label define countycd 37051 "Cumberland, NC", add 
label define countycd 37057 "Davidson, NC", add 
label define countycd 37061 "Duplin, NC", add 
label define countycd 37063 "Durham, NC", add 
label define countycd 37065 "Edgecombe, NC", add 
label define countycd 37067 "Forsyth, NC", add 
label define countycd 37069 "Franklin, NC", add 
label define countycd 37071 "Gaston, NC", add 
label define countycd 37081 "Guilford, NC", add 
label define countycd 37083 "Halifax, NC", add 
label define countycd 37085 "Harnett, NC", add 
label define countycd 37087 "Haywood, NC", add 
label define countycd 37089 "Henderson, NC", add 
label define countycd 37091 "Hertford, NC", add 
label define countycd 37097 "Iredell, NC", add 
label define countycd 37099 "Jackson, NC", add 
label define countycd 37101 "Johnston, NC", add 
label define countycd 37105 "Lee, NC", add 
label define countycd 37107 "Lenoir, NC", add 
label define countycd 37111 "McDowell, NC", add 
label define countycd 37115 "Madison, NC", add 
label define countycd 37117 "Martin, NC", add 
label define countycd 37119 "Mecklenburg, NC", add 
label define countycd 37123 "Montgomery, NC", add 
label define countycd 37125 "Moore, NC", add 
label define countycd 37127 "Nash, NC", add 
label define countycd 37129 "New Hanover, NC", add 
label define countycd 37133 "Onslow, NC", add 
label define countycd 37135 "Orange, NC", add 
label define countycd 37137 "Pamlico, NC", add 
label define countycd 37139 "Pasquotank, NC", add 
label define countycd 37145 "Person, NC", add 
label define countycd 37147 "Pitt, NC", add 
label define countycd 37151 "Randolph, NC", add 
label define countycd 37153 "Richmond, NC", add 
label define countycd 37155 "Robeson, NC", add 
label define countycd 37157 "Rockingham, NC", add 
label define countycd 37159 "Rowan, NC", add 
label define countycd 37161 "Rutherford, NC", add 
label define countycd 37163 "Sampson, NC", add 
label define countycd 37165 "Scotland, NC", add 
label define countycd 37167 "Stanly, NC", add 
label define countycd 37171 "Surry, NC", add 
label define countycd 37175 "Transylvania, NC", add 
label define countycd 37179 "Union, NC", add 
label define countycd 37181 "Vance, NC", add 
label define countycd 37183 "Wake, NC", add 
label define countycd 37189 "Watauga, NC", add 
label define countycd 37191 "Wayne, NC", add 
label define countycd 37193 "Wilkes, NC", add 
label define countycd 37195 "Wilson, NC", add 
label define countycd 38003 "Barnes, ND", add 
label define countycd 38009 "Bottineau, ND", add 
label define countycd 38015 "Burleigh, ND", add 
label define countycd 38017 "Cass, ND", add 
label define countycd 38021 "Dickey, ND", add 
label define countycd 38035 "Grand Forks, ND", add 
label define countycd 38061 "Mountrail, ND", add 
label define countycd 38071 "Ramsey, ND", add 
label define countycd 38077 "Richland, ND", add 
label define countycd 38079 "Rolette, ND", add 
label define countycd 38085 "Sioux, ND", add 
label define countycd 38089 "Stark, ND", add 
label define countycd 38093 "Stutsman, ND", add 
label define countycd 38097 "Traill, ND", add 
label define countycd 38101 "Ward, ND", add 
label define countycd 38105 "Williams, ND", add 
label define countycd 39003 "Allen, OH", add 
label define countycd 39005 "Ashland, OH", add 
label define countycd 39007 "Ashtabula, OH", add 
label define countycd 39009 "Athens, OH", add 
label define countycd 39013 "Belmont, OH", add 
label define countycd 39015 "Brown, OH", add 
label define countycd 39017 "Butler, OH", add 
label define countycd 39021 "Champaign, OH", add 
label define countycd 39023 "Clark, OH", add 
label define countycd 39025 "Clermont, OH", add 
label define countycd 39027 "Clinton, OH", add 
label define countycd 39029 "Columbiana, OH", add 
label define countycd 39035 "Cuyahoga, OH", add 
label define countycd 39039 "Defiance, OH", add 
label define countycd 39041 "Delaware, OH", add 
label define countycd 39043 "Erie, OH", add 
label define countycd 39045 "Fairfield, OH", add 
label define countycd 39049 "Franklin, OH", add 
label define countycd 39053 "Gallia, OH", add 
label define countycd 39055 "Geauga, OH", add 
label define countycd 39057 "Greene, OH", add 
label define countycd 39059 "Guernsey, OH", add 
label define countycd 39061 "Hamilton, OH", add 
label define countycd 39063 "Hancock, OH", add 
label define countycd 39065 "Hardin, OH", add 
label define countycd 39069 "Henry, OH", add 
label define countycd 39071 "Highland, OH", add 
label define countycd 39075 "Holmes, OH", add 
label define countycd 39079 "Jackson, OH", add 
label define countycd 39081 "Jefferson, OH", add 
label define countycd 39083 "Knox, OH", add 
label define countycd 39085 "Lake, OH", add 
label define countycd 39087 "Lawrence, OH", add 
label define countycd 39089 "Licking, OH", add 
label define countycd 39091 "Logan, OH", add 
label define countycd 39093 "Lorain, OH", add 
label define countycd 39095 "Lucas, OH", add 
label define countycd 39097 "Madison, OH", add 
label define countycd 39099 "Mahoning, OH", add 
label define countycd 39101 "Marion, OH", add 
label define countycd 39103 "Medina, OH", add 
label define countycd 39107 "Mercer, OH", add 
label define countycd 39109 "Miami, OH", add 
label define countycd 39113 "Montgomery, OH", add 
label define countycd 39119 "Muskingum, OH", add 
label define countycd 39129 "Pickaway, OH", add 
label define countycd 39131 "Pike, OH", add 
label define countycd 39133 "Portage, OH", add 
label define countycd 39137 "Putnam, OH", add 
label define countycd 39139 "Richland, OH", add 
label define countycd 39141 "Ross, OH", add 
label define countycd 39143 "Sandusky, OH", add 
label define countycd 39145 "Scioto, OH", add 
label define countycd 39147 "Seneca, OH", add 
label define countycd 39151 "Stark, OH", add 
label define countycd 39153 "Summit, OH", add 
label define countycd 39155 "Trumbull, OH", add 
label define countycd 39157 "Tuscarawas, OH", add 
label define countycd 39161 "Van Wert, OH", add 
label define countycd 39165 "Warren, OH", add 
label define countycd 39167 "Washington, OH", add 
label define countycd 39169 "Wayne, OH", add 
label define countycd 39173 "Wood, OH", add 
label define countycd 40001 "Adair, OK", add 
label define countycd 40005 "Atoka, OK", add 
label define countycd 4001 "Apache, AZ", add 
label define countycd 40013 "Bryan, OK", add 
label define countycd 40015 "Caddo, OK", add 
label define countycd 40017 "Canadian, OK", add 
label define countycd 40019 "Carter, OK", add 
label define countycd 40021 "Cherokee, OK", add 
label define countycd 40023 "Choctaw, OK", add 
label define countycd 40027 "Cleveland, OK", add 
label define countycd 4003 "Cochise, AZ", add 
label define countycd 40031 "Comanche, OK", add 
label define countycd 40037 "Creek, OK", add 
label define countycd 40039 "Custer, OK", add 
label define countycd 40041 "Delaware, OK", add 
label define countycd 40047 "Garfield, OK", add 
label define countycd 4005 "Coconino, AZ", add 
label define countycd 40051 "Grady, OK", add 
label define countycd 40061 "Haskell, OK", add 
label define countycd 40063 "Hughes, OK", add 
label define countycd 40065 "Jackson, OK", add 
label define countycd 40069 "Johnston, OK", add 
label define countycd 40071 "Kay, OK", add 
label define countycd 40073 "Kingfisher, OK", add 
label define countycd 40077 "Latimer, OK", add 
label define countycd 40079 "Le Flore, OK", add 
label define countycd 40083 "Logan, OK", add 
label define countycd 40087 "McClain, OK", add 
label define countycd 40089 "McCurtain, OK", add 
label define countycd 4009 "Graham, AZ", add 
label define countycd 40093 "Major, OK", add 
label define countycd 40097 "Mayes, OK", add 
label define countycd 40101 "Muskogee, OK", add 
label define countycd 40109 "Oklahoma, OK", add 
label define countycd 40111 "Okmulgee, OK", add 
label define countycd 40115 "Ottawa, OK", add 
label define countycd 40119 "Payne, OK", add 
label define countycd 40121 "Pittsburg, OK", add 
label define countycd 40123 "Pontotoc, OK", add 
label define countycd 40125 "Pottawatomie, OK", add 
label define countycd 4013 "Maricopa, AZ", add 
label define countycd 40131 "Rogers, OK", add 
label define countycd 40133 "Seminole, OK", add 
label define countycd 40135 "Sequoyah, OK", add 
label define countycd 40137 "Stephens, OK", add 
label define countycd 40139 "Texas, OK", add 
label define countycd 40143 "Tulsa, OK", add 
label define countycd 40147 "Washington, OK", add 
label define countycd 40149 "Washita, OK", add 
label define countycd 4015 "Mohave, AZ", add 
label define countycd 40151 "Woods, OK", add 
label define countycd 40153 "Woodward, OK", add 
label define countycd 4017 "Navajo, AZ", add 
label define countycd 4019 "Pima, AZ", add 
label define countycd 4021 "Pinal, AZ", add 
label define countycd 4025 "Yavapai, AZ", add 
label define countycd 4027 "Yuma, AZ", add 
label define countycd 41003 "Benton, OR", add 
label define countycd 41005 "Clackamas, OR", add 
label define countycd 41007 "Clatsop, OR", add 
label define countycd 41011 "Coos, OR", add 
label define countycd 41017 "Deschutes, OR", add 
label define countycd 41019 "Douglas, OR", add 
label define countycd 41029 "Jackson, OR", add 
label define countycd 41033 "Josephine, OR", add 
label define countycd 41035 "Klamath, OR", add 
label define countycd 41039 "Lane, OR", add 
label define countycd 41041 "Lincoln, OR", add 
label define countycd 41043 "Linn, OR", add 
label define countycd 41045 "Malheur, OR", add 
label define countycd 41047 "Marion, OR", add 
label define countycd 41051 "Multnomah, OR", add 
label define countycd 41053 "Polk, OR", add 
label define countycd 41057 "Tillamook, OR", add 
label define countycd 41059 "Umatilla, OR", add 
label define countycd 41061 "Union, OR", add 
label define countycd 41065 "Wasco, OR", add 
label define countycd 41067 "Washington, OR", add 
label define countycd 41071 "Yamhill, OR", add 
label define countycd 42001 "Adams, PA", add 
label define countycd 42003 "Allegheny, PA", add 
label define countycd 42005 "Armstrong, PA", add 
label define countycd 42007 "Beaver, PA", add 
label define countycd 42011 "Berks, PA", add 
label define countycd 42013 "Blair, PA", add 
label define countycd 42015 "Bradford, PA", add 
label define countycd 42017 "Bucks, PA", add 
label define countycd 42019 "Butler, PA", add 
label define countycd 42021 "Cambria, PA", add 
label define countycd 42027 "Centre, PA", add 
label define countycd 42029 "Chester, PA", add 
label define countycd 42031 "Clarion, PA", add 
label define countycd 42033 "Clearfield, PA", add 
label define countycd 42035 "Clinton, PA", add 
label define countycd 42037 "Columbia, PA", add 
label define countycd 42039 "Crawford, PA", add 
label define countycd 42041 "Cumberland, PA", add 
label define countycd 42043 "Dauphin, PA", add 
label define countycd 42045 "Delaware, PA", add 
label define countycd 42049 "Erie, PA", add 
label define countycd 42051 "Fayette, PA", add 
label define countycd 42055 "Franklin, PA", add 
label define countycd 42059 "Greene, PA", add 
label define countycd 42061 "Huntingdon, PA", add 
label define countycd 42063 "Indiana, PA", add 
label define countycd 42065 "Jefferson, PA", add 
label define countycd 42069 "Lackawanna, PA", add 
label define countycd 42071 "Lancaster, PA", add 
label define countycd 42073 "Lawrence, PA", add 
label define countycd 42075 "Lebanon, PA", add 
label define countycd 42077 "Lehigh, PA", add 
label define countycd 42079 "Luzerne, PA", add 
label define countycd 42081 "Lycoming, PA", add 
label define countycd 42083 "McKean, PA", add 
label define countycd 42085 "Mercer, PA", add 
label define countycd 42087 "Mifflin, PA", add 
label define countycd 42089 "Monroe, PA", add 
label define countycd 42091 "Montgomery, PA", add 
label define countycd 42095 "Northampton, PA", add 
label define countycd 42097 "Northumberland, PA", add 
label define countycd 42101 "Philadelphia, PA", add 
label define countycd 42107 "Schuylkill, PA", add 
label define countycd 42109 "Snyder, PA", add 
label define countycd 42117 "Tioga, PA", add 
label define countycd 42119 "Union, PA", add 
label define countycd 42121 "Venango, PA", add 
label define countycd 42125 "Washington, PA", add 
label define countycd 42127 "Wayne, PA", add 
label define countycd 42129 "Westmoreland, PA", add 
label define countycd 42133 "York, PA", add 
label define countycd 44001 "Bristol, RI", add 
label define countycd 44003 "Kent, RI", add 
label define countycd 44005 "Newport, RI", add 
label define countycd 44007 "Providence, RI", add 
label define countycd 44009 "Washington, RI", add 
label define countycd 45001 "Abbeville, SC", add 
label define countycd 45003 "Aiken, SC", add 
label define countycd 45005 "Allendale, SC", add 
label define countycd 45007 "Anderson, SC", add 
label define countycd 45009 "Bamberg, SC", add 
label define countycd 45013 "Beaufort, SC", add 
label define countycd 45015 "Berkeley, SC", add 
label define countycd 45019 "Charleston, SC", add 
label define countycd 45021 "Cherokee, SC", add 
label define countycd 45025 "Chesterfield, SC", add 
label define countycd 45031 "Darlington, SC", add 
label define countycd 45035 "Dorchester, SC", add 
label define countycd 45041 "Florence, SC", add 
label define countycd 45045 "Greenville, SC", add 
label define countycd 45047 "Greenwood, SC", add 
label define countycd 45051 "Horry, SC", add 
label define countycd 45055 "Kershaw, SC", add 
label define countycd 45057 "Lancaster, SC", add 
label define countycd 45059 "Laurens, SC", add 
label define countycd 45063 "Lexington, SC", add 
label define countycd 45071 "Newberry, SC", add 
label define countycd 45075 "Orangeburg, SC", add 
label define countycd 45077 "Pickens, SC", add 
label define countycd 45079 "Richland, SC", add 
label define countycd 45083 "Spartanburg, SC", add 
label define countycd 45085 "Sumter, SC", add 
label define countycd 45087 "Union, SC", add 
label define countycd 45089 "Williamsburg, SC", add 
label define countycd 45091 "York, SC", add 
label define countycd 46011 "Brookings, SD", add 
label define countycd 46013 "Brown, SD", add 
label define countycd 46027 "Clay, SD", add 
label define countycd 46029 "Codington, SD", add 
label define countycd 46035 "Davison, SD", add 
label define countycd 46079 "Lake, SD", add 
label define countycd 46081 "Lawrence, SD", add 
label define countycd 46083 "Lincoln, SD", add 
label define countycd 46093 "Meade, SD", add 
label define countycd 46099 "Minnehaha, SD", add 
label define countycd 46103 "Pennington, SD", add 
label define countycd 46109 "Roberts, SD", add 
label define countycd 46113 "Shannon, SD", add 
label define countycd 46121 "Todd, SD", add 
label define countycd 46135 "Yankton, SD", add 
label define countycd 47003 "Bedford, TN", add 
label define countycd 47009 "Blount, TN", add 
label define countycd 47011 "Bradley, TN", add 
label define countycd 47013 "Campbell, TN", add 
label define countycd 47017 "Carroll, TN", add 
label define countycd 47019 "Carter, TN", add 
label define countycd 47023 "Chester, TN", add 
label define countycd 47025 "Claiborne, TN", add 
label define countycd 47035 "Cumberland, TN", add 
label define countycd 47037 "Davidson, TN", add 
label define countycd 47043 "Dickson, TN", add 
label define countycd 47045 "Dyer, TN", add 
label define countycd 47051 "Franklin, TN", add 
label define countycd 47053 "Gibson, TN", add 
label define countycd 47055 "Giles, TN", add 
label define countycd 47059 "Greene, TN", add 
label define countycd 47063 "Hamblen, TN", add 
label define countycd 47065 "Hamilton, TN", add 
label define countycd 47069 "Hardeman, TN", add 
label define countycd 47071 "Hardin, TN", add 
label define countycd 47077 "Henderson, TN", add 
label define countycd 47079 "Henry, TN", add 
label define countycd 47089 "Jefferson, TN", add 
label define countycd 47093 "Knox, TN", add 
label define countycd 47097 "Lauderdale, TN", add 
label define countycd 47099 "Lawrence, TN", add 
label define countycd 47101 "Lewis, TN", add 
label define countycd 47103 "Lincoln, TN", add 
label define countycd 47107 "McMinn, TN", add 
label define countycd 47109 "McNairy, TN", add 
label define countycd 47113 "Madison, TN", add 
label define countycd 47119 "Maury, TN", add 
label define countycd 47123 "Monroe, TN", add 
label define countycd 47125 "Montgomery, TN", add 
label define countycd 47127 "Moore, TN", add 
label define countycd 47133 "Overton, TN", add 
label define countycd 47141 "Putnam, TN", add 
label define countycd 47143 "Rhea, TN", add 
label define countycd 47145 "Roane, TN", add 
label define countycd 47149 "Rutherford, TN", add 
label define countycd 47151 "Scott, TN", add 
label define countycd 47157 "Shelby, TN", add 
label define countycd 47163 "Sullivan, TN", add 
label define countycd 47165 "Sumner, TN", add 
label define countycd 47167 "Tipton, TN", add 
label define countycd 47169 "Trousdale, TN", add 
label define countycd 47177 "Warren, TN", add 
label define countycd 47179 "Washington, TN", add 
label define countycd 47183 "Weakley, TN", add 
label define countycd 47187 "Williamson, TN", add 
label define countycd 47189 "Wilson, TN", add 
label define countycd 48005 "Angelina, TX", add 
label define countycd 48025 "Bee, TX", add 
label define countycd 48027 "Bell, TX", add 
label define countycd 48029 "Bexar, TX", add 
label define countycd 48037 "Bowie, TX", add 
label define countycd 48039 "Brazoria, TX", add 
label define countycd 48041 "Brazos, TX", add 
label define countycd 48043 "Brewster, TX", add 
label define countycd 48049 "Brown, TX", add 
label define countycd 48061 "Cameron, TX", add 
label define countycd 48073 "Cherokee, TX", add 
label define countycd 48085 "Collin, TX", add 
label define countycd 48091 "Comal, TX", add 
label define countycd 48097 "Cooke, TX", add 
label define countycd 48099 "Coryell, TX", add 
label define countycd 48113 "Dallas, TX", add 
label define countycd 48121 "Denton, TX", add 
label define countycd 48129 "Donley, TX", add 
label define countycd 48133 "Eastland, TX", add 
label define countycd 48135 "Ector, TX", add 
label define countycd 48139 "Ellis, TX", add 
label define countycd 48141 "El Paso, TX", add 
label define countycd 48143 "Erath, TX", add 
label define countycd 48167 "Galveston, TX", add 
label define countycd 48181 "Grayson, TX", add 
label define countycd 48183 "Gregg, TX", add 
label define countycd 48187 "Guadalupe, TX", add 
label define countycd 48189 "Hale, TX", add 
label define countycd 48199 "Hardin, TX", add 
label define countycd 48201 "Harris, TX", add 
label define countycd 48203 "Harrison, TX", add 
label define countycd 48209 "Hays, TX", add 
label define countycd 48213 "Henderson, TX", add 
label define countycd 48215 "Hidalgo, TX", add 
label define countycd 48217 "Hill, TX", add 
label define countycd 48219 "Hockley, TX", add 
label define countycd 48227 "Howard, TX", add 
label define countycd 48231 "Hunt, TX", add 
label define countycd 48233 "Hutchinson, TX", add 
label define countycd 48241 "Jasper, TX", add 
label define countycd 48245 "Jefferson, TX", add 
label define countycd 48251 "Johnson, TX", add 
label define countycd 48257 "Kaufman, TX", add 
label define countycd 48265 "Kerr, TX", add 
label define countycd 48273 "Kleberg, TX", add 
label define countycd 48277 "Lamar, TX", add 
label define countycd 48303 "Lubbock, TX", add 
label define countycd 48309 "McLennan, TX", add 
label define countycd 48323 "Maverick, TX", add 
label define countycd 48329 "Midland, TX", add 
label define countycd 48339 "Montgomery, TX", add 
label define countycd 48347 "Nacogdoches, TX", add 
label define countycd 48349 "Navarro, TX", add 
label define countycd 48353 "Nolan, TX", add 
label define countycd 48355 "Nueces, TX", add 
label define countycd 48361 "Orange, TX", add 
label define countycd 48365 "Panola, TX", add 
label define countycd 48367 "Parker, TX", add 
label define countycd 48375 "Potter, TX", add 
label define countycd 48381 "Randall, TX", add 
label define countycd 48415 "Scurry, TX", add 
label define countycd 48423 "Smith, TX", add 
label define countycd 48439 "Tarrant, TX", add 
label define countycd 48441 "Taylor, TX", add 
label define countycd 48449 "Titus, TX", add 
label define countycd 48451 "Tom Green, TX", add 
label define countycd 48453 "Travis, TX", add 
label define countycd 48463 "Uvalde, TX", add 
label define countycd 48465 "Val Verde, TX", add 
label define countycd 48469 "Victoria, TX", add 
label define countycd 48471 "Walker, TX", add 
label define countycd 48473 "Waller, TX", add 
label define countycd 48477 "Washington, TX", add 
label define countycd 48479 "Webb, TX", add 
label define countycd 48481 "Wharton, TX", add 
label define countycd 48485 "Wichita, TX", add 
label define countycd 48487 "Wilbarger, TX", add 
label define countycd 48491 "Williamson, TX", add 
label define countycd 48499 "Wood, TX", add 
label define countycd 49005 "Cache, UT", add 
label define countycd 49007 "Carbon, UT", add 
label define countycd 49011 "Davis, UT", add 
label define countycd 49013 "Duchesne, UT", add 
label define countycd 49021 "Iron, UT", add 
label define countycd 49035 "Salt Lake, UT", add 
label define countycd 49039 "Sanpete, UT", add 
label define countycd 49041 "Sevier, UT", add 
label define countycd 49049 "Utah, UT", add 
label define countycd 49053 "Washington, UT", add 
label define countycd 49057 "Weber, UT", add 
label define countycd 50001 "Addison, VT", add 
label define countycd 50003 "Bennington, VT", add 
label define countycd 50005 "Caledonia, VT", add 
label define countycd 50007 "Chittenden, VT", add 
label define countycd 50015 "Lamoille, VT", add 
label define countycd 50019 "Orleans, VT", add 
label define countycd 50021 "Rutland, VT", add 
label define countycd 50023 "Washington, VT", add 
label define countycd 50025 "Windham, VT", add 
label define countycd 50027 "Windsor, VT", add 
label define countycd 5003 "Ashley, AR", add 
label define countycd 5005 "Baxter, AR", add 
label define countycd 5007 "Benton, AR", add 
label define countycd 5009 "Boone, AR", add 
label define countycd 5019 "Clark, AR", add 
label define countycd 5027 "Columbia, AR", add 
label define countycd 5029 "Conway, AR", add 
label define countycd 5031 "Craighead, AR", add 
label define countycd 5035 "Crittenden, AR", add 
label define countycd 5043 "Drew, AR", add 
label define countycd 5045 "Faulkner, AR", add 
label define countycd 5051 "Garland, AR", add 
label define countycd 5055 "Greene, AR", add 
label define countycd 5057 "Hempstead, AR", add 
label define countycd 5059 "Hot Spring, AR", add 
label define countycd 5063 "Independence, AR", add 
label define countycd 5065 "Izard, AR", add 
label define countycd 5067 "Jackson, AR", add 
label define countycd 5069 "Jefferson, AR", add 
label define countycd 5071 "Johnson, AR", add 
label define countycd 5075 "Lawrence, AR", add 
label define countycd 5091 "Miller, AR", add 
label define countycd 5093 "Mississippi, AR", add 
label define countycd 51001 "Accomack, VA", add 
label define countycd 51003 "Albemarle, VA", add 
label define countycd 51005 "Alleghany, VA", add 
label define countycd 51009 "Amherst, VA", add 
label define countycd 51013 "Arlington, VA", add 
label define countycd 51015 "Augusta, VA", add 
label define countycd 51025 "Brunswick, VA", add 
label define countycd 51027 "Buchanan, VA", add 
label define countycd 5103 "Ouachita, AR", add 
label define countycd 51041 "Chesterfield, VA", add 
label define countycd 51047 "Culpeper, VA", add 
label define countycd 51053 "Dinwiddie, VA", add 
label define countycd 51059 "Fairfax, VA", add 
label define countycd 51067 "Franklin, VA", add 
label define countycd 51069 "Frederick, VA", add 
label define countycd 5107 "Phillips, AR", add 
label define countycd 51073 "Gloucester, VA", add 
label define countycd 51085 "Hanover, VA", add 
label define countycd 51087 "Henrico, VA", add 
label define countycd 51089 "Henry, VA", add 
label define countycd 51107 "Loudoun, VA", add 
label define countycd 51121 "Montgomery, VA", add 
label define countycd 5113 "Polk, AR", add 
label define countycd 51137 "Orange, VA", add 
label define countycd 51147 "Prince Edward, VA", add 
label define countycd 5115 "Pope, AR", add 
label define countycd 51153 "Prince William, VA", add 
label define countycd 51155 "Pulaski, VA", add 
label define countycd 51161 "Roanoke, VA", add 
label define countycd 51165 "Rockingham, VA", add 
label define countycd 51179 "Stafford, VA", add 
label define countycd 51185 "Tazewell, VA", add 
label define countycd 5119 "Pulaski, AR", add 
label define countycd 51191 "Washington, VA", add 
label define countycd 51195 "Wise, VA", add 
label define countycd 51197 "Wythe, VA", add 
label define countycd 5121 "Randolph, AR", add 
label define countycd 5123 "St. Francis, AR", add 
label define countycd 5131 "Sebastian, AR", add 
label define countycd 5133 "Sevier, AR", add 
label define countycd 5139 "Union, AR", add 
label define countycd 5143 "Washington, AR", add 
label define countycd 5145 "White, AR", add 
label define countycd 51510 "Alexandria city, VA", add 
label define countycd 51520 "Bristol city, VA", add 
label define countycd 51530 "Buena Vista city, VA", add 
label define countycd 51540 "Charlottesville city, VA", add 
label define countycd 51550 "Chesapeake city, VA", add 
label define countycd 51590 "Danville city, VA", add 
label define countycd 51620 "Franklin city, VA", add 
label define countycd 51630 "Fredericksburg city, VA", add 
label define countycd 51650 "Hampton city, VA", add 
label define countycd 51660 "Harrisonburg city, VA", add 
label define countycd 51678 "Lexington city, VA", add 
label define countycd 51680 "Lynchburg city, VA", add 
label define countycd 51683 "Manassas city, VA", add 
label define countycd 51700 "Newport News city, VA", add 
label define countycd 51710 "Norfolk city, VA", add 
label define countycd 51730 "Petersburg city, VA", add 
label define countycd 51750 "Radford city, VA", add 
label define countycd 51760 "Richmond city, VA", add 
label define countycd 51770 "Roanoke city, VA", add 
label define countycd 51775 "Salem city, VA", add 
label define countycd 51790 "Staunton city, VA", add 
label define countycd 51800 "Suffolk city, VA", add 
label define countycd 51810 "Virginia Beach city, VA", add 
label define countycd 51830 "Williamsburg city, VA", add 
label define countycd 51840 "Winchester city, VA", add 
label define countycd 53005 "Benton, WA", add 
label define countycd 53007 "Chelan, WA", add 
label define countycd 53009 "Clallam, WA", add 
label define countycd 53011 "Clark, WA", add 
label define countycd 53015 "Cowlitz, WA", add 
label define countycd 53021 "Franklin, WA", add 
label define countycd 53025 "Grant, WA", add 
label define countycd 53027 "Grays Harbor, WA", add 
label define countycd 53033 "King, WA", add 
label define countycd 53035 "Kitsap, WA", add 
label define countycd 53037 "Kittitas, WA", add 
label define countycd 53041 "Lewis, WA", add 
label define countycd 53053 "Pierce, WA", add 
label define countycd 53057 "Skagit, WA", add 
label define countycd 53061 "Snohomish, WA", add 
label define countycd 53063 "Spokane, WA", add 
label define countycd 53067 "Thurston, WA", add 
label define countycd 53071 "Walla Walla, WA", add 
label define countycd 53073 "Whatcom, WA", add 
label define countycd 53075 "Whitman, WA", add 
label define countycd 53077 "Yakima, WA", add 
label define countycd 54001 "Barbour, WV", add 
label define countycd 54003 "Berkeley, WV", add 
label define countycd 54009 "Brooke, WV", add 
label define countycd 54011 "Cabell, WV", add 
label define countycd 54019 "Fayette, WV", add 
label define countycd 54021 "Gilmer, WV", add 
label define countycd 54025 "Greenbrier, WV", add 
label define countycd 54029 "Hancock, WV", add 
label define countycd 54031 "Hardy, WV", add 
label define countycd 54033 "Harrison, WV", add 
label define countycd 54035 "Jackson, WV", add 
label define countycd 54037 "Jefferson, WV", add 
label define countycd 54039 "Kanawha, WV", add 
label define countycd 54045 "Logan, WV", add 
label define countycd 54049 "Marion, WV", add 
label define countycd 54051 "Marshall, WV", add 
label define countycd 54055 "Mercer, WV", add 
label define countycd 54057 "Mineral, WV", add 
label define countycd 54061 "Monongalia, WV", add 
label define countycd 54069 "Ohio, WV", add 
label define countycd 54079 "Putnam, WV", add 
label define countycd 54081 "Raleigh, WV", add 
label define countycd 54083 "Randolph, WV", add 
label define countycd 54089 "Summers, WV", add 
label define countycd 54097 "Upshur, WV", add 
label define countycd 54107 "Wood, WV", add 
label define countycd 55003 "Ashland, WI", add 
label define countycd 55007 "Bayfield, WI", add 
label define countycd 55009 "Brown, WI", add 
label define countycd 55025 "Dane, WI", add 
label define countycd 55031 "Douglas, WI", add 
label define countycd 55033 "Dunn, WI", add 
label define countycd 55035 "Eau Claire, WI", add 
label define countycd 55039 "Fond du Lac, WI", add 
label define countycd 55043 "Grant, WI", add 
label define countycd 55045 "Green, WI", add 
label define countycd 55055 "Jefferson, WI", add 
label define countycd 55059 "Kenosha, WI", add 
label define countycd 55063 "La Crosse, WI", add 
label define countycd 55071 "Manitowoc, WI", add 
label define countycd 55073 "Marathon, WI", add 
label define countycd 55075 "Marinette, WI", add 
label define countycd 55078 "Menominee, WI", add 
label define countycd 55079 "Milwaukee, WI", add 
label define countycd 55085 "Oneida, WI", add 
label define countycd 55087 "Outagamie, WI", add 
label define countycd 55089 "Ozaukee, WI", add 
label define countycd 55093 "Pierce, WI", add 
label define countycd 55097 "Portage, WI", add 
label define countycd 55101 "Racine, WI", add 
label define countycd 55105 "Rock, WI", add 
label define countycd 55113 "Sawyer, WI", add 
label define countycd 55117 "Sheboygan, WI", add 
label define countycd 55127 "Walworth, WI", add 
label define countycd 55129 "Washburn, WI", add 
label define countycd 55133 "Waukesha, WI", add 
label define countycd 55139 "Winnebago, WI", add 
label define countycd 55141 "Wood, WI", add 
label define countycd 56001 "Albany, WY", add 
label define countycd 56013 "Fremont, WY", add 
label define countycd 56015 "Goshen, WY", add 
label define countycd 56021 "Laramie, WY", add 
label define countycd 56025 "Natrona, WY", add 
label define countycd 56029 "Park, WY", add 
label define countycd 56033 "Sheridan, WY", add 
label define countycd 56037 "Sweetwater, WY", add 
label define countycd 6001 "Alameda, CA", add 
label define countycd 60050 "Western District, AS", add 
label define countycd 6007 "Butte, CA", add 
label define countycd 6013 "Contra Costa, CA", add 
label define countycd 6017 "El Dorado, CA", add 
label define countycd 6019 "Fresno, CA", add 
label define countycd 6023 "Humboldt, CA", add 
label define countycd 6025 "Imperial, CA", add 
label define countycd 6029 "Kern, CA", add 
label define countycd 6031 "Kings, CA", add 
label define countycd 6035 "Lassen, CA", add 
label define countycd 6037 "Los Angeles, CA", add 
label define countycd 6039 "Madera, CA", add 
label define countycd 6041 "Marin, CA", add 
label define countycd 6045 "Mendocino, CA", add 
label define countycd 6047 "Merced, CA", add 
label define countycd 6053 "Monterey, CA", add 
label define countycd 6055 "Napa, CA", add 
label define countycd 6059 "Orange, CA", add 
label define countycd 6061 "Placer, CA", add 
label define countycd 6063 "Plumas, CA", add 
label define countycd 6065 "Riverside, CA", add 
label define countycd 6067 "Sacramento, CA", add 
label define countycd 6071 "San Bernardino, CA", add 
label define countycd 6073 "San Diego, CA", add 
label define countycd 6075 "San Francisco, CA", add 
label define countycd 6077 "San Joaquin, CA", add 
label define countycd 6079 "San Luis Obispo, CA", add 
label define countycd 6081 "San Mateo, CA", add 
label define countycd 6083 "Santa Barbara, CA", add 
label define countycd 6085 "Santa Clara, CA", add 
label define countycd 6087 "Santa Cruz, CA", add 
label define countycd 6089 "Shasta, CA", add 
label define countycd 6093 "Siskiyou, CA", add 
label define countycd 6095 "Solano, CA", add 
label define countycd 6097 "Sonoma, CA", add 
label define countycd 6099 "Stanislaus, CA", add 
label define countycd 6101 "Sutter, CA", add 
label define countycd 6107 "Tulare, CA", add 
label define countycd 6109 "Tuolumne, CA", add 
label define countycd 6111 "Ventura, CA", add 
label define countycd 6113 "Yolo, CA", add 
label define countycd 6115 "Yuba, CA", add 
label define countycd 66010 "Guam, GU", add 
label define countycd 69110 "Saipan Municipality, MP", add 
label define countycd 72003 "Aguada Municipio, PR", add 
label define countycd 72005 "Aguadilla Municipio, PR", add 
label define countycd 72013 "Arecibo Municipio, PR", add 
label define countycd 72015 "Arroyo Municipio, PR", add 
label define countycd 72019 "Barranquitas Municipio, PR", add 
label define countycd 72021 "Bayamón Municipio, PR", add 
label define countycd 72025 "Caguas Municipio, PR", add 
label define countycd 72031 "Carolina Municipio, PR", add 
label define countycd 72035 "Cayey Municipio, PR", add 
label define countycd 72043 "Coamo Municipio, PR", add 
label define countycd 72053 "Fajardo Municipio, PR", add 
label define countycd 72057 "Guayama Municipio, PR", add 
label define countycd 72061 "Guaynabo Municipio, PR", add 
label define countycd 72063 "Gurabo Municipio, PR", add 
label define countycd 72069 "Humacao Municipio, PR", add 
label define countycd 72071 "Isabela Municipio, PR", add 
label define countycd 72075 "Juana Díaz Municipio, PR", add 
label define countycd 72091 "Manatí Municipio, PR", add 
label define countycd 72097 "Mayagüez Municipio, PR", add 
label define countycd 72099 "Moca Municipio, PR", add 
label define countycd 72113 "Ponce Municipio, PR", add 
label define countycd 72119 "Río Grande Municipio, PR", add 
label define countycd 72125 "San Germán Municipio, PR", add 
label define countycd 72127 "San Juan Municipio, PR", add 
label define countycd 72129 "San Lorenzo Municipio, PR", add 
label define countycd 72131 "San Sebastián Municipio, PR", add 
label define countycd 72139 "Trujillo Alto Municipio, PR", add 
label define countycd 72141 "Utuado Municipio, PR", add 
label define countycd 72145 "Vega Baja Municipio, PR", add 
label define countycd 72153 "Yauco Municipio, PR", add 
label define countycd 78010 "St. Croix Island, VI", add 
label define countycd 78030 "St. Thomas Island, VI", add 
label define countycd 8001 "Adams, CO", add 
label define countycd 8003 "Alamosa, CO", add 
label define countycd 8005 "Arapahoe, CO", add 
label define countycd 8013 "Boulder, CO", add 
label define countycd 8014 "Broomfield, CO", add 
label define countycd 8029 "Delta, CO", add 
label define countycd 8031 "Denver, CO", add 
label define countycd 8035 "Douglas, CO", add 
label define countycd 8041 "El Paso, CO", add 
label define countycd 8045 "Garfield, CO", add 
label define countycd 8051 "Gunnison, CO", add 
label define countycd 8059 "Jefferson, CO", add 
label define countycd 8067 "La Plata, CO", add 
label define countycd 8069 "Larimer, CO", add 
label define countycd 8071 "Las Animas, CO", add 
label define countycd 8075 "Logan, CO", add 
label define countycd 8077 "Mesa, CO", add 
label define countycd 8083 "Montezuma, CO", add 
label define countycd 8087 "Morgan, CO", add 
label define countycd 8089 "Otero, CO", add 
label define countycd 8099 "Prowers, CO", add 
label define countycd 8101 "Pueblo, CO", add 
label define countycd 8103 "Rio Blanco, CO", add 
label define countycd 8119 "Teller, CO", add 
label define countycd 8123 "Weld, CO", add 
label define countycd 9001 "Fairfield, CT", add 
label define countycd 9003 "Hartford, CT", add 
label define countycd 9005 "Litchfield, CT", add 
label define countycd 9007 "Middlesex, CT", add 
label define countycd 9009 "New Haven, CT", add 
label define countycd 9011 "New London, CT", add 
label define countycd 9013 "Tolland, CT", add 
label define countycd 9015 "Windham, CT", add 
label values countycd countycd
label define cngdstcd -2 "Not applicable" 
label define cngdstcd 1000 "DE - District 00", add 
label define cngdstcd 101 "AL - District 01", add 
label define cngdstcd 102 "AL - District 02", add 
label define cngdstcd 103 "AL - District 03", add 
label define cngdstcd 104 "AL - District 04", add 
label define cngdstcd 105 "AL - District 05", add 
label define cngdstcd 106 "AL - District 06", add 
label define cngdstcd 107 "AL - District 07", add 
label define cngdstcd 1198 "DC - District 98", add 
label define cngdstcd 1201 "FL - District 01", add 
label define cngdstcd 1202 "FL - District 02", add 
label define cngdstcd 1203 "FL - District 03", add 
label define cngdstcd 1204 "FL - District 04", add 
label define cngdstcd 1205 "FL - District 05", add 
label define cngdstcd 1206 "FL - District 06", add 
label define cngdstcd 1207 "FL - District 07", add 
label define cngdstcd 1208 "FL - District 08", add 
label define cngdstcd 1209 "FL - District 09", add 
label define cngdstcd 1210 "FL - District 10", add 
label define cngdstcd 1211 "FL - District 11", add 
label define cngdstcd 1212 "FL - District 12", add 
label define cngdstcd 1213 "FL - District 13", add 
label define cngdstcd 1214 "FL - District 14", add 
label define cngdstcd 1215 "FL - District 15", add 
label define cngdstcd 1216 "FL - District 16", add 
label define cngdstcd 1217 "FL - District 17", add 
label define cngdstcd 1218 "FL - District 18", add 
label define cngdstcd 1219 "FL - District 19", add 
label define cngdstcd 1220 "FL - District 20", add 
label define cngdstcd 1221 "FL - District 21", add 
label define cngdstcd 1222 "FL - District 22", add 
label define cngdstcd 1223 "FL - District 23", add 
label define cngdstcd 1224 "FL - District 24", add 
label define cngdstcd 1225 "FL - District 25", add 
label define cngdstcd 1301 "GA - District 01", add 
label define cngdstcd 1302 "GA - District 02", add 
label define cngdstcd 1303 "GA - District 03", add 
label define cngdstcd 1304 "GA - District 04", add 
label define cngdstcd 1305 "GA - District 05", add 
label define cngdstcd 1306 "GA - District 06", add 
label define cngdstcd 1307 "GA - District 07", add 
label define cngdstcd 1308 "GA - District 08", add 
label define cngdstcd 1309 "GA - District 09", add 
label define cngdstcd 1310 "GA - District 10", add 
label define cngdstcd 1311 "GA - District 11", add 
label define cngdstcd 1312 "GA - District 12", add 
label define cngdstcd 1313 "GA - District 13", add 
label define cngdstcd 1501 "HI - District 01", add 
label define cngdstcd 1502 "HI - District 02", add 
label define cngdstcd 1601 "ID - District 01", add 
label define cngdstcd 1602 "ID - District 02", add 
label define cngdstcd 1701 "IL - District 01", add 
label define cngdstcd 1702 "IL - District 02", add 
label define cngdstcd 1703 "IL - District 03", add 
label define cngdstcd 1704 "IL - District 04", add 
label define cngdstcd 1705 "IL - District 05", add 
label define cngdstcd 1706 "IL - District 06", add 
label define cngdstcd 1707 "IL - District 07", add 
label define cngdstcd 1708 "IL - District 08", add 
label define cngdstcd 1709 "IL - District 09", add 
label define cngdstcd 1710 "IL - District 10", add 
label define cngdstcd 1711 "IL - District 11", add 
label define cngdstcd 1712 "IL - District 12", add 
label define cngdstcd 1713 "IL - District 13", add 
label define cngdstcd 1714 "IL - District 14", add 
label define cngdstcd 1715 "IL - District 15", add 
label define cngdstcd 1716 "IL - District 16", add 
label define cngdstcd 1717 "IL - District 17", add 
label define cngdstcd 1718 "IL - District 18", add 
label define cngdstcd 1719 "IL - District 19", add 
label define cngdstcd 1801 "IN - District 01", add 
label define cngdstcd 1802 "IN - District 02", add 
label define cngdstcd 1803 "IN - District 03", add 
label define cngdstcd 1804 "IN - District 04", add 
label define cngdstcd 1805 "IN - District 05", add 
label define cngdstcd 1806 "IN - District 06", add 
label define cngdstcd 1807 "IN - District 07", add 
label define cngdstcd 1808 "IN - District 08", add 
label define cngdstcd 1809 "IN - District 09", add 
label define cngdstcd 1901 "IA - District 01", add 
label define cngdstcd 1902 "IA - District 02", add 
label define cngdstcd 1903 "IA - District 03", add 
label define cngdstcd 1904 "IA - District 04", add 
label define cngdstcd 1905 "IA - District 05", add 
label define cngdstcd 200 "AK - District 00", add 
label define cngdstcd 2001 "KS - District 01", add 
label define cngdstcd 2002 "KS - District 02", add 
label define cngdstcd 2003 "KS - District 03", add 
label define cngdstcd 2004 "KS - District 04", add 
label define cngdstcd 2101 "KY - District 01", add 
label define cngdstcd 2102 "KY - District 02", add 
label define cngdstcd 2103 "KY - District 03", add 
label define cngdstcd 2104 "KY - District 04", add 
label define cngdstcd 2105 "KY - District 05", add 
label define cngdstcd 2106 "KY - District 06", add 
label define cngdstcd 2201 "LA - District 01", add 
label define cngdstcd 2202 "LA - District 02", add 
label define cngdstcd 2203 "LA - District 03", add 
label define cngdstcd 2204 "LA - District 04", add 
label define cngdstcd 2205 "LA - District 05", add 
label define cngdstcd 2206 "LA - District 06", add 
label define cngdstcd 2207 "LA - District 07", add 
label define cngdstcd 2301 "ME - District 01", add 
label define cngdstcd 2302 "ME - District 02", add 
label define cngdstcd 2401 "MD - District 01", add 
label define cngdstcd 2402 "MD - District 02", add 
label define cngdstcd 2403 "MD - District 03", add 
label define cngdstcd 2404 "MD - District 04", add 
label define cngdstcd 2405 "MD - District 05", add 
label define cngdstcd 2406 "MD - District 06", add 
label define cngdstcd 2407 "MD - District 07", add 
label define cngdstcd 2408 "MD - District 08", add 
label define cngdstcd 2501 "MA - District 01", add 
label define cngdstcd 2502 "MA - District 02", add 
label define cngdstcd 2503 "MA - District 03", add 
label define cngdstcd 2504 "MA - District 04", add 
label define cngdstcd 2505 "MA - District 05", add 
label define cngdstcd 2506 "MA - District 06", add 
label define cngdstcd 2507 "MA - District 07", add 
label define cngdstcd 2508 "MA - District 08", add 
label define cngdstcd 2509 "MA - District 09", add 
label define cngdstcd 2510 "MA - District 10", add 
label define cngdstcd 2601 "MI - District 01", add 
label define cngdstcd 2602 "MI - District 02", add 
label define cngdstcd 2603 "MI - District 03", add 
label define cngdstcd 2604 "MI - District 04", add 
label define cngdstcd 2605 "MI - District 05", add 
label define cngdstcd 2606 "MI - District 06", add 
label define cngdstcd 2607 "MI - District 07", add 
label define cngdstcd 2608 "MI - District 08", add 
label define cngdstcd 2609 "MI - District 09", add 
label define cngdstcd 2610 "MI - District 10", add 
label define cngdstcd 2611 "MI - District 11", add 
label define cngdstcd 2612 "MI - District 12", add 
label define cngdstcd 2613 "MI - District 13", add 
label define cngdstcd 2614 "MI - District 14", add 
label define cngdstcd 2615 "MI - District 15", add 
label define cngdstcd 2701 "MN - District 01", add 
label define cngdstcd 2702 "MN - District 02", add 
label define cngdstcd 2703 "MN - District 03", add 
label define cngdstcd 2704 "MN - District 04", add 
label define cngdstcd 2705 "MN - District 05", add 
label define cngdstcd 2706 "MN - District 06", add 
label define cngdstcd 2707 "MN - District 07", add 
label define cngdstcd 2708 "MN - District 08", add 
label define cngdstcd 2801 "MS - District 01", add 
label define cngdstcd 2802 "MS - District 02", add 
label define cngdstcd 2803 "MS - District 03", add 
label define cngdstcd 2804 "MS - District 04", add 
label define cngdstcd 2901 "MO - District 01", add 
label define cngdstcd 2902 "MO - District 02", add 
label define cngdstcd 2903 "MO - District 03", add 
label define cngdstcd 2904 "MO - District 04", add 
label define cngdstcd 2905 "MO - District 05", add 
label define cngdstcd 2906 "MO - District 06", add 
label define cngdstcd 2907 "MO - District 07", add 
label define cngdstcd 2908 "MO - District 08", add 
label define cngdstcd 2909 "MO - District 09", add 
label define cngdstcd 3000 "MT - District 00", add 
label define cngdstcd 3101 "NE - District 01", add 
label define cngdstcd 3102 "NE - District 02", add 
label define cngdstcd 3103 "NE - District 03", add 
label define cngdstcd 3201 "NV - District 01", add 
label define cngdstcd 3202 "NV - District 02", add 
label define cngdstcd 3203 "NV - District 03", add 
label define cngdstcd 3301 "NH - District 01", add 
label define cngdstcd 3302 "NH - District 02", add 
label define cngdstcd 3401 "NJ - District 01", add 
label define cngdstcd 3402 "NJ - District 02", add 
label define cngdstcd 3403 "NJ - District 03", add 
label define cngdstcd 3404 "NJ - District 04", add 
label define cngdstcd 3405 "NJ - District 05", add 
label define cngdstcd 3406 "NJ - District 06", add 
label define cngdstcd 3407 "NJ - District 07", add 
label define cngdstcd 3408 "NJ - District 08", add 
label define cngdstcd 3409 "NJ - District 09", add 
label define cngdstcd 3410 "NJ - District 10", add 
label define cngdstcd 3411 "NJ - District 11", add 
label define cngdstcd 3412 "NJ - District 12", add 
label define cngdstcd 3413 "NJ - District 13", add 
label define cngdstcd 3501 "NM - District 01", add 
label define cngdstcd 3502 "NM - District 02", add 
label define cngdstcd 3503 "NM - District 03", add 
label define cngdstcd 3601 "NY - District 01", add 
label define cngdstcd 3602 "NY - District 02", add 
label define cngdstcd 3603 "NY - District 03", add 
label define cngdstcd 3604 "NY - District 04", add 
label define cngdstcd 3605 "NY - District 05", add 
label define cngdstcd 3606 "NY - District 06", add 
label define cngdstcd 3607 "NY - District 07", add 
label define cngdstcd 3608 "NY - District 08", add 
label define cngdstcd 3609 "NY - District 09", add 
label define cngdstcd 3610 "NY - District 10", add 
label define cngdstcd 3611 "NY - District 11", add 
label define cngdstcd 3612 "NY - District 12", add 
label define cngdstcd 3613 "NY - District 13", add 
label define cngdstcd 3614 "NY - District 14", add 
label define cngdstcd 3615 "NY - District 15", add 
label define cngdstcd 3616 "NY - District 16", add 
label define cngdstcd 3617 "NY - District 17", add 
label define cngdstcd 3618 "NY - District 18", add 
label define cngdstcd 3619 "NY - District 19", add 
label define cngdstcd 3620 "NY - District 20", add 
label define cngdstcd 3621 "NY - District 21", add 
label define cngdstcd 3622 "NY - District 22", add 
label define cngdstcd 3623 "NY - District 23", add 
label define cngdstcd 3624 "NY - District 24", add 
label define cngdstcd 3625 "NY - District 25", add 
label define cngdstcd 3626 "NY - District 26", add 
label define cngdstcd 3627 "NY - District 27", add 
label define cngdstcd 3628 "NY - District 28", add 
label define cngdstcd 3629 "NY - District 29", add 
label define cngdstcd 3701 "NC - District 01", add 
label define cngdstcd 3702 "NC - District 02", add 
label define cngdstcd 3703 "NC - District 03", add 
label define cngdstcd 3704 "NC - District 04", add 
label define cngdstcd 3705 "NC - District 05", add 
label define cngdstcd 3706 "NC - District 06", add 
label define cngdstcd 3707 "NC - District 07", add 
label define cngdstcd 3708 "NC - District 08", add 
label define cngdstcd 3709 "NC - District 09", add 
label define cngdstcd 3710 "NC - District 10", add 
label define cngdstcd 3711 "NC - District 11", add 
label define cngdstcd 3712 "NC - District 12", add 
label define cngdstcd 3713 "NC - District 13", add 
label define cngdstcd 3800 "ND - District 00", add 
label define cngdstcd 3901 "OH - District 01", add 
label define cngdstcd 3902 "OH - District 02", add 
label define cngdstcd 3903 "OH - District 03", add 
label define cngdstcd 3904 "OH - District 04", add 
label define cngdstcd 3905 "OH - District 05", add 
label define cngdstcd 3906 "OH - District 06", add 
label define cngdstcd 3907 "OH - District 07", add 
label define cngdstcd 3908 "OH - District 08", add 
label define cngdstcd 3909 "OH - District 09", add 
label define cngdstcd 3910 "OH - District 10", add 
label define cngdstcd 3911 "OH - District 11", add 
label define cngdstcd 3912 "OH - District 12", add 
label define cngdstcd 3913 "OH - District 13", add 
label define cngdstcd 3914 "OH - District 14", add 
label define cngdstcd 3915 "OH - District 15", add 
label define cngdstcd 3916 "OH - District 16", add 
label define cngdstcd 3917 "OH - District 17", add 
label define cngdstcd 3918 "OH - District 18", add 
label define cngdstcd 4001 "OK - District 01", add 
label define cngdstcd 4002 "OK - District 02", add 
label define cngdstcd 4003 "OK - District 03", add 
label define cngdstcd 4004 "OK - District 04", add 
label define cngdstcd 4005 "OK - District 05", add 
label define cngdstcd 401 "AZ - District 01", add 
label define cngdstcd 402 "AZ - District 02", add 
label define cngdstcd 403 "AZ - District 03", add 
label define cngdstcd 404 "AZ - District 04", add 
label define cngdstcd 405 "AZ - District 05", add 
label define cngdstcd 406 "AZ - District 06", add 
label define cngdstcd 407 "AZ - District 07", add 
label define cngdstcd 408 "AZ - District 08", add 
label define cngdstcd 4101 "OR - District 01", add 
label define cngdstcd 4102 "OR - District 02", add 
label define cngdstcd 4103 "OR - District 03", add 
label define cngdstcd 4104 "OR - District 04", add 
label define cngdstcd 4105 "OR - District 05", add 
label define cngdstcd 4201 "PA - District 01", add 
label define cngdstcd 4202 "PA - District 02", add 
label define cngdstcd 4203 "PA - District 03", add 
label define cngdstcd 4204 "PA - District 04", add 
label define cngdstcd 4205 "PA - District 05", add 
label define cngdstcd 4206 "PA - District 06", add 
label define cngdstcd 4207 "PA - District 07", add 
label define cngdstcd 4208 "PA - District 08", add 
label define cngdstcd 4209 "PA - District 09", add 
label define cngdstcd 4210 "PA - District 10", add 
label define cngdstcd 4211 "PA - District 11", add 
label define cngdstcd 4212 "PA - District 12", add 
label define cngdstcd 4213 "PA - District 13", add 
label define cngdstcd 4214 "PA - District 14", add 
label define cngdstcd 4215 "PA - District 15", add 
label define cngdstcd 4216 "PA - District 16", add 
label define cngdstcd 4217 "PA - District 17", add 
label define cngdstcd 4218 "PA - District 18", add 
label define cngdstcd 4219 "PA - District 19", add 
label define cngdstcd 4401 "RI - District 01", add 
label define cngdstcd 4402 "RI - District 02", add 
label define cngdstcd 4501 "SC - District 01", add 
label define cngdstcd 4502 "SC - District 02", add 
label define cngdstcd 4503 "SC - District 03", add 
label define cngdstcd 4504 "SC - District 04", add 
label define cngdstcd 4505 "SC - District 05", add 
label define cngdstcd 4506 "SC - District 06", add 
label define cngdstcd 4600 "SD - District 00", add 
label define cngdstcd 4701 "TN - District 01", add 
label define cngdstcd 4702 "TN - District 02", add 
label define cngdstcd 4703 "TN - District 03", add 
label define cngdstcd 4704 "TN - District 04", add 
label define cngdstcd 4705 "TN - District 05", add 
label define cngdstcd 4706 "TN - District 06", add 
label define cngdstcd 4707 "TN - District 07", add 
label define cngdstcd 4708 "TN - District 08", add 
label define cngdstcd 4709 "TN - District 09", add 
label define cngdstcd 4801 "TX - District 01", add 
label define cngdstcd 4802 "TX - District 02", add 
label define cngdstcd 4803 "TX - District 03", add 
label define cngdstcd 4804 "TX - District 04", add 
label define cngdstcd 4805 "TX - District 05", add 
label define cngdstcd 4806 "TX - District 06", add 
label define cngdstcd 4807 "TX - District 07", add 
label define cngdstcd 4808 "TX - District 08", add 
label define cngdstcd 4809 "TX - District 09", add 
label define cngdstcd 4810 "TX - District 10", add 
label define cngdstcd 4811 "TX - District 11", add 
label define cngdstcd 4812 "TX - District 12", add 
label define cngdstcd 4813 "TX - District 13", add 
label define cngdstcd 4814 "TX - District 14", add 
label define cngdstcd 4815 "TX - District 15", add 
label define cngdstcd 4816 "TX - District 16", add 
label define cngdstcd 4817 "TX - District 17", add 
label define cngdstcd 4818 "TX - District 18", add 
label define cngdstcd 4819 "TX - District 19", add 
label define cngdstcd 4820 "TX - District 20", add 
label define cngdstcd 4821 "TX - District 21", add 
label define cngdstcd 4822 "TX - District 22", add 
label define cngdstcd 4823 "TX - District 23", add 
label define cngdstcd 4824 "TX - District 24", add 
label define cngdstcd 4825 "TX - District 25", add 
label define cngdstcd 4826 "TX - District 26", add 
label define cngdstcd 4827 "TX - District 27", add 
label define cngdstcd 4828 "TX - District 28", add 
label define cngdstcd 4829 "TX - District 29", add 
label define cngdstcd 4830 "TX - District 30", add 
label define cngdstcd 4831 "TX - District 31", add 
label define cngdstcd 4832 "TX - District 32", add 
label define cngdstcd 4901 "UT - District 01", add 
label define cngdstcd 4902 "UT - District 02", add 
label define cngdstcd 4903 "UT - District 03", add 
label define cngdstcd 5000 "VT - District 00", add 
label define cngdstcd 501 "AR - District 01", add 
label define cngdstcd 502 "AR - District 02", add 
label define cngdstcd 503 "AR - District 03", add 
label define cngdstcd 504 "AR - District 04", add 
label define cngdstcd 5101 "VA - District 01", add 
label define cngdstcd 5102 "VA - District 02", add 
label define cngdstcd 5103 "VA - District 03", add 
label define cngdstcd 5104 "VA - District 04", add 
label define cngdstcd 5105 "VA - District 05", add 
label define cngdstcd 5106 "VA - District 06", add 
label define cngdstcd 5107 "VA - District 07", add 
label define cngdstcd 5108 "VA - District 08", add 
label define cngdstcd 5109 "VA - District 09", add 
label define cngdstcd 5110 "VA - District 10", add 
label define cngdstcd 5111 "VA - District 11", add 
label define cngdstcd 5301 "WA - District 01", add 
label define cngdstcd 5302 "WA - District 02", add 
label define cngdstcd 5303 "WA - District 03", add 
label define cngdstcd 5304 "WA - District 04", add 
label define cngdstcd 5305 "WA - District 05", add 
label define cngdstcd 5306 "WA - District 06", add 
label define cngdstcd 5307 "WA - District 07", add 
label define cngdstcd 5308 "WA - District 08", add 
label define cngdstcd 5309 "WA - District 09", add 
label define cngdstcd 5401 "WV - District 01", add 
label define cngdstcd 5402 "WV - District 02", add 
label define cngdstcd 5403 "WV - District 03", add 
label define cngdstcd 5501 "WI - District 01", add 
label define cngdstcd 5502 "WI - District 02", add 
label define cngdstcd 5503 "WI - District 03", add 
label define cngdstcd 5504 "WI - District 04", add 
label define cngdstcd 5505 "WI - District 05", add 
label define cngdstcd 5506 "WI - District 06", add 
label define cngdstcd 5507 "WI - District 07", add 
label define cngdstcd 5508 "WI - District 08", add 
label define cngdstcd 5600 "WY - District 00", add 
label define cngdstcd 601 "CA - District 01", add 
label define cngdstcd 602 "CA - District 02", add 
label define cngdstcd 603 "CA - District 03", add 
label define cngdstcd 604 "CA - District 04", add 
label define cngdstcd 605 "CA - District 05", add 
label define cngdstcd 606 "CA - District 06", add 
label define cngdstcd 607 "CA - District 07", add 
label define cngdstcd 608 "CA - District 08", add 
label define cngdstcd 609 "CA - District 09", add 
label define cngdstcd 6098 "AS - District 98", add 
label define cngdstcd 610 "CA - District 10", add 
label define cngdstcd 611 "CA - District 11", add 
label define cngdstcd 612 "CA - District 12", add 
label define cngdstcd 613 "CA - District 13", add 
label define cngdstcd 614 "CA - District 14", add 
label define cngdstcd 615 "CA - District 15", add 
label define cngdstcd 616 "CA - District 16", add 
label define cngdstcd 617 "CA - District 17", add 
label define cngdstcd 618 "CA - District 18", add 
label define cngdstcd 619 "CA - District 19", add 
label define cngdstcd 620 "CA - District 20", add 
label define cngdstcd 621 "CA - District 21", add 
label define cngdstcd 622 "CA - District 22", add 
label define cngdstcd 623 "CA - District 23", add 
label define cngdstcd 624 "CA - District 24", add 
label define cngdstcd 625 "CA - District 25", add 
label define cngdstcd 626 "CA - District 26", add 
label define cngdstcd 627 "CA - District 27", add 
label define cngdstcd 628 "CA - District 28", add 
label define cngdstcd 629 "CA - District 29", add 
label define cngdstcd 630 "CA - District 30", add 
label define cngdstcd 631 "CA - District 31", add 
label define cngdstcd 632 "CA - District 32", add 
label define cngdstcd 633 "CA - District 33", add 
label define cngdstcd 634 "CA - District 34", add 
label define cngdstcd 635 "CA - District 35", add 
label define cngdstcd 636 "CA - District 36", add 
label define cngdstcd 637 "CA - District 37", add 
label define cngdstcd 638 "CA - District 38", add 
label define cngdstcd 639 "CA - District 39", add 
label define cngdstcd 640 "CA - District 40", add 
label define cngdstcd 641 "CA - District 41", add 
label define cngdstcd 642 "CA - District 42", add 
label define cngdstcd 643 "CA - District 43", add 
label define cngdstcd 644 "CA - District 44", add 
label define cngdstcd 645 "CA - District 45", add 
label define cngdstcd 646 "CA - District 46", add 
label define cngdstcd 647 "CA - District 47", add 
label define cngdstcd 648 "CA - District 48", add 
label define cngdstcd 649 "CA - District 49", add 
label define cngdstcd 650 "CA - District 50", add 
label define cngdstcd 651 "CA - District 51", add 
label define cngdstcd 652 "CA - District 52", add 
label define cngdstcd 653 "CA - District 53", add 
label define cngdstcd 6698 "GU - District 98", add 
label define cngdstcd 6999 "MP - District 99", add 
label define cngdstcd 7298 "PR - District 98", add 
label define cngdstcd 7898 "VI - District 98", add 
label define cngdstcd 801 "CO - District 01", add 
label define cngdstcd 802 "CO - District 02", add 
label define cngdstcd 803 "CO - District 03", add 
label define cngdstcd 804 "CO - District 04", add 
label define cngdstcd 805 "CO - District 05", add 
label define cngdstcd 806 "CO - District 06", add 
label define cngdstcd 807 "CO - District 07", add 
label define cngdstcd 901 "CT - District 01", add 
label define cngdstcd 902 "CT - District 02", add 
label define cngdstcd 903 "CT - District 03", add 
label define cngdstcd 904 "CT - District 04", add 
label define cngdstcd 905 "CT - District 05", add 
label values cngdstcd cngdstcd
label define dfrcgid -1 "Not reported - Nontitle IV institutiondid not respond to all components" 
label define dfrcgid -2 "Not applicable - institution is inactive", add 
label define dfrcgid 1 "Public, academic year reporter, nondegree-granting/1", add 
label define dfrcgid 10 "Public, program reporter, nondegree-granting, largest program-health/6", add 
label define dfrcgid 100 "Public, 2-year colleges, small size, southeastern states, rural locale/2", add 
label define dfrcgid 101 "Public, 2-year colleges, large size,  western states/1", add 
label define dfrcgid 102 "Public, 2-year colleges, large size,  western states/2", add 
label define dfrcgid 103 "Public, 2-year colleges, large size,  western states/3", add 
label define dfrcgid 104 "Public, 2-year colleges, large size,  western states/4", add 
label define dfrcgid 105 "Public, 2-year colleges, medium size, western states, city locale.", add 
label define dfrcgid 106 "Public, 2-year colleges, medium size, western states, suburban locale.", add 
label define dfrcgid 107 "Public, 2-year colleges, medium size, western states, town locale.", add 
label define dfrcgid 108 "Public, 2-year colleges, medium size, western states, rural locale.", add 
label define dfrcgid 109 "Public, 2-year colleges, small size, western states/1", add 
label define dfrcgid 11 "Public, program reporter, nondegree-granting.", add 
label define dfrcgid 110 "Public, 2-year colleges, small size, western states/2", add 
label define dfrcgid 111 "Associates--Private not-for-profit/1", add 
label define dfrcgid 112 "Associates--Private not-for-profit/2", add 
label define dfrcgid 113 "Associates--Private not-for-profit/3", add 
label define dfrcgid 114 "Associates--Private for-profit, in New England.", add 
label define dfrcgid 115 "Associates--Private for-profit, in the Mid-Atlantic region/1", add 
label define dfrcgid 116 "Associates--Private for-profit, in the Mid-Atlantic region/2", add 
label define dfrcgid 117 "Associates--Private for-profit, in the Mid-Atlantic region/3", add 
label define dfrcgid 118 "Associates--Private for-profit, in the Mid-Atlantic region/4", add 
label define dfrcgid 119 "Associates--Private for-profit, in the Great Lakes region/1", add 
label define dfrcgid 12 "Private not-for-profit, academic year reporter, nondegree-granting/1", add 
label define dfrcgid 120 "Associates--Private for-profit, in the Great Lakes region/2", add 
label define dfrcgid 121 "Associates--Private for-profit, in the Great Lakes region/3", add 
label define dfrcgid 122 "Associates--Private for-profit, in the Great Lakes region/4", add 
label define dfrcgid 123 "Associates--Private for-profit, in the Plains region.", add 
label define dfrcgid 124 "Associates--Private for-profit, in the southeastern region/1", add 
label define dfrcgid 125 "Associates--Private for-profit, in the southeastern region/2", add 
label define dfrcgid 126 "Associates--Private for-profit, in the southeastern region/3", add 
label define dfrcgid 127 "Associates--Private for-profit, in the southeastern region/4", add 
label define dfrcgid 128 "Associates--Private for-profit, in the southeastern region/5", add 
label define dfrcgid 129 "Associates--Private for-profit, in the southeastern region/6", add 
label define dfrcgid 13 "Private not-for-profit, academic year reporter, nondegree-granting/2", add 
label define dfrcgid 130 "Associates--Private for-profit, in the southwestern region/1", add 
label define dfrcgid 131 "Associates--Private for-profit, in the southwestern region/2", add 
label define dfrcgid 132 "Associates--Private for-profit, in the southwestern region/3", add 
label define dfrcgid 133 "Associates--Private for-profit, in the Rocky Mountain region.", add 
label define dfrcgid 134 "Associates--Private for-profit, in the Far Western region/1", add 
label define dfrcgid 135 "Associates--Private for-profit, in the Far Western region/2", add 
label define dfrcgid 136 "Associates--Private for-profit, in the Far Western region/3", add 
label define dfrcgid 137 "Associates--Public 4-year Primarily Associates/1", add 
label define dfrcgid 138 "Associates--Public 4-year Primarily Associates/2", add 
label define dfrcgid 139 "Associates--Private not-for-profit 4-year Primarily Associates.", add 
label define dfrcgid 14 "Private not-for-profit, academic year reporter, nondegree-granting/3", add 
label define dfrcgid 140 "Associates--Private for-profit 4-year Primarily Associates/1", add 
label define dfrcgid 141 "Associates--Private for-profit 4-year Primarily Associates/2", add 
label define dfrcgid 142 "Research Universities (very high research activity), public/1", add 
label define dfrcgid 143 "Research Universities (very high research activity), public/2", add 
label define dfrcgid 144 "Research Universities (very high research activity), private not-for-profit.", add 
label define dfrcgid 145 "Research Universities (high research activity), public/1", add 
label define dfrcgid 146 "Research Universities (high research activity), public/2", add 
label define dfrcgid 147 "Research Universities (high research activity), private not-for-profit.", add 
label define dfrcgid 148 "Doctoral/Research Universities, public.", add 
label define dfrcgid 149 "Doctoral/Research Universities, private not-for-profit.", add 
label define dfrcgid 15 "Private not-for-profit, program reporter, nondegree-granting, largest program-health", add 
label define dfrcgid 150 "Doctoral/Research Universities, private for-profit.", add 
label define dfrcgid 151 "Masters Colleges and Universities (larger programs), public/1", add 
label define dfrcgid 152 "Masters Colleges and Universities (larger programs), public/2", add 
label define dfrcgid 153 "Masters Colleges and Universities (larger programs), public/3", add 
label define dfrcgid 154 "Masters Colleges and Universities (larger programs), public/4", add 
label define dfrcgid 155 "Masters Colleges and Universities (larger programs), public/5", add 
label define dfrcgid 156 "Masters Colleges and Universities (larger programs), private not-for-profit/1", add 
label define dfrcgid 157 "Masters Colleges and Universities (larger programs), private not-for-profit/2", add 
label define dfrcgid 158 "Masters Colleges and Universities (larger programs), private not-for-profit/3", add 
label define dfrcgid 159 "Masters Colleges and Universities (larger programs), private not-for-profit/4", add 
label define dfrcgid 16 "Private not-for-profit, program reporter, nondegree-granting/1", add 
label define dfrcgid 160 "Masters Colleges and Universities (larger programs), private not-for-profit/5", add 
label define dfrcgid 161 "Masters Colleges and Universities (larger programs), private for-profit.", add 
label define dfrcgid 162 "Masters Colleges and Universities (medium programs), public/1", add 
label define dfrcgid 163 "Masters Colleges and Universities (medium programs), public/2", add 
label define dfrcgid 164 "Masters Colleges and Universities (medium programs), private not-for-profit/1", add 
label define dfrcgid 165 "Masters Colleges and Universities (medium programs), private not-for-profit/2", add 
label define dfrcgid 166 "Masters Colleges and Universities (medium programs), private not-for-profit/3", add 
label define dfrcgid 167 "Masters Colleges and Universities (medium programs), private for-profit.", add 
label define dfrcgid 168 "Masters Colleges and Universities (smaller programs), public.", add 
label define dfrcgid 169 "Masters Colleges and Universities (smaller programs), private not-for-profit/1", add 
label define dfrcgid 17 "Private not-for-profit, program reporter, nondegree-granting/2", add 
label define dfrcgid 170 "Masters Colleges and Universities (smaller programs), private not-for-profit/2", add 
label define dfrcgid 171 "Masters Colleges and Universities (smaller programs), private not-for-profit/3", add 
label define dfrcgid 172 "Masters Colleges and Universities (smaller programs), private for-profit.", add 
label define dfrcgid 173 "Baccalaureate Colleges--Arts & Sciences, public.", add 
label define dfrcgid 174 "Baccalaureate Colleges--Arts & Sciences, private not-for-profit/1", add 
label define dfrcgid 175 "Baccalaureate Colleges--Arts & Sciences, private not-for-profit/2", add 
label define dfrcgid 176 "Baccalaureate Colleges--Arts & Sciences, private not-for-profit/3", add 
label define dfrcgid 177 "Baccalaureate Colleges--Arts & Sciences, private not-for-profit/4", add 
label define dfrcgid 178 "Baccalaureate Colleges--Arts & Sciences, private not-for-profit/5", add 
label define dfrcgid 179 "Baccalaureate Colleges--Arts & Sciences, private not-for-profit/6", add 
label define dfrcgid 18 "Private for-profit, academic year reporter, nondegree-granting/1", add 
label define dfrcgid 180 "Baccalaureate Colleges--Arts & Sciences, private not-for-profit/7", add 
label define dfrcgid 181 "Baccalaureate Colleges--Arts & Sciences, private not-for-profit/8", add 
label define dfrcgid 182 "Baccalaureate Colleges--Diverse Fields, public/1", add 
label define dfrcgid 183 "Baccalaureate Colleges--Diverse Fields, public/2", add 
label define dfrcgid 184 "Baccalaureate Colleges--Diverse Fields, private not-for-profit/1", add 
label define dfrcgid 185 "Baccalaureate Colleges--Diverse Fields, private not-for-profit/2", add 
label define dfrcgid 186 "Baccalaureate Colleges--Diverse Fields, private not-for-profit/3", add 
label define dfrcgid 187 "Baccalaureate Colleges--Diverse Fields, private not-for-profit/4", add 
label define dfrcgid 188 "Baccalaureate Colleges--Diverse Fields, private not-for-profit/5", add 
label define dfrcgid 189 "Baccalaureate Colleges--Diverse Fields, private not-for-profit/6", add 
label define dfrcgid 19 "Private for-profit, academic year reporter, nondegree-granting/2", add 
label define dfrcgid 190 "Baccalaureate Colleges--Diverse Fields, private not-for-profit/7", add 
label define dfrcgid 191 "Baccalaureate Colleges--Diverse Fields, private not-for-profit/8", add 
label define dfrcgid 192 "Baccalaureate/Associates Colleges, public.", add 
label define dfrcgid 193 "Baccalaureate/Associates Colleges, private not-for-profit.", add 
label define dfrcgid 194 "Baccalaureate/Associates Colleges, private for-profit/1", add 
label define dfrcgid 195 "Baccalaureate/Associates Colleges, private for-profit/2", add 
label define dfrcgid 196 "Theological seminaries, Bible colleges, and other faith-related institutions, highest level-bachelors degree, undergraduate degrees/certificates offered/1", add 
label define dfrcgid 197 "Theological seminaries, Bible colleges, and other faith-related institutions, highest level-bachelors degree, undergraduate degrees/certificates offered/2", add 
label define dfrcgid 198 "Theological seminaries, Bible colleges, and other faith-related institutions, highest level-postbaccalaureate, undergraduate degrees/certificates offered/1", add 
label define dfrcgid 199 "Theological seminaries, Bible colleges, and other faith-related institutions, highest level-postbaccalaureate, undergraduate degrees/certificates offered/2", add 
label define dfrcgid 2 "Public, academic year reporter, nondegree-granting/2", add 
label define dfrcgid 20 "Private for-profit, academic year reporter, nondegree-granting/3", add 
label define dfrcgid 200 "Theological seminaries, Bible colleges, and other faith-related institutions, highest level-postbaccalaureate, undergraduate degrees/certificates not offered", add 
label define dfrcgid 201 "Theological seminaries, Bible colleges, and other faith-related institutions, highest level-PhD., undergraduate degrees/certificates offered.", add 
label define dfrcgid 202 "Theological seminaries, Bible colleges, and other faith-related institutions, highest level-PhD., undergraduate degrees or certificates are not offered/1", add 
label define dfrcgid 203 "Theological seminaries, Bible colleges, and other faith-related institutions, highest level-PhD., undergraduate degrees or certificates are not offered/2", add 
label define dfrcgid 204 "Medical schools and medical centers, public", add 
label define dfrcgid 205 "Medical schools and medical centers, private not-for-profit", add 
label define dfrcgid 206 "Other health professions schools, highest level of offering-bachelors degree.", add 
label define dfrcgid 207 "Other health professions schools, highest level of offering-postbaccalaureate/1", add 
label define dfrcgid 208 "Other health professions schools, highest level of offering-postbaccalaureate/2", add 
label define dfrcgid 209 "Other health professions schools, highest level of offering-postbaccalaureate/3", add 
label define dfrcgid 21 "Private for-profit, academic year reporter, nondegree-granting/4", add 
label define dfrcgid 210 "Schools of engineering.", add 
label define dfrcgid 211 "Other technology-related schools/1", add 
label define dfrcgid 212 "Other technology-related schools/2", add 
label define dfrcgid 213 "Schools of business and management, private not-for-profit", add 
label define dfrcgid 214 "Schools of business and management, privatefor-profit", add 
label define dfrcgid 215 "Schools of art, music, and design, highest level of offering-bachelors degree/1", add 
label define dfrcgid 216 "Schools of art, music, and design, highest level of offering-bachelors degree/2", add 
label define dfrcgid 217 "Schools of art, music, and design, highest level of offering-postbaccalaureate/1", add 
label define dfrcgid 218 "Schools of art, music, and design, highest level of offering-postbaccalaureate/2", add 
label define dfrcgid 219 "Schools of law.", add 
label define dfrcgid 22 "Private for-profit, program reporter, nondegree-granting, largest program-cosmetology/1", add 
label define dfrcgid 220 "Other special-focus institutions.", add 
label define dfrcgid 221 "Tribal Colleges.", add 
label define dfrcgid 222 "Baccalaureate Colleges--Arts & Sciences or Diverse Fields, private for-profit.", add 
label define dfrcgid 223 "Private, for-profit, 4 year, degree-granting institution, no Carnegie classification, highest degree awarded-Masters/1", add 
label define dfrcgid 224 "Private, for-profit, 4 year, degree-granting institution, no Carnegie classification, highest degree awarded-Masters/2", add 
label define dfrcgid 225 "Private, for-profit, 4 year, degree-granting institution, no Carnegie classification, highest degree awarded-Bachelors/1", add 
label define dfrcgid 226 "Private, for-profit, 4 year, degree-granting institution, no Carnegie classification, highest degree awarded-Bachelors/2", add 
label define dfrcgid 227 "Private, for-profit, 4 year, degree-granting institution, no Carnegie classification, highest degree awarded-Bachelors/3", add 
label define dfrcgid 228 "Private, not-for-profit, 4 year, degree-granting institution, no Carnegie classification.", add 
label define dfrcgid 229 "Non-Title IV, private not-for-profit, degree-granting.", add 
label define dfrcgid 23 "Private for-profit, program reporter, nondegree-granting, largest program-cosmetology/2", add 
label define dfrcgid 230 "Non-Title IV, private for-profit, degree-granting.", add 
label define dfrcgid 231 "Non-Title IV, nondegree-granting.", add 
label define dfrcgid 232 "U.S. Military Academies", add 
label define dfrcgid 233 "Title IV not primarily postsecondary public nondegree-granting.", add 
label define dfrcgid 234 "Public, 2-year degree-granting in American Samoa, Virgin Islands", add 
label define dfrcgid 235 "Public, less than 4 year in Puerto Rico.", add 
label define dfrcgid 236 "Public, 4 year, degree-granting in Puerto Rico.", add 
label define dfrcgid 237 "Private not-for-profit, degree-granting in Puerto Rico.", add 
label define dfrcgid 238 "Private not-for-profit, nondegree-granting in Puerto Rico.", add 
label define dfrcgid 239 "Private for-profit, degree-granting in Puerto Rico.", add 
label define dfrcgid 24 "Private for-profit, program reporter, nondegree-granting, largest program-cosmetology/3", add 
label define dfrcgid 240 "Private for-profit, nondegree-granting in Puerto Rico/1", add 
label define dfrcgid 241 "Private for-profit, nondegree-granting in Puerto Rico/2", add 
label define dfrcgid 25 "Private for-profit, program reporter, nondegree-granting, largest program-cosmetology/4", add 
label define dfrcgid 26 "Private for-profit, program reporter, nondegree-granting, largest program-cosmetology/5", add 
label define dfrcgid 27 "Private for-profit, program reporter, nondegree-granting, largest program-cosmetology/6", add 
label define dfrcgid 28 "Private for-profit, program reporter, nondegree-granting, largest program-cosmetology/7", add 
label define dfrcgid 29 "Private for-profit, program reporter, nondegree-granting, largest program-cosmetology/8", add 
label define dfrcgid 3 "Public, program reporter, nondegree-granting, largest program-business.", add 
label define dfrcgid 30 "Private for-profit, program reporter, nondegree-granting, largest program-cosmetology/9", add 
label define dfrcgid 31 "Private for-profit, program reporter, nondegree-granting, largest program-cosmetology/10", add 
label define dfrcgid 32 "Private for-profit, program reporter, nondegree-granting, largest program-cosmetology/11", add 
label define dfrcgid 33 "Private for-profit, program reporter, nondegree-granting, largest program-cosmetology/12", add 
label define dfrcgid 34 "Private for-profit, program reporter, nondegree-granting, largest program-cosmetology/13", add 
label define dfrcgid 35 "Private for-profit, program reporter, nondegree-granting, largest program-cosmetology/14", add 
label define dfrcgid 36 "Private for-profit, program reporter, nondegree-granting, largest program-cosmetology/15", add 
label define dfrcgid 37 "Private for-profit, program reporter, nondegree-granting, largest program-cosmetology/16", add 
label define dfrcgid 38 "Private for-profit, program reporter, nondegree-granting, largest program-cosmetology/17", add 
label define dfrcgid 39 "Private for-profit, program reporter, nondegree-granting, largest program-cosmetology/18", add 
label define dfrcgid 4 "Public, program reporter, nondegree-granting, largest program-cosmetology.", add 
label define dfrcgid 40 "Private for-profit, program reporter, nondegree-granting, largest program-cosmetology/19", add 
label define dfrcgid 41 "Private for-profit, program reporter, nondegree-granting, largest program-cosmetology/20", add 
label define dfrcgid 42 "Private for-profit, program reporter, nondegree-granting, largest program-cosmetology/21", add 
label define dfrcgid 43 "Private for-profit, program reporter, nondegree-granting, largest program-cosmetology/22", add 
label define dfrcgid 44 "Private for-profit, program reporter, nondegree-granting, largest program-cosmetology/23", add 
label define dfrcgid 45 "Private for-profit, program reporter, nondegree-granting, largest program-cosmetology/24", add 
label define dfrcgid 46 "Private for-profit, program reporter, nondegree-granting, largest program-cosmetology/25", add 
label define dfrcgid 47 "Private for-profit, program reporter, nondegree-granting, largest program-cosmetology/26", add 
label define dfrcgid 48 "Private for-profit, program reporter, nondegree-granting, largest program-cosmetology/27", add 
label define dfrcgid 49 "Private for-profit, program reporter, nondegree-granting, largest program-cosmetology/28", add 
label define dfrcgid 5 "Public, program reporter, nondegree-granting, largest program-health/1", add 
label define dfrcgid 50 "Private for-profit, program reporter, nondegree-granting, largest program-cosmetology/29", add 
label define dfrcgid 51 "Private for-profit, program reporter, nondegree-granting, largest program-cosmetology/30", add 
label define dfrcgid 52 "Private for-profit, program reporter, nondegree-granting, largest program-cosmetology/31", add 
label define dfrcgid 53 "Private for-profit, program reporter, nondegree-granting, largest program-cosmetology/32", add 
label define dfrcgid 54 "Private for-profit, program reporter, nondegree-granting, largest program-cosmetology/33", add 
label define dfrcgid 55 "Private for-profit, program reporter, nondegree-granting, largest program-cosmetology/34", add 
label define dfrcgid 56 "Private for-profit, program reporter, nondegree-granting, largest program-cosmetology/35", add 
label define dfrcgid 57 "Private for-profit, program reporter, nondegree-granting, largest program-health/1", add 
label define dfrcgid 58 "Private for-profit, program reporter, nondegree-granting, largest program-health/2", add 
label define dfrcgid 59 "Private for-profit, program reporter, nondegree-granting, largest program-health/3", add 
label define dfrcgid 6 "Public, program reporter, nondegree-granting, largest program-health/2", add 
label define dfrcgid 60 "Private for-profit, program reporter, nondegree-granting, largest program-health/4", add 
label define dfrcgid 61 "Private for-profit, program reporter, nondegree-granting, largest program-health/5", add 
label define dfrcgid 62 "Private for-profit, program reporter, nondegree-granting, largest program-health/6", add 
label define dfrcgid 63 "Private for-profit, program reporter, nondegree-granting, largest program-health/7", add 
label define dfrcgid 64 "Private for-profit, program reporter, nondegree-granting, largest program-health/8", add 
label define dfrcgid 65 "Private for-profit, program reporter, nondegree-granting, largest program-health/9", add 
label define dfrcgid 66 "Private for-profit, program reporter, nondegree-granting, largest program-health/10", add 
label define dfrcgid 67 "Private for-profit, program reporter, nondegree-granting, largest program-health/11", add 
label define dfrcgid 68 "Private for-profit, program reporter, nondegree-granting, largest program-health/12", add 
label define dfrcgid 69 "Private for-profit, program reporter, nondegree-granting, largest program-health/13", add 
label define dfrcgid 7 "Public, program reporter, nondegree-granting, largest program-health/3", add 
label define dfrcgid 70 "Private for-profit, program reporter, nondegree-granting/1", add 
label define dfrcgid 71 "Private for-profit, program reporter, nondegree-granting/2", add 
label define dfrcgid 72 "Private for-profit, program reporter, nondegree-granting/3", add 
label define dfrcgid 73 "Private for-profit, program reporter, nondegree-granting/4", add 
label define dfrcgid 74 "Private for-profit, program reporter, nondegree-granting/5", add 
label define dfrcgid 75 "Public, 2-year colleges, large size,  eastern states", add 
label define dfrcgid 76 "Public, 2-year colleges, medium size, eastern states, city locale.", add 
label define dfrcgid 77 "Public, 2-year colleges, medium size, eastern states, suburban locale.", add 
label define dfrcgid 78 "Public, 2-year colleges, medium size, eastern states, town locale.", add 
label define dfrcgid 79 "Public, 2-year colleges, medium size, eastern states, rural locale.", add 
label define dfrcgid 8 "Public, program reporter, nondegree-granting, largest program-health/4", add 
label define dfrcgid 80 "Public, 2-year colleges, small size, eastern states.", add 
label define dfrcgid 81 "Public, 2-year colleges, large size,  midwestern states/1", add 
label define dfrcgid 82 "Public, 2-year colleges, large size,  midwestern states/2", add 
label define dfrcgid 83 "Public, 2-year colleges, medium size, midwestern states, city locale.", add 
label define dfrcgid 84 "Public, 2-year colleges, medium size, midwestern states, suburban locale.", add 
label define dfrcgid 85 "Public, 2-year colleges, medium size, midwestern states, town locale.", add 
label define dfrcgid 86 "Public, 2-year colleges, medium size,  midwestern states, rural locale/1", add 
label define dfrcgid 87 "Public, 2-year colleges, medium size,  midwestern states, rural locale/2", add 
label define dfrcgid 88 "Public, 2-year colleges, small size, midwestern states/1", add 
label define dfrcgid 89 "Public, 2-year colleges, small size, midwestern states/2", add 
label define dfrcgid 9 "Public, program reporter, nondegree-granting, largest program-health/5", add 
label define dfrcgid 90 "Public, 2-year colleges, large size, southeastern states", add 
label define dfrcgid 902 "Minimum comparison group requirement - public 4-year degree-granting (Guam, Northern Marianas and Virgin Islands", add 
label define dfrcgid 904 "Minimum comparison group requirement -private <2-year in Guam", add 
label define dfrcgid 905 "Minimum comparison group requirement - non-Title IV, public 2-year, degree-granting", add 
label define dfrcgid 908 "Minimun comparison group requirement - Not primarily postsecondary private-not-for-profit institution", add 
label define dfrcgid 909 "Minimum comparison group requirement - Institution no open to the public", add 
label define dfrcgid 91 "Public, 2-year colleges, medium size, southeastern states, city locale.", add 
label define dfrcgid 92 "Public, 2-year colleges, medium size, southeastern states, suburban locale.", add 
label define dfrcgid 93 "Public, 2-year colleges, medium size, southeastern states, town locale.", add 
label define dfrcgid 94 "Public, 2-year colleges, medium size, southeastern states, rural locale/1", add 
label define dfrcgid 95 "Public, 2-year colleges, medium size, southeastern states, rural locale/2", add 
label define dfrcgid 96 "Public, 2-year colleges, small size, southeastern states, city locale.", add 
label define dfrcgid 97 "Public, 2-year colleges, small size, southeastern states, suburban locale.", add 
label define dfrcgid 98 "Public, 2-year colleges, small size, southeastern states, town locale.", add 
label define dfrcgid 99 "Public, 2-year colleges, small size, southeastern states, rural locale/1", add 
label values dfrcgid dfrcgid
tab stabbr
tab fips
tab obereg
tab opeflag
tab sector
tab iclevel
tab control
tab hloffer
tab ugoffer
tab groffer
tab hdegofr1
tab deggrant
tab hbcu
tab hospital
tab medical
tab tribal
tab locale
tab openpubl
tab act
tab deathyr
tab cyactive
tab postsec
tab pseflag
tab pset4flg
tab rptmth
tab instcat
tab ccbasic
tab ccipug
tab ccipgrad
tab ccugprof
tab ccenrprf
tab ccsizset
tab carnegie
tab tenursys
tab landgrnt
tab instsize
tab cbsa
tab cbsatype
tab csa
tab necta
tab countycd
tab cngdstcd
tab dfrcgid
summarize newid
summarize longitud
summarize latitude
save working_data/dct_hd2009.dta, replace

