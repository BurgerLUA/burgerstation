SUBSYSTEM_DEF(power)
	name = "Power Subsystem"
	desc = "Handle power processing and other cool things."
	priority = SS_ORDER_LAST

	tick_rate = SECONDS_TO_TICKS(1)

	tick_usage_max = 50
	cpu_usage_max = 50

	var/list/power_network/all_power_networks = list()

/subsystem/power/on_life()

	for(var/k in all_power_networks)
		var/power_network/PN = k
		PN.power_process()

	return TRUE