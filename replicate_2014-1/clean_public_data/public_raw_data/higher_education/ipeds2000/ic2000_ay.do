* Created: 6/12/2004 10:20:12 PM
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
insheet using ic2000_ay_data_stata.csv, comma clear
label data "dct_ic2000_ay"
label variable unitid "unitid"
label variable xtuit1 "Imputation field for TUITION1 - Tuition  FTFY UG in-district"
label variable tuition1 "Tuition  FTFY UG in-district"
label variable xfee1 "Imputation field for FEE1 - In-district undergraduate required fees"
label variable fee1 "In-district undergraduate required fees"
label variable xhrchg1 "Imputation field for HRCHG1 - In-district UG per credit hour charge"
label variable hrchg1 "In-district UG per credit hour charge"
label variable xcmpfee1 "Imputation field for CMPFEE1 - In-district UG comprehensive fee"
label variable cmpfee1 "In-district UG comprehensive fee"
label variable xtuit2 "Imputation field for TUITION2 - Tuition FTFY UG in-state"
label variable tuition2 "Tuition FTFY UG in-state"
label variable xfee2 "Imputation field for FEE2 - In-state undergraduate required fees"
label variable fee2 "In-state undergraduate required fees"
label variable xhrchg2 "Imputation field for HRCHG2 - In-state UG per credit hour charge"
label variable hrchg2 "In-state UG per credit hour charge"
label variable xcmpfee2 "Imputation field for CMPFEE2 - In-state UG comprehensive fee"
label variable cmpfee2 "In-state UG comprehensive fee"
label variable xtuit3 "Imputation field for TUITION3 - Tuition FTFY UG out-of-state"
label variable tuition3 "Tuition FTFY UG out-of-state"
label variable xfee3 "Imputation field for FEE3 - Out-of-state undergraduate required fees"
label variable fee3 "Out-of-state undergraduate required fees"
label variable xhrchg3 "Imputation field for HRCHG3 - Out-of-state UG per credit hour charge"
label variable hrchg3 "Out-of-state UG per credit hour charge"
label variable xcmpfee3 "Imputation field for CMPFEE3 - Out-of-state UG comprehensive fee"
label variable cmpfee3 "Out-of-state UG comprehensive fee"
label variable xtuit5 "Imputation field for TUITION5 - Tuition  FTFY Grad in-district"
label variable tuition5 "Tuition  FTFY Grad in-district"
label variable xfee5 "Imputation field for FEE5 - In-district graduate required fees"
label variable fee5 "In-district graduate required fees"
label variable xhrchg5 "Imputation field for HRCHG5 - In-district GR per credit hour charge"
label variable hrchg5 "In-district GR per credit hour charge"
label variable xtuit6 "Imputation field for TUITION6 - Tuition  FTFY Grad in-state"
label variable tuition6 "Tuition  FTFY Grad in-state"
label variable xfee6 "Imputation field for FEE6 - In-state graduate required fees"
label variable fee6 "In-state graduate required fees"
label variable xhrchg6 "Imputation field for HRCHG6 - In-state GR per credit hour charge"
label variable hrchg6 "In-state GR per credit hour charge"
label variable xtuit7 "Imputation field for TUITION7 - Tuition  FTFY Grad out-of-state"
label variable tuition7 "Tuition  FTFY Grad out-of-state"
label variable xfee7 "Imputation field for FEE7 - Out-of-state graduate required fees"
label variable fee7 "Out-of-state graduate required fees"
label variable xhrchg7 "Imputation field for HRCHG7 - Out-of-state GR per credit hour charge"
label variable hrchg7 "Out-of-state GR per credit hour charge"
label variable xispro1 "Imputation field for ISPROF1 - Tuition FTFY Chiropractic"
label variable isprof1 "Tuition FTFY Chiropractic"
label variable xispfe1 "Imputation field for ISPFEE1 - Fees for FT in-state Chiropractic"
label variable ispfee1 "Fees for FT in-state Chiropractic"
label variable xospro1 "Imputation field for OSPROF1 - Tuition FTFY Chiro. out-of-state"
label variable osprof1 "Tuition FTFY Chiro. out-of-state"
label variable xospfe1 "Imputation field for OSPFEE1 - Fees for FT out-of-state Chiropractic"
label variable ospfee1 "Fees for FT out-of-state Chiropractic"
label variable xispro2 "Imputation field for ISPROF2 - Tuition FTFY Dentistry in-state"
label variable isprof2 "Tuition FTFY Dentistry in-state"
label variable xispfe2 "Imputation field for ISPFEE2 - Fees for Dentistry in-state"
label variable ispfee2 "Fees for Dentistry in-state"
label variable xospro2 "Imputation field for OSPROF2 - Tuition FTFY Dentistry out-state"
label variable osprof2 "Tuition FTFY Dentistry out-state"
label variable xospfe2 "Imputation field for OSPFEE2 - Fees for Dentistry out-of-state"
label variable ospfee2 "Fees for Dentistry out-of-state"
label variable xispro3 "Imputation field for ISPROF3 - Tuition FTFY Medicine in-state"
label variable isprof3 "Tuition FTFY Medicine in-state"
label variable xispfe3 "Imputation field for ISPFEE3 - Fees for Medicine in-state"
label variable ispfee3 "Fees for Medicine in-state"
label variable xospro3 "Imputation field for OSPROF3 - Tuition FTFY Medicine out-of-state"
label variable osprof3 "Tuition FTFY Medicine out-of-state"
label variable xospfe3 "Imputation field for OSPFEE3 - Fees for Medicine out-of-state"
label variable ospfee3 "Fees for Medicine out-of-state"
label variable xispro4 "Imputation field for ISPROF4 - Tuition FTFY Optometry in-state"
label variable isprof4 "Tuition FTFY Optometry in-state"
label variable xispfe4 "Imputation field for ISPFEE4 - Fees for Optometry in-state"
label variable ispfee4 "Fees for Optometry in-state"
label variable xospro4 "Imputation field for OSPROF4 - Tuition FTFY Optometry out-state"
label variable osprof4 "Tuition FTFY Optometry out-state"
label variable xospfe4 "Imputation field for OSPFEE4 - Fees for Optometry out-of-state"
label variable ospfee4 "Fees for Optometry out-of-state"
label variable xispro5 "Imputation field for ISPROF5 - Tuition FTFY Osteopathic Medicine"
label variable isprof5 "Tuition FTFY Osteopathic Medicine"
label variable xispfe5 "Imputation field for ISPFEE5 - Fees for Osteopathic in-state"
label variable ispfee5 "Fees for Osteopathic in-state"
label variable xospro5 "Imputation field for OSPROF5 - Tuition FTFY Osteopathic Medicine"
label variable osprof5 "Tuition FTFY Osteopathic Medicine"
label variable xospfe5 "Imputation field for OSPFEE5 - Fees for Osteopathic out-of-state"
label variable ospfee5 "Fees for Osteopathic out-of-state"
label variable xispro6 "Imputation field for ISPROF6 - Tuition FTFY Pharmacy in-state"
label variable isprof6 "Tuition FTFY Pharmacy in-state"
label variable xispfe6 "Imputation field for ISPFEE6 - Fees for Pharmacy in-state"
label variable ispfee6 "Fees for Pharmacy in-state"
label variable xospro6 "Imputation field for OSPROF6 - Tuition FTFY Pharmacy out-of-state"
label variable osprof6 "Tuition FTFY Pharmacy out-of-state"
label variable xospfe6 "Imputation field for OSPFEE6 - Fees for Pharmacy out-of-state"
label variable ospfee6 "Fees for Pharmacy out-of-state"
label variable xispro7 "Imputation field for ISPROF7 - Tuition FTFY Podiatry in-state"
label variable isprof7 "Tuition FTFY Podiatry in-state"
label variable xispfe7 "Imputation field for ISPFEE7 - Fees for Podiatry in-state"
label variable ispfee7 "Fees for Podiatry in-state"
label variable xospro7 "Imputation field for OSPROF7 - Tuition FTFY Podiatry out-of-state"
label variable osprof7 "Tuition FTFY Podiatry out-of-state"
label variable xospfe7 "Imputation field for OSPFEE7 - Fees for Podiatry out-of-state"
label variable ospfee7 "Fees for Podiatry out-of-state"
label variable xispro8 "Imputation field for ISPROF8 - Tuition FTFY Veterinary Medicine"
label variable isprof8 "Tuition FTFY Veterinary Medicine"
label variable xispfe8 "Imputation field for ISPFEE8 - Fees for Veterinary in-state"
label variable ispfee8 "Fees for Veterinary in-state"
label variable xospro8 "Imputation field for OSPROF8 - Tuition FTFY Veterinary Medicine"
label variable osprof8 "Tuition FTFY Veterinary Medicine"
label variable xospfe8 "Imputation field for OSPFEE8 - Fees for Veterinary out-of-state"
label variable ospfee8 "Fees for Veterinary out-of-state"
label variable xispro9 "Imputation field for ISPROF9 - Tuition FTFY Law in-state"
label variable isprof9 "Tuition FTFY Law in-state"
label variable xispfe9 "Imputation field for ISPFEE9 - Fees for Law in-state"
label variable ispfee9 "Fees for Law in-state"
label variable xospro9 "Imputation field for OSPROF9 - Tuition FTFY Law out-of-state"
label variable osprof9 "Tuition FTFY Law out-of-state"
label variable xospfe9 "Imputation field for OSPFEE9 - Fees for Law out-of-state"
label variable ospfee9 "Fees for Law out-of-state"
label variable xispro10 "Imputation field for ISPROF10 - Tuition FTFY Theology in-state"
label variable isprof10 "Tuition FTFY Theology in-state"
label variable xispfe10 "Imputation field for ISPFEE10 - Fees for Theology in-state"
label variable ispfee10 "Fees for Theology in-state"
label variable xospro10 "Imputation field for OSPROF10 - Tuition FTFY Theology out-of-state"
label variable osprof10 "Tuition FTFY Theology out-of-state"
label variable xospfe10 "Imputation field for OSPFEE10 - Fees for Theology out-of-state"
label variable ospfee10 "Fees for Theology out-of-state"
label variable xispro11 "Imputation field for ISPROF11 - Tuition FTFY Other 1stP, in-state"
label variable isprof11 "Tuition FTFY Other 1stP, in-state"
label variable xispfe11 "Imputation field for ISPFEE11 - Fees for Other 1stP in-state"
label variable ispfee11 "Fees for Other 1stP in-state"
label variable xospro11 "Imputation field for OSPROF11 - Tuition FTFY Other 1stP, out-state"
label variable osprof11 "Tuition FTFY Other 1stP, out-state"
label variable xospfe11 "Imputation field for OSPFEE11 - Fees for Other 1stP out-of-state"
label variable ospfee11 "Fees for Other 1stP out-of-state"
label variable xchg1ay1 "Imputation field for chg1ay1 - Published in-district tuition and fees  1998-1999"
label variable chg1ay1 "Published in-district tuition and fees  1998-1999"
label variable xchg1ay2 "Imputation field for chg1ay2 - Published in-district tuition and fees  1999-2000"
label variable chg1ay2 "Published in-district tuition and fees  1999-2000"
label variable xchg1ay3 "Imputation field for chg1ay3 - Published in-district tuition and fees  2000-2001"
label variable chg1ay3 "Published in-district tuition and fees  2000-2001"
label variable xchg2ay1 "Imputation field for chg2ay1 - Published in-state tuition and fees 1998-1999"
label variable chg2ay1 "Published in-state tuition and fees 1998-1999"
label variable xchg2ay2 "Imputation field for chg2ay2 - Published in-state tuition and fees 1999-2000"
label variable chg2ay2 "Published in-state tuition and fees 1999-2000"
label variable xchg2ay3 "Imputation field for chg2ay3 - Published in-state tuition and fees 2000-2001"
label variable chg2ay3 "Published in-state tuition and fees 2000-2001"
label variable xchg3ay1 "Imputation field for chg3ay1 - Published out-of-state tuition and fees  1998-1999"
label variable chg3ay1 "Published out-of-state tuition and fees  1998-1999"
label variable xchg3ay2 "Imputation field for chg3ay2 - Published out-of-state tuition and fees  1999-2000"
label variable chg3ay2 "Published out-of-state tuition and fees  1999-2000"
label variable xchg3ay3 "Imputation field for chg3ay3 - Published out-of-state tuition and fees  2000-2001"
label variable chg3ay3 "Published out-of-state tuition and fees  2000-2001"
label variable xchg4ay1 "Imputation field for chg4ay1 - Books and supplies 1998-1999"
label variable chg4ay1 "Books and supplies 1998-1999"
label variable xchg4ay2 "Imputation field for chg4ay2 - Books and supplies 1999-2000"
label variable chg4ay2 "Books and supplies 1999-2000"
label variable xchg4ay3 "Imputation field for chg4ay3 - Books and supplies 2000-2001"
label variable chg4ay3 "Books and supplies 2000-2001"
label variable xchg5ay1 "Imputation field for chg5ay1 - On campus, room and board 1998-1999"
label variable chg5ay1 "On campus, room and board 1998-1999"
label variable xchg5ay2 "Imputation field for chg5ay2 - On campus, room and board 1999-2000"
label variable chg5ay2 "On campus, room and board 1999-2000"
label variable xchg5ay3 "Imputation field for chg5ay3 - On campus, room and board 2000-2001"
label variable chg5ay3 "On campus, room and board 2000-2001"
label variable xchg6ay1 "Imputation field for chg6ay1 - On campus, other expenses 1998-1999"
label variable chg6ay1 "On campus, other expenses 1998-1999"
label variable xchg6ay2 "Imputation field for chg6ay2 - On campus, other expenses 1999-2000"
label variable chg6ay2 "On campus, other expenses 1999-2000"
label variable xchg6ay3 "Imputation field for chg6ay3 - On campus, other expenses 2000-2001"
label variable chg6ay3 "On campus, other expenses 2000-2001"
label variable xchg7ay1 "Imputation field for chg7ay1 - Off campus (not with family), room and board 1998-1999"
label variable chg7ay1 "Off campus (not with family), room and board 1998-1999"
label variable xchg7ay2 "Imputation field for chg7ay2 - Off campus (not with family), room and board 1999-2000"
label variable chg7ay2 "Off campus (not with family), room and board 1999-2000"
label variable xchg7ay3 "Imputation field for chg7ay3 - Off campus (not with family), room and board 2000-2001"
label variable chg7ay3 "Off campus (not with family), room and board 2000-2001"
label variable xchg8ay1 "Imputation field for chg8ay1 - Off campus (not with family), other expenses 1998-1999"
label variable chg8ay1 "Off campus (not with family), other expenses 1998-1999"
label variable xchg8ay2 "Imputation field for chg8ay2 - Off campus (not with family), other expenses 1999-2000"
label variable chg8ay2 "Off campus (not with family), other expenses 1999-2000"
label variable xchg8ay3 "Imputation field for chg8ay3 - Off campus (not with family), other expenses 2000-2001"
label variable chg8ay3 "Off campus (not with family), other expenses 2000-2001"
label variable xchg9ay1 "Imputation field for chg9ay1 - Off campus (with family), other expenses 1998-1999"
label variable chg9ay1 "Off campus (with family), other expenses 1998-1999"
label variable xchg9ay2 "Imputation field for chg9ay2 - Off campus (with family), other expenses 1999-2000"
label variable chg9ay2 "Off campus (with family), other expenses 1999-2000"
label variable xchg9ay3 "Imputation field for chg9ay3 - Off campus (with family), other expenses 2000-2001"
label variable chg9ay3 "Off campus (with family), other expenses 2000-2001"
label define xtuit1 10 "Reported" 
label define xtuit1 11 "Analyst corrected reported value", add 
label define xtuit1 12 "Data generated from other data values", add 
label define xtuit1 13 "Implied zero", add 
label define xtuit1 20 "Imputed using Carry Forward procedure", add 
label define xtuit1 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xtuit1 30 "Not applicable", add 
label define xtuit1 31 "Institution left item blank", add 
label define xtuit1 32 "Do not know", add 
label define xtuit1 40 "Suppressed to protect confidentiality", add 
label values xtuit1 xtuit1
label define xfee1 10 "Reported" 
label define xfee1 11 "Analyst corrected reported value", add 
label define xfee1 12 "Data generated from other data values", add 
label define xfee1 13 "Implied zero", add 
label define xfee1 20 "Imputed using Carry Forward procedure", add 
label define xfee1 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xfee1 30 "Not applicable", add 
label define xfee1 31 "Institution left item blank", add 
label define xfee1 32 "Do not know", add 
label define xfee1 40 "Suppressed to protect confidentiality", add 
label values xfee1 xfee1
label define xhrchg1 10 "Reported" 
label define xhrchg1 11 "Analyst corrected reported value", add 
label define xhrchg1 12 "Data generated from other data values", add 
label define xhrchg1 13 "Implied zero", add 
label define xhrchg1 20 "Imputed using Carry Forward procedure", add 
label define xhrchg1 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xhrchg1 30 "Not applicable", add 
label define xhrchg1 31 "Institution left item blank", add 
label define xhrchg1 32 "Do not know", add 
label define xhrchg1 40 "Suppressed to protect confidentiality", add 
label values xhrchg1 xhrchg1
label define xcmpfee1 10 "Reported" 
label define xcmpfee1 11 "Analyst corrected reported value", add 
label define xcmpfee1 12 "Data generated from other data values", add 
label define xcmpfee1 13 "Implied zero", add 
label define xcmpfee1 20 "Imputed using Carry Forward procedure", add 
label define xcmpfee1 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xcmpfee1 30 "Not applicable", add 
label define xcmpfee1 31 "Institution left item blank", add 
label define xcmpfee1 32 "Do not know", add 
label define xcmpfee1 40 "Suppressed to protect confidentiality", add 
label values xcmpfee1 xcmpfee1
label define xtuit2 10 "Reported" 
label define xtuit2 11 "Analyst corrected reported value", add 
label define xtuit2 12 "Data generated from other data values", add 
label define xtuit2 13 "Implied zero", add 
label define xtuit2 20 "Imputed using Carry Forward procedure", add 
label define xtuit2 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xtuit2 30 "Not applicable", add 
label define xtuit2 31 "Institution left item blank", add 
label define xtuit2 32 "Do not know", add 
label define xtuit2 40 "Suppressed to protect confidentiality", add 
label values xtuit2 xtuit2
label define xfee2 10 "Reported" 
label define xfee2 11 "Analyst corrected reported value", add 
label define xfee2 12 "Data generated from other data values", add 
label define xfee2 13 "Implied zero", add 
label define xfee2 20 "Imputed using Carry Forward procedure", add 
label define xfee2 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xfee2 30 "Not applicable", add 
label define xfee2 31 "Institution left item blank", add 
label define xfee2 32 "Do not know", add 
label define xfee2 40 "Suppressed to protect confidentiality", add 
label values xfee2 xfee2
label define xhrchg2 10 "Reported" 
label define xhrchg2 11 "Analyst corrected reported value", add 
label define xhrchg2 12 "Data generated from other data values", add 
label define xhrchg2 13 "Implied zero", add 
label define xhrchg2 20 "Imputed using Carry Forward procedure", add 
label define xhrchg2 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xhrchg2 30 "Not applicable", add 
label define xhrchg2 31 "Institution left item blank", add 
label define xhrchg2 32 "Do not know", add 
label define xhrchg2 40 "Suppressed to protect confidentiality", add 
label values xhrchg2 xhrchg2
label define xcmpfee2 10 "Reported" 
label define xcmpfee2 11 "Analyst corrected reported value", add 
label define xcmpfee2 12 "Data generated from other data values", add 
label define xcmpfee2 13 "Implied zero", add 
label define xcmpfee2 20 "Imputed using Carry Forward procedure", add 
label define xcmpfee2 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xcmpfee2 30 "Not applicable", add 
label define xcmpfee2 31 "Institution left item blank", add 
label define xcmpfee2 32 "Do not know", add 
label define xcmpfee2 40 "Suppressed to protect confidentiality", add 
label values xcmpfee2 xcmpfee2
label define xtuit3 10 "Reported" 
label define xtuit3 11 "Analyst corrected reported value", add 
label define xtuit3 12 "Data generated from other data values", add 
label define xtuit3 13 "Implied zero", add 
label define xtuit3 20 "Imputed using Carry Forward procedure", add 
label define xtuit3 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xtuit3 30 "Not applicable", add 
label define xtuit3 31 "Institution left item blank", add 
label define xtuit3 32 "Do not know", add 
label define xtuit3 40 "Suppressed to protect confidentiality", add 
label values xtuit3 xtuit3
label define xfee3 10 "Reported" 
label define xfee3 11 "Analyst corrected reported value", add 
label define xfee3 12 "Data generated from other data values", add 
label define xfee3 13 "Implied zero", add 
label define xfee3 20 "Imputed using Carry Forward procedure", add 
label define xfee3 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xfee3 30 "Not applicable", add 
label define xfee3 31 "Institution left item blank", add 
label define xfee3 32 "Do not know", add 
label define xfee3 40 "Suppressed to protect confidentiality", add 
label values xfee3 xfee3
label define xhrchg3 10 "Reported" 
label define xhrchg3 11 "Analyst corrected reported value", add 
label define xhrchg3 12 "Data generated from other data values", add 
label define xhrchg3 13 "Implied zero", add 
label define xhrchg3 20 "Imputed using Carry Forward procedure", add 
label define xhrchg3 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xhrchg3 30 "Not applicable", add 
label define xhrchg3 31 "Institution left item blank", add 
label define xhrchg3 32 "Do not know", add 
label define xhrchg3 40 "Suppressed to protect confidentiality", add 
label values xhrchg3 xhrchg3
label define xcmpfee3 10 "Reported" 
label define xcmpfee3 11 "Analyst corrected reported value", add 
label define xcmpfee3 12 "Data generated from other data values", add 
label define xcmpfee3 13 "Implied zero", add 
label define xcmpfee3 20 "Imputed using Carry Forward procedure", add 
label define xcmpfee3 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xcmpfee3 30 "Not applicable", add 
label define xcmpfee3 31 "Institution left item blank", add 
label define xcmpfee3 32 "Do not know", add 
label define xcmpfee3 40 "Suppressed to protect confidentiality", add 
label values xcmpfee3 xcmpfee3
label define xtuit5 10 "Reported" 
label define xtuit5 11 "Analyst corrected reported value", add 
label define xtuit5 12 "Data generated from other data values", add 
label define xtuit5 13 "Implied zero", add 
label define xtuit5 20 "Imputed using Carry Forward procedure", add 
label define xtuit5 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xtuit5 30 "Not applicable", add 
label define xtuit5 31 "Institution left item blank", add 
label define xtuit5 32 "Do not know", add 
label define xtuit5 40 "Suppressed to protect confidentiality", add 
label values xtuit5 xtuit5
label define xfee5 10 "Reported" 
label define xfee5 11 "Analyst corrected reported value", add 
label define xfee5 12 "Data generated from other data values", add 
label define xfee5 13 "Implied zero", add 
label define xfee5 20 "Imputed using Carry Forward procedure", add 
label define xfee5 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xfee5 30 "Not applicable", add 
label define xfee5 31 "Institution left item blank", add 
label define xfee5 32 "Do not know", add 
label define xfee5 40 "Suppressed to protect confidentiality", add 
label values xfee5 xfee5
label define xhrchg5 10 "Reported" 
label define xhrchg5 11 "Analyst corrected reported value", add 
label define xhrchg5 12 "Data generated from other data values", add 
label define xhrchg5 13 "Implied zero", add 
label define xhrchg5 20 "Imputed using Carry Forward procedure", add 
label define xhrchg5 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xhrchg5 30 "Not applicable", add 
label define xhrchg5 31 "Institution left item blank", add 
label define xhrchg5 32 "Do not know", add 
label define xhrchg5 40 "Suppressed to protect confidentiality", add 
label values xhrchg5 xhrchg5
label define xtuit6 10 "Reported" 
label define xtuit6 11 "Analyst corrected reported value", add 
label define xtuit6 12 "Data generated from other data values", add 
label define xtuit6 13 "Implied zero", add 
label define xtuit6 20 "Imputed using Carry Forward procedure", add 
label define xtuit6 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xtuit6 30 "Not applicable", add 
label define xtuit6 31 "Institution left item blank", add 
label define xtuit6 32 "Do not know", add 
label define xtuit6 40 "Suppressed to protect confidentiality", add 
label values xtuit6 xtuit6
label define xfee6 10 "Reported" 
label define xfee6 11 "Analyst corrected reported value", add 
label define xfee6 12 "Data generated from other data values", add 
label define xfee6 13 "Implied zero", add 
label define xfee6 20 "Imputed using Carry Forward procedure", add 
label define xfee6 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xfee6 30 "Not applicable", add 
label define xfee6 31 "Institution left item blank", add 
label define xfee6 32 "Do not know", add 
label define xfee6 40 "Suppressed to protect confidentiality", add 
label values xfee6 xfee6
label define xhrchg6 10 "Reported" 
label define xhrchg6 11 "Analyst corrected reported value", add 
label define xhrchg6 12 "Data generated from other data values", add 
label define xhrchg6 13 "Implied zero", add 
label define xhrchg6 20 "Imputed using Carry Forward procedure", add 
label define xhrchg6 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xhrchg6 30 "Not applicable", add 
label define xhrchg6 31 "Institution left item blank", add 
label define xhrchg6 32 "Do not know", add 
label define xhrchg6 40 "Suppressed to protect confidentiality", add 
label values xhrchg6 xhrchg6
label define xtuit7 10 "Reported" 
label define xtuit7 11 "Analyst corrected reported value", add 
label define xtuit7 12 "Data generated from other data values", add 
label define xtuit7 13 "Implied zero", add 
label define xtuit7 20 "Imputed using Carry Forward procedure", add 
label define xtuit7 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xtuit7 30 "Not applicable", add 
label define xtuit7 31 "Institution left item blank", add 
label define xtuit7 32 "Do not know", add 
label define xtuit7 40 "Suppressed to protect confidentiality", add 
label values xtuit7 xtuit7
label define xfee7 10 "Reported" 
label define xfee7 11 "Analyst corrected reported value", add 
label define xfee7 12 "Data generated from other data values", add 
label define xfee7 13 "Implied zero", add 
label define xfee7 20 "Imputed using Carry Forward procedure", add 
label define xfee7 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xfee7 30 "Not applicable", add 
label define xfee7 31 "Institution left item blank", add 
label define xfee7 32 "Do not know", add 
label define xfee7 40 "Suppressed to protect confidentiality", add 
label values xfee7 xfee7
label define xhrchg7 10 "Reported" 
label define xhrchg7 11 "Analyst corrected reported value", add 
label define xhrchg7 12 "Data generated from other data values", add 
label define xhrchg7 13 "Implied zero", add 
label define xhrchg7 20 "Imputed using Carry Forward procedure", add 
label define xhrchg7 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xhrchg7 30 "Not applicable", add 
label define xhrchg7 31 "Institution left item blank", add 
label define xhrchg7 32 "Do not know", add 
label define xhrchg7 40 "Suppressed to protect confidentiality", add 
label values xhrchg7 xhrchg7
label define xispro1 10 "Reported" 
label define xispro1 11 "Analyst corrected reported value", add 
label define xispro1 12 "Data generated from other data values", add 
label define xispro1 13 "Implied zero", add 
label define xispro1 20 "Imputed using Carry Forward procedure", add 
label define xispro1 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xispro1 30 "Not applicable", add 
label define xispro1 31 "Institution left item blank", add 
label define xispro1 32 "Do not know", add 
label define xispro1 40 "Suppressed to protect confidentiality", add 
label values xispro1 xispro1
label define xispfe1 10 "Reported" 
label define xispfe1 11 "Analyst corrected reported value", add 
label define xispfe1 12 "Data generated from other data values", add 
label define xispfe1 13 "Implied zero", add 
label define xispfe1 20 "Imputed using Carry Forward procedure", add 
label define xispfe1 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xispfe1 30 "Not applicable", add 
label define xispfe1 31 "Institution left item blank", add 
label define xispfe1 32 "Do not know", add 
label define xispfe1 40 "Suppressed to protect confidentiality", add 
label values xispfe1 xispfe1
label define xospro1 10 "Reported" 
label define xospro1 11 "Analyst corrected reported value", add 
label define xospro1 12 "Data generated from other data values", add 
label define xospro1 13 "Implied zero", add 
label define xospro1 20 "Imputed using Carry Forward procedure", add 
label define xospro1 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xospro1 30 "Not applicable", add 
label define xospro1 31 "Institution left item blank", add 
label define xospro1 32 "Do not know", add 
label define xospro1 40 "Suppressed to protect confidentiality", add 
label values xospro1 xospro1
label define xospfe1 10 "Reported" 
label define xospfe1 11 "Analyst corrected reported value", add 
label define xospfe1 12 "Data generated from other data values", add 
label define xospfe1 13 "Implied zero", add 
label define xospfe1 20 "Imputed using Carry Forward procedure", add 
label define xospfe1 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xospfe1 30 "Not applicable", add 
label define xospfe1 31 "Institution left item blank", add 
label define xospfe1 32 "Do not know", add 
label define xospfe1 40 "Suppressed to protect confidentiality", add 
label values xospfe1 xospfe1
label define xispro2 10 "Reported" 
label define xispro2 11 "Analyst corrected reported value", add 
label define xispro2 12 "Data generated from other data values", add 
label define xispro2 13 "Implied zero", add 
label define xispro2 20 "Imputed using Carry Forward procedure", add 
label define xispro2 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xispro2 30 "Not applicable", add 
label define xispro2 31 "Institution left item blank", add 
label define xispro2 32 "Do not know", add 
label define xispro2 40 "Suppressed to protect confidentiality", add 
label values xispro2 xispro2
label define xispfe2 10 "Reported" 
label define xispfe2 11 "Analyst corrected reported value", add 
label define xispfe2 12 "Data generated from other data values", add 
label define xispfe2 13 "Implied zero", add 
label define xispfe2 20 "Imputed using Carry Forward procedure", add 
label define xispfe2 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xispfe2 30 "Not applicable", add 
label define xispfe2 31 "Institution left item blank", add 
label define xispfe2 32 "Do not know", add 
label define xispfe2 40 "Suppressed to protect confidentiality", add 
label values xispfe2 xispfe2
label define xospro2 10 "Reported" 
label define xospro2 11 "Analyst corrected reported value", add 
label define xospro2 12 "Data generated from other data values", add 
label define xospro2 13 "Implied zero", add 
label define xospro2 20 "Imputed using Carry Forward procedure", add 
label define xospro2 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xospro2 30 "Not applicable", add 
label define xospro2 31 "Institution left item blank", add 
label define xospro2 32 "Do not know", add 
label define xospro2 40 "Suppressed to protect confidentiality", add 
label values xospro2 xospro2
label define xospfe2 10 "Reported" 
label define xospfe2 11 "Analyst corrected reported value", add 
label define xospfe2 12 "Data generated from other data values", add 
label define xospfe2 13 "Implied zero", add 
label define xospfe2 20 "Imputed using Carry Forward procedure", add 
label define xospfe2 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xospfe2 30 "Not applicable", add 
label define xospfe2 31 "Institution left item blank", add 
label define xospfe2 32 "Do not know", add 
label define xospfe2 40 "Suppressed to protect confidentiality", add 
label values xospfe2 xospfe2
label define xispro3 10 "Reported" 
label define xispro3 11 "Analyst corrected reported value", add 
label define xispro3 12 "Data generated from other data values", add 
label define xispro3 13 "Implied zero", add 
label define xispro3 20 "Imputed using Carry Forward procedure", add 
label define xispro3 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xispro3 30 "Not applicable", add 
label define xispro3 31 "Institution left item blank", add 
label define xispro3 32 "Do not know", add 
label define xispro3 40 "Suppressed to protect confidentiality", add 
label values xispro3 xispro3
label define xispfe3 10 "Reported" 
label define xispfe3 11 "Analyst corrected reported value", add 
label define xispfe3 12 "Data generated from other data values", add 
label define xispfe3 13 "Implied zero", add 
label define xispfe3 20 "Imputed using Carry Forward procedure", add 
label define xispfe3 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xispfe3 30 "Not applicable", add 
label define xispfe3 31 "Institution left item blank", add 
label define xispfe3 32 "Do not know", add 
label define xispfe3 40 "Suppressed to protect confidentiality", add 
label values xispfe3 xispfe3
label define xospro3 10 "Reported" 
label define xospro3 11 "Analyst corrected reported value", add 
label define xospro3 12 "Data generated from other data values", add 
label define xospro3 13 "Implied zero", add 
label define xospro3 20 "Imputed using Carry Forward procedure", add 
label define xospro3 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xospro3 30 "Not applicable", add 
label define xospro3 31 "Institution left item blank", add 
label define xospro3 32 "Do not know", add 
label define xospro3 40 "Suppressed to protect confidentiality", add 
label values xospro3 xospro3
label define xospfe3 10 "Reported" 
label define xospfe3 11 "Analyst corrected reported value", add 
label define xospfe3 12 "Data generated from other data values", add 
label define xospfe3 13 "Implied zero", add 
label define xospfe3 20 "Imputed using Carry Forward procedure", add 
label define xospfe3 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xospfe3 30 "Not applicable", add 
label define xospfe3 31 "Institution left item blank", add 
label define xospfe3 32 "Do not know", add 
label define xospfe3 40 "Suppressed to protect confidentiality", add 
label values xospfe3 xospfe3
label define xispro4 10 "Reported" 
label define xispro4 11 "Analyst corrected reported value", add 
label define xispro4 12 "Data generated from other data values", add 
label define xispro4 13 "Implied zero", add 
label define xispro4 20 "Imputed using Carry Forward procedure", add 
label define xispro4 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xispro4 30 "Not applicable", add 
label define xispro4 31 "Institution left item blank", add 
label define xispro4 32 "Do not know", add 
label define xispro4 40 "Suppressed to protect confidentiality", add 
label values xispro4 xispro4
label define xispfe4 10 "Reported" 
label define xispfe4 11 "Analyst corrected reported value", add 
label define xispfe4 12 "Data generated from other data values", add 
label define xispfe4 13 "Implied zero", add 
label define xispfe4 20 "Imputed using Carry Forward procedure", add 
label define xispfe4 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xispfe4 30 "Not applicable", add 
label define xispfe4 31 "Institution left item blank", add 
label define xispfe4 32 "Do not know", add 
label define xispfe4 40 "Suppressed to protect confidentiality", add 
label values xispfe4 xispfe4
label define xospro4 10 "Reported" 
label define xospro4 11 "Analyst corrected reported value", add 
label define xospro4 12 "Data generated from other data values", add 
label define xospro4 13 "Implied zero", add 
label define xospro4 20 "Imputed using Carry Forward procedure", add 
label define xospro4 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xospro4 30 "Not applicable", add 
label define xospro4 31 "Institution left item blank", add 
label define xospro4 32 "Do not know", add 
label define xospro4 40 "Suppressed to protect confidentiality", add 
label values xospro4 xospro4
label define xospfe4 10 "Reported" 
label define xospfe4 11 "Analyst corrected reported value", add 
label define xospfe4 12 "Data generated from other data values", add 
label define xospfe4 13 "Implied zero", add 
label define xospfe4 20 "Imputed using Carry Forward procedure", add 
label define xospfe4 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xospfe4 30 "Not applicable", add 
label define xospfe4 31 "Institution left item blank", add 
label define xospfe4 32 "Do not know", add 
label define xospfe4 40 "Suppressed to protect confidentiality", add 
label values xospfe4 xospfe4
label define xispro5 10 "Reported" 
label define xispro5 11 "Analyst corrected reported value", add 
label define xispro5 12 "Data generated from other data values", add 
label define xispro5 13 "Implied zero", add 
label define xispro5 20 "Imputed using Carry Forward procedure", add 
label define xispro5 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xispro5 30 "Not applicable", add 
label define xispro5 31 "Institution left item blank", add 
label define xispro5 32 "Do not know", add 
label define xispro5 40 "Suppressed to protect confidentiality", add 
label values xispro5 xispro5
label define xispfe5 10 "Reported" 
label define xispfe5 11 "Analyst corrected reported value", add 
label define xispfe5 12 "Data generated from other data values", add 
label define xispfe5 13 "Implied zero", add 
label define xispfe5 20 "Imputed using Carry Forward procedure", add 
label define xispfe5 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xispfe5 30 "Not applicable", add 
label define xispfe5 31 "Institution left item blank", add 
label define xispfe5 32 "Do not know", add 
label define xispfe5 40 "Suppressed to protect confidentiality", add 
label values xispfe5 xispfe5
label define xospro5 10 "Reported" 
label define xospro5 11 "Analyst corrected reported value", add 
label define xospro5 12 "Data generated from other data values", add 
label define xospro5 13 "Implied zero", add 
label define xospro5 20 "Imputed using Carry Forward procedure", add 
label define xospro5 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xospro5 30 "Not applicable", add 
label define xospro5 31 "Institution left item blank", add 
label define xospro5 32 "Do not know", add 
label define xospro5 40 "Suppressed to protect confidentiality", add 
label values xospro5 xospro5
label define xospfe5 10 "Reported" 
label define xospfe5 11 "Analyst corrected reported value", add 
label define xospfe5 12 "Data generated from other data values", add 
label define xospfe5 13 "Implied zero", add 
label define xospfe5 20 "Imputed using Carry Forward procedure", add 
label define xospfe5 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xospfe5 30 "Not applicable", add 
label define xospfe5 31 "Institution left item blank", add 
label define xospfe5 32 "Do not know", add 
label define xospfe5 40 "Suppressed to protect confidentiality", add 
label values xospfe5 xospfe5
label define xispro6 10 "Reported" 
label define xispro6 11 "Analyst corrected reported value", add 
label define xispro6 12 "Data generated from other data values", add 
label define xispro6 13 "Implied zero", add 
label define xispro6 20 "Imputed using Carry Forward procedure", add 
label define xispro6 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xispro6 30 "Not applicable", add 
label define xispro6 31 "Institution left item blank", add 
label define xispro6 32 "Do not know", add 
label define xispro6 40 "Suppressed to protect confidentiality", add 
label values xispro6 xispro6
label define xispfe6 10 "Reported" 
label define xispfe6 11 "Analyst corrected reported value", add 
label define xispfe6 12 "Data generated from other data values", add 
label define xispfe6 13 "Implied zero", add 
label define xispfe6 20 "Imputed using Carry Forward procedure", add 
label define xispfe6 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xispfe6 30 "Not applicable", add 
label define xispfe6 31 "Institution left item blank", add 
label define xispfe6 32 "Do not know", add 
label define xispfe6 40 "Suppressed to protect confidentiality", add 
label values xispfe6 xispfe6
label define xospro6 10 "Reported" 
label define xospro6 11 "Analyst corrected reported value", add 
label define xospro6 12 "Data generated from other data values", add 
label define xospro6 13 "Implied zero", add 
label define xospro6 20 "Imputed using Carry Forward procedure", add 
label define xospro6 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xospro6 30 "Not applicable", add 
label define xospro6 31 "Institution left item blank", add 
label define xospro6 32 "Do not know", add 
label define xospro6 40 "Suppressed to protect confidentiality", add 
label values xospro6 xospro6
label define xospfe6 10 "Reported" 
label define xospfe6 11 "Analyst corrected reported value", add 
label define xospfe6 12 "Data generated from other data values", add 
label define xospfe6 13 "Implied zero", add 
label define xospfe6 20 "Imputed using Carry Forward procedure", add 
label define xospfe6 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xospfe6 30 "Not applicable", add 
label define xospfe6 31 "Institution left item blank", add 
label define xospfe6 32 "Do not know", add 
label define xospfe6 40 "Suppressed to protect confidentiality", add 
label values xospfe6 xospfe6
label define xispro7 10 "Reported" 
label define xispro7 11 "Analyst corrected reported value", add 
label define xispro7 12 "Data generated from other data values", add 
label define xispro7 13 "Implied zero", add 
label define xispro7 20 "Imputed using Carry Forward procedure", add 
label define xispro7 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xispro7 30 "Not applicable", add 
label define xispro7 31 "Institution left item blank", add 
label define xispro7 32 "Do not know", add 
label define xispro7 40 "Suppressed to protect confidentiality", add 
label values xispro7 xispro7
label define xispfe7 10 "Reported" 
label define xispfe7 11 "Analyst corrected reported value", add 
label define xispfe7 12 "Data generated from other data values", add 
label define xispfe7 13 "Implied zero", add 
label define xispfe7 20 "Imputed using Carry Forward procedure", add 
label define xispfe7 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xispfe7 30 "Not applicable", add 
label define xispfe7 31 "Institution left item blank", add 
label define xispfe7 32 "Do not know", add 
label define xispfe7 40 "Suppressed to protect confidentiality", add 
label values xispfe7 xispfe7
label define xospro7 10 "Reported" 
label define xospro7 11 "Analyst corrected reported value", add 
label define xospro7 12 "Data generated from other data values", add 
label define xospro7 13 "Implied zero", add 
label define xospro7 20 "Imputed using Carry Forward procedure", add 
label define xospro7 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xospro7 30 "Not applicable", add 
label define xospro7 31 "Institution left item blank", add 
label define xospro7 32 "Do not know", add 
label define xospro7 40 "Suppressed to protect confidentiality", add 
label values xospro7 xospro7
label define xospfe7 10 "Reported" 
label define xospfe7 11 "Analyst corrected reported value", add 
label define xospfe7 12 "Data generated from other data values", add 
label define xospfe7 13 "Implied zero", add 
label define xospfe7 20 "Imputed using Carry Forward procedure", add 
label define xospfe7 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xospfe7 30 "Not applicable", add 
label define xospfe7 31 "Institution left item blank", add 
label define xospfe7 32 "Do not know", add 
label define xospfe7 40 "Suppressed to protect confidentiality", add 
label values xospfe7 xospfe7
label define xispro8 10 "Reported" 
label define xispro8 11 "Analyst corrected reported value", add 
label define xispro8 12 "Data generated from other data values", add 
label define xispro8 13 "Implied zero", add 
label define xispro8 20 "Imputed using Carry Forward procedure", add 
label define xispro8 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xispro8 30 "Not applicable", add 
label define xispro8 31 "Institution left item blank", add 
label define xispro8 32 "Do not know", add 
label define xispro8 40 "Suppressed to protect confidentiality", add 
label values xispro8 xispro8
label define xispfe8 10 "Reported" 
label define xispfe8 11 "Analyst corrected reported value", add 
label define xispfe8 12 "Data generated from other data values", add 
label define xispfe8 13 "Implied zero", add 
label define xispfe8 20 "Imputed using Carry Forward procedure", add 
label define xispfe8 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xispfe8 30 "Not applicable", add 
label define xispfe8 31 "Institution left item blank", add 
label define xispfe8 32 "Do not know", add 
label define xispfe8 40 "Suppressed to protect confidentiality", add 
label values xispfe8 xispfe8
label define xospro8 10 "Reported" 
label define xospro8 11 "Analyst corrected reported value", add 
label define xospro8 12 "Data generated from other data values", add 
label define xospro8 13 "Implied zero", add 
label define xospro8 20 "Imputed using Carry Forward procedure", add 
label define xospro8 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xospro8 30 "Not applicable", add 
label define xospro8 31 "Institution left item blank", add 
label define xospro8 32 "Do not know", add 
label define xospro8 40 "Suppressed to protect confidentiality", add 
label values xospro8 xospro8
label define xospfe8 10 "Reported" 
label define xospfe8 11 "Analyst corrected reported value", add 
label define xospfe8 12 "Data generated from other data values", add 
label define xospfe8 13 "Implied zero", add 
label define xospfe8 20 "Imputed using Carry Forward procedure", add 
label define xospfe8 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xospfe8 30 "Not applicable", add 
label define xospfe8 31 "Institution left item blank", add 
label define xospfe8 32 "Do not know", add 
label define xospfe8 40 "Suppressed to protect confidentiality", add 
label values xospfe8 xospfe8
label define xispro9 10 "Reported" 
label define xispro9 11 "Analyst corrected reported value", add 
label define xispro9 12 "Data generated from other data values", add 
label define xispro9 13 "Implied zero", add 
label define xispro9 20 "Imputed using Carry Forward procedure", add 
label define xispro9 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xispro9 30 "Not applicable", add 
label define xispro9 31 "Institution left item blank", add 
label define xispro9 32 "Do not know", add 
label define xispro9 40 "Suppressed to protect confidentiality", add 
label values xispro9 xispro9
label define xispfe9 10 "Reported" 
label define xispfe9 11 "Analyst corrected reported value", add 
label define xispfe9 12 "Data generated from other data values", add 
label define xispfe9 13 "Implied zero", add 
label define xispfe9 20 "Imputed using Carry Forward procedure", add 
label define xispfe9 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xispfe9 30 "Not applicable", add 
label define xispfe9 31 "Institution left item blank", add 
label define xispfe9 32 "Do not know", add 
label define xispfe9 40 "Suppressed to protect confidentiality", add 
label values xispfe9 xispfe9
label define xospro9 10 "Reported" 
label define xospro9 11 "Analyst corrected reported value", add 
label define xospro9 12 "Data generated from other data values", add 
label define xospro9 13 "Implied zero", add 
label define xospro9 20 "Imputed using Carry Forward procedure", add 
label define xospro9 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xospro9 30 "Not applicable", add 
label define xospro9 31 "Institution left item blank", add 
label define xospro9 32 "Do not know", add 
label define xospro9 40 "Suppressed to protect confidentiality", add 
label values xospro9 xospro9
label define xospfe9 10 "Reported" 
label define xospfe9 11 "Analyst corrected reported value", add 
label define xospfe9 12 "Data generated from other data values", add 
label define xospfe9 13 "Implied zero", add 
label define xospfe9 20 "Imputed using Carry Forward procedure", add 
label define xospfe9 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xospfe9 30 "Not applicable", add 
label define xospfe9 31 "Institution left item blank", add 
label define xospfe9 32 "Do not know", add 
label define xospfe9 40 "Suppressed to protect confidentiality", add 
label values xospfe9 xospfe9
label define xispro10 10 "Reported" 
label define xispro10 11 "Analyst corrected reported value", add 
label define xispro10 12 "Data generated from other data values", add 
label define xispro10 13 "Implied zero", add 
label define xispro10 20 "Imputed using Carry Forward procedure", add 
label define xispro10 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xispro10 30 "Not applicable", add 
label define xispro10 31 "Institution left item blank", add 
label define xispro10 32 "Do not know", add 
label define xispro10 40 "Suppressed to protect confidentiality", add 
label values xispro10 xispro10
label define xispfe10 10 "Reported" 
label define xispfe10 11 "Analyst corrected reported value", add 
label define xispfe10 12 "Data generated from other data values", add 
label define xispfe10 13 "Implied zero", add 
label define xispfe10 20 "Imputed using Carry Forward procedure", add 
label define xispfe10 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xispfe10 30 "Not applicable", add 
label define xispfe10 31 "Institution left item blank", add 
label define xispfe10 32 "Do not know", add 
label define xispfe10 40 "Suppressed to protect confidentiality", add 
label values xispfe10 xispfe10
label define xospro10 10 "Reported" 
label define xospro10 11 "Analyst corrected reported value", add 
label define xospro10 12 "Data generated from other data values", add 
label define xospro10 13 "Implied zero", add 
label define xospro10 20 "Imputed using Carry Forward procedure", add 
label define xospro10 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xospro10 30 "Not applicable", add 
label define xospro10 31 "Institution left item blank", add 
label define xospro10 32 "Do not know", add 
label define xospro10 40 "Suppressed to protect confidentiality", add 
label values xospro10 xospro10
label define xospfe10 10 "Reported" 
label define xospfe10 11 "Analyst corrected reported value", add 
label define xospfe10 12 "Data generated from other data values", add 
label define xospfe10 13 "Implied zero", add 
label define xospfe10 20 "Imputed using Carry Forward procedure", add 
label define xospfe10 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xospfe10 30 "Not applicable", add 
label define xospfe10 31 "Institution left item blank", add 
label define xospfe10 32 "Do not know", add 
label define xospfe10 40 "Suppressed to protect confidentiality", add 
label values xospfe10 xospfe10
label define xispro11 10 "Reported" 
label define xispro11 11 "Analyst corrected reported value", add 
label define xispro11 12 "Data generated from other data values", add 
label define xispro11 13 "Implied zero", add 
label define xispro11 20 "Imputed using Carry Forward procedure", add 
label define xispro11 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xispro11 30 "Not applicable", add 
label define xispro11 31 "Institution left item blank", add 
label define xispro11 32 "Do not know", add 
label define xispro11 40 "Suppressed to protect confidentiality", add 
label values xispro11 xispro11
label define xispfe11 10 "Reported" 
label define xispfe11 11 "Analyst corrected reported value", add 
label define xispfe11 12 "Data generated from other data values", add 
label define xispfe11 13 "Implied zero", add 
label define xispfe11 20 "Imputed using Carry Forward procedure", add 
label define xispfe11 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xispfe11 30 "Not applicable", add 
label define xispfe11 31 "Institution left item blank", add 
label define xispfe11 32 "Do not know", add 
label define xispfe11 40 "Suppressed to protect confidentiality", add 
label values xispfe11 xispfe11
label define xospro11 10 "Reported" 
label define xospro11 11 "Analyst corrected reported value", add 
label define xospro11 12 "Data generated from other data values", add 
label define xospro11 13 "Implied zero", add 
label define xospro11 20 "Imputed using Carry Forward procedure", add 
label define xospro11 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xospro11 30 "Not applicable", add 
label define xospro11 31 "Institution left item blank", add 
label define xospro11 32 "Do not know", add 
label define xospro11 40 "Suppressed to protect confidentiality", add 
label values xospro11 xospro11
label define xospfe11 10 "Reported" 
label define xospfe11 11 "Analyst corrected reported value", add 
label define xospfe11 12 "Data generated from other data values", add 
label define xospfe11 13 "Implied zero", add 
label define xospfe11 20 "Imputed using Carry Forward procedure", add 
label define xospfe11 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xospfe11 30 "Not applicable", add 
label define xospfe11 31 "Institution left item blank", add 
label define xospfe11 32 "Do not know", add 
label define xospfe11 40 "Suppressed to protect confidentiality", add 
label values xospfe11 xospfe11
label define xchg1ay1 10 "Reported" 
label define xchg1ay1 11 "Analyst corrected reported value", add 
label define xchg1ay1 12 "Data generated from other data values", add 
label define xchg1ay1 13 "Implied zero", add 
label define xchg1ay1 20 "Imputed using Carry Forward procedure", add 
label define xchg1ay1 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xchg1ay1 30 "Not applicable", add 
label define xchg1ay1 31 "Institution left item blank", add 
label define xchg1ay1 32 "Do not know", add 
label define xchg1ay1 40 "Suppressed to protect confidentiality", add 
label values xchg1ay1 xchg1ay1
label define xchg1ay2 10 "Reported" 
label define xchg1ay2 11 "Analyst corrected reported value", add 
label define xchg1ay2 12 "Data generated from other data values", add 
label define xchg1ay2 13 "Implied zero", add 
label define xchg1ay2 20 "Imputed using Carry Forward procedure", add 
label define xchg1ay2 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xchg1ay2 30 "Not applicable", add 
label define xchg1ay2 31 "Institution left item blank", add 
label define xchg1ay2 32 "Do not know", add 
label define xchg1ay2 40 "Suppressed to protect confidentiality", add 
label values xchg1ay2 xchg1ay2
label define xchg1ay3 10 "Reported" 
label define xchg1ay3 11 "Analyst corrected reported value", add 
label define xchg1ay3 12 "Data generated from other data values", add 
label define xchg1ay3 13 "Implied zero", add 
label define xchg1ay3 20 "Imputed using Carry Forward procedure", add 
label define xchg1ay3 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xchg1ay3 30 "Not applicable", add 
label define xchg1ay3 31 "Institution left item blank", add 
label define xchg1ay3 32 "Do not know", add 
label define xchg1ay3 40 "Suppressed to protect confidentiality", add 
label values xchg1ay3 xchg1ay3
label define xchg2ay1 10 "Reported" 
label define xchg2ay1 11 "Analyst corrected reported value", add 
label define xchg2ay1 12 "Data generated from other data values", add 
label define xchg2ay1 13 "Implied zero", add 
label define xchg2ay1 20 "Imputed using Carry Forward procedure", add 
label define xchg2ay1 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xchg2ay1 30 "Not applicable", add 
label define xchg2ay1 31 "Institution left item blank", add 
label define xchg2ay1 32 "Do not know", add 
label define xchg2ay1 40 "Suppressed to protect confidentiality", add 
label values xchg2ay1 xchg2ay1
label define xchg2ay2 10 "Reported" 
label define xchg2ay2 11 "Analyst corrected reported value", add 
label define xchg2ay2 12 "Data generated from other data values", add 
label define xchg2ay2 13 "Implied zero", add 
label define xchg2ay2 20 "Imputed using Carry Forward procedure", add 
label define xchg2ay2 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xchg2ay2 30 "Not applicable", add 
label define xchg2ay2 31 "Institution left item blank", add 
label define xchg2ay2 32 "Do not know", add 
label define xchg2ay2 40 "Suppressed to protect confidentiality", add 
label values xchg2ay2 xchg2ay2
label define xchg2ay3 10 "Reported" 
label define xchg2ay3 11 "Analyst corrected reported value", add 
label define xchg2ay3 12 "Data generated from other data values", add 
label define xchg2ay3 13 "Implied zero", add 
label define xchg2ay3 20 "Imputed using Carry Forward procedure", add 
label define xchg2ay3 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xchg2ay3 30 "Not applicable", add 
label define xchg2ay3 31 "Institution left item blank", add 
label define xchg2ay3 32 "Do not know", add 
label define xchg2ay3 40 "Suppressed to protect confidentiality", add 
label values xchg2ay3 xchg2ay3
label define xchg3ay1 10 "Reported" 
label define xchg3ay1 11 "Analyst corrected reported value", add 
label define xchg3ay1 12 "Data generated from other data values", add 
label define xchg3ay1 13 "Implied zero", add 
label define xchg3ay1 20 "Imputed using Carry Forward procedure", add 
label define xchg3ay1 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xchg3ay1 30 "Not applicable", add 
label define xchg3ay1 31 "Institution left item blank", add 
label define xchg3ay1 32 "Do not know", add 
label define xchg3ay1 40 "Suppressed to protect confidentiality", add 
label values xchg3ay1 xchg3ay1
label define xchg3ay2 10 "Reported" 
label define xchg3ay2 11 "Analyst corrected reported value", add 
label define xchg3ay2 12 "Data generated from other data values", add 
label define xchg3ay2 13 "Implied zero", add 
label define xchg3ay2 20 "Imputed using Carry Forward procedure", add 
label define xchg3ay2 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xchg3ay2 30 "Not applicable", add 
label define xchg3ay2 31 "Institution left item blank", add 
label define xchg3ay2 32 "Do not know", add 
label define xchg3ay2 40 "Suppressed to protect confidentiality", add 
label values xchg3ay2 xchg3ay2
label define xchg3ay3 10 "Reported" 
label define xchg3ay3 11 "Analyst corrected reported value", add 
label define xchg3ay3 12 "Data generated from other data values", add 
label define xchg3ay3 13 "Implied zero", add 
label define xchg3ay3 20 "Imputed using Carry Forward procedure", add 
label define xchg3ay3 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xchg3ay3 30 "Not applicable", add 
label define xchg3ay3 31 "Institution left item blank", add 
label define xchg3ay3 32 "Do not know", add 
label define xchg3ay3 40 "Suppressed to protect confidentiality", add 
label values xchg3ay3 xchg3ay3
label define xchg4ay1 10 "Reported" 
label define xchg4ay1 11 "Analyst corrected reported value", add 
label define xchg4ay1 12 "Data generated from other data values", add 
label define xchg4ay1 13 "Implied zero", add 
label define xchg4ay1 20 "Imputed using Carry Forward procedure", add 
label define xchg4ay1 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xchg4ay1 30 "Not applicable", add 
label define xchg4ay1 31 "Institution left item blank", add 
label define xchg4ay1 32 "Do not know", add 
label define xchg4ay1 40 "Suppressed to protect confidentiality", add 
label values xchg4ay1 xchg4ay1
label define xchg4ay2 10 "Reported" 
label define xchg4ay2 11 "Analyst corrected reported value", add 
label define xchg4ay2 12 "Data generated from other data values", add 
label define xchg4ay2 13 "Implied zero", add 
label define xchg4ay2 20 "Imputed using Carry Forward procedure", add 
label define xchg4ay2 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xchg4ay2 30 "Not applicable", add 
label define xchg4ay2 31 "Institution left item blank", add 
label define xchg4ay2 32 "Do not know", add 
label define xchg4ay2 40 "Suppressed to protect confidentiality", add 
label values xchg4ay2 xchg4ay2
label define xchg4ay3 10 "Reported" 
label define xchg4ay3 11 "Analyst corrected reported value", add 
label define xchg4ay3 12 "Data generated from other data values", add 
label define xchg4ay3 13 "Implied zero", add 
label define xchg4ay3 20 "Imputed using Carry Forward procedure", add 
label define xchg4ay3 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xchg4ay3 30 "Not applicable", add 
label define xchg4ay3 31 "Institution left item blank", add 
label define xchg4ay3 32 "Do not know", add 
label define xchg4ay3 40 "Suppressed to protect confidentiality", add 
label values xchg4ay3 xchg4ay3
label define xchg5ay1 10 "Reported" 
label define xchg5ay1 11 "Analyst corrected reported value", add 
label define xchg5ay1 12 "Data generated from other data values", add 
label define xchg5ay1 13 "Implied zero", add 
label define xchg5ay1 20 "Imputed using Carry Forward procedure", add 
label define xchg5ay1 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xchg5ay1 30 "Not applicable", add 
label define xchg5ay1 31 "Institution left item blank", add 
label define xchg5ay1 32 "Do not know", add 
label define xchg5ay1 40 "Suppressed to protect confidentiality", add 
label values xchg5ay1 xchg5ay1
label define xchg5ay2 10 "Reported" 
label define xchg5ay2 11 "Analyst corrected reported value", add 
label define xchg5ay2 12 "Data generated from other data values", add 
label define xchg5ay2 13 "Implied zero", add 
label define xchg5ay2 20 "Imputed using Carry Forward procedure", add 
label define xchg5ay2 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xchg5ay2 30 "Not applicable", add 
label define xchg5ay2 31 "Institution left item blank", add 
label define xchg5ay2 32 "Do not know", add 
label define xchg5ay2 40 "Suppressed to protect confidentiality", add 
label values xchg5ay2 xchg5ay2
label define xchg5ay3 10 "Reported" 
label define xchg5ay3 11 "Analyst corrected reported value", add 
label define xchg5ay3 12 "Data generated from other data values", add 
label define xchg5ay3 13 "Implied zero", add 
label define xchg5ay3 20 "Imputed using Carry Forward procedure", add 
label define xchg5ay3 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xchg5ay3 30 "Not applicable", add 
label define xchg5ay3 31 "Institution left item blank", add 
label define xchg5ay3 32 "Do not know", add 
label define xchg5ay3 40 "Suppressed to protect confidentiality", add 
label values xchg5ay3 xchg5ay3
label define xchg6ay1 10 "Reported" 
label define xchg6ay1 11 "Analyst corrected reported value", add 
label define xchg6ay1 12 "Data generated from other data values", add 
label define xchg6ay1 13 "Implied zero", add 
label define xchg6ay1 20 "Imputed using Carry Forward procedure", add 
label define xchg6ay1 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xchg6ay1 30 "Not applicable", add 
label define xchg6ay1 31 "Institution left item blank", add 
label define xchg6ay1 32 "Do not know", add 
label define xchg6ay1 40 "Suppressed to protect confidentiality", add 
label values xchg6ay1 xchg6ay1
label define xchg6ay2 10 "Reported" 
label define xchg6ay2 11 "Analyst corrected reported value", add 
label define xchg6ay2 12 "Data generated from other data values", add 
label define xchg6ay2 13 "Implied zero", add 
label define xchg6ay2 20 "Imputed using Carry Forward procedure", add 
label define xchg6ay2 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xchg6ay2 30 "Not applicable", add 
label define xchg6ay2 31 "Institution left item blank", add 
label define xchg6ay2 32 "Do not know", add 
label define xchg6ay2 40 "Suppressed to protect confidentiality", add 
label values xchg6ay2 xchg6ay2
label define xchg6ay3 10 "Reported" 
label define xchg6ay3 11 "Analyst corrected reported value", add 
label define xchg6ay3 12 "Data generated from other data values", add 
label define xchg6ay3 13 "Implied zero", add 
label define xchg6ay3 20 "Imputed using Carry Forward procedure", add 
label define xchg6ay3 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xchg6ay3 30 "Not applicable", add 
label define xchg6ay3 31 "Institution left item blank", add 
label define xchg6ay3 32 "Do not know", add 
label define xchg6ay3 40 "Suppressed to protect confidentiality", add 
label values xchg6ay3 xchg6ay3
label define xchg7ay1 10 "Reported" 
label define xchg7ay1 11 "Analyst corrected reported value", add 
label define xchg7ay1 12 "Data generated from other data values", add 
label define xchg7ay1 13 "Implied zero", add 
label define xchg7ay1 20 "Imputed using Carry Forward procedure", add 
label define xchg7ay1 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xchg7ay1 30 "Not applicable", add 
label define xchg7ay1 31 "Institution left item blank", add 
label define xchg7ay1 32 "Do not know", add 
label define xchg7ay1 40 "Suppressed to protect confidentiality", add 
label values xchg7ay1 xchg7ay1
label define xchg7ay2 10 "Reported" 
label define xchg7ay2 11 "Analyst corrected reported value", add 
label define xchg7ay2 12 "Data generated from other data values", add 
label define xchg7ay2 13 "Implied zero", add 
label define xchg7ay2 20 "Imputed using Carry Forward procedure", add 
label define xchg7ay2 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xchg7ay2 30 "Not applicable", add 
label define xchg7ay2 31 "Institution left item blank", add 
label define xchg7ay2 32 "Do not know", add 
label define xchg7ay2 40 "Suppressed to protect confidentiality", add 
label values xchg7ay2 xchg7ay2
label define xchg7ay3 10 "Reported" 
label define xchg7ay3 11 "Analyst corrected reported value", add 
label define xchg7ay3 12 "Data generated from other data values", add 
label define xchg7ay3 13 "Implied zero", add 
label define xchg7ay3 20 "Imputed using Carry Forward procedure", add 
label define xchg7ay3 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xchg7ay3 30 "Not applicable", add 
label define xchg7ay3 31 "Institution left item blank", add 
label define xchg7ay3 32 "Do not know", add 
label define xchg7ay3 40 "Suppressed to protect confidentiality", add 
label values xchg7ay3 xchg7ay3
label define xchg8ay1 10 "Reported" 
label define xchg8ay1 11 "Analyst corrected reported value", add 
label define xchg8ay1 12 "Data generated from other data values", add 
label define xchg8ay1 13 "Implied zero", add 
label define xchg8ay1 20 "Imputed using Carry Forward procedure", add 
label define xchg8ay1 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xchg8ay1 30 "Not applicable", add 
label define xchg8ay1 31 "Institution left item blank", add 
label define xchg8ay1 32 "Do not know", add 
label define xchg8ay1 40 "Suppressed to protect confidentiality", add 
label values xchg8ay1 xchg8ay1
label define xchg8ay2 10 "Reported" 
label define xchg8ay2 11 "Analyst corrected reported value", add 
label define xchg8ay2 12 "Data generated from other data values", add 
label define xchg8ay2 13 "Implied zero", add 
label define xchg8ay2 20 "Imputed using Carry Forward procedure", add 
label define xchg8ay2 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xchg8ay2 30 "Not applicable", add 
label define xchg8ay2 31 "Institution left item blank", add 
label define xchg8ay2 32 "Do not know", add 
label define xchg8ay2 40 "Suppressed to protect confidentiality", add 
label values xchg8ay2 xchg8ay2
label define xchg8ay3 10 "Reported" 
label define xchg8ay3 11 "Analyst corrected reported value", add 
label define xchg8ay3 12 "Data generated from other data values", add 
label define xchg8ay3 13 "Implied zero", add 
label define xchg8ay3 20 "Imputed using Carry Forward procedure", add 
label define xchg8ay3 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xchg8ay3 30 "Not applicable", add 
label define xchg8ay3 31 "Institution left item blank", add 
label define xchg8ay3 32 "Do not know", add 
label define xchg8ay3 40 "Suppressed to protect confidentiality", add 
label values xchg8ay3 xchg8ay3
label define xchg9ay1 10 "Reported" 
label define xchg9ay1 11 "Analyst corrected reported value", add 
label define xchg9ay1 12 "Data generated from other data values", add 
label define xchg9ay1 13 "Implied zero", add 
label define xchg9ay1 20 "Imputed using Carry Forward procedure", add 
label define xchg9ay1 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xchg9ay1 30 "Not applicable", add 
label define xchg9ay1 31 "Institution left item blank", add 
label define xchg9ay1 32 "Do not know", add 
label define xchg9ay1 40 "Suppressed to protect confidentiality", add 
label values xchg9ay1 xchg9ay1
label define xchg9ay2 10 "Reported" 
label define xchg9ay2 11 "Analyst corrected reported value", add 
label define xchg9ay2 12 "Data generated from other data values", add 
label define xchg9ay2 13 "Implied zero", add 
label define xchg9ay2 20 "Imputed using Carry Forward procedure", add 
label define xchg9ay2 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xchg9ay2 30 "Not applicable", add 
label define xchg9ay2 31 "Institution left item blank", add 
label define xchg9ay2 32 "Do not know", add 
label define xchg9ay2 40 "Suppressed to protect confidentiality", add 
label values xchg9ay2 xchg9ay2
label define xchg9ay3 10 "Reported" 
label define xchg9ay3 11 "Analyst corrected reported value", add 
label define xchg9ay3 12 "Data generated from other data values", add 
label define xchg9ay3 13 "Implied zero", add 
label define xchg9ay3 20 "Imputed using Carry Forward procedure", add 
label define xchg9ay3 21 "Imputed using Group Median or Nearest Neighbor procedure", add 
label define xchg9ay3 30 "Not applicable", add 
label define xchg9ay3 31 "Institution left item blank", add 
label define xchg9ay3 32 "Do not know", add 
label define xchg9ay3 40 "Suppressed to protect confidentiality", add 
label values xchg9ay3 xchg9ay3
tab xtuit1
tab xfee1
tab xhrchg1
tab xcmpfee1
tab xtuit2
tab xfee2
tab xhrchg2
tab xcmpfee2
tab xtuit3
tab xfee3
tab xhrchg3
tab xcmpfee3
tab xtuit5
tab xfee5
tab xhrchg5
tab xtuit6
tab xfee6
tab xhrchg6
tab xtuit7
tab xfee7
tab xhrchg7
tab xispro1
tab xispfe1
tab xospro1
tab xospfe1
tab xispro2
tab xispfe2
tab xospro2
tab xospfe2
tab xispro3
tab xispfe3
tab xospro3
tab xospfe3
tab xispro4
tab xispfe4
tab xospro4
tab xospfe4
tab xispro5
tab xispfe5
tab xospro5
tab xospfe5
tab xispro6
tab xispfe6
tab xospro6
tab xospfe6
tab xispro7
tab xispfe7
tab xospro7
tab xospfe7
tab xispro8
tab xispfe8
tab xospro8
tab xospfe8
tab xispro9
tab xispfe9
tab xospro9
tab xospfe9
tab xispro10
tab xispfe10
tab xospro10
tab xospfe10
tab xispro11
tab xispfe11
tab xospro11
tab xospfe11
tab xchg1ay1
tab xchg1ay2
tab xchg1ay3
tab xchg2ay1
tab xchg2ay2
tab xchg2ay3
tab xchg3ay1
tab xchg3ay2
tab xchg3ay3
tab xchg4ay1
tab xchg4ay2
tab xchg4ay3
tab xchg5ay1
tab xchg5ay2
tab xchg5ay3
tab xchg6ay1
tab xchg6ay2
tab xchg6ay3
tab xchg7ay1
tab xchg7ay2
tab xchg7ay3
tab xchg8ay1
tab xchg8ay2
tab xchg8ay3
tab xchg9ay1
tab xchg9ay2
tab xchg9ay3
summarize tuition1
summarize fee1
summarize hrchg1
summarize cmpfee1
summarize tuition2
summarize fee2
summarize hrchg2
summarize cmpfee2
summarize tuition3
summarize fee3
summarize hrchg3
summarize cmpfee3
summarize tuition5
summarize fee5
summarize hrchg5
summarize tuition6
summarize fee6
summarize hrchg6
summarize tuition7
summarize fee7
summarize hrchg7
summarize isprof1
summarize ispfee1
summarize osprof1
summarize ospfee1
summarize isprof2
summarize ispfee2
summarize osprof2
summarize ospfee2
summarize isprof3
summarize ispfee3
summarize osprof3
summarize ospfee3
summarize isprof4
summarize ispfee4
summarize osprof4
summarize ospfee4
summarize isprof5
summarize ispfee5
summarize osprof5
summarize ospfee5
summarize isprof6
summarize ispfee6
summarize osprof6
summarize ospfee6
summarize isprof7
summarize ispfee7
summarize osprof7
summarize ospfee7
summarize isprof8
summarize ispfee8
summarize osprof8
summarize ospfee8
summarize isprof9
summarize ispfee9
summarize osprof9
summarize ospfee9
summarize isprof10
summarize ispfee10
summarize osprof10
summarize ospfee10
summarize isprof11
summarize ispfee11
summarize osprof11
summarize ospfee11
summarize chg1ay1
summarize chg1ay2
summarize chg1ay3
summarize chg2ay1
summarize chg2ay2
summarize chg2ay3
summarize chg3ay1
summarize chg3ay2
summarize chg3ay3
summarize chg4ay1
summarize chg4ay2
summarize chg4ay3
summarize chg5ay1
summarize chg5ay2
summarize chg5ay3
summarize chg6ay1
summarize chg6ay2
summarize chg6ay3
summarize chg7ay1
summarize chg7ay2
summarize chg7ay3
summarize chg8ay1
summarize chg8ay2
summarize chg8ay3
summarize chg9ay1
summarize chg9ay2
summarize chg9ay3
save working_data/dct_ic2000_ay.dta, replace

