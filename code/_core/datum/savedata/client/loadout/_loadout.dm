#define LOADOUT_LIMIT 5

var/global/list/ckey_to_loadout_data = list()
var/global/list/ckey_to_loadout_cooldown = list()

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

	if(!P.ckey || !name)
		return FALSE

	if(length(ckey_to_loadout_cooldown) && ckey_to_loadout_cooldown[P.ckey] > world.time)
		P.to_chat(span("warning","Please wait [CEILING(DECISECONDS_TO_SECONDS(ckey_to_loadout_cooldown[P.ckey] - world.time),1)] more seconds before saving another loadout!"))
		return FALSE

	var/list/objects_to_check = P.worn_objects.Copy()
	sortTim(objects_to_check,/proc/cmp_worn_layer_hybrid_asc)
	objects_to_check += P.held_objects

	var/list/final_data_list = list()
	var/final_cost = 0
	for(var/k in objects_to_check)
		var/obj/item/I = k
		var/list/generated_list = I.save_item_data(P)
		if(is_inventory(I.loc))
			var/obj/hud/inventory/I2 = I.loc
			generated_list["original_slot"] = I2.id
		final_data_list += list(generated_list)
		final_cost += I.get_value()

	var/savedata/client/loadout/L = ckey_to_loadout_data[P.ckey]

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

	L.save()
	ckey_to_loadout_cooldown[P.ckey] = world.time + SECONDS_TO_DECISECONDS(10)

	return TRUE


/proc/apply_loadout_to_mob(var/mob/living/advanced/player/P,var/name="Default")

	if(!P || !P.ckey || !name)
		return FALSE

	if(length(ckey_to_loadout_cooldown) && ckey_to_loadout_cooldown[P.ckey] > world.time)
		P.to_chat(span("warning","Please wait [CEILING(DECISECONDS_TO_SECONDS(ckey_to_loadout_cooldown[P.ckey] - world.time),1)] more seconds before purchasing another loadout!"))
		return FALSE

	var/savedata/client/loadout/L = ckey_to_loadout_data[P.ckey]
	var/list/found_data = L.loaded_data[name]

	if(!found_data)
		CRASH("Tried loading a player-made loadout ([name]) that didn't exist!")

	if(found_data["cost"] > P.currency)
		P.to_chat(span("warning","You don't have enough credits to purchase this loadout!"))
		return FALSE

	var/turf/T = get_turf(P)
	var/total_value = 0
	for(var/data in found_data["loadout"])
		var/obj/item/I = load_and_create(P,data,T,TRUE)
		if(!I)
			P.to_chat(span("danger","Could not load item of type [data["type"]] as it doesn't exist anymore!"))
			continue
		var/obj/hud/inventory/I2 = data["original_slot"] ? P.inventories_by_id[data["original_slot"]] : null
		var/success = I2 ? I2.add_object(I,messages=FALSE,silent=TRUE) : I.quick_equip(P,silent=TRUE)
		if(success)
			total_value += I.get_value()
		else
			P.to_chat(span("warning","\The [I.name] could not be equipped. You will not be charged for this item."))
			qdel(I)

	P.to_chat(span("notice","You were charged [P.adjust_currency(-total_value)] credits for this loadout."))
	ckey_to_loadout_cooldown[P.ckey] = world.time + SECONDS_TO_DECISECONDS(10)

	return TRUE



