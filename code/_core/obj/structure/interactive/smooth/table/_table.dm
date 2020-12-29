/obj/structure/smooth/table
	name = "table"
	desc = "A table for placing objects down or taking them."
	desc_extended = "To place items on a table, press Q + Left/Right click depending on if the item is in your left or right hand. Climbing over tables is automatic; Walk into a table for long enough to climb over it."
	icon = 'icons/obj/structure/smooth/table/normal.dmi'
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

/obj/structure/smooth/table/PostInitialize()

	var/turf/T = get_turf(src)

	var/list/valid_items = list()

	for(var/obj/item/I in T.contents)
		valid_items += I

	var/items_length = length(valid_items)
	var/i=1

	for(var/k in valid_items)
		var/obj/item/I = k
		I.pixel_x = -16 + (32*(i/items_length))
		I.pixel_y = i % 2 ? 10 : 6
		i++


	return ..()


/obj/structure/smooth/table/dropped_on_by_object(var/mob/caller,var/atom/object,location,control,params)

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

	return ..()



/obj/structure/smooth/table/Cross(atom/movable/O)

	if(is_living(O) && O.collision_flags & FLAG_COLLISION_BARICADE)
		var/mob/living/L = O
		var/obj/structure/smooth/table/T = locate() in O.loc.contents
		if(T)
			return TRUE

		if(L.climb_counter >= 3)
			L.climb_counter = 0
			return TRUE

		L.climb_counter++

		return FALSE

	return ..()

/obj/structure/smooth/table/Crossed(atom/movable/O)

	if(O.loc && is_living(O) && O.collision_flags & FLAG_COLLISION_BARICADE)
		var/mob/living/L = O
		L.tabled = TRUE

	return ..()

/obj/structure/smooth/table/Uncrossed(atom/movable/O)

	if(O.loc && is_living(O) && O.collision_flags & FLAG_COLLISION_BARICADE)
		var/mob/living/L = O
		L.tabled = FALSE

	return ..()

obj/structure/smooth/table/rack
	name = "table"
	desc = "A rack. Not the middle ages kind."
	desc_extended = "To place items on a rack, press Q + Left/Right click depending on if the item is in your left or right hand."
	icon = 'icons/obj/structure/rack.dmi'
	icon_state = "rack"

	corner_category = "rack"
	corner_icons = FALSE

	collision_flags = FLAG_COLLISION_BARICADE
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

obj/structure/smooth/table/rack/grey
	color = COLOR_GREY

obj/structure/smooth/table/rack/steel
	color = COLOR_STEEL

obj/structure/smooth/table/fancy
	name = "fancy table"
	icon = 'icons/obj/structure/smooth/table/fancy.dmi'
	pixel_y = -1

	corner_category = "table_fancy"

obj/structure/smooth/table/glass
	name = "glass table"
	icon = 'icons/obj/structure/smooth/table/glass.dmi'

	corner_category = "table_glass"

obj/structure/smooth/table/dark
	color = "#999999"

obj/structure/smooth/table/wood
	name = "wood table"
	color = "#A05120"

	corner_category = "table_wood"

obj/structure/smooth/table/wood/poor
	name = "wood table"
	color = "#6B4E3A"

obj/structure/smooth/table/wood/magic
	color = "#B5004E"

obj/structure/smooth/table/reinforced
	name = "reinforced table"
	desc = "Extra sturdy."
	icon = 'icons/obj/structure/smooth/table/reinforced.dmi'
	icon_state = "table"

	corner_category = "table_reinforced"


obj/structure/smooth/table/reinforced/dark
	color = "#999999"

obj/structure/smooth/table/reinforced/dark/pvp
	name = "table of doom"
	desc = "<font color='red'><b>WARNING: OTHERS PAST THIS TABLE WILL BE ALLOWED TO KILL YOU AND YOU WILL BE ALLOWED TO KILL THEM.</b></font>"
	desc_extended = "An absolutely cursed table that disrupts loyalty implant signals, but not IFF, when the user is standing on it. A favorite among those looking for something to prove."

obj/structure/smooth/table/reinforced/yellow
	color = "#FFFF00"



obj/structure/smooth/table/brass
	name = "clockwork table"
	desc = "Extra sturdy."
	icon = 'icons/obj/structure/clockwork/table.dmi'
	icon_state = "table"

	corner_category = "table_clockwork"

obj/structure/smooth/table/cult

	name = "cult table"
	color = "#261E1C"



	corner_category = "table_cult"
