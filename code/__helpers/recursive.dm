

/proc/recursive_find_item(var/obj/item/I,var/desired_obj,var/desired_proc)

	if(!I)
		CRASH_SAFE("recursive_find_mob not supplied with an item!")
		return FALSE

	if(!desired_proc)
		CRASH_SAFE("recursive_find_mob not supplied with a proc!")
		return FALSE

	if(!desired_obj)
		CRASH_SAFE("recursive_find_mob not supplied with a obj!")
		return FALSE

	world.log << "Checking [I]..."
	var/call_result = call(desired_obj,desired_proc)(I)
	if(call_result)
		return I

	for(var/obj/hud/inventory/I2 in I.inventories)
		for(var/obj/item/I3 in I2.held_objects)
			var/result = recursive_find_item(I3,desired_obj,desired_proc)
			if(result)
				return result
		for(var/obj/item/I3 in I2.worn_objects)
			var/result = recursive_find_item(I3,desired_obj,desired_proc)
			if(result)
				return result

	return FALSE


/proc/recursive_find_mob(var/mob/living/advanced/A,var/desired_obj,var/desired_proc)

	if(!A)
		CRASH_SAFE("recursive_find_mob not supplied with an advanced mob!")
		return FALSE

	if(!desired_proc)
		CRASH_SAFE("recursive_find_mob not supplied with a proc!")
		return FALSE

	if(!desired_obj)
		CRASH_SAFE("recursive_find_mob not supplied with a obj!")
		return FALSE

	for(var/obj/item/I3 in A.worn_objects)
		var/result = recursive_find_item(I3,desired_obj,desired_proc)
		if(result)
			return result
	for(var/obj/item/I3 in A.held_objects)
		var/result = recursive_find_item(I3,desired_obj,desired_proc)
		if(result)
			return result

	return FALSE