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
		color = rgb(red/total_reagents,green/total_reagents,blue/total_reagents)
	else
		color = "#FFFFFF"

	return TRUE

/reagent_container/proc/add_reagent(var/reagent_id,var/amount=0)

	world.log << "[src] of [owner].add_reagent([reagent_id],[amount])"

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

	var/reagent/R = all_reagents[reagent_id]
	R = new R(src,amount)
	return amount

/reagent_container/proc/remove_reagent(var/reagent_id,var/amount=0)

	world.log << "[src] of [owner].add_reagent([reagent_id],[amount])"

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
	world.log << "[src]  of [owner].transfer_reagent_to([target_container],[reagent_id],[amount])"
	return target_container.add_reagent(reagent_id,remove_reagent(reagent_id,amount))

/reagent_container/proc/transfer_reagents_to(var/reagent_container/target_container,var/amount=0) //Transfer all the reagents.

	world.log << "[src] of [owner].transfer_reagents_to([target_container],[amount])"

	if(amount <= 0)
		return FALSE

	amount = min(amount,total_volume)

	var/amount_transfered = 0

	var/old_volume = total_volume

	for(var/reagent/R in stored_reagents)
		var/ratio = R.volume / old_volume
		world.log << "The ratio is: [ratio]."
		var/transfered = R.transfer_reagent_to(target_container,ceiling(ratio*amount,1))
		world.log << "Transfered [transfered] units of [R.id]!"
		amount_transfered += transfered

	return amount_transfered