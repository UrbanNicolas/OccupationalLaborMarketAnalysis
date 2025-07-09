use usa_00006.dta, clear 

drop sample serial cbserial hhwt cluster strata gq pernum educd empstatd 

keep if occ1990==007 | occ1990== 166

keep if age >= 18 & age <= 65
gen male =1 if sex ==1
replace male =0 if male==.
keep if empstat==1
drop if incwage==0

 gen ed_years=.

     replace ed_years=0 if educ==0

     replace ed_years=2.5 if educ==1

     replace ed_years=6.5 if educ==2

     replace ed_years=9 if educ==3

     replace ed_years=10 if educ==4

     replace ed_years=11 if educ==5

     replace ed_years=12 if educ==6

     replace ed_years=13 if educ==7

     replace ed_years=14 if educ==8

     replace ed_years=15 if educ==9

     replace ed_years=16 if educ==10

     replace ed_years=17 if educ==11
	 

replace incwage=(304.7/195.3)*incwage if year==2005 //CPI in 2005
replace incwage=(304.7/201.6)*incwage if year==2006 //CPI in 2006
replace incwage=(304.7/207.3)*incwage if year==2007 
replace incwage=(304.7/215.3)*incwage if year==2008
replace incwage=(304.7/214.6)*incwage if year==2009
replace incwage=(304.7/218.1)*incwage if year==2010
replace incwage=(304.7/224.9)*incwage if year==2011
replace incwage=(304.7/229.6)*incwage if year==2012
replace incwage=(304.7/233.0)*incwage if year==2013
replace incwage=(304.7/236.7)*incwage if year==2014
replace incwage=(304.7/237.0)*incwage if year==2015
replace incwage=(304.7/240.0)*incwage if year==2016
replace incwage=(304.7/245.1)*incwage if year==2017
replace incwage=(304.7/251.1)*incwage if year==2018
replace incwage=(304.7/255.7)*incwage if year==2019
replace incwage=(304.7/258.9)*incwage if year==2020
replace incwage=(304.7/271.0)*incwage if year==2021
replace incwage=(304.7/292.6)*incwage if year==2022
replace incwage=(304.7/304.7)*incwage if year==2023 //CPI in 2023


collapse(sum) wage=incwage (mean) age incwage male ed_years, by (occ1990 year)

twoway (line wage year if occ1990==007) ///
       (line wage year if occ1990==166), ///
       title("Wage over Time") xtitle("Year") ///
       ytitle("Number of Workers") ///
	  

**legend(pos(6) cols(2) label(1 "Financial Manager") label(2 "Survey Researcher"))

graph export graph2.pdf, replace 
*twoway (year if occ1990==007)
*(occ1990==166)