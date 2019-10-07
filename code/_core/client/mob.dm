client/proc/control_mob(var/mob/M)

	if(!M)
		return FALSE

	clear_mob(mob)

	M.client = src
	all_mobs_with_clients += src
	M.ckey = src.ckey
	mob = M
	update_zoom(-1)

client/proc/clear_mob(var/mob/M)

	known_inventory.Cut()
	known_buttons.Cut()
	known_health_elements.Cut()
	screen.Cut()
	images.Cut()

	if(!M)
		return FALSE

	all_mobs_with_clients -= M
	M.client = null
	if(M == mob)
		mob = null