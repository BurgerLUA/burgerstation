SUBSYSTEM_DEF(loot)
	name = "Loot Subsystem"
	desc = "Yes."
	priority = SS_ORDER_LOOT
	var/list/all_loot = list()
	var/list/recursive_loot = list()

/subsystem/loot/Initialize()

	var/list/loot_to_check = list()

	var/list/created_items = list()

	for(var/k in subtypesof(/loot/))
		var/loot/L = new k
		all_loot[L.type] = L
		loot_to_check += L.type

	var/turf/T = locate(1,1,1)

	while(length(loot_to_check) > 0)
		var/k = loot_to_check[1]
		var/loot/L = all_loot[k]
		loot_to_check -= k
		var/isolated = TRUE
		for(var/j in L.loot_table)
			if(ispathcache(k,/obj/item))
				if(SSbalance.stored_value[k])
					continue
				var/obj/item/I = k
				if(created_items[I])
					I = created_items[I]
				else
					I = new k(T)
					I.initialize_type = INITIALIZE_NONE
					created_items[k] = I
				if(isnull(I.get_base_value()))
					isolated = FALSE
					break
				continue
			if(!ispathcache(j,/loot)) //Not loot. Must be something else.
				continue
			if(!(j in loot_to_check)) //Already checked!
				continue
			isolated = FALSE
			break
		for(var/j in L.loot_table_guaranteed)
			if(ispathcache(k,/obj/item))
				if(SSbalance.stored_value[k])
					continue
				var/obj/item/I = k
				if(created_items[I])
					I = created_items[I]
				else
					I = new k
					created_items[k] = I
				if(isnull(I.get_base_value()))
					isolated = FALSE
					break
				continue
			if(!ispathcache(j,/loot)) //Not loot. Must be something else.
				continue
			if(!(j in loot_to_check)) //Already checked!
				continue
			isolated = FALSE
			break
		if(!isolated)
			//log_subsystem(name,"[k] was not isolated. Moving to back...")
			loot_to_check += k //Move to back. Check again later.
		else
			L.check_value()
			//log_subsystem(name,"[k] was set to a value of [L.average_value].")
		CHECK_TICK(95,FPS_SERVER)

	for(var/k in created_items)
		var/obj/item/I = created_items[k]
		qdel(I)

	log_subsystem(name,"Initialized [length(all_loot)] loot tables.")

	return ..()