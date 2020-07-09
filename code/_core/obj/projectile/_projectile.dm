/obj/projectile/
	name = "Projectile"

	var/vel_x = 0 //X velocity, in pixels per decisecond
	var/vel_y = 0 //Y velocity in pixels per decisecond

	var/pixel_x_float = 0
	var/pixel_y_float = 0

	var/atom/owner //Who is the one who shot the weapon?
	var/atom/weapon //What weapon did the projectile come from?
	var/atom/blamed //Who should we blame for the damage?

	var/atom/previous_loc
	var/atom/current_loc

	var/last_loc_x = 0
	var/last_loc_y = 0

	var/shoot_x = 0
	var/shoot_y = 0

	var/inaccuracy_modifier = 1

	mouse_opacity = 0

	layer = LAYER_PROJECTILE

	plane = PLANE_EFFECT

	var/start_time = 0
	var/lifetime = SECONDS_TO_DECISECONDS(60) //Just in case.

	var/turf/start_turf
	var/turf/target_turf
	var/atom/target_atom

	var/hit_target_turf = FALSE
	var/hit_laying = FALSE

	collision_flags = FLAG_COLLISION_NONE
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE
	var/collision_flags_special = FLAG_COLLISION_NONE //If the projectile is actually a throw item.

	var/obj/effect/temp/impact/impact_effect_turf
	var/obj/effect/temp/impact/impact_effect_movable

	var/bullet_color = "#FFFFFF"

	var/steps_current = 0
	var/steps_allowed = 0

	var/damage_multiplier = 1

	var/obj/effect/temp/muzzleflash/muzzleflash_effect

	var/iff_tag
	var/ignore_iff = FALSE //Set to true if you want it to ignore IFF collision checking.

	var/loyalty_tag
	var/ignore_loyalty = TRUE //SEt to true if you want to ignore loyalty tag collision checking.

	anchored = TRUE

/obj/projectile/Destroy()
	owner = null
	weapon = null
	blamed = null
	target_atom = null
	target_turf = null
	start_turf = null
	previous_loc = null
	current_loc = null

	all_projectiles -= src
	return ..()

/obj/projectile/New(var/loc,var/atom/desired_owner,var/atom/desired_weapon,var/desired_vel_x,var/desired_vel_y,var/desired_shoot_x = 0,var/desired_shoot_y = 0, var/turf/desired_turf, var/desired_damage_type, var/desired_target, var/desired_color, var/desired_blamed, var/desired_damage_multiplier=1,var/desired_iff,var/desired_loyalty,var/desired_inaccuracy_modifier=1)

	owner = desired_owner
	weapon = desired_weapon
	start_turf = loc
	if(desired_damage_type)
		damage_type = desired_damage_type

	vel_x = desired_vel_x
	vel_y = desired_vel_y

	all_projectiles += src

	current_loc = loc
	previous_loc = loc

	last_loc_x = x
	last_loc_y = y

	var/normal_x = desired_vel_x
	var/normal_y = desired_vel_y

	if(vel_x || vel_y)
		normal_x *= 1/max(abs(vel_x),abs(vel_y))
		normal_y *= 1/max(abs(vel_x),abs(vel_y))

	var/bullet_offset = FLOOR(TILE_SIZE * 0.5, 1)

	pixel_x = (desired_owner.pixel_x - initial(desired_owner.pixel_x)) + (normal_x * bullet_offset)
	pixel_y = (desired_owner.pixel_y - initial(desired_owner.pixel_y)) + (normal_y * bullet_offset)
	pixel_z = desired_owner.pixel_z - initial(desired_owner.pixel_z)

	if(muzzleflash_effect)
		var/obj/effect/temp/muzzleflash/M = new muzzleflash_effect(src.loc)
		M.pixel_x = pixel_x
		M.pixel_y = pixel_y
		M.pixel_z = pixel_z
		var/new_angle = ATAN2(vel_x,vel_y) - 90
		M.transform = turn(M.transform,-new_angle)
		if(desired_color)
			M.color = desired_color
		INITIALIZE(M)

	pixel_x_float = pixel_x
	pixel_y_float = pixel_y

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

	if(desired_iff)
		iff_tag = desired_iff

	if(desired_loyalty)
		loyalty_tag = desired_loyalty

	. = ..()

	update_sprite()

	return .

/obj/projectile/proc/on_enter_tile(var/turf/old_loc,var/turf/new_loc)

	if(!new_loc || !old_loc)
		damage_atom(src.loc)
		on_hit(src.loc,TRUE)
		return TRUE

	if(hit_target_turf && new_loc == target_turf)
		damage_atom(new_loc)
		on_hit(new_loc)
		return TRUE

	if(steps_allowed && steps_allowed <= steps_current)
		damage_atom(new_loc)
		on_hit(new_loc,TRUE)
		return TRUE

	if(lifetime <= start_time)
		damage_atom(new_loc)
		on_hit(new_loc,TRUE)
		return TRUE

	if(!isturf(old_loc))
		damage_atom(old_loc)
		on_hit(old_loc,TRUE)
		return TRUE

	var/atom/collide_with_turf = current_loc.projectile_should_collide(src,new_loc,old_loc)
	if(collide_with_turf)
		damage_atom(collide_with_turf)
		on_hit(collide_with_turf)
		return TRUE

	for(var/atom/movable/A in new_loc.contents)
		if(A == owner || A == weapon)
			continue
		var/atom/collide_atom = A.projectile_should_collide(src,new_loc,old_loc)
		if(!collide_atom)
			continue
		if(!damage_atom(collide_atom))
			continue
		on_hit(collide_atom)
		return TRUE

	for(var/mob/living/L in new_loc.old_living)
		if(L.dead)
			continue
		if(L.move_delay > 0)
			continue
		if(L == owner || L == weapon)
			continue
		var/atom/collide_atom = L.projectile_should_collide(src,new_loc,old_loc)
		if(!collide_atom)
			continue
		if(!damage_atom(collide_atom))
			continue
		on_hit(collide_atom)
		return TRUE

	return FALSE

/obj/projectile/proc/update_projectile()

	if(!isturf(src.loc))
		on_hit(src.loc,TRUE)
		return FALSE

	var/current_loc_x = x + FLOOR(((TILE_SIZE/2) + pixel_x_float) / TILE_SIZE, 1)
	var/current_loc_y = y + FLOOR(((TILE_SIZE/2) + pixel_y_float) / TILE_SIZE, 1)

	var/matrix/M = matrix()
	var/new_angle = -ATAN2(vel_x,vel_y) + 90
	M.Turn(new_angle)
	M.Translate(pixel_x_float,pixel_y_float)
	if(!start_time)
		transform = M
	else
		animate(src, transform = M, time = TICKS_TO_DECISECONDS(PROJECTILE_TICK))

	start_time += TICKS_TO_DECISECONDS(PROJECTILE_TICK)

	if((last_loc_x != current_loc_x) || (last_loc_y != current_loc_y))
		current_loc = locate(current_loc_x,current_loc_y,z)
		steps_current += 1
		if(on_enter_tile(previous_loc,current_loc))
			return FALSE
		if(current_loc)
			previous_loc = current_loc

	pixel_x_float += vel_x
	pixel_y_float += vel_y

	for(var/mob/MO in contents)
		if(!MO.client)
			continue
		animate(MO.client,pixel_x = pixel_x_float, pixel_y = pixel_y_float, time = TICKS_TO_DECISECONDS(PROJECTILE_TICK))

	last_loc_x = current_loc_x
	last_loc_y = current_loc_y

	return TRUE

/obj/projectile/proc/damage_atom(var/atom/hit_atom) //Return true to delete the projectile

	if(damage_type && all_damage_types[damage_type])

		if(!owner && !owner.qdeleting)
			return TRUE

		var/damagetype/DT = all_damage_types[damage_type]

		if(!hit_atom.can_be_attacked(owner,weapon,null,DT))
			return TRUE

		var/list/params = list()
		params[PARAM_ICON_X] = shoot_x
		params[PARAM_ICON_Y] = shoot_y

		var/precise = FALSE
		if(is_living(hit_atom))
			var/mob/living/L = hit_atom
			if(L.ai && L.ai.alert_level <= ALERT_LEVEL_NOISE)
				precise = TRUE

		var/atom/object_to_damage = hit_atom.get_object_to_damage(owner,src,params,precise,precise,inaccuracy_modifier)

		if(!object_to_damage)
			DT.perform_miss(owner,hit_atom,weapon)
			return FALSE

		if(DT.allow_dodge)
			var/dodging_return = can_dodge(owner,weapon,object_to_damage,DT)
			if(dodging_return && hit_atom.perform_dodge(owner,weapon,object_to_damage,DT)) return FALSE

		if(DT.allow_parry)
			var/atom/parrying_atom = hit_atom.can_parry(owner,weapon,object_to_damage,DT)
			if(parrying_atom && hit_atom.perform_parry(owner,weapon,object_to_damage,DT,parrying_atom)) return TRUE

		if(DT.allow_block)
			var/atom/blocking_atom = hit_atom.can_block(owner,weapon,object_to_damage,DT)
			if(blocking_atom && hit_atom.perform_block(owner,weapon,object_to_damage,DT,blocking_atom))
				damage_multiplier *= 0.75
				damage_multiplier *= 1 - clamp(blocking_atom.get_block_power(hit_atom,owner,weapon,object_to_damage,DT) - DT.get_block_power_penetration(owner,hit_atom,weapon,object_to_damage,blocking_atom),0,1)

		if(DT.falloff > 0)
			damage_multiplier *= clamp(1 - ((get_dist(hit_atom,start_turf) - DT.falloff)/DT.falloff),0.1,1)

		if(damage_multiplier > 0)
			DT.do_damage(owner,hit_atom,weapon,object_to_damage,blamed,damage_multiplier)
	else
		log_error("Warning: [damage_type] is an invalid damagetype!.")

	return TRUE

/obj/projectile/proc/on_hit(var/atom/hit_atom)
	all_projectiles -= src
	post_on_hit(hit_atom)
	qdel(src)
	return TRUE

/obj/projectile/proc/post_on_hit(var/atom/hit_atom)

	/*
	for(var/mob/MO in contents)
		if(MO.client)
			MO.client.pixel_x = vel_x
			MO.client.pixel_y = vel_y
			animate(MO.client,pixel_x = 0, pixel_y = 0, time = SECONDS_TO_DECISECONDS(2))
	*/

	if(impact_effect_turf && isturf(hit_atom))
		new impact_effect_turf(get_turf(hit_atom),SECONDS_TO_DECISECONDS(60),rand(-8,8),rand(-8,8),bullet_color)

	else if(impact_effect_movable && ismovable(hit_atom))
		new impact_effect_movable(get_turf(hit_atom),SECONDS_TO_DECISECONDS(5),0,0,bullet_color)

	return TRUE

/obj/projectile/get_inaccuracy(var/atom/source,var/atom/target,var/inaccuracy_modifier) //Only applies to melee. For ranged, see projectile.

	if(istype(weapon,/obj/item/weapon/ranged/) && is_living(source))
		var/obj/item/weapon/ranged/R = weapon
		return R.get_bullet_inaccuracy(source,target,src,inaccuracy_modifier)

	return 0