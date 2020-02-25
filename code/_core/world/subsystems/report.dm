SUBSYSTEM_DEF(report)
	name = "Report Subsystem"
	desc = "Constrols statistics to display"
	tick_rate = SECONDS_TO_TICKS(5)
	priority = SS_ORDER_REPORT


	var/list/stored_tick_reports = list()

	var/passes = 60

/subsystem/report/on_life()

	stored_tick_reports += world.tick_usage

	if(passes > 60)

		var/average = 0
		var/lowest = 100
		var/highest = 0

		for(var/num in stored_tick_reports)
			if(num > highest)
				highest = round(num)

			if(num < lowest)
				lowest = round(num)

			average += round(num)

		average = round(average / length(stored_tick_reports))
		stored_tick_reports = list()
		passes = 0

		var/text_to_broadcast = "<title>Tick Report</title> Lowest: [lowest]%, Highest: [highest]%, Average: [average]%.<br><i>Values over 100% means the server is experiencing CPU lag and you should yell and scream at Burger. Values less than 100% mean the server is functioning normally.</i>"
		broadcast_to_clients(text_to_broadcast)

	passes++
	return TRUE