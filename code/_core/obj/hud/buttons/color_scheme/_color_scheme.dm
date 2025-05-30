var/global/static/list/obj/hud/button/color_scheme_buttons = list(
	/obj/hud/button/color_scheme/color_01,
	/obj/hud/button/color_scheme/color_02,
	/obj/hud/button/color_scheme/color_03,
	/obj/hud/button/color_scheme/color_04,
	/obj/hud/button/color_scheme/color_05,
	/obj/hud/button/color_scheme/color_06,
	/obj/hud/button/color_scheme/color_07,
	/obj/hud/button/close_color_scheme,
	/obj/hud/button/default_color_scheme
)

/obj/hud/button/close_color_scheme
	name = "close color scheme"
	icon_state = "close_inventory"
	screen_loc = "CENTER+3.5,CENTER+2"

	has_quick_function = FALSE

/obj/hud/button/close_color_scheme/clicked_on_by_object(var/mob/activator,var/atom/object,location,control,params)

	. = ..()

	if(. && is_advanced(activator) && activator.client && activator.client.settings)
		var/mob/living/advanced/A = activator
		A.remove_color_scheme_buttons()
		A.client.settings.save()


/obj/hud/button/default_color_scheme
	name = "default color scheme"
	desc_extended = "Clicking here will reset the color scheme to the original burgerstation blue color scheme."
	icon_state = "default"
	screen_loc = "CENTER-4.5,CENTER+2"

	has_quick_function = FALSE

/obj/hud/button/default_color_scheme/clicked_on_by_object(var/mob/activator,var/atom/object,location,control,params)

	. = ..()

	if(. && is_advanced(activator) && activator.client && activator.client.settings && activator.client.settings.loaded_data)
		var/mob/living/advanced/A = activator
		A.client.settings.loaded_data["hud_colors"] = DEFAULT_COLORS

		for(var/k in A.buttons)
			var/obj/hud/button/B = k
			B.update_sprite()

		for(var/k in A.health_elements)
			var/obj/hud/button/B = A.health_elements[k]
			B.update_sprite()

		for(var/k in A.inventories_by_id)
			var/obj/hud/inventory/I = A.inventories_by_id[k]
			I.update_sprite()

		A.client.update_window()


/obj/hud/button/color_scheme
	name = "change color scheme"
	desc = "Pretty colors."
	icon_state = "color_frame"
	screen_loc = "CENTER,CENTER"

	flags_hud = FLAG_HUD_SPECIAL

	user_colors = FALSE

	var/color_id = 1

	has_quick_function = FALSE

/obj/hud/button/color_scheme/clicked_on_by_object(var/mob/activator,var/atom/object,location,control,params)

	. = ..()

	if(. && is_advanced(activator) && activator.client && activator.client.settings && activator.client.settings.loaded_data)
		var/mob/living/advanced/A = activator
		var/desired_color = input("Skin Color","Skin Color",A.client.settings.loaded_data["hud_colors"][color_id]) as color|null
		if(desired_color)
			A.client.settings.loaded_data["hud_colors"][color_id] = desired_color

			for(var/k in A.buttons)
				var/obj/hud/button/B = k
				B.update_sprite()

			for(var/k in A.health_elements)
				var/obj/hud/button/B = A.health_elements[k]
				B.update_sprite()

			for(var/k in A.inventories_by_id)
				var/obj/hud/inventory/I = A.inventories_by_id[k]
				I.update_sprite()

			A.client.update_window()


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
	screen_loc = "CENTER-3.5,CENTER+2"

/obj/hud/button/color_scheme/color_02
	color_id = 2
	screen_loc = "CENTER-2.5,CENTER+2"

/obj/hud/button/color_scheme/color_03
	color_id = 3
	screen_loc = "CENTER-1.5,CENTER+2"

/obj/hud/button/color_scheme/color_04
	color_id = 4
	screen_loc = "CENTER-0.5,CENTER+2"

/obj/hud/button/color_scheme/color_05
	color_id = 5
	screen_loc = "CENTER+0.5,CENTER+2"

/obj/hud/button/color_scheme/color_06
	color_id = 6
	screen_loc = "CENTER+1.5,CENTER+2"

/obj/hud/button/color_scheme/color_07
	color_id = 7
	screen_loc = "CENTER+2.5,CENTER+2"