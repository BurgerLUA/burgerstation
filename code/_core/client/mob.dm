/client/proc/make_ghost(var/turf/desired_loc)

	if(!desired_loc)
		desired_loc = FALLBACK_TURF

	if(mob)
		mob.ckey_last = null

	var/mob/abstract/observer/ghost/O = new(desired_loc,src)
	INITIALIZE(O)
	FINALIZE(O)

/client/proc/make_observer(var/turf/desired_loc)
	if(!desired_loc)
		desired_loc = FALLBACK_TURF

	if(mob)
		mob.ckey_last = null

	var/mob/abstract/observer/menu/O = new(desired_loc,src)
	INITIALIZE(O)
	FINALIZE(O)

/client/proc/control_mob(var/mob/M,var/delete_last_mob = FALSE)

	if(!M)
		return FALSE

	if(delete_last_mob)
		if(mob) qdel(mob)
	else
		clear_mob(mob,TRUE)

	M.client = src
	M.ckey = src.ckey
	M.ckey_last = src.ckey

	mob = M
	eye = M
	all_mobs_with_clients |= M
	all_listeners |= M
	view = M.view

	update_zoom(2)
	update_verbs()

/client/proc/clear_mob(var/mob/M,var/hard = FALSE) //This is called when the client no longer controls this mob.

	if(known_inventory)
		known_inventory.Cut()

	if(known_buttons)
		known_buttons.Cut()

	if(known_health_elements)
		known_health_elements.Cut()

	if(screen)
		screen.Cut()

	if(images)
		images.Cut()

	if(!M)
		return FALSE

	if(M.parallax)
		for(var/k in M.parallax)
			var/obj/parallax/P = M.parallax[k]
			qdel(P)
			M.parallax -= P
		M.parallax.Cut()

	all_mobs_with_clients -= M
	if(!M.listener)
		all_listeners -= M
	M.client = null
	if(hard)
		M.ckey_last = null
	if(M == mob)
		mob = null


/client/proc/load(var/savedata/client/mob/U,var/file_num)

	if(restricted)
		src.to_chat(span("danger",restricted))
		return FALSE

	U.loaded_data = U.load_json_data_from_id(file_num)
	U.loaded_data["id"] = file_num
	to_chat(span("notice","Successfully loaded character [U.loaded_data["name"]]."))
	stop_music_track(src)

	var/mob/living/advanced/player/P = new(FALLBACK_TURF,src)
	INITIALIZE(P)
	FINALIZE(P)

	return P
