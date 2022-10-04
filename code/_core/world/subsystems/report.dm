SUBSYSTEM_DEF(report)
	name = "Tick Report Subsystem"
	desc = "Makes a report of performance."
	tick_rate = 1
	priority = SS_ORDER_REPORT

	var/list/stored_tick_reports = list()

	var/average_cpu = 0
	var/min_cpu = INFINITY
	var/max_cpu = -INFINITY

	var/average_tick = 0
	var/min_tick = INFINITY
	var/max_tick = -INFINITY


	var/next_report = 0

/subsystem/report/Initialize()
	next_report = world.time + SECONDS_TO_DECISECONDS(300)
	. = ..()

/subsystem/report/on_life()

	min_cpu = CEILING(min(min_cpu,world.cpu),1)
	max_cpu = CEILING(max(max_cpu,world.cpu),1)
	average_cpu = CEILING( (average_cpu + world.cpu) / 2 , 1)

	min_tick = CEILING(min(min_tick,world.tick_usage),1)
	max_tick = CEILING(max(max_tick,world.tick_usage),1)
	average_tick = CEILING( (average_tick + world.tick_usage) / 2, 1)

	if(world.time >= next_report)
		make_report()
		next_report = world.time + SECONDS_TO_DECISECONDS(300)

	return TRUE

/subsystem/report/proc/make_report()
	log_subsystem(src.name,"<br>CPU:(MIN:[min_cpu]%,MAX:[max_cpu]%,AVG:[average_cpu]%)<br>TICK:(MIN:[min_tick]%,MAX:[max_tick]%,AVG:[average_tick]%)")
	average_cpu = initial(average_cpu)
	min_cpu = initial(min_cpu)
	max_cpu = initial(max_cpu)
	average_tick = initial(average_tick)
	min_tick = initial(min_tick)
	max_tick = initial(max_tick)
	return TRUE