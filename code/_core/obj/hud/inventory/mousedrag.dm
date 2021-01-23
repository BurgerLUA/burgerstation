/obj/hud/inventory/MouseDrag(over_object,src_location,over_location,src_control,over_control,params)

	if(!is_advanced(usr) || !is_inventory(over_object))
		return ..()

	var/mob/living/advanced/player/A = usr
	var/obj/item/I = get_top_object()

	if(!I || !A)
		return ..()

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
		if(I.can_be_dragged(A) && get_dist(I,over_inventory) <= 1 && ((I.loc == over_inventory) || over_inventory.can_slot_object(I,FALSE) || (over_item && over_item.can_add_to_inventory(A,I,FALSE,FALSE))))
			A.click_and_drag_icon.color = "#00FF00"
		else
			A.click_and_drag_icon.color = "#FF0000"

	/*
	if(istype(over_inventory,/obj/hud/inventory/crafting/) && I.item_count_current > 1) //WE MINECRAFT NOW.
		var/obj/item/existing_item = over_inventory.get_top_object()
		if(!existing_item && I.add_item_count(-1))
			var/obj/item/I2 = copy(I)
			I2.item_count_current = 1
			I2.update_sprite()
			over_inventory.add_object(I2)
	*/

	return ..()