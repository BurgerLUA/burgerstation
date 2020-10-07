/obj/effect/cleanable/blood/
	name = "blood"
	icon = 'icons/obj/effects/blood_impact.dmi'
	color = "#990000"
	layer = LAYER_FLOOR_SCENERY
	plane = PLANE_OBJ
	alpha = 200

	var/animate_position = FALSE

	anchored = TRUE

	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

	var/blood_level = 0

/obj/effect/cleanable/blood/Cross(atom/movable/O)
	return TRUE

/obj/effect/cleanable/blood/Destroy()
	update_blood_level(null,loc)
	return ..()

/obj/effect/cleanable/blood/proc/update_blood_level(var/turf/simulated/new_loc,var/turf/simulated/old_loc)

	if(!blood_level)
		return FALSE

	if(istype(new_loc))
		old_loc.blood_level += blood_level
		if(old_loc.blood_level >= 0)
			blood_turfs |= new_loc

	if(istype(old_loc))
		old_loc.blood_level -= blood_level
		if(old_loc.blood_level <= 0)
			blood_turfs -= old_loc

	return TRUE

/obj/effect/cleanable/blood/New(var/desired_location,var/desired_color,var/desired_x,var/desired_y)

	if(!desired_x)
		desired_x = 0

	if(!desired_y)
		desired_y = 0

	desired_x *=2
	desired_y *=2

	if(desired_color) color = desired_color

	var/matrix/T = matrix()
	transform = turn(T,pick(0,90,180,270))
	if(animate_position)
		var/move_x = SIGN(desired_x) * FLOOR(abs(desired_x)/TILE_SIZE,1)
		var/move_y = SIGN(desired_y) * FLOOR(abs(desired_y)/TILE_SIZE,1)
		desired_x -= move_x*TILE_SIZE
		desired_y -= move_y*TILE_SIZE
		T.Translate(desired_x,desired_y)
		animate(src, transform=T, easing = QUAD_EASING, time = 3)
		if(move_x || move_y)
			var/turf/desired_turf = locate(x + move_x,y + move_y,z)
			if(desired_turf)
				walk_to(src,desired_turf,0,3)
	else
		pixel_x = SAFENUM(desired_x)
		pixel_y = SAFENUM(desired_y)

	update_blood_level(null,src.loc)

	return ..()

/obj/effect/cleanable/blood/drip
	name = "blood drip"
	icon_state = "drip"
	animate_position = FALSE
	blood_level = 1

/obj/effect/cleanable/blood/splatter/
	name = "blood splatter"
	icon_state = "1"
	animate_position = TRUE
	blood_level = 10

/obj/effect/cleanable/blood/splatter/New(var/desired_location,var/desired_color,var/desired_x,var/desired_y)
	icon_state = "[rand(1,12)]"
	return ..()

/obj/effect/cleanable/blood/splatter_small/
	name = "small blood splatter"
	icon_state = "micro"
	animate_position = TRUE
	blood_level = 1




