var/global/list/obj/hud/button/color_scheme_buttons = list(
	/obj/hud/button/color_scheme/color_01,
	/obj/hud/button/color_scheme/color_02,
	/obj/hud/button/color_scheme/color_03,
	/obj/hud/button/color_scheme/color_04,
	/obj/hud/button/color_scheme/color_05,
	/obj/hud/button/color_scheme/color_06,
	/obj/hud/button/close_color_scheme,
	/obj/hud/button/default_color_scheme
)

/obj/hud/button/close_color_scheme
	name = "close color scheme"
	icon_state = "close_inventory"
	screen_loc = "CENTER+3.5,CENTER+2"

/obj/hud/button/close_color_scheme/clicked_on_by_object(var/mob/caller,object,location,control,params)

	if(!is_advanced(caller))
		return ..()

	var/mob/living/advanced/A = caller

	A.remove_color_scheme_buttons()

	if(!A.client || !A.client.settings)
		return ..()

	A.client.settings.save()

	return ..()

/obj/hud/button/default_color_scheme
	name = "close color scheme"
	icon_state = "default"
	screen_loc = "CENTER-3.5,CENTER+2"

/obj/hud/button/default_color_scheme/clicked_on_by_object(var/mob/caller,object,location,control,params)

	if(!is_advanced(caller))
		return ..()

	var/mob/living/advanced/A = caller

	if(!A.client || !A.client.settings || !A.client.settings.loaded_data)
		return ..()

	A.client.settings.loaded_data["hud_colors"] = DEFAULT_COLORS

	for(var/obj/hud/button/B in A.buttons)
		B.update_icon()

	for(var/obj/hud/button/B in A.health_elements)
		B.update_icon()

	for(var/obj/hud/inventory/I in A.inventory)
		I.update_icon()

	A.client.update_window()

	return ..()

/obj/hud/button/color_scheme
	name = "color scheme button changer"
	desc = "Press this."
	desc_extended = "Press this button."
	icon_state = "color_frame"
	screen_loc = "CENTER,CENTER"

	flags = FLAGS_HUD_SPECIAL

	user_colors = FALSE

	var/color_id = 1

/obj/hud/button/color_scheme/clicked_on_by_object(var/mob/caller,object,location,control,params)

	if(!is_advanced(caller))
		return ..()

	var/mob/living/advanced/A = caller

	if(!A.client || !A.client.settings || !A.client.settings.loaded_data)
		return ..()

	var/desired_color = input("Skin Color","Skin Color",A.client.settings.loaded_data["hud_colors"][color_id]) as color|null

	if(desired_color)
		A.client.settings.loaded_data["hud_colors"][color_id] = desired_color

		for(var/obj/hud/button/B in A.buttons)
			B.update_icon()

		for(var/obj/hud/button/B in A.health_elements)
			B.update_icon()

		for(var/obj/hud/inventory/I in A.inventory)
			I.update_icon()

		A.client.update_window()

	return ..()

/obj/hud/button/color_scheme/update_icon()

	if(!owner || !is_advanced(owner))
		return ..()

	var/mob/living/advanced/A = owner

	if(!A.client || !A.client.settings || !A.client.settings.loaded_data)
		return ..()

	var/list/color_settings = A.client.settings.loaded_data["hud_colors"]

	icon = initial(icon)
	icon_state = initial(icon_state)

	var/icon/I = new/icon(icon,icon_state)
	swap_colors(I)

	var/icon/I2 = new/icon(icon,"color_center")
	I2.Blend(color_settings[color_id],ICON_MULTIPLY)

	I.Blend(I2,ICON_OVERLAY)

	icon = I

/obj/hud/button/color_scheme/color_01
	color_id = 1
	screen_loc = "CENTER-2.5,CENTER+2"

/obj/hud/button/color_scheme/color_02
	color_id = 2
	screen_loc = "CENTER-1.5,CENTER+2"

/obj/hud/button/color_scheme/color_03
	color_id = 3
	screen_loc = "CENTER-0.5,CENTER+2"

/obj/hud/button/color_scheme/color_04
	color_id = 4
	screen_loc = "CENTER+0.5,CENTER+2"

/obj/hud/button/color_scheme/color_05
	color_id = 5
	screen_loc = "CENTER+1.5,CENTER+2"

/obj/hud/button/color_scheme/color_06
	color_id = 6
	screen_loc = "CENTER+2.5,CENTER+2"