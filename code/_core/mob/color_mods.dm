/mob/proc/add_color_mod(var/id,var/list/color_mod)
	color_mods[id] = color_mod

/mob/proc/remove_color_mod(var/id)
	color_mods -= id

/mob/proc/clear_color_mods()
	color_mods = list()

/client/proc/update_color_mods()

	if(!mob)
		color = "#FFFFFF"
		return TRUE

	var/list/desired_color = list(
		1,0,0,0,
		0,1,0,0,
		0,0,1,0,
		0,0,0,1,
		0,0,0,0
	)

	for(var/id in mob.color_mods)
		var/list/color_mod = mob.color_mods[id]
		for(var/i=1,i<=length(desired_color),i++)
			if(length(color_mod) < i)
				break
			desired_color[i] = (desired_color[i]+color_mod[i])*0.5

	animate(src,color = desired_color,time = TICKS_TO_DECISECONDS(CLIENT_TICK_SLOW))

	return TRUE




/mob/proc/add_lighting_mod(var/id,var/lighting_mod)
	lighting_mods[id] = lighting_mod

/mob/proc/remove_lighting_mod(var/id)
	lighting_mods -= id

/mob/proc/clear_lighting_mods()
	lighting_mods = list()

/client/proc/update_lighting_mods()

	if(!mob)
		return TRUE

	var/desired_alpha = 255

	for(var/id in mob.lighting_mods)
		var/lighting_mod = mob.lighting_mods[id]
		desired_alpha = (desired_alpha + lighting_mod)/2

	desired_alpha = FLOOR(desired_alpha,1)

	animate(mob.plane_master_lighting,alpha = desired_alpha,time = TICKS_TO_DECISECONDS(CLIENT_TICK_SLOW))

	return TRUE