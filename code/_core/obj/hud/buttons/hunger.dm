/obj/hud/button/hunger
	name = "hunger and thirst"
	desc = "Keep both of these up!"
	desc_extended = "A tracker for your current hunger and thirst levels. These can be replenished by eating and drinking, respectively."

	icon = 'icons/hud/hunger.dmi'
	icon_state = "thirst_bar_0"

	user_colors = FALSE

	var/stored_hunger = -1
	var/stored_thirst = -1

	screen_loc = "RIGHT:-4,BOTTOM+3.2"

	flags = FLAGS_HUD_MOB


/obj/hud/button/hunger/update_owner()

	. = ..()

	update_overlays()

	return .


/obj/hud/button/hunger/proc/update_overlays()

	underlays.Cut()
	var/icon/I = new/icon(initial(icon),"hunger_thirst_background")
	swap_colors(I)
	underlays += I

	return TRUE

/obj/hud/button/hunger/update_icon()

	overlays.Cut()

	icon = initial(icon)

	if(!is_living(owner))
		return ..()

	var/mob/living/L = owner
	var/hunger_mod = (L.nutrition/1000)
	var/thirst_mod = (L.hydration/1000)
	var/hunger_icon = FLOOR(hunger_mod * 20,1)
	var/thirst_icon = FLOOR(thirst_mod * 20,1)

	var/image/I_hunger = new/image(icon,"hunger_bar_[hunger_icon]")
	I_hunger.color = blend_colors("#FF0000","#00FF00",hunger_mod)

	var/image/I_thirst = new/image(icon,"thirst_bar_[thirst_icon]")
	I_thirst.color = blend_colors("#FF0000","#00FF00",thirst_mod)

	overlays += I_hunger
	overlays += I_thirst

	var/icon/I2 = new/icon(icon,"hunger_thirst_detail")
	overlays += I2

	return ..()