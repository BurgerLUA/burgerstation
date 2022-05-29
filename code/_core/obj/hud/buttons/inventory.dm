/obj/hud/button/close_inventory
	name = "close inventory"
	icon_state = "close_inventory"
	screen_loc = "CENTER,CENTER"
	alpha = 0
	mouse_opacity = 0

	essential = TRUE

	flags = FLAG_HUD_MOB | FLAG_HUD_INVENTORY | FLAG_HUD_SPECIAL

	has_quick_function = FALSE

	var/inventory_category = "none"

	var/obj/item/assoc_item

/obj/hud/button/close_inventory/Destroy()
	. = ..()
	assoc_item = null

/obj/hud/button/close_inventory/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	. = ..()

	if(.)
		assoc_item.close_inventory(caller)

/obj/hud/button/hide_show_inventory
	name = "toggle inventory"
	desc = "Need more space? Click this button."
	desc_extended = "Hides your inventory from view. Inventories such as pockets, belts, backpacks, and hands are not hidden."
	icon_state = "view_inventory"
	screen_loc = "LEFT:1,BOTTOM:12"

	flags = FLAG_HUD_MOB | FLAG_HUD_INVENTORY

	has_quick_function = FALSE

/obj/hud/button/hide_show_inventory/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	. = ..()

	if(. && is_advanced(owner))
		var/mob/living/advanced/A = owner
		A.toggle_inventory(FLAG_HUD_WORN,FLAG_HUD_SPECIAL,2)
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

	flags = FLAG_HUD_MOB | FLAG_HUD_INVENTORY | FLAG_HUD_SPECIAL

	has_quick_function = FALSE

/obj/hud/button/close_inventory_defers/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	. = ..()

	if(. && is_advanced(caller))
		var/mob/living/advanced/A = caller
		A.clear_inventory_defers()

