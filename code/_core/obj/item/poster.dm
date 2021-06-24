/obj/item/poster/
	name = "poster"
	var/collectable_poster/stored_poster

	value_burgerbux = 1
	value = 4000

/obj/item/poster/save_item_data(var/save_inventory = TRUE)
	. = ..()
	SAVEPATH("stored_poster")

/obj/item/poster/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
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

/obj/item/poster/get_examine_list(var/mob/examiner)
	. = ..()
	var/collectable_poster/P = SSposter.all_posters[stored_poster]
	. += "<center>[ICON_TO_HTML(P.icon,P.icon_state,32,32)]</center>"

/obj/item/poster/update_icon()
	. = ..()
	var/collectable_poster/P = SSposter.all_posters[stored_poster]
	icon = P.icon
	icon_state = "inventory"