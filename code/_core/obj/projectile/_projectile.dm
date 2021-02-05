/obj/projectile/
	name = "Projectile"

	appearance_flags = LONG_GLIDE | PIXEL_SCALE

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
	var/lifetime = SECONDS_TO_DECISECONDS(10) //Just in case.

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

	var/rotate_projectile = TRUE

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
	SSprojectiles.all_projectiles -= src
	return ..()

/obj/projectile/New(var/loc,var/atom/desired_owner,var/atom/desired_weapon,var/desired_vel_x,var/desired_vel_y,var/desired_shoot_x = 0,var/desired_shoot_y = 0, var/turf/desired_turf, var/desired_damage_type, var/desired_target, var/desired_color, var/desired_blamed, var/desired_damage_multiplier=1,var/desired_iff,var/desired_loyalty,var/desired_inaccuracy_modifier=1)

	if(!desired_owner)
		log_error("WARNING: PROJECTILE [src.get_debug_name()] DID NOT HAVE AN OWNER!")
		qdel(src)
		return FALSE

	owner = desired_owner
	weapon = desired_weapon
	blamed = desired_blamed ? desired_blamed : owner

	target_atom = desired_target
	target_turf = desired_turf

	if(desired_iff) iff_tag = desired_iff
	if(desired_loyalty) loyalty_tag = desired_loyalty
	if(desired_damage_type) damage_type = desired_damage_type

	damage_multiplier = desired_damage_multiplier

	//This is for the target doll.
	shoot_x = desired_shoot_x
	shoot_y = desired_shoot_y

	start_turf = loc //Used for damage falloff calculations.

	vel_x = desired_vel_x
	vel_y = desired_vel_y

	current_loc = loc
	previous_loc = loc

	last_loc_x = x
	last_loc_y = y

	pixel_x_float = pixel_x
	pixel_y_float = pixel_y

	bullet_color = desired_color

	color = bullet_color

	return ..()


/obj/projectile/Initialize()

	//Calculate visual bullet offsets.
	var/normal_x = vel_x
	var/normal_y = vel_y
	var/bullet_offset = FLOOR(TILE_SIZE * 0.5, 1)
	if(vel_x || vel_y)
		normal_x *= 1/max(abs(vel_x),abs(vel_y))
		normal_y *= 1/max(abs(vel_x),abs(vel_y))
	pixel_x = (owner.pixel_x - initial(owner.pixel_x)) + (normal_x * bullet_offset)
	pixel_y = (owner.pixel_y - initial(owner.pixel_y)) + (normal_y * bullet_offset)
	pixel_z = owner.pixel_z - initial(owner.pixel_z)

	return ..()

/obj/projectile/Finalize()

	//Muzzleflash Effect
	if(muzzleflash_effect)
		var/obj/effect/temp/muzzleflash/M = new muzzleflash_effect(src.loc)
		M.pixel_x = pixel_x
		M.pixel_y = pixel_y
		M.pixel_z = pixel_z
		var/new_angle = ATAN2(vel_x,vel_y) - 90
		M.transform = turn(M.transform,-new_angle)
		INITIALIZE(M)
		FINALIZE(M)

	SSprojectiles.all_projectiles += src

	return ..()

/obj/projectile/proc/on_enter_tile(var/turf/old_loc,var/turf/new_loc)

	if(!new_loc)
		damage_atom(src.loc)
		on_hit(src.loc,TRUE)
		log_error("Warning: Projectile didn't have a new loc.")
		return TRUE

	if(!old_loc)
		damage_atom(src.loc)
		on_hit(src.loc,TRUE)
		log_error("Warning: Projectile didn't have an old loc.")
		return TRUE

	if(!isturf(old_loc))
		damage_atom(old_loc)
		on_hit(old_loc,TRUE)
		log_error("Warning: Projectile didn't have a valid old loc.")
		return TRUE

	if(hit_target_turf && new_loc == target_turf)
		damage_atom(new_loc)
		on_hit(new_loc)
		return TRUE

	if(steps_allowed && steps_allowed <= steps_current)
		damage_atom(new_loc)
		on_hit(new_loc,TRUE)
		return TRUE

	var/atom/collide_with_turf = current_loc.projectile_should_collide(src,new_loc,old_loc)
	if(collide_with_turf)
		damage_atom(collide_with_turf)
		on_hit(collide_with_turf)
		return TRUE

	for(var/k in new_loc.contents)
		var/atom/movable/A = k
		if(!A.density)
			continue
		if(check_hit(A,old_loc,new_loc))
			return TRUE

	for(var/k in new_loc.old_living)
		var/mob/living/L = k
		if(!L.density)
			continue
		if(L.dead)
			continue
		if(L.move_delay <= 0)
			continue
		if(check_hit(L,old_loc,new_loc))
			return TRUE

	return FALSE

/obj/projectile/proc/check_hit(var/atom/movable/A,var/atom/old_loc,var/atom/new_loc)
	if(A == owner || A == weapon)
		return FALSE
	var/atom/collide_atom = A.projectile_should_collide(src,new_loc,old_loc)
	if(!collide_atom)
		return FALSE
	if(!damage_atom(collide_atom))
		return FALSE
	return on_hit(collide_atom)

/obj/projectile/proc/update_projectile(var/tick_rate=1)

	if(!isturf(src.loc))
		on_hit(current_loc ? current_loc : src.loc,TRUE)
		return FALSE

	if(!vel_x && !vel_y)
		on_hit(current_loc ? current_loc : src.loc,TRUE)
		return FALSE

	if(lifetime && start_time >= lifetime)
		on_hit(current_loc ? current_loc : src.loc,TRUE)
		return FALSE

	var/current_loc_x = x + FLOOR(((TILE_SIZE/2) + pixel_x_float) / TILE_SIZE, 1) //DON'T REMOVE (TILE_SIZE/2). IT MAKES SENSE.
	var/current_loc_y = y + FLOOR(((TILE_SIZE/2) + pixel_y_float) / TILE_SIZE, 1) //DON'T REMOVE (TILE_SIZE/2). IT MAKES SENSE.
	if((last_loc_x != current_loc_x) || (last_loc_y != current_loc_y))
		current_loc = locate(current_loc_x,current_loc_y,z)
		steps_current += 1
		if(!current_loc)
			return FALSE
		if(on_enter_tile(previous_loc,current_loc))
			return FALSE
		if(!current_loc)
			return FALSE
		previous_loc = current_loc
		last_loc_x = current_loc_x
		last_loc_y = current_loc_y

	if(!start_time)
		var/matrix/M = matrix()
		var/new_angle = -ATAN2(vel_x,vel_y) + 90
		M.Turn(new_angle)
		transform = M

	pixel_x_float += vel_x
	pixel_y_float += vel_y

	animate(src,pixel_x = pixel_x_float,pixel_y = pixel_y_float,time=tick_rate)

	start_time += TICKS_TO_DECISECONDS(tick_rate)

	return TRUE

/obj/projectile/proc/damage_atom(var/atom/hit_atom) //Return true to delete the projectile

	if(damage_type && all_damage_types[damage_type])

		if(!owner || owner.qdeleting)
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

		if(DT.falloff > 0)
			damage_multiplier *= clamp(1 - ((get_dist(hit_atom,start_turf) - DT.falloff)/DT.falloff),0.1,1)

		if(damage_multiplier > 0)
			DT.hit(owner,hit_atom,weapon,object_to_damage,blamed,damage_multiplier)
	else
		log_error("Warning: [damage_type] is an invalid damagetype!.")

	return TRUE

/obj/projectile/proc/on_hit(var/atom/hit_atom)
	post_on_hit(hit_atom)
	qdel(src)
	return TRUE

/obj/projectile/proc/post_on_hit(var/atom/hit_atom)

	if(impact_effect_turf && isturf(hit_atom))
		new impact_effect_turf(get_turf(hit_atom),SECONDS_TO_DECISECONDS(60),rand(-8,8),rand(-8,8),bullet_color)

	else if(impact_effect_movable && ismovable(hit_atom))
		new impact_effect_movable(get_turf(hit_atom),SECONDS_TO_DECISECONDS(5),0,0,bullet_color)

	weapon.on_projectile_hit(src,hit_atom)

	return TRUE

/obj/projectile/get_inaccuracy(var/atom/source,var/atom/target,var/inaccuracy_modifier) //Only applies to melee. For ranged, see projectile.

	. = 0

	if(is_living(source))
		var/mob/living/L = source
		if(istype(weapon,/obj/item/weapon/ranged/))
			var/obj/item/weapon/ranged/R = weapon
			. = R.get_bullet_inaccuracy(L,target,src,inaccuracy_modifier)
		if(L.ai)
			. *= max(1,get_dist(start_turf,target)/VIEW_RANGE)
		if(target_atom)
			. *= max(1,get_dist(target_atom,target)/(VIEW_RANGE*0.5))

	return .