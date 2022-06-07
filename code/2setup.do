*DEFINE VARIABLE LISTS

*DEPENDENT VARIABLES
global dependent "D_Popularsupport"

*INTERACTION VARIABLES
global interaction "oilPrice gasPrice yrcurnt initialEPS energysh top1share top10share top20share bot1share bot10share bot20share giniMRKT giniNET sbCASH sbKIND almpExp unempExp"

*CONTROL VARIABLES
global control1 "deficit_oecd elderly_oecd gdpr_wb"
global control2 "deficit_oecd elderly_oecd gdpr_wb unemprate_wb"
global control3 "deficit_oecd elderly_oecd gdpr_wb unemprate_wb cpi_full_oecd"
global control4 "deficit_oecd elderly_oecd gdpr_wb unemprate_wb cpi_full_oecd voteshare"
global control5 "deficit_oecd elderly_oecd gdpr_wb unemprate_wb cpi_full_oecd voteshare wedge2"
global control6 "deficit_oecd elderly_oecd gdpr_wb unemprate_wb cpi_full_oecd voteshare wedge2 finref_index_ref product_index_ref current_index_ref capital_index_ref labor_index_ref"
global controlorder "deficit_oecd elderly_oecd gdpr_wb unemprate_wb cpi_full_oecd voteshare wedge2 finref_index_ref product_index_ref current_index_ref capital_index_ref labor_index_ref"

*INSTRUMENTAL VARIABLES
global instrument "eventsFlood_coastLengthWRI peopleAffectEQ_urbanCoastLOG majorHurric_cenDist eventsWildfire_agriLandPC"
