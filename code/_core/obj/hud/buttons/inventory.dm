/obj/hud/button/close_inventory
	name = "close inventory"
	icon_state = "close_inventory"
	screen_loc = "CENTER,CENTER"
	alpha = 0
	mouse_opacity = 0

	essential = TRUE

	flags = FLAGS_HUD_MOB | FLAGS_HUD_INVENTORY | FLAGS_HUD_SPECIAL

	has_quick_function = FALSE

	var/inventory_category = "none"

/obj/hud/button/close_inventory/proc/close(var/mob/caller)

	if(is_advanced(caller))
		var/mob/living/advanced/A = caller
		for(var/k in A.using_inventories)
			var/obj/item/I = k
			if(I.inventory_category != inventory_category)
				continue
			I.close_inventory(A)

	return TRUE

/obj/hud/button/close_inventory/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	. = ..()

	if(.)
		close(caller)

/obj/hud/button/hide_show_inventory
	name = "toggle inventory"
	desc = "Need more space? Click this button."
	desc_extended = "Hides your inventory from view. Inventories such as pockets, belts, backpacks, and hands are not hidden."
	icon_state = "view_inventory"
	screen_loc = "LEFT,BOTTOM"

	flags = FLAGS_HUD_MOB | FLAGS_HUD_INVENTORY

	has_quick_function = FALSE

/obj/hud/button/hide_show_inventory/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	. = ..()

	if(. && is_advanced(owner))
		var/mob/living/advanced/A = owner
		A.toggle_inventory(FLAGS_HUD_WORN,FLAGS_HUD_SPECIAL,0.1)
		update_sprite()


/obj/hud/button/hide_show_inventory/update_icon()

	if(!is_advanced(owner))
		return ..()

	var/mob/living/advanced/A = owner


	if(A.draw_inventory)
		icon_state = initial(icon_state)
	else
		icon_state = "[initial(icon_state)]_off"

	..()

/obj/hud/button/close_inventory_defers

	icon_state = "close_inventory"
	screen_loc = "CENTER,CENTER"

	essential = TRUE

	flags = FLAGS_HUD_MOB | FLAGS_HUD_INVENTORY | FLAGS_HUD_SPECIAL

	has_quick_function = FALSE

/obj/hud/button/close_inventory_defers/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	. = ..()

	if(. && is_advanced(caller))
		var/mob/living/advanced/A = caller
		A.clear_inventory_defers()

