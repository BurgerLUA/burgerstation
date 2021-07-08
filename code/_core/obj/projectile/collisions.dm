/atom/proc/projectile_should_collide(var/obj/projectile/P,var/turf/new_turf,var/turf/old_turf)

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


/obj/structure/interactive/scanner/projectile_should_collide(var/obj/projectile/P,var/turf/new_turf,var/turf/old_turf)

	. = ..()

	if(.)
		return . //Don't run the rest

	for(var/k in P.contents)
		var/atom/movable/M = k
		if(!src.Cross(M,old_turf))
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


/mob/living/projectile_should_collide(var/obj/projectile/P,var/turf/new_turf,var/turf/old_turf)

	if(P && !P.ignore_iff && P.iff_tag && src.iff_tag == P.iff_tag)
		return null

	if(P && !P.ignore_loyalty && P.loyalty_tag && src.loyalty_tag == P.loyalty_tag)
		return null

	if(!P.hit_laying && dead && get_dist(src,P.target_atom) > 0)
		return null

	return ..()

/turf/projectile_should_collide(var/obj/projectile/P,var/turf/new_turf,var/turf/old_turf)

	. = ..()

	if(.)
		if(P.vel_y > 0)
			if(!old_turf.allow_bullet_pass && old_turf.density_north)
				P.penetrations_left = -1
				return list(old_turf)
			if(!new_turf.allow_bullet_pass && new_turf.density_south)
				P.penetrations_left = -1
				return list(new_turf)
		else if(P.vel_y < 0)
			if(!old_turf.allow_bullet_pass && old_turf.density_south)
				P.penetrations_left = -1
				return list(old_turf)
			if(!new_turf.allow_bullet_pass && new_turf.density_north)
				P.penetrations_left = -1
				return list(new_turf)
		if(P.vel_x > 0)
			if(!old_turf.allow_bullet_pass && old_turf.density_east)
				P.penetrations_left = -1
				return list(old_turf)
			if(!new_turf.allow_bullet_pass && new_turf.density_west)
				P.penetrations_left = -1
				return list(new_turf)
		else if(P.vel_x < 0)
			if(!old_turf.allow_bullet_pass && old_turf.density_west)
				P.penetrations_left = -1
				return list(old_turf)
			if(!new_turf.allow_bullet_pass && new_turf.density_east)
				P.penetrations_left = -1
				return list(new_turf)
		P.penetrations_left = -1
		return list(src) //Weird.
	else
		. = list()

	//Take priority of existing targets on a turf before ones that existed before.
	for(var/k in src.contents)
		var/atom/movable/A = k
		if(!A.density)
			continue
		if(A.projectile_should_collide(P,new_turf,old_turf) && P.on_projectile_hit(A))
			. |= A
			P.penetrations_left--
			if(P.penetrations_left < 0)
				return .

	for(var/k in src.old_living)
		var/mob/living/L = k
		if(!L.density)
			continue
		if(L.mouse_opacity <= 0 || L.dead || L.move_delay <= 0 || get_dist(L,src) > 1)
			continue
		if(L.projectile_should_collide(P,new_turf,old_turf))
			. |= L
			P.penetrations_left--
			if(P.penetrations_left < 0)
				return .

	return .

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

