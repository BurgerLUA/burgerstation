#define LOADOUT_LIMIT 10

var/global/list/ckey_to_loadout_data = list()

/savedata/client/loadout
	loaded_data = list()

/savedata/client/loadout/get_file(var/file_id)
	return "loadout.json"


/savedata/client/loadout/New(var/desired_ckey)

	. = ..()

	load()

	var/client/owner = CLIENT(ckey)
	if(owner)
		ckey_to_loadout_data[ckey] = src


/savedata/client/loadout/proc/save()
	var/client/owner = CLIENT(ckey)
	var/full_path = "[get_folder(ckey)][get_file()]"
	rustg_file_write(json_encode(loaded_data),full_path)
	owner?.to_chat(span("notice","Your loadout data has been saved."))
	return TRUE

/savedata/client/loadout/proc/load()
	var/full_path = "[get_folder(ckey)][get_file()]"
	if(!fexists(full_path))
		rustg_file_write(json_encode(loaded_data),full_path)
	else
		loaded_data = json_decode(rustg_file_read(full_path))
	return TRUE


/proc/save_loadout_of_mob(var/mob/living/advanced/player/P,var/name="Default")

	if(!P.ckey_last || !name)
		return FALSE

	var/list/objects_to_check = P.worn_objects.Copy()
	sortTim(objects_to_check,/proc/cmp_worn_layer_hybrid_asc)
	objects_to_check += P.held_objects

	var/list/final_data_list = list()
	var/final_cost = 0
	for(var/k in objects_to_check)
		var/obj/item/I = objects_to_check[k]
		var/generated_list = I.save_item_data(P)
		if(is_inventory(I.loc))
			var/obj/hud/inventory/I2 = I.loc
			generated_list["original_slot"] = I2.id
		final_data_list += generated_list
		final_cost += I.get_value()

	var/savedata/client/loadout/L = ckey_to_loadout_data[P.ckey_last]

	if(length(L.loaded_data) && L.loaded_data[name])
		if(usr != P)
			return FALSE
		var/choice = input("There already exists a loadout named [name]. Do you wish to overwrite?","Overwrite Loadout Data") as null|anything in list("Yes","No","Cancel")
		if(choice != "Yes")
			return FALSE

	L.loaded_data[name] = list(
		"name" = name,
		"date" = get_date(),
		"time" = get_time(),
		"loadout" = final_data_list,
		"cost" = final_cost
	)

	P.to_chat(span("notice","Successfully saved loadout [name]."))

	return TRUE


/proc/apply_loadout_to_mob(var/mob/living/advanced/player/P,var/name="Default")

	if(!P.ckey_last || !name)
		return FALSE

	var/savedata/client/loadout/L = ckey_to_loadout_data[P.ckey_last]
	var/list/found_data = L.loaded_data[name]
	if(!found_data)
		return FALSE

	var/turf/T = get_turf(src)
	var/total_value = 0
	for(var/k in found_data["loadout"])
		var/list/data = k
		var/obj/item/I = load_and_create(P,data,T,TRUE)
		var/obj/hud/inventory/I2 = data["original_slot"] ? P.inventories_by_id[data["original_slot"]] : null
		if(I2)
			I2.add_object(I,messages=FALSE,silent=TRUE)
		else
			I.quick_equip(P,silent=TRUE)
		total_value += I.get_value()


	return TRUE



