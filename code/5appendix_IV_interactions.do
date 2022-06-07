local path_first "results/appendix/TABLE_SI_11-12_1st.txt"
capture noisily rm `path_first'
local path_second "results/appendix/TABLE_SI_11-12_2nd.txt"
capture noisily rm `path_second'

preserve

*oil price, gas price, years until next election
local inst "peopleAffectEQ_urbanCoastLOG"
global interaction_temp "oilPrice gasPrice yrcurnt"
foreach ia in $interaction_temp {
	
	*update instrument
	if "`ia'" == "yrcurnt" {
       local inst "eventsFlood_coastLengthWRI"
    }
	
	*define endogenous and instrumental variables
	gen LOW_instrument = low_`ia'_V1*`inst'
	gen HIGH_instrument = high_`ia'_V1*`inst'
	gen DEPS_low`ia' = (DEPS_low_`ia'_V1)
	gen DEPS_high`ia' = (DEPS_high_`ia'_V1)

	************

	*second stage
	ivreg2 $dependent $control1 i.YEAR i.ISO_ID (DEPS_low`ia' = LOW_instrument), cluster(ISO_ID) partial($control1 i.YEAR i.ISO_ID) first savefirst 
	mat def first_1=e(first) 
	global f1_low_text = first_1[4,1]
	outreg2 using "`path_second'", keep(DEPS_low`ia' DEPS_high`ia') bdec(3) dec(3) pdec(3) alpha(0.01, 0.05, 0.1) excel app ///
	addtext(TIME FE, YES, UNIT FE, YES, TYPE, LOW, INSTRUMENT, `inst', FStat low, $f1_low_text) nor2

	*first stage
	estimates restore _ivreg2_DEPS_low`ia'
	outreg2 using "`path_first'", bdec(7) dec(3) pdec(3) alpha(0.01, 0.05, 0.1) excel app ///
	addtext(TIME FE, YES, UNIT FE, YES, TYPE, LOW, INSTRUMENT, `inst', FStat low, $f1_low_text) nor2

	************

	*second stage
	ivreg2 $dependent $control1 i.YEAR i.ISO_ID (DEPS_high`ia' = HIGH_instrument), cluster(ISO_ID) partial($control1 i.YEAR i.ISO_ID) first savefirst 
	mat def first_1=e(first) 
	global f1_high_text = first_1[4,1]
	outreg2 using "`path_second'", keep(DEPS_low`ia' DEPS_high`ia') bdec(3) dec(3) pdec(3) alpha(0.01, 0.05, 0.1) excel app ///
	addtext(TIME FE, YES, UNIT FE, YES, TYPE, HIGH, INSTRUMENT, `inst', FStat high, $f1_high_text) nor2

	*first stage
	estimates restore _ivreg2_DEPS_high`ia'
	outreg2 using "`path_first'", bdec(7) dec(3) pdec(3) alpha(0.01, 0.05, 0.1) excel app ///
	addtext(TIME FE, YES, UNIT FE, YES, TYPE, HIGH, INSTRUMENT, `inst', FStat high, $f1_high_text) nor2

	************

	drop LOW_instrument HIGH_instrument DEPS_low`ia' DEPS_high`ia'
	estimates clear
	
}

*****************************************

*dirty energy share
*define endogenous and instrumental variables
local ia "energysh"
local inst "peopleAffectEQ_urbanCoastLOG"
gen LOW_instrument = low_`ia'_V4*`inst'
gen HIGH_instrument = high_`ia'_V4*`inst'
gen DEPS_low`ia' = (DEPS_low_`ia'_V4)
gen DEPS_high`ia' = (DEPS_high_`ia'_V4)

************

*second stage
ivreg2 $dependent $control1 i.YEAR i.ISO_ID (DEPS_low`ia' = LOW_instrument), cluster(ISO_ID) partial($control1 i.YEAR i.ISO_ID) first savefirst 
mat def first_1=e(first) 
global f1_low_text = first_1[4,1]
outreg2 using "`path_second'", keep(DEPS_low`ia' DEPS_high`ia') bdec(3) dec(3) pdec(3) alpha(0.01, 0.05, 0.1) excel app ///
addtext(TIME FE, YES, UNIT FE, YES, TYPE, LOW, INSTRUMENT, `inst', FStat low, $f1_low_text) nor2

*first stage
estimates restore _ivreg2_DEPS_low`ia'
outreg2 using "`path_first'", bdec(7) dec(3) pdec(3) alpha(0.01, 0.05, 0.1) excel app ///
addtext(TIME FE, YES, UNIT FE, YES, TYPE, LOW, INSTRUMENT, `inst', FStat low, $f1_low_text) nor2

************

*second stage
ivreg2 $dependent $control1 i.YEAR i.ISO_ID (DEPS_high`ia' = HIGH_instrument), cluster(ISO_ID) partial($control1 i.YEAR i.ISO_ID) first savefirst 
mat def first_1=e(first) 
global f1_high_text = first_1[4,1]
outreg2 using "`path_second'", keep(DEPS_low`ia' DEPS_high`ia') bdec(3) dec(3) pdec(3) alpha(0.01, 0.05, 0.1) excel app ///
addtext(TIME FE, YES, UNIT FE, YES, TYPE, HIGH, INSTRUMENT, `inst', FStat high, $f1_high_text) nor2

*first stage
estimates restore _ivreg2_DEPS_high`ia'
outreg2 using "`path_first'", bdec(7) dec(3) pdec(3) alpha(0.01, 0.05, 0.1) excel app ///
addtext(TIME FE, YES, UNIT FE, YES, TYPE, HIGH, INSTRUMENT, `inst', FStat high, $f1_high_text) nor2

************

drop LOW_instrument HIGH_instrument DEPS_low`ia' DEPS_high`ia'
estimates clear			

*****************************************

*initial EPS
*define endogenous and instrumental variables
local ia "initialEPS"
local inst "peopleAffectEQ_urbanCoastLOG"
gen LOW_instrument = low_`ia'_V3*`inst'
gen HIGH_instrument = high_`ia'_V3*`inst'
gen DEPS_low`ia' = (DEPS_low_`ia'_V3)
gen DEPS_high`ia' = (DEPS_high_`ia'_V3)

************

*second stage
ivreg2 $dependent $control1 i.YEAR i.ISO_ID (DEPS_low`ia' = LOW_instrument), cluster(ISO_ID) partial($control1 i.YEAR i.ISO_ID) first savefirst 
mat def first_1=e(first) 
global f1_low_text = first_1[4,1]
outreg2 using "`path_second'", keep(DEPS_low`ia' DEPS_high`ia') bdec(3) dec(3) pdec(3) alpha(0.01, 0.05, 0.1) excel app ///
addtext(TIME FE, YES, UNIT FE, YES, TYPE, LOW, INSTRUMENT, `inst', FStat low, $f1_low_text) nor2

*first stage
estimates restore _ivreg2_DEPS_low`ia'
outreg2 using "`path_first'", bdec(7) dec(3) pdec(3) alpha(0.01, 0.05, 0.1) excel app ///
addtext(TIME FE, YES, UNIT FE, YES, TYPE, LOW, INSTRUMENT, `inst', FStat low, $f1_low_text) nor2

************

*second stage
ivreg2 $dependent $control1 i.YEAR i.ISO_ID (DEPS_high`ia' = HIGH_instrument), cluster(ISO_ID) partial($control1 i.YEAR i.ISO_ID) first savefirst 
mat def first_1=e(first) 
global f1_high_text = first_1[4,1]
outreg2 using "`path_second'", keep(DEPS_low`ia' DEPS_high`ia') bdec(3) dec(3) pdec(3) alpha(0.01, 0.05, 0.1) excel app ///
addtext(TIME FE, YES, UNIT FE, YES, TYPE, HIGH, INSTRUMENT, `inst', FStat high, $f1_high_text) nor2

*first stage
estimates restore _ivreg2_DEPS_high`ia'
outreg2 using "`path_first'", bdec(7) dec(3) pdec(3) alpha(0.01, 0.05, 0.1) excel app ///
addtext(TIME FE, YES, UNIT FE, YES, TYPE, HIGH, INSTRUMENT, `inst', FStat high, $f1_high_text) nor2

************

drop LOW_instrument HIGH_instrument DEPS_low`ia' DEPS_high`ia'
estimates clear


restore

*****************************************
*****************************************

local path_first "results/appendix/TABLE_SI_13-17_1st.txt"
capture noisily rm `path_first'
local path_second "results/appendix/TABLE_SI_13-17_2nd.txt"
capture noisily rm `path_second'

preserve

*oil price, gas price, years until next election
local inst "eventsFlood_coastLengthWRI"
global interaction_temp "giniMRKT giniNET top1share top10share top20share bot1share bot10share bot20share sbCASH sbKIND almpExp unempExp"
foreach ia in $interaction_temp {
	
	*update instrument
	if ("`ia'" == "sbCASH" | "`ia'" == "sbKIND") {
       local inst "peopleAffectEQ_urbanCoastLOG"
    }
	
	*define endogenous and instrumental variables
	gen LOW_instrument = low_`ia'_V1*`inst'
	gen HIGH_instrument = high_`ia'_V1*`inst'
	gen DEPS_low`ia' = (DEPS_low_`ia'_V1)
	gen DEPS_high`ia' = (DEPS_high_`ia'_V1)

	************

	*second stage
	ivreg2 $dependent $control1 i.YEAR i.ISO_ID (DEPS_low`ia' = LOW_instrument), cluster(ISO_ID) partial($control1 i.YEAR i.ISO_ID) first savefirst 
	mat def first_1=e(first) 
	global f1_low_text = first_1[4,1]
	outreg2 using "`path_second'", keep(DEPS_low`ia' DEPS_high`ia') bdec(3) dec(3) pdec(3) alpha(0.01, 0.05, 0.1) excel app ///
	addtext(TIME FE, YES, UNIT FE, YES, TYPE, LOW, INSTRUMENT, `inst', FStat low, $f1_low_text) nor2

	*first stage
	estimates restore _ivreg2_DEPS_low`ia'
	outreg2 using "`path_first'", bdec(7) dec(3) pdec(3) alpha(0.01, 0.05, 0.1) excel app ///
	addtext(TIME FE, YES, UNIT FE, YES, TYPE, LOW, INSTRUMENT, `inst', FStat low, $f1_low_text) nor2

	************

	*second stage
	ivreg2 $dependent $control1 i.YEAR i.ISO_ID (DEPS_high`ia' = HIGH_instrument), cluster(ISO_ID) partial($control1 i.YEAR i.ISO_ID) first savefirst 
	mat def first_1=e(first) 
	global f1_high_text = first_1[4,1]
	outreg2 using "`path_second'", keep(DEPS_low`ia' DEPS_high`ia') bdec(3) dec(3) pdec(3) alpha(0.01, 0.05, 0.1) excel app ///
	addtext(TIME FE, YES, UNIT FE, YES, TYPE, HIGH, INSTRUMENT, `inst', FStat high, $f1_high_text) nor2

	*first stage
	estimates restore _ivreg2_DEPS_high`ia'
	outreg2 using "`path_first'", bdec(7) dec(3) pdec(3) alpha(0.01, 0.05, 0.1) excel app ///
	addtext(TIME FE, YES, UNIT FE, YES, TYPE, HIGH, INSTRUMENT, `inst', FStat high, $f1_high_text) nor2

	************

	drop LOW_instrument HIGH_instrument DEPS_low`ia' DEPS_high`ia'
	estimates clear
	local inst "eventsFlood_coastLengthWRI"
}

