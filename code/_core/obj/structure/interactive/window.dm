/obj/structure/window
	name = "glass window"
	desc = "A see through window. A few good hits could shatter this."
	icon = 'icons/obj/structure/window/improved.dmi'
	icon_state = "window"

	alpha = 150
	color = "#6E9CAD"

	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_WINDOW

	corner_category = "metal"
	corner_icons = TRUE

	layer = LAYER_OBJ_WINDOW

	health = /health/construction/glass

	health_base = 100

	blocks_air = NORTH | EAST | SOUTH | WEST

	plane = PLANE_WALL

	density = TRUE

	var/no_queue = FALSE

/obj/structure/window/update_overlays()
	. = ..()

	if(health)
		var/damage_number = 3 - min(3,FLOOR((health.health_current/health.health_max)*3, 1))
		if(damage_number > 0)
			var/image/I = new/image('icons/obj/effects/glass_damage.dmi',"damage_[damage_number]")
			add_overlay(I)

	if(anchored)
		for(var/d in DIRECTIONS_CARDINAL)
			var/turf/T = get_step(loc,d)
			var/found = istype(T,/turf/simulated/wall/metal)
			if(!found)
				var/obj/structure/interactive/door/airlock/A = locate() in T.contents
				if(A) found = TRUE
			if(found)
				var/image/I = new/image(initial(icon),"wall_blend_[d]")
				I.color = T.color
				I.dir = d
				I.appearance_flags = RESET_COLOR | RESET_ALPHA | KEEP_APART
				add_overlay(I)


/obj/structure/window/on_destruction(var/mob/caller,var/damage = FALSE)
	. = ..()
	if(damage)
		create_destruction(get_turf(src),list(/obj/item/material/shard/ = 2),material_id)
		no_queue = TRUE
	qdel(src)

/obj/structure/window/Destroy()
	if(!no_queue)
		queue_update_smooth_edges(src,include_self = FALSE)
	. = ..()

/obj/structure/window/reinforced
	name = "aluminium reinforced glass window"
	icon = 'icons/obj/structure/window/improved_reinforced.dmi'

	reinforced_material_id = /material/aluminium
	reinforced_color = COLOR_ALUMINIUM

	health_base = 300

/obj/structure/window/reinforced/plasma
	name = "plasteel reinforced phoron-silicate window"
	color = "#E423C9"

	reinforced_material_id = /material/plasteel
	reinforced_color = COLOR_PLASTEEL

	health_base = 600

/obj/structure/window/tinted
	name = "tinted window"
	desc = "Don't see through this."
	color = "#444444"
	opacity = 1


/obj/structure/window/clockwork
	name = "clockwork window"
	opacity = 1
	icon = 'icons/obj/structure/clockwork/window.dmi'
	icon_state = "window"
	color = "#FFFFFF"

	health = null


/obj/structure/window/cult
	name = "cult window"
	color = "#7F0000"

/obj/structure/window/shuttle
	name = "shuttle window"
	icon = 'icons/obj/structure/window/shuttle.dmi'
	icon_state = "window"
	corner_category = "shuttle"
	color = "#FFFFFF"
	plane = PLANE_SHUTTLE
	alpha = 255

/obj/structure/window/shuttle/middle
	icon_state = "single"
	corner_icons = FALSE

/obj/structure/window/shuttle/end_01
	icon_state = "end_01"
	corner_icons = FALSE

/obj/structure/window/shuttle/end_02
	icon_state = "end_02"
	corner_icons = FALSE

/obj/structure/window/directional
	name = "window"
	icon = 'icons/obj/structure/window/single_new.dmi'
	icon_state = "single"

	corner_category = null
	corner_icons = FALSE

	anchored = FALSE

	change_dir_on_move = FALSE

	var/force_corner = FALSE

	density = TRUE

/obj/structure/window/directional/anchored
	anchored = TRUE

/obj/structure/window/directional/Initialize()

	if(dir in DIRECTIONS_INTERCARDINAL)
		force_corner = TRUE
		name = "corner window"

	return ..()

/obj/structure/window/directional/set_dir(var/desired_dir,var/force = FALSE)

	if(force_corner)
		switch(desired_dir)
			if(NORTH)
				desired_dir = NORTHEAST
			if(EAST)
				desired_dir = SOUTHEAST
			if(SOUTH)
				desired_dir = SOUTHWEST
			if(WEST)
				desired_dir = NORTHWEST
	else
		switch(desired_dir)
			if(NORTHEAST)
				desired_dir = NORTH
			if(SOUTHEAST)
				desired_dir = EAST
			if(SOUTHWEST)
				desired_dir = SOUTH
			if(NORTHWEST)
				desired_dir = WEST

	. = ..()

	update_collisions(c_dir = dir, a_dir = dir)

