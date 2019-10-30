/obj/item/container/food/raw
	name = "raw food"
	desc = "Not quite edible yet."

/obj/item/container/food/dynamic/bread
	name = "dough"
	icon = 'icons/obj/items/consumable/food/dynamic_bread.dmi'
	icon_state = "dough"
	crafting_id = "dough"

/obj/item/container/food/dynamic/bread/update_icon()

	if(!reagents || !reagents.stored_reagents || !length(reagents.stored_reagents))
		return ..()

	color = reagents.color

	var/total_dough = 0
	var/total_bread = 0

	var/best_dough_reagent_id
	var/best_dough_reagent_amount

	var/best_bread_reagent_id
	var/best_bread_reagent_amount

	var/wetness = 0
	var/wetness_prefix = "perfect"

	var/cooked_percent = 0

	for(var/reagent_id in reagents.stored_reagents)
		var/amount = reagents.stored_reagents[reagent_id]

		wetness += all_reagents[reagent_id].liquid*(amount/reagents.volume_current)

		if(has_prefix(reagent_id,"dough_"))

			total_dough += amount

			if(best_dough_reagent_id && best_dough_reagent_amount >= amount)
				continue

			best_dough_reagent_id = reagent_id
			best_dough_reagent_amount = amount

		if(has_prefix(reagent_id,"bread_"))

			total_bread += amount

			if(best_bread_reagent_id && best_bread_reagent_amount >= amount)
				continue

			best_bread_reagent_id = reagent_id
			best_bread_reagent_amount = amount

	cooked_percent = total_bread / (total_dough + total_bread)


	if(cooked_percent > 0.5) //It's bread
		switch(wetness)
			if(-INFINITY to -20)
				wetness_prefix = "dry"
			if(20 to INFINITY)
				wetness_prefix = "moist"

		if(best_bread_reagent_id)
			name = "[wetness_prefix] [all_reagents[best_bread_reagent_id].name]"
		else
			name = "[wetness_prefix] mystery bread"

	else //It's dough
		switch(wetness)
			if(-INFINITY to -20)
				wetness_prefix = "dry"
			if(20 to INFINITY)
				wetness_prefix = "wet"

		if(best_dough_reagent_id)
			name = "[wetness_prefix] [all_reagents[best_dough_reagent_id].name]"
		else
			name = "[wetness_prefix] mystery dough"

	icon_state = cooked_percent > 0.5 ? "bread" : "dough_ball"
	color = reagents.color

	return ..()