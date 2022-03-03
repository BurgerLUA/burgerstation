/obj/item/clothing/glasses/nightvision
	name = "nightvision goggles"

	desc = "Kept you waiting, huh?"
	desc_extended = "A pair of tactical nightvision goggles. Keep away from light."
	icon = 'icons/obj/item/clothing/glasses/nightvision.dmi'

	see_in_dark = VIEW_RANGE + ZOOM_RANGE

	armor = /armor/mechanical/night_vision

	value = 100

	item_slot_layer = 2

	worn_layer = LAYER_MOB_CLOTHING_ALL

	var/active = FALSE

/obj/item/clothing/glasses/nightvision/Finalize()
	. = ..()
	update_sprite()

/obj/item/clothing/glasses/nightvision/update_icon()
	. = ..()
	icon = initial(icon)
	icon_state = initial(icon_state)
	icon_state_worn = initial(icon_state_worn)
	if(!active)
		icon_state = "[icon_state]_off"
		icon_state_worn = "[icon_state_worn]_off"

/obj/item/clothing/glasses/nightvision/click_self(var/mob/caller)

	var/obj/hud/inventory/I = src.loc
	if(istype(I))
		INTERACT_CHECK
		INTERACT_DELAY(1)
		active = !active
		if(active)
			enable(I)
		else
			disable(I)
		caller.to_chat(span("notice","You toggle \the [src.name] [active ? "on" : "off"]."))
		update_sprite()
		if(I.worn && is_advanced(I.owner))
			var/mob/living/advanced/A = I.owner
			A.remove_overlay("\ref[src]")
			I.update_worn_icon(src)
		return TRUE

	. = ..()


/obj/item/clothing/glasses/nightvision/proc/enable(var/obj/hud/inventory/I)
	var/list/desired_color = list(
		1,1,0,0,
		0,1,0,0,
		0,1,1,0,
		0,0,0,1,
		0,0,0,0
	)
	I.owner.add_color_mod("\ref[src]",desired_color)
	I.owner.add_lighting_mod("\ref[src]",100)
	return TRUE


/obj/item/clothing/glasses/nightvision/proc/disable(var/obj/hud/inventory/I)
	I.owner?.remove_color_mod("\ref[src]")
	I.owner?.remove_lighting_mod("\ref[src]")
	return TRUE

/obj/item/clothing/glasses/nightvision/pre_pickup(var/atom/old_location,var/obj/hud/inventory/new_location)

	. = ..()

	if(active && is_inventory(old_location))
		disable(old_location)

	if(active && new_location.item_slot & SLOT_FACE)
		enable(new_location)

