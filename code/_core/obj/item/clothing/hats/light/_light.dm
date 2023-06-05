/obj/item/clothing/head/light
	var/enabled = FALSE

	desired_light_range = VIEW_RANGE*0.5
	desired_light_power = 0.5
	desired_light_color = "#FFD175"
	desired_light_angle = LIGHT_OMNI

/obj/item/clothing/head/light/update_overlays()
	. = ..()
	if(enabled)
		var/image/I = new/image(initial(icon),"[icon_state]_light_on")
		I.appearance_flags = src.appearance_flags | RESET_COLOR
		add_overlay(I)


/obj/item/clothing/head/light/initialize_worn_blends(var/desired_icon_state)

	. = ..()

	add_blend(
		"light",
		desired_icon = initial(icon),
		desired_icon_state = "[desired_icon_state]_light_off",
		desired_color = desired_light_color,
		desired_blend = ICON_OVERLAY,
		desired_type = ICON_BLEND_OVERLAY,
		desired_should_save = FALSE,
		desired_layer = worn_layer + 0.1
	)

/obj/item/clothing/head/light/click_self(var/mob/caller,location,control,params)
	INTERACT_CHECK
	INTERACT_DELAY(10)
	enabled = !enabled
	update_sprite()
	update_atom_light()
	if(is_inventory(src.loc))
		var/obj/hud/inventory/I = src.loc
		if(I.worn) I.update_worn_icon(src)
	return TRUE

/obj/item/clothing/head/light/update_atom_light()
	if(enabled)
		set_light_sprite(desired_light_range, desired_light_power, desired_light_color,desired_light_angle)
	else
		set_light_sprite(FALSE)
	return TRUE