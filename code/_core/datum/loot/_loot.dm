/loot/
	var/list/loot_table = list()
	var/list/loot_table_guaranteed = list()
	var/loot_count = 1 //How much of this loot to spawn.
	var/allow_duplicates = TRUE //Set to false so it never spawns a duplicate item again.
	var/chance_none = 0 //Applies on a per item basis.
	var/loot_multiplier = 1 //How much of the loot to duplicate.

/loot/proc/do_spawn(var/atom/spawn_loc,var/rarity=0) //Use this to spawn the loot. rarity is optional.
	if(!spawn_loc) CRASH("Invalid spawn_loc!")
	. = create_loot_table(spawn_loc,rarity)
	for(var/k in .)
		var/atom/movable/M = k
		pre_spawn(M)
		INITIALIZE(M)
		GENERATE(M)
		FINALIZE(M)
		post_spawn(M)
		//animate(M,pixel_x = initial(M.pixel_x) + rand(-8,8),pixel_y = initial(M.pixel_y) + rand(-8,8), time = 5)

	//Order of operations
	//do_spawn -> create_loot_table -> create_loot_single

/loot/proc/create_loot_single(var/type_to_spawn,var/spawn_loc,var/rarity=0) //Don't use this. Use do_spawn to spawn loot. Not providing a spawn_loc will just return the types.

	. = list()

	if(ispath(type_to_spawn,/loot/))
		var/loot/L = LOOT(type_to_spawn)
		for(var/i=1,i<=loot_multiplier,i++)
			. += L.create_loot_table(spawn_loc,rarity)
		return

	for(var/i=1,i<=loot_multiplier,i++)
		if(spawn_loc)
			. += new type_to_spawn(spawn_loc)
		else
			. += type_to_spawn

/loot/proc/pre_spawn(var/atom/movable/M)
	return TRUE

/loot/proc/post_spawn(var/atom/movable/M)
	return TRUE

/loot/proc/create_loot_table(var/atom/spawn_loc,var/rarity=0) //rarity is optional

	var/list/new_table = allow_duplicates ? loot_table : loot_table.Copy()

	. = list()

	for(var/k in loot_table_guaranteed)
		. += create_loot_single(k,spawn_loc,rarity)

	if(length(new_table) <= 0)
		return .

	for(var/i=1,i<=loot_count,i++)
		if(prob(chance_none))
			continue
		var/selection = pickweight(loot_table,rarity)
		. += create_loot_single(selection,spawn_loc,rarity)
		if(!allow_duplicates)
			new_table -= selection
			if(length(new_table) <= 0)
				break