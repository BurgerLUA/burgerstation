

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

	var/call_result = call(desired_obj,desired_proc)(I)
	if(call_result)
		return I

	for(var/v in I.inventories)
		var/obj/hud/inventory/I2 = v
		for(var/k in I2.contents)
			var/obj/item/I3 = k
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

	for(var/k in A.worn_objects)
		var/obj/item/I3 = k
		var/result = recursive_find_item(I3,desired_obj,desired_proc)
		if(result)
			return result
	for(var/k in A.held_objects)
		var/obj/item/I3 = k
		var/result = recursive_find_item(I3,desired_obj,desired_proc)
		if(result)
			return result

	return FALSE