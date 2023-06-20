/obj/projectile/
	name = "Projectile"
	plane = PLANE_PROJECTILE
	layer = LAYER_PROJECTILE

	damage_type = null //Default is /damagetype/error. Sometimes projectiles don't need to do damage.

	appearance_flags = LONG_GLIDE | PIXEL_SCALE

	var/vel_x = 0 //X velocity, in pixels per decisecond
	var/vel_y = 0 //Y velocity in pixels per decisecond

	//Cosmsetic
	var/pixel_x_float_visual = 0
	var/pixel_y_float_visual = 0

	//Actual
	var/pixel_x_float_physical = 0
	var/pixel_y_float_physical = 0

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

	var/intercaridnal_fix_switch = TRUE

	var/start_time = 0
	var/lifetime = SECONDS_TO_DECISECONDS(10) //Just in case.

	var/turf/start_turf
	var/turf/target_turf
	var/atom/target_atom

	var/hit_target_turf = FALSE //The target atom can still be hit when false. Setting to true just gives priority.
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
	var/loyalty_tag

	var/hostile = TRUE //Set to true if this is a hostile projectile. Set to false if it isn't.

	anchored = TRUE

	var/penetrations_left = 0 //Uwu
	var/list/projectile_blacklist = list()

	throwable = FALSE

	var/ricochets_left = 3 //Amount of richochets this projectile is allowed to have. 0 to disable.
	var/ricochet_angle = 55 //The angle of incidence needs to be larger than this to trigger a richochete.
	//Generally a number between 0 and 90, with 0 being a direct impact and 90 being an impossible to obtain parallel line. (Lower means can bounce more often).
	//Ideal value is something between 55 and 60. This value is doubled when considering shields.
	var/richochet_block_percent_threshold = 0.25 //Percentage of damage blocked required to start a richochet. Note that armor deflection multiplies the block percentage checked.

	var/debug = FALSE

	var/rotate_projectile = TRUE

	var/ignore_living = FALSE //Ignore collisions with living beings.

/obj/projectile/PreDestroy()
	SSprojectiles.all_projectiles -= src
	. = ..()

/obj/projectile/Destroy()
	color = "#000000"
	owner = null
	weapon = null
	blamed = null
	target_atom = null
	target_turf = null
	start_turf = null
	previous_loc = null
	current_loc = null
	projectile_blacklist?.Cut()
	. = ..()

/obj/projectile/New(var/desired_loc,var/atom/desired_owner,var/atom/desired_weapon,var/desired_vel_x,var/desired_vel_y,var/desired_shoot_x = 0,var/desired_shoot_y = 0, var/turf/desired_turf, var/desired_damage_type, var/desired_target, var/desired_color, var/desired_blamed, var/desired_damage_multiplier=1,var/desired_iff_tag,var/desired_loyalty_tag,var/desired_inaccuracy_modifier=1,var/desired_penetrations_left=0)

	if(!desired_owner)
		log_error("WARNING: PROJECTILE [src.get_debug_name()] DID NOT HAVE AN OWNER!")
		qdel(src)
		return FALSE

	intercaridnal_fix_switch = prob(50)

	owner = desired_owner
	weapon = desired_weapon
	blamed = desired_blamed ? desired_blamed : owner

	target_atom = desired_target
	target_turf = desired_turf

	if(desired_iff_tag) iff_tag = desired_iff_tag
	if(desired_loyalty_tag) loyalty_tag = desired_loyalty_tag
	if(desired_damage_type) damage_type = desired_damage_type
	if(desired_penetrations_left) penetrations_left = desired_penetrations_left

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

	bullet_color = desired_color

	color = bullet_color

	inaccuracy_modifier = desired_inaccuracy_modifier

	. = ..()


/obj/projectile/Initialize()

	//Calculate visual bullet offsets.
	var/normal_x = vel_x
	var/normal_y = vel_y
	var/bullet_offset = TILE_SIZE * 0.25 //Cannot be greater or equal to TILE_SIZE*0.5
	var/muzzle_offset = TILE_SIZE
	if(vel_x || vel_y)
		var/norm = max(abs(vel_x),abs(vel_y))
		normal_x *= 1/norm
		normal_y *= 1/norm
		if(muzzleflash_effect)
			var/obj/effect/temp/muzzleflash/M = new muzzleflash_effect(src.loc)
			M.pixel_x = pixel_x + muzzle_offset*normal_x
			M.pixel_y = pixel_y + muzzle_offset*normal_y
			M.pixel_z = pixel_z
			var/new_angle = ATAN2(vel_x,vel_y) - 90
			M.transform = turn(M.transform,-new_angle)
			INITIALIZE(M)
			FINALIZE(M)

	var/desired_pixel_x = (owner.pixel_x - initial(owner.pixel_x)) + (normal_x * bullet_offset)
	var/desired_pixel_y = (owner.pixel_y - initial(owner.pixel_y)) + (normal_y * bullet_offset)
	var/desired_pixel_z = owner.pixel_z - initial(owner.pixel_z)
	pixel_x = FLOOR(desired_pixel_x,1)
	pixel_y = FLOOR(desired_pixel_y,1)
	pixel_z = FLOOR(desired_pixel_z,1)
	pixel_x_float_visual = pixel_x
	pixel_y_float_visual = pixel_y
	pixel_x_float_physical = pixel_x
	pixel_y_float_physical = pixel_y

	. = ..()

/obj/projectile/Finalize()
	. = ..()
	SSprojectiles.all_projectiles += src

/obj/projectile/proc/on_enter_tile(var/turf/old_loc,var/turf/new_loc)

	if(!new_loc)
		log_error("Warning: [src.get_debug_name()] didn't have a new loc!")
		on_projectile_hit(src.loc)
		return FALSE

	if(!old_loc)
		log_error("Warning: [src.get_debug_name()] didn't have an old loc!")
		on_projectile_hit(src.loc)
		return FALSE

	if(debug)
		var/obj/effect/temp/tile/TE = new(new_loc)
		TE.maptext = "[steps_current]"
		TE.alpha = 200

	var/list/target_score = list() //The higher the object, the higher priority it is to get hit.


	if(new_loc.has_dense_atom)
		for(var/k in new_loc.contents)
			var/atom/movable/A = k
			if(!A.density || A.mouse_opacity <= 0)
				continue
			if(is_living(A))
				var/mob/living/L = A
				var/score = L.size //Bigger objects get more priority.
				if(L == target_atom)
					score = 1000
				else if(L.horizontal)
					score *= 0.5
				target_score[L] = score
				continue
			else
				target_score[A] = A.plane*1000 + A.layer

	if(length(new_loc.old_living))
		for(var/k in new_loc.old_living)
			var/mob/living/L = k
			if(!L.density || L.mouse_opacity <= 0)
				continue
			if(L.dead || L.next_move <= 0 || get_dist(L,src) > 1) //Special exceptions for living.
				continue
			var/score = L.size*0.5
			if(L == target_atom)
				score = 1000
			else if(L.horizontal)
				score *= 0.5
			target_score[L] = score

	if(length(target_score))
		sort_tim(target_score,cmp=/proc/cmp_numeric_dsc,associative=TRUE) //Get the highest.

		for(var/k in target_score)
			var/mob/living/L = k
			if(L.projectile_should_collide(src,old_loc,new_loc))
				if(on_projectile_hit(L,old_loc,new_loc))
					penetrations_left--
					if(penetrations_left < 0)
						return FALSE
				else
					break

	if(new_loc.density && new_loc.projectile_should_collide(src,old_loc,new_loc) && on_projectile_hit(new_loc,old_loc,new_loc))
		penetrations_left--
		if(penetrations_left < 0)
			return FALSE

	if(hit_target_turf && target_turf == old_loc)
		on_projectile_hit(old_loc,old_loc,new_loc)
		return FALSE

	if(steps_allowed && steps_allowed <= steps_current)
		on_projectile_hit(new_loc,old_loc,new_loc)
		return FALSE

	steps_current += 1

	return TRUE //No hits. Do not destroy.

/obj/projectile/proc/update_projectile(var/tick_rate=1)

	if(qdeleting)
		log_error("Warning: [src.get_debug_name()] called update_projectile() while qdeleting!")
		SSprojectiles.all_projectiles -= src //Safety.
		return TRUE

	if(!src.z || (!vel_x && !vel_y) || lifetime && start_time >= lifetime)
		on_projectile_hit(current_loc)
		return FALSE

	if(!start_time) //First time running.
		if(rotate_projectile)
			var/matrix/M = get_base_transform()
			var/new_angle = -ATAN2(vel_x,vel_y) + 90
			M.Turn(new_angle)
			transform = M
	else
		pixel_x_float_visual += vel_x
		pixel_y_float_visual += vel_y
		pixel_x_float_physical += vel_x
		pixel_y_float_physical += vel_y

	start_time += TICKS_TO_DECISECONDS(tick_rate)

	//Visual changes here only.
	var/rounded_x = CEILING(pixel_x_float_visual,1)
	var/rounded_y = CEILING(pixel_y_float_visual,1)
	if(pixel_x != rounded_x || pixel_y != rounded_y) //Big enough change to animate.
		var/pixel_offset_x = vel_x
		var/pixel_offset_y = vel_y
		if(pixel_offset_x || pixel_offset_y)
			var/norm = max(abs(pixel_offset_x),abs(pixel_offset_y))
			pixel_offset_x = round((pixel_offset_x/norm) * TILE_SIZE)
			pixel_offset_y = round((pixel_offset_y/norm) * TILE_SIZE)
		if(world.tick_usage < 90 && max(abs(vel_x),abs(vel_y)) < TILE_SIZE*TICKS_TO_SECONDS(SSprojectiles.tick_rate))
			animate(src,
				pixel_x = rounded_x + pixel_offset_x,
				pixel_y = rounded_y + pixel_offset_y,
				time=tick_rate
			)
		else
			pixel_x = rounded_x + pixel_offset_x
			pixel_y = rounded_y + pixel_offset_y

	var/max_normal = max(abs(vel_x),abs(vel_y))
	var/x_normal = vel_x/max_normal
	var/y_normal = vel_y/max_normal
	var/current_loc_x = x + FLOOR(((TILE_SIZE/2) + pixel_x_float_physical + x_normal*TILE_SIZE) / TILE_SIZE, 1) //DON'T REMOVE (TILE_SIZE/2). IT MAKES SENSE.
	var/current_loc_y = y + FLOOR(((TILE_SIZE/2) + pixel_y_float_physical + y_normal*TILE_SIZE) / TILE_SIZE, 1) //DON'T REMOVE (TILE_SIZE/2). IT MAKES SENSE.
	if((last_loc_x != current_loc_x) || (last_loc_y != current_loc_y))
		//To coders better than me.
		//There is probably a legitimately better way to handle this.
		//I remember coding another method accidentally before but I don't remember it.
		//If you have any legitimate ideas, hit me up.
		if((last_loc_x != current_loc_x) && (last_loc_y != current_loc_y)) //If both changed at the same time, that's a problem as it is moving in a diaganol.
			if(intercaridnal_fix_switch) //There is really no real way to do this.
				pixel_x_float_physical -= vel_x
				current_loc_x = x + FLOOR(((TILE_SIZE/2) + pixel_x_float_physical + x_normal*TILE_SIZE) / TILE_SIZE, 1) //Copy of above.
			else
				pixel_y_float_physical -= vel_y
				current_loc_y = y + FLOOR(((TILE_SIZE/2) + pixel_y_float_physical + y_normal*TILE_SIZE) / TILE_SIZE, 1) //Copy of above.
			intercaridnal_fix_switch = !intercaridnal_fix_switch //Alternates so that the offset isn't too crazy.
		current_loc = locate(current_loc_x,current_loc_y,z)
		if(!on_enter_tile(previous_loc,current_loc))
			return FALSE
		previous_loc = current_loc
		last_loc_x = current_loc_x
		last_loc_y = current_loc_y
	else if(steps_current == 0 && !on_enter_tile(loc,loc))
		return FALSE

	return TRUE

/obj/projectile/on_projectile_hit(var/atom/hit_atom,var/turf/old_loc,var/turf/new_loc)

	if(projectile_blacklist[hit_atom])
		return FALSE

	projectile_blacklist[hit_atom] = TRUE //Can't damage the same thing twice.

	. = TRUE

	if(damage_type && all_damage_types[damage_type])

		var/damagetype/DT = all_damage_types[damage_type]

		var/precise = FALSE
		if(is_living(hit_atom))
			var/mob/living/L = hit_atom
			if(L.ai && L.ai.alert_level <= ALERT_LEVEL_NOISE)
				precise = TRUE

		if(!precise)
			var/inaccuracy = DT.inaccuracy_mod
			if(inaccuracy > 0)
				inaccuracy *= src.get_inaccuracy(owner,hit_atom,inaccuracy_modifier)
				shoot_x = clamp(shoot_x + rand(-inaccuracy,inaccuracy),0,TILE_SIZE)
				shoot_y = clamp(shoot_y + rand(-inaccuracy,inaccuracy),0,TILE_SIZE)

		if(owner && !owner.qdeleting && hit_atom.can_be_attacked(owner,weapon,null,DT))
			var/list/params = list()

			params[PARAM_ICON_X] = shoot_x
			params[PARAM_ICON_Y] = shoot_y

			var/atom/object_to_damage = hit_atom.get_object_to_damage(owner,src,damage_type,params,precise,precise,inaccuracy_modifier)

			if(!object_to_damage)
				DT.perform_miss(null,hit_atom,weapon)
				return FALSE

			if(DT.falloff > 0)
				damage_multiplier *= clamp(1 - ((get_dist(hit_atom,start_turf) - DT.falloff)/DT.falloff),0.1,1)

			if(damage_multiplier > 0)
				var/list/damage_information = DT.process_damage(owner,hit_atom,weapon,object_to_damage,blamed,damage_multiplier)

				if(ricochets_left > 0 && length(damage_information))
					//damage information indexes
					//1 = damage dealt
					//2 = damage blocked via armor
					//3 = damage blocked via shield
					//4 = best armor deflection

					var/local_required_angle = ricochet_angle - (damage_information[3]*2/max(1,damage_information[1]))*ricochet_angle*0.5

					var/total_unblocked = damage_information[1] + damage_information[2] + damage_information[3]

					var/block_percent = total_unblocked > 0 ? 1 - (damage_information[1]/total_unblocked) : 1
					block_percent *= damage_information[4]

					if(block_percent >= richochet_block_percent_threshold)
						var/list/face_of_impact = get_directional_offsets(old_loc,new_loc)
						if(face_of_impact[1] || face_of_impact[2])
							var/angle_of_incidence = abs(closer_angle_difference(ATAN2(vel_x,vel_y),ATAN2(face_of_impact[1],face_of_impact[2])))
							if(angle_of_incidence >= local_required_angle)
								var/turf/T = get_turf(hit_atom)
								if(T)

									ricochets_left--

									if(is_living(hit_atom))
										var/mob/living/L = owner
										if(L.ckey_last) //Only convert if it hits a player.
											var/good_tag = FALSE
											if(iff_tag && L.iff_tag)
												iff_tag = L.iff_tag
												good_tag = TRUE
											if(loyalty_tag && L.loyalty_tag)
												loyalty_tag = L.loyalty_tag
												good_tag = TRUE
											if(good_tag)
												owner = L
												blamed = L

									start_turf = T
									previous_loc = T
									current_loc = T

									//Move one step forward.
									pixel_x_float_physical += vel_x
									pixel_y_float_physical += vel_y
									//Reflect the velocity
									vel_x *= 1 - abs(face_of_impact[1])*2
									vel_y *= 1 - abs(face_of_impact[2])*2

									//Adjust the position.
									pixel_x_float_physical -= vel_x*0.5
									pixel_y_float_physical -= vel_y*0.5

									//Resync everything.
									pixel_x_float_visual = pixel_x_float_physical
									pixel_y_float_visual = pixel_y_float_physical
									pixel_x = CEILING(pixel_x_float_visual,1)
									pixel_y = CEILING(pixel_y_float_visual,1)
									if(rotate_projectile)
										var/matrix/M = get_base_transform()
										var/new_angle = -ATAN2(vel_x,vel_y) + 90
										M.Turn(new_angle)
										transform = M
									. = FALSE

									if(length(DT.impact_sounds))
										play_sound(pick(DT.impact_sounds),T,range_max=VIEW_RANGE,volume=50)

	if(impact_effect_turf && is_turf(hit_atom))
		new impact_effect_turf(hit_atom,SECONDS_TO_DECISECONDS(60),clamp((shoot_x-16)*2,-20,20),clamp((shoot_y-16)*2,-20,20),bullet_color)

	else if(impact_effect_movable && ismovable(hit_atom))
		new impact_effect_movable(get_turf(hit_atom),SECONDS_TO_DECISECONDS(5),0,0,bullet_color)

	weapon.on_projectile_hit(src,hit_atom,old_loc,new_loc)
	hit_atom.on_projectile_hit(src,old_loc,new_loc)

	return .

/obj/projectile/get_inaccuracy(var/atom/source,var/atom/target,var/inaccuracy_modifier=1)
	if(!source || !target || source.qdeleting || target.qdeleting)
		return 100
	if(inaccuracy_modifier <= 0)
		return 0
	if(is_living(source))
		var/mob/living/L = source
		if(L.qdeleting)
			return 100
		return (1 - L.get_skill_power(SKILL_PRECISION,0,0.5,1))*inaccuracy_modifier*8
	return 0
