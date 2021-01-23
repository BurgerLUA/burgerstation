/obj/projectile/magic/
	icon = 'icons/obj/projectiles/magic.dmi'

	collision_bullet_flags = FLAG_COLLISION_BULLET_LIGHT

	ignore_loyalty = FALSE
	ignore_iff = TRUE


/obj/projectile/magic/fireball
	name = "fireball"
	icon_state = "fireball"

	collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID


/obj/projectile/magic/fireball/explosive
	hit_target_turf = TRUE

/obj/projectile/magic/fireball/explosive/post_on_hit(var/atom/hit_atom)

	. = ..()

	if(.)
		explode(get_turf(hit_atom),2,owner,src,loyalty_tag)

	return .


/obj/projectile/magic/fireball/lava
	hit_target_turf = TRUE

/obj/projectile/magic/fireball/lava/post_on_hit(var/atom/hit_atom)

	. = ..()

	var/turf/T = get_turf(hit_atom)
	if(T)
		var/obj/effect/temp/hazard/lava/L = new(T,SECONDS_TO_DECISECONDS(30),owner)
		INITIALIZE(L)
		GENERATE(L)
		FINALIZE(L)

	return .




/obj/projectile/magic/chaos
	name = "chaos ball"
	icon_state = "chaos"

/obj/projectile/magic/magic_missile
	name = "magic missile"
	icon_state = "missile"

	collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID

/obj/projectile/magic/blade
	name = "magic blade"
	icon_state = "blade"

	collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID

/obj/projectile/magic/rift
	name = "magic rift"
	icon_state = "rift"

	collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID

/obj/projectile/magic/rift/revive
	name = "revival rift"
	hit_laying = TRUE

/obj/projectile/magic/rift/revive/post_on_hit(var/atom/hit_atom)

	. = ..()

	if(. && is_living(hit_atom))
		var/mob/living/L = hit_atom
		if(L.dead && L.loyalty_tag == src.loyalty_tag)
			L.resurrect()

	return .

/obj/projectile/magic/lightning
	name = "lightning"
	icon_state = "lightning_01"

/obj/projectile/magic/lightning/New(var/loc,var/atom/desired_owner,var/atom/desired_weapon,var/desired_vel_x,var/desired_vel_y,var/desired_shoot_x = 0,var/desired_shoot_y = 0, var/turf/desired_turf, var/desired_damage_type, var/desired_target, var/desired_color, var/desired_blamed, var/desired_damage_multiplier=1,var/desired_iff,var/desired_loyalty,var/desired_inaccuracy_modifier=1)
	icon_state = pick("lightning_01","lightning_02","lightning_03","lightning_04","lightning_05")
	return ..()

/obj/projectile/magic/lightning/update_projectile(var/tick_rate=1)

	. = ..()

	if(.)
		vel_x *= 0.8
		vel_y *= 0.8
		alpha = clamp(alpha-5,0,255)

		if(abs(vel_x) <= 1	&& abs(vel_y) <= 1)
			on_hit(current_loc,TRUE)
			return FALSE

	return .

/obj/projectile/magic/frost
	name = "frost"
	icon_state = "frost"

/obj/projectile/magic/frost/update_projectile(var/tick_rate=1)

	. = ..()

	if(.)
		vel_x *= 0.9
		vel_y *= 0.9
		alpha = clamp(alpha-5,0,255)

		if(abs(vel_x) <= 1	&& abs(vel_y) <= 1)
			on_hit(current_loc,TRUE)
			return FALSE

	return .


/obj/projectile/magic/lesser_fire
	name = "lesser fire"
	icon_state = "fire_lesser"

/obj/projectile/magic/lesser_fire/update_projectile(var/tick_rate=1)

	. = ..()

	if(.)
		vel_x *= 0.9
		vel_y *= 0.9
		alpha = clamp(alpha-5,0,255)

		if(abs(vel_x) <= 1	&& abs(vel_y) <= 1)
			on_hit(current_loc,TRUE)
			return FALSE

	return .


/obj/projectile/magic/lightning_bolt
	name = "holy lightning bolt"
	icon_state = "lightning"

/obj/projectile/magic/lightning_bolt/update_projectile(var/tick_rate=1)

	. = ..()

	if(.)
		vel_x *= 0.9
		vel_y *= 0.9
		alpha = clamp(alpha-5,0,255)

		if(abs(vel_x) <= 1	&& abs(vel_y) <= 1)
			on_hit(current_loc,TRUE)
			return FALSE

	return .

/obj/projectile/magic/crystal
	name = "magic crystal"
	icon_state = "crystal"

	collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID


/obj/projectile/magic/crystal/update_projectile(var/tick_rate=1)

	. = ..()

	if(.)
		vel_x *= 0.9
		vel_y *= 0.9
		alpha = clamp(alpha-5,0,255)

		if(abs(vel_x) <= 1	&& abs(vel_y) <= 1)
			on_hit(current_loc,TRUE)
			return FALSE

	return .


/obj/projectile/magic/crystal/fire
	name = "magic fire crystal"
	icon_state = "crystal_fire"

	collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID

/obj/projectile/magic/shadow
	name = "shadow ball"
	icon_state = "shadow"

/obj/projectile/magic/crystal/ice
	name = "ice bolt"
	icon_state = "crystal_ice"

	collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID

/obj/projectile/bullet/summon
	name = "summon"
	icon = 'icons/obj/projectiles/magic.dmi'
	icon_state = "summon_dark"
	steps_allowed = 6
	hit_target_turf = TRUE
	lifetime = SECONDS_TO_DECISECONDS(2)

/obj/projectile/magic/blackflame
	name = "blackflame"
	icon_state = "blackflame"

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

	return .