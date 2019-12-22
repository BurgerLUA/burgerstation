/turf/simulated/wall/metal
	name = "metal wall"
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

	for(var/i=1,i<=4,i++)

		var/desired_dir = get_dir(src,caller)
		var/turf/desired_turf = get_step(src,desired_dir)

		var/obj/item/material/sheet/S = new(desired_turf)
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
	name = "reinforced metal wall"
	corner_icons = TRUE
	corner_category = "metal"

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