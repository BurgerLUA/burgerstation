/obj/projectile/magic/
	icon = 'icons/obj/projectiles/magic.dmi'

	collision_bullet_flags = FLAG_COLLISION_BULLET_LIGHT
	//Goes boom on destroy if not 0
	var/explode_power = 0
	//Velocity multiplied by this every update if not 0
	var/velocity_degrade = 0



	var/homing = FALSE //Do we home in on a target?
	var/homing_distance_max = VIEW_RANGE //Allowed maximum distance to home.
	var/homing_distance_min = 0 //If non-zero, speed up if above this range and slow down if below this range.
	var/homing_speed = 0 //How fast are we allowed to go without slowing down? Set to 0 to disable.
	var/homing_maximum_acceleration = 0.05 //Per tick. Also deceleration. limited between 0.01 and 0.25.
	var/homing_angle_limit = 45 //Maximum angle that it can change when homing.
	var/homing_mod = 0.05 //What percentage of velocity (as a value 0-1) should the projectile try to turn to.

	var/obj/projectile/turret_projectile // The projectile for this projectile to shoot when near valid targets.
	var/damagetype/turret_projectile_damage_type
	var/turret_projectile_delay = SECONDS_TO_DECISECONDS(1) //The delay in which the projectile can shoot.
	var/turret_projectie_max_range = 4
	var/turret_projectile_next = 0 //Read only.
	var/turret_projectile_speed = TILE_SIZE*0.5 - 1
	var/turret_projectile_sound

	var/last_angle
	var/extra_lifetime = 0 //How long should we persist before starting to decay by velocity_degrade? (In deciseconds)


/obj/projectile/magic/New(var/desired_loc,var/atom/desired_owner,var/atom/desired_weapon,var/desired_vel_x,var/desired_vel_y,var/desired_shoot_x = 0,var/desired_shoot_y = 0, var/turf/desired_turf, var/desired_damage_type, var/desired_target, var/desired_color, var/desired_blamed, var/desired_damage_multiplier=1,var/desired_iff_tag,var/desired_loyalty_tag,var/desired_inaccuracy_modifier=1,var/desired_penetrations_left=0)
	. = ..()
	homing_maximum_acceleration = clamp(homing_maximum_acceleration,0.01,0.25)

	//Stolen from smartguns
	if(homing && (loyalty_tag || iff_tag) && target_turf)
		var/mob/living/best_target
		var/best_distance = INFINITY
		for(var/mob/living/L in range(target_turf,3))
			if(L.dead)
				continue
			if(iff_tag && L.iff_tag == iff_tag)
				continue
			if(loyalty_tag && L.loyalty_tag == loyalty_tag)
				continue
			var/dist = get_dist(target_turf,L)
			if(dist < best_distance)
				best_target = L
				best_distance = dist
		if(best_target)
			target_atom = best_target




/obj/projectile/magic/on_projectile_hit(var/atom/hit_atom,var/turf/old_loc,var/turf/new_loc)
	. = ..()

	if(. && old_loc && explode_power > 0)
		explode(old_loc,explode_power,owner,src,loyalty_tag)

/obj/projectile/magic/update_projectile(var/tick_rate=1)

	. = ..()

	if(!. || !current_loc)
		return .

	//Handle shooting.
	if(turret_projectile && turret_projectie_max_range > 0 && turret_projectile_next <= world.time)
		turret_projectile_next = world.time + turret_projectile_delay
		var/mob/living/best_target
		var/best_distance = INFINITY
		for(var/mob/living/L in orange(turret_projectie_max_range,current_loc))
			if(L.dead)
				continue
			if(iff_tag && L.iff_tag == iff_tag)
				continue
			if(loyalty_tag && L.loyalty_tag == loyalty_tag)
				continue
			var/dist = get_dist(current_loc,L)
			if(dist < best_distance)
				best_target = L
				best_distance = dist
		if(best_target)
			current_loc.shoot_projectile(
				owner,
				best_target,
				null,
				null,
				turret_projectile,
				turret_projectile_damage_type,
				16,
				16,
				0,
				turret_projectile_speed,
				1,
				src.color,
				0,
				1,
				iff_tag,
				loyalty_tag
			)
			if(turret_projectile_sound)
				play_sound(turret_projectile_sound,current_loc)



	if(homing && target_atom && target_atom.z == src.z && !target_atom.qdeleting)

		var/current_speed = ROOT(vel_x**2 + vel_y**2,2) //Current speed.

		if(current_speed <= 0)
			on_projectile_hit(current_loc)
			return FALSE

		if(homing_speed > 0)
			var/found_max = max(abs(vel_x),abs(vel_y))
			var/norm_x = vel_x/found_max
			var/norm_y = vel_y/found_max
			var/max_increase = 1 / (current_speed / homing_speed)
			max_increase = round(max_increase,0.01)
			if(max_increase != 1) //No point in doing anything if the speed is fine.
				if(max_increase < 1) //Woah, slow down.
					max_increase = max(max_increase,1-homing_maximum_acceleration)
				else if(max_increase > 1) //Lets speed up.
					max_increase = min(max_increase,1+homing_maximum_acceleration)
				current_speed *= max_increase
				vel_x = norm_x * current_speed
				vel_y = norm_y * current_speed

		var/real_distance_to_target = get_dist_real(current_loc,target_atom)

		if(homing_distance_max > 0 && real_distance_to_target > homing_distance_max) //Too far away.
			return .

		if(homing_distance_min >= 0 && real_distance_to_target <= homing_distance_min) //Too close!
			return .

		if(vel_x && vel_y)
			var/list/offsets = get_directional_offsets(current_loc,target_atom)
			if(offsets[1] || offsets[2])
				var/current_angle = ATAN2(vel_x,vel_y) - 90
				var/new_angle = ATAN2(offsets[1],offsets[2]) - 90

				if(current_angle != new_angle)
					if(!homing_angle_limit || abs(current_angle - new_angle) < homing_angle_limit)
						vel_x = round(offsets[1]*current_speed*homing_mod + vel_x*(1-homing_mod),0.001)
						vel_y = round(offsets[2]*current_speed*homing_mod + vel_y*(1-homing_mod),0.001)
					if(rotate_projectile)
						var/matrix/M = get_base_transform()
						M.Turn(last_angle)
						transform = M

	//Start to degrade velocity over time.
	if(velocity_degrade > 0 && (!homing || homing_speed <= 0) && start_time + extra_lifetime <= lifetime)
		vel_x *= velocity_degrade
		vel_y *= velocity_degrade
		alpha -= 10
		if(alpha <= 40)
			on_projectile_hit(current_loc)
			return FALSE



/obj/projectile/magic/fireball
	name = "fireball"
	icon_state = "fireball"

	collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID


/obj/projectile/magic/fireball/explosive
	hit_target_turf = TRUE

	explode_power = 3

/obj/projectile/magic/fireball/lava
	hit_target_turf = TRUE

/obj/projectile/magic/fireball/lava/on_projectile_hit(var/atom/hit_atom,var/turf/old_loc,var/turf/new_loc)

	. = ..()

	if(. && hit_atom && old_loc)
		var/turf/turf_to_hit = is_floor(hit_atom) ? hit_atom : old_loc
		var/obj/effect/temp/hazard/lava/L = new(turf_to_hit,SECONDS_TO_DECISECONDS(30),owner)
		INITIALIZE(L)
		GENERATE(L)
		FINALIZE(L)

/obj/projectile/magic/chaos
	name = "chaos ball"
	icon_state = "chaos"
	var/angle_to_add = 0

/obj/projectile/magic/chaos/New(var/desired_loc,var/atom/desired_owner,var/atom/desired_weapon,var/desired_vel_x,var/desired_vel_y,var/desired_shoot_x = 0,var/desired_shoot_y = 0, var/turf/desired_turf, var/desired_damage_type, var/desired_target, var/desired_color, var/desired_blamed, var/desired_damage_multiplier=1,var/desired_iff_tag,var/desired_loyalty_tag,var/desired_inaccuracy_modifier=1,var/desired_penetrations_left=0)
	. = ..()
	angle_to_add = pick(-1,1)


/obj/projectile/magic/chaos/update_projectile(var/tick_rate=1)

	. = ..()

	if(!. || !current_loc || !angle_to_add)
		return .

	var/current_angle = -ATAN2(vel_x,vel_y) + 90
	var/current_max = max(abs(vel_x),abs(vel_y))

	var/new_angle = current_angle + angle_to_add
	var/new_vel_x = sin(new_angle)*current_max
	var/new_vel_y = cos(new_angle)*current_max

	vel_x = new_vel_x
	vel_y = new_vel_y

	var/matrix/M = get_base_transform()
	M.Turn(new_angle)
	transform = M

/obj/projectile/magic/magic_missile
	name = "magic missile"
	icon_state = "missile"

	collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID

	homing = TRUE //Do we home in on a target?
	homing_distance_max = VIEW_RANGE //Allowed maximum distance to home.
	homing_distance_min = 0 //If non-zero, speed up if above this range and slow down if below this range.
	homing_speed = 0 //How fast are we allowed to go without slowing down? Set to 0 to disable.
	homing_maximum_acceleration = 0.05 //Per tick. Also deceleration. limited between 0.01 and 0.25.
	homing_angle_limit = 60 //Maximum angle that it can change when homing.
	homing_mod = 0.5 //What percentage of velocity (as a value 0-1) should the projectile try to turn to.

/obj/projectile/magic/blade
	name = "magic blade"
	icon_state = "blade"

	penetrations_left = 1

	velocity_degrade = 0.95

	collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID

/obj/projectile/magic/rift
	name = "magic rift"
	icon_state = "rift"

	collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID

/obj/projectile/magic/rift/revive
	name = "revival rift"
	hit_laying = TRUE

/obj/projectile/magic/rift/revive/on_projectile_hit(var/atom/hit_atom,var/turf/old_loc,var/turf/new_loc)

	. = ..()

	if(. && is_living(hit_atom))
		var/mob/living/L = hit_atom
		if(L.dead && allow_helpful_action(src.loyalty_tag,L))
			L.resurrect()

/obj/projectile/magic/rift/heal
	name = "healing rift"
	hit_laying = TRUE

/obj/projectile/magic/rift/heal/on_projectile_hit(var/atom/hit_atom,var/turf/old_loc,var/turf/new_loc)

	. = ..()

	if(. && is_living(hit_atom))
		var/mob/living/L = hit_atom
		if(!L.dead && allow_helpful_action(src.loyalty_tag,L))
			L.health.adjust_loss_smart(brute=-10,burn=-10,tox=-10,robotic=FALSE)
			L.blood_oxygen += 0.2
			L.blood_volume = clamp(L.blood_volume+20,0,L.blood_volume_max)

/obj/projectile/magic/tesla
	name = "tesla ball"
	icon_state = "tesla"

	turret_projectile = /obj/projectile/magic/tesla_bolt // The projectile for this projectile to shoot when near valid targets.
	turret_projectile_damage_type = /damagetype/ranged/magic/tesla_shock
	turret_projectile_delay = SECONDS_TO_DECISECONDS(1) //The delay in which the projectile can shoot.
	turret_projectie_max_range = 4
	turret_projectile_speed = TILE_SIZE*0.3 - 1
	turret_projectile_sound = 'sound/effects/tesla.ogg'

	ignore_living = TRUE


/obj/projectile/magic/tesla_bolt
	name = "tesla bolt"
	icon_state = "tesla_01"

/obj/projectile/magic/tesla_bolt/New(var/desired_loc,var/atom/desired_owner,var/atom/desired_weapon,var/desired_vel_x,var/desired_vel_y,var/desired_shoot_x = 0,var/desired_shoot_y = 0, var/turf/desired_turf, var/desired_damage_type, var/desired_target, var/desired_color, var/desired_blamed, var/desired_damage_multiplier=1,var/desired_iff_tag,var/desired_loyalty_tag,var/desired_inaccuracy_modifier=1)
	icon_state = pick("tesla_01","tesla_02","tesla_03")
	return ..()

/obj/projectile/magic/lightning
	name = "lightning"
	icon_state = "lightning_01"
	velocity_degrade = 0.8

/obj/projectile/magic/lightning/New(var/desired_loc,var/atom/desired_owner,var/atom/desired_weapon,var/desired_vel_x,var/desired_vel_y,var/desired_shoot_x = 0,var/desired_shoot_y = 0, var/turf/desired_turf, var/desired_damage_type, var/desired_target, var/desired_color, var/desired_blamed, var/desired_damage_multiplier=1,var/desired_iff_tag,var/desired_loyalty_tag,var/desired_inaccuracy_modifier=1)
	icon_state = pick("lightning_01","lightning_02","lightning_03","lightning_04","lightning_05")
	return ..()

/obj/projectile/magic/frost
	name = "frost"
	icon_state = "frost"
	velocity_degrade = 0.75

/obj/projectile/magic/lesser_fire
	name = "lesser fire"
	icon_state = "fire_lesser"

	velocity_degrade = 0.6

/obj/projectile/magic/lightning_bolt
	name = "holy lightning bolt"
	icon_state = "lightning"
	var/has_cleaved = FALSE

/obj/projectile/magic/lightning_bolt/on_projectile_hit(var/atom/hit_atom,var/turf/old_loc,var/turf/new_loc)

	. = ..()

	if(. && !has_cleaved && is_living(hit_atom))
		has_cleaved = TRUE
		for(var/mob/living/L in orange(2,hit_atom))
			if(L == hit_atom)
				continue //Just in case.
			if(L.loyalty_tag == src.loyalty_tag)
				continue
			src.on_projectile_hit(L,old_loc,new_loc)




/obj/projectile/magic/crystal
	name = "magic crystal"
	icon_state = "crystal"

	collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID

	penetrations_left = 1

	velocity_degrade = 0.7
	extra_lifetime = 1

/obj/projectile/magic/crystal/fire
	name = "magic fire crystal"
	icon_state = "crystal_fire"

	velocity_degrade = 0.95

	penetrations_left = 1
	collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID

/obj/projectile/magic/crystal/ice
	name = "ice bolt"
	icon_state = "crystal_ice"

	velocity_degrade = 0.95

	penetrations_left = 2
	collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID

/obj/projectile/magic/shadow
	name = "shadow ball"
	icon_state = "shadow"

/obj/projectile/bullet/summon
	name = "summon"
	icon = 'icons/obj/projectiles/magic.dmi'
	icon_state = "summon_dark"
	steps_allowed = 4
	hit_target_turf = TRUE
	lifetime = SECONDS_TO_DECISECONDS(2)
	impact_effect_turf = null

/obj/projectile/magic/blackflame
	name = "blackflame"
	icon_state = "blackflame"

	collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID


/obj/projectile/magic/cultist
	name = "cultist hand"
	icon_state = "cultist"

	collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID

	velocity_degrade = 0.7


/obj/projectile/magic/cultist/on_enter_tile(var/turf/old_loc,var/turf/new_loc)

	. = ..()

	var/obj/effect/temp/hazard/curse/found_curse = locate() in new_loc

	if(!found_curse)
		new /obj/effect/temp/hazard/curse(new_loc,SECONDS_TO_DECISECONDS(10),owner)



/obj/projectile/magic/arcblade
	name = "arcblade"
	icon_state = "cool"

	penetrations_left = 3

	collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID

	rotate_projectile = FALSE

	richochet_block_percent_threshold = 0
	ricochet_angle = 0
	velocity_degrade = 0.95

/obj/projectile/magic/fractal
	name = "fractal"
	icon_state = "fractal"
	collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID
	penetrations_left = 1
	homing = TRUE
	homing_speed = TILE_SIZE*0.75
	homing_mod = 0.1
	ricochet_angle = 90
	homing_angle_limit = 80

/*
/obj/projectile/magic/fractal/on_projectile_hit(atom/hit_atom)

	. = ..()

	if(. && is_living(hit_atom) && !has_split)
		has_split = TRUE
		var/list/inrange = mobs_in_range(4,hit_atom) //There has got to be a better way to get mobs in range 4
		if(inrange.len == 0)
			return FALSE
		for(var/list/unluckymobs in inrange)
			for(var/i = min(2,unluckymobs.len), i,i++)
				var/victim = unluckymobs[rand(1,unluckymobs.len)]
				src.on_projectile_hit(victim)
				unluckymobs -= list(victim) //dont hit same twice
		return FALSE

*/
/obj/projectile/magic/holy_cross
	name = "holy cross"
	icon_state = "cross"

	//TODO: Var for all 'Unholy' creatures.Deal extra to them.

	collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID

/obj/projectile/magic/unholy_skull
	name = "unholy skull"
	icon_state = "evil"

	homing = TRUE
	homing_speed = TILE_SIZE * 0.5
	explode_power = 2

	collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID

/obj/projectile/magic/inferno
	name = "inferno"
	icon_state = "inferno"

	collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID

	hit_target_turf = TRUE

/obj/projectile/magic/inferno/on_projectile_hit(var/atom/hit_atom,var/turf/old_loc,var/turf/new_loc)
	. = ..()
	firebomb(old_loc,6,owner,weapon,src.loyalty_tag)


/obj/projectile/magic/buff
	name = "buff"
	icon_state = "cross"

/obj/projectile/magic/buff/mending
	name = "mending"

/obj/projectile/magic/buff/mending/on_projectile_hit(var/atom/hit_atom,var/turf/old_loc,var/turf/new_loc)
	. = ..()
	if(. && is_living(hit_atom))
		var/mob/living/L = hit_atom
		if(!L.dead)
			L.add_status_effect(TEMP_REGEN,damage_multiplier,SECONDS_TO_DECISECONDS(damage_multiplier * 15))

/obj/projectile/magic/buff/armor
	name = "armor"

/obj/projectile/magic/buff/armor/on_projectile_hit(var/atom/hit_atom,var/turf/old_loc,var/turf/new_loc)
	. = ..()
	if(. && is_living(hit_atom))
		var/mob/living/L = hit_atom
		if(!L.dead)
			L.add_status_effect(TEMP_ARMOR,damage_multiplier * 10,SECONDS_TO_DECISECONDS(damage_multiplier * 30))


/obj/projectile/magic/leaper
	name = "leaper homing orb"
	icon = 'icons/obj/projectiles/leaper.dmi'
	icon_state = "dark_orb"

	collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID

	lifetime = SECONDS_TO_DECISECONDS(10)
	extra_lifetime = SECONDS_TO_DECISECONDS(8)

	homing = TRUE
	homing_speed = TILE_SIZE * 0.5
	explode_power = 2