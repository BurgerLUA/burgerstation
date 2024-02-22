#define within_range(point_A,point_B,range) (point_A.z == point_B.z && get_dist(point_A,point_B) <= range)

/proc/create_alert_process(var/list/list_to_use,var/range = VIEW_RANGE,var/atom/epicenter,var/atom/alert_source,var/alert_level = ALERT_LEVEL_NOISE,var/visual=FALSE)

	. = 0

	if(!epicenter)
		CRASH("No valid epicenter provided for create_alert_process()!")

	for(var/k in list_to_use)
		var/ai/AI = k
		if(!AI || AI.qdeleting || !AI.owner || AI.owner.qdeleting || AI.owner.dead || AI.objective_attack || AI.alert_level > alert_level)
			continue
		var/list/callback_data = CALLBACK_EXISTS("alert_level_change_\ref[AI]")
		if(callback_data && callback_data["args"][2] != alert_source) //Already reacting to something else.
			continue
		if(!within_range(AI.owner,epicenter,range)) //Too far away.
			continue
		if(visual && !is_facing_cheap(AI.owner,epicenter))
			continue
		if(alert_source && !AI.is_enemy(alert_source,FALSE))
			continue
		. += 1
		if(callback_data || AI.reaction_time <= 0) //Force a reaction instantly.
			CALLBACK_REMOVE("alert_level_change_\ref[AI]")
			AI.set_alert_level(alert_level,alert_source,epicenter,FALSE)
		else
			CALLBACK("alert_level_change_\ref[AI]",CEILING(AI.reaction_time,1),AI,AI::set_alert_level(),alert_level,alert_source,epicenter,FALSE)



/proc/create_alert(var/range = VIEW_RANGE,var/turf/epicenter,var/atom/alert_source,var/alert_level = ALERT_LEVEL_NOISE,var/visual=FALSE)

	if(!epicenter)
		CRASH("create_alert() had no epicenter!")

	if(epicenter.z == 0)
		CRASH("create_alert() had a non-turf as an epicenter!")

	if(is_living(alert_source))
		var/mob/living/L = alert_source
		if(L.master)
			if(L.master.next_alert > world.time)
				return FALSE
			L.master.next_alert = world.time + SECONDS_TO_DECISECONDS(1)
		else
			if(L.next_alert > world.time)
				return FALSE
			L.next_alert = world.time + SECONDS_TO_DECISECONDS(1)

	. = 0

	var/chunk/CH = CHUNK(epicenter)
	if(CH)
		. += create_alert_process(CH.ai,range,epicenter,alert_source,alert_level,visual)
		for(var/k in CH.adjacent_chunks)
			var/chunk/CH2 = k
			. += create_alert_process(CH2.ai,range,epicenter,alert_source,alert_level,visual)

	return .

