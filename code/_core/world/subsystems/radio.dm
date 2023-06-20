SUBSYSTEM_DEF(radio)
	name = "Radio Subsystem"
	desc = "Controls radios."
	tick_rate = SECONDS_TO_TICKS(1)
	priority = SS_ORDER_POSTLOAD

	tick_usage_max = 50

	var/radio_syn
	var/radio_rev
	var/radio_merc

	var/list/obj/item/device/radio/all_radios = list()

//Radios should never be unclogged.
/subsystem/radio/unclog(var/mob/caller)
	tick_rate = -1
	. = ..()

/subsystem/radio/Initialize()
	radio_syn = rand(RADIO_FREQ_SYNDICATE_MIN,RADIO_FREQ_SYNDICATE_MAX)
	radio_rev = rand(RADIO_FREQ_REVOLUTIONARY_MIN,RADIO_FREQ_REVOLUTIONARY_MAX)
	radio_merc = rand(RADIO_FREQ_MERCENARY_MIN,RADIO_FREQ_MERCENARY_MAX)
	. = ..()

/subsystem/radio/on_life()

	for(var/area_id in all_telecomms) //Get all area ids in this telecomms list.
		if(!area_id)
			all_telecomms -= area_id
			continue
		for(var/k in all_telecomms[area_id]) //Get all telecomms units in this area_id
			var/obj/structure/interactive/telecomms/TC = k
			if(!TC || TC.qdeleting)
				all_telecomms[area_id] -= k
				continue
			TC.process_all_data()
			CHECK_TICK(tick_usage_max,FPS_SERVER)

	return TRUE

