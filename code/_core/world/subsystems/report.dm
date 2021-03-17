SUBSYSTEM_DEF(report)
	name = "Tick Report Subsystem"
	desc = "Makes a report of performance."
	tick_rate = 1
	priority = SS_ORDER_REPORT

	var/list/stored_tick_reports = list()

	var/average_cpu = 0
	var/average_tick = 0

	var/next_report = 0

/subsystem/report/Initialize()
	next_report = world.time + SECONDS_TO_DECISECONDS(300)
	. = ..()

/subsystem/report/on_life()

	average_cpu = FLOOR( (average_cpu + world.cpu) / 2 , 1)
	average_tick = FLOOR( (average_tick + world.tick_usage) / 2, 1)

	if(world.time >= next_report)
		log_subsystem(src.name,"Average CPU Rate: [average_cpu], Average Tick Rate: [average_tick].")
		next_report = world.time + SECONDS_TO_DECISECONDS(300)

	return TRUE