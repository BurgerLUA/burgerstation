/obj/item/get_base_value()
	return initial(value) * item_count_current

/atom/movable/proc/get_base_value()
	return initial(value)

/atom/movable/proc/calculate_value()

	. = get_base_value()

	for(var/atom/movable/M in contents)
		. += M.calculate_value()

	if(reagents && length(reagents.stored_reagents))
		for(var/reagent_id in reagents.stored_reagents)
			var/reagent_volume = reagents.stored_reagents[reagent_id]
			var/reagent/R = all_reagents[reagent_id]
			. += R.value*reagent_volume

	return .


/obj/item/calculate_value()

	. = ..()

	for(var/obj/hud/inventory/I in inventories)
		for(var/obj/item/I2 in I.worn_objects)
			. += I2.calculate_value()
		for(var/obj/item/I2 in I.held_objects)
			. += I2.calculate_value()

	return .