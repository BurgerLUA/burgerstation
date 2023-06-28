#define PROFILING_DELAY_SECONDS 600

SUBSYSTEM_DEF(report)
	name = "Tick Report Subsystem"
	desc = "Makes a report of performance."
	tick_rate = 1
	priority = SS_ORDER_REPORT

	var/average_cpu = 0
	var/min_cpu = INFINITY
	var/max_cpu = -INFINITY

	var/average_tick = 0
	var/min_tick = INFINITY
	var/max_tick = -INFINITY

	var/runtime_count = 0

	var/next_report = 0
	var/profiling = 0

/subsystem/report/unclog(var/mob/caller)
	tick_rate = -1
	. = ..()

/subsystem/report/Initialize()
	next_report = world.time + SECONDS_TO_DECISECONDS(PROFILING_DELAY_SECONDS)
	. = ..()

/subsystem/report/on_life()

	if(!profiling)
		profiling = TRUE
		start_profiling()
	else
		min_cpu = CEILING(min(min_cpu,world.cpu),1)
		max_cpu = CEILING(max(max_cpu,world.cpu),1)
		average_cpu = CEILING( (average_cpu + world.cpu) / 2 , 1)

		min_tick = CEILING(min(min_tick,world.tick_usage),1)
		max_tick = CEILING(max(max_tick,world.tick_usage),1)
		average_tick = CEILING( (average_tick + world.tick_usage) / 2, 1)

		if(world.time >= next_report)
			end_profling()
			next_report = world.time + SECONDS_TO_DECISECONDS(PROFILING_DELAY_SECONDS)
			profiling = FALSE

	return TRUE

/subsystem/report/proc/start_profiling()
	world.Profile(PROFILE_RESTART)
	return TRUE

/subsystem/report/proc/end_profling()

	var/list/profile_output = world.Profile(PROFILE_STOP)

	var/list/sorted_profile_output_self = list()
	var/list/sorted_profile_output_real = list()
	for(var/i=7,i<=length(profile_output),i+=6) //It just werks
		if(profile_output[i+1] > 0)
			sorted_profile_output_self[profile_output[i]] = profile_output[i+1]
		if(profile_output[i+3] > 0)
			sorted_profile_output_real[profile_output[i]] = profile_output[i+3]

	var/string_to_send = "<br><u>[CEILING(PROFILING_DELAY_SECONDS/60,1)] Minute Server Performance Report:</u><br>\
	CPU Usage: (\
	MIN:<div class='[min_cpu >= 50 ? "red bold" : "blue bold"]'>[min_cpu]%</div>, \
	MAX:<div class='[max_cpu >= 90 ? "red bold" : "blue bold"]'>[max_cpu]%</div>, \
	AVG:<div class='[average_cpu >= 75 ? "red bold" : "blue bold"]'>[average_cpu]%</div>)<br>\
	Tick Usage: (\
	MIN:<div class='[min_tick >= 50 ? "red bold" : "blue bold"]'>[min_tick]%</div>, \
	MAX:<div class='[max_tick >= 90 ? "red bold" : "blue bold"]'>[max_tick]%</div>, \
	AVG:<div class='[average_tick >= 75 ? "red bold" : "blue bold"]'>[average_tick]%</div>)<br>\
	Runtime Count:<div class='[runtime_count > 0 ? "red bold" : "blue bold"]'>[runtime_count]</div><br>"

	if(length(sorted_profile_output_self))
		string_to_send += "<u>Most Expensive Procs (self CPU%):</u><br>"
		sort_tim(sorted_profile_output_self,/proc/cmp_numeric_dsc,associative=TRUE)
		for(var/i=1,i<=min(length(sorted_profile_output_self),5),i++)
			var/name = sorted_profile_output_self[i]
			var/value = sorted_profile_output_self[name]
			string_to_send += "[name]: <div class='[value/PROFILING_DELAY_SECONDS >= 0.05 ? "red bold" : "blue bold"]'>[CEILING((value/PROFILING_DELAY_SECONDS)*100,0.1)]%</div>.<br>"

	if(length(sorted_profile_output_real))
		string_to_send += "<u>Most Expensive Procs (real time):</u><br>"
		sort_tim(sorted_profile_output_real,/proc/cmp_numeric_dsc,associative=TRUE)
		for(var/i=1,i<=min(length(sorted_profile_output_real),5),i++)
			var/name = sorted_profile_output_real[i]
			var/value = sorted_profile_output_real[name]
			string_to_send += "[name]: <div class='[value >= PROFILING_DELAY_SECONDS*0.5 ? "red bold" : "blue bold"]'>[CEILING(value,0.01)]</div> seconds.<br>"

	broadcast_to_clients(span("debug",string_to_send),CHAT_TYPE_DEBUG)

	average_cpu = initial(average_cpu)
	min_cpu = initial(min_cpu)
	max_cpu = initial(max_cpu)
	average_tick = initial(average_tick)
	min_tick = initial(min_tick)
	max_tick = initial(max_tick)
	runtime_count = initial(runtime_count)

	profiling = FALSE

	return TRUE