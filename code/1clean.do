*CREATE INTERACTION TERMS

*V1: country-year and country mean
global interaction_temp "oilPrice gasPrice yrcurnt initialEPS energysh top1share top10share top20share bot1share bot10share bot20share giniMRKT giniNET sbCASH sbKIND almpExp unempExp"
foreach var in $interaction_temp {

	bys ISO_ID: egen mean_VAR = mean(`var')
	bys ISO_ID: egen sd_VAR = sd(`var')
	tsset ISO_ID YEAR, yearly
	gen zVAR=(`var'-mean_VAR)/sd_VAR
	gen gVAR=exp(-1.5*zVAR)/(1+exp(-1.5*zVAR))
	gen DEPS_low_`var'_V1 = D.EPS*gVAR
	gen DEPS_high_`var'_V1 = D.EPS*(1-gVAR)
	gen low_`var'_V1 = gVAR
	gen high_`var'_V1 = (1-gVAR)
	drop mean_VAR sd_VAR zVAR gVAR
	
}

*V3: country mean and sample mean: initial EPS
bys ISO_ID: egen country_mean_VAR = mean(initialEPS)
egen mean_VAR = mean(initialEPS)
egen sd_VAR = sd(initialEPS)
tsset ISO_ID YEAR, yearly
gen zVAR=(country_mean_VAR-mean_VAR)/sd_VAR
gen gVAR=exp(-1.5*zVAR)/(1+exp(-1.5*zVAR))
gen DEPS_low_initialEPS_V3 = D.EPS*gVAR
gen DEPS_high_initialEPS_V3 = D.EPS*(1-gVAR)
gen low_initialEPS_V3 = gVAR
gen high_initialEPS_V3 = (1-gVAR)
drop mean_VAR sd_VAR zVAR gVAR country_mean_VAR

*V4: first value: dirty energy share
gen temp_first = energysh if YEAR == 2001
bysort ISO: replace temp_first = temp_first[_n-1] if missing(temp_first)
egen mean_VAR = mean(energysh)
egen sd_VAR = sd(energysh)
tsset ISO_ID YEAR, yearly
gen zVAR=(temp_first-mean_VAR)/sd_VAR
gen gVAR=exp(-1.5*zVAR)/(1+exp(-1.5*zVAR))
gen DEPS_low_energysh_V4 = D.EPS*gVAR
gen DEPS_high_energysh_V4 = D.EPS*(1-gVAR)
gen low_energysh_V4 = gVAR
gen high_energysh_V4 = (1-gVAR)
drop mean_VAR sd_VAR zVAR gVAR temp_first
