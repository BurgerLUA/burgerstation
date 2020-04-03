/mob/living/proc/add_nutrition(var/nutrition_amount,var/update=TRUE)
	nutrition = clamp(nutrition + nutrition_amount,0,1500)
	if(update)
		for(var/obj/hud/button/hunger/B in buttons)
			B.update_sprite()

/mob/living/proc/add_hydration(var/hydration_amount,var/update=TRUE)
	hydration = clamp(hydration + hydration_amount,0,1500)
	if(update)
		for(var/obj/hud/button/hunger/B in buttons)
			B.update_sprite()


