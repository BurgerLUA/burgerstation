/obj/item/container/edible/dynamic/
	var/raw_icon_state
	var/cooked_icon_state

/obj/item/container/edible/dynamic/save_item_data(mob/living/advanced/player/P,save_inventory = TRUE,died=FALSE,loadout=FALSE)
	RUN_PARENT_SAFE
	SAVEVAR("icon_state")
	SAVEVAR("cooked_icon_state")
	SAVEVAR("raw_icon_state")

/obj/item/container/edible/dynamic/load_item_data_pre(mob/living/advanced/player/P,list/object_data,loadout=FALSE)
	RUN_PARENT_SAFE
	LOADVAR("icon_state")
	LOADVAR("cooked_icon_state")
	LOADVAR("raw_icon_state")
