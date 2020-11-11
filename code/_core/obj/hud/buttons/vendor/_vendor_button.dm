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
	var/associated_cost = 1

	mouse_opacity = 1

	has_quick_function = FALSE

/obj/hud/button/vendor/get_examine_list(var/mob/caller)
	return associated_item.get_examine_list(caller)

/obj/hud/button/vendor/Destroy()
	associated_item = null
	return ..()

/obj/hud/button/vendor/update_overlays()

	. = ..()

	var/num_to_text = num2text(associated_cost)
	var/the_length = length(num_to_text)

	var/icon/I2 = ICON_INVISIBLE

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
			I4.Shift(EAST,x_pos_mod)
			I4.Shift(SOUTH,2)
			I2.Blend(I4,ICON_OVERLAY)
			x_pos_mod += 5

	var/image/I4 = new/image(I2)
	I4.pixel_y = -4
	I4.pixel_x = 35
	add_overlay(I4)

	var/image/IM = new/image(associated_item.icon,associated_item.icon_state)
	IM.appearance = associated_item.appearance
	IM.pixel_x = 0
	IM.pixel_y = 4
	IM.pixel_z = 0
	IM.plane = PLANE_HUD_OBJ
	add_overlay(IM)

	return .

/obj/hud/button/vendor/update_sprite()

	. = ..()

	name = associated_item.vendor_name ? associated_item.vendor_name : associated_item.name

	maptext = name
	maptext_width = 96*2
	maptext_x = 2
	maptext_y = 2

	return .

/obj/hud/button/vendor/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	. = ..()

	if(!associated_item)
		CRASH_SAFE("Warning: Vendor button [src.get_debug_name()] did not have an associated_item!")
		update_owner(null)
		return .

	if(.)
		associated_vendor.purchase_item(caller,associated_item,associated_cost)

	return .


/obj/hud/button/close_vendor
	name = "close vendor"
	icon_state = "close_inventory"
	screen_loc = "CENTER,CENTER"

	essential = TRUE

	flags = FLAGS_HUD_SPECIAL

	has_quick_function = FALSE

	interaction_flags = FLAG_INTERACTION_LIVING | FLAG_INTERACTION_DEAD | FLAG_INTERACTION_NO_DISTANCE

/obj/hud/button/close_vendor/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	. = ..()

	if(. && is_player(caller))
		var/mob/living/advanced/player/P = caller
		P.set_structure_unactive()

	return .