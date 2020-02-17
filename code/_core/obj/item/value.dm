/obj/item/proc/calculate_value(var/debug=FALSE)

	. = initial(value) * item_count_current

	if(debug) LOG_DEBUG("Initial value: [.].")

	for(var/obj/item/I in contents)
		. += I.calculate_value()

	if(debug) LOG_DEBUG("Initial value plus contents: [.].")

	for(var/obj/hud/inventory/I in inventories)
		for(var/obj/item/I2 in I.worn_objects)
			. += I2.calculate_value()
		for(var/obj/item/I2 in I.held_objects)
			. += I2.calculate_value()

	if(debug) LOG_DEBUG("Initial value plus inventories: [.].")

	if(reagents && length(reagents.stored_reagents))
		for(var/reagent_id in reagents.stored_reagents)
			var/reagent_volume = reagents.stored_reagents[reagent_id]
			var/reagent/R = all_reagents[reagent_id]
			. += R.value*reagent_volume

	if(debug) LOG_DEBUG("Initial value plus reagents: [.].")

	return .


/client/verb/calculate_value_of_object(var/obj/item/I in view())
	I.calculate_value(TRUE)