// open data file
use cps_00001.dta


/*
		FINANCIAL MANAGER OCCUPTION CODE
*/
preserve
// data cleaning
keep if occ1990==007
drop if year<1990
keep if empstat==10
drop if union==0

// gen incwage union variables
gen unionized=(union==2 | union==3)
gen incwage_unionized=incwage if unionized==1
gen incwage_not_unionized=incwage if unionized==0

// data collapse
collapse (mean) unionized incwage_not_unionized incwage_unionized, by(year)

// Make variable labels and union wage premium var
label variable unionized "Share Unionized"
gen union_wage_premium=(incwage_unionized/incwage_not_unionized-1)
label variable union_wage_premium "Union Wage Premium"

// graph
twoway (connected unionized year, xtitle("Year") yaxis(1)) (connected union_wage_premium year, yaxis(2)), title("Financial Manager Unionization and Wage Premium") xlabel(1990(5)2025) legend(pos(6) cols(2) label(1 "Share Unionized") label(2 "Union Wage Premium"))
graph export "Assign10FinancialManager.png", replace

restore


/*
		SURVEY RESEARCHER OCCUPTION CODE
*/
preserve
// data cleaning
keep if occ1990==166
drop if year<1990
keep if empstat==10
drop if union==0

// gen incwage union variables
gen unionized=(union==2 | union==3)
gen incwage_unionized=incwage if unionized==1
gen incwage_not_unionized=incwage if unionized==0

// data collapse
collapse (mean) unionized incwage_not_unionized incwage_unionized, by(year)

// Make variable labels and union wage premium var
label variable unionized "Share Unionized"
gen union_wage_premium=(incwage_unionized/incwage_not_unionized-1)
label variable union_wage_premium "Union Wage Premium"

// graph
twoway (connected unionized year, xtitle("Year") yaxis(1)) (connected union_wage_premium year, yaxis(2)), title("Survey Researcher Unionization and Wage Premium") xlabel(1990(5)2025) legend(pos(6) cols(2) label(1 "Share Unionized") label(2 "Union Wage Premium"))
graph export "Assign10SurveyResearcher.png", replace

restore