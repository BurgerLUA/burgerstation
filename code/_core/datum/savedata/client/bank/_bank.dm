var/global/list/ckey_to_bank_data = list()
var/global/list/ckey_to_bank_storage = list()

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

/proc/save_banks()

	var/banks_saved = 0

	for(var/k in ckey_to_bank_data)
		CHECK_TICK_HARD
		var/savedata/client/bank/D = ckey_to_bank_data[k]
		var/obj/item/bank_storage/BS = ckey_to_bank_storage[k]
		if(!BS)
			//No need to save since it's been unchanged.
			continue
		D.loaded_data = BS.save_item_data(null) //Don't check for player because its not needed.
		D.save()
		banks_saved++

	log_debug("Saved [banks_saved] banks.")