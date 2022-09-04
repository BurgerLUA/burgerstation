var/global/list/all_vault_doors = list()

//5 to 11 random syndicate vaults are placed on the map.
//The laptop can give you access to it by giving you the coords of the vault as well as the keyphrase.


/obj/item/data_laptop
	name = "classified data laptop"
	desc = "Top secret!"
	desc_extended = "A laptop containing classified locational data on secret storage areas. Once opened, coordinates will be shown to the user and then be wiped of all data!"

	icon = 'icons/obj/item/data_laptop.dmi'
	icon_state = "closed"

	var/used = FALSE

	value = 500

	contraband = TRUE


/obj/item/data_laptop/get_base_value()
	return used ? 100 : 1000

/obj/item/data_laptop/update_icon()

	. = ..()

	icon_state = initial(icon_state)

	if(used)
		icon_state = "useless"

/obj/item/data_laptop/Finalize()
	. = ..()
	update_sprite()

/obj/item/data_laptop/click_self(var/mob/caller)

	INTERACT_CHECK
	INTERACT_DELAY(10)

	if(used)
		caller.to_chat(span("warning","Nothing happens..."))
		update_sprite()
		return TRUE

	var/obj/structure/interactive/door/airlock/A = pick(all_vault_doors)
	all_vault_doors -= A

	used = TRUE
	update_value()
	update_sprite()
	flick("open",src)

	caller.to_chat(span("notice","\The [src.name] flashes the coordinates \"<b>[A.x],[A.y],[A.z]</b>\" before flickering to dark..."))

	return TRUE
