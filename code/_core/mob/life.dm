/mob/proc/on_life_client()
	if(!initialized)
		return FALSE
	handle_movement(CLIENT_TICK)
	return TRUE



/mob/proc/get_lighting_alpha()
	return 255

#define NIGHTVISION_TIME SECONDS_TO_DECISECONDS(2)

/mob/proc/handle_lighting_alpha()

	//Honestly a pretty weird proc, but it werks.
	//What it does is check the alpha, and if it's a match, animate it.
	//In case of pesky race conditions, it will keep calling if the alpha is not correct.
	//If it's the same, then no alterations are needed.

	if(!plane_master_lighting)
		return FALSE

	if(CALLBACK_EXISTS("\ref[src]_nightvision"))
		return FALSE

	var/desired_lighting_alpha = get_lighting_alpha()

	if(plane_master_lighting.alpha != desired_lighting_alpha)
		animate(plane_master_lighting,alpha=desired_lighting_alpha,time=NIGHTVISION_TIME)
		CALLBACK("\ref[src]_nightvision",NIGHTVISION_TIME,src,src::handle_lighting_alpha())

	return TRUE