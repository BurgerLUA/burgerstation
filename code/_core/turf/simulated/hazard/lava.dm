/turf/simulated/hazard/lava/
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

/turf/simulated/hazard/lava/Enter(atom/movable/O,atom/oldloc)

	if(istype(O,/mob/abstract/node_checker))
		return FALSE

	if(is_living(O))
		var/mob/living/L = O
		if(L.ai && !(length(L.status_immune) && L.status_immune[FIRE]))
			return FALSE

	return ..()

/turf/simulated/hazard/lava/Entered(atom/movable/O,atom/oldloc)
	if(is_living(O))
		lava_idiot(O)
	return ..()


/turf/simulated/hazard/lava/proc/lava_idiot(var/mob/living/L,var/check=FALSE)

	if(length(L.status_immune) && L.status_immune[FIRE])
		return FALSE

	if(check && !istype(L.loc,src.type))
		return FALSE

	if(!L.on_fire)
		L.to_chat(span("danger","<h1>The lava is HOT!</h1>"))
		L.send_pain(20)

	L.add_status_effect(FIRE,100,0,stealthy=L.on_fire)

	CALLBACK("lava_\ref[L]",10,src,.proc/lava_idiot,L,TRUE)

	return TRUE
