/obj/hud/inventory/MouseDrag(over_object,src_location,over_location,src_control,over_control,params)

	if(!is_advanced(usr) || !is_inventory(over_object))
		return ..()

	var/obj/item/I = get_top_object()

	var/mob/living/advanced/A = usr

	var/obj/hud/inventory/over_inventory = over_object
	if(A.click_and_drag_icon.stored_object != I)
		A.click_and_drag_icon.appearance = I.appearance
		A.click_and_drag_icon.stored_object = I
		A.click_and_drag_icon.mouse_opacity = 0
		A.click_and_drag_icon.alpha = 100
		A.click_and_drag_icon.plane = PLANE_HUD_MOUSE

	if(A.click_and_drag_icon.stored_inventory != over_inventory)
		A.click_and_drag_icon.stored_inventory = over_inventory
		A.click_and_drag_icon.screen_loc = over_inventory.screen_loc
		var/obj/item/over_item = over_inventory.get_top_object()
		if((I.loc == over_inventory) || over_inventory.can_hold_object(I,FALSE) || over_inventory.can_wear_object(I,FALSE) || (over_item && over_item.can_add_to_inventory(A,I,FALSE,FALSE)))
			A.click_and_drag_icon.color = "#00FF00"
		else
			A.click_and_drag_icon.color = "#FF0000"

	return ..()

/obj/hud/inventory/proc/get_top_object()
	var/obj/item/I = src.get_top_held_object()
	if(I) return I
	I = src.get_top_worn_object()
	return I