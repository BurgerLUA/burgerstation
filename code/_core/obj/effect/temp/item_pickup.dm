/obj/effect/temp/item_pickup
	name = "item pickup"
	duration = 3
	mouse_opacity = 0
	alpha = 255
	plane = PLANE_EFFECT

obj/effect/temp/item_pickup/New(var/atom/desired_location,var/desired_time,var/atom/old_location,var/obj/item/desired_object,var/desired_animation_type = "pickup")

	appearance = desired_object.appearance
	plane = initial(plane)
	mouse_opacity = 0

	var/list/offsets = get_directional_offsets(get_turf(old_location),get_turf(desired_location))

	pixel_x = offsets[1]
	pixel_y = offsets[2]

	switch(desired_animation_type)
		if("pickup")
			pixel_x += desired_object.pixel_x
			pixel_y += desired_object.pixel_y
			var/matrix/M = get_base_transform()
			M.Scale(0,0)
			animate(src,transform=M,pixel_x = 0,pixel_y = 0,time = duration,easing=SINE_EASING)
		if("drop")
			var/original_x = desired_object.pixel_x
			var/original_y = desired_object.pixel_y
			desired_object.alpha = 0
			src.transform *= 0
			animate(src,transform=desired_object.transform, pixel_x=original_x, pixel_y = original_y, time = duration,easing=SINE_EASING)
		if("transfer")
			animate(src,pixel_x = 0,pixel_y = 0,time = duration,easing=SINE_EASING)

	spawn(duration)
		desired_object.alpha = initial(desired_object.alpha)
		qdel(src)

	return TRUE