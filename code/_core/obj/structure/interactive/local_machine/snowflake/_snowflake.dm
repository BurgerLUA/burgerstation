/obj/structure/interactive/localmachine/snowflake
	name = "door"

	//Cached image is the default image.

	var/list/mob_to_image = list()


/obj/structure/interactive/localmachine/snowflake/clear_existing_images(var/mob/M)

	. = ..()

	if(.)
		if(mob_to_image[M])
			M.client.images -= mob_to_image[M]
			qdel(mob_to_image[M])
			mob_to_image[M] = null


/obj/structure/interactive/localmachine/snowflake/proc/set_icon_state_mob(var/mob/M,var/icon_state)

	clear_existing_images(M)

	var/image/I = image(initial(icon),icon_state = icon_state)
	I.loc = src

	mob_to_image[M] = I
	update_for_mob(M)

	return TRUE

/obj/structure/interactive/localmachine/snowflake/update_for_mob(var/mob/M)

	if(mob_to_image[M])
		M << mob_to_image[M]
		return TRUE

	if(!(cached_image in M.overlays))
		M << cached_image
		return TRUE

	return FALSE