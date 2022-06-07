*TABLE SI.1
do "code/2setup.do"
global independent "EPS"
foreach dep of varlist poll {
	foreach indep in $independent {
	
		local path "results/appendix/TABLE_SI_1.txt"
		capture noisily rm `path'
		
		forval contval = 1/6 {

			xtreg `dep' d.`indep' ${control`contval'} i.YEAR i.ISO_ID, vce(cluster ISO_ID)
			outreg2 using `path', bdec(3) tdec(2) rdec(2) alpha(0.01, 0.05, 0.1) stat(coef se) ///
			addtext(TIME FE, YES, UNIT FE, YES) keep(d.`indep' $controlorder) ///
			sortvar(d.`indep' $controlorder) addstat(R-squared, `e(r2_o)') excel app

		}
	}
}

***********

*TABLE SI.2
do "code/2setup.do"
global control1 "deficit_oecd elderly_oecd gdpr_wb"
global control2 "deficit_oecd elderly_oecd gdpr_wb unemprate_wb"
global control3 "deficit_oecd elderly_oecd gdpr_wb unemprate_wb cpi_full_oecd"
global control4 "deficit_oecd elderly_oecd gdpr_wb unemprate_wb cpi_full_oecd wedge2"
global control5 "deficit_oecd elderly_oecd gdpr_wb unemprate_wb cpi_full_oecd wedge2 finref_index_ref product_index_ref current_index_ref capital_index_ref labor_index_ref"
global independent "EPS"
foreach dep of varlist B_numvote {
	foreach indep in $independent {
	
		local path "results/appendix/TABLE_SI_2.txt"
		capture noisily rm `path'
		
		forval contval = 1/5 {

			xtscc `dep' D.`indep' ${control`contval'} L.`dep' i.YEAR if D.`dep'!=0, fe lag(2)	
			outreg2 using `path', bdec(3) tdec(2) rdec(2) alpha(0.01, 0.05, 0.1) stat(coef se) ///
			addtext(TIME FE, YES, UNIT FE, YES) keep(d.`indep' $controlorder L.`dep') ///
			sortvar(d.`indep' L.`dep' $controlorder) addstat(R-squared, `e(r2_w)') excel app

		}
	}
}

***********

*TABLE SI.3
do "code/2setup.do"
global control1 "deficit_oecd elderly_oecd gdpr_wb"
global control2 "deficit_oecd elderly_oecd gdpr_wb unemprate_wb"
global control3 "deficit_oecd elderly_oecd gdpr_wb unemprate_wb cpi_full_oecd"
global control4 "deficit_oecd elderly_oecd gdpr_wb unemprate_wb cpi_full_oecd wedge2"
global control5 "deficit_oecd elderly_oecd gdpr_wb unemprate_wb cpi_full_oecd wedge2 finref_index_ref product_index_ref current_index_ref capital_index_ref labor_index_ref"
global independent "EPS"
foreach dep of varlist B_gov1vote {
	foreach indep in $independent {
	
		local path "results/appendix/TABLE_SI_3.txt"
		capture noisily rm `path'
		
		forval contval = 1/5 {

			xtscc `dep' D.`indep' ${control`contval'} L.`dep' i.YEAR if D.`dep'!=0, fe lag(2)	
			outreg2 using `path', bdec(3) tdec(2) rdec(2) alpha(0.01, 0.05, 0.1) stat(coef se) ///
			addtext(TIME FE, YES, UNIT FE, YES) keep(d.`indep' $controlorder L.`dep') ///
			sortvar(d.`indep' L.`dep' $controlorder) addstat(R-squared, `e(r2_w)') excel app

		}
	}
}

***********

*TABLE SI.4
do "code/2setup.do"

*subset dataset and create new variables
preserve

gen diff_EPS = d.EPS
keep if YEAR>=2001 & YEAR<=2015
gen diff_ninc1 = D.ninc1
replace B_execrlc = . if B_execrlc == 0
tab (ISO), gen(isocode)
tab (YEAR), gen(year)

*define varlists
global dependent "D_Popularsupport"
global independent "diff_EPS"
global doubt_pol "greenvote B_execrlc B_maj B_herfopp D_DemocraticAccountK D_LegislativeStrength"
global doubt_econ "ninc1 diff_ninc1"

*define path
local path "results/appendix/TABLE_SI_4.txt"
capture noisily rm `path'

wals $dependent $independent isocode* year*, aux($control6 $doubt_pol $doubt_econ)
outreg2 using `path', bdec(3) tdec(2) rdec(2) alpha(0.01, 0.05, 0.1) stat(coef se tstat) ///
addtext(MODEL, WALS, TIME FE, YES, UNIT FE, YES) drop(isocode* year*) ///
sortvar($independent $control6) excel app

bma $dependent $independent isocode* year*, aux($control6 $doubt_pol $doubt_econ)
outreg2 using `path', bdec(3) tdec(2) rdec(2) alpha(0.01, 0.05, 0.1) stat(coef se tstat) ///
addtext(MODEL, BMA, TIME FE, YES, UNIT FE, YES) drop(isocode* year*) ///
sortvar($independent $control6) excel app

restore

***********

*TABLE SI.5
do "code/2setup.do"
global independent "EPS"
foreach dep in $dependent {
	foreach indep in $independent {
	
		local path "results/appendix/TABLE_SI_5.txt"
		capture noisily rm `path'
		
		forval year = 2006(2)2015 {

			xtreg `dep' d.`indep' $control1 i.YEAR i.ISO_ID if YEAR<= `year', vce(cluster ISO_ID)
			outreg2 using `path', bdec(3) tdec(2) rdec(2) alpha(0.01, 0.05, 0.1) stat(coef se) ///
			addtext(TIME FE, YES, UNIT FE, YES, OBS BEFORE, `year') keep(d.`indep' $controlorder) ///
			sortvar(d.`indep' $controlorder) addstat(R-squared, `e(r2_o)') excel app

		}
	}
}

***********

*TABLE SI.6
do "code/2setup.do"
global independent "EPS"
foreach dep in $dependent {
	foreach indep in $independent {
	
		local path "results/appendix/TABLE_SI_6.txt"
		capture noisily rm `path'
		
		foreach inst in $instrument {

			xtreg `dep' d.`indep' $control1 `inst' i.YEAR i.ISO_ID, vce(cluster ISO_ID)
			outreg2 using `path', bdec(3) tdec(2) rdec(2) alpha(0.01, 0.05, 0.1) stat(coef se) ///
			addtext(TIME FE, YES, UNIT FE, YES) keep(d.`indep' $controlorder `inst') ///
			sortvar(d.`indep' $controlorder $instrument_select) addstat(R-squared, `e(r2_o)') excel app

		}
	}
}

***********

*TABLE SI.7
do "code/2setup.do"
global independent "EPS"
xtreg $dependent d.EPS $control1 i.YEAR i.ISO_ID, vce(cluster ISO_ID)
capture noisily drop error
predict error, e
foreach dep in $dependent {
	foreach indep in $independent {
	
		local path "results/appendix/TABLE_SI_7.txt"
		capture noisily rm `path'
		
		foreach inst in $instrument {

			xtreg error d.`indep' $control1 `inst' i.YEAR i.ISO_ID, vce(cluster ISO_ID)
			outreg2 using `path', bdec(3) tdec(2) rdec(2) alpha(0.01, 0.05, 0.1) stat(coef se) ///
			addtext(TIME FE, YES, UNIT FE, YES) keep($controlorder `inst') ///
			sortvar($controlorder $instrument_select) addstat(R-squared, `e(r2_o)') excel app

		}
	}
}

***********

*TABLE SI.8
do "code/2setup.do"
global independent "EPS"
local path_second "results/appendix/TABLE_SI_8.txt"
capture noisily rm `path_second'

foreach dep in $dependent {
	
	ivreg2 `dep' $control1 i.YEAR i.ISO_ID c.coastLengthWRICOU##c.GlobKOF_total (d.EPS=eventsFlood_coastLengthWRI), ///
	cluster(ISO_ID) partial($control1 i.YEAR i.ISO_ID c.coastLengthWRICOU##c.GlobKOF_total) first savefirst 
	mat def first_1=e(first)
	global f1_text = first_1[4,1]
	outreg2 using "`path_second'", keep(d.EPS) bdec(3) dec(3) pdec(3) alpha(0.01, 0.05, 0.1) excel app ///
	addtext(INSTRUMENT, eventsFlood_coastLengthWRI, FStat, $f1_text, TIME FE, YES, UNIT FE, YES, CORRELATE of global term, GlobKOF_total) nor2
	
	ivreg2 `dep' $control1 i.YEAR i.ISO_ID c.coastLengthWRICOU##c.conindex_global (d.EPS=eventsFlood_coastLengthWRI), ///
	cluster(ISO_ID) partial($control1 i.YEAR i.ISO_ID c.coastLengthWRICOU##c.conindex_global) first savefirst 
	mat def first_1=e(first)
	global f1_text = first_1[4,1]
	outreg2 using "`path_second'", keep(d.EPS) bdec(3) dec(3) pdec(3) alpha(0.01, 0.05, 0.1) excel app ///
	addtext(INSTRUMENT, eventsFlood_coastLengthWRI, FStat, $f1_text, TIME FE, YES, UNIT FE, YES, CORRELATE of global term, conindex_global) nor2
	
	ivreg2 `dep' $control1 i.YEAR i.ISO_ID c.coastLengthWRICOU##c.riot_global (d.EPS=eventsFlood_coastLengthWRI), ///
	cluster(ISO_ID) partial($control1 i.YEAR i.ISO_ID c.coastLengthWRICOU##c.riot_global) first savefirst 
	mat def first_1=e(first)
	global f1_text = first_1[4,1]
	outreg2 using "`path_second'", keep(d.EPS) bdec(3) dec(3) pdec(3) alpha(0.01, 0.05, 0.1) excel app ///
	addtext(INSTRUMENT, eventsFlood_coastLengthWRI, FStat, $f1_text, TIME FE, YES, UNIT FE, YES, CORRELATE of global term, riot_global) nor2
	
	***
	
	ivreg2 $dependent $control1 i.YEAR i.ISO_ID c.eventsFloodGLOB##c.logpop (d.EPS=eventsFlood_coastLengthWRI), ///
	cluster(ISO_ID) partial($control1 i.YEAR i.ISO_ID c.eventsFloodGLOB##c.logpop) first savefirst 
	mat def first_1=e(first)
	global f1_text = first_1[4,1]
	outreg2 using "`path_second'", keep(d.EPS) bdec(3) dec(3) pdec(3) alpha(0.01, 0.05, 0.1) excel app ///
	addtext(INSTRUMENT, eventsFlood_coastLengthWRI, FStat, $f1_text, TIME FE, YES, UNIT FE, YES, CORRELATE of country term, logpop) nor2
	
	ivreg2 `dep' $control1 c.GlobKOF_total##c.logpop i.YEAR i.ISO_ID (d.EPS=eventsFlood_coastLengthWRI), ///
	cluster(ISO_ID) partial($control1 i.YEAR i.ISO_ID) first savefirst 
	mat def first_1=e(first)
	global f1_text = first_1[4,1]
	outreg2 using "`path_second'", keep(d.EPS) bdec(3) dec(3) pdec(3) alpha(0.01, 0.05, 0.1) excel app ///
	addtext(INSTRUMENT, eventsFlood_coastLengthWRI, FStat, $f1_text, TIME FE, YES, UNIT FE, YES, ADDITIONAL interaction term, GlobKOF_total##logpop) nor2
	
}

***********

*TABLE SI.9
do "code/2setup.do"
global independent "d.TAXCO2 d.TAXDIESEL d.TAXNOX d.TAXSOX d.FIT d.FIT_SOLAR d.FIT_WIND d.TRADESCH d.TRADESCH_CO2 d.TRADESCH_EEF d.TRADESCH_REC d.EPS_NMKT d.STD d.RD_RE d.RD_SUB d.ELV_DIESELSO d.ELV_NOX d.ELV_PM d.ELV_SOX"
foreach dep in $dependent {

	local path "results/appendix/TABLE_SI_9.txt"
	capture noisily rm `path'
	
	foreach indep in $independent {
	
		xtreg `dep' `indep' $control1 i.YEAR i.ISO_ID, vce(cluster ISO_ID)
		outreg2 using `path', bdec(3) tdec(2) rdec(2) alpha(0.01, 0.05, 0.1) stat(coef se) ///
		addtext(TIME FE, YES, UNIT FE, YES) keep($independent $control1) ///
		sortvar($control1 $independent) addstat(R-squared, `e(r2_o)') excel app
		
	}	
}

***********

*TABLE SI.10
do "code/2setup.do"
global independent "EPS"
foreach dep in $dependent {
	foreach indep in $independent {
	
		local path "results/appendix/TABLE_SI_10.txt"
		capture noisily rm `path'	
		
		forval contval = 1/6 {

			xtreg `dep' left`indep' cent`indep' right`indep' ${control`contval'} i.YEAR i.ISO_ID, vce(cluster ISO_ID)
			outreg2 using `path', bdec(3) tdec(2) rdec(2) alpha(0.01, 0.05, 0.1) stat(coef se) ///
			addtext(TIME FE, YES, UNIT FE, YES) keep(left`indep' cent`indep' right`indep' $controlorder) ///
			sortvar(left`indep' cent`indep' right`indep' $controlorder) addstat(R-squared, `e(r2_o)') excel app

		}
	}
}
