/obj/item/container/edible/dynamic/
	var/raw_icon_state
	var/cooked_icon_state

/obj/item/container/edible/dynamic/save_item_data(var/mob/living/advanced/player/P,var/save_inventory = TRUE,var/died=FALSE)
	. = ..()
	SAVEVAR("icon_state")
	SAVEVAR("cooked_icon_state")
	SAVEVAR("raw_icon_state")

/obj/item/container/edible/dynamic/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADVAR("icon_state")
	LOADVAR("cooked_icon_state")
	LOADVAR("raw_icon_state")
