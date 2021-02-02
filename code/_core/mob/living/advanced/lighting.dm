/*
/mob/living/advanced/proc/update_all_lighting()

	var/list/obj/item/final_list = worn_objects + held_objects

	for(var/k in final_list)
		var/obj/item/I = k
		if(I.light) I.light.update(src)
		if(I.light_sprite) I.light_sprite.update(src)

	return TRUE
*/

/mob/living/advanced/proc/update_single_lighting(var/obj/item/I)
	var/dropped = !(I in held_objects) && !(I in worn_objects)
	if(I.light) I.light.update(dropped ? I : src)
	if(I.light_sprite) I.light_sprite.update(dropped ? I : src)
	return TRUE