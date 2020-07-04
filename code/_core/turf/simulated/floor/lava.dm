/turf/simulated/floor/lava/
	name = "lava"
	icon = 'icons/turf/floor/lava2.dmi'
	desc = "Melting hot lava, dont fall in!"
	icon_state = "lava"

	footstep = /footstep/lava

	plane = PLANE_WATER

/turf/simulated/floor/lava/setup_sunlight(var/sunlight_freq=VIEW_RANGE*0.5)
	if( (src.x % FLOOR(sunlight_freq*0.5, 1)) || (src.y % FLOOR(sunlight_freq*0.5, 1)) )
		return FALSE
	set_light(sunlight_freq+1,desired_light_power,"#CE631C")
	return TRUE

/turf/simulated/floor/lava/Crossed(var/atom/movable/M)
	if(is_living(M))
		lava_idiot(M)
	return ..()

/turf/simulated/floor/lava/proc/lava_idiot(var/mob/living/L)

	if(L.loc != src)
		return FALSE

	if(length(L.status_immune) && L.status_immune[FIRE])
		return FALSE

	if(!L.on_fire)
		L.to_chat(span("danger","<h1>The lava is HOT!</h1>"))
		L.emote("pain")

	L.add_status_effect(FIRE,100,0,stealthy=L.on_fire)

	CALLBACK("lava_\ref[L]",10,src,.proc/lava_idiot,L)

	return TRUE
