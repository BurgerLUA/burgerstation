/turf/simulated/wall/metal
	name = "steel wall"
	desc = "Try getting through that"
	desc_extended = "It's a wall made of solid steel, pretty tough."
	icon = 'icons/turf/wall/metal/nanotrasen.dmi'
	icon_state = "wall"
	corner_icons = TRUE
	corner_category = "wall"

	destruction_turf = /turf/simulated/floor/plating

	color = COLOR_STEEL
	material_id = /material/steel
	health_base = 1000

	window_blend = TRUE

/turf/simulated/wall/metal/New(var/desired_loc)
	. = ..()
	map_color = color

/turf/simulated/wall/metal/on_destruction(var/mob/caller,var/damage = FALSE)

	var/obj/structure/interactive/construction/girder/G = new(src)
	G.material_id = material_id
	G.color = color
	INITIALIZE(G)
	FINALIZE(G)

	create_destruction(src,list(/obj/item/material/sheet/ = 4),material_id)

	return ..()

/*
/turf/simulated/wall/metal/rusted
	name = "metal wall"
	icon = 'icons/turf/wall/metal_rusty.dmi'
	icon_state = "wall"
	corner_icons = TRUE
*/

/turf/simulated/wall/metal/crew
	color = "#3D4A4A"

/turf/simulated/wall/metal/reinforced
	name = "plasteel reinforced steel wall"
	desc = "Try getting through that"
	desc_extended = "It's a wall made of steel reinforced with plasteel, really tough."
	icon_state = "wall_ref"
	reinforced_material_id = /material/plasteel
	reinforced_color = "#FFFFFF"
	health_base = 3000

/turf/simulated/wall/metal/reinforced/hull
	name = "adamantium-carbon reinforced plasteel wall"
	desc = "Try getting through that"
	desc_extended = "It's a wall made of plasteel reinforced with an adamantium-carbon alloy, extremely tough."
	reinforced_material_id = /material/adamantium_carbon
	color = "#48482B"
	reinforced_color = COLOR_ADAMANITUM_CARBON
	health = null

/turf/simulated/wall/metal/reinforced/syndicate
	color = COLOR_IRON
	reinforced_color = "#FF0000"

/turf/simulated/wall/metal/reinforced/syndicate/shuttle
	plane = PLANE_SHUTTLE

/*
/turf/simulated/wall/metal/reinforced/rusted
	name = "reinforced metal wall"
	icon = 'icons/turf/wall/metal_reinforced_rusty.dmi'
	icon_state = "wall"
	corner_icons = TRUE
*/

/*
/turf/simulated/wall/metal/colored
	name = "metal wall"
	icon = 'icons/turf/wall/composite_solid.dmi'

/turf/simulated/wall/metal/colored/grey
	color = "#727272"


/turf/simulated/wall/metal/colored/cargo
	color = COLOR_CARGO
*/


/turf/simulated/wall/metal/syndicate
	name = "dark steel wall"
	icon = 'icons/turf/wall/metal/syndicate.dmi'
	icon_state = "wall"
	corner_icons = TRUE

	destruction_turf = /turf/simulated/floor/plating

	color = COLOR_STEEL_DARK
	material_id = /material/steel
	health_base = 1000

/turf/simulated/wall/metal/syndicate/reinforced
	name = "plasteel reinforced dark steel wall"
	icon_state = "wall_ref"
	reinforced_material_id = /material/plasteel
	reinforced_color = "#FFFFFF"
	health_base = 3000


/turf/simulated/wall/metal/rev
	name = "tinted steel wall"
	icon = 'icons/turf/wall/metal/rev.dmi'
	icon_state = "wall"
	corner_icons = TRUE

	destruction_turf = /turf/simulated/floor/plating

	color = "#626A3B"
	material_id = /material/steel
	health_base = 1000

/turf/simulated/wall/metal/rev/reinforced
	name = "plasteel reinforced tinted steel wall"
	icon_state = "wall_ref"
	reinforced_material_id = /material/plasteel
	reinforced_color = "#FFFFFF"
	health_base = 3000


/turf/simulated/metal/shuttle
	name = "shuttle-grade steel wall"
	desc = "Brace for landing"
	desc_extended = "The wall of a shuttle."
	icon = 'icons/turf/wall/metal/shuttle.dmi'
	icon_state = "wall"

	plane = PLANE_SHUTTLE

	map_color = COLOR_GREY

	reinforced_material_id = /material/plasteel
	reinforced_color = "#FFFFFF"
	reinforced_blend = BLEND_MULTIPLY
	reinforced_alpha = 100