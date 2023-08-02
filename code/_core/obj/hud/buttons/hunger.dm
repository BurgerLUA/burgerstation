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

/obj/hud/button/hunger/get_examine_list(var/mob/examiner)
	. = ..()

	if(is_living(examiner))
		var/mob/living/L = examiner
		var/nutrition_mod = (L.nutrition_normal + L.nutrition_quality + L.nutrition_fast)/(L.nutrition_max)

		switch(nutrition_mod)
			if(-INFINITY to 0.2)
				. += div("danger","You're starving!")
			if(0.2 to 0.3)
				. += div("warning","You're very hungry!")
			if(0.3 to 0.5)
				. += div("warning","You're hungry.")
			if(0.5 to 0.7)
				. += div("notice","You could use a bite to eat.")
			if(0.7 to 0.9)
				. += div("notice","You're not hungry.")
			if(0.9 to 1)
				. += div("notice","You're full.")
			if(1 to INFINITY)
				. += div("warning","You're overfed!")

		. += "Total Nutrition: [FLOOR(nutrition_mod*100,1)]%."
		. += "Nutritional Health: [FLOOR(L.get_nutrition_quality_mod()*100,1)]%."


/obj/hud/button/hunger/update_owner()
	. = ..()
	if(owner)
		update_sprite()

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

	var/total_nutrition =  L.nutrition_quality+L.nutrition_fast+L.nutrition_normal

	var/hunger_mod_visual = min( total_nutrition/L.nutrition_max, 1)
	var/hunger_mod_real = L.get_nutrition_mod()
	var/hunger_icon = CEILING(clamp(hunger_mod_visual * 24,0,24),1)

	var/fatass_mod = (total_nutrition - L.nutrition_max) / max(1,L.nutrition_max_hard - L.nutrition_max)
	var/fatass_icon = CEILING(clamp(fatass_mod * 4,0,4),1)

	var/quality_mod_real = L.get_nutrition_quality_mod()

	//Color bullshit.
	var/good_color = "#00FF00"
	var/bad_color = "#FF0000"
	var/fat_color = "#EAEAEA"
	var;quality_color = "#FFFF00"
	if(owner && owner.client)
		var/color_scheme = owner.client.settings.loaded_data["hud_colors"]
		good_color = color_scheme[4]
		fat_color = color_scheme[5]
		bad_color = color_scheme[6]
		quality_color = color_scheme[7]

	icon = initial(icon)
	if(fatass_mod > 0)
		icon_state = "bar_fat_[fatass_icon]"
		color = fat_color
	else
		icon_state = "bar_[hunger_icon]"
		color = blend_colors(blend_colors(bad_color,good_color,hunger_mod_real),quality_color,clamp(quality_mod_real - 0.5,0,1))

