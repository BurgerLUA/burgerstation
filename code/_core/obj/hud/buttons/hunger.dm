/obj/hud/button/hunger
	name = "hunger and thirst"
	desc = "Keep both of these up!"
	desc_extended = "A tracker for your current hunger and thirst levels. These can be replenished by eating and drinking, respectively."

	icon = 'icons/hud/hunger.dmi'
	icon_state = "thirst_bar_0"

	user_colors = FALSE

	var/stored_hunger = -1
	var/stored_thirst = -1

	screen_loc = "RIGHT:-2,CENTER-3"

	flags = FLAGS_HUD_MOB


/obj/hud/button/hunger/update_owner()

	. = ..()

	update_underlays()
	update_overlays()

	return .

/obj/hud/button/hunger/get_examine_list(var/mob/caller)

	. = ..()

	if(is_living(caller))
		var/mob/living/L = caller
		var/quality_mod = L.get_nutrition_quality_mod()
		. += "Your nutrition is [L.nutrition_fast+L.nutrition]/[initial(L.nutrition)]."
		. += "Your hydration is [L.hydration]/[initial(L.hydration)]."
		. += "Your nutritional quality is [FLOOR(100*quality_mod,0.1)]%."
		. += "Your energy level is [FLOOR(100 * L.get_nutrition_mod() * L.get_hydration_mod() * quality_mod,1)]%."


	return .

/obj/hud/button/hunger/update_underlays()

	. = ..()

	var/icon/I = new/icon(initial(icon),"hunger_thirst_background")
	swap_colors(I)
	underlays += I

	return .

/obj/hud/button/hunger/update_overlays()

	. = ..()

	if(!is_living(owner))
		return .

	var/initial_icon = initial(icon)

	var/mob/living/L = owner
	var/visual_hunger_mod = (L.nutrition_fast+L.nutrition)/(initial(L.nutrition)*0.95)
	var/visual_thirst_mod = L.hydration/(initial(L.hydration)*0.95)
	var/hunger_mod = L.get_nutrition_mod()
	var/thirst_mod = L.get_hydration_mod()
	var/hunger_icon = FLOOR(clamp(visual_hunger_mod * 20,0,20),1)
	var/thirst_icon = FLOOR(clamp(visual_thirst_mod * 20,0,20),1)


	var/image/I_hunger = new/image(initial_icon,"hunger_bar_[hunger_icon]")
	var/image/I_thirst = new/image(initial_icon,"thirst_bar_[thirst_icon]")


	if(visual_hunger_mod > 1 && hunger_mod < 1) //Fat
		I_hunger.color = blend_colors("#000000","#808080",hunger_mod)
	else
		I_hunger.color = hunger_mod >= 1 ? "#00FF00" : blend_colors("#FF0000","#FFFF00",hunger_mod)

	I_thirst.color = thirst_mod >= 1 ? "#00FF00" : blend_colors("#FF0000","#FFFF00",thirst_mod)

	add_overlay(I_hunger)
	add_overlay(I_thirst)

	var/icon/I2 = new/icon(icon,"hunger_thirst_detail")
	add_overlay(I2)

	return .