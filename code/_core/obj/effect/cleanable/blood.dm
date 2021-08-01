/obj/effect/cleanable/blood/
	name = "blood"
	icon = 'icons/obj/effects/blood.dmi'
	color = "#990000"
	layer = LAYER_FLOOR_SCENERY
	plane = PLANE_BLOOD
	alpha = 200

	var/animate_position = FALSE
	var/randomize_angle = TRUE

	anchored = TRUE

	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

	var/blood_level = 0

	density = FALSE

/obj/effect/cleanable/blood/Cross(atom/movable/O,atom/oldloc)
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

/obj/effect/cleanable/blood/get_base_transform()
	. = ..()
	if(randomize_angle)
		var/matrix/M = .
		M.Turn(pick(0,90,180,270))

/obj/effect/cleanable/blood/New(var/desired_location,var/desired_color,var/desired_x,var/desired_y)

	if(!desired_x)
		desired_x = 0

	if(!desired_y)
		desired_y = 0

	desired_x *=2
	desired_y *=2

	if(desired_color) color = desired_color

	transform = get_base_transform()

	if(animate_position)
		desired_x = clamp(desired_x,-TILE_SIZE,TILE_SIZE)
		desired_y = clamp(desired_y,-TILE_SIZE,TILE_SIZE)
		var/move_x = SIGN(desired_x) * FLOOR(abs(desired_x)/TILE_SIZE,1)
		var/move_y = SIGN(desired_y) * FLOOR(abs(desired_y)/TILE_SIZE,1)
		desired_x -= move_x*TILE_SIZE
		desired_y -= move_y*TILE_SIZE
		if(move_x || move_y)
			var/turf/desired_turf = locate(x + move_x,y + move_y,z)
			if(desired_turf)
				loc = desired_turf
				pixel_x = -move_x*TILE_SIZE
				pixel_y = -move_y*TILE_SIZE
				animate(src,pixel_x=desired_x,pixel_y=desired_y,time=3,easing=QUAD_EASING,time=3)
	else
		desired_x = clamp(desired_x,-TILE_SIZE/2,TILE_SIZE/2)
		desired_y = clamp(desired_y,-TILE_SIZE/2,TILE_SIZE/2)
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
	icon_state = "splatter_1"
	animate_position = TRUE
	blood_level = 10

/obj/effect/cleanable/blood/splatter/New(var/desired_location,var/desired_color,var/desired_x,var/desired_y)
	icon_state = "splatter_[rand(1,12)]"
	return ..()

/obj/effect/cleanable/blood/splatter_small/
	name = "small blood splatter"
	icon_state = "micro"
	animate_position = TRUE
	blood_level = 0 //Trivial to clean.


/obj/effect/cleanable/blood/gib/
	name = "giblet splatter"
	icon_state = "gib_1"
	animate_position = TRUE
	blood_level = 20

/obj/effect/cleanable/blood/gib/New(var/desired_location,var/desired_color,var/desired_x,var/desired_y)
	icon_state = "gib_[rand(1,10)]"
	return ..()

/obj/effect/cleanable/blood/line/
	name = "blood line"
	icon_state = "trail_1"
	animate_position = TRUE
	blood_level = 5

	animate_position = FALSE

	randomize_angle = FALSE

/obj/effect/cleanable/blood/line/New(var/desired_location,var/desired_color,var/desired_x,var/desired_y)
	icon_state = "trail_[rand(1,4)]"
	return ..()


/obj/effect/cleanable/blood/body_gib
	name = "body part gib"
	blood_level = 30

	color = "#FFFFFF"

	var/flesh_color = "#FFFFFF"

/obj/effect/cleanable/blood/body_gib/update_overlays()

	var/image/I = new/image(icon,"[icon_state]_flesh")
	I.appearance_flags = src.appearance_flags | RESET_COLOR
	I.color = flesh_color
	add_overlay(I)
