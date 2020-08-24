/mob/living/advanced/player/proc/save(var/mob_data = TRUE, var/inventory_data = TRUE, var/mech_data = TRUE,var/save_inventory = TRUE, var/died = FALSE)
	var/savedata/client/mob/mobdata = MOBDATA(src.ckey_last)
	if(mobdata) mobdata.save_character(src,died = TRUE)
	var/savedata/client/mob/inventorydata = INVENTORYDATA(src.ckey_last)
	if(inventorydata) inventorydata.save_character(src,save_inventory = save_inventory,died = died)
	src.to_chat(span("notice","Your character was successfully saved."))


/mob/living/advanced/player/proc/reset(var/mob_data = TRUE, var/inventory_data = TRUE, var/mech_data = TRUE, var/died = FALSE)
	var/savedata/client/mob/mobdata = MOBDATA(src.ckey_last)
	if(mobdata) mobdata.reset_data()
	var/savedata/client/mob/inventorydata = INVENTORYDATA(src.ckey_last)
	if(inventorydata) inventorydata.reset()