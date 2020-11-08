SUBSYSTEM_DEF(holiday)
	name = "Holiday Subsystem"
	desc = "Calculates if it's a holiday or not."
	priority = SS_ORDER_NORMAL
	tick_rate = SECONDS_TO_TICKS(1)

	var/list/all_events = list()
	var/list/all_events_prob = list()
	var/list/all_events_active = list()

	var/next_event_time = 0


	var/list/holidays = list()

/subsystem/holiday/Initialize()

	var/real_time = world.realtime

	var/month = text2num(time2text(real_time,"MM"))
	var/day = text2num(time2text(real_time,"DD"))
	//var/year = text2num(time2text(real_time,"YYYY"))

	//October
	if(month == 10)
		if(day >= 31 - 7 && day <= 31)
			holidays[/holiday/halloween] = new /holiday/halloween

	for(var/k in holidays)
		var/holiday/H = holidays[k]
		INITIALIZE(H)
		GENERATE(H)
		FINALIZE(H)