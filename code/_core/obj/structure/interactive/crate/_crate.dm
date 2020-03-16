/obj/structure/interactive/crate
	name = "crate"
	desc = "Shove things inside."
	icon = 'icons/obj/structure/crates.dmi'
	icon_state = "crate"

	anchored = FALSE
	collision_flags = FLAG_COLLISION_REAL

	var/list/crate_contents = list()

	var/open = FALSE

/obj/structure/interactive/crate/Cross(var/atom/movable/O)

	if(istype(O,/obj/structure/interactive/crate))
		return FALSE

	if(open)
		return TRUE

	if(!(O.collision_flags && FLAG_COLLISION_ETHEREAL))
		return TRUE

	return ..()


/obj/structure/interactive/crate/Uncross(var/atom/movable/O)

	if(open)
		return TRUE

	return ..()

/obj/structure/interactive/crate/update_icon()
	icon_state = initial(icon_state)
	if(open)
		icon_state = "[icon_state]_open"

	return ..()

/obj/structure/interactive/crate/clicked_on_by_object(var/mob/caller,object,location,control,params)
	INTERACT_CHECK
	toggle(caller)
	return ..()

/obj/structure/interactive/crate/Initialize()

	if(!open)
		for(var/atom/movable/M in loc.contents)
			if(M == src || M.anchored)
				continue
			M.force_move(src)
			M.pixel_x = initial(M.pixel_x)
			M.pixel_y = initial(M.pixel_y)
			crate_contents += M

	update_icon()

	return ..()

/obj/structure/interactive/crate/proc/toggle(var/mob/caller)
	return open ? close(caller) : open(caller)

/obj/structure/interactive/crate/proc/close(var/mob/caller)

	for(var/atom/movable/M in loc.contents)
		if(M == src || M.anchored)
			continue
		M.force_move(src)
		M.pixel_x = 0
		M.pixel_y = 0
		crate_contents += M

	open = FALSE

	update_icon()

	return TRUE

/obj/structure/interactive/crate/proc/open(var/mob/caller)

	for(var/atom/movable/M in crate_contents)
		crate_contents -= M
		M.force_move(src.loc)
		//animate(M,pixel_x = initial(M.pixel_x) + rand(-16,16),pixel_y = initial(M.pixel_y) + rand(-16,16),time = 4)

	open = TRUE

	update_icon()

	return TRUE