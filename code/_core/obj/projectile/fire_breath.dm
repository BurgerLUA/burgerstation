/obj/projectile/fire_breath
	name = "fire breath"
	icon = null
	icon_state = null

	collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID

	lifetime = 3 SECONDS
	steps_allowed = VIEW_RANGE

	ignore_living = TRUE

/obj/projectile/fire_breath/on_enter_tile(turf/old_loc,turf/new_loc)

	. = ..()

	if(. && old_loc && steps_allowed > 0)
		//Spreads out based on distance.
		firebomb(
			old_loc,
			10 + 40 * (steps_current/steps_allowed),
			owner,
			weapon,
			loyalty_tag
		)


/obj/projectile/fire_breath/on_projectile_hit(atom/hit_atom,turf/old_loc,turf/new_loc)

	. = ..()

	if(. && steps_current < steps_allowed - 1 && steps_allowed > 0)
		firebomb(
			old_loc,
			10 + 40 * ((steps_allowed - steps_current)/steps_allowed),
			owner,
			weapon,
			loyalty_tag
		)
		steps_allowed = 0 //Just in case.
