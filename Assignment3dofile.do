use usa_00005.dta, clear 

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
	 
collapse incwage age male ed_years, by(occ1990)