/mob/living/proc/add_nutrition(var/nutrition_amount)
	var/nutrition_max = initial(nutrition)
	if(nutrition_amount< 0 && (nutrition + nutrition_amount*3) > nutrition_max)
		nutrition_amount *= 3 //Easier to remove nutrition when fat. I know this isn't realistic but...
	nutrition = clamp(nutrition + nutrition_amount,0,nutrition_max*1.5)

/mob/living/proc/add_hydration(var/hydration_amount,var/update=TRUE)
	hydration = clamp(hydration + hydration_amount,0,initial(hydration))

/mob/living/proc/get_nutrition_mod()
	var/nutrition_max = initial(nutrition)
	if(nutrition > nutrition_max)
		return clamp(1 - ((nutrition - nutrition_max)/nutrition_max),0,1)
	return clamp(nutrition/(nutrition_max*0.50),0,1)

/mob/living/proc/get_hydration_mod()
	return clamp(hydration/(initial(hydration)*0.50),0,1)