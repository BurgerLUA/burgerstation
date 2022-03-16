SUBSYSTEM_DEF(power)
	name = "Power Subsystem"
	desc = "Handle power processing and other cool things."
	priority = SS_ORDER_LAST

	tick_rate = SECONDS_TO_TICKS(1)

	tick_usage_max = 50
	cpu_usage_max = 50

	var/list/power_network/all_power_networks = list()
	var/list/area/all_apc_areas = list()

/subsystem/power/Initialize()
	. = ..()
	for(var/k in SSarea.all_areas)
		var/area/A = SSarea.all_areas[k]
		if(!A.requires_power)
			continue
		A.toggle_power_lights(FALSE,force=TRUE)
		A.toggle_power_machines(FALSE,force=TRUE)
		A.toggle_power_doors(FALSE,force=TRUE)

/subsystem/power/on_life()

	for(var/k in all_apc_areas)
		var/area/A = k
		A.apc_process()

	for(var/k in all_power_networks)
		var/power_network/PN = k
		PN.power_process()

	return TRUE