/mob/living/advanced/player/proc/close_bank()
	var/obj/item/bank_storage/BS = ckey_to_bank_storage[ckey_last]
	BS.close_inventory(src)

/mob/living/advanced/player/proc/access_bank()

	if(!ckey_last)
		return FALSE

	var/turf/T = get_turf(src)

	if(!T)
		return FALSE

	var/obj/item/bank_storage/BS

	if(!ckey_to_bank_storage[ckey_last])
		var/list/object_data
		if(ckey_to_bank_data[ckey_last])
			var/savedata/client/bank/BD = ckey_to_bank_data[ckey_last]
			object_data = BD.loaded_data

		BS = new(T)
		BS.owner = ckey_last
		if(object_data) BS.load_item_data_pre(src,object_data)
		INITIALIZE(BS)
		if(object_data) BS.load_item_data_post(src,object_data)
		FINALIZE(BS)
		if(!object_data)
			GENERATE(BS)
		ckey_to_bank_storage[ckey_last] = BS
	else
		BS = ckey_to_bank_storage[ckey_last]

	BS.force_move(T)
	BS.open_inventory(src)

	//HOOK_ADD("post_move","\ref[BS]_bank_post_move",src,src,.proc/close_bank)