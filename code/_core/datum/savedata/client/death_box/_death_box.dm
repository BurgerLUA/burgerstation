
#define DEATH_BOX_LIMIT 5

/proc/save_deathboxes()

	var/list/savedata/client/death_box/db_data_to_save = list()

	var/list/saved_player_count = list()

	for(var/obj/structure/interactive/grave/G as anything in all_graves)

		for(var/owner_ckey in G.storage_data)

			var/savedata/client/death_box/DB = SSclient.ckey_to_death_box_data[owner_ckey]
			if(!DB)
				log_error("FATAL ERROR: Could not save deathbox belonging to [owner_ckey] as there was no death box data assigned to it!")
				continue

			if(!saved_player_count[owner_ckey])
				saved_player_count[owner_ckey] = 1
			else if(saved_player_count[owner_ckey] > DEATH_BOX_LIMIT)
				continue
			else
				saved_player_count[owner_ckey] += 1

			var/list/data_list = list()
			data_list["death_area"] = "[get_area(G)]"
			data_list["round_id"] = SSlogging.round_id
			data_list["inventory"] = list()
			data_list["value"] = 0

			var/list/storage_holders = G.storage_data[owner_ckey]

			if(!length(storage_holders))
				log_error("FATAL ERROR: Did not find any storage holders in [G.get_debug_name()] for [owner_ckey]!")
				continue

			for(var/obj/item/structure_storage/holder as anything in storage_holders)

				if(!length(holder.inventories))
					log_error("FATAL ERROR: Did not find any inventories inside a storage holder in [G.get_debug_name()] for [owner_ckey]!")
					continue

				for(var/obj/hud/inventory/INV as anything in holder.inventories)
					if(!length(INV.contents))
						continue

					var/list/found_inventory_data = INV.save_inventory_data(null)
					if(!length(found_inventory_data))
						log_error("FATAL ERROR: An inventory slot did not return any valid inventory data for [owner_ckey] despite having contents in inventory!")
						continue

					data_list["inventory"] += found_inventory_data
					CHECK_TICK_HARD

				if(length(data_list["inventory"]))

					data_list["value"] += holder.get_value()

					if(data_list["value"] <= 0)
						continue

					data_list["value"] = CEILING(data_list["value"]*0.25,1)

					data_list["value"] += 1000 //The fee
					DB.loaded_data += list(data_list)
					db_data_to_save |= DB


				CHECK_TICK_HARD

			CHECK_TICK_HARD

	log_debug("Saving [length(db_data_to_save)] death box instances.")

	for(var/k in db_data_to_save)
		var/savedata/client/death_box/DB = k
		DB.save()
		CHECK_TICK_HARD

/proc/load_deathbox(var/mob/living/advanced/player/P,var/atom/A)

	if(!P || P.dead || P.qdeleting)
		P?.to_chat(span("warning","You can't do this while dead!"))
		return null

	if(A && get_dist(A,P) > 3)
		P.to_chat(span("warning","You're too far away!"))
		return null

	var/savedata/client/death_box/DB = SSclient.ckey_to_death_box_data[P.ckey_last]

	if(!DB)
		P.to_chat(span("danger","Deathbox Data error detected. Report this bug on discord."))
		return null

	if(!length(DB.loaded_data))
		P.to_chat(span("warning","You don't have any deathboxes to purchase!"))
		return null

	var/list/valid_choices = list()
	var/list/instance_list = list()

	var/instance = 1
	for(var/k in DB.loaded_data)
		var/list/DI = k //death_instance
		var/final_string = "#[instance]: [DI["death_area"]], Round ID: [DI["round_id"]], [DI["value"]] credits"
		valid_choices[final_string] = DI
		instance_list[final_string] = instance
		instance++

	valid_choices["Cancel"] = "Cancel"

	var/selection = input("What deathbox do you wish for the Goblins to retrieve?","Goblin Retrival","Cancel") as null|anything in valid_choices
	if(!selection || selection == "Cancel")
		P.to_chat(span("notice","You decide not to purchase any deathboxes."))
		return null

	if(!P || P.dead || P.qdeleting)
		P?.to_chat(span("warning","You can't do this while dead!"))
		return null

	if(A && get_dist(A,P) > 3)
		P.to_chat(span("warning","You're too far away!"))
		return null

	var/confirmation = input("Are you sure you want to load [selection]? You will be charged [valid_choices[selection]["value"]] credits for this purchase.") as null|anything in list("Yes","No","Cancel")
	if(!confirmation || confirmation != "Yes")
		P.to_chat(span("notice","You decide not to purchase any deathboxes."))
		return null

	if(!P || P.dead || P.qdeleting)
		P?.to_chat(span("warning","You can't do this while dead!"))
		return null

	if(A && get_dist(A,P) > 3)
		P.to_chat(span("warning","You're too far away!"))
		return null

	if(!P.adjust_currency(-text2num(valid_choices[selection]["value"])))
		P.to_chat(span("danger","You don't have enough credits to make this purchase!"))
		return null

	var/turf/T = get_turf(P)
	var/obj/item/storage/death_box/created_box = new(T)
	created_box.owning_mob_name = valid_choices[selection]["name"]
	created_box.owning_mob_ckey = P.ckey_last
	INITIALIZE(created_box)

	for(var/i=1,i<=length(valid_choices[selection]["inventory"]),i++)
		var/list/k = valid_choices[selection]["inventory"][i]
		var/obj/item/I = load_and_create(P,k,T)
		if(I) created_box.add_object_to_src_inventory(null,I,FALSE,TRUE,silent=TRUE)
	FINALIZE(created_box)

	P.put_in_hands(created_box)

	DB.loaded_data.Cut(instance_list[selection],instance_list[selection]+1)

	DB.save()

	P.to_chat(span("notice","You purchase a deathbox."))

	return created_box

/savedata/client/death_box
	loaded_data = list()

/savedata/client/death_box/get_file(var/file_id)
	return "death_box.json"

/savedata/client/death_box/New(var/desired_ckey)

	. = ..()

	load()

	var/client/owner = CLIENT(ckey)
	if(owner)
		SSclient.ckey_to_death_box_data[ckey] = src

/savedata/client/death_box/proc/save()
	var/client/owner = CLIENT(ckey)
	var/full_path = "[get_folder()][get_file()]"
	var/length_of_data = length(loaded_data)
	if(length_of_data > 5)
		loaded_data.Cut(1,length_of_data - (DEATH_BOX_LIMIT-1))
	rustg_file_write(json_encode(loaded_data),full_path)
	owner?.to_chat(span("notice","Your deathbox data has been saved."))
	return TRUE

/savedata/client/death_box/proc/load()
	var/full_path = "[get_folder()][get_file()]"
	if(!fexists(full_path))
		rustg_file_write(json_encode(loaded_data),full_path)
	else
		loaded_data = json_decode(rustg_file_read(full_path))
	return TRUE