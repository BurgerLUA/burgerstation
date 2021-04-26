SUBSYSTEM_DEF(enchanting)
	name = "Enchanting Subsystem"
	desc = "Store all the enchantments."
	priority = SS_ORDER_PRELOAD
	var/list/all_prefix_enchantments = list()
	var/list/all_suffix_enchantments = list()

	var/list/all_prefix_enchantments_by_rarity = list()
	var/list/all_suffix_enchantments_by_rarity = list()

/subsystem/enchanting/Initialize()

	for(var/k in subtypesof(/ench/prefix/))
		var/ench/E = k
		if(initial(E.name) && initial(E.desc))
			E = new k
			all_prefix_enchantments[E.type] = E
			all_prefix_enchantments_by_rarity[E] = E.rarity

	log_subsystem(name,"Initialized [length(all_prefix_enchantments)] suffix enchantments.")

	for(var/k in subtypesof(/ench/suffix/))
		var/ench/E = k
		if(initial(E.name) && initial(E.desc))
			E = new k
			all_suffix_enchantments[E.type] = E
			all_suffix_enchantments_by_rarity[E] = E.rarity

	log_subsystem(name,"Initialized [length(all_suffix_enchantments)] suffix enchantments.")

	return ..()

/proc/get_random_enchantment(var/ench_type=ENCH_ANY,var/list/whitelist,var/list/blacklist)

	var/list/possible_enchantments = list()

	if(whitelist)
		possible_enchantments += whitelist
	else
		if(ench_type & ENCH_PREFIX)
			possible_enchantments += SSenchanting.all_prefix_enchantments_by_rarity

		if(ench_type & ENCH_SUFFIX)
			possible_enchantments += SSenchanting.all_suffix_enchantments_by_rarity

	if(blacklist)
		possible_enchantments -= blacklist

	return pickweight(possible_enchantments)
