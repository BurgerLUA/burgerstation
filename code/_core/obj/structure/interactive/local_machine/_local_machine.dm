var/global/list/local_machines = list()

/obj/structure/interactive/localmachine
	name = "local machine"
	desc = "only certain players can see this."

	var/image/cached_image

	var/list/disallowed_mobs = list()

/obj/structure/interactive/localmachine/New()
	. = ..()
	local_machines += src
	update_icon()

/obj/structure/interactive/localmachine/proc/update_for_mob(var/mob/M)
	if(M in disallowed_mobs)
		return
	if(!(cached_image in M.overlays))
		M << cached_image

/obj/structure/interactive/localmachine/update_icon()
	if(!cached_image)
		cached_image = image(icon,icon_state = icon_state)
		cached_image.loc = src
		icon = null

	for(var/mob/M in all_mobs_with_clients)
		update_for_mob(M)

/obj/structure/interactive/localmachine/clicked_by_object(caller,object,location,control,params)
	if(is_mob(caller))
		var/mob/M = caller
		disallowed_mobs += M
		if(M.client)
			M.client.images -= cached_image

	return TRUE
