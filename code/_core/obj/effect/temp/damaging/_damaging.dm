obj/effect/temp/hazard
	name = "hazard"
	desc = "Avoid this."
	duration = SECONDS_TO_DECISECONDS(3)

	var/atom/owner

	var/hazard_range = 0
	var/hazard_delay = SECONDS_TO_DECISECONDS(1)

	var/cross_hazard = TRUE

	var/enabled = FALSE

	density = TRUE

obj/effect/temp/hazard/Destroy()
	owner = null
	return ..()

obj/effect/temp/hazard/proc/activate_hazard()
	enabled = TRUE
	do_hazard()
	return TRUE

/obj/effect/temp/hazard/proc/deactivate_hazard()
	return TRUE

obj/effect/temp/hazard/New(var/desired_location,var/desired_time,var/desired_owner)

	if(desired_owner)
		owner = desired_owner

	if(hazard_delay <= 0)
		activate_hazard()
	else
		CALLBACK("activate_hazard_\ref[src]",hazard_delay,src,.proc/activate_hazard)

	return ..()


/obj/effect/temp/hazard/proc/do_cross_damage(var/mob/living/L)

	if(!cross_hazard || !enabled || !L || L.loc != src.loc)
		return FALSE

	do_damage(L)

	CALLBACK("\ref[src]_cross_\ref[L]",SECONDS_TO_DECISECONDS(1),src,.proc/do_cross_damage,L)

/obj/effect/temp/hazard/Crossed(atom/movable/O)
	if(enabled && cross_hazard && is_living(O))
		do_cross_damage(O)
	return ..()

/obj/effect/temp/hazard/Uncrossed(atom/movable/O)
	if(enabled && cross_hazard && is_living(O))
		do_cross_damage(O)
	return ..()

/obj/effect/temp/hazard/proc/get_params(var/atom/victim)
	. = list()
	.[PARAM_ICON_X] = rand(0,32)
	.[PARAM_ICON_Y] = rand(0,32)
	return .

/obj/effect/temp/hazard/proc/do_damage(var/atom/victim)

	if(is_living(victim) && is_living(owner) && owner != victim)
		var/mob/living/L = victim
		var/mob/living/L2 = owner
		if(L.loyalty_tag == L2.loyalty_tag)
			return FALSE
	var/damagetype/DT = all_damage_types[damage_type]
	var/list/params = get_params()
	if(!victim.can_be_attacked(owner,src,params,DT))
		return FALSE
	var/atom/object_to_damage = victim.get_object_to_damage(owner,src,params,TRUE,TRUE)
	return DT.hit(owner,victim,src,object_to_damage,owner,1)

/obj/effect/temp/hazard/proc/do_hazard()

	if(qdeleting)
		return FALSE

	if(hazard_range >= 2)
		for(var/mob/living/L in range(hazard_range,src))
			do_damage(L)
	else
		var/turf/T = get_turf(src)
		if(T)
			for(var/mob/living/L in T.contents)
				do_damage(L)


obj/effect/temp/hazard/falling_fireball
	name = "falling fireball"
	icon = 'icons/obj/projectiles/magic.dmi'
	icon_state = "firebolt"
	duration = SECONDS_TO_DECISECONDS(2.1)
	hazard_range = 0
	hazard_delay = SECONDS_TO_DECISECONDS(2)
	damage_type = /damagetype/ranged/magic/fireball

obj/effect/temp/hazard/falling_fireball/New(var/desired_location,var/desired_time,var/desired_owner)

	alpha = 50
	pixel_z = TILE_SIZE*VIEW_RANGE

	src.transform = turn(src.transform, 180)

	animate(src,alpha=255,time=hazard_delay*0.5)
	animate(src,pixel_z=0,time=hazard_delay*0.9)

	return ..()



obj/effect/temp/hazard/fire/
	name = "hellfire"
	icon = 'icons/obj/effects/fire.dmi'
	icon_state = "3"
	duration = SECONDS_TO_DECISECONDS(6)
	hazard_range = 1
	hazard_delay = SECONDS_TO_DECISECONDS(1)
	damage_type = /damagetype/ranged/magic/magefire

	cross_hazard = TRUE


obj/effect/temp/hazard/tentacle/
	name = "goliath tentacle"
	icon = 'icons/mob/living/simple/lavaland/goliath.dmi'
	icon_state = "tentacle"
	duration = 13
	hazard_delay = 7

	hazard_range = 0
	damage_type = /damagetype/npc/goliath_tentacle
	cross_hazard = TRUE

	layer = LAYER_FLOOR_EFFECTS

obj/effect/temp/hazard/tentacle/New(var/desired_location,var/desired_time,var/desired_owner)
	. = ..()
	CALLBACK("deactivate_hazard_\ref[src]",9,src,.proc/deactivate_hazard)
	return .

obj/effect/temp/hazard/tentacle/attack(var/atom/attacker,var/atom/victim,var/list/params=list(),var/atom/blamed,var/ignore_distance = FALSE, var/precise = FALSE,var/damage_multiplier=1)
	if(istype(victim,/mob/living/simple/goliath/)) //This bug is hilarious but we don't want to have it.
		return FALSE
	return ..()

obj/effect/temp/hazard/bubblefist/
	name = "bubblegum grab"
	icon = 'icons/mob/living/simple/lavaland/bubblegum_hands.dmi'
	icon_state = "rightpawgrab"
	var/overlay_state = "rightthumbgrab"
	duration = 10
	hazard_delay = 6

	hazard_range = 0
	damage_type = /damagetype/npc/goliath_tentacle
	cross_hazard = TRUE

	layer = LAYER_FLOOR_EFFECTS

	plane = PLANE_MOB - 1

obj/effect/temp/hazard/bubblefist/update_overlays()
	. = ..()
	var/image/I = new/image(icon,overlay_state)
	I.appearance_flags = RESET_COLOR | RESET_ALPHA | RESET_TRANSFORM
	I.plane = PLANE_EFFECT

	add_overlay(I)
	return .

obj/effect/temp/hazard/bubblefist/New(var/desired_location,var/desired_time,var/desired_owner)
	if(prob(50))
		icon_state = "leftpawgrab"
		overlay_state = "leftthumbgrab"
	. = ..()
	CALLBACK("deactivate_hazard_\ref[src]",7,src,.proc/deactivate_hazard)
	update_sprite()

	return .

obj/effect/temp/hazard/bubblefist/attack(var/atom/attacker,var/atom/victim,var/list/params=list(),var/atom/blamed,var/ignore_distance = FALSE, var/precise = FALSE,var/damage_multiplier=1)
	if(istype(victim,/mob/living/simple/bubblegum)) //This bug is hilarious but we don't want to have it.
		return FALSE
	return ..()



/obj/effect/temp/hazard/lava/
	name = "lava"
	icon = 'icons/obj/effects/lava.dmi'
	icon_state = "lavastaff_warn"
	duration = SECONDS_TO_DECISECONDS(30)
	hazard_range = 1
	damage_type = /damagetype/ranged/magic/fireball
	cross_hazard = TRUE
	plane = PLANE_BLOOD
	layer = 0

/obj/effect/temp/hazard/lava/get_params(var/atom/victim)

	if(is_living(victim))
		var/mob/living/L = victim
		if(L.horizontal)
			return ..()

	. = list()
	.[PARAM_ICON_X] = rand(0,32)
	.[PARAM_ICON_Y] = rand(0.14)

	return .



/obj/effect/temp/hazard/curse
	name = "lava"
	icon = 'icons/obj/structure/cult/effects.dmi'
	icon_state = "floorglow_strong"
	duration = SECONDS_TO_DECISECONDS(10)
	hazard_range = 1
	damage_type = /damagetype/ranged/magic/cult
	cross_hazard = TRUE
	plane = PLANE_BLOOD
	layer = 0

/obj/effect/temp/hazard/curse/New(var/desired_location,var/desired_time,var/desired_owner)

	if(istype(desired_location,/turf/simulated/wall/))
		icon_state = "wallglow_strong"

	return ..()

/obj/effect/temp/hazard/curse/get_params(var/atom/victim)

	if(is_living(victim))
		var/mob/living/L = victim
		if(L.horizontal)
			return ..()

	. = list()
	.[PARAM_ICON_X] = rand(0,32)
	.[PARAM_ICON_Y] = rand(0.14)

	return .