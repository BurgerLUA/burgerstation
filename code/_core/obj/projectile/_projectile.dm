/obj/projectile/
	name = "Projectile"

	var/vel_x = 0 //X velocity, in pixels per decisecond
	var/vel_y = 0 //Y velocity in pixels per decisecond

	var/pixel_x_float = 0
	var/pixel_y_float = 0

	var/imaginary_x = 0
	var/imaginary_y = 0

	var/atom/owner //Who is the one who shot the weapon?
	var/atom/weapon //What weapon did the projectile come from?
	var/atom/blamed //Who should we blame for the damage?

	var/atom/previous_loc
	var/atom/current_loc

	var/last_loc_x = 0
	var/last_loc_y = 0

	var/shoot_x = 0
	var/shoot_y = 0

	mouse_opacity = 0

	layer = LAYER_PROJECTILE

	plane = PLANE_EFFECT

	var/start_time = 0
	var/lifetime = SECONDS_TO_DECISECONDS(60) //Just in case.

	var/turf/target_turf
	var/atom/target_atom

	var/hit_target_turf = FALSE

	collision_flags = FLAG_COLLISION_NONE
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

	var/obj/effect/temp/impact/impact_effect_turf
	var/obj/effect/temp/impact/impact_effect_movable

	var/bullet_color = "#FFFFFF"

	var/steps_current = 0
	var/steps_allowed = 0

	var/damage_multiplier = 1

	var/obj/effect/temp/muzzleflash/muzzleflash_effect

/obj/projectile/destroy()
	owner = null
	weapon = null
	blamed = null
	target_atom = null
	target_turf = null
	previous_loc = null
	current_loc = null

	all_projectiles -= src
	return ..()

/obj/projectile/New(var/loc,var/atom/desired_owner,var/atom/desired_weapon,var/desired_vel_x,var/desired_vel_y,var/desired_shoot_x = 0,var/desired_shoot_y = 0, var/turf/desired_turf, var/desired_damage_type, var/desired_target, var/desired_color, var/desired_blamed, var/desired_damage_multiplier=1)

	owner = desired_owner
	weapon = desired_weapon
	if(desired_damage_type)
		damage_type = desired_damage_type

	vel_x = desired_vel_x
	vel_y = desired_vel_y

	imaginary_x = x
	imaginary_y = y

	all_projectiles += src

	previous_loc = loc

	last_loc_x = x
	last_loc_y = y

	var/normal_x = desired_vel_x
	var/normal_y = desired_vel_y

	if(vel_x || vel_y)
		normal_x *= 1/max(abs(vel_x),abs(vel_y))
		normal_y *= 1/max(abs(vel_x),abs(vel_y))

	var/bullet_offset = floor(TILE_SIZE*0.5)

	if(muzzleflash_effect)
		var/obj/effect/temp/muzzleflash/M = new muzzleflash_effect(src.loc)
		M.pixel_x = normal_x * bullet_offset
		M.pixel_y = normal_y * bullet_offset
		var/new_angle = arctan(vel_x,vel_y) - 90
		M.transform = turn(M.transform,-new_angle)

	pixel_x = normal_x * bullet_offset
	pixel_y = normal_y * bullet_offset

	pixel_x_float = normal_x * bullet_offset
	pixel_y_float = normal_y * bullet_offset

	shoot_x = desired_shoot_x
	shoot_y = desired_shoot_y

	target_atom = desired_target

	target_turf = desired_turf

	bullet_color = desired_color

	if(desired_blamed)
		blamed = desired_blamed
	else
		blamed = owner

	damage_multiplier = desired_damage_multiplier

	. = ..()

	update_icon()

	return .

/obj/projectile/update_icon()
	var/icon/I = icon(icon,icon_state = icon_state)
	var/new_angle = arctan(vel_x,vel_y) - 90
	I.Turn(-new_angle)
	icon = I

/obj/projectile/proc/update_projectile()

	steps_current += 1

	start_time += TICKS_TO_DECISECONDS(PROJECTILE_TICK)

	if(steps_allowed && steps_allowed <= steps_current && current_loc)
		on_hit(current_loc)
		return FALSE

	if(lifetime <= start_time && current_loc)
		on_hit(current_loc)
		return FALSE

	var/current_loc_x = x + floor( ((TILE_SIZE/2) + pixel_x_float) / TILE_SIZE)
	var/current_loc_y = y + floor( ((TILE_SIZE/2) + pixel_y_float) / TILE_SIZE)

	if( (last_loc_x != current_loc_x) || (last_loc_y != current_loc_y))

		for(var/mob/MO in contents)
			if(MO.client)
				animate(MO.client,pixel_x = pixel_x_float, pixel_y = pixel_y_float, time = TICKS_TO_DECISECONDS(PROJECTILE_TICK))

		current_loc = locate(current_loc_x,current_loc_y,z)
		if(!is_turf(previous_loc))
			on_hit(previous_loc)
			return

		if(!is_turf(src.loc))
			on_hit(src.loc)
			return

		var/turf/new_turf = current_loc
		var/turf/old_turf = previous_loc

		if(!previous_loc || !current_loc)
			on_hit(src)
			return

		if(do_turf_collide(old_turf,new_turf))
			return

	if(current_loc)
		previous_loc = current_loc

	var/matrix/M = matrix()
	M.Translate(pixel_x_float,pixel_y_float)
	animate(src, transform = M, time = TICKS_TO_DECISECONDS(PROJECTILE_TICK))

	pixel_x_float += vel_x
	pixel_y_float += vel_y

/obj/projectile/proc/do_turf_collide(var/turf/old_turf,var/turf/new_turf)

	//new /obj/effect/temp/tile(new_turf,20) DEBUG

	var/atom/collide_with_turf = new_turf.projectile_should_collide(src,new_turf,old_turf)

	if(collide_with_turf)
		on_hit(collide_with_turf)
		return TRUE

	for(var/atom/A in new_turf.contents)
		var/atom/collide_with_atom = A.projectile_should_collide(src,new_turf,old_turf)
		if(!collide_with_atom)
			continue

		if(hit_atom(A))
			on_hit(A)
			return TRUE

	if(hit_target_turf && new_turf == target_turf)
		on_hit(current_loc)
		return TRUE

	return FALSE

/obj/projectile/proc/hit_atom(var/atom/hit_atom) //Return true to delete the projectile

	if(!hit_atom.can_be_attacked(owner))
		return FALSE

	if(hit_atom != target_atom && is_living(hit_atom))
		var/mob/living/L = hit_atom
		if(L.status & FLAG_STATUS_DEAD || L.status & FLAG_STATUS_STUN)
			return FALSE

	if(damage_type && all_damage_types[damage_type])
		if(owner && !owner.qdeleting)
			var/damagetype/DT = all_damage_types[damage_type]

			var/list/params = list()
			params[PARAM_ICON_X] = shoot_x
			params[PARAM_ICON_Y] = shoot_y

			var/atom/object_to_damage = hit_atom.get_object_to_damage(owner,params)
			if(hit_atom.perform_block(owner,weapon,object_to_damage,DT)) return TRUE
			if(hit_atom.perform_dodge(owner,weapon,object_to_damage,DT)) return FALSE
			if(DT.perform_miss(owner,weapon,object_to_damage)) return FALSE

			DT.do_damage(owner,hit_atom,weapon,object_to_damage,blamed,damage_multiplier)
	else
		LOG_ERROR("Warning: [damage_type] is an invalid damagetype!.")

	return TRUE

/atom/proc/projectile_should_collide(var/obj/projectile/P,var/turf/new_turf,var/turf/old_turf)

	if(P == src)
		return FALSE

	if(P.owner == src)
		return FALSE

	if(!(P.collision_bullet_flags & src.collision_bullet_flags))
		return FALSE

	return src


/mob/living/advanced/npc/projectile_should_collide(var/obj/projectile/P,var/turf/new_turf,var/turf/old_turf)

	var/area/A = get_area(new_turf)

	if(A && A.safe && dialogue_id && P && P.owner && is_player(P.owner))
		return FALSE

	return ..()

/mob/living/advanced/player/projectile_should_collide(var/obj/projectile/P,var/turf/new_turf,var/turf/old_turf)

	var/area/A = get_area(new_turf)

	if(A && A.safe) //Honestly it's a bad idea to have projectiles in safezones. Players can bait NPCs into shooting stray bullets into people who are AFK/Busy.
		return FALSE

	return ..()

/turf/projectile_should_collide(var/obj/projectile/P,var/turf/new_turf,var/turf/old_turf)

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

/obj/projectile/proc/on_hit(var/atom/hit_atom)
	all_projectiles -= src
	post_on_hit(hit_atom)
	qdel(src)
	return TRUE

/obj/projectile/proc/post_on_hit(var/atom/hit_atom)

	for(var/mob/MO in contents)
		if(MO.client)
			MO.client.pixel_x = vel_x
			MO.client.pixel_y = vel_y
			animate(MO.client,pixel_x = 0, pixel_y = 0, time = SECONDS_TO_DECISECONDS(2))

	if(impact_effect_turf && is_turf(hit_atom))
		new impact_effect_turf(get_turf(hit_atom),SECONDS_TO_DECISECONDS(60),rand(-8,8),rand(-8,8),bullet_color)

	else if(impact_effect_movable && is_movable(hit_atom))
		new impact_effect_movable(get_turf(hit_atom),SECONDS_TO_DECISECONDS(5),0,0,bullet_color)

	return TRUE