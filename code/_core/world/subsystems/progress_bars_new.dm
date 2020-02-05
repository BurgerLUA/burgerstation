var/global/subsystem/progress_bars/SSprogressbars

/subsystem/progress_bars/
	name = "Progress Bar Subsystem"
	desc = "Controls the display of progress bars."
	tick_rate = DECISECONDS_TO_TICKS(1)
	priority = SS_ORDER_IMPORTANT

	var/list/all_progress_bars = list()

/subsystem/progress_bars/Initialize()
	SSprogressbars = src
	return TRUE

/subsystem/progress_bars/on_life()
	for(var/k in all_progress_bars)
		var/atom/A = k
		var/list/progress_list = all_progress_bars[k]
		var/obj/hud/progress_bar/P = progress_list["progress_bar"]

		if(progress_list["condition_proc"] && !call(progress_list["condition_proc"])(arglist(progress_list["condition_args"])))
			animate(P,alpha=0,time=5)
			queue_delete(P,10)
			all_progress_bars -= A
			continue

		if(progress_list["time"] >= curtime)
			call(progress_list["proc"])(arglist(progress_list["args"]))
			animate(P,alpha=0,time=5)
			queue_delete(P,10)
			all_progress_bars -= A
			continue

		P.update_icon()

	return TRUE

/subsystem/progress_bars/proc/add_progress_bar(var/atom/A,var/desired_time,var/desired_proc,...)

	if(all_progress_bars[A])
		if(is_mob(A))
			var/mob/M = A
			M.to_chat(span("notice","You're already busy with a task!"))
		return FALSE

	all_progress_bars[A] = list(
		"proc" = desired_proc,
		"args" = args.Copy(4),
		"time" = curtime + desired_time,
		"progress_bar" = new /obj/hud/progress_bar(A,curtime,curtime + desired_time)
	)

	return TRUE

/subsystem/progress_bars/proc/add_progress_bar_conditions(var/atom/A,var/desired_proc,...)

	if(!all_progress_bars[A])
		return FALSE

	all_progress_bars[A]["condition_proc"] = desired_proc
	all_progress_bars[A]["condition_args"] = args.Copy(3)

	return TRUE