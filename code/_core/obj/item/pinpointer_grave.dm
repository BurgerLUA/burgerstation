/obj/item/pinpointer/grave
	name = "grave pinpointer"
	desc_extended = "Use this to track and locate objects. This one tracks gravestones which you died at."
	icon_state = "orange"

	value = 100

/obj/item/pinpointer/grave/click_self(var/mob/activator,location,control,params)

	INTERACT_CHECK
	INTERACT_DELAY(1)

	if(!is_player(activator))
		return TRUE

	var/mob/living/advanced/player/P = activator

	if(!P.ckey)
		return TRUE

	var/list/possible_graves = list()

	var/string_check = "[P.ckey]"

	for(var/obj/structure/interactive/grave/G as anything in all_graves)
		if(!length(G.storage_data))
			continue
		var/list/storage_grouping = G.storage_data[string_check]
		if(!storage_grouping || !length(storage_grouping))
			continue
		if(!can_track(G))
			continue
		var/total_items = 0
		for(var/obj/item/structure_storage/found_storage as anything in storage_grouping)
			if(!length(found_storage.inventories))
				continue
			total_items += length(found_storage.inventories)
		var/name_mod = "gravestone containing [total_items] items ([dir2text(get_dir_advanced(activator,G))], [get_dist_advanced(src,G)]m)"
		possible_graves[name_mod] = G

	if(!length(possible_graves))
		activator.to_chat(span("warning","Can't find anything to track!"))
		return TRUE

	scan_mode = TRUE
	update_sprite()

	var/choice = input("What do you want to track?","Objective Pinpointer Tracking","Cancel") as null|anything in possible_graves

	INTERACT_CHECK_OTHER(src) //Hacky.

	if(choice)
		var/atom/A = possible_graves[choice]
		tracked_atom = A
	else
		tracked_atom = null

	scan_mode = FALSE
	START_THINKING(src)

	return TRUE