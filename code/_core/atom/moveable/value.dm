/atom/movable/proc/get_base_value()
	return initial(value)

/atom/movable/proc/calculate_value()

	. = get_base_value()

	for(var/atom/movable/M in contents)
		. += M.calculate_value()

	if(reagents && length(reagents.stored_reagents))
		for(var/reagent_type in reagents.stored_reagents)
			var/reagent_volume = reagents.stored_reagents[reagent_type]
			var/reagent/R = REAGENT(reagent_type)
			. += R.value*reagent_volume

	return .