/obj/structure/table
	name = "plastic table"
	desc = "A table for placing objects down or taking them."
	desc_extended = "To place items on a table, press Q + Left/Right click depending on if the item is in your left or right hand. Climbing over tables is automatic; Walk into a table for long enough to climb over it."
	icon = 'icons/obj/structure/table/normal_new.dmi'
	icon_state = "table"

	corner_category = "table"
	corner_icons = TRUE

	layer = LAYER_TABLE

	collision_flags = FLAG_COLLISION_BARICADE
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

	bullet_block_chance = 50

	initialize_type = INITIALIZE_LATE

	var/table_height = 8

	density = TRUE

	pixel_y = 0

	allow_path = TRUE

/obj/structure/table/PostInitialize()

	var/turf/T = get_turf(src)

	var/list/valid_items = list()

	for(var/obj/item/I in T.contents)
		valid_items += I

	var/items_length = length(valid_items)
	var/i=0
	var/maximum_x = min(items_length,4)
	var/maximum_y = CEILING(items_length/4,1)
	for(var/k in valid_items)
		var/obj/item/I = k
		var/x = (i % maximum_x) - (maximum_x-1)*0.5
		var/y = FLOOR(i/maximum_x,1) - (maximum_y-1)*0.5
		I.pixel_x = x*TILE_SIZE*0.2 + initial(pixel_x)
		I.pixel_y = y*TILE_SIZE*0.2 + 4 + initial(pixel_y)
		i++

	return ..()


/obj/structure/table/dropped_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(is_item(object) || is_structure(object))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(1)
		var/obj/O = object
		if(anchored)
			return FALSE
		if(is_item(object))
			var/obj/item/I = O
			I.drop_item(src.loc)
		else
			O.force_move(src.loc)
		return TRUE

	. = ..()



/obj/structure/table/Cross(atom/movable/O,atom/oldloc)

	if(O && O.loc && is_living(O) && O.collision_flags & FLAG_COLLISION_BARICADE)
		var/mob/living/L = O
		var/obj/structure/table/T = locate() in O.loc.contents
		if(T)
			return TRUE

		if(L.climb_counter >= 3)
			L.climb_counter = 0
			return TRUE

		L.climb_counter++

		return FALSE

	. = ..()

/obj/structure/table/Crossed(atom/movable/O,atom/OldLoc)

	if(O && O.loc && is_living(O) && O.collision_flags & FLAG_COLLISION_BARICADE)
		var/mob/living/L = O
		L.on_table = TRUE
		L.handle_transform()

	. = ..()

/obj/structure/table/Uncrossed(atom/movable/O)

	if(O && O.loc && is_living(O) && O.collision_flags & FLAG_COLLISION_BARICADE)
		var/mob/living/L = O
		L.on_table = FALSE
		L.handle_transform()

	. = ..()

obj/structure/table/rack
	name = "plastic rack"
	desc = "A rack. Not the middle ages kind."
	desc_extended = "To place items on a rack, press Q + Left/Right click depending on if the item is in your left or right hand."
	icon = 'icons/obj/structure/rack.dmi'
	icon_state = "rack"

	corner_category = "rack"
	corner_icons = FALSE

	collision_flags = FLAG_COLLISION_BARICADE
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

obj/structure/table/rack/grey
	color = COLOR_GREY

obj/structure/table/rack/grey/light
	color = COLOR_GREY_LIGHT

obj/structure/table/rack/steel
	color = COLOR_STEEL

obj/structure/table/fancy
	name = "fancy table"
	icon = 'icons/obj/structure/table/fancy.dmi'
	pixel_y = -1
	corner_category = "table_fancy"

	pixel_y = 4

obj/structure/table/glass
	name = "glass table"
	icon = 'icons/obj/structure/table/glass.dmi'
	corner_category = "table_glass"

obj/structure/table/steel
	name = "steel table"
	color = COLOR_STEEL_LIGHT

obj/structure/table/steel/dark
	name = "dark steel table"
	color = COLOR_STEEL_DARK

obj/structure/table/wood
	name = "wood table"
	color = "#A05120"

	corner_category = "table_wood"

obj/structure/table/wood/poor
	color = "#6B4E3A"

obj/structure/table/wood/magic
	color = "#B5004E"

obj/structure/table/reinforced
	name = "reinforced table"
	desc = "Extra sturdy."
	icon = 'icons/obj/structure/table/reinforced.dmi'
	icon_state = "table"

	corner_category = "table_reinforced"

	pixel_y = 3

obj/structure/table/reinforced/steel
	color = COLOR_STEEL_LIGHT

obj/structure/table/reinforced/steel/dark
	color = COLOR_STEEL_DARK

obj/structure/table/reinforced/steel/dark/doom
	name = "table of doom"
	desc = "Probably shouldn't climb this."
	desc_extended = "A strange looking dark table with some weird circuitry attached."

obj/structure/table/reinforced/yellow
	color = "#FFFF00"



obj/structure/table/brass
	name = "clockwork table"
	desc = "Extra sturdy."
	icon = 'icons/obj/structure/clockwork/table.dmi'
	icon_state = "table"

	corner_category = "table_clockwork"

obj/structure/table/cult

	name = "cult table"
	color = "#261E1C"



	corner_category = "table_cult"



