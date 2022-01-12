/obj/item/plate
	name = "plate"
	desc = "Dinner is served."
	desc_extended = "A basic plate meant for holding food. Hold CTRL and click to remove items from the plate."
	icon = 'icons/obj/item/plate.dmi'
	icon_state = "plate"
	mouse_opacity = 2
	layer = -1000
	size = SIZE_3
	weight = 1
	value = 10

	var/max_load = 4
	var/max_size = SIZE_2

/obj/item/plate/get_examine_list(var/mob/examiner)
	. = ..()
	. += div("notice","This object holds up to [max_load] items that are size [max_size] or lower.")

/obj/item/plate/save_item_data(var/mob/living/advanced/player/P,var/save_inventory = TRUE,var/died=FALSE)
	. = ..()
	.["contents"] = list()
	for(var/obj/item/I in contents)
		.["contents"] += I.save_item_data(save_inventory)

/obj/item/plate/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	for(var/k in object_data["contents"])
		load_and_create(P,k,src)

/obj/item/plate/Crossed(atom/movable/O)
	. = ..()
	if(O.loc == src.loc && is_item(O) && !istype(O,/obj/item/plate) && length(contents) < max_load)
		var/obj/item/I = O
		if(I.size <= max_size)
			I.drop_item(src)

/obj/item/plate/Entered(var/atom/movable/enterer,var/atom/oldloc)
	. = ..()
	vis_contents |= enterer

/obj/item/plate/Exited(var/atom/movable/exiter,var/atom/newloc)
	. = ..()
	vis_contents -= exiter