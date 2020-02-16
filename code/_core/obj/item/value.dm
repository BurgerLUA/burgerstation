/obj/item/proc/calculate_value()

	. = initial(value) * item_count_current

	for(var/obj/item/I in contents)
		. += I.calculate_value()

	if(reagents && length(reagents.stored_reagents))
		for(var/reagent_id in reagents.stored_reagents)
			var/reagent_volume = reagents.stored_reagents[reagent_id]
			var/reagent/R = all_reagents[reagent_id]
			. += R.value*reagent_volume

	return .