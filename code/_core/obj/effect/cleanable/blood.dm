/obj/effect/cleanable/blood
	name = "blood"
	icon = 'icons/obj/effects/blood.dmi'
	color = "#990000"
	layer = LAYER_FLOOR_SCENERY
	plane = PLANE_BLOOD
	alpha = 200

	var/randomize_angle = TRUE

	anchored = TRUE

	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

	var/blood_level = 0

	density = FALSE

/obj/effect/cleanable/blood/proc/dry()
	blood_level = 0
	color = blend_colors(color,"#2B2400",0.75)
	return TRUE

/obj/effect/cleanable/blood/dried_random/Generate()
	icon_state = pick(icon_states(icon))
	dry()
	. = ..()

/obj/effect/cleanable/blood/New(var/desired_location,var/desired_color)

	if(desired_color) color = desired_color

	transform = get_base_transform()

	update_blood_level(loc,null)

	. = ..()

/obj/effect/cleanable/blood/Destroy()
	update_blood_level(null,loc)
	. = ..()

/obj/effect/cleanable/blood/proc/update_blood_level(var/turf/simulated/new_loc,var/turf/simulated/old_loc)



	if(istype(new_loc))
		if(blood_level > 0) new_loc.add_blood_level(blood_level,desired_color=color)
		new_loc.add_blood_level_hard(1)

	if(istype(old_loc))
		if(blood_level > 0) old_loc.add_blood_level(-blood_level)
		old_loc.add_blood_level_hard(-1)

	return TRUE

/obj/effect/cleanable/blood/get_base_transform()
	. = ..()
	if(randomize_angle)
		var/matrix/M = .
		M.Turn(pick(0,90,180,270))

/obj/effect/cleanable/blood/drip
	name = "blood drip"
	icon_state = "drip"
	blood_level = 1

/obj/effect/cleanable/blood/splatter/
	name = "blood splatter"
	icon_state = "splatter_1"
	blood_level = 10

/obj/effect/cleanable/blood/splatter/grease
	color = "#955746"

/obj/effect/cleanable/blood/splatter/New(var/desired_location,var/desired_color,var/desired_x,var/desired_y)
	icon_state = "splatter_[rand(1,12)]"
	return ..()

/obj/effect/cleanable/blood/gib/
	name = "giblet splatter"
	icon_state = "gib_1"
	blood_level = 20

/obj/effect/cleanable/blood/gib/New(var/desired_location,var/desired_color,var/desired_x,var/desired_y)
	icon_state = "gib_[rand(1,10)]"
	return ..()

/obj/effect/cleanable/blood/footprint
	name = "footprints"
	icon = 'icons/obj/effects/footprints.dmi'
	icon_state = "human"
	randomize_angle = FALSE
	blood_level = -1

/obj/effect/cleanable/blood/line/
	name = "blood line"
	icon_state = "trail_1"
	blood_level = 5

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
	. = ..()
	var/image/I = new/image(icon,"[icon_state]_flesh")
	I.appearance_flags = src.appearance_flags | RESET_COLOR | KEEP_APART
	I.color = flesh_color ? flesh_color : "#FFFFFF"
	add_overlay(I)
