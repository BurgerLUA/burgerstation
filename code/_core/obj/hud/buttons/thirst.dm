/obj/hud/button/thirst
	name = "hunger and thirst"
	desc = "Keep both of these up!"
	desc_extended = "A tracker for your current hunger and thirst levels. These can be replenished by eating and drinking, respectively."

	icon = 'icons/hud/hunger.dmi'
	icon_state = "thirst_bar_0"

	user_colors = FALSE

	var/stored_hunger = -1
	var/stored_thirst = -1

	screen_loc = "RIGHT:8,CENTER-1"

	flags_hud = FLAG_HUD_MOB


/obj/hud/button/thirst/update_owner()
	. = ..()
	if(. && owner)
		update_sprite()

/obj/hud/button/thirst/get_examine_list(var/mob/caller)

	. = ..()

	if(is_living(caller))
		var/mob/living/L = caller
		var/hydration_mod = L.get_hydration_mod()

		switch(hydration_mod)
			if(-INFINITY to 0.2)
				. += div("danger","You're dehydrated!")
			if(0.2 to 0.3)
				. += div("warning","You're very thirsty!")
			if(0.3 to 0.5)
				. += div("warning","You're thirsty.")
			if(0.5 to 0.7)
				. += div("notice","You could use something to drink.")
			if(0.7 to INFINITY)
				. += div("notice","You're not thirsty.")

		. += "Your hydration level is [FLOOR(hydration_mod*100,1)]%."



/obj/hud/button/thirst/update_underlays()
	. = ..()
	var/icon/IC = new/icon(initial(icon),"base")
	swap_colors(IC)
	var/image/I = new/image(IC)
	I.appearance_flags = RESET_COLOR
	add_underlay(I)

/obj/hud/button/thirst/update_overlays()
	. = ..()
	var/image/I = new/image(initial(icon),"thirst_icon")
	I.pixel_y = -16
	I.appearance_flags = RESET_COLOR
	add_overlay(I)


/obj/hud/button/thirst/update_icon()

	. = ..()

	var/mob/living/L = owner

	var/hydration_mod_visual = min( (L.hydration)/L.hydration_max, 1)
	var/hydration_mod_real = L.get_hydration_mod()
	var/hydration_icon = CEILING(clamp(hydration_mod_visual * 24,0,24),1)

	//Color bullshit.
	var/good_color = "#00FF00"
	var/bad_color = "#FF0000"
	if(owner && owner.client)
		var/color_scheme = owner.client.settings.loaded_data["hud_colors"]
		good_color = color_scheme[4]
		bad_color = color_scheme[6]

	icon = initial(icon)
	icon_state = "bar_[hydration_icon]"
	color = blend_colors(bad_color,good_color,hydration_mod_real)

