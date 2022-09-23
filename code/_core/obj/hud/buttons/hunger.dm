/obj/hud/button/hunger
	name = "hunger and thirst"
	desc = "Keep both of these up!"
	desc_extended = "A tracker for your current hunger and thirst levels. These can be replenished by eating and drinking, respectively."

	icon = 'icons/hud/hunger.dmi'
	icon_state = "thirst_bar_0"

	user_colors = FALSE

	var/stored_hunger = -1
	var/stored_thirst = -1

	screen_loc = "RIGHT:-8,CENTER-1"

	flags_hud = FLAG_HUD_MOB


/obj/hud/button/hunger/update_owner()
	. = ..()
	update_sprite()

/obj/hud/button/hunger/get_examine_list(var/mob/caller)

	. = ..()

	if(is_living(caller))
		var/mob/living/L = caller
		var/quality_mod = L.get_nutrition_quality_mod()
		var/nut_mod = L.get_nutrition_mod()
		var/hyd_mod = L.get_hydration_mod()
		. += "Your nutrition is [FLOOR(nut_mod*100,1)]%."
		. += "Your nutritional quality is [FLOOR(100*quality_mod,0.1)]%."
		. += "Your energy level is [FLOOR(100 * nut_mod * hyd_mod * quality_mod,1)]%."



/obj/hud/button/hunger/update_underlays()
	. = ..()
	var/icon/IC = new/icon(initial(icon),"base")
	swap_colors(IC)
	var/image/I = new/image(IC)
	I.appearance_flags = RESET_COLOR
	add_underlay(I)

/obj/hud/button/hunger/update_overlays()
	. = ..()
	var/image/I = new/image(initial(icon),"hunger_icon")
	I.pixel_y = -16
	I.appearance_flags = RESET_COLOR
	add_overlay(I)


/obj/hud/button/hunger/update_icon()

	. = ..()

	var/mob/living/L = owner

	var/hunger_mod_visual = min( (L.nutrition_fast+L.nutrition)/L.nutrition_max, 1)
	var/hunger_mod_real = L.get_nutrition_mod()
	var/hunger_icon = CEILING(clamp(hunger_mod_visual * 24,0,24),1)

	var/fatass_mod = (L.nutrition_fast+L.nutrition-L.nutrition_max) / (L.nutrition_max_hard - L.nutrition_max)
	var/fatass_icon = CEILING(clamp(fatass_mod * 4,0,4),1)

	//Color bullshit.
	var/good_color = "#00FF00"
	var/bad_color = "#FF0000"
	var/fat_color = "#EAEAEA"
	if(owner && owner.client)
		var/color_scheme = owner.client.settings.loaded_data["hud_colors"]
		good_color = color_scheme[4]
		fat_color = color_scheme[5]
		bad_color = color_scheme[6]

	icon = initial(icon)
	if(fatass_mod > 0)
		icon_state = "bar_fat_[fatass_icon]"
		color = fat_color
	else
		icon_state = "bar_[hunger_icon]"
		color = blend_colors(bad_color,good_color,hunger_mod_real)
