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

	blocks_air = NORTH | EAST | SOUTH | WEST

/obj/structure/smooth/window/update_overlays()
	. = ..()
	if(health)
		var/damage_number = 3 - min(3,FLOOR((health.health_current/health.health_max)*3, 1))
		if(damage_number > 0)
			var/image/I = new/image('icons/obj/effects/glass_damage.dmi',"damage_[damage_number]")
			add_overlay(I)
	return .

/obj/structure/smooth/window/on_destruction(var/atom/caller,var/damage = FALSE)
	create_destruction(get_turf(src),list(/obj/item/material/shard/ = 2),material_id)
	queue_update_smooth_edges(src)
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
