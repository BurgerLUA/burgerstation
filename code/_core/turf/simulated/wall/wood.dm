/turf/simulated/wall/wood
	name = "wall"
	icon = 'icons/turf/wall/wood.dmi'
	icon_state = "wall"
	corner_icons = TRUE
	corner_category = "wood_wall"

	destruction_turf = /turf/simulated/floor/plating

	material_id = /material/wood
	health_base = 500

	color = COLOR_WOOD

/turf/simulated/wall/wood/on_destruction(var/atom/caller,var/damage = FALSE)

	. = ..()

	var/obj/structure/interactive/construction/girder/G = new(src)
	G.material_id = material_id
	G.color = color
	INITIALIZE(G)
	GENERATE(G)

	create_destruction(src,list(/obj/item/material/wood/ = 4),material_id)

	return .


/turf/simulated/wall/wood/brown
	color = "#6F4533"

/turf/simulated/wall/wood/rich
	color = "#53331E"

/turf/simulated/wall/wood/boat
	color = "#423022"

/turf/simulated/wall/wood/boat/starting
	color = "#724C34"
