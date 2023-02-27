/ai/proc/add_to_active_list(var/z)
	if(z <= 0)
		log_error("FATAL ERROR: Tried adding [src.get_debug_name()] to active ai list of z [z]!")
		return FALSE
	if(debug) log_debug("Adding to active list [z].")
	var/list/active_ai_list = boss ? SSbossai.active_ai_by_z : SSai.active_ai_by_z
	if(!active_ai_list["[z]"])
		active_ai_list["[z]"] = list()
	active_ai_list["[z]"] += src
	return FALSE

/ai/proc/remove_from_active_list(var/z)
	if(debug) log_debug("Removing from active list [z].")
	var/list/active_ai_list = boss ? SSbossai.active_ai_by_z : SSai.active_ai_by_z
	if(length(active_ai_list) && active_ai_list["[z]"])
		active_ai_list["[z]"] -= src

/ai/proc/add_to_inactive_list(var/z)
	if(z <= 0)
		log_error("FATAL ERROR: Tried adding [src.get_debug_name()] to inactive ai list of z [z]!")
		return FALSE
	if(debug) log_debug("Adding to inactive list [z].")
	var/list/inactive_ai_list = boss ? SSbossai.inactive_ai_by_z : SSai.inactive_ai_by_z
	if(!inactive_ai_list["[z]"])
		inactive_ai_list["[z]"] = list()
	inactive_ai_list["[z]"] += src

/ai/proc/remove_from_inactive_list(var/z)
	if(debug) log_debug("Removing from inactive list [z].")
	var/list/inactive_ai_list = boss ? SSbossai.inactive_ai_by_z : SSai.inactive_ai_by_z
	if(length(inactive_ai_list) && inactive_ai_list["[z]"])
		inactive_ai_list["[z]"] -= src

/ai/proc/set_active(var/desired_active=TRUE,var/deleting=FALSE)

	if(desired_active)
		if(!owner)
			return FALSE
		if(owner.qdeleting)
			return FALSE
		if(owner.dead)
			return FALSE

	if(active == desired_active)
		return FALSE

	active = desired_active

	var/turf/T = get_turf(owner)

	if(!T) CRASH("AI belonging to [owner ? owner.get_debug_name() : src.type] had an invalid turf!")

	if(active)
		PROCESS_LIVING(owner)
		add_to_active_list(T.z)
		remove_from_inactive_list(T.z)
		HOOK_ADD("post_move","\ref[src]_post_move",owner,src,.proc/post_move)
		HOOK_ADD("pre_death","\ref[src]_pre_death",owner,src,.proc/pre_death)
		if(debug) log_debug("Setting to active.")
	else
		UNPROCESS_LIVING(owner)
		if(!deleting) add_to_inactive_list(T.z)
		remove_from_active_list(T.z)
		set_alert_level(ALERT_LEVEL_NONE,can_lower=TRUE)
		set_objective(null)
		set_move_objective(null)
		set_hunt_target(null)
		CALLBACK_REMOVE("set_new_objective_\ref[src]")
		attackers.Cut()
		obstacles.Cut()
		HOOK_REMOVE("post_move","\ref[src]_post_move",owner)
		HOOK_REMOVE("pre_death","\ref[src]_pre_death",owner)
		if(debug) log_debug("Setting to inactive.")

	return TRUE