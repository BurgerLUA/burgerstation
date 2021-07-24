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

/mob/living/advanced/player/proc/set_mob_data(var/list/loaded_data,var/do_teleport = TRUE,var/update_blends=TRUE,var/appearance_only=FALSE)

	//Name
	real_name = sanitize_name(client,loaded_data["name"])
	if(!real_name)
		real_name = "[gender == MALE ? FIRST_NAME_MALE : FIRST_NAME_FEMALE] [LAST_NAME]"

	sex = loaded_data["sex"]
	rarity = loaded_data["rarity"] ? loaded_data["rarity"] : RARITY_COMMON
	gender = loaded_data["gender"]
	species = loaded_data["species"]
	blood_type = loaded_data["blood_type"] ? text2path(loaded_data["blood_type"]) : /reagent/blood //This should generate a new blood type.

	if(!loaded_data["known_topics"])
		loaded_data["known_topics"] = list()

	if(!appearance_only)
		save_id = loaded_data["id"]
		currency = loaded_data["currency"]
		revenue = loaded_data["revenue"] ? loaded_data["revenue"] : 0
		expenses = loaded_data["expenses"] ? loaded_data["expenses"] : 0
		partial_tax = loaded_data["partial_tax"] ? loaded_data["partial_tax"] : 0
		last_tax_payment = loaded_data["last_tax_payment"] ? loaded_data["last_tax_payment"] : world.realtime
		insurance = isnum(loaded_data["insurance"]) ? loaded_data["insurance"] : INSURANCE_PAYOUT * 4
		insurance_premiums = isnum(loaded_data["insurance_premiums"]) ? loaded_data["insurance_premiums"] : 5
		nutrition = isnum(loaded_data["nutrition"]) ? loaded_data["nutrition"] : initial(nutrition)*0.5
		hydration = isnum(loaded_data["hydration"]) ? loaded_data["hydration"] : initial(hydration)*0.5
		nutrition_fast = isnum(loaded_data["nutrition_fast"]) ? loaded_data["nutrition_fast"] : 0
		nutrition_quality = isnum(loaded_data["nutrition_quality"]) ? loaded_data["nutrition_quality"] : initial(nutrition_quality)

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


	if(loaded_data["traits"])
		for(var/k in loaded_data["traits"])
			k = text2path(k)
			if(k) src.add_trait(k,FALSE,FALSE)

	if(loaded_data["known_languages"])
		known_languages |= loaded_data["known_languages"]

	for(var/id in loaded_data["organs"]) //This does not use load_and_create object as organs are special. TODO: IT SHOULD THOUGH.
		var/o_type = loaded_data["organs"][id]["type"]
		if(appearance_only && ispath(o_type,/obj/item/organ/internal/implant))
			continue
		var/obj/item/organ/O = add_organ(o_type)
		if(!O)
			log_error("Invalid Organ: [o_type].")
			continue
		if(loaded_data["organs"][id]["blend_data"])
			O.set_blend_data(loaded_data["organs"][id]["blend_data"])
		if(!appearance_only)
			if(loaded_data["organs"][id]["inventories"])
				for(var/i=1,i<=length(loaded_data["organs"][id]["inventories"]),i++)
					var/obj/hud/inventory/I = O.inventories[i]
					I.set_inventory_data(src,loaded_data["organs"][id]["inventories"][i])
		O.update_sprite()

	if(do_teleport)
		var/obj/marker/dev/D = locate() in world
		if(D && ENABLE_INSTALOAD)
			force_move(get_turf(D))
		else if(length(cryo_spawnpoints))
			var/obj/structure/interactive/bed/sleeper/C = pick(cryo_spawnpoints)
			force_move(get_turf(C))
			C.door_state = SLEEPER_OPENED
			C.buckle(src,silent=TRUE)
			C.door_state = SLEEPER_CLOSED
			C.update_icon()
		else if(length(backup_spawnpoints))
			var/obj/marker/backup_spawn/BS = pick(backup_spawnpoints)
			force_move(get_turf(BS))
		else
			var/obj/marker/failsafe/FS = locate() in world
			force_move(get_turf(FS))


	if(update_blends)
		update_all_blends()
	else
		update_all_blends() //butts

/mob/living/advanced/player/proc/get_mob_data(var/save_inventory = TRUE,var/force=FALSE,var/died=FALSE)

	. = list()

	//Basic Information
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

	if(length(traits))
		.["traits"] = list()
		for(var/k in traits)
			.["traits"] |= k

	var/final_organ_list = list()
	for(var/id in labeled_organs)
		var/obj/item/organ/O = labeled_organs[id]
		try
			final_organ_list[id] = O.save_item_data(save_inventory)
		catch(var/exception/e)
			log_error("get_mob_data:() [e] on [e.file]:[e.line]\n[e.desc]!")
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