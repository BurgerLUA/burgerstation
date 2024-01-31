

/proc/recursive_find_item(obj/item/I,desired_obj,desired_proc)

	if(!I)
		CRASH("recursive_find_mob not supplied with an item!")

	if(!desired_proc)
		CRASH("recursive_find_mob not supplied with a proc!")

	if(!desired_obj)
		CRASH("recursive_find_mob not supplied with a obj!")


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


/proc/recursive_find_mob(mob/living/advanced/A,desired_obj,desired_proc)

	if(!A)
		CRASH("recursive_find_mob not supplied with an advanced mob!")

	if(!desired_proc)
		CRASH("recursive_find_mob not supplied with a proc!")

	if(!desired_obj)
		CRASH("recursive_find_mob not supplied with a obj!")

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
