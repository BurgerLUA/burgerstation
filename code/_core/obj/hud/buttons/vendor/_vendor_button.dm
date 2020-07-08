/obj/hud/button/vendor

	name = "vending button"
	desc = "Press this."
	desc_extended = "Press this button."
	icon = 'icons/hud/vendor.dmi'
	icon_state = "vendor_base"
	screen_loc = "CENTER,CENTER"

	flags = FLAGS_HUD_SPECIAL

	user_colors = TRUE

	maptext = "ITEM NAME HERE"

	var/obj/item/associated_item
	var/obj/structure/interactive/vending/associated_vendor

	mouse_opacity = 1

	has_quick_function = FALSE

/obj/hud/button/vendor/get_examine_list(var/mob/caller)
	if(associated_item && !ispath(associated_item))
		return associated_item.get_examine_list(caller)
	return ..()

/obj/hud/button/vendor/Destroy()
	associated_item = null
	return ..()

/obj/hud/button/vendor/update_overlays()

	. = ..()

	var/sale_amount = CEILING(associated_item.calculate_value(),1)
	var/num_to_text = num2text(sale_amount)
	var/the_length = length(num_to_text)

	var/icon/I2 = ICON_INVISIBLE

	if(!(associated_vendor && associated_vendor.is_free))
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
			I4.Shift(EAST,x_pos_mod)
			I4.Shift(SOUTH,2)
			I2.Blend(I4,ICON_OVERLAY)
			x_pos_mod += 5

	var/image/I4 = new/image(I2)
	I4.pixel_y = -4
	I4.pixel_x = 35
	add_overlay(I4)

	if(ispath(associated_item))
		var/image/IM = new/image(initial(associated_item.icon),initial(associated_item.icon_state))
		IM.color = initial(associated_item.color)
		IM.pixel_y = 4
		add_overlay(IM)
	else
		associated_item.pixel_y = 4
		add_overlay(associated_item)

	return .

/obj/hud/button/vendor/update_sprite()

	. = ..()

	var/desired_name

	if(!ispath(associated_item))
		desired_name = associated_item.vendor_name ? associated_item.vendor_name : associated_item.name
	else
		desired_name = initial(associated_item.vendor_name) ? initial(associated_item.vendor_name) : associated_item.name

	maptext = desired_name
	maptext_width = 96*2
	maptext_x = 2
	maptext_y = 2

	name = desired_name

	return .

/obj/hud/button/vendor/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	. = ..()

	if(!associated_item)
		CRASH_SAFE("Warning: Vendor button [src.get_debug_name()] did not have an associated_item!")
		update_owner(null)
		return .

	if(. && is_player(caller))
		var/mob/living/advanced/player/P = caller
		var/atom/defer_object = object.defer_click_on_object(location,control,params)
		var/item_value = CEILING(associated_item.calculate_value(),1)

		if(!is_inventory(defer_object))
			P.to_chat(span("notice","Your hand needs to be empty in order to buy this!"))
			return TRUE

		var/obj/hud/inventory/I = defer_object
		associated_vendor.purchase_item(caller,associated_item,item_value,I)

	return .


/obj/hud/button/close_vendor
	name = "close vendor"
	icon_state = "close_inventory"
	screen_loc = "CENTER,CENTER"

	essential = TRUE

	flags = FLAGS_HUD_SPECIAL

	has_quick_function = FALSE

	interaction_flags = FLAG_INTERACTION_LIVING | FLAG_INTERACTION_DEAD | FLAG_INTERACTION_NO_DISTANCE

/obj/hud/button/close_vendor/clicked_on_by_object(var/mob/caller,object,location,control,params)

	. = ..()

	if(. && is_player(caller))
		var/mob/living/advanced/player/P = caller
		P.set_structure_unactive()

	return .