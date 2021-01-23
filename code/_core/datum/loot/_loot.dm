/loot/
	var/list/loot_table = list()
	var/list/loot_table_guaranteed = list()
	var/loot_count = 1 //How much of this loot to spawn.
	var/allow_duplicates = TRUE //Set to false so it never spawns a duplicate item again.
	var/chance_none = 0 //Applies on a per item basis.
	var/loot_multiplier = 1 //How much of the loot to duplicate.

/loot/proc/create_loot(var/type_to_spawn,var/spawn_loc) //Don't use this.

	. = list()

	if(ispath(type_to_spawn,/loot/))
		var/loot/L = LOOT(type_to_spawn)
		for(var/i=1,i<=loot_multiplier,i++)
			. += L.create_loot_table(spawn_loc)
		return .

	for(var/i=1,i<=loot_multiplier,i++)
		. += new type_to_spawn(spawn_loc)

	return .

/loot/proc/pre_spawn(var/atom/movable/M)
	return TRUE

/loot/proc/post_spawn(var/atom/movable/M)
	return TRUE

/loot/proc/do_spawn(var/spawn_loc)
	. = create_loot_table(spawn_loc)
	for(var/k in .)
		var/atom/movable/M = k
		pre_spawn(M)
		INITIALIZE(M)
		GENERATE(M)
		FINALIZE(M)
		post_spawn(M)
		//animate(M,pixel_x = initial(M.pixel_x) + rand(-8,8),pixel_y = initial(M.pixel_y) + rand(-8,8), time = 5)
	return .

/loot/proc/create_loot_table(var/spawn_loc) //Use this to spawn the loot.

	var/list/new_table = loot_table.Copy()

	. = list()

	for(var/k in loot_table_guaranteed)
		. += create_loot(k,spawn_loc)

	if(length(loot_table))
		for(var/i=1,i<=loot_count,i++)
			if(length(new_table) <= 0)
				break
			if(prob(chance_none))
				continue
			var/selection = pickweight(loot_table)
			if(!allow_duplicates)
				new_table -= selection
			. += create_loot(selection,spawn_loc)

	return .
