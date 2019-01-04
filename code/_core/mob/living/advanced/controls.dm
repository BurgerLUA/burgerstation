mob/living/advanced/on_left_click(object,location,control,params)
	for(var/obj/inventory/I in inventory)
		if((I.click_flags & RIGHT_HAND) || (src.attack_flags & ATTACK_KICK && I.click_flags & RIGHT_FOOT))
			I.attack_object(src,object,location,control,params)

mob/living/advanced/on_right_click(object,location,control,params)
	for(var/obj/inventory/I in inventory)
		if((I.click_flags & LEFT_HAND) || (src.attack_flags & ATTACK_KICK && I.click_flags & LEFT_FOOT))
			I.attack_object(src,object,location,control,params)


/mob/living/advanced/proc/get_left_hand()
	for(var/obj/inventory/I in inventory)
		if (I.click_flags & LEFT_HAND)
			return I

/mob/living/advanced/proc/get_right_hand()
	for(var/obj/inventory/I in inventory)
		if (I.click_flags & RIGHT_HAND)
			return I
