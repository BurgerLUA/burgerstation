/loot/
	var/list/loot_table = list()
	var/list/loot_table_guaranteed = list()
	var/loot_count = 1 //How much of this loot to spawn. Doesn't affect loot_table_guaranteed.
	var/allow_duplicates = TRUE //Set to false so it never spawns a duplicate item again.
	var/chance_none = 0 //Applies on a per loot_count basis.
	var/loot_multiplier = 1 //How much of the loot to duplicate.
	var/use_value = FALSE //Use the actual value of a item as a weight instead of the predefined value in the list.
	var/average_value = 0
	var/use_random_item_amounts = FALSE //Set to true to enable random quanity amounts for items spawned.

/loot/proc/check_value()
	average_value = 0
	if(use_value)
		var/highest = 0
		for(var/k in loot_table) //First pass.
			if(ispathcache(k,/loot/))
				var/loot/L = SSloot.all_loot[k]
				highest = max(highest,L.average_value)
			else
				var/obj/item/I = k
				var/found_value = SSbalance.stored_value[I]
				if(use_random_item_amounts)
					found_value *= CEILING(initial(I.amount_max)*0.5,1)
				highest = max(highest,found_value)
		if(!highest)
			log_error("Warning: [src.type] did not have a highest value for loot. Something went wrong.")
		for(var/k in loot_table) //Second pass.
			var/value = 0
			if(ispathcache(k,/loot/))
				var/loot/L = SSloot.all_loot[k]
				value = L.average_value
			else
				var/obj/item/I = k
				value = SSbalance.stored_value[I]
				if(use_random_item_amounts)
					value *= CEILING(initial(I.amount_max)*0.5,1)
			var/actual_weight = highest ? (1 - value/highest)*highest : 1
			actual_weight = 1 + FLOOR(actual_weight,1)
			loot_table[k] = actual_weight
			average_value += value
		sort_tim(loot_table,/proc/cmp_numeric_asc_rand,TRUE)
	else
		for(var/k in loot_table)
			if(ispathcache(k,/loot/))
				var/loot/L = SSloot.all_loot[k]
				average_value += L.average_value
			else
				var/obj/item/I = k
				var/value = SSbalance.stored_value[I]
				if(use_random_item_amounts)
					value *= CEILING(initial(I.amount_max)*0.5,1)
				average_value += value

	for(var/k in loot_table_guaranteed)
		if(ispathcache(k,/loot/))
			var/loot/L = SSloot.all_loot[k]
			average_value += L.average_value
		else
			var/obj/item/I = k
			var/found_value = SSbalance.stored_value[I]
			if(use_random_item_amounts)
				found_value *= CEILING(initial(I.amount_max)*0.5,1)
			average_value += found_value

	average_value *= 1/max(1,length(loot_table) + length(loot_table_guaranteed))
	average_value *= loot_count * loot_multiplier * clamp((100 - chance_none)/100,0,1)



/loot/proc/do_spawn(var/atom/spawn_loc,var/rarity) //Use this to spawn the loot. rarity is optional.

	if(!spawn_loc) CRASH("Invalid spawn_loc!")

	. = create_loot_table(spawn_loc,use_value ? rarity : null)

	for(var/k in .)
		var/obj/item/I = k
		var/list/loot_data = .[k]
		for(var/j in loot_data)
			var/loot/L = j
			L.pre_spawn(I)
		INITIALIZE(I)
		GENERATE(I)
		if(use_random_item_amounts && I.amount_max > 1)
			I.amount = rand(1,I.amount_max)
		FINALIZE(I)
		for(var/j in loot_data)
			var/loot/L = j
			L.post_spawn(I)


/loot/proc/create_loot_single(var/type_to_spawn,var/spawn_loc,var/rarity) //Don't use this. Use do_spawn to spawn loot. Not providing a spawn_loc will just return the types.

	. = list()

	if(islist(type_to_spawn))
		for(var/k in type_to_spawn)
			. += create_loot_single(k,spawn_loc,rarity) //Repeats this proc.
		return .

	if(ispath(type_to_spawn,/loot/))
		var/loot/L = LOOT(type_to_spawn)
		for(var/i=1,i<=loot_multiplier,i++)
			var/list/loot_data = L.create_loot_table(spawn_loc,rarity)
			if(spawn_loc)
				for(var/k in loot_data)
					if(loot_data[k])
						.[k] = loot_data[k]
						.[k] += src
					else
						.[k] = list(src)
			else
				. += loot_data
		return .

	for(var/i=1,i<=loot_multiplier,i++)
		if(spawn_loc)
			var/atom/movable/M = new type_to_spawn(spawn_loc)
			.[M] = list(src)
		else
			. += type_to_spawn

/loot/proc/pre_spawn(var/atom/movable/M)
	return TRUE

/loot/proc/post_spawn(var/atom/movable/M)
	return TRUE

/loot/proc/create_loot_table(var/atom/spawn_loc,var/rarity) //rarity is optional.

	. = list()

	for(var/k in loot_table_guaranteed)
		if(!k) CRASH("Error: Improper selection in loot_table_guaranteed!")
		. += create_loot_single(k,spawn_loc)

	if(length(loot_table) > 0)
		var/list/new_table = allow_duplicates ? loot_table : loot_table.Copy()
		for(var/i=1,i<=loot_count,i++)
			if(prob(chance_none))
				continue
			var/selection = pickweight(new_table,rarity)
			if(!selection) CRASH("Error: Improper selection in loot_table!")
			. += create_loot_single(selection,spawn_loc,rarity)
			if(!allow_duplicates)
				new_table -= selection
				if(length(new_table) <= 0)
					break