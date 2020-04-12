/obj/structure/smooth/window
	name = "glass window"
	desc = "A see through window. A few good hits could shatter this."
	icon = 'icons/obj/structure/smooth/window/normal_new_new.dmi'
	icon_state = "window"

	alpha = 150
	color = "#6E9CAD"

	collision_flags = FLAG_COLLISION_REAL
	collision_bullet_flags = FLAG_COLLISION_BULLET_WINDOW

	corner_category = "window"
	corner_icons = TRUE

	layer = LAYER_OBJ_WINDOW

	health = /health/construction/glass

	health_base = 100

/obj/structure/smooth/window/can_be_attacked(var/atom/attacker)

	var/area/A = get_area(src)
	if(A.flags_area * FLAGS_AREA_NO_CONSTRUCTION)
		return FALSE

	return ..()

/obj/structure/smooth/window/on_destruction(var/atom/caller,var/damage = FALSE)

	var/desired_dir = get_dir(src,caller)
	var/turf/desired_turf = get_step(src,desired_dir)

	for(var/i=1,i<=rand(2,4),i++)
		var/obj/item/material/shard/S = new(desired_turf)
		S.material_id = material_id
		S.color = color

		var/offset_x = 0
		var/offset_y = 0

		if(desired_dir & NORTH)
			offset_y -= TILE_SIZE

		if(desired_dir & SOUTH)
			offset_y += TILE_SIZE

		if(desired_dir & EAST)
			offset_x -= TILE_SIZE

		if(desired_dir & WEST)
			offset_x += TILE_SIZE

		S.pixel_x = offset_x
		S.pixel_y = offset_y

		animate(S,pixel_x = rand(-TILE_SIZE*0.5,TILE_SIZE*0.5), pixel_y = rand(-TILE_SIZE*0.5,TILE_SIZE*0.5),time=5)


	qdel(src)
	return TRUE

/obj/structure/smooth/window/reinforced
	name = "aluminum reinforced glass window"
	color = "#6E9CAD"

	reinforced_material_id = "aluminum"
	reinforced_color = COLOR_ALUMINUM

/obj/structure/smooth/window/reinforced/plasma
	name = "plasteel reinforced phoron-silicate window"
	color = "#E423C9"

	reinforced_material_id = "plasteel"
	reinforced_color = COLOR_PLASTEEL

	health = null

/obj/structure/smooth/window/tinted
	name = "tinted window"
	desc = "Don't see through this."
	color = "#444444"
	opacity = 1


/obj/structure/smooth/window/clockwork
	name = "clockwork window"
	opacity = 1
	icon = 'icons/obj/structure/clockwork/window.dmi'
	icon_state = "window"

	desired_light_power = 0.5
	desired_light_range = 2
	desired_light_color = "#E29E00"


/obj/structure/smooth/window/cult
	name = "cult window"
	color = "#7F0000"



/obj/structure/smooth/window/shuttle
	name = "shuttle window"
	icon = 'icons/obj/structure/smooth/window/shuttle.dmi'
	icon_state = "window"
	corner_category = "shuttle"
	color = "#FFFFFF"
	plane = PLANE_SHUTTLE

/obj/structure/smooth/window/shuttle/middle
	icon_state = "single"
	corner_icons = FALSE

/obj/structure/smooth/window/shuttle/end_01
	icon_state = "end_01"
	corner_icons = FALSE

/obj/structure/smooth/window/shuttle/end_02
	icon_state = "end_02"
	corner_icons = FALSE
