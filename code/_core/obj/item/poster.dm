/obj/item/poster/
	name = "poster"
	var/collectable_poster/stored_poster

	value = 2000

	rarity = RARITY_RARE

/obj/item/poster/Generate()
	. = ..()
	if(!stored_poster)
		stored_poster = pick(SSposter.all_posters)

/obj/item/poster/save_item_data(mob/living/advanced/player/P,save_inventory = TRUE,died=FALSE,loadout=FALSE)
	RUN_PARENT_SAFE
	SAVEPATH("stored_poster")

/obj/item/poster/load_item_data_pre(mob/living/advanced/player/P,list/object_data,loadout=FALSE)
	RUN_PARENT_SAFE
	LOADPATH("stored_poster")

/obj/item/poster/Finalize()
	. = ..()
	update_sprite()


/obj/item/poster/update_sprite()
	. = ..()
	var/collectable_poster/P = SSposter.all_posters[stored_poster]
	name = "Collectable Poster: [P.name]"
	desc = P.desc
	desc_extended = P.desc_extended

/obj/item/poster/get_examine_list(mob/examiner)
	. = ..()
	var/collectable_poster/P = SSposter.all_posters[stored_poster]
	. += "<center>[ICON_TO_HTML(P.icon,P.icon_state,32,32)]</center>"

/obj/item/poster/update_icon()
	. = ..()
	var/collectable_poster/P = SSposter.all_posters[stored_poster]
	icon = P.icon
	icon_state = "inventory"