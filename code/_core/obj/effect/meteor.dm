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

	var/matrix/M = get_base_transform()
	M.Scale(2,2)
	src.transform = M

	animate(src, alpha=255, time=meteor_time*0.5)
	animate(src, pixel_z=0, pixel_w=0, time=meteor_time, transform = get_base_transform())

	CALLBACK("meteor_telegraph_\ref[src]",meteor_time-20,src,src::create_telegraph())

	CALLBACK("meteor_land_\ref[src]",meteor_time,src,src::land())

	return ..()

/obj/effect/falling_meteor/proc/create_telegraph()
	new/obj/effect/temp/target(loc,20)

/obj/effect/falling_meteor/proc/land()
	explode(get_turf(src),2,src)
	src.alpha = 0
	CALLBACK("delete_\ref[src]",SECONDS_TO_DECISECONDS(3),src,.datum/proc/delete)
	return TRUE

/obj/effect/falling_fireball
	name = "falling fireball"
	icon = 'icons/obj/projectiles/magic.dmi'
	icon_state = "firebolt_flipped"

	var/meteor_time = SECONDS_TO_DECISECONDS(2)
	var/stored_loyalty_tag = "Ash Drake"

/obj/effect/falling_fireball/New(var/desired_location)

	alpha = 0
	pixel_z = TILE_SIZE*VIEW_RANGE*2

	var/matrix/M = get_base_transform()
	M.Scale(2,2)
	src.transform = M

	animate(src, alpha=255, time=meteor_time*0.5)
	animate(src, pixel_z=0, pixel_w=0, time=meteor_time*0.95, transform = get_base_transform())

	CALLBACK("fireball_land_\ref[src]",meteor_time,src,src::land())

	return ..()

/obj/effect/falling_fireball/proc/land()
	explode(get_turf(src),2,src,src,desired_loyalty_tag=stored_loyalty_tag)
	src.alpha = 0
	CALLBACK("delete_\ref[src]",SECONDS_TO_DECISECONDS(3),src,.datum/proc/delete)
	return TRUE


/obj/effect/falling_missile
	name = "falling missile"
	icon = 'icons/obj/effects/missile.dmi'
	icon_state = "missile_flight"

	plane = PLANE_ALWAYS_VISIBLE

	var/lock_time = SECONDS_TO_DECISECONDS(2)
	var/flight_time = SECONDS_TO_DECISECONDS(1)
	var/explode_time = SECONDS_TO_DECISECONDS(1)

	pixel_x = -16
	pixel_y = 0

/obj/effect/falling_missile/New(var/desired_location)

	alpha = 0
	pixel_z = TILE_SIZE*VIEW_RANGE*2

	new/obj/effect/temp/target(loc,lock_time + flight_time)

	play_sound('sound/effects/double_beep.ogg',loc)

	CALLBACK("missile_shoot_\ref[src]",lock_time,src,src::shoot())

	return ..()

/obj/effect/falling_missile/proc/shoot()

	animate(src, alpha=255, time=flight_time*0.5)
	animate(src, pixel_z=0, pixel_w=0, time=flight_time, transform = get_base_transform())

	CALLBACK("missile_land_\ref[src]",flight_time,src,src::land())
	play_sound('sound/effects/mortar_long_whistle.ogg',loc)

	return TRUE


/obj/effect/falling_missile/proc/land()
	var/turf/T = get_turf(src)
	src.alpha = 255
	src.icon_state = "missile_landed"
	play_sound('sound/effects/impacts/meteor_impact.ogg',T)
	explode(T,2,src,src)
	CALLBACK("missile_detonate_\ref[src]",explode_time,src,src::detonate())
	return TRUE

/obj/effect/falling_missile/proc/detonate()
	var/turf/T = get_turf(src)
	firebomb(T,5,src,src)
	explode(T,3,src,src)
	CALLBACK("delete_\ref[src]",SECONDS_TO_DECISECONDS(3),src,.datum/proc/delete)
	src.alpha = 0
	return TRUE