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

	mouse_opacity = 1

/obj/hud/button/vendor/get_examine_text(var/mob/caller)
	if(associated_item)
		return associated_item.get_examine_text(caller)
	return ..()

/obj/hud/button/vendor/Destroy()
	associated_item = null
	return ..()

/obj/hud/button/vendor/update_icon()

	. = ..()

	overlays.Cut()
	overlays += associated_item

	var/amount = associated_item.value

	var/num_to_text = num2text(amount)
	var/the_length = length(num_to_text)

	var/icon/I2 = ICON_INVISIBLE

	var/icon/I3 = new/icon('icons/hud/numbers.dmi',"T")
	I3.Shift(EAST,1)
	I2.Blend(I3,ICON_OVERLAY)
	var/x_pos_mod = 11

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
	overlays += I4

	maptext = associated_item.name
	maptext_width = 96*2
	maptext_x = 2
	maptext_y = 1

	name = associated_item.name

	return .

/obj/hud/button/vendor/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(!is_player(caller))
		return ..()

	var/mob/living/advanced/player/P = caller
	var/atom/defer_object = object.defer_click_on_object()

	if(!is_inventory(defer_object))
		P.to_chat(span("notice","Your hand needs to be empty in order to buy this!"))
		return TRUE

	var/obj/hud/inventory/I = defer_object

	if(P.currency >= associated_item.value && P.spend_currency(associated_item.value)) //Just in case
		spawn()
			var/obj/item/new_item = new associated_item.type(get_turf(caller))
			new_item.on_spawn()
			new_item.update_icon()
			new_item.transfer_item(I)
			P.to_chat(span("notice","You have successfully purchased \the [new_item] for [associated_item.value] telecrystal\s."))

	return ..()