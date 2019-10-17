obj/effect/temp/damage_number
	name = "damage number"
	desc = "We a JRPG now!"
	duration = 30
	icon = null
	mouse_opacity = 0
	plane = PLANE_CHAT

obj/effect/temp/damage_number/New(var/desired_location,var/desired_time,var/desired_value)

	. = ..()

	if(duration && isnum(desired_value))
		desired_value = floor(desired_value)
		var/damage_color_math = Clamp(255 - (desired_value/100)*255,0,255)
		var/size_math = Clamp(desired_value*0.05,1,5)
		var/desired_color = rgb(255,damage_color_math,damage_color_math)
		maptext = "<center><font size='[size_math]' color='[desired_color]'>[desired_value]</text></center>"
		animate(src,pixel_x = rand(-32,32),pixel_y=rand(TILE_SIZE*0.5,TILE_SIZE*1),time=10)
		spawn(duration - 5)
			animate(src,alpha=0,time = 5)

	return .