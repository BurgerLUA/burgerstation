var/global/list/all_unprocessed_radio_data = list()

SUBSYSTEM_DEF(radio)
	name = "Radio Subsystem"
	desc = "Controls radios."
	tick_rate = SECONDS_TO_TICKS(1)
	priority = SS_ORDER_NORMAL

	cpu_usage_max = 50
	tick_usage_max = 50

/subsystem/radio/on_life()

	for(var/k in all_radios)
		var/obj/item/device/radio/R = k
		if(!R.receiving)
			continue
		for(var/data_key in all_unprocessed_radio_data)
			CHECK_TICK(tick_usage_max,FPS_SERVER*10)
			var/data_value = all_unprocessed_radio_data[data_key]
			R.receive_data(data_value)

	all_unprocessed_radio_data.Cut()

	return TRUE

