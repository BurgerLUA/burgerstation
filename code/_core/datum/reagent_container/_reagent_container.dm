/reagent_container/
	name = "Reagent Container"
	desc = "The basic description of the reagent container."
	desc_extended = "The extended description of the reagent container, usually a detailed note of how much it can hold."

	var/list/reagent/stored_reagents = list()

	var/volume_max = 1000
	var/total_volume = 0
	var/color = "#FFFFFF"

	var/flags_metabolism = REAGENT_METABOLISM_NONE

	var/atom/owner

	var/should_update_owner = FALSE //Should a change in reagents update the owner?


/reagent_container/proc/get_contents_english()

	var/returning_text = list()

	for(var/reagent/R in stored_reagents)
		returning_text += "[R.volume] units of [R.name]"

	return "It contains [english_list(returning_text)]"

/reagent_container/New(var/atom/desired_owner,var/desired_volume_max)

	. = ..()

	if(desired_owner)
		owner = desired_owner

	if(desired_volume_max)
		volume_max = desired_volume_max

	return .

/reagent_container/proc/metabolize()

	if(!total_volume)
		return

	for(var/reagent/R in stored_reagents)
		if(owner && flags_metabolism)
			R.metabolize(owner)

	update_container()

/reagent_container/proc/update_container()

	var/red = 0
	var/green = 0
	var/blue = 0

	total_volume = 0

	for(var/reagent/R in stored_reagents)
		red += GetRedPart(R.color) * R.volume
		green += GetGreenPart(R.color) * R.volume
		blue += GetBluePart(R.color) * R.volume
		total_volume += R.volume

	var/total_reagents = length(stored_reagents)

	if(total_reagents)
		color = rgb(red/total_volume,green/total_volume,blue/total_volume)
	else
		color = "#FFFFFF"

	if(should_update_owner)
		owner.update_icon()

	return TRUE


/reagent_container/proc/process_recipes()

	var/list/c_id_to_volume = list() //What is in the reagent container, but in a nice id = volume form

	for(var/reagent/C in stored_reagents)
		c_id_to_volume[C.id] = C.volume

	var/reagent_recipe/found_recipe = null

	for(var/k in all_reagent_recipes)

		var/reagent_recipe/recipe = all_reagent_recipes[k]

		if(!length(recipe.required_reagents))
			continue

		var/good_recipe = TRUE

		for(var/reagent_id in recipe.required_reagents)
			if(!c_id_to_volume[reagent_id] || c_id_to_volume[reagent_id] < recipe.required_reagents[reagent_id]) //if our container doesn't have what is required, then lets fuck off.
				good_recipe = FALSE
				//world.log << "[k] is not a good recipe because there is no [reagent_id] or it is less than the required amount."
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

	for(var/k in found_recipe.required_reagents)
		var/required_amount = found_recipe.required_reagents[k]
		remove_reagent(k,portions_to_make* required_amount)

	for(var/k in found_recipe.results)
		var/v = found_recipe.results[k]
		add_reagent(k,portions_to_make * v)

	update_container()

	return TRUE

/reagent_container/proc/add_reagent(var/reagent_id,var/amount=0)

	if(amount == 0)
		LOG_ERROR("Reagent Error: Tried to add/remove 0 units of [reagent_id] (ID) to [owner]!")
		return 0

	for(var/reagent/R in stored_reagents)
		if(R.id == reagent_id)
			return R.add_amount(amount)

	if(!all_reagents[reagent_id])
		LOG_ERROR("Reagent Error: Tried to add a null reagent ([reagent_id]) (ID) to [owner]!")
		return 0

	if(amount <= 0)
		LOG_ERROR("Reagent Error: Tried to take away a reagent ([reagent_id]) that doesn't exist in [owner]!")
		return 0

	var/R = all_reagents[reagent_id].type
	new R(src,amount)

	process_recipes()

	return amount

/reagent_container/proc/remove_reagent(var/reagent_id,var/amount=0)


	if(amount <= 0)
		return 0

	var/reagent/found_reagent

	for(var/reagent/R in stored_reagents)
		if(R.id == reagent_id)
			found_reagent = R
			break

	if(!found_reagent)
		return 0

	var/amount_removed = found_reagent.remove_amount(amount)
	return amount_removed


/reagent_container/proc/transfer_reagent_to(var/reagent_container/target_container,var/reagent_id,var/amount=0) //Transfer a single reagent by id.
	return target_container.add_reagent(reagent_id,remove_reagent(reagent_id,amount))

/reagent_container/proc/transfer_reagents_to(var/reagent_container/target_container,var/amount=0) //Transfer all the reagents.


	if(amount <= 0)
		return FALSE

	amount = min(amount,total_volume)

	var/amount_transfered = 0

	var/old_volume = total_volume

	for(var/reagent/R in stored_reagents)
		var/ratio = R.volume / old_volume
		var/transfered = R.transfer_reagent_to(target_container,ceiling(ratio*amount,1))
		amount_transfered += transfered

	return amount_transfered