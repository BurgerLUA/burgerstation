/mob/living/advanced/player/proc/set_mob_data(var/list/loaded_data,var/do_teleport = TRUE,var/update_blends=TRUE)

	//Name
	real_name = loaded_data["name"]
	sex = loaded_data["sex"]
	gender = loaded_data["gender"]
	currency = loaded_data["currency"]
	species = loaded_data["species"]
	nutrition = loaded_data["nutrition"] ? loaded_data["nutrition"] : 1000
	hydration = loaded_data["hydration"] ? loaded_data["hydration"] : 1000
	save_id = loaded_data["id"]

	if(loaded_data["known_languages"])
		known_languages |= loaded_data["known_languages"]

	if(loaded_data["last_saved_date"] && loaded_data["last_saved_date"] != get_date())
		to_chat(span("notice","<h2>You are rewarded 2000 credits for logging in with this character today! Make sure to log in tomorrow to receive this reward again.</h2>"))
		adjust_currency(2000)

	/*
	for(var/id in loaded_data["organs"])
		var/obj/item/organ/O = load_and_create(src,loaded_data["organs"][id],src,FALSE)
		attach_organ(O,FALSE)
		O.update_sprite()
	*/

	for(var/id in loaded_data["organs"]) //This does not use load_and_create object as organs are special. TODO: IT SHOULD THOUGH.
		var/o_type = loaded_data["organs"][id]["type"]
		var/obj/item/organ/O = add_organ(o_type)
		if(!O)
			log_error("Invalid Organ: [o_type].")
			continue
		if(loaded_data["organs"][id]["blend_data"])
			O.set_blend_data(loaded_data["organs"][id]["blend_data"])
		if(loaded_data["organs"][id]["inventories"])
			for(var/i=1,i<=length(loaded_data["organs"][id]["inventories"]),i++)
				var/obj/hud/inventory/I = O.inventories[i]
				I.set_inventory_data(src,loaded_data["organs"][id]["inventories"][i])
		O.update_sprite()

	//Skills
	for(var/id in loaded_data["skills"])
		var/experience/skill/S = get_skill(id)
		var/xp = ENABLE_XP_SAVING ? loaded_data["skills"][id] : S.level_to_xp(S.chargen_max_level)
		if(S)
			S.Initialize(xp)
		else
			log_error("Warning! Skill of ID \"[id]\" for [src] is invalid!")

	//Attributes
	for(var/id in loaded_data["attributes"])
		var/experience/attribute/S = get_attribute(id)
		var/xp = ENABLE_XP_SAVING ? loaded_data["attributes"][id] : S.level_to_xp(S.chargen_max_level)
		if(S)
			S.Initialize(xp)
		else
			log_error("Warning! Attribute of ID \"[id]\" for [src] is invalid!")

	if(do_teleport)
		var/obj/marker/dev/D = locate() in world
		if(D && ENABLE_INSTALOAD)
			force_move(get_turf(D))
			adjust_currency(10000)
		else
			var/obj/structure/interactive/bed/sleeper/C = length(cryo_spawnpoints) ? pick(cryo_spawnpoints) : pick(backup_spawnpoints)
			force_move(get_turf(C))
			C.buckle(src,silent=TRUE)

	if(update_blends)
		update_all_blends()
	else
		update_all_blends() //butts

/mob/living/advanced/player/proc/get_mob_data(var/save_inventory = TRUE,var/force=FALSE)

	. = list()

	//Basic Information
	.["name"] = real_name
	.["currency"] = currency
	.["species"] = species
	.["gender"] = gender
	.["sex"] = sex
	.["nutrition"] = nutrition
	.["hydration"] = hydration
	.["known_languages"] = known_languages
	.["id"] = save_id

	var/final_organ_list = list()
	for(var/id in labeled_organs)
		var/obj/item/organ/O = labeled_organs[id]
		final_organ_list[id] = O.save_item_data(save_inventory)
	.["organs"] = final_organ_list

	//Skills
	var/list/final_skill_list = list()
	for(var/id in skills)
		var/experience/skill/S = skills[id]
		var/desired_experience = ENABLE_XP_SAVING ? S.experience : S.level_to_xp(S.chargen_max_level)
		final_skill_list[id] = desired_experience
	.["skills"] = final_skill_list

	//Attributes
	var/list/final_attribute_list = list()
	for(var/id in attributes)
		var/experience/attribute/B = attributes[id]
		var/desired_experience = ENABLE_XP_SAVING ? B.experience : B.level_to_xp(B.chargen_max_level)
		final_attribute_list[id] = desired_experience
	.["attributes"] = final_attribute_list