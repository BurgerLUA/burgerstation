/client/proc/find_controlling_mob()

	if(mob)
		return mob

	. = null

	for(var/k in SSliving.all_mobs)
		var/mob/M = k
		if(!M || M.qdeleting)
			continue
		if(M.ckey_last == ckey)
			. = M
			return .
		if(M.ckey_owner == ckey && !M.ckey_last)
			if(is_living(M))
				var/mob/living/L = M
				if(L.dead)
					continue
			. = M
			//No break here as ckey_last needs a priority.

/client/proc/make_ghost(turf/desired_loc)

	if(!desired_loc && mob)
		desired_loc = get_turf(mob)

	if(!desired_loc)
		desired_loc = FALLBACK_TURF

	if(mob)
		mob.ckey_last = null
		if(mob.fallback_mob)
			control_mob(mob.fallback_mob)
			return TRUE

	var/mob/abstract/observer/ghost/O = new(desired_loc,src)
	INITIALIZE(O)
	FINALIZE(O)

/client/proc/make_observer(turf/desired_loc)

	if(mob)
		mob.ckey_last = null

	var/mob/abstract/observer/menu/O = new(desired_loc,src)
	INITIALIZE(O)
	FINALIZE(O)

	return TRUE

/client/proc/control_mob(mob/M,delete_last_mob = FALSE)

	if(!M)
		return FALSE

	if(delete_last_mob)
		if(mob) qdel(mob)
	else if(mob)
		clear_mob(mob,TRUE)

	M.client = src
	M.ckey = src.ckey
	M.ckey_last = src.ckey
	M.ckey_owner = src.ckey

	mob = M
	eye = M

	SSliving.all_mobs_with_clients += M
	if(M.last_z) //The mob could still be in null space.
		if(!SSliving.all_mobs_with_clients_by_z["[M.last_z]"])
			SSliving.all_mobs_with_clients_by_z["[M.last_z]"] = list()
		SSliving.all_mobs_with_clients_by_z["[M.last_z]"] += M

	view = M.view

	update_zoom(2)
	update_verbs()

	if(!M.listener)
		M.listener = TRUE
		SSradio.all_listeners += src

	update_statpanel = TRUE

/client/proc/clear_mob(mob/M,hard = FALSE) //This is called when the client no longer controls this mob.

	known_inventory?.Cut()
	known_buttons?.Cut()
	known_stat_elements?.Cut()
	screen?.Cut()
	images?.Cut()

	if(!M)
		return FALSE

	SSliving.all_mobs_with_clients -= M
	if(SSliving.all_mobs_with_clients_by_z["[M.last_z]"])
		SSliving.all_mobs_with_clients_by_z["[M.last_z]"] -= src

	M.client = null
	if(hard)
		M.ckey_last = null
	if(M == mob)
		mob = null


/client/proc/load(savedata/client/mob/U,file_num)

	if(restricted)
		src.to_chat(span("danger",restricted))
		return FALSE

	U.loaded_data = U.load_json_data_from_id(file_num)
	U.loaded_data["id"] = file_num
	to_chat(span("notice","Successfully loaded character [U.loaded_data["name"]]."))
	stop_music_track(src)

	var/turf/T = length(world_spawnpoints) ? pick(world_spawnpoints) : FALLBACK_TURF

	var/mob/living/advanced/player/P = new(T,src)
	INITIALIZE(P)
	FINALIZE(P)

	return P
