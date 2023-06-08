/mob/living/advanced/player/proc/update_premiums(var/messages=TRUE)
	var/desired_premium_amount
	switch(insurance/INSURANCE_PAYOUT) //How many payouts left?
		if(0 to 0.5)
			desired_premium_amount = 0.2
		if(0.5 to 1)
			desired_premium_amount = 0.1
		if(1 to 2)
			desired_premium_amount = 0.05
		if(2 to 3)
			desired_premium_amount = 0.03
		if(3 to 4)
			desired_premium_amount = 0.01
		if(4 to INFINITY)
			desired_premium_amount = 0
	if(desired_premium_amount > insurance_premiums)
		if(messages) to_chat(span("warning","Your insurance premiums have increased from <b>[insurance_premiums*100]%</b> to <b>[desired_premium_amount*100]%</b>..."))
		insurance_premiums = desired_premium_amount
	else if (desired_premium_amount < insurance_premiums)
		if(messages) to_chat(span("notice","Your insurance premiums have decreased from <b>[insurance_premiums*100]%</b> to <b>[desired_premium_amount*100]%</b>!"))
		insurance_premiums = desired_premium_amount

/mob/living/advanced/player/proc/set_mob_data(var/list/loaded_data,var/appearance_only=FALSE)

	//Name
	real_name = police_text(client,loaded_data["name"],check_name=TRUE,check_characters=TRUE,min_length=2,max_length=40)
	if(!real_name)
		real_name = "[gender == MALE ? FIRST_NAME_MALE : FIRST_NAME_FEMALE] [LAST_NAME]"

	unique_pid = loaded_data["unique_pid"]
	if(!unique_pid)
		unique_pid = md5("[ckey_last]_[real_name]_[get_date()]_[get_time()]_[world.time]") //I will be made fun of for making this absurdly detailed.

	sex = loaded_data["sex"]
	rarity = loaded_data["rarity"] ? loaded_data["rarity"] : RARITY_COMMON
	gender = loaded_data["gender"]
	species = loaded_data["species"] ? loaded_data["species"] : "human"
	blood_type = loaded_data["blood_type"] ? text2path(loaded_data["blood_type"]) : /reagent/blood //This should generate a new blood type.
	difficulty = loaded_data["difficulty"] ? loaded_data["difficulty"] : DIFFICULTY_NORMAL

	// setup_difficulty() does not need to be called here as it is called in Finalize()

	if(!loaded_data["known_topics"])
		loaded_data["known_topics"] = list()

	if(!appearance_only)
		save_id = loaded_data["id"]
		currency = loaded_data["currency"]
		revenue = loaded_data["revenue"] ? loaded_data["revenue"] : 0
		expenses = loaded_data["expenses"] ? loaded_data["expenses"] : 0
		partial_tax = loaded_data["partial_tax"] ? loaded_data["partial_tax"] : 0
		last_tax_payment = loaded_data["last_tax_payment"] > 0 ? loaded_data["last_tax_payment"] : world.realtime
		insurance = isnum(loaded_data["insurance"]) ? loaded_data["insurance"] : INSURANCE_PAYOUT * 4
		insurance_premiums = isnum(loaded_data["insurance_premiums"]) ? loaded_data["insurance_premiums"] : 5
		nutrition = isnum(loaded_data["nutrition"]) ? loaded_data["nutrition"] : initial(nutrition)*0.5
		hydration = isnum(loaded_data["hydration"]) ? loaded_data["hydration"] : initial(hydration)*0.5
		nutrition_fast = isnum(loaded_data["nutrition_fast"]) ? loaded_data["nutrition_fast"] : 0
		nutrition_quality = isnum(loaded_data["nutrition_quality"]) ? loaded_data["nutrition_quality"] : initial(nutrition_quality)
		job = loaded_data["job"] ? text2path(loaded_data["job"]) : null
		job_rank = loaded_data["job_rank"] ? loaded_data["job_rank"] : 1
		job_next_promotion = loaded_data["job_next_promotion"] ? loaded_data["job_next_promotion"] : 0

		if(loaded_data["last_saved_date"] && loaded_data["last_saved_date"] != get_date())
			to_chat(span("notice","<h2>You are rewarded 1000 credits for logging in with this character today! Make sure to log in tomorrow to receive this reward again.</h2>"))
			adjust_currency(1000)

		if(loaded_data["prestige_count"])
			prestige_count =  loaded_data["prestige_count"]

		if(loaded_data["dead"]) //New body!
			nutrition = initial(nutrition)*0.25
			nutrition_fast = nutrition
			hydration = initial(hydration)*0.5
			nutrition_quality = nutrition_quality_max*0.5
			var/currency_to_give = 0
			if(isnum(insurance))
				var/insurance_to_pay = clamp(insurance,0,INSURANCE_PAYOUT)
				insurance -= insurance_to_pay
				to_chat(span("notice","You were paid <b>[insurance_to_pay] credits</b> in insurance. You have <b>[insurance] credits</b> left in your insurance pool."))
				currency_to_give = insurance_to_pay
				update_premiums()
			if(currency >= 10000)
				var/death_tax = FLOOR(currency*0.1,1)
				if(death_tax)
					currency_to_give -= death_tax
					to_chat(span("warning","You paid [death_tax] credits in cloning fees."))
			if(currency_to_give)
				adjust_currency(currency_to_give)

		//Skills
		for(var/id in loaded_data["skills"])
			var/experience/skill/S = get_skill(id,FALSE)
			if(S)
				var/xp = ENABLE_XP_SAVING ? loaded_data["skills"][id] : S.level_to_xp(S.chargen_max_level)
				S.update_experience(xp)

		//Attributes
		for(var/id in loaded_data["attributes"])
			var/experience/attribute/S = get_attribute(id,FALSE)
			if(S)
				var/xp = ENABLE_XP_SAVING ? loaded_data["attributes"][id] : S.level_to_xp(S.chargen_max_level)
				S.update_experience(xp)

		//Abilities
		var/ability_length = min(length(ability_buttons),length(loaded_data["abilities"]))

		for(var/i=1,i<=ability_length,i++)
			var/b_index = ability_buttons[i]
			var/obj/hud/button/ability/B = ability_buttons[b_index]
			if(loaded_data["abilities"][i])
				var/ability_type = text2path(loaded_data["abilities"][i])
				if(ability_type)
					B.ability = new ability_type
					B.update_sprite()

		//Quests
		for(var/k in loaded_data["quests"])
			src.add_quest(k,loaded_data["quests"][k])




	if(loaded_data["known_languages"])
		known_languages |= loaded_data["known_languages"]

	for(var/id in loaded_data["organs"])
		if(!loaded_data["organs"][id])
			log_error("WARNING: Incomplete organ data for [src.get_debug_name()]: [id]!")
			continue
		var/o_type = loaded_data["organs"][id]["type"]
		if(appearance_only && ispath(o_type,/obj/item/organ/internal/implant))
			continue
		var/obj/item/organ/O = add_organ(o_type)
		if(!O)
			log_error("WARNING: Invalid Organ for [src.get_debug_name()]: [o_type]!")
			continue
		if(loaded_data["organs"][id]["blend_data"])
			O.set_blend_data(loaded_data["organs"][id]["blend_data"])
		if(!appearance_only)
			if(loaded_data["organs"][id]["inventories"])
				for(var/i=1,i<=length(loaded_data["organs"][id]["inventories"]),i++)
					var/obj/hud/inventory/I = O.inventories[i]
					I.load_inventory_data(src,loaded_data["organs"][id]["inventories"][i])
		O.update_sprite()

	//Organ checking
	var/species/S = SPECIES(species)
	if(!S)
		log_error("ERROR: INVALID SPECIES: [species]!")
		species = "human"
		S = SPECIES(species)

	var/list/organ_list_to_use = list()
	if(S.genderless || sex == MALE)
		organ_list_to_use = S.spawning_organs_male
	else
		organ_list_to_use = S.spawning_organs_female
	var/list/missing_organs = list()
	for(var/organ_id in organ_list_to_use)
		if(labeled_organs[organ_id])
			continue
		missing_organs += organ_list_to_use[organ_id]
	if(length(missing_organs))
		log_error("WARNING: [src.get_debug_name()] had [length(missing_organs)] missing organs ([english_list(missing_organs)]) when loading!")
		var/list/blend_data = list()
		if(labeled_organs[BODY_TORSO])
			var/obj/item/organ/O = labeled_organs[BODY_TORSO]
			blend_data = O.get_blend_data()
		for(var/o_path in missing_organs)
			var/obj/item/organ/O = add_organ(o_path)
			if(length(blend_data))
				if(O.enable_skin && blend_data["skin"])
					O.add_blend("skin", desired_color = blend_data["skin"]["color"])
				if(O.enable_skin && blend_data["skin_glow"])
					O.add_blend("skin_glow", desired_color = blend_data["skin_glow"]["color"])
				if(O.enable_skin && blend_data["skin_detail"])
					O.add_blend("skin_detail", desired_color = blend_data["skin_detail"]["color"])
			O.update_sprite()

	if(!labeled_organs["implant_hand_left"])
		add_organ(/obj/item/organ/internal/implant/hand/left/iff/nanotrasen)
	if(!labeled_organs["implant_head"])
		add_organ(/obj/item/organ/internal/implant/head/loyalty/nanotrasen)

	health?.update_health_stats()

	last_autosave = world.time

	check_promotion()

	if(!appearance_only)
		default_nanotrasen_move()

/mob/living/advanced/player/proc/get_mob_data(var/save_inventory = TRUE,var/died=FALSE)

	. = list()

	//Basic Information
	.["unique_pid"] = unique_pid
	.["name"] = real_name
	.["currency"] = currency
	.["insurance"] = insurance
	.["insurance_premiums"] = insurance_premiums
	.["species"] = species
	.["gender"] = gender
	.["sex"] = sex
	.["nutrition"] = nutrition
	.["hydration"] = hydration
	.["nutrition_quality"] = nutrition_quality
	.["nutrition_fast"] = nutrition_fast
	.["known_languages"] = known_languages
	.["id"] = save_id
	.["dead"] = died
	.["blood_type"] = blood_type
	.["revenue"] = revenue
	.["expenses"] = expenses
	.["last_tax_payment"] = last_tax_payment
	.["partial_tax"] = partial_tax
	.["rarity"] = rarity
	.["prestige_count"] = prestige_count
	.["job"] = job
	.["job_rank"] = job_rank
	.["job_next_promotion"] = job_next_promotion
	.["difficulty"] = difficulty

	if(length(quests))
		.["quests"] = list()
		for(var/k in quests)
			var/quest/Q = k
			.["quests"] += Q

	if(length(traits))
		.["traits"] = list()
		for(var/k in traits)
			.["traits"] += k

	var/final_organ_list = list()
	for(var/id in labeled_organs)
		var/obj/item/organ/O = labeled_organs[id]
		if(!O)
			log_error("WARNING: Organ [id] not found while saving! Save corruption possible!")
			continue
		final_organ_list[id] = O.save_item_data(src,save_inventory,died)
	.["organs"] = final_organ_list

	//Skills
	var/list/final_skill_list = list()
	for(var/id in skills)
		var/experience/skill/S = skills[id]
		var/desired_experience = ENABLE_XP_SAVING && S.experience > 0 ? S.experience : S.level_to_xp(S.chargen_max_level)
		final_skill_list[id] = desired_experience
	.["skills"] = final_skill_list

	//Attributes
	var/list/final_attribute_list = list()
	for(var/id in attributes)
		var/experience/attribute/B = attributes[id]
		var/desired_experience = ENABLE_XP_SAVING && B.experience > 0 ? B.experience : B.level_to_xp(B.chargen_max_level)
		final_attribute_list[id] = desired_experience
	.["attributes"] = final_attribute_list

	//Abilities
	var/ability_length = length(ability_buttons)
	.["abilities"] = new/list(ability_length)
	for(var/i=1,i<=ability_length,i++)
		var/ability_num_as_string = ability_buttons[i]
		var/obj/hud/button/ability/B = ability_buttons[ability_num_as_string]
		if(B && B.ability)
			.["abilities"][i] = "[B.ability.type]"

	last_autosave = world.time