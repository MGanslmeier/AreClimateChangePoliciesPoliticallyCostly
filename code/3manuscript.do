*TABLE 1
global allVariables "ISO_ID YEAR D_Popularsupport poll B_numvote B_gov1vote EPS EPS_MKT TAXES EPS_NMKT STD TAXCO2 TAXDIESEL TAXNOX TAXSOX FIT FIT_SOLAR FIT_WIND TRADESCH TRADESCH_CO2 TRADESCH_EEF TRADESCH_REC EPS_NMKT STD RD_RE RD_SUB ELV_DIESELSO ELV_NOX ELV_PM ELV_SOX deficit_oecd elderly_oecd gdpr_wb unemprate_wb cpi_full_oecd voteshare wedge2 finref_index_ref product_index_ref current_index_ref capital_index_ref labor_index_ref oilPrice gasPrice yrcurnt energysh initialEPS top1share top10share top20share bot1share bot10share bot20share giniMRKT giniNET sbCASH sbKIND almpExp unempExp peopleAffectEQGLOB urbanCoastLOGCOU eventsFloodGLOB coastLengthWRICOU majorHurricGLOB cenDistCOU eventsWildfireGLOB agriLandPCCOU eventsFlood_coastLengthWRI peopleAffectEQ_urbanCoastLOG majorHurric_cenDist eventsWildfire_agriLandPC GlobKOF_total conindex_global riot_global logpop leftEPS centEPS rightEPS ninc1 greenvote B_execrlc B_maj B_herfopp D_DemocraticAccountK D_LegislativeStrength"

preserve

keep $allVariables
outreg2 using "results/manuscript/TABLE_1.txt", excel replace sum(log) eqkeep(N mean sd max min) sortvar($allVariables)

restore

***********

*TABLE 2
do "code/2setup.do"
global independent "EPS"
foreach dep in $dependent {
	foreach indep in $independent {
	
		local path "results/manuscript/TABLE_2.txt"
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

*TABLE 3
do "code/2setup.do"

local path_first "results/manuscript/TABLE_3_1st.txt"
capture noisily rm `path_first'
local path_second "results/manuscript/TABLE_3_2nd.txt"
capture noisily rm `path_second'

global factor 100000
global independent "EPS"
foreach dep in $dependent {
	foreach inst in $instrument {
		foreach indep in $independent {
			
			*second stage
			ivreg2 `dep' $control1 i.YEAR i.ISO_ID (d.`indep'=`inst'), cluster(ISO_ID) partial($control1 i.YEAR i.ISO_ID) first savefirst 
			mat def first_1=e(first)
			global f1_text = first_1[4,1]
			outreg2 using "`path_second'", keep(d.`indep') bdec(3) dec(3) pdec(3) alpha(0.01, 0.05, 0.1) excel app ///
			addtext(INSTRUMENT, `inst', FStat, $f1_text, TIME FE, YES, UNIT FE, YES) nor2
			
			*first stage
			preserve
			replace `indep' = `indep'*$factor
			ivreg2 `dep' $control1 i.YEAR i.ISO_ID (d.`indep'=`inst'), cluster(ISO_ID) partial($control1 i.YEAR i.ISO_ID) first savefirst 
			estimates restore _ivreg2_D_`indep'
			outreg2 using "`path_first'", bdec(7) dec(3) pdec(3) alpha(0.01, 0.05, 0.1) excel app ///
			addtext(INSTRUMENT, `inst', FStat, $f1_text, TIME FE, YES, UNIT FE, YES, MULTIPLIED, $factor) nor2
			restore

		}
	}
}

***********

*TABLE 4
do "code/2setup.do"
global independent "d.EPS_MKT d.TAXES d.EPS_NMKT d.STD"
foreach dep in $dependent {

	local path "results/manuscript/TABLE_4.txt"
	capture noisily rm `path'
	
	foreach indep in $independent {
	
		xtreg `dep' `indep' $control1 i.YEAR i.ISO_ID, vce(cluster ISO_ID)
		outreg2 using `path', bdec(3) tdec(2) rdec(2) alpha(0.01, 0.05, 0.1) stat(coef se) ///
		addtext(TIME FE, YES, UNIT FE, YES) keep($independent $control1) ///
		sortvar($control1 $independent) addstat(R-squared, `e(r2_o)') excel app
		
	}	
}

***********

*TABLE 5
foreach dep in $dependent {
	
	local path "results/manuscript/TABLE_5.txt"
	capture noisily rm `path'
	
	*oil price
	xtreg `dep' DEPS_low_oilPrice_V1 DEPS_high_oilPrice_V1 $control1 i.YEAR i.ISO_ID, vce(cluster ISO_ID)
	test DEPS_low_oilPrice_V1 == DEPS_high_oilPrice_V1
	outreg2 using `path', bdec(3) tdec(2) rdec(2) alpha(0.01, 0.05, 0.1) stat(coef se) ///
	addtext(TIME FE, YES, UNIT FE, YES) drop(i.YEAR i.ISO_ID) ///
	sortvar($control1) addstat(R-squared, `e(r2_o)', Equality pval, `r(p)') excel app
	
	*gas price
	xtreg `dep' DEPS_low_gasPrice_V1 DEPS_high_gasPrice_V1 $control1 i.YEAR i.ISO_ID, vce(cluster ISO_ID)
	test DEPS_low_gasPrice_V1 == DEPS_high_gasPrice_V1
	outreg2 using `path', bdec(3) tdec(2) rdec(2) alpha(0.01, 0.05, 0.1) stat(coef se) ///
	addtext(TIME FE, YES, UNIT FE, YES) drop(i.YEAR i.ISO_ID) ///
	sortvar($control1) addstat(R-squared, `e(r2_o)', Equality pval, `r(p)') excel app
	
	*years until next election
	xtreg `dep' DEPS_low_yrcurnt_V1 DEPS_high_yrcurnt_V1 $control1 i.YEAR i.ISO_ID, vce(cluster ISO_ID)
	test DEPS_low_yrcurnt_V1 == DEPS_high_yrcurnt_V1
	outreg2 using `path', bdec(3) tdec(2) rdec(2) alpha(0.01, 0.05, 0.1) stat(coef se) ///
	addtext(TIME FE, YES, UNIT FE, YES) drop(i.YEAR i.ISO_ID) ///
	sortvar($control1) addstat(R-squared, `e(r2_o)', Equality pval, `r(p)') excel app
	
	*share of dirty energy
	xtscc `dep' DEPS_low_energysh_V4 DEPS_high_energysh_V4 $control1 i.YEAR, fe lag(2)
	test DEPS_low_energysh_V4 == DEPS_high_energysh_V4
	outreg2 using `path', bdec(3) tdec(2) rdec(2) alpha(0.01, 0.05, 0.1) stat(coef se) ///
	addtext(TIME FE, YES, UNIT FE, YES) drop(i.ISO_ID i.YEAR) sortvar($control1) ///
	addstat(R-squared, `e(r2_w)', Equality pval, `r(p)') excel app
	
	*initial EPS level
	xtscc `dep' DEPS_low_initialEPS_V3 DEPS_high_initialEPS_V3 $control1 i.YEAR, fe lag(2)
	test DEPS_low_initialEPS_V3 == DEPS_high_initialEPS_V3
	outreg2 using `path', bdec(3) tdec(2) rdec(2) alpha(0.01, 0.05, 0.1) stat(coef se) ///
	addtext(TIME FE, YES, UNIT FE, YES) drop(i.ISO_ID i.YEAR) sortvar($control1) ///
	addstat(R-squared, `e(r2_w)', Equality pval, `r(p)') excel app

}

***********

*TABLE 6-8
global interaction "giniMRKT giniNET top1share top10share top20share bot1share bot10share bot20share sbCASH sbKIND almpExp unempExp"
foreach dep in $dependent {
	
	local path "results/manuscript/TABLE_6-8.txt"
	capture noisily rm `path'
	
	foreach ia in $interaction {
			
		xtreg `dep' DEPS_low_`ia'_V1 DEPS_high_`ia'_V1 $control1 i.YEAR i.ISO_ID, vce(cluster ISO_ID)
		test DEPS_low_`ia'_V1 == DEPS_high_`ia'_V1
		outreg2 using `path', bdec(3) tdec(2) rdec(2) alpha(0.01, 0.05, 0.1) stat(coef se) ///
		addtext(TIME FE, YES, UNIT FE, YES) drop(i.YEAR i.ISO_ID) ///
		sortvar($control1) addstat(R-squared, `e(r2_o)', Equality pval, `r(p)') excel app

	}
}
