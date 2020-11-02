obj/effect/temp/damage_number
	name = "damage number"
	desc = "We a JRPG now!"
	duration = 20

	icon = null
	mouse_opacity = 0
	plane = PLANE_HUD_CHAT

	pixel_x =  -TILE_SIZE
	pixel_y = -TILE_SIZE

	maptext_x = 0
	maptext_y = 0
	maptext_height = TILE_SIZE*3
	maptext_width = TILE_SIZE*3

obj/effect/temp/damage_number/New(var/desired_location,var/desired_time,var/desired_value)

	. = ..()

	if(duration && desired_value)
		var/desired_color = "#FFFFFF"
		var/desired_size = 0.5
		if(isnum(desired_value))
			desired_value = clamp(desired_value,1,9999999)
			var/damage_color_math = clamp(255 - (desired_value/100)*255,0,255)
			desired_size = clamp(desired_value*0.05,0.25,5)
			desired_color = rgb(255,damage_color_math,damage_color_math)
			if(desired_value == 69 || desired_value == 420)
				desired_value = "[desired_value] (nice)"
		maptext = "<center><font size='[desired_size]' color='[desired_color]'>[desired_value]</text></center>"
		animate(src,pixel_x = initial(pixel_x) + rand(-TILE_SIZE,TILE_SIZE),pixel_y=initial(pixel_y)+rand(0,TILE_SIZE),time=duration*0.5,easing = CIRCULAR_EASING | EASE_OUT)
		spawn(duration - 5)
			animate(src,alpha=0,time = 5)

	return .