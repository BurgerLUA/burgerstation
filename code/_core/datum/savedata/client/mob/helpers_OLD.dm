/savedata/client/mob/proc/apply_data_to_mob(var/mob/living/advanced/player/A,var/do_teleport = TRUE,var/update_blends=TRUE)

	//Name
	A.real_name = loaded_data["name"]
	A.sex = loaded_data["sex"]
	A.gender = loaded_data["gender"]
	A.currency = loaded_data["currency"]
	A.species = loaded_data["species"]
	A.nutrition = loaded_data["nutrition"] ? loaded_data["nutrition"] : 1000
	A.hydration = loaded_data["hydration"] ? loaded_data["hydration"] : 1000

	LOG_DEBUG("[owner] is loading their character [A.real_name].")

	if(loaded_data["known_languages"])
		A.known_languages |= loaded_data["known_languages"]

	if(loaded_data["last_saved_date"] && loaded_data["last_saved_date"] != get_date())
		A.to_chat(span("notice","<h2>You are rewarded 2000 credits for logging in with this character today! Make sure to log in tomorrow to receive this reward again.</h2>"))
		A.adjust_currency(2000)

	//Organs
	for(var/id in loaded_data["organs"]) //This does not use load_and_create object as organs are special
		var/o_type = loaded_data["organs"][id]["type"]
		var/obj/item/organ/O = A.add_organ(o_type)
		if(loaded_data["organs"][id]["blend_data"])
			apply_blend_data(O, loaded_data["organs"][id]["blend_data"])
		if(loaded_data["organs"][id]["inventories"])
			for(var/i=1,i<=length(loaded_data["organs"][id]["inventories"]),i++)
				O.set_inventory_data(loaded_data["organs"][id]["inventories"][i])
		O.update_sprite()

	//Skills
	for(var/id in loaded_data["skills"])
		var/experience/skill/S = A.get_skill(id)
		var/xp = ENABLE_XP_SAVING ? loaded_data["skills"][id] : S.level_to_xp(S.chargen_max_level)
		if(S)
			S.Initialize(xp)
		else
			log_error("Warning! Skill of ID \"[id]\" for [A] is invalid!")

	//Attributes
	for(var/id in loaded_data["attributes"])
		var/experience/attribute/S = A.get_attribute(id)
		var/xp = ENABLE_XP_SAVING ? loaded_data["attributes"][id] : S.level_to_xp(S.chargen_max_level)
		if(S)
			S.Initialize(xp)
		else
			log_error("Warning! Attribute of ID \"[id]\" for [A] is invalid!")

	if(do_teleport)
		var/obj/marker/dev/D = locate() in world
		if(D && ENABLE_INSTALOAD)
			A.force_move(get_turf(D))
			A.adjust_currency(10000)
		else
			var/obj/structure/interactive/bed/sleeper/C = length(cryo_spawnpoints) ? pick(cryo_spawnpoints) : pick(backup_spawnpoints)
			A.force_move(get_turf(C))
			C.buckle(A,silent=TRUE)

	if(update_blends)
		A.update_all_blends()
	else
		A.update_all_blends() //butts

	LOG_DEBUG("[owner] is done loading their character [A.get_debug_name()].")

/savedata/client/mob/proc/apply_blend_data(var/obj/O, var/list/blend_data)
	for(var/id in blend_data)
		var/list/blend_list = blend_data[id]
		var/desired_id = value_or_null(blend_list,"id")
		var/desired_icon = value_or_null(blend_list,"icon")
		if(desired_icon)
			desired_icon = file(desired_icon)
		var/desired_icon_state = value_or_null(blend_list,"icon_state")
		var/desired_color = value_or_null(blend_list,"color")
		var/desired_blend = value_or_null(blend_list,"blend")
		var/desired_type = value_or_null(blend_list,"type")
		var/desired_layer = value_or_null(blend_list,"layer")
		O.add_blend(desired_id,desired_icon,desired_icon_state,desired_color,desired_blend,desired_type,TRUE,desired_layer)

/savedata/client/mob/proc/save_current_character(var/save_inventory = TRUE,var/force=FALSE)

	if(!owner)
		log_error("FATAL ERROR: Could not save a character because there was no owner attached! Usr: [usr].")
		return FALSE
	if(!owner.save_slot)
		owner.to_chat(span("danger","<h2>Save failed. Please contact the server owner with error code: 2.</h2>"))
		return FALSE
	if(!owner.mob)
		owner.to_chat(span("danger","<h2>Save failed. Please contact the server owner with error code: 3.</h2>"))
		return FALSE
	if(!is_advanced(owner.mob))
		owner.to_chat(span("danger","<h2>Save failed. Please contact the server owner with error code: 4.</h2>"))
		return FALSE
	if(!force && world_state != STATE_RUNNING)
		owner.to_chat(span("danger","<h2>Save failed. Please contact the server owner with error code: 5.</h2>"))
		return FALSE

	var/mob/living/advanced/player/A = owner.mob

	LOG_DEBUG("[owner] is saving their character [A.get_debug_name()]...")

	//Basic Information
	loaded_data["name"] = A.real_name
	loaded_data["id"] = owner.save_slot
	loaded_data["currency"] = A.currency
	loaded_data["species"] = A.species
	loaded_data["gender"] = A.gender
	loaded_data["sex"] = A.sex
	loaded_data["nutrition"] = A.nutrition
	loaded_data["hydration"] = A.hydration
	loaded_data["known_languages"] = A.known_languages

	var/final_organ_list = list()
	for(var/id in A.labeled_organs)
		var/obj/item/organ/O = A.labeled_organs[id]
		final_organ_list[id] = O.get_item_data(save_inventory)

	loaded_data["organs"] = final_organ_list

	//Skills
	var/list/final_skill_list = list()
	for(var/id in A.skills)
		var/experience/skill/S = A.skills[id]
		var/desired_experience = ENABLE_XP_SAVING ? S.experience : S.level_to_xp(S.chargen_max_level)
		final_skill_list[id] = desired_experience
	loaded_data["skills"] = final_skill_list

	//Attributes
	var/list/final_attribute_list = list()
	for(var/id in A.attributes)
		var/experience/attribute/B = A.attributes[id]
		var/desired_experience = ENABLE_XP_SAVING ? B.experience : B.level_to_xp(B.chargen_max_level)
		final_attribute_list[id] = desired_experience
	loaded_data["attributes"] = final_attribute_list

	if(write_json_data_to_id(owner.save_slot,loaded_data))
		owner.to_chat(span("notice","Sucessfully saved character [A.name]."))
	else
		owner.to_chat(span("danger","<h2>Save failed. Please contact the server owner with error code: 99.</h2>"))

	LOG_DEBUG("[owner] has finished saving their character [A.get_debug_name()].")