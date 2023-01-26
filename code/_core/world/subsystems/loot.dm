SUBSYSTEM_DEF(loot)
	name = "Loot Subsystem"
	desc = "Yes."
	priority = SS_ORDER_POSTLOAD
	var/list/all_loot = list()
	var/list/recursive_loot = list()

/subsystem/loot/Initialize()

	var/list/loot_to_check = list()

	for(var/k in subtypesof(/loot/))
		var/loot/L = new k
		all_loot[L.type] = L
		loot_to_check += L.type

	while(length(loot_to_check) > 0)
		var/k = loot_to_check[1]
		var/loot/L = all_loot[k]
		loot_to_check -= k
		var/isolated = TRUE
		for(var/j in L.loot_table)
			if(!ispathcache(j,/loot)) //Not loot. Forget about it.
				continue
			if(!(j in loot_to_check)) //Already checked!
				continue
			isolated = FALSE
		for(var/j in L.loot_table_guaranteed)
			if(!ispathcache(j,/loot)) //Not loot. Forget about it.
				continue
			if(!(j in loot_to_check)) //Already checked!
				continue
			isolated = FALSE
		if(!isolated)
			//log_subsystem(name,"[k] was not isolated. Moving to back...")
			loot_to_check += k //Move to back. Check again later.
		else
			L.check_value()
			//log_subsystem(name,"[k] was set to a value of [L.average_value].")
		CHECK_TICK_HARD(95)

	log_subsystem(name,"Initialized [length(all_loot)] loot tables.")

	return ..()