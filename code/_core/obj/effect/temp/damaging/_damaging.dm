obj/effect/temp/hazard
	name = "hazard"
	desc = "Avoid this."
	duration = SECONDS_TO_DECISECONDS(3)

	var/atom/owner

	var/hazard_range = 0
	var/hazard_delay = SECONDS_TO_DECISECONDS(1)

	var/cross_hazard = TRUE

obj/effect/temp/hazard/destroy()
	owner = null
	return ..()

obj/effect/temp/hazard/New(var/desired_location,var/desired_time,var/desired_owner)

	cross_hazard = FALSE

	if(desired_owner)
		owner = desired_owner

	spawn(hazard_delay)
		if(initial(cross_hazard))
			cross_hazard = TRUE
		do_hazard()

	return ..()

/obj/effect/temp/hazard/Crossed(atom/movable/O)
	if(cross_hazard && is_living(O))
		attack(owner,O,ignore_distance = TRUE)

	return ..()

/obj/effect/temp/hazard/proc/do_hazard()

	if(hazard_range >= 1)
		for(var/mob/living/L in range(hazard_range,src))
			attack(owner,L,ignore_distance = TRUE)
	else
		var/turf/T = get_turf(src)
		for(var/mob/living/L in T.contents)
			attack(owner,L,ignore_distance = TRUE)


obj/effect/temp/hazard/falling_fireball
	name = "falling fireball"
	icon = 'icons/obj/projectiles/fire.dmi'
	icon_state = "ball2"
	duration = SECONDS_TO_DECISECONDS(2.1)
	hazard_range = 0
	hazard_delay = SECONDS_TO_DECISECONDS(2)
	damage_type = "ash_drake_fireball"

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
	damage_type = "ash_drake_fire"

	cross_hazard = TRUE


obj/effect/temp/hazard/tentacle/
	name = "goliath tentacle"
	icon = 'icons/mob/living/simple/goliath.dmi'
	icon_state = "tentacle"
	duration = 15
	hazard_delay = 3

	hazard_range = 0
	damage_type = "goliath_tentacle"
	cross_hazard = TRUE

	layer = LAYER_GROUND_SCENERY

obj/effect/temp/hazard/tentacle/attack(var/atom/attacker,var/atom/victim,params,var/atom/blamed,var/ignore_distance = FALSE)
	if(istype(victim,/mob/living/simple/npc/goliath/)) //This bug is hilarious but we don't want to have it.
		return FALSE

	return ..()


obj/effect/temp/hazard/falling_meteor
	name = "falling meteor"
	icon = 'icons/obj/effects/meteor.dmi'
	icon_state = "small"
	duration = SECONDS_TO_DECISECONDS(3)
	hazard_range = 1
	hazard_delay = SECONDS_TO_DECISECONDS(3)
	damage_type = "meteor"

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