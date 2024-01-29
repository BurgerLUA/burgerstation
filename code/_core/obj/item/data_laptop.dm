

//5 to 10 random syndicate vaults are placed on the map.
//The laptop can give you access to it by giving you the coords of the vault as well as the keyphrase.


/obj/item/data_laptop
	name = "classified data laptop"
	desc = "Top secret!"
	desc_extended = "A laptop containing classified locational data on secret storage areas. Once opened, coordinates will be shown to the user and then be wiped of all data!"

	icon = 'icons/obj/item/data_laptop.dmi'
	icon_state = "closed"

	var/used = FALSE

	rarity = RARITY_RARE

	value = 5000

/obj/item/data_laptop/save_item_data(mob/living/advanced/player/P,save_inventory = TRUE,died=FALSE,loadout=FALSE)
	RUN_PARENT_SAFE
	SAVEVAR("used")

/obj/item/data_laptop/load_item_data_pre(mob/living/advanced/player/P,list/object_data,loadout=FALSE)
	RUN_PARENT_SAFE
	LOADVAR("used")

/obj/item/data_laptop/get_base_value()
	. = ..()
	. *= used ? 0.01 : 1
	. = CEILING(.,1)

/obj/item/data_laptop/update_icon()

	. = ..()

	icon_state = initial(icon_state)

	if(used)
		icon_state = "useless"

/obj/item/data_laptop/Finalize()
	. = ..()
	update_sprite()

/obj/item/data_laptop/click_self(mob/caller,location,control,params)

	INTERACT_CHECK
	INTERACT_DELAY(10)

	if(used)
		caller.to_chat(span("warning","Nothing happens..."))
		update_sprite()
		return TRUE

	var/obj/structure/interactive/door/vault/syndicate/D
	while(TRUE)
		if(!length(SSobj.all_vault_doors))
			caller.to_chat(span("notice","\The [src.name] doesn't seem to want to turn on... maybe use it in another shift?"))
			return TRUE
		D = pick(SSobj.all_vault_doors)
		SSobj.all_vault_doors -= D
		if(!D.z || !D.stored_keypad || !D.stored_keypad.code)
			continue //Bad one.
		break //Found a good one.

	used = TRUE
	update_sprite()
	flick("open",src)

	value = get_base_value()

	caller.to_chat(span("notice","\The [src.name] flashes the coordinates \"<b>[D.x],[D.y],[D.z]</b>\" and \"<b>[D.stored_keypad.code]</b>\" before flickering to dark..."))

	return TRUE
