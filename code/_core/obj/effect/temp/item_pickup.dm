/obj/effect/temp/item_pickup
	name = "item pickup"
	duration = 3
	mouse_opacity = 0
	alpha = 255
	layer = LAYER_EFFECT


obj/effect/temp/item_pickup/New(var/atom/desired_location,var/desired_time,var/atom/old_location,var/obj/item/desired_object,var/desired_animation_type = "pickup")

	appearance = desired_object.appearance

	var/target_dir = get_dir(get_turf(old_location),get_turf(desired_location))

	var/x_offset = 0
	var/y_offset = 0

	if(target_dir & NORTH)
		y_offset = -32

	if(target_dir & SOUTH)
		y_offset = 32

	if(target_dir & EAST)
		x_offset = -32

	if(target_dir & WEST)
		x_offset = 32

	src.pixel_x = x_offset
	src.pixel_y = y_offset

	switch(desired_animation_type)
		if("pickup")
			var/matrix/M = matrix()
			M.Scale(0,0)
			animate(src,transform=M,pixel_x = 0,pixel_y = 0,time = duration,easing=SINE_EASING)
		if("drop")
			desired_object.alpha = 0
			var/matrix/M = matrix()
			src.transform *= 0
			animate(src,transform=M,pixel_x = 0,pixel_y = 0,time = duration,easing=SINE_EASING)

	spawn(duration)
		desired_object.alpha = 255
		qdel(src)

	return TRUE