/obj/effect/damage_number
	name = "damage number"
	desc = "We a JRPG now!"

	icon = null
	mouse_opacity = 0
	plane = PLANE_DAMAGE_NUMBERS

	pixel_x = 0
	pixel_y = 0

	maptext_x = -TILE_SIZE
	maptext_y = 0
	maptext_height = TILE_SIZE
	maptext_width = TILE_SIZE*3

	var/current_damage
	var/current_block
	var/id

	maptext = "Bug"

/obj/effect/damage_number/PreDestroy()
	all_damage_numbers -= id
	. = ..()

/obj/effect/damage_number/New(var/desired_location,var/desired_damage,var/desired_block,var/desirwed_id)
	. = ..()
	if(desirwed_id)
		id = desirwed_id
		all_damage_numbers[id] = src
	if(desired_damage || desired_block) add_value(desired_damage,desired_block)

/obj/effect/damage_number/proc/fade()
	animate(src,alpha=0,time = 5)
	CALLBACK("\ref[src]_remove_damage_number",5,src,src::remove())
	return TRUE

/obj/effect/damage_number/proc/remove()
	qdel(src)
	return TRUE

/obj/effect/damage_number/proc/add_value(var/desired_damage,var/desired_block)

	if(desired_damage) desired_damage = CEILING(desired_damage,1)
	if(desired_block) desired_block = CEILING(desired_block,1)

	var/desired_color = "#FFFFFF"
	var/desired_size = 0.5
	if(current_damage || current_block)
		current_damage += desired_damage
		current_block += desired_block
	else
		current_damage = desired_damage
		current_block = desired_block
		alpha = 255
		animate(src,pixel_x = initial(pixel_x) + rand(-TILE_SIZE,TILE_SIZE),pixel_y=initial(pixel_y)+rand(0,TILE_SIZE),time=10,easing = CIRCULAR_EASING | EASE_OUT,flags = ANIMATION_PARALLEL)
	current_damage = clamp(current_damage,1,9999999)
	current_block = clamp(current_block,1,9999999)
	var/damage_color_math = clamp(255 - (current_damage/200)*255,0,255)
	desired_size = clamp(current_damage*0.01,0.1,4)
	desired_color = rgb(255,damage_color_math,damage_color_math)
	desired_color = blend_colors(desired_color,"#808080",current_block/current_damage)
	var/desired_text = current_damage
	maptext = "<div style='font-size:[desired_size];color:[desired_color];text-align:center;text-shadow:0px 0px 2px #000000'>[desired_text]</div>"
	CALLBACK("\ref[src]_fade_damage_number",10,src,src::fade())
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
	maptext = "<div style='font-size:0.25;color:#FFFFFF;text-align:center;text-shadow:0px 0px 2px #000000;'>[desired_value]</div>"
	animate(src,pixel_x = initial(pixel_x) + rand(-TILE_SIZE,TILE_SIZE),pixel_y=initial(pixel_y)+rand(0,TILE_SIZE),time=duration*0.5,easing = CIRCULAR_EASING | EASE_OUT)
	CALLBACK("\ref[src]_fade_status",duration-5,src,src::fade())

/obj/effect/temp/status_effect/proc/fade()
	animate(src,alpha=0,time = 5)
	return TRUE

