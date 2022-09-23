/turf/simulated/liquid/lava/
	name = "lava"
	icon = 'icons/turf/floor/lava2.dmi'
	desc = "Melting hot lava, dont fall in!"
	icon_state = "lava"

	footstep = /footstep/lava
	fishing_rewards = /loot/fishing/lava

	plane = PLANE_FLOOR

	desired_light_frequency = 2
	desired_light_power = 0.5
	desired_light_range = 8
	desired_light_color = "#CE631C"

	turf_temperature_mod = 800

	map_color = COLOR_ORANGE

	depth = 4

/turf/simulated/liquid/lava/is_safe()
	return FALSE

/turf/simulated/liquid/lava/Enter(atom/movable/O,atom/oldloc)

	if(istype(O,/mob/abstract/node_checker))
		return FALSE

	return ..()

/turf/simulated/liquid/lava/Entered(atom/movable/O,atom/oldloc)
	if(is_living(O))
		lava_idiot(O)
	return ..()

/turf/simulated/liquid/lava/post_change_turf(var/old_turf_type)

	. = ..()

	for(var/mob/living/L in contents)
		lava_idiot(L)

/turf/simulated/liquid/lava/proc/lava_idiot(var/mob/living/L,var/check=FALSE)

	if(length(L.status_immune) && L.status_immune[FIRE])
		return FALSE

	if(check && !istype(L.loc,src.type))
		return FALSE

	if(!L.on_fire && L.send_pain_response(20))
		L.to_chat(span("danger","<h1>The lava is HOT!</h1>"))

	L.add_status_effect(FIRE,100,0,stealthy=L.on_fire)

	CALLBACK("lava_\ref[L]",10,src,.proc/lava_idiot,L,TRUE)

	return TRUE
