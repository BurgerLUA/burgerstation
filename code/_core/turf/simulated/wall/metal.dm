/turf/simulated/wall/metal
	name = "steel wall"
	icon = 'icons/turf/wall/metal_new.dmi'
	icon_state = "wall"
	corner_icons = TRUE
	corner_category = "metal"

	destruction_turf = /turf/simulated/floor/plating

	color = COLOR_STEEL
	material_id = "steel"

/turf/simulated/wall/metal/on_destruction(var/atom/caller,var/damage = FALSE)

	. = ..()

	var/obj/structure/interactive/construction/girder/G = new(src)
	G.material_id = material_id
	G.color = color
	INITIALIZE(G)
	GENERATE(G)

	create_destruction(src,list(/obj/item/material/sheet/ = 4),material_id)

	return .

/*
/turf/simulated/wall/metal/rusted
	name = "metal wall"
	icon = 'icons/turf/wall/metal_rusty.dmi'
	icon_state = "wall"
	corner_icons = TRUE
	corner_category = "metal"
*/

/turf/simulated/wall/metal/reinforced
	name = "plasteel reinforced steel wall"
	icon_state = "wall_ref"
	reinforced_material_id = "plasteel"
	reinforced_color = COLOR_PLASTEEL

/turf/simulated/wall/metal/reinforced/hull
	name = "adamantium-carbon reinforced plasteel wall"
	reinforced_material_id = "adamantium-carbon"
	color = "#48482B"
	reinforced_color = "#00FF00"
	health = null

/turf/simulated/wall/metal/reinforced/syndicate
	color = COLOR_IRON
	reinforced_color = "#FF0000"

/*
/turf/simulated/wall/metal/reinforced/rusted
	name = "reinforced metal wall"
	icon = 'icons/turf/wall/metal_reinforced_rusty.dmi'
	icon_state = "wall"
	corner_icons = TRUE
	corner_category = "metal"
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