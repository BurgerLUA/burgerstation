obj/effect/temp/damage_number
	name = "damage number"
	desc = "We a JRPG now!"
	duration = 10
	icon = null
	mouse_opacity = 0
	plane = PLANE_HUD_CHAT

	//maptext_x = TILE_SIZE*1.5
	//maptext_y = TILE_SIZE*1.5
	maptext_height = TILE_SIZE*3
	maptext_width = TILE_SIZE*3

obj/effect/temp/damage_number/New(var/desired_location,var/desired_time,var/desired_value)

	. = ..()

	if(duration)
		var/desired_color = "#FFFFFF"
		var/desired_size = 1
		if(isnum(desired_value))
			desired_value = floor(desired_value)
			var/damage_color_math = Clamp(255 - (desired_value/100)*255,0,255)
			desired_size = Clamp(desired_value*0.05,1,5)
			desired_color = rgb(255,damage_color_math,damage_color_math)

		maptext = "<center><font size='[desired_size]' color='[desired_color]'>[desired_value]</text></center>"
		animate(src,pixel_x = rand(-32,32),pixel_y=rand(TILE_SIZE*0.5,TILE_SIZE*1),time=duration)
		spawn(duration - 5)
			animate(src,alpha=0,time = 5)

	return .