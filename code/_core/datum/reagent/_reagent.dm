/reagent/
	name = "Reagent"
	desc = "The basic description of the reagent."
	desc_extended = "The extended description of the reagent, usually a detailed note of its effects."

	var/color = "#FFFFFF" //Reagent's color.

	var/metabolism_stomach = 1 //How many units of the reagent to metabolize per second.
	var/metabolism_blood = 1 //How many units of the reagent to metabolize per second.
	var/metabolism_skin = 1 //How many units of the reagent to metabolize per second.

	var/flags_metabolism = REAGENT_METABOLISM_INGEST | REAGENT_METABOLISM_BLOOD

	//var/volume = 0 //How many units does this reagent instance contain?

/*
/reagent/New(var/reagent_container/desired_container,var/desired_volume)

	. = ..()

	if(desired_container)
		current_container = desired_container
		desired_container.stored_reagents += src

	if(desired_volume)
		volume = 0
		add_amount(desired_volume)

	return .
*/

/reagent/proc/metabolize(var/atom/owner,var/reagent_container/container,var/starting_volume=0)

	var/container_flags_metabolism = container.flags_metabolism

	var/total_metabolized = 0

	if(starting_volume >= 0 && container_flags_metabolism & REAGENT_METABOLISM_BLOOD)
		total_metabolized += on_metabolize_blood(owner,container,starting_volume)

	if(starting_volume >= 0 && container_flags_metabolism & REAGENT_METABOLISM_INGEST)
		total_metabolized += on_metabolize_stomach(owner,container,starting_volume)

	if(starting_volume >= 0 && container_flags_metabolism & REAGENT_METABOLISM_SKIN)
		total_metabolized += on_metabolize_skin(owner,container,starting_volume)

	return total_metabolized

/reagent/proc/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0)
	return metabolism_stomach

/reagent/proc/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0)
	return metabolism_blood

/reagent/proc/on_metabolize_skin(var/atom/owner,var/reagent_container/container,var/starting_volume=0)
	return metabolism_skin

/*
/reagent/proc/update_volume()

	if(volume <= 0)
		current_container.stored_reagents -= src
		current_container.update_container()
		qdel(src)
		return TRUE

	current_container.update_container()

	return TRUE

/reagent/proc/add_amount(var/volume_to_add)

	if(!volume_to_add)
		LOG_ERROR("Reagent Error: Tried to add/remove 0 units of [name] to [current_container.owner]!")
		return 0

	if(volume_to_add < 0)
		volume_to_add = max(volume_to_add,-volume)

	volume += volume_to_add

	update_volume()

	return volume_to_add

/reagent/proc/remove_amount(var/volume_to_remove)
	return -add_amount(-volume_to_remove)

/reagent/proc/transfer_reagent_to(var/reagent_container/target_container,var/amount=0)
	return target_container.add_reagent(src.id,src.remove_amount(amount))
*/