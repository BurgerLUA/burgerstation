

/mob/living/proc/add_hydration(var/hydration_amount)
	hydration = clamp(hydration + hydration_amount,0,hydration_max)
	return hydration_amount




/mob/living/proc/remove_nutrition_mix(var/amount_to_remove=0)

	var/total_removed = 0
	//Quality Nutrition
	var/nutrition_quality_to_remove = min(amount_to_remove*0.5,nutrition_quality)
	nutrition_quality -= nutrition_quality_to_remove
	amount_to_remove -= nutrition_quality_to_remove
	total_removed += nutrition_quality_to_remove
	//Normal Nutrition
	var/nutrition_normal_to_remove = min(amount_to_remove*0.5,nutrition_normal)
	nutrition_normal -= nutrition_normal_to_remove
	amount_to_remove -= nutrition_normal_to_remove
	total_removed += nutrition_quality_to_remove
	//Fast Nutrition
	var/nutrition_fast_to_remove = min(amount_to_remove,nutrition_fast)
	nutrition_fast -= nutrition_fast_to_remove
	amount_to_remove -= nutrition_fast_to_remove
	total_removed += nutrition_fast_to_remove

	if(amount_to_remove > 0)
		nutrition_quality_to_remove = min(amount_to_remove/2,nutrition_quality)
		nutrition_quality = nutrition_quality_to_remove
		nutrition_normal_to_remove = min(amount_to_remove/2,nutrition_normal)
		nutrition_normal -= nutrition_normal_to_remove
		total_removed += nutrition_quality_to_remove + nutrition_normal_to_remove

	nutrition_normal = max(0,nutrition_normal)
	nutrition_fast = max(0,nutrition_fast)
	nutrition_quality = max(0,nutrition_quality)

	return total_removed


/mob/living/proc/add_nutrition_normal(var/nutrition_amount)
	nutrition_normal = clamp(nutrition_normal + nutrition_amount,0,nutrition_max_hard)
	return nutrition_normal

/mob/living/proc/add_nutrition_quality(var/amount)
	nutrition_quality = clamp(nutrition_quality + amount,0,nutrition_max_hard)
	return nutrition_quality

/mob/living/proc/add_nutrition_fast(var/amount)
	nutrition_fast = clamp(nutrition_fast + amount,0,nutrition_max_hard)
	return nutrition_fast

/mob/living/proc/get_nutrition_mod()
	if(nutrition_normal + nutrition_quality + nutrition_fast > nutrition_max)
		return clamp(1 - ((nutrition_normal + nutrition_quality + nutrition_fast - nutrition_max)/nutrition_max),0,1)
	return clamp((nutrition_normal + nutrition_quality + nutrition_fast)/(nutrition_max*0.50),0,1)

/mob/living/proc/get_hydration_mod()
	return clamp(hydration/(hydration_max*0.50),0,1)

/mob/living/proc/get_nutrition_quality_mod() //Scales 0 to 2.
	if(nutrition_quality + nutrition_normal + nutrition_fast <= 0)
		return 0
	return ( (nutrition_quality*2 + nutrition_normal*0.5) / (nutrition_normal*0.5 + nutrition_fast*1.5 + nutrition_quality)) * min( (nutrition_quality+nutrition_normal*0.5)/nutrition_max,1)

/mob/living/proc/is_stuffed()
	return (nutrition_fast + nutrition_quality + nutrition_normal) > nutrition_max_hard

