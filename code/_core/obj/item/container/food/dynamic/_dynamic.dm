/obj/item/container/food/dynamic/
	var/raw_icon_state
	var/cooked_icon_state

/obj/item/container/food/dynamic/save_item_data(var/save_inventory = TRUE)
	. = ..()
	SAVEVAR("icon_state")
	SAVEVAR("cooked_icon_state")
	SAVEVAR("raw_icon_state")
	return .

/obj/item/container/food/dynamic/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADVAR("icon_state")
	LOADVAR("cooked_icon_state")
	LOADVAR("raw_icon_state")
	return .