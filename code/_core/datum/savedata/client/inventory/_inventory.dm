var/global/list/ckey_to_inventorydata = list()

/savedata/client/inventory
	var/mob/living/advanced/player/attached_mob

/savedata/client/inventory/Destroy()
	CRASH_SAFE("FATAL WARNING: SAVEDATA ATTEMPTED TO BE DESTROYED! SAVEDATA SHOULD NEVER BE DESTROYED!")
	return ..()

/savedata/client/inventory/get_folder(var/folder_id)
	. = replacetext(CHARACTER_PATH_FORMAT,"%CKEY",folder_id)
	return

/savedata/client/inventory/reset_data()
	loaded_data = list()
	return TRUE

/savedata/client/inventory/New(var/desired_ckey)
	..()
	reset_data()
	var/client/owner = CLIENT(ckey)
	if(owner)
		ckey_to_inventorydata[ckey] = src

/savedata/client/inventory/get_file(var/file_id)
	var/returning = "[get_folder(ckey)][INVENTORY_FILE_FORMAT]"
	returning = replacetext(returning,"%CKEY",bot_controlled ? "BOT" : ckey)
	returning = replacetext(returning,"%CID",file_id)
	return returning
