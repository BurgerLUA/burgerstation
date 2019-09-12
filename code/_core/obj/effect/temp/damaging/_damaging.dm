obj/effect/temp/hazard
	name = "hazard"
	desc = "Avoid this."
	duration = SECONDS_TO_DECISECONDS(3)

	var/mob/owner

	var/hazard_range = 1
	var/hazard_delay = SECONDS_TO_DECISECONDS(1)

	var/cross_hazard = TRUE

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
		attack(owner,O)

	return ..()

/obj/effect/temp/hazard/proc/do_hazard()
	for(var/mob/living/L in range(hazard_range,src))
		world.log << "HELLO: [L]"
		attack(owner,L)

obj/effect/temp/hazard/falling_fireball
	name = "falling fireball"
	icon = 'icons/obj/projectiles/fire.dmi'
	icon_state = "ball2"
	duration = SECONDS_TO_DECISECONDS(2.1)
	hazard_range = 1
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

	hazard_range = 1
	damage_type = "goliath_tentacle"
	cross_hazard = TRUE

	layer = LAYER_GROUND_SCENERY