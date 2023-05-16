/atom/proc/projectile_should_collide(var/obj/projectile/P,var/turf/old_turf,var/turf/new_turf)

	if(P.owner == src && P.target_atom != P.owner)
		return FALSE

	if((collision_bullet_flags & FLAG_COLLISION_BULLET_SPECIFIC) && P.target_atom == src)
		return TRUE

	if(P.collision_flags_special && (P.collision_flags_special & collision_flags))
		return TRUE

	if(!src.collision_bullet_flags || !P.collision_bullet_flags)
		return FALSE

	if(!(P.collision_bullet_flags & src.collision_bullet_flags))
		return FALSE

	return TRUE


/obj/structure/interactive/scanner/projectile_should_collide(var/obj/projectile/P,var/turf/old_turf,var/turf/new_turf)

	. = ..()

	if(.)
		return . //Don't run the rest

	for(var/k in P.contents)
		var/atom/movable/M = k
		if(!src.Cross(M,old_turf))
			return TRUE

	return FALSE

/atom/movable/lighting_overlay/projectile_should_collide(var/obj/projectile/P,var/turf/old_turf,var/turf/new_turf)
	return null

/mob/living/vehicle/projectile_should_collide(var/obj/projectile/P,var/turf/old_turf,var/turf/new_turf)

	if(is_advanced(P.owner))
		var/mob/living/advanced/A = P.owner
		if(A.driving == src)
			return FALSE

	. = ..()

/obj/effect/projectile_should_collide(var/obj/projectile/P,var/turf/old_turf,var/turf/new_turf)
	return FALSE


/mob/living/projectile_should_collide(var/obj/projectile/P,var/turf/old_turf,var/turf/new_turf)

	if(P.ignore_living)
		return FALSE

	if(P.iff_tag && !check_iff_against(P.iff_tag,src,P.hostile))
		return FALSE

	if(P.loyalty_tag && !allow_hostile_action(P.loyalty_tag,src))
		return FALSE

	if(!P.hit_laying && dead && get_dist(src,P.target_turf) > 0)
		return FALSE

	. = ..()

/turf/projectile_should_collide(var/obj/projectile/P,var/turf/old_turf,var/turf/new_turf)

	if(src.allow_bullet_pass)
		return FALSE

	. = ..()

	if(.)
		if(src == old_turf)
			if(P.vel_y > 0 && old_turf.density_north)
				return TRUE
			else if(P.vel_y < 0 && old_turf.density_south)
				return TRUE
			if(P.vel_x > 0 && old_turf.density_east)
				return TRUE
			else if(P.vel_x < 0 && old_turf.density_west)
				return TRUE
		if(src == new_turf)
			if(P.vel_y > 0 && new_turf.density_south)
				return TRUE
			else if(P.vel_y < 0 && new_turf.density_north)
				return TRUE
			if(P.vel_x > 0 && new_turf.density_west)
				return TRUE
			else if(P.vel_x < 0 && new_turf.density_east)
				return TRUE

	return FALSE

/obj/projectile/projectile_should_collide(var/obj/projectile/P,var/turf/old_turf,var/turf/new_turf)
	return FALSE

/obj/structure/projectile_should_collide(var/obj/projectile/P,var/turf/old_turf,var/turf/new_turf)

	if(P.target_atom != src && bullet_block_chance <= 0)
		return FALSE

	. = ..()

	if(!.)
		return FALSE

	var/projectile_dir = turn(get_dir(old_turf,new_turf),180)

	if(!(projectile_dir & src.collision_dir))
		return FALSE

	if(P.target_atom == src) //Bullet block chance doesn't matter if we intentionally target it.
		return TRUE

	if(P.target_atom == src || bullet_block_chance >= 100) //Intentionally placed before distance checking in order to prevent exploits.
		return TRUE

	if(P.start_turf && get_dist(P.start_turf,src) <= 1 )
		return FALSE

	return !luck(P.owner,bullet_block_chance,FALSE)





