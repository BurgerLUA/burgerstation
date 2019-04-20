/obj/button/close_inventory
	icon_state = "close_inventory"
	screen_loc = "CENTER,CENTER"
	alpha = 0
	mouse_opacity = 0

	essential = TRUE

/obj/button/close_inventory/clicked_by_object(var/mob/caller,object,location,control,params)

	if(!is_advanced(caller))
		return TRUE

	var/mob/living/advanced/A = caller

	for(var/obj/inventory/I in A.inventory)
		if(!I.is_container)
			continue
		animate(I,alpha=0,time=4)
		I.mouse_opacity = 0

	animate(src,alpha=0,time=4)
	src.mouse_opacity = 0

	return TRUE