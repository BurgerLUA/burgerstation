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
	stored_line.pixel_x = FLOOR(L.resist_percent * 27,1)

	if(L.next_resist > 0)
		src.alpha = clamp(src.alpha + 80,0,255)
	else
		src.alpha = clamp(src.alpha - 40,0,255)

	/*
	if(L.next_resist < world.time)
		var/x_mod = 0
		var/y_mod = 0
		animate(src)
		for(var/i=1,i<=5,i++)
			x_mod = clamp(-x_mod + pick(-1,1),-1,1)*RAND_PRECISE(0.25,1)
			y_mod = clamp(-y_mod + pick(-1,1),-1,1)*RAND_PRECISE(0.25,1)
			var/matrix/M = matrix()
			M.Translate(x_mod*TILE_SIZE,y_mod*TILE_SIZE)
			animate(src,transform=M,time=0.5)
		animate(transform=matrix(),time=1)
	*/

	. = ..()

	if(src.alpha > 0)
		. = TRUE
