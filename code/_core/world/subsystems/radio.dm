SUBSYSTEM_DEF(radio)
	name = "Radio Subsystem"
	desc = "Controls radios."
	tick_rate = SECONDS_TO_TICKS(1)
	priority = SS_ORDER_NORMAL

	cpu_usage_max = 50
	tick_usage_max = 50

/subsystem/radio/on_life()

	for(var/area_id in all_telecomms)
		var/list/area_list = all_telecomms[area_id]
		for(var/k in area_list)
			var/obj/structure/interactive/telecomms/TC = k
			TC.process_all_data()

	return TRUE

