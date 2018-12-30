mob/living/advanced/on_left_click(object,location,control,params)
	for(var/obj/inventory/I in inventory)
		if(I.click_flags & RIGHT_HAND)
			I.use_item_on(src,object,location,control,params)

mob/living/advanced/on_right_click(object,location,control,params)
	for(var/obj/inventory/I in inventory)
		if(I.click_flags & LEFT_HAND)
			I.use_item_on(src,object,location,control,params)