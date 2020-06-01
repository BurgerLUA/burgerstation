/mob/living/proc/add_nutrition(var/nutrition_amount,var/update=TRUE)
	nutrition = clamp(nutrition + nutrition_amount,0,initial(nutrition))
	if(update)
		for(var/obj/hud/button/hunger/B in buttons)
			B.update_sprite()

/mob/living/proc/add_hydration(var/hydration_amount,var/update=TRUE)
	hydration = clamp(hydration + hydration_amount,0,initial(hydration))
	if(update)
		for(var/obj/hud/button/hunger/B in buttons)
			B.update_sprite()


/mob/living/proc/get_nutrition_mod()
	return client ? clamp(nutrition/(initial(nutrition)*0.50),0,1) : 1

/mob/living/proc/get_hydration_mod()
	return client ? clamp(hydration/(initial(hydration)*0.50),0,1) : 1