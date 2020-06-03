/atom/proc/projectile_should_collide(var/obj/projectile/P,var/turf/new_turf,var/turf/old_turf)

	if(P == src)
		return FALSE

	if(P.owner == src)
		return FALSE

	if( (collision_bullet_flags & FLAG_COLLISION_SPECIFIC) && P.target_atom == src)
		return src

	if(P.collision_flags_special && P.collision_flags_special & collision_flags)
		return src

	if(!src.collision_bullet_flags || !P.collision_bullet_flags)
		return FALSE

	if(!(P.collision_bullet_flags & src.collision_bullet_flags))
		return FALSE

	return src

/atom/movable/lighting_overlay/projectile_should_collide(var/obj/projectile/P,var/turf/new_turf,var/turf/old_turf)
	return FALSE

/mob/living/advanced/npc/projectile_should_collide(var/obj/projectile/P,var/turf/new_turf,var/turf/old_turf)

	if(dialogue_id)
		return FALSE

	return ..()

/mob/living/advanced/player/projectile_should_collide(var/obj/projectile/P,var/turf/new_turf,var/turf/old_turf)

	if(P && !P.ignore_iff && is_living(P.owner)) //FAILSAFE. PUSSY SHIT BUT IT SHOULD PREVENT EXPLOITS.
		var/mob/living/L = P.owner
		if(L.loyalty_tag == src.loyalty_tag)
			return FALSE

	return ..()

/mob/living/projectile_should_collide(var/obj/projectile/P,var/turf/new_turf,var/turf/old_turf)

	if(src != P.target_atom && (dead || horizontal))
		return FALSE

	if(P && !P.ignore_iff && P.iff_tag && src.iff_tag == P.iff_tag)
		return FALSE

	return ..()

/turf/projectile_should_collide(var/obj/projectile/P,var/turf/new_turf,var/turf/old_turf)

	. = ..()

	if(!.)
		return FALSE

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

	return FALSE

/obj/projectile/projectile_should_collide(var/obj/projectile/P,var/turf/new_turf,var/turf/old_turf)
	return FALSE

/obj/structure/projectile_should_collide(var/obj/projectile/P,var/turf/new_turf,var/turf/old_turf)

	var/projectile_dir = get_dir(old_turf,new_turf)

	if(!..()) //REMEMBER, THIS NEEDS TO BE HERE.
		return FALSE

	if(projectile_dir & src.collision_dir && (bullet_block_chance == 100 || luck(src,bullet_block_chance)))
		. = src

	if(P.start_turf && get_dist(P.start_turf,src) <= 1 )
		return FALSE

	return .