obj/effect/temp/damage_number
	name = "damage number"
	desc = "We a JRPG now!"
	duration = 10
	icon = null
	mouse_opacity = 0
	plane = PLANE_HUD_CHAT

	pixel_x =  -TILE_SIZE*0.5
	pixel_y = -TILE_SIZE*0.5

	maptext_x = 0
	maptext_y = 0
	maptext_height = TILE_SIZE*2
	maptext_width = TILE_SIZE*2

obj/effect/temp/damage_number/New(var/desired_location,var/desired_time,var/desired_value)

	. = ..()

	loc.color = "#FF0000"

	if(duration)
		var/desired_color = "#FFFFFF"
		var/desired_size = 1
		if(isnum(desired_value))
			desired_value = FLOOR(desired_value, 1)
			var/damage_color_math = clamp(255 - (desired_value/100)*255,0,255)
			desired_size = clamp(desired_value*0.05,1,5)
			desired_color = rgb(255,damage_color_math,damage_color_math)

		maptext = "<center><font size='[desired_size]' color='[desired_color]'>[desired_value]</text></center>"
		//animate(src,pixel_x = 0,pixel_y=0,time=duration)
		spawn(duration - 5)
			animate(src,alpha=0,time = 5)

	return .