/obj/structure/
	name = "structure"
	desc = "Some kind of strange structure."
	collision_flags = FLAG_COLLISION_NONE
	collision_bullet_flags = FLAG_COLLISION_NONE
	anchored = 1

	var/density_north = TRUE
	var/density_south = TRUE
	var/density_east  = TRUE
	var/density_west  = TRUE

	var/bullet_block_chance = 100 //Chance to block bullets, assuming that the object is solid.

	var/mob/living/buckled

/obj/structure/New(var/desired_loc)

	. = ..()

	if(desired_light_range && desired_light_power && desired_light_color)
		set_light(desired_light_range,desired_light_power,desired_light_color)

	return .

/obj/structure/proc/on_active(var/mob/living/advanced/player/P)
	return TRUE

/obj/structure/proc/on_inactive(var/mob/living/advanced/player/P)
	return TRUE

/obj/structure/proc/buckle(var/mob/living/victim,var/mob/caller,var/silent = FALSE)

	if(!silent)
		if(!caller || caller == victim)
			victim.visible_message("\The [caller.name] buckles themselves to \the [src.name].")
		else
			victim.visible_message("\The [caller.name] buckles \the [victim.name] into \the [src.name].")

	buckled = victim
	buckled.buckled_object = src

	return TRUE

/obj/structure/proc/unbuckle(var/mob/caller,var/silent=FALSE)

	if(!buckled)
		return FALSE

	if(!silent)
		if(!caller || caller == buckled)
			buckled.visible_message("\The [buckled.name] unbuckles themselves from \the [src.name].")
		else
			buckled.visible_message("\The [buckled.name] is unbuckled from \the [src.name] by \the [caller.name].")

	buckled.buckled_object = null
	buckled = null

	return TRUE


/obj/structure/Cross(var/atom/movable/O,var/atom/NewLoc,var/atom/OldLoc)

	if(O.collision_flags & src.collision_flags)

		var/direction = get_dir(OldLoc,NewLoc)

		if((direction & NORTH) && density_south)
			return FALSE

		if((direction & SOUTH) && density_north)
			return FALSE

		if((direction & EAST) && density_west)
			return FALSE

		if((direction & WEST) && density_east)
			return FALSE

		if(is_structure(O)) //Prevents infinite loops.
			var/obj/structure/S = O
			if(density_north && S.density_north)
				return FALSE
			if(density_south && S.density_south)
				return FALSE
			if(density_east && S.density_east)
				return FALSE
			if(density_west && S.density_west)
				return FALSE


	return TRUE

/obj/structure/Uncross(var/atom/movable/O,var/atom/NewLoc,var/atom/OldLoc)

	if(O.collision_flags & src.collision_flags)

		var/direction = get_dir(OldLoc,NewLoc)

		if((direction & NORTH) && density_north)
			return FALSE

		if((direction & SOUTH) && density_south)
			return FALSE

		if((direction & EAST) && density_east)
			return FALSE

		if((direction & WEST) && density_west)
			return FALSE

	return TRUE