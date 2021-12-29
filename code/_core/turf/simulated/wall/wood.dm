/turf/simulated/wall/wood
	name = "wall"
	desc = "A wall made of wood"
	desc_extended = "It's a wall, made of wood, something made it."
	icon = 'icons/turf/wall/wood.dmi'
	icon_state = "wall"
	corner_icons = TRUE
	corner_category = "wood_wall"

	destruction_turf = /turf/simulated/floor/plating

	material_id = /material/wood
	health_base = 500

	color = COLOR_WOOD

/turf/simulated/wall/wood/New(var/desired_loc)
	. = ..()
	map_color = color

/turf/simulated/wall/wood/on_destruction(var/mob/caller,var/damage = FALSE)

	var/obj/structure/interactive/construction/girder/G = new(src)
	G.material_id = material_id
	G.color = color
	INITIALIZE(G)
	FINALIZE(G)

	create_destruction(src,list(/obj/item/material/wood/ = 4),material_id)

	return ..()


/turf/simulated/wall/wood/brown
	color = "#6F4533"
	desc = "A wall made of wood"
	desc_extended = "It's a wall, made of wood, something made it."

/turf/simulated/wall/wood/rich
	color = "#53331E"
	desc = "A wall made of wood"
	desc_extended = "It's a wall, made of wood, something made it. This one seems to be of a higher quality than most."

/turf/simulated/wall/wood/boat
	color = "#423022"
	desc = "A wall made of wood"
	desc_extended = "It's a wall, made of wood, something made it. This one is part of a boat."

/turf/simulated/wall/wood/boat/starting
	color = "#724C34"
	desc = "A wall made of wood"
	desc_extended = "It's a wall, made of wood, something made it. This one is part of a boat."

/turf/simulated/wall/wood/rev //for the rev base, more HP
	color = "#724C34"
	desc = "A wall made of wood"
	desc_extended = "It's a wall, made of wood, something made it, prolly' the russians. Maybe not."
	health_base = 2000
