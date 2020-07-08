/obj/hud/button/close_inventory
	icon_state = "close_inventory"
	screen_loc = "CENTER,CENTER"
	alpha = 0
	mouse_opacity = 0

	essential = TRUE

	flags = FLAGS_HUD_MOB | FLAGS_HUD_INVENTORY | FLAGS_HUD_SPECIAL

	has_quick_function = FALSE

	interaction_flags = FLAG_INTERACTION_LIVING | FLAG_INTERACTION_DEAD | FLAG_INTERACTION_NO_DISTANCE

/obj/hud/button/close_inventory/clicked_on_by_object(var/mob/caller,object,location,control,params)

	. = ..()

	if(. && is_advanced(caller))

		var/mob/living/advanced/A = caller

		for(var/obj/hud/inventory/I in A.inventory)
			if(!(I.flags & FLAGS_HUD_CONTAINER))
				continue
			animate(I,alpha=0,time=4)
			I.mouse_opacity = 0

		animate(src,alpha=0,time=4)
		src.mouse_opacity = 0

	return .

/*
/obj/hud/button/drop
	name = "drop item"
	desc = "Drop the item in this slot."
	icon_state = "extension_left"
	screen_loc = "CENTER-1.5,BOTTOM"
	var/left = 0

	flags = FLAGS_HUD_MOB

/obj/hud/button/drop/left
	icon_state = "extension_right"
	screen_loc = "CENTER+1.5,BOTTOM"
	left = 1

/obj/hud/button/drop/clicked_on_by_object(var/mob/caller,object,location,control,params)

	if(!is_advanced(caller))
		return TRUE

	var/mob/living/advanced/A = caller

	if(left)
		if(A.left_hand)
			A.left_hand.drop_held_objects(A.loc)

	else
		if(A.right_hand)
			A.right_hand.drop_held_objects(A.loc)

	return TRUE
*/

/obj/hud/button/hide_show_inventory
	name = "toggle inventory"
	desc = "Need more space? Click this button."
	desc_extended = "Hides your inventory from view. Inventories such as pockets, belts, backpacks, and hands are not hidden."
	icon_state = "view_inventory"
	screen_loc = "LEFT,BOTTOM"

	flags = FLAGS_HUD_MOB | FLAGS_HUD_INVENTORY

	has_quick_function = FALSE

/obj/hud/button/hide_show_inventory/clicked_on_by_object(var/mob/caller,object,location,control,params)

	. = ..()

	if(. && is_advanced(owner))
		var/mob/living/advanced/A = owner
		A.toggle_inventory(FLAGS_HUD_WORN,FLAGS_HUD_SPECIAL,0.1)
		update_sprite()

	return .

/obj/hud/button/hide_show_inventory/update_icon()

	if(!is_advanced(owner))
		return ..()

	var/mob/living/advanced/A = owner


	if(A.draw_inventory)
		icon_state = initial(icon_state)
	else
		icon_state = "[initial(icon_state)]_off"

	..()