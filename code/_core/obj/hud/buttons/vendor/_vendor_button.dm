/obj/hud/button/vendor

	name = "vending button"
	icon = 'icons/hud/vendor_long.dmi'
	icon_state = "large"
	screen_loc = "CENTER,CENTER"

	flags_hud = FLAG_HUD_SPECIAL

	user_colors = TRUE

	maptext = "ITEM NAME HERE"

	var/obj/item/associated_item
	var/obj/structure/interactive/vending/associated_vendor
	var/associated_cost = 1

	mouse_opacity = 1

	has_quick_function = FALSE

	layer = 0

	var/locked //Accepts a string if it's locked.

/obj/hud/button/vendor/get_examine_list(var/mob/activator)
	if(!associated_item)
		return ..()
	return associated_item.get_examine_list(activator)

/obj/hud/button/vendor/get_examine_details_list(var/mob/activator)
	if(!associated_item)
		return ..()
	return associated_item.get_examine_details_list(activator)

/obj/hud/button/vendor/Destroy()
	associated_item = null
	return ..()

/obj/hud/button/vendor/update_overlays()

	. = ..()

	if(!locked)
		var/num_to_text = num2text(associated_cost)
		var/the_length = length(num_to_text)
		var/icon/I2 = ICON_INVISIBLE //The pricetag.

		if(associated_vendor.accepts_item)
			var/icon/I3 = new/icon('icons/hud/numbers.dmi',"[associated_vendor.accepts_item.type]")
			I3.Shift(EAST,1)
			I2.Blend(I3,ICON_OVERLAY)

		else if(!(associated_vendor && associated_vendor.is_free))
			var/icon/I3 = new/icon('icons/hud/numbers.dmi',"T")
			I3.Shift(EAST,1)
			I2.Blend(I3,ICON_OVERLAY)

		var/x_pos_mod = 13

		if(associated_vendor && associated_vendor.is_free && associated_vendor.free_text)
			var/icon/I4 = new/icon('icons/hud/numbers.dmi',associated_vendor.free_text)
			I4.Shift(EAST,x_pos_mod)
			I4.Shift(SOUTH,2)
			I2.Blend(I4,ICON_OVERLAY)
		else
			for(var/i=1,i<=the_length,i++)
				var/letter = copytext(num_to_text,i,i+1)
				var/icon/I4 = new/icon('icons/hud/numbers.dmi',letter)
				if(letter == ".")
					x_pos_mod -= 1
				I4.Shift(EAST,x_pos_mod)
				I4.Shift(SOUTH,2)
				I2.Blend(I4,ICON_OVERLAY)
				if(letter == ".")
					x_pos_mod += 3
				else
					x_pos_mod += 4

		var/image/I4 = new/image(I2)
		I4.pixel_y = -4
		I4.pixel_x = 53
		add_overlay(I4)

	var/image/IM = new/image(associated_item.icon,associated_item.icon_state)
	IM.appearance = associated_item.appearance
	IM.pixel_x = 4
	IM.pixel_y = 8
	IM.pixel_z = 0
	IM.plane = PLANE_HUD_OBJ
	IM.layer = -1
	IM.mouse_opacity = 0
	add_overlay(IM)

	if(locked)
		var/image/LI = new/image(initial(icon),"[icon_state]_locked")
		LI.plane = PLANE_HUD_OBJ
		LI.layer = 1000
		add_overlay(LI)



/obj/hud/button/vendor/update_sprite()

	if(associated_vendor.use_unlock_requirements && associated_item.unlock_requirement && !associated_item.can_unlock(owner))
		locked = associated_item.unlock_requirement

	icon = initial(icon)

	if(owner && owner.client)
		var/client/C = owner.client
		if(C.settings.loaded_data["compact_mode"])
			icon_state = "small"

	. = ..()

	name = associated_item.vendor_name ? associated_item.vendor_name : associated_item.name
	desc_extended = associated_item.desc_extended

	if(locked)
		tooltip_text = locked
	else
		tooltip_text = initial(tooltip_text)
		if(!tooltip_text)
			tooltip_text = generate_tooltip_text(tooltip_text)

	maptext = name
	maptext_width = 128*2
	maptext_x = 2
	maptext_y = 2

	if(locked)
		color = greyscale
	else
		color = initial(color)

/obj/hud/button/vendor/clicked_on_by_object(var/mob/activator,var/atom/object,location,control,params)

	SPAM_CHECK(5)

	if(!associated_item)
		log_error("Warning: Vendor button [src.get_debug_name()] did not have an associated_item!")
		update_owner(null)
		return

	. = ..()

	if(.)

		if(locked)
			activator.to_chat(span("warning","You haven't unlocked that yet: [locked]"))
			return TRUE

		var/obj/item/I = associated_vendor.purchase_item(activator,params,associated_item,associated_cost)

		if(!I || I.qdeleting && !is_item(I)) //Sometimes the item is abstract.
			return TRUE

		if(object && is_item(object) && I.can_transfer_stacks_to(object))
			var/stacks_transfered = I.transfer_amount_to(object)
			if(stacks_transfered)
				activator.to_chat(span("notice","You restock \the [object.name] with [stacks_transfered] stacks."))
			else
				activator.to_chat(span("warning","You can't restock \the [src.name], it's full!"))

		if(is_advanced(activator))
			var/mob/living/advanced/A = activator
			if(!(A.movement_flags & MOVEMENT_RUNNING && I.quick_equip(A)))
				A.put_in_hands(I,params)


/obj/hud/button/close_vendor
	name = "close vendor"
	icon_state = "close_inventory"
	screen_loc = "CENTER,CENTER"

	essential = TRUE

	flags_hud = FLAG_HUD_SPECIAL

	has_quick_function = FALSE

/obj/hud/button/close_vendor/clicked_on_by_object(var/mob/activator,var/atom/object,location,control,params)

	. = ..()

	if(. && is_player(activator))
		var/mob/living/advanced/player/P = activator
		P.set_structure_unactive()

