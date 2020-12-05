/atom/proc/projectile_should_collide(var/obj/projectile/P,var/turf/new_turf,var/turf/old_turf)

	if(P == src)
		return null

	if(P.owner == src)
		return null

	if( (collision_bullet_flags & FLAG_COLLISION_SPECIFIC) && P.target_atom == src)
		return src

	if(P.collision_flags_special && P.collision_flags_special & collision_flags)
		return src

	if(!src.collision_bullet_flags || !P.collision_bullet_flags)
		return null

	if(!(P.collision_bullet_flags & src.collision_bullet_flags))
		return null

	return src

/atom/movable/lighting_overlay/projectile_should_collide(var/obj/projectile/P,var/turf/new_turf,var/turf/old_turf)
	return null

/mob/living/vehicle/projectile_should_collide(var/obj/projectile/P,var/turf/new_turf,var/turf/old_turf)

	if(is_advanced(P.owner))
		var/mob/living/advanced/A = P.owner
		if(A.driving == src)
			return null

	return ..()

/obj/effect/projectile_should_collide(var/obj/projectile/P,var/turf/new_turf,var/turf/old_turf)
	return null


/*
/mob/living/advanced/player/projectile_should_collide(var/obj/projectile/P,var/turf/new_turf,var/turf/old_turf)

	if(P && !P.ignore_iff && is_living(P.owner)) //FAILSAFE. PUSSY SHIT BUT IT SHOULD PREVENT EXPLOITS.
		var/mob/living/L = P.owner
		if(L.loyalty_tag == src.loyalty_tag)
			return null

	return ..()
*/

/mob/living/projectile_should_collide(var/obj/projectile/P,var/turf/new_turf,var/turf/old_turf)

	if(!P.hit_laying)
		if(dead && P.target_atom != src)
			return null

	if(P && !P.ignore_iff && P.iff_tag && src.iff_tag == P.iff_tag)
		return null

	if(P && !P.ignore_loyalty && P.loyalty_tag && src.loyalty_tag == P.loyalty_tag)
		return null

	return ..()

/turf/projectile_should_collide(var/obj/projectile/P,var/turf/new_turf,var/turf/old_turf)

	for(var/k in P.contents)
		var/atom/movable/M = k
		if(!src.Enter(M))
			return src

	. = ..()

	if(!.)
		return null

	if(P.vel_y > 0)
		if(!old_turf.allow_bullet_pass && old_turf.density_north)
			return old_turf
		if(!new_turf.allow_bullet_pass && new_turf.density_south)
			return new_turf
	else if(P.vel_y < 0)
		if(!old_turf.allow_bullet_pass && old_turf.density_south)
			return old_turf
		if(!new_turf.allow_bullet_pass && new_turf.density_north)
			return new_turf
	if(P.vel_x > 0)
		if(!old_turf.allow_bullet_pass && old_turf.density_east)
			return old_turf
		if(!new_turf.allow_bullet_pass && new_turf.density_west)
			return new_turf
	else if(P.vel_x < 0)
		if(!old_turf.allow_bullet_pass && old_turf.density_west)
			return old_turf
		if(!new_turf.allow_bullet_pass && new_turf.density_east)
			return new_turf

	return null

/obj/projectile/projectile_should_collide(var/obj/projectile/P,var/turf/new_turf,var/turf/old_turf)
	return null

/obj/structure/projectile_should_collide(var/obj/projectile/P,var/turf/new_turf,var/turf/old_turf)

	. = ..()

	if(!.)
		return null

	var/projectile_dir = get_dir(old_turf,new_turf)

	if(projectile_dir & src.collision_dir)
		if(bullet_block_chance >= 100)
			return src
		else if(P.start_turf && get_dist(P.start_turf,src) <= 1 )
			return null
		else if(luck(P.owner,bullet_block_chance,FALSE))
			return null

	return .