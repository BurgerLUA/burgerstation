#define REAGENT_ROUNDING 0.01

/reagent_container/

	var/list/stored_reagents = list()
	var/list/stored_reagents_temperature = list()

	var/volume_current = 0
	var/volume_max = 1000
	var/color = "#FFFFFF"
	var/alpha = 255

	var/average_temperature = T0C + 20

	var/flags_metabolism = REAGENT_METABOLISM_NONE
	var/flags_temperature = REAGENT_TEMPERATURE_NONE

	var/atom/owner

	var/should_update_owner = FALSE //Should a change in reagents update the owner?

	var/debug = FALSE

	var/special_temperature_mod = 0

	var/contains_lethal = FALSE

	var/allow_recipie_processing = TRUE

/reagent_container/Destroy()
	owner = null
	SSreagent.all_reagent_containers -= src
	return ..()

/reagent_container/proc/get_contents_english()

	var/returning_text = list()

	for(var/r_id in stored_reagents)
		var/reagent/R = REAGENT(r_id)
		var/volume = stored_reagents[r_id]
		returning_text += "[volume] units of [R.name]"

	return "It contains [english_list(returning_text)]. The temperature reads [average_temperature] kelvin."

/reagent_container/New(var/atom/desired_owner,var/desired_volume_max)

	if(desired_owner)
		owner = desired_owner

	if(desired_volume_max)
		volume_max = desired_volume_max

	. = ..()

	SSreagent.all_reagent_containers += src

	return .

/reagent_container/proc/metabolize(var/multiplier=1)

	if(!volume_current)
		return

	if(!owner)
		return

	if(!flags_metabolism)
		return

	for(var/r_id in stored_reagents)

		var/volume = stored_reagents[r_id]

		if(!volume)
			continue

		var/reagent/R = REAGENT(r_id)

		if(!(flags_metabolism & R.flags_metabolism))
			continue

		var/atom/owner_to_use = owner

		if(owner && is_organ(owner) && owner.loc && flags_metabolism & REAGENT_METABOLISM_INGEST)
			owner_to_use = owner.loc

		var/metabolize_amount = R.metabolize(owner,owner_to_use,src,volume,multiplier)

		if(metabolize_amount)
			remove_reagent(r_id,metabolize_amount,FALSE)

	update_container()

/reagent_container/proc/process_temperature()

	if(!owner)
		return FALSE

	if(!volume_current)
		return FALSE

	var/turf/simulated/T
	if(is_simulated(owner.loc))
		T = owner.loc

	var/area/A
	if(T && T.loc)
		A = T.loc

	var/desired_temperature = (A ? A.ambient_temperature : T0C + 20) + special_temperature_mod + (T ? T.turf_temperature_mod : 0)
	var/desired_temperature_mod = AIR_TEMPERATURE_MOD

	if(is_inventory(owner.loc))
		var/obj/hud/inventory/I = owner.loc
		desired_temperature += I.inventory_temperature_mod
		desired_temperature_mod *= I.inventory_temperature_mod_mod

	if(desired_temperature == average_temperature)
		return TRUE

	var/temperature_mod = 0

	for(var/r_id in stored_reagents)
		var/reagent/R = REAGENT(r_id)
		var/volume = stored_reagents[r_id]
		temperature_mod += (volume * R.temperature_mod)

	var/temperature_diff = desired_temperature - average_temperature

	var/temperature_change = (temperature_diff * (1/temperature_mod)) + clamp(temperature_diff,-1,1)

	if(average_temperature > desired_temperature) //If we're hotter than we want to be.
		average_temperature = max(desired_temperature,average_temperature + temperature_change)
	else //If we're colder than we need to be.
		temperature_change *= 0.5 //This means it's slow to heat up, but fast to cool down.
		average_temperature = min(desired_temperature,average_temperature + temperature_change)
	 . = FALSE


	for(var/r_id in stored_reagents_temperature)
		var/reagent/R = REAGENT(r_id)
		var/volume = stored_reagents[r_id]
		stored_reagents_temperature[r_id] = average_temperature
		if(R.heated_reagent && R.heated_reagent_temp < average_temperature)
			var/temperature_heat_mod = (average_temperature/max(0.1,R.heated_reagent_temp)) ** 2
			var/amount_to_remove = CEILING(min(R.heated_reagent_amount + (volume * R.heated_reagent_mul * temperature_heat_mod),volume),REAGENT_ROUNDING)
			add_reagent(R.heated_reagent,remove_reagent(r_id,amount_to_remove,should_update = FALSE, check_recipes = FALSE),should_update = FALSE, check_recipes = FALSE)
			. = TRUE
		else if(R.cooled_reagent && R.cooled_reagent_temp > average_temperature)
			var/temperature_cool_mod = (R.cooled_reagent_temp/max(0.1,average_temperature)) ** 2
			var/amount_to_remove = CEILING(min(R.cooled_reagent_amount + (volume * R.cooled_reagent_mul * temperature_cool_mod),volume),REAGENT_ROUNDING)
			add_reagent(R.cooled_reagent,remove_reagent(r_id,amount_to_remove,should_update = FALSE, check_recipes = FALSE),should_update = FALSE, check_recipes = FALSE)
			. = TRUE

	if(.)
		update_container()
		return TRUE

	process_recipes() //Don't worry, this is only called when there was a temperature change and nothing else.

	return TRUE


/reagent_container/proc/update_container(var/update_owner = TRUE)

	var/red = 0
	var/green = 0
	var/blue = 0
	var/alpha = 0

	volume_current = 0
	average_temperature = 0

	var/list/temperature_math_01 = list()

	var/list/temperature_math_02 = list()
	var/math_02_total = 0

	contains_lethal = FALSE

	for(var/r_id in stored_reagents)
		var/reagent/R = REAGENT(r_id)
		stored_reagents[r_id] = round(stored_reagents[r_id],REAGENT_ROUNDING)

		if(R.lethal)
			contains_lethal = TRUE

		var/volume = stored_reagents[r_id]
		var/temperature = stored_reagents_temperature[r_id] ? stored_reagents_temperature[r_id] : T0C + 20

		if(volume <= 0)
			stored_reagents -= r_id
			stored_reagents_temperature -= r_id
			continue

		red += GetRedPart(R.color) * volume
		green += GetGreenPart(R.color) * volume
		blue += GetBluePart(R.color) * volume
		alpha += R.alpha * volume
		volume_current += volume

		temperature_math_01[r_id] = temperature
		temperature_math_02[r_id] = volume * R.temperature_mod
		math_02_total += temperature_math_02[r_id]

	for(var/r_id in temperature_math_01)
		average_temperature += temperature_math_01[r_id] * (temperature_math_02[r_id] / math_02_total)

	var/total_reagents = length(stored_reagents)

	if(total_reagents)
		color = rgb(red/volume_current,green/volume_current,blue/volume_current)
		alpha = clamp(FLOOR(alpha/total_reagents,1),1,255)
	else
		color = "#FFFFFF"
		average_temperature = T0C+20

	if(owner && should_update_owner && update_owner)
		owner.update_sprite()

	return TRUE


/reagent_container/proc/process_recipes(var/mob/caller)

	if(!allow_recipie_processing)
		return FALSE

	if(!caller && is_item(src.owner))
		var/obj/item/I = src.owner
		caller = I.last_interacted

	var/list/c_id_to_volume = stored_reagents.Copy()
	var/list/c_id_to_temperature = stored_reagents_temperature.Copy()

	var/reagent_recipe/found_recipe = null
	for(var/k in SSreagent.all_reagent_recipes)

		CHECK_TICK(75,FPS_SERVER)

		var/reagent_recipe/recipe = SSreagent.all_reagent_recipes[k]

		if(debug) log_debug("Checking [recipe]...")

		if(!length(recipe.required_reagents))
			continue

		var/good_recipe = TRUE

		for(var/reagent_type in recipe.required_reagents)
			if(recipe.required_container && !istype(owner,recipe.required_container))
				if(debug) log_debug("Recipe [recipe.name] invalid because of wrong container type.")
				good_recipe = FALSE
				break

			if(!c_id_to_volume[reagent_type] || c_id_to_volume[reagent_type] < recipe.required_reagents[reagent_type]) //if our container doesn't have what is required, then lets fuck off.
				if(debug) log_debug("Recipe [recipe.name] invalid because of too few reagents of [reagent_type].")
				good_recipe = FALSE
				break

			if(recipe.required_temperature_min[reagent_type] && c_id_to_temperature[reagent_type] < recipe.required_temperature_min[reagent_type])
				if(debug) log_debug("Recipe [recipe.name] invalid because of too low temperature of [reagent_type].")
				good_recipe = FALSE
				break

			if(recipe.required_temperature_max[reagent_type] && c_id_to_temperature[reagent_type] > recipe.required_temperature_max[reagent_type])
				if(debug) log_debug("Recipe [recipe.name] invalid because of too high temperature of [reagent_type].")
				good_recipe = FALSE
				break

		if(!good_recipe) //This recipe doesn't work. Onto the next recipe.
			continue

		found_recipe = recipe
		break

	if(!found_recipe)
		return FALSE

	//Okay now we figure out math bullshit.

	var/portions_to_make

	for(var/k in found_recipe.required_reagents)
		CHECK_TICK(75,FPS_SERVER)
		var/required_amount = found_recipe.required_reagents[k]
		var/current_volume = c_id_to_volume[k]
		var/math_to_do = current_volume / required_amount
		if(!portions_to_make)
			portions_to_make = math_to_do
			continue
		portions_to_make = min(portions_to_make,math_to_do)

	var/amount_removed = 0

	var/desired_temperature = average_temperature

	for(var/k in found_recipe.required_reagents)
		CHECK_TICK(75,FPS_SERVER)
		var/required_amount = found_recipe.required_reagents[k]
		var/amount_to_remove = portions_to_make * required_amount
		remove_reagent(k,amount_to_remove,FALSE,FALSE)
		amount_removed += amount_to_remove

	update_container(FALSE)

	for(var/k in found_recipe.results)
		var/v = found_recipe.results[k] * portions_to_make
		add_reagent(k,v,desired_temperature,FALSE,FALSE,caller)

	found_recipe.on_react(caller,src,portions_to_make)

	if(found_recipe.result && owner && !istype(owner,found_recipe.result))
		update_container(FALSE)
		while(volume_current > 0)
			CHECK_TICK(75,FPS_SERVER)
			var/obj/item/A = new found_recipe.result(get_turf(owner))
			INITIALIZE(A)
			FINALIZE(A)
			if(!A.reagents)
				break
			transfer_reagents_to(A.reagents,min(A.reagents.volume_max - A.reagents.volume_current,volume_current),caller = caller)
	else
		update_container()

	return TRUE

/reagent_container/proc/add_reagent(var/reagent_type,var/amount=0, var/temperature = TNULL, var/should_update = TRUE,var/check_recipes = TRUE,var/mob/living/caller)

	amount = round(amount,REAGENT_ROUNDING)

	var/reagent/R = REAGENT(reagent_type)

	if(!R)
		CRASH_SAFE("Reagent Error: Tried to add/remove an invalid reagent ([reagent_type]) to [owner.get_debug_name()]!")
		return 0

	if(amount == 0)
		//CRASH_SAFE("Reagent Error: Tried to add/remove 0 units of [reagent_type] to [owner.get_debug_name()]!")
		return 0

	if(temperature == TNULL)
		if(owner)
			var/area/A = get_area(owner)
			if(A)
				temperature = A.ambient_temperature
			else
				temperature = T0C + 20
		else
			temperature = T0C + 20

	var/previous_amount = SAFENUM(stored_reagents[reagent_type])
	var/previous_temp = SAFENUM(stored_reagents_temperature[reagent_type])

	if(volume_current + amount > volume_max)
		amount = volume_max - volume_current

	if(amount == 0)
		return 0

	. = amount //This is the REAL WORLD AMOUNT that is added. This is used for removing stuff.

	if(amount > 0)
		amount = R.on_add(src,amount,previous_amount,caller) //This is the VIRTUAL AMOUNT that is actually added.
		var/mob/living/L
		if(is_living(src.owner))
			L = src.owner
		else if(is_living(src.owner.loc))
			L = src.owner.loc
		if(L)
			amount = R.on_add_living(L,src,amount,previous_amount,caller) //This is the VIRTUAL AMOUNT that is actually added.

	if(amount)
		stored_reagents[reagent_type] += amount

	if(amount > 0)
		if(stored_reagents_temperature[reagent_type] && stored_reagents[reagent_type])
			stored_reagents_temperature[reagent_type] = ( (previous_amount*previous_temp) + (amount*temperature) ) / (stored_reagents[reagent_type])
		else
			stored_reagents_temperature[reagent_type] = temperature

	if(stored_reagents[reagent_type] <= 0)
		R.on_remove(src)
		var/mob/living/L
		if(is_living(src.owner))
			L = src.owner
		else if(is_living(src.owner.loc))
			L = src.owner.loc
		if(L)
			R.on_remove_living(L,src)

	if(check_recipes)
		process_recipes(caller)

	if(should_update)
		update_container()

	return .

/reagent_container/proc/remove_reagent(var/reagent_type,var/amount=0,var/should_update = TRUE,var/check_recipes = TRUE,var/mob/living/caller)
	return -add_reagent(reagent_type,-amount,TNULL,should_update,check_recipes,caller)

/reagent_container/proc/remove_all_reagents()

	stored_reagents.Cut()
	stored_reagents_temperature.Cut()
	update_container()

	return TRUE

/*
/reagent_container/proc/transfer_reagent_to(var/reagent_container/target_container,var/reagent_type,var/amount=0,var/should_update = TRUE, var/check_recipes = TRUE,var/mob/living/caller) //Transfer a single reagent by id.
	var/old_temperature = stored_reagents_temperature[reagent_type] ? stored_reagents_temperature[reagent_type] : T0C + 20
	return target_container.add_reagent(reagent_type,remove_reagent(reagent_type,amount,should_update,check_recipes,caller),old_temperature,should_update,check_recipes,caller)
*/

/*
/reagent_container/proc/remove_reagents(var/amount,var/should_update=TRUE,var/check_recipes = TRUE,var/mob/living/caller)

	if(amount <= 0)
		return FALSE

	amount = min(amount,volume_current)

	var/total_amount_removed = 0

	var/old_volume = volume_current

	for(var/r_id in stored_reagents)
		var/volume = stored_reagents[r_id]
		var/ratio = volume / old_volume
		total_amount_removed += remove_reagent(r_id,ratio*amount,FALSE,FALSE)

	if(should_update)
		src.update_container()

	if(check_recipes)
		src.process_recipes(caller)

	return total_amount_removed
*/

/reagent_container/proc/transfer_reagents_to(var/reagent_container/target_container,var/amount=0,var/should_update=TRUE,var/check_recipes = TRUE,var/mob/living/caller) //Transfer all the reagents.

	if(!target_container)
		CRASH_SAFE("Tried to transfer reagents from [owner], but there was no target_container!")
		return 0

	if(amount == 0)
		return 0

	if(amount < 0)
		return -target_container.transfer_reagents_to(src,-amount,should_update,check_recipes,caller)

	amount = min(amount,volume_current)

	if(caller && target_container.owner)
		var/mob/living/L1 = caller
		var/mob/living/L2

		if(is_living(target_container.owner))
			L2 = target_container.owner
		else if(target_container.owner && is_living(target_container.owner.loc))
			L2 = target_container.owner.loc

		if(L2 && L1.loyalty_tag && L1.loyalty_tag == L2.loyalty_tag)
			for(var/r_id in stored_reagents)
				var/reagent/R = REAGENT(r_id)
				if(R.lethal)
					return 0

	var/total_amount_transfered = 0

	var/old_volume = volume_current

	for(var/r_id in stored_reagents)
		var/volume = stored_reagents[r_id]
		var/ratio = volume / old_volume
		var/temp = stored_reagents_temperature[r_id]

		var/amount_transfered = target_container.add_reagent(r_id,ratio*amount,temp,FALSE,FALSE,caller = caller)
		remove_reagent(r_id,amount_transfered,FALSE)
		total_amount_transfered += amount_transfered

	if(should_update)
		src.update_container()
		target_container.update_container()

	if(check_recipes)
		src.process_recipes(caller)
		target_container.process_recipes(caller)

	return total_amount_transfered

/reagent_container/proc/get_reagent_volume(var/reagent_type)
	return stored_reagents[reagent_type] ? stored_reagents[reagent_type] : 0

/reagent_container/proc/get_flavor()

	var/list/flavor_profile = list()
	var/list/flavor_flags = list()

	for(var/r_id in stored_reagents)
		var/reagent/R = REAGENT(r_id)
		var/flavor_strength = R.flavor_strength*(stored_reagents[r_id]/volume_current)
		flavor_profile[R.flavor] += flavor_strength
		flavor_flags["[R.flags_flavor]"] = flavor_strength

	sortTim(flavor_profile,/proc/cmp_numeric_dsc,associative=TRUE)

	var/list/english_flavor_profile = list()

	var/flavor_count = min(4,length(flavor_profile))

	for(var/i=1,i<=flavor_count,i++)
		var/k = flavor_profile[i] //This gets the key (flavor name)
		var/v = flavor_profile[k] //This gets the value (flavor strength)
		var/flavor_text
		switch(v)
			if(0.05 to 0.1)
				flavor_text = "a hint of [k]"
			if(0.1 to 0.25)
				flavor_text = "a little bit of [k]"
			if(0.25 to 1)
				flavor_text = k
			if(1 to 2)
				flavor_text = "a strong amount of [k]"
			if(2 to INFINITY)
				flavor_text = "an overwhelming amount of [k]"
		if(flavor_text)
			english_flavor_profile += flavor_text


	return list(english_list(english_flavor_profile),flavor_flags,flavor_count)


/reagent_container/proc/splash(var/mob/caller,var/atom/target,var/splash_amount = volume_current,var/silent = FALSE,var/strength_mod=1)

	if(!splash_amount || !volume_current)
		caller?.to_chat(span("warning","There is nothing to splash!"))
		return FALSE

	if(!target)
		CRASH_SAFE("Tried to splash with no target!")
		return FALSE

	target = target.change_victim(caller,owner)

	target.on_splash(caller,src,splash_amount,silent,strength_mod)

	return TRUE


/atom/proc/on_splash(var/mob/caller,var/reagent_container/source,var/splash_amount,var/silent = FALSE,var/strength_mod=1)

	if(source.stored_reagents)
		for(var/r_id in source.stored_reagents)
			var/reagent/R = REAGENT(r_id)
			var/volume_to_splash = source.remove_reagent(R.type,source.stored_reagents[r_id] * (splash_amount/source.volume_current),FALSE,FALSE)
			R.on_splash(source,caller,src,volume_to_splash,strength_mod)
		if(!silent) caller?.visible_message(span("danger","\The [caller] splashes the contents of \the [source.owner.name] on \the [src.name]!"),span("warning","You splash the contents of \the [source.owner.name] on \the [src.name]!"))
		source.update_container()
		return TRUE

	return FALSE

/reagent_container/proc/consume(var/mob/caller,var/mob/living/consumer)

	if(!owner)
		CRASH_SAFE("[src.get_debug_name()] had no owner!")
		return FALSE

	var/consume_verb = owner.get_consume_verb()
	var/consume_sound = owner.get_consume_sound()

	if(!length(stored_reagents) || volume_current <= 0)
		caller.to_chat(span("warning","There is nothing left of \the [src.owner.name] to [consume_verb]!"))
		return FALSE

	if(is_advanced(consumer))
		var/mob/living/advanced/A = consumer
		if(!A.labeled_organs[BODY_STOMACH])
			if(caller && caller != consumer)
				caller.to_chat(span("warning","You don't know how they can [consume_verb] \the [src.owner.name]!"))
			consumer.to_chat(span("warning","You don't know how you can [consume_verb] \the [src]!"))
			return FALSE

		var/list/flavor_data = get_flavor()

		var/final_flavor_text = flavor_data[1]
		var/list/flavor_flags = flavor_data[2]
		var/flavor_count = flavor_data[3]

		var/like_score = 0
		var/species/SP = SPECIES(A.species)
		for(var/k in flavor_flags)
			var/real_bit = text2num(k)
			if(real_bit & SP.flags_flavor_love)
				like_score += flavor_flags[k]
			if(real_bit & SP.flags_flavor_hate)
				like_score -= flavor_flags[k]*5 //Things you dislike in food are much more obvious than things you like.

		if(flavor_count > 1 && like_score > 0)
			like_score *= 1 + flavor_count*0.5 //Bonuses for multiple flavor types. More effort must've been put into it.

		if(final_flavor_text && (A.last_flavor_time + SECONDS_TO_DECISECONDS(3) <= world.time || A.last_flavor != final_flavor_text) )
			A.last_flavor = final_flavor_text
			A.last_flavor_time = world.time
			final_flavor_text = "You taste [final_flavor_text]."
			if(like_score >= 1)
				final_flavor_text += " You like this taste."
			else if(like_score < 0)
				final_flavor_text += " You hate this taste!"
		else
			final_flavor_text = null

		if(caller && caller != consumer)
			consumer.visible_message(span("warning","\The [caller.name] forces \the [consumer.name] to [consume_verb] \the [src.owner.name]!"),span("danger","\The [caller.name] forces you to [consume_verb] the [src.owner.name]!"))
		else
			consumer.visible_message(span("notice","\The [consumer.name] [consume_verb]s \the [src.owner.name]."),span("notice","You [consume_verb] \the [src.owner.name]."))

		if(consume_sound)
			play_sound(consume_sound,get_turf(consumer),range_max=VIEW_RANGE*0.5)

		if(final_flavor_text)
			consumer.to_chat(span("notice",final_flavor_text))

		var/obj/item/organ/internal/stomach/S = A.labeled_organs[BODY_STOMACH]
		. = transfer_reagents_to(S.reagents,volume_current, caller = caller)
	else
		. = transfer_reagents_to(consumer.reagents,volume_current, caller = caller)

	return .