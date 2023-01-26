/loot/
	var/list/loot_table = list()
	var/list/loot_table_guaranteed = list()
	var/loot_count = 1 //How much of this loot to spawn.
	var/allow_duplicates = TRUE //Set to false so it never spawns a duplicate item again.
	var/chance_none = 0 //Applies on a per loot_count basis.
	var/loot_multiplier = 1 //How much of the loot to duplicate.
	var/use_value = FALSE //Use the actual value of a weapon as a weight instead of the predefined value in the list.

/loot/New(var/desired_loc)

	. = ..()

	if(length(loot_table))
		if(use_value)
			var/highest = 0
			for(var/k in loot_table)
				if(!ispathcache(k,/obj/item/))
					log_error("Error: use_value was set to TRUE for [src.get_debug_name()], but not everything in the loot_table was an item!")
					use_value = FALSE
					break
				highest = max(highest,SSbalance.stored_value[k])
			if(use_value)
				for(var/k in loot_table)
					var/value = SSbalance.stored_value[k]
					var/actual_weight = (1 - value/highest)*highest
					actual_weight = 1 + FLOOR(actual_weight,1)
					loot_table[k] = actual_weight

		sort_tim(loot_table,/proc/cmp_numeric_asc_rand,TRUE)

/loot/proc/do_spawn(var/atom/spawn_loc,var/rarity) //Use this to spawn the loot. rarity is optional.
	if(!spawn_loc) CRASH("Invalid spawn_loc!")
	. = create_loot_table(spawn_loc,use_value ? rarity : null)
	for(var/k in .)
		var/atom/movable/M = k
		var/list/loot_data = .[k]
		for(var/j in loot_data)
			var/loot/L = j
			L.pre_spawn(M)
		INITIALIZE(M)
		GENERATE(M)
		FINALIZE(M)
		for(var/j in loot_data)
			var/loot/L = j
			L.post_spawn(M)


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