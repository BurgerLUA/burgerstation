/obj/projectile/magic/
	icon = 'icons/obj/projectiles/magic.dmi'

	collision_bullet_flags = FLAG_COLLISION_BULLET_LIGHT
	//Do go boom?
	var/does_explode = FALSE
	var/explode_power = 5
	//Do we slowly fade out of existance?
	var/does_degrade = FALSE
	var/magic_vel_degrade = 0.95 
	//Do we home in on a target?
	var/is_homing = FALSE
	var/last_angle
	var/is_turret = FALSE //Slows down homing bois so they can shoot while alive. Does nothing if not homing.
	var/extra_lifetime =  2 //How long should we persist before starting to decay by magic_vel_degrade?
	var/max_home_speed = 4 //How fast are we allowed to go without slowing down?

/obj/projectile/magic/on_projectile_hit(atom/hit_atom)
	. = ..()
	
	if(. && does_explode)
		explode(get_turf(hit_atom),explode_power,owner,src,loyalty_tag)

/obj/projectile/magic/update_projectile(var/tick_rate=1)

	. = ..()

	if(. && is_homing)
		if(!.)
			return .

		if(!current_loc)
			return .

		if(start_time + SECONDS_TO_DECISECONDS(extra_lifetime) > lifetime)
			vel_x *= magic_vel_degrade
			vel_y *= magic_vel_degrade
			alpha -= 10
			if(alpha <= 0)
				on_projectile_hit(current_loc)
				return FALSE
			return .


		if((abs(vel_x) > max_home_speed && abs(vel_y) > max_home_speed) && is_turret)
			vel_x *= 0.95
			vel_y *= 0.95
			return .

		var/atom/target_to_track = target_atom ? target_atom : target_turf

		if(!target_to_track || target_to_track.z != src.z || target_to_track.qdeleting)
			return .

		var/desired_angle = get_angle(current_loc,target_to_track)

		if(!isnum(last_angle))
			last_angle = desired_angle
		else
			desired_angle = SIMPLIFY_DEGREES(last_angle)*0.75 + SIMPLIFY_DEGREES(desired_angle)*0.25

		vel_x = (vel_x + sin(desired_angle)*2)*0.5
		vel_y = (vel_y + cos(desired_angle)*2)*0.5

		last_angle = desired_angle
	
	else if(. && does_degrade)
		vel_x *= magic_vel_degrade
		vel_y *= magic_vel_degrade
		alpha = clamp(alpha *= magic_vel_degrade,0,255)

		if(abs(vel_x) <= 1	&& abs(vel_y) <= 1)
			on_projectile_hit(current_loc)
			return FALSE


/obj/projectile/magic/fireball
	name = "fireball"
	icon_state = "fireball"

	collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID


/obj/projectile/magic/fireball/explosive
	hit_target_turf = TRUE

	does_explode = TRUE
	explode_power = 20

/obj/projectile/magic/fireball/lava
	hit_target_turf = TRUE

/obj/projectile/magic/fireball/lava/on_projectile_hit(var/atom/hit_atom)

	. = ..()

	if(.)
		var/turf/T = get_turf(hit_atom)
		if(T)
			var/obj/effect/temp/hazard/lava/L = new(T,SECONDS_TO_DECISECONDS(30),owner)
			INITIALIZE(L)
			GENERATE(L)
			FINALIZE(L)

/obj/projectile/magic/chaos
	name = "chaos ball"
	icon_state = "chaos"

/obj/projectile/magic/magic_missile
	name = "magic missile"
	icon_state = "missile"

	is_homing = TRUE

	collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID

/obj/projectile/magic/blade
	name = "magic blade"
	icon_state = "blade"

	penetrations_left = 2

	magic_vel_degrade = 0.95

	collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID

/obj/projectile/magic/rift
	name = "magic rift"
	icon_state = "rift"

	collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID

/obj/projectile/magic/rift/revive
	name = "revival rift"
	hit_laying = TRUE

/obj/projectile/magic/rift/revive/on_projectile_hit(var/atom/hit_atom)

	. = ..()

	if(. && is_living(hit_atom))
		var/mob/living/L = hit_atom
		if(L.dead && allow_helpful_action(src.loyalty_tag,L))
			L.resurrect()

/obj/projectile/magic/rift/heal
	name = "healing rift"
	hit_laying = TRUE

/obj/projectile/magic/rift/heal/on_projectile_hit(var/atom/hit_atom)

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

	magic_vel_degrade = 0.75
	is_homing = TRUE
	is_turret = TRUE

/obj/projectile/magic/lightning
	name = "lightning"
	icon_state = "lightning_01"
	does_degrade = TRUE
	magic_vel_degrade = 0.85

/obj/projectile/magic/lightning/New(var/desired_loc,var/atom/desired_owner,var/atom/desired_weapon,var/desired_vel_x,var/desired_vel_y,var/desired_shoot_x = 0,var/desired_shoot_y = 0, var/turf/desired_turf, var/desired_damage_type, var/desired_target, var/desired_color, var/desired_blamed, var/desired_damage_multiplier=1,var/desired_iff_tag,var/desired_loyalty_tag,var/desired_inaccuracy_modifier=1)
	icon_state = pick("lightning_01","lightning_02","lightning_03","lightning_04","lightning_05")
	return ..()

/obj/projectile/magic/frost
	name = "frost"
	icon_state = "frost"
	does_degrade = TRUE

/obj/projectile/magic/lesser_fire
	name = "lesser fire"
	icon_state = "fire_lesser"

	does_degrade = TRUE
	magic_vel_degrade = 0.9

/obj/projectile/magic/lightning_bolt
	name = "holy lightning bolt"
	icon_state = "lightning"

/obj/projectile/magic/crystal
	name = "magic crystal"
	icon_state = "crystal"
	
	collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID

/obj/projectile/magic/crystal/fire
	name = "magic fire crystal"
	icon_state = "crystal_fire"

	does_degrade = TRUE

	penetrations_left = 2
	collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID

/obj/projectile/magic/shadow
	name = "shadow ball"
	icon_state = "shadow"

/obj/projectile/magic/crystal/ice
	name = "ice bolt"
	icon_state = "crystal_ice"

	does_degrade = TRUE

	penetrations_left = 3
	collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID

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

	does_explode = TRUE
	explode_power = 10

	collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID


/obj/projectile/magic/cultist
	name = "cultist hand"
	icon_state = "cultist"

	collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID


/obj/projectile/magic/cultist/on_enter_tile(var/turf/old_loc,var/turf/new_loc)

	. = ..()

	var/obj/effect/temp/hazard/curse/found_curse = locate() in new_loc

	if(!found_curse)
		new /obj/effect/temp/hazard/curse(new_loc,SECONDS_TO_DECISECONDS(10),owner)



/obj/projectile/magic/arcblade
	name = "arcblade"
	icon_state = "cool"

	penetrations_left = 2

	collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID

/obj/projectile/magic/fractal
	name = "fractal"
	icon_state = "fractal"
	collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID
	penetrations_left = 2
	is_homing = TRUE
	max_home_speed = 24

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

	is_homing = TRUE
	max_home_speed = 16
	does_explode = TRUE
	explode_power = 2.5

	collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID

/obj/projectile/magic/inferno
	name = "inferno"
	icon_state = "inferno"

	does_explode = TRUE
	explode_power = 2.5

	collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID

/obj/projectile/magic/inferno/on_projectile_hit(atom/hit_atom, turf/old_loc, turf/new_loc)
	. = ..()

	if(.)
		var/turf/T = get_turf(hit_atom)
		if(T)
			var/obj/effect/temp/hazard/fire/L = new(T,SECONDS_TO_DECISECONDS(5),owner)
			INITIALIZE(L)
			GENERATE(L)
			FINALIZE(L)

/obj/projectile/magic/buff
	name = "buff"
	icon_state = "cross"
/obj/projectile/magic/buff/mending
	name = "mending"
/obj/projectile/magic/buff/mending/on_projectile_hit(atom/hit_atom)
	. = ..()
	if(. && is_living(hit_atom))
		var/mob/living/L = hit_atom
		if(!L.dead)
			L.add_status_effect(TEMP_REGEN,damage_multiplier,SECONDS_TO_DECISECONDS(damage_multiplier * 15))
/obj/projectile/magic/buff/armor
	name = "armor"
/obj/projectile/magic/buff/armor/on_projectile_hit(atom/hit_atom)
	. = ..()
	if(. && is_living(hit_atom))
		var/mob/living/L = hit_atom
		if(!L.dead)
			L.add_status_effect(TEMP_ARMOR,damage_multiplier * 10,SECONDS_TO_DECISECONDS(damage_multiplier * 30))
