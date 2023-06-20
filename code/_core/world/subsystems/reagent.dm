SUBSYSTEM_DEF(reagent)
	name = "Reagent Subsystem"
	desc = "Store all the reagents."
	priority = SS_ORDER_FIRST
	tick_rate = SECONDS_TO_TICKS(4)

	var/list/all_reagents = list()

	tick_usage_max = 75

	var/list/all_reagent_recipes = list()
	var/list/reagent_container/all_temperature_reagent_containers = list()

	var/list/stored_book_data = list()

	var/list/valid_random_reagents = list()

/subsystem/reagent/unclog(var/mob/caller)
	tick_rate = -1
	. = ..()

/subsystem/reagent/on_life()

	for(var/k in all_temperature_reagent_containers)
		var/reagent_container/R = k
		if(!R || R.qdeleting)
			all_temperature_reagent_containers -= k
			continue
		if(R.process_temperature() == null) //Failed to process.
			if(R.owner)
				if(!is_living(R.owner) && !is_organ(R.owner))
					qdel(R.owner)
			else
				qdel(R)
			continue
		CHECK_TICK(tick_usage_max,FPS_SERVER)

	return TRUE

/subsystem/reagent/Initialize()

	for(var/k in subtypesof(/reagent/))
		var/reagent/R = k
		R = new k
		all_reagents[R.type] = R
		if(!R.abstract && R.value > 0)
			valid_random_reagents += R.type

	log_subsystem(name,"Initialized [length(all_reagents)] reagents.")

	for(var/k in subtypesof(/reagent_recipe/))
		var/reagent_recipe/RR = new k
		all_reagent_recipes[RR.type] = RR
		for(var/k2 in RR.required_reagents)
			CHECK_TICK_HARD
			var/reagent/R = REAGENT(k2)
			if(!R)
				log_error("WARNING: Non reagent ([k2]) detected in recipe [RR]!")
				continue
			if(!R.involved_in_recipes)
				R.involved_in_recipes = list()
			R.involved_in_recipes += RR.type
			if(!R.has_temperature_recipe && (length(RR.required_temperature_min) || length(RR.required_temperature_max)))
				R.has_temperature_recipe = TRUE

	sort_tim(all_reagent_recipes,/proc/cmp_recipe_name_asc,associative=TRUE) //Its okay to sort by name since this list is only used for the book that gets generated.

	log_subsystem(name,"Initialized [length(all_reagent_recipes)] reagent recipes.")

	var/list/cached_text = list()

	var/list/item_counts = list()

	for(var/recipe_id in all_reagent_recipes)
		CHECK_TICK_HARD
		var/reagent_recipe/RR = all_reagent_recipes[recipe_id]
		if(!RR.result && !RR.results) //The reason it's not length(RR.results) is because the dev who made the recipe acknowledges that it's not supposed to have a recipe result.
			log_error("Warning: [RR.get_debug_name()] had no reagent result(s)!")
			continue

		var/actual_name = RR.name
		actual_name = replacetextEx(actual_name,"\improper","")

		var/recipe_text = ""
		for(var/r_id in RR.required_reagents)
			var/reagent/R = all_reagents[r_id]
			if(!R)
				log_error("Warning: Reagent [r_id] for recipe [RR.type] is an invalid reagent!")
				continue
			var/amount = RR.required_reagents[r_id]
			var/temperature_min = length(RR.required_temperature_min) ? RR.required_temperature_min[r_id] : null
			var/temperature_max = length(RR.required_temperature_max) ? RR.required_temperature_max[r_id] : null
			recipe_text += "- [amount]u [R.name]"
			if(temperature_min)
				recipe_text += ", at least [temperature_min]k"
			if(temperature_max)
				recipe_text += ", at most [temperature_max]k"
			recipe_text += "\n"

		var/result_text = "Makes:\n\n"

		var/atom/A = RR.result
		if(A && !length(RR.results))
			result_text += "- [initial(A.name)]\n\n"

		for(var/r_id in RR.results)
			var/amount = RR.results[r_id]
			var/reagent/R = all_reagents[r_id]
			if(!R)
				log_error("Warning: [r_id] was not a valid reagent ID for recipe [RR.type]!")
				continue
			result_text += "- [amount]u [R.name]\n\n"

		var/desired_text = "# [actual_name]\n\n [RR.desc]\n\n[trim(recipe_text)] \n\n[trim(result_text)]\n\n"
		if(!cached_text[RR.category])
			cached_text[RR.category] = ""
		if(!item_counts[RR.category])
			item_counts[RR.category] = 0
		if(!stored_book_data[RR.category])
			stored_book_data[RR.category] = list()

		cached_text[RR.category] += desired_text
		item_counts[RR.category] += 1
		if(item_counts[RR.category] >= 5)
			stored_book_data[RR.category] += cached_text[RR.category]
			cached_text[RR.category] = ""
			item_counts[RR.category] = 1

	return ..()