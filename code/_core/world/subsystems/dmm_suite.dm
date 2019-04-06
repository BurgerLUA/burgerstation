var/global/dmm_suite/dmm_suite

/subsystem/dmm_suite/
	name = ".dmm Suite Subsystem"
	desc = "Map loading and saving."
	priority = SS_ORDER_DMM

/subsystem/dmm_suite/Initialize()
	dmm_suite = new()
