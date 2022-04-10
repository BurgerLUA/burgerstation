/mob/living/advanced/proc/update_single_lighting(var/obj/item/I)
	var/dropped = !(I in held_objects) && !(I in worn_objects)
	if(I.light) I.light.update(dropped ? I : src)
	if(I.light_sprite) I.light_sprite.update(dropped ? I : src)
	return TRUE