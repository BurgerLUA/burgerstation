var/global/list/all_progress_bars = list()


/subsystem/progress_bars/
	name = "Progress Bar Subsystem"
	desc = "Controls the display of progress bars."
	tick_rate = DECISECONDS_TO_TICKS(1)
	priority = SS_ORDER_IMPORTANT

/subsystem/progress_bars/on_life()
	for(var/obj/progress_bar/P in all_progress_bars)
		if(P.end_time <= curtime+1)
			all_progress_bars -= P
			P.loc.on_progress_bar_completed(P.id)
			animate(P,alpha=0,time=5)
			queue_delete(P,10)
		else
			P.update_icon()

	return TRUE

/proc/add_progress_bar(var/atom/A,var/desired_id,var/duration)
	var/obj/progress_bar/P = new(A,desired_id,curtime,curtime + duration)
	all_progress_bars += P
