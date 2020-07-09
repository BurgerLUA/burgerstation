obj/effect/temp/hazard
	name = "hazard"
	desc = "Avoid this."
	duration = SECONDS_TO_DECISECONDS(3)

	var/atom/owner

	var/hazard_range = 0
	var/hazard_delay = SECONDS_TO_DECISECONDS(1)

	var/cross_hazard = TRUE

	var/enabled = FALSE

obj/effect/temp/hazard/Destroy()
	owner = null
	return ..()

obj/effect/temp/hazard/proc/activate_hazard()
	enabled = TRUE
	do_hazard()

/obj/effect/temp/hazard/proc/deactivate_hazard()

obj/effect/temp/hazard/New(var/desired_location,var/desired_time,var/desired_owner)

	if(desired_owner)
		owner = desired_owner

	if(hazard_delay <= 0)
		activate_hazard()
	else
		CALLBACK("activate_hazard_\ref[src]",hazard_delay,src,.proc/activate_hazard)

	return ..()

/obj/effect/temp/hazard/Crossed(var/atom/movable/O,var/atom/new_loc,var/atom/old_loc)
	if(enabled && cross_hazard && is_living(O))
		do_damage(O)
	return ..()

/obj/effect/temp/hazard/proc/do_damage(var/atom/victim)
	var/damagetype/DT = all_damage_types[damage_type]
	var/list/params = list()
	params[PARAM_ICON_X] = rand(0,32)
	params[PARAM_ICON_Y] = rand(0,32)
	var/atom/object_to_damage = victim.get_object_to_damage(owner,src,params,TRUE,TRUE)
	return DT.do_damage(owner,victim,src,object_to_damage,owner,1)

/obj/effect/temp/hazard/proc/do_hazard()

	if(hazard_range >= 1)
		for(var/mob/living/L in range(hazard_range,src))
			do_damage(L)
	else
		var/turf/T = get_turf(src)
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
	hazard_delay = 3

	hazard_range = 0
	damage_type = /damagetype/npc/goliath_tentacle
	cross_hazard = TRUE

	layer = LAYER_GROUND_SCENERY

obj/effect/temp/hazard/tentacle/New(var/desired_location,var/desired_time,var/desired_owner)
	. = ..()
	CALLBACK("deactivate_hazard_\ref[src]",9,src,.proc/deactivate_hazard)
	return .

obj/effect/temp/hazard/tentacle/attack(var/atom/attacker,var/atom/victim,params,var/atom/blamed,var/ignore_distance = FALSE)
	if(istype(victim,/mob/living/simple/npc/goliath/)) //This bug is hilarious but we don't want to have it.
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

	layer = LAYER_GROUND_SCENERY

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

obj/effect/temp/hazard/bubblefist/attack(var/atom/attacker,var/atom/victim,params,var/atom/blamed,var/ignore_distance = FALSE)
	if(istype(victim,/mob/living/simple/npc/bubblegum)) //This bug is hilarious but we don't want to have it.
		return FALSE
	return ..()

obj/effect/temp/hazard/falling_meteor
	name = "falling meteor"
	icon = 'icons/obj/effects/meteor.dmi'
	icon_state = "small"
	duration = SECONDS_TO_DECISECONDS(3)
	hazard_range = 1
	hazard_delay = SECONDS_TO_DECISECONDS(3)
	damage_type = /damagetype/item/heavy

	plane = PLANE_ALWAYS_VISIBLE

obj/effect/temp/hazard/falling_meteor/New(var/desired_location,var/desired_time,var/desired_owner)

	owner = src

	alpha = 0
	pixel_z = TILE_SIZE*VIEW_RANGE*2
	pixel_w = TILE_SIZE*VIEW_RANGE

	var/matrix/M = matrix()
	M.Scale(2,2)
	src.transform = M

	animate(src, alpha=255, time=hazard_delay*0.5)
	animate(src, pixel_z=0, pixel_w=0, time=hazard_delay*0.9, transform = matrix())

	return ..()