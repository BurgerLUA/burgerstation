/client/proc/make_ghost(var/turf/desired_loc)
	var/mob/abstract/observer/O = new(desired_loc,src)
	INITIALIZE(O)
	O.force_move(desired_loc)

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
	update_zoom(-1)

	all_mobs_with_clients += M

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

	all_mobs_with_clients -= M
	M.client = null
	if(hard)
		M.ckey_last = null
	if(M == mob)
		mob = null
