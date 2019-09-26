/turf/unsimulated/
	name = "bluespace"
	icon_state = "bluespace"
	opacity = 0

/turf/unsimulated/space
	name = "space"
	icon = 'icons/turf/space/space.dmi'
	icon_state = "1"
	opacity = 1
	var/generate = TRUE

/turf/unsimulated/space/New()
	. = ..()
	update_icon()
	return TRUE

/turf/unsimulated/space/update_icon()
	if(generate)
		icon_state = "[rand(0,25)]"

/turf/unsimulated/space/blocking
	name = "deep space"
	icon = 'icons/turf/space/space.dmi'
	icon_state = "space"
	opacity = 0
	generate = FALSE

/turf/unsimulated/abyss
	name = "abyss"
	icon = 'icons/turf/space/abyss.dmi'
	icon_state = "abyss"
	opacity = 1

/turf/unsimulated/void
	name = "abyss"
	icon = 'icons/turf/space/void.dmi'
	icon_state = "void"
	opacity = 0