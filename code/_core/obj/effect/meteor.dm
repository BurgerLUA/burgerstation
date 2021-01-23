/obj/effect/falling_meteor
	name = "falling meteor"
	icon = 'icons/obj/effects/meteor.dmi'
	icon_state = "small"

	plane = PLANE_ALWAYS_VISIBLE

	var/meteor_time = SECONDS_TO_DECISECONDS(3)

/obj/effect/falling_meteor/New(var/desired_location)

	alpha = 0
	pixel_z = TILE_SIZE*VIEW_RANGE*2
	pixel_w = TILE_SIZE*VIEW_RANGE

	var/matrix/M = matrix()
	M.Scale(2,2)
	src.transform = M

	animate(src, alpha=255, time=meteor_time*0.5)
	animate(src, pixel_z=0, pixel_w=0, time=meteor_time*0.95, transform = matrix())

	CALLBACK("meteor_land_\ref[src]",meteor_time,src,.proc/land)

	return ..()

/obj/effect/falling_meteor/proc/land()
	explode(get_turf(src),2,src,src)
	src.alpha = 0
	queue_delete(src,10)
	return TRUE

/obj/effect/falling_fireball
	name = "falling fireball"
	icon = 'icons/obj/projectiles/magic.dmi'
	icon_state = "firebolt_flipped"

	var/meteor_time = SECONDS_TO_DECISECONDS(2)

/obj/effect/falling_fireball/New(var/desired_location)

	alpha = 0
	pixel_z = TILE_SIZE*VIEW_RANGE*2

	var/matrix/M = matrix()
	M.Scale(2,2)
	src.transform = M

	animate(src, alpha=255, time=meteor_time*0.5)
	animate(src, pixel_z=0, pixel_w=0, time=meteor_time*0.95, transform = matrix())

	CALLBACK("fireball_land_\ref[src]",meteor_time,src,.proc/land)

	return ..()

/obj/effect/falling_fireball/proc/land()
	explode(get_turf(src),1,src,src)
	src.alpha = 0
	queue_delete(src,10)
	return TRUE