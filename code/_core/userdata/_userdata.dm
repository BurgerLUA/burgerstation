/userdata/
	var/name = "Userdata"
	var/desc = "Data for a user."

	var/client/owner
	var/list/loaded_data = list(
		"name" = "Urist McRobust",
		"tutorial" = 1,
		"id" = "none",
		"last_saved_date" = 0,
		"last_saved_time" = 0,
		"organs" = list(),
		"worn" = list(),
		"held" = list(),
		"skills" = list(),
		"attributes" = list()
	)

/userdata/New(var/client/new_owner)
	owner = new_owner

	if(check_if_no_characters())
		owner << "Welcome to Burgerstation 13! Please create a new character in the \"Create Character\" menu to get started. A placeholder character was created and loaded for you if you wish to skip this step."
		loaded_data = load_most_recent_character()
		owner.save_slot = loaded_data["id"]
	else
		loaded_data = load_most_recent_character()
		owner.save_slot = loaded_data["id"]
		owner << "Welcome back to Burgerstation 13! Your last saved character ([loaded_data["name"]]) was loaded."

/userdata/proc/apply_data_to_mob(var/mob/living/advanced/A)

	//Name
	A.name = loaded_data["name"]

	//Organs
	for(var/id in loaded_data["organs"]) //This does not use load_and_create object as organs are special
		var/o_type = loaded_data["organs"][id]["type"]

		var/o_color
		var/o_color_skin
		var/o_style

		if(loaded_data["organs"][id]["color"])
			o_color = loaded_data["organs"][id]["color"]

		if(loaded_data["organs"][id]["color_skin"])
			o_color_skin = loaded_data["organs"][id]["color_skin"]

		if(loaded_data["organs"][id]["style"])
			o_style = loaded_data["organs"][id]["style"]

		var/obj/item/organ/O = A.add_organ(o_type,o_color_skin,o_color,o_style)

		O.update_icon()

	//Skills
	for(var/id in loaded_data["skills"])
		var/xp = loaded_data["skills"][id]
		var/experience/skill/S = A.get_skill(id)
		S.Initialize(xp)

	//Attributes
	for(var/id in loaded_data["attributes"])
		var/xp = loaded_data["attributes"][id]
		var/experience/attribute/S = A.get_attribute(id)
		S.Initialize(xp)

	//Inventory - Worn
	for(var/id in loaded_data["worn"])
		for(var/list_data in loaded_data["worn"][id])
			var/obj/O = load_and_create_object(list_data)
			for(var/obj/inventory/I in A.inventory)
				if(I.id != id)
					continue
				I.add_worn_object(O)

	//Inventory - Held
	for(var/id in loaded_data["held"])
		for(var/list_data in loaded_data["held"][id])
			var/obj/O = load_and_create_object(list_data)
			for(var/obj/inventory/I in A.inventory)
				if(I.id != id)
					continue
				I.add_held_object(O)

	A.update_icon()

/userdata/proc/load_and_create_object(var/list/data,var/loc)

	var/o_type = data["type"]
	var/obj/O = new o_type(loc)

	//General Information
	if(data["color"])
		O.color = data["color"]

	if(is_bullet(O))
		var/obj/item/bullet/B = O
		if(data["bullet_count"])
			B.bullet_count = data["bullet_count"]
		else
			B.bullet_count = 1

	if(is_bullet_gun(O))
		var/obj/item/weapon/ranged/bullet/BG = O
		if(data["stored_magazine"])
			BG.stored_magazine = load_and_create_object(data["stored_magazine"],BG.loc)
		if(data["stored_bullets"])
			for(var/i=1, i <= length(data["stored_bullets"]), i++)
				var/b_type = data["stored_bullets"][i]
				var/obj/item/bullet/B = new b_type(BG.loc)
				B.update_icon()
				BG.stored_bullets += B

	if(is_magazine(O))
		var/obj/item/magazine/M = O
		if(data["stored_bullets"])
			for(var/i=1, i <= length(data["stored_bullets"]), i++)
				var/b_type = data["stored_bullets"][i]
				var/obj/item/bullet/B = new b_type(M.loc)
				B.update_icon()
				M.stored_bullets += B

	O.loc = loc
	O.update_icon()

	return O


/userdata/proc/save_current_character()

	if(!owner)
		return FALSE
	if(!owner.save_slot)
		owner << "Save failed! You don't have a character loaded!"
		return
	if(!owner.mob)
		owner << "Save failed! You aren't controlling a mob!"
		return FALSE
	if(!is_advanced(owner.mob))
		owner << "Save failed! You aren't controlling an advanced mob!"
		return FALSE

	var/mob/living/advanced/A = owner.mob

	//Basic Information
	loaded_data["name"] = owner.mob.name
	loaded_data["id"] = owner.save_slot

	var/list/final_organ_list = list()
	for(var/id in A.labeled_organs)
		var/obj/item/organ/O = A.labeled_organs[id]
		final_organ_list[id] = get_item_data(O)
	loaded_data["organs"] = final_organ_list

	//Inventory stuff
	var/list/final_worn_list = list()
	var/list/final_held_list = list()
	for(var/obj/inventory/I in A.inventory)
		//Held Objects
		if(length(I.held_objects))
			final_held_list[I.id] = list()
			for(var/obj/item/H in I.held_objects)
				final_held_list[I.id] += list((get_item_data(H)))
		//Worn Objects
		if(length(I.worn_objects))
			final_worn_list[I.id] = list()
			for(var/obj/item/W in I.worn_objects)
				final_worn_list[I.id] += list((get_item_data(W)))

	loaded_data["worn"] = final_worn_list
	loaded_data["held"] = final_held_list

	//Skills
	var/list/final_skill_list = list()
	for(var/id in A.skills)
		var/experience/skill/S = A.skills[id]
		final_skill_list[id] = S.experience
	loaded_data["skills"] = final_skill_list

	//Attributes
	var/list/final_attribute_list = list()
	for(var/id in A.attributes)
		var/experience/attribute/B = A.attributes[id]
		final_attribute_list[id] = B.experience
	loaded_data["attributes"] = final_attribute_list

	loaded_data["tutorial"] = 0

	if(write_json_data_to_id(owner.save_slot))
		owner << "Sucessfully saved character [owner.mob.name]."
	else
		owner << "Save failed. Please contact the server owner."

/userdata/proc/get_ckey_path()
	var/returning = replacetext(CKEY_PATH,"%CKEY",owner.ckey)
	return returning

/userdata/proc/get_character_path(var/character_id)
	var/returning = "[CKEY_PATH][DATA_FORMAT]"
	returning = replacetext(returning,"%CKEY",owner.ckey)
	returning = replacetext(returning,"%CID",character_id)
	return returning

/userdata/proc/create_new_character(var/character_id)
	return write_json_data_to_id(character_id)

/userdata/proc/write_json_data_to_id(var/character_id)
	loaded_data["id"] = character_id
	loaded_data["last_saved_date"] = get_date()
	loaded_data["last_saved_time"] = get_time()
	fdel(get_character_path(character_id))
	var/data = json_encode(loaded_data)
	return text2file(data,get_character_path(character_id))

/userdata/proc/load_json_data_from_id(var/character_id)

	var/filename = get_character_path(character_id)
	var/data = file2text(filename)

	if(!data)
		owner << "FATAL ERROR: NO DATA FOUND FOR [filename]"
		return FALSE

	loaded_data = json_decode(data)
	return loaded_data

/userdata/proc/load_json_data_from_file(var/filename)
	var/data = file2text(filename)

	if(!data)
		owner << "FATAL ERROR: NO DATA FOUND FOR [filename]"
		return FALSE


	loaded_data = json_decode(data)
	return loaded_data

/userdata/proc/get_character_files()
	var/list/found_files = flist(get_ckey_path())
	return found_files

/userdata/proc/has_character()
	return length(get_character_files())

/userdata/proc/check_if_no_characters()
	if(has_character())
		return FALSE
	else
		return create_new_character("01")

/userdata/proc/get_next_character_id()

	var/list/file_numbers = list()

	for(var/v in get_character_files())
		file_numbers += text2num(get_proper_id_from_filename(v))

	var/best_number = 0
	for(var/i=1,i<=99,i++)
		if(!(i in file_numbers))
			best_number = i
			break

	if(best_number == 0)
		return FALSE
	else if(best_number < 10)
		return "0[best_number]"
	else
		return "[best_number]"

/userdata/proc/load_most_recent_character()
	var/list/file_paths = get_character_files()

	var/best_date = 0
	var/best_time = 0
	var/list/best_data

	for(var/v in file_paths)
		v = get_proper_id_from_filename(v)
		var/list/loaded_data = load_json_data_from_id(v)
		if(!best_time || time_x_newer_than_y(loaded_data["last_saved_date"],loaded_data["last_saved_time"],best_date,best_time))
			best_time = loaded_data["last_saved_time"]
			best_date = loaded_data["last_saved_date"]
			best_data = loaded_data

	return best_data

/userdata/proc/get_proper_id_from_filepath(var/file_string)
	var/file_name = get_filename(file_string)
	return replacetext(replacetext(file_name,"character_",""),".json","")

/userdata/proc/get_proper_id_from_filename(var/file_string)
	return replacetext(replacetext(file_string,"character_",""),".json","")

/userdata/proc/get_item_data(var/obj/item/I)
	if(!I)
		return list()

	var/list/returning_list = list()
	returning_list["type"] = I.type
	if(I.color && lowertext(I.color) != "#ffffff")
		returning_list["color"] = I.color

	if(is_organ(I))
		var/obj/item/organ/O = I
		if(O.color_skin && lowertext(O.color_skin) != "#ffffff")
			returning_list["color_skin"] = O.color_skin
		if(O.style)
			returning_list["style"] = O.style

	if(is_bullet(I))
		var/obj/item/bullet/B = I
		if(B.bullet_count > 1)
			returning_list["bullet_count"] = B.bullet_count

	if(is_bullet_gun(I))
		var/obj/item/weapon/ranged/bullet/BG = I
		if(BG.stored_magazine)
			returning_list["stored_magazine"] = get_item_data(BG.stored_magazine)
		if(length(BG.stored_bullets))
			returning_list["stored_bullets"] = new/list(length(BG.stored_bullets))
			for(var/i=1,i<=length(BG.stored_bullets),i++)
				var/obj/item/bullet/B = BG.stored_bullets[i]
				returning_list["stored_bullets"][i] = B.type

	if(is_magazine(I))
		var/obj/item/magazine/M = I
		if(length(M.stored_bullets))
			returning_list["stored_bullets"] = new/list(length(M.stored_bullets))
			for(var/i=1,i<=length(M.stored_bullets),i++)
				var/obj/item/bullet/B = M.stored_bullets[i]
				returning_list["stored_bullets"][i] = B.type

	return returning_list