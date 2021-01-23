var/global/list/local_machines = list()

/obj/structure/interactive/localmachine
	name = "local machine"
	desc = "only certain players can see this."

	var/image/cached_image

	var/list/disallowed_mobs = list()

/obj/structure/interactive/localmachine/New()
	. = ..()
	local_machines += src
	update_sprite()

/obj/structure/interactive/localmachine/proc/update_for_mob(var/mob/M)

	if(M in disallowed_mobs)
		return

	M << cached_image

/obj/structure/interactive/localmachine/update_icon()
	if(!cached_image)
		cached_image = image(icon,icon_state = icon_state)
		cached_image.loc = src
		icon = null

	for(var/k in all_mobs_with_clients)
		var/mob/M = k
		update_for_mob(M)

/obj/structure/interactive/localmachine/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(ismob(caller))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(1)
		var/mob/M = caller
		disallowed_mobs += M
		clear_existing_images(M)
		return TRUE

	return ..()


/obj/structure/interactive/localmachine/proc/clear_existing_images(var/mob/M)

	if(!M.client)
		return

	M.client.images -= cached_image

	return TRUE