/mob/living/proc/remove_nutrition_mix(amount_to_remove=0)

	. = 0

	var/total_nutrition = nutrition_normal + nutrition_quality + nutrition_fast

	if(total_nutrition <= 0)
		return 0

	if(nutrition_normal > 0)
		var/nutrtion_normal_m = (1/3) / (nutrition_normal/total_nutrition)
		. -= add_nutrition_normal( -CEILING(amount_to_remove*nutrtion_normal_m,1) )

	if(nutrition_fast > 0)
		var/nutrtion_fast_m = (1/3) / (nutrition_fast/total_nutrition)
		. -= add_nutrition_fast( -CEILING(amount_to_remove*nutrtion_fast_m,1) )

	if(nutrition_quality > 0)
		var/nutrtion_quality_m = (1/3) / (nutrition_quality/total_nutrition)
		. -= add_nutrition_quality( -CEILING(amount_to_remove*nutrtion_quality_m,1) )

	return .

/mob/living/proc/add_hydration(amount)
	var/amount_to_add = clamp(amount,-hydration,hydration_max-hydration)
	hydration += amount_to_add
	return amount_to_add

/mob/living/proc/add_nutrition_normal(amount)
	var/amount_to_add = clamp(amount,-nutrition_normal,nutrition_max_hard-nutrition_normal)
	nutrition_normal += amount_to_add
	return amount_to_add

/mob/living/proc/add_nutrition_quality(amount)
	var/amount_to_add = clamp(amount,-nutrition_quality,nutrition_max_hard-nutrition_quality)
	nutrition_quality += amount_to_add
	return amount_to_add

/mob/living/proc/add_nutrition_fast(amount)
	var/amount_to_add = clamp(amount,-nutrition_fast,nutrition_max_hard-nutrition_fast)
	nutrition_fast += amount_to_add
	return amount_to_add

/mob/living/proc/get_nutrition_mod() //Scales 0 to 1.
	var/total_nutrition = nutrition_normal + nutrition_quality + nutrition_fast
	if(total_nutrition > nutrition_max) //Fat
		return max(0,1 - (total_nutrition - nutrition_max)/nutrition_max)
	return min( (2*total_nutrition)/nutrition_max,1)

/mob/living/proc/get_hydration_mod()
	return clamp(hydration/(hydration_max*0.50),0,1)

/mob/living/proc/get_nutrition_quality_mod() //Scales 0 to 2.
	if(nutrition_quality + nutrition_normal + nutrition_fast <= 0)
		return 0
	return ( (nutrition_quality*2 + nutrition_normal*0.5) / (nutrition_normal*0.5 + nutrition_fast*1.5 + nutrition_quality)) * min( (nutrition_quality+nutrition_normal*0.5)/nutrition_max,1)

/mob/living/proc/is_stuffed()
	return (nutrition_fast + nutrition_quality + nutrition_normal) > nutrition_max_hard

