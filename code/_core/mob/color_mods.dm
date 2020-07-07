/mob/proc/add_color_mod(var/id,var/list/color_mod)
	color_mods[id] = color_mod

/mob/proc/remove_color_mod(var/id,var/list/color_mod)
	color_mods -= id

/mob/proc/clear_color_mods()
	for(var/id in color_mods)
		color_mods -= id

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