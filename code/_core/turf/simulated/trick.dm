/turf/simulated/floor/trick
	name = "strange wall"
	icon = 'icons/turf/wall/brick.dmi'
	icon_state = "wall"
	var/open = FALSE

	var/ticking = FALSE

/turf/simulated/floor/trick/update_icon()

	if(ticking)
		if(!open)
			opacity = 0
			name = "vibrataing wall"
			icon = 'icons/turf/wall/brick.dmi'
			icon_state = "wall"
		else
			name = "vibrating floor"
			opacity = 0
			icon = 'icons/turf/wall/brick.dmi'
			icon_state = "wall"
	else
		if(!open)
			opacity = 0
			name = "strange wall"
			icon = 'icons/turf/wall/brick.dmi'
			icon_state = "wall"
		else
			name = "strange floor"
			opacity = 0

	..()