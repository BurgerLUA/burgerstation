/obj/effect/damage_number
	name = "damage number"
	desc = "We a JRPG now!"

	icon = null
	mouse_opacity = 0
	plane = PLANE_DAMAGE_NUMBERS

	pixel_x =  -TILE_SIZE
	pixel_y = -TILE_SIZE

	maptext_x = 0
	maptext_y = 0
	maptext_height = TILE_SIZE*3
	maptext_width = TILE_SIZE*3

	var/current_value

	maptext = "Bug"

/obj/effect/damage_number/New(var/desired_location,var/desired_value)
	. = ..()
	if(desired_value) add_value(desired_value)

/obj/effect/damage_number/proc/fade()
	animate(src,alpha=0,time = 10)
	CALLBACK("\ref[src]_remove_damage_number",10,src,.proc/remove)

/obj/effect/damage_number/proc/remove()
	qdel(src)
	return TRUE

/obj/effect/damage_number/proc/add_value(var/desired_value)
	var/desired_color = "#FFFFFF"
	var/desired_size = 0.5
	if(current_value)
		current_value += desired_value
		animate(src,alpha=255,flags=ANIMATION_END_NOW)
		CALLBACK_REMOVE("\ref[src]_remove_damage_number")
		CALLBACK_REMOVE("\ref[src]_fade_damage_number")
	else
		current_value = desired_value
		alpha = 255
		animate(src,pixel_x = initial(pixel_x) + rand(-TILE_SIZE,TILE_SIZE),pixel_y=initial(pixel_y)+rand(0,TILE_SIZE),time=30,easing = CIRCULAR_EASING | EASE_OUT)
	current_value = clamp(current_value,1,9999999)
	var/damage_color_math = clamp(255 - (current_value/200)*255,0,255)
	desired_size = clamp(current_value*0.01,0.25,4)
	desired_color = rgb(255,damage_color_math,damage_color_math)
	var/desired_text = current_value
	if(current_value == 69 || current_value == 420)
		desired_text = "[current_value] (nice)"
	maptext = "<center><font size='[desired_size]' color='[desired_color]'>[desired_text]</text></center>"
	CALLBACK("\ref[src]_fade_damage_number",35,src,.proc/fade)
	return TRUE


/obj/effect/temp/status_effect
	name = "status_effect"
	desc = "We a JRPG now!"
	duration = 20

	icon = null
	mouse_opacity = 0
	plane = PLANE_DAMAGE_NUMBERS

	pixel_x =  -TILE_SIZE
	pixel_y = -TILE_SIZE

	maptext_x = 0
	maptext_y = 0
	maptext_height = TILE_SIZE*3
	maptext_width = TILE_SIZE*3


/obj/effect/temp/status_effect/New(var/desired_location,var/desired_time,var/desired_value)
	. = ..()
	maptext = "<center><font size='0.5' color='#FFFFFF'>[desired_value]</text></center>"
	animate(src,pixel_x = initial(pixel_x) + rand(-TILE_SIZE,TILE_SIZE),pixel_y=initial(pixel_y)+rand(0,TILE_SIZE),time=duration*0.5,easing = CIRCULAR_EASING | EASE_OUT)
	spawn(duration - 5)
		animate(src,alpha=0,time = 5)
