var/global/list/

SUBSYSTEM_DEF(radio)
	name = "Radio Subsystem"
	desc = "Controls radios."
	tick_rate = SECONDS_TO_TICKS(1)
	priority = SS_ORDER_NORMAL

	cpu_usage_max = 50
	tick_usage_max = 50

	var/list/unprocessed_radio_data = list()

/subsystem/radio/unclog(var/mob/caller)

	unprocessed_radio_data.Cut()

	broadcast_to_clients(span("danger","Removed all unprocessed radio data."))

	return ..()

/subsystem/radio/on_life()

	for(var/k in all_radios)
		var/obj/item/device/radio/R = k
		if(!R.receiving)
			continue
		for(var/data_key in unprocessed_radio_data)
			CHECK_TICK(tick_usage_max,FPS_SERVER*10)
			var/data_value = unprocessed_radio_data[data_key]
			try
				R.receive_data(data_value)
			catch(var/exception/e)
				log_error("radio on_life(): [e] on [e.file]:[e.line]\n[e.desc]!")
	unprocessed_radio_data.Cut()

	return TRUE

