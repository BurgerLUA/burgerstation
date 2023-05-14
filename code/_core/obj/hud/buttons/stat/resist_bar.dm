/obj/hud/button/stat/resist_bar
	name = "resist bar"
	icon = 'icons/hud/escape.dmi'
	icon_state = "escape"
	id = "resist"

	layer = LAYER_HUD
	plane = PLANE_HUD

	screen_loc = "CENTER,CENTER-1"

	var/obj/stored_line

	maptext = "Resist!"
	maptext_y = -16

	mouse_opacity = 0
	alpha = 0

/obj/hud/button/stat/resist_bar/PreDestroy()
	QDEL_NULL(stored_line)
	. = ..()

/obj/hud/button/stat/resist_bar/New(var/desired_loc)
	. = ..()
	stored_line = new(src)
	stored_line.icon = 'icons/hud/escape.dmi'
	stored_line.icon_state = "escape_line"
	stored_line.appearance_flags = src.appearance_flags
	stored_line.plane = src.plane
	stored_line.layer = src.layer + 1
	vis_contents += stored_line

/obj/hud/button/stat/resist_bar/update()

	if(!is_living(owner))
		return FALSE

	var/mob/living/L = owner
	var/resist_percent = L.get_resist_percent()
	if(resist_percent == -1)
		resist_percent = 1

	var/desired = resist_percent*27
	var/distance = abs(stored_line.pixel_x - desired)
	var/mod = CEILING(min(distance,1 + distance*0.25),1)

	if(resist_percent >= 0)
		stored_line.pixel_x = min(stored_line.pixel_x + mod,desired)
	else
		stored_line.pixel_x = max(stored_line.pixel_x - mod,desired)

	if(stored_line.pixel_x == 27)
		src.alpha = clamp(src.alpha - 40,0,255) //Remove alpha.
	else
		src.alpha = clamp(src.alpha + 80,0,255) //Add alpha.

	. = ..()

	if(src.alpha > 0)
		. = TRUE
