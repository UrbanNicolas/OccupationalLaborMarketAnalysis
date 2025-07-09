 // open data file
use usa_00006.dta, clear 

// preserve data for data change 
preserve

// clean data
keep if occ1990==007 | occ1990== 166
keep if age>=18 & age<=65
keep if empstat==1
keep if incwage>0

// run cpi do file
do cpi.do

// incwage gender variable generation
gen incwage_male=incwage if sex==1
gen incwage_female=incwage if sex==2

//Decomp before collapse
sum incwage if sex==1 & occ1990==84 & year==2015
sum incwage if sex==2 & occ1990==84 & year==2015


// collapse data
collapse (p90) incwage90=incwage (p10) incwage10=incwage (median) incwage50=incwage (mean) incwage incwage_male incwage_female, by(occ1990 year)

// ratios
gen incwage_ratio_90_10=incwage90/incwage10
gen incwage_ratio_50_10=incwage50/incwage10
gen incwage_ratio_90_50=incwage90/incwage50
list 

// generate gender wage gap variables
gen gender_wage_gap=incwage_female/incwage_male

/*
// Reshape
keep gender_wage_gap incwage_ratio_90_50 incwage_ratio_50_10 year occ1990
reshape wide gender_wage_gap incwage_ratio_90_50 incwage_ratio_50_10, i(year) j(occ1990)
list */

// one graph for ratios 90/50 and 50/10 graphs for both occ
twoway (connected incwage_ratio_50_10 year if occ1990==007) (connected incwage_ratio_50_10 year if occ1990==166) (connected incwage_ratio_90_50 year if occ1990==007) (connected incwage_ratio_90_50 year if occ1990==166), title("Income Ratios") xtitle("Year") ytitle("Ratio") legend(pos(6) cols(2) label(1 "50 to 10 Financial Manager") label(2 "50 to 10 Survey Researcher") label(3 "90 to 50 Financial Manager") label(4 "90 to 50 Survey Researcher"))

// graph gender wage for both occupations
twoway (connected gender_wage_gap year if occ1990==007) (connected gender_wage_gap year if occ1990==166), title("Gender Wage Gap") xtitle("Year") ytitle("Ratio") legend(pos(6) cols(2) label(1 "Financial Manager Gender Wage Gap") label(2 "Survey Researcher Gender Wage Gap"))

// restore data from data change
restore
























