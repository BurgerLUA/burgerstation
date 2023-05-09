/obj/structure/window
	name = "glass window"
	desc = "A see through window. A few good hits could shatter this."
	icon = 'icons/obj/structure/window/improved.dmi'
	icon_state = "window"

	alpha = 125
	color = "#6E9CAD"

	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_WINDOW

	corner_category = "wall"
	corner_icons = TRUE

	layer = LAYER_OBJ_WINDOW

	health = /health/construction/glass

	health_base = 100

	plane = PLANE_WALL

	density = TRUE

	var/no_queue = FALSE

/obj/structure/window/should_smooth_with(var/turf/T)

	. = ..()

	if(istype(.,/turf/simulated/wall))
		var/turf/simulated/wall/S = .
		if(!S.window_blend)
			return FALSE

/obj/structure/window/update_overlays()
	. = ..()

	if(health)
		var/damage_number = 3 - min(3,FLOOR((health.health_current/health.health_max)*3, 1))
		if(damage_number > 0)
			var/image/I = new/image('icons/obj/effects/glass_damage.dmi',"damage_[damage_number]")
			I.appearance_flags = src.appearance_flags | RESET_COLOR | RESET_ALPHA | KEEP_APART
			add_overlay(I)

	if(anchored)
		for(var/d in DIRECTIONS_CARDINAL)
			var/turf/T = get_step(src,d)
			if(!T)
				continue
			var/atom/A = src.should_smooth_with(T)
			var/is_a_turf = is_turf(A)
			var/is_an_airlock = istype(A,/obj/structure/interactive/door/airlock)
			if(is_a_turf || is_an_airlock)
				var/image/I = new/image(initial(A.icon),is_a_turf ? "window_blend_[d]" : "metal_frame_[d]")
				I.color = is_a_turf ? T.color : COLOR_STEEL
				I.dir = d
				I.appearance_flags = T.appearance_flags | RESET_COLOR | RESET_ALPHA | KEEP_APART
				add_overlay(I)

/obj/structure/window/on_destruction(var/damage = TRUE)
	if(damage)
		create_destruction(get_turf(src),list(/obj/item/material/shard/ = 2),material_id)
		no_queue = TRUE
	. = ..()
	qdel(src)

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

	health = null //Indestructable.

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

	. = ..()

/obj/structure/window/directional/Finalize()
	. = ..()
	set_dir(dir,force=TRUE)

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

	update_collisions(c_dir = dir)

