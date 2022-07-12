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

	mouse_opacity = 0
	alpha = 0

/obj/hud/button/stat/resist_bar/Destroy()
	. = ..()
	QDEL_NULL(stored_line)

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
	stored_line.pixel_x = FLOOR(L.resist_percent * 27,1)

	if(L.next_resist > 0)
		src.alpha = clamp(src.alpha + 40,0,255)
	else
		src.alpha = clamp(src.alpha - 20,0,255)

	. = ..()

	if(src.alpha > 0)
		. = TRUE
