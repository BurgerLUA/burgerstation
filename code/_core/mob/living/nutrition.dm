/mob/living/proc/add_nutrition(var/nutrition_amount)
	var/nutrition_max = initial(nutrition)
	if(nutrition_amount< 0 && (nutrition + nutrition_amount*3) > nutrition_max)
		nutrition_amount *= 3 //Easier to remove nutrition when fat. I know this isn't realistic but...
	nutrition = clamp(nutrition + nutrition_amount,0,nutrition_max*1.5)
	return nutrition_amount

/mob/living/proc/add_hydration(var/hydration_amount,var/update=TRUE)
	hydration = clamp(hydration + hydration_amount,0,initial(hydration))
	return hydration_amount

/mob/living/proc/add_nutrition_quality(var/amount)
	nutrition_quality = clamp(nutrition_quality + amount,0,2000)
	return nutrition_quality

/mob/living/proc/add_nutrition_fast(var/amount)
	nutrition_fast = clamp(nutrition_fast + amount,0,2000)
	return nutrition_fast

/mob/living/proc/get_nutrition_mod()
	var/nutrition_max = initial(nutrition)
	if(nutrition + nutrition_fast > nutrition_max)
		return clamp(1 - ((nutrition + nutrition_fast - nutrition_max)/nutrition_max),0,1)
	return clamp((nutrition+nutrition_fast)/(nutrition_max*0.50),0,1)

/mob/living/proc/get_hydration_mod()
	return clamp(hydration/(initial(hydration)*0.50),0,1)

/mob/living/proc/get_nutrition_quality_mod()
	return clamp(nutrition_quality/initial(nutrition_quality),0,1.25)