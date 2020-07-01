/loot/
	var/list/loot_table = list()
	var/list/loot_table_guaranteed = list()
	var/loot_count = 1 //How much of this loot to spawn.
	var/allow_duplicates = TRUE //Set to false so it never spawns a duplicate item again.
	var/chance_none = 0 //Applies on a per item basis.


/loot/proc/spawn_loot(var/type_to_spawn,var/spawn_loc) //Don't use this.

	if(ispath(type_to_spawn,/loot/))
		var/loot/L = LOOT(type_to_spawn)
		return L.spawn_loot_table(spawn_loc)

	var/atom/movable/M = new type_to_spawn(spawn_loc)
	INITIALIZE(M)
	GENERATE(M)
	return M

/loot/proc/spawn_loot_table(var/spawn_loc) //Use this to spawn the loot.

	var/list/new_table = loot_table.Copy()

	. = list()

	for(var/k in loot_table_guaranteed)
		spawn_loot(k,spawn_loc)

	if(length(loot_table))
		for(var/i=1,i<=loot_count,i++)
			if(length(new_table) <= 0)
				break
			if(prob(chance_none))
				continue
			var/selection = pickweight(loot_table)
			if(!allow_duplicates)
				new_table -= selection
			. += spawn_loot(selection,spawn_loc)

	return .
