/obj/item/plate
	name = "plate"
	desc = "Dinner is served."
	desc_extended = "A basic plate meant for holding food."
	icon = 'icons/obj/item/plate.dmi'
	icon_state = "plate"
	mouse_opacity = 2
	layer = -1000
	size = SIZE_10

/obj/item/plate/save_item_data(var/save_inventory = TRUE,var/died=FALSE)
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

	if(O.loc == src.loc && is_item(O))
		var/obj/item/I = O
		I.drop_item(src)

/obj/item/plate/Entered(var/atom/movable/enterer,var/atom/oldloc)
	. = ..()
	vis_contents |= enterer

/obj/item/plate/Exited(var/atom/movable/exiter,var/atom/newloc)
	. = ..()
	vis_contents -= exiter