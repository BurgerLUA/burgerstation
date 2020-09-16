/mob/living/advanced/proc/update_lighting()

	var/list/obj/item/final_list = worn_objects + held_objects

	for(var/k in final_list)
		var/obj/item/I = k
		if(I.light)
			I.light.update(src)

	return TRUE