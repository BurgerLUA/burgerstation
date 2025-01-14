SUBSYSTEM_DEF(loot)
	name = "Loot Subsystem"
	desc = "Yes."
	priority = SS_ORDER_LOOT
	var/list/all_loot = list()

	var/list/unobtainable_items = list() //item = weight, higher weight means less value

/subsystem/loot/Initialize()

	var/list/loot_to_check = list()
	var/list/checked_loot = list()

	for(var/k in subtypesof(/loot/))
		var/loot/L = new k
		all_loot[L.type] = L
		loot_to_check += L.type

	var/i = 1
	while(length(loot_to_check) > 0)
		CHECK_TICK_HARD
		if(i > length(loot_to_check))
			i = 1
		var/loot/L = all_loot[loot_to_check[i]]
		var/valid_check = TRUE
		//Process the loot_table.
		for(var/k in L.loot_table)
			if(ispath(k,/loot/) && !(k in checked_loot))
				valid_check = FALSE
				break
		if(!valid_check)
			i++
			continue
		//Process the loot_table_guaranteed.
		for(var/k in L.loot_table_guaranteed)
			if(ispath(k,/loot/) && !(k in checked_loot))
				valid_check = FALSE
				break
		if(!valid_check)
			i++
			continue
		L.check_value()
		checked_loot += L.type
		loot_to_check -= L.type

	var/list/all_items = subtypesof(/obj/item)

	//Dirty as fuck, but at least it runs once.
	for(var/k in SSloot.all_loot)
		var/loot/L = SSloot.all_loot[k]
		for(var/j in L.loot_table)
			all_items -= j
		for(var/j in L.loot_table_guaranteed)
			all_items -= j

	for(var/k in SSloadouts.all_loadouts)
		var/loadout/L = SSloadouts.all_loadouts[k]
		for(var/j in L.spawning_items)
			all_items -= j

	for(var/k in all_items)
		var/obj/item/I = k
		if(I.value <= 0)
			continue
		if(!I.can_save)
			continue
		if(SSbalance.can_save_loadout[I.type])
			continue
		var/found_value = SSbalance.stored_value[I]
		if(!found_value) //Could be null
			found_value = 0
		unobtainable_items[I] = CEILING(found_value,1)

	sort_tim(unobtainable_items,/proc/cmp_numeric_dsc,associative=TRUE)

	log_subsystem(name,"Initialized [length(all_loot)] loot tables.")

	return ..()