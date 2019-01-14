mob/living/advanced/on_left_click(object,location,control,params)
	for(var/obj/inventory/I in inventory)
		if((I.click_flags & RIGHT_HAND) || (src.attack_flags & ATTACK_KICK && I.click_flags & RIGHT_FOOT))
			I.click_on_object(src,object,location,control,params)

mob/living/advanced/on_right_click(object,location,control,params)
	for(var/obj/inventory/I in inventory)
		if((I.click_flags & LEFT_HAND) || (src.attack_flags & ATTACK_KICK && I.click_flags & LEFT_FOOT))
			I.click_on_object(src,object,location,control,params)


/mob/living/advanced/on_left_drop(var/atom/src_object,over_object,src_location,over_location,src_control,over_control,aug)
	src_object.drop_on_object(src,over_object)

/mob/living/advanced/on_right_drop(var/atom/src_object,over_object,src_location,over_location,src_control,over_control,aug)
	src_object.drop_on_object(src,over_object)







/mob/living/advanced/proc/get_left_hand()
	for(var/obj/inventory/I in inventory)
		if (I.click_flags & LEFT_HAND)
			return I

/mob/living/advanced/proc/get_right_hand()
	for(var/obj/inventory/I in inventory)
		if (I.click_flags & RIGHT_HAND)
			return I

/mob/living/advanced/proc/do_automatic_left()
	if(automatic_left && client)
		automatic_left.do_automatic(src,client.last_object,client.last_location,client.last_params)

/mob/living/advanced/proc/do_automatic_right()
	if(automatic_right && client)
		automatic_right.do_automatic(src,client.last_object,client.last_location,client.last_params)
