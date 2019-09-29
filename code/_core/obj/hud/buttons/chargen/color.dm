/obj/hud/button/chargen/color
	name = "color bar"
	icon_state = "full"
	icon = 'icons/hud/colorwheels.dmi'

	var/red = 0
	var/green = 0
	var/blue = 0

/obj/hud/button/chargen/color/clicked_on_by_object(var/mob/caller,object,location,control,params)

	var/icon_x = params[PARAM_ICON_X]
	var/icon_y = params[PARAM_ICON_Y]

	switch(icon_x)
		if(2 to 21)
			//red

		if(23 to 42)
			//green

		if(44 to 63)
			//blue





	return TRUE

