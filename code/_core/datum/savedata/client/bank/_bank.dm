var/global/list/ckey_to_bank_data = list()
var/global/list/ckey_to_bank_storage = list()

/proc/save_banks()

	var/banks_saved = 0

	for(var/k in ckey_to_bank_data)
		sleep(-1)
		var/savedata/client/bank/D = ckey_to_bank_data[k]
		var/obj/item/bank_storage/BS = ckey_to_bank_storage[k]
		if(!BS)
			//No need to save since it's been unchanged.
			continue
		D.loaded_data = BS.save_item_data(TRUE)
		D.save()
		banks_saved++

	log_debug("Saved [banks_saved] banks.")


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


/savedata/client/bank
	loaded_data = list()

/savedata/client/bank/get_file(var/file_id)
	return "bank.json"

/savedata/client/bank/New(var/desired_ckey)

	. = ..()

	load()

	var/client/owner = CLIENT(ckey)
	if(owner)
		ckey_to_bank_data[ckey] = src

/savedata/client/bank/proc/save()
	var/client/owner = CLIENT(ckey)
	var/full_path = "[get_folder(ckey)][get_file()]"
	rustg_file_write(json_encode(loaded_data),full_path)
	owner?.to_chat(span("notice","Your bank data has been saved."))
	return TRUE

/savedata/client/bank/proc/load()
	var/full_path = "[get_folder(ckey)][get_file()]"
	if(!fexists(full_path))
		rustg_file_write(json_encode(loaded_data),full_path)
	else
		loaded_data = json_decode(rustg_file_read(full_path))
	return TRUE