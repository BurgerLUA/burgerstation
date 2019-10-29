/reagent_container/
	name = "Reagent Container"
	desc = "The basic description of the reagent container."
	desc_extended = "The extended description of the reagent container, usually a detailed note of how much it can hold."

	var/list/stored_reagents = list()
	var/list/stored_reagents_temperature = list()

	var/volume_current = 0
	var/volume_max = 1000
	var/color = "#FFFFFF"

	var/average_temperature = T0C + 20

	var/flags_metabolism = REAGENT_METABOLISM_NONE
	var/flags_temperature = REAGENT_TEMPERATURE_NONE

	var/atom/owner

	var/should_update_owner = FALSE //Should a change in reagents update the owner?

/reagent_container/destroy()
	owner = null
	all_reagent_containers -= src
	return ..()

/reagent_container/proc/get_contents_english()

	var/returning_text = list()

	for(var/r_id in stored_reagents)
		var/reagent/R = all_reagents[r_id]
		var/volume = stored_reagents[r_id]
		returning_text += "[volume] units of [R.name]"

	return "It contains [english_list(returning_text)]. The temperature reads [average_temperature] kelvin."

/reagent_container/New(var/atom/desired_owner,var/desired_volume_max)

	. = ..()

	if(desired_owner)
		owner = desired_owner

	if(desired_volume_max)
		volume_max = desired_volume_max

	all_reagent_containers += src

	return .

/reagent_container/proc/metabolize()

	if(!volume_current)
		return

	for(var/r_id in stored_reagents)

		if(!flags_metabolism)
			continue

		var/volume = stored_reagents[r_id]

		if(!volume)
			continue


		var/reagent/R = all_reagents[r_id]


		var/atom/owner_to_use = owner

		if(owner && is_organ(owner) && owner.loc && flags_metabolism & REAGENT_METABOLISM_INGEST)
			owner_to_use = owner.loc

		if(!owner_to_use)
			continue

		remove_reagent(r_id,R.metabolize(owner_to_use,src,volume),FALSE)

	update_container()


/reagent_container/proc/process_temperature()

	if(!owner)
		return FALSE

	if(!volume_current)
		return FALSE

	var/area/A = get_area(owner)
	var/area_temperature = A.ambient_temperature

	if(area_temperature == average_temperature)
		return TRUE

	var/temperature_mod = 0

	for(var/r_id in stored_reagents)
		temperature_mod += stored_reagents[r_id] * all_reagents[r_id].temperature_mod

	var/temperature_diff = area_temperature - average_temperature

	if(average_temperature > area_temperature)
		average_temperature = max(area_temperature,average_temperature + (temperature_diff * (AIR_TEMPERATURE_MOD/temperature_mod)))
	else
		average_temperature = min(area_temperature,average_temperature + (temperature_diff * (AIR_TEMPERATURE_MOD/temperature_mod)))

	for(var/r_id in stored_reagents_temperature)
		stored_reagents_temperature[r_id] = average_temperature

	return TRUE


/reagent_container/proc/update_container()

	var/red = 0
	var/green = 0
	var/blue = 0

	volume_current = 0
	average_temperature = 0

	var/list/temperature_math_01 = list()

	var/list/temperature_math_02 = list()
	var/math_02_total = 0

	for(var/r_id in stored_reagents)
		var/reagent/R = all_reagents[r_id]

		var/volume = stored_reagents[r_id]
		var/temperature = stored_reagents_temperature[r_id] ? stored_reagents_temperature[r_id] : T0C + 20

		if(volume <= 0)
			stored_reagents -= r_id
			stored_reagents_temperature -= r_id
			continue

		red += GetRedPart(R.color) * volume
		green += GetGreenPart(R.color) * volume
		blue += GetBluePart(R.color) * volume
		volume_current += volume

		temperature_math_01[r_id] = temperature
		temperature_math_02[r_id] = volume * R.temperature_mod
		math_02_total += temperature_math_02[r_id]

	for(var/r_id in temperature_math_01)
		average_temperature += temperature_math_01[r_id] * (temperature_math_02[r_id] / math_02_total)

	var/total_reagents = length(stored_reagents)

	if(total_reagents)
		color = rgb(red/volume_current,green/volume_current,blue/volume_current)
	else
		color = "#FFFFFF"
		average_temperature = T0C+20

	if(should_update_owner)
		owner.update_icon()

	return TRUE


/reagent_container/proc/process_recipes()

	var/list/c_id_to_volume = list() //What is in the reagent container, but in a nice id = volume form

	for(var/reagent_id in stored_reagents)
		c_id_to_volume[reagent_id] = stored_reagents[reagent_id]

	var/reagent_recipe/found_recipe = null

	for(var/k in all_reagent_recipes)

		var/reagent_recipe/recipe = all_reagent_recipes[k]

		if(!length(recipe.required_reagents))
			continue

		var/good_recipe = TRUE

		for(var/reagent_id in recipe.required_reagents)
			if(!c_id_to_volume[reagent_id] || c_id_to_volume[reagent_id] < recipe.required_reagents[reagent_id]) //if our container doesn't have what is required, then lets fuck off.
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
		var/required_amount = found_recipe.required_reagents[k]
		var/current_volume = c_id_to_volume[k]
		var/math_to_do = current_volume / required_amount

		if(!portions_to_make)
			portions_to_make = math_to_do
			continue

		portions_to_make = min(portions_to_make,math_to_do)

	var/desired_temperature = 0
	var/amount_removed = 0

	for(var/k in found_recipe.required_reagents)
		var/required_amount = found_recipe.required_reagents[k]
		var/amount_to_remove = portions_to_make * required_amount
		remove_reagent(k,amount_to_remove,FALSE)
		desired_temperature += amount_to_remove*all_reagents[k].temperature_mod
		amount_removed += amount_to_remove

	if(amount_removed)
		desired_temperature *= 1/amount_removed
	else
		desired_temperature = T0C

	world.log << desired_temperature

	for(var/k in found_recipe.results)
		var/v = found_recipe.results[k]
		add_reagent(k,portions_to_make * v,desired_temperature,FALSE)

	update_container()

	if(found_recipe.result && owner && !istype(owner,found_recipe.result))
		world.log << "Owner: [owner], Result: [found_recipe.result]"
		var/obj/item/A = new found_recipe.result(get_turf(owner))
		if(A.reagents)
			transfer_reagents_to(A.reagents,volume_current,FALSE)

			A.reagents.update_container()
			update_container()


	return TRUE

/reagent_container/proc/add_reagent(var/reagent_id,var/amount=0, var/temperature = TNULL, var/should_update = TRUE)

	if(!all_reagents[reagent_id])
		LOG_ERROR("Reagent Error: Tried to add/remove a null reagent ([reagent_id]) (ID) to [owner]!")
		return 0

	if(amount == 0)
		LOG_ERROR("Reagent Error: Tried to add/remove 0 units of [reagent_id] (ID) to [owner]!")
		return 0

	if(temperature == TNULL)
		if(owner)
			var/area/A = get_area(owner)
			temperature = A.ambient_temperature
		else
			temperature = T0C + 20

	var/previous_amount = stored_reagents[reagent_id] ? stored_reagents[reagent_id] : 0
	var/previous_temp = stored_reagents_temperature[reagent_id] ? stored_reagents_temperature[reagent_id] : 0

	if(volume_current + amount > volume_max)
		amount = volume_max - volume_current

	if(amount == 0)
		return 0

	if(stored_reagents[reagent_id])
		stored_reagents[reagent_id] += amount
	else
		stored_reagents[reagent_id] = amount

	if(stored_reagents_temperature[reagent_id])
		stored_reagents_temperature[reagent_id] = ( (previous_amount*previous_temp) + (amount*temperature) ) / (stored_reagents[reagent_id])
	else
		stored_reagents_temperature[reagent_id] = temperature

	process_recipes()

	if(should_update)
		update_container()

	return amount

/reagent_container/proc/remove_reagent(var/reagent_id,var/amount=0,var/should_update = TRUE)
	return -add_reagent(reagent_id,-amount,should_update)

/reagent_container/proc/transfer_reagent_to(var/reagent_container/target_container,var/reagent_id,var/amount=0) //Transfer a single reagent by id.
	return target_container.add_reagent(reagent_id,remove_reagent(reagent_id,amount))

/reagent_container/proc/transfer_reagents_to(var/reagent_container/target_container,var/amount=0,var/should_update=TRUE) //Transfer all the reagents.

	if(amount == 0)
		return FALSE

	if(amount < 0)
		return -target_container.transfer_reagents_to(src,-amount,should_update)

	amount = min(amount,volume_current)

	var/total_amount_transfered = 0

	var/old_volume = volume_current

	for(var/r_id in stored_reagents)
		var/volume = stored_reagents[r_id]
		var/ratio = volume / old_volume
		var/amount_transfered = target_container.add_reagent(r_id,ratio*amount,FALSE)
		remove_reagent(r_id,amount_transfered,FALSE)
		total_amount_transfered += amount_transfered

	if(should_update)
		src.update_container()
		target_container.update_container()

	return total_amount_transfered