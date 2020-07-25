/proc/notify_ghosts(var/text,var/turf/T)
	var/formatted_message = span("dead bold","[text] (Click <a href='?spectate=1;x=[T.x];y=[T.y];z=[T.z]'>here</a> to observe.)")

	for(var/mob/abstract/observer/ghost/O in all_mobs)
		O.to_chat(formatted_message)

	return TRUE