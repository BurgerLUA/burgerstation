/obj/plane_master/
	name = "plane master"
	icon = null
	plane = 0
	screen_loc = "CENTER" //Stolen from /tg/
	appearance_flags = PLANE_MASTER | LONG_GLIDE | PIXEL_SCALE | TILE_BOUND
	blend_mode = BLEND_OVERLAY
	alpha = 255
	var/mob/owner

/obj/plane_master/New(var/desired_loc)
	. = ..()
	owner = desired_loc
	apply_post_processing()

/obj/plane_master/Destroy()
	owner = null
	. = ..()

/obj/plane_master/proc/refresh_post_processing()
	remove_post_processing()
	apply_post_processing()
	return TRUE

/obj/plane_master/proc/remove_post_processing()
	for(var/k in filters)
		filters -= k
	return TRUE

/obj/plane_master/proc/apply_post_processing()
	return TRUE