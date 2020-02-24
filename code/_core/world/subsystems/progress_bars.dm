var/global/list/all_progress_bars = list()

SUBSYSTEM_DEF(progress_bars)
	name = "Progress Bar Subsystem"
	desc = "Controls the display of progress bars."
	tick_rate = DECISECONDS_TO_TICKS(1)
	priority = SS_ORDER_IMPORTANT

/subsystem/progress_bars/on_life()
	for(var/obj/hud/progress_bar/P in all_progress_bars)

		var/failed_first_turf = length(P.callback_list) && P.callback_list["start_turf"]  && P.callback_list["start_turf"] != get_turf(P.loc)
		var/failed_second_turf = length(P.callback_list) && P.callback_list["target_start_turf"] && P.callback_list["target"]  && P.callback_list["target_start_turf"] != get_turf(P.callback_list["target"])

		if(failed_first_turf || failed_second_turf || !P.loc)
			all_progress_bars -= P
			if(P.loc)
				P.loc.on_progress_bar_failed(P.id,P.callback_list)
				P.loc.doing_progress = FALSE
			animate(P,alpha=0,time=5)
			queue_delete(P,10)
			continue

		if(P.end_time < world.time)
			all_progress_bars -= P
			P.loc.doing_progress = FALSE
			animate(P,alpha=0,time=5)
			P.loc.on_progress_bar_completed(P.id,P.callback_list)
			queue_delete(P,10)
			continue

		P.update_icon()

	return TRUE


/proc/add_progress_bar(var/atom/A,var/desired_id,var/duration,var/list/callback_list)

	if(A.doing_progress)
		if(is_living(A))
			var/mob/living/L = A
			L.to_chat(span("notice","You're already busy with a task!"))
		return FALSE

	var/obj/hud/progress_bar/P = new(A, desired_id, world.time, world.time + duration, callback_list)
	all_progress_bars += P
	A.doing_progress = TRUE
	return TRUE