SUBSYSTEM_DEF(radio)
	name = "Radio Subsystem"
	desc = "Controls radios."
	tick_rate = SECONDS_TO_TICKS(1)
	priority = SS_ORDER_POSTLOAD

	cpu_usage_max = 50
	tick_usage_max = 50

	var/radio_syn
	var/radio_rev
	var/radio_merc

	var/list/obj/item/device/radio/all_radios = list()

/subsystem/radio/Initialize()
	radio_syn = rand(RADIO_FREQ_SYNDICATE_MIN,RADIO_FREQ_SYNDICATE_MAX)
	radio_rev = rand(RADIO_FREQ_REVOLUTIONARY_MIN,RADIO_FREQ_REVOLUTIONARY_MAX)
	radio_merc = rand(RADIO_FREQ_MERCENARY_MIN,RADIO_FREQ_MERCENARY_MAX)
	. = ..()

/subsystem/radio/on_life()

	var/list/queued_telecomms = list()

	for(var/area_id in all_telecomms)
		var/list/area_list = all_telecomms[area_id]
		for(var/k in area_list)
			var/obj/structure/interactive/telecomms/TC = k
			queued_telecomms |= TC
			CHECK_TICK_SAFE(tick_usage_max,FPS_SERVER)

	for(var/k in queued_telecomms)
		var/obj/structure/interactive/telecomms/TC = k
		TC.process_all_data()
		CHECK_TICK_SAFE(tick_usage_max,FPS_SERVER)

	return TRUE

