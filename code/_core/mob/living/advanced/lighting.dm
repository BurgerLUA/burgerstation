/mob/living/advanced/proc/update_lighting()

	var/list/obj/item/final_list = worn_objects + held_objects

	for(var/obj/item/I in final_list)
		if(I.light)
			I.light.update(src)

	return TRUE