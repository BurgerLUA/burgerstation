/loot/gun/
	var/company_type
	var/magazines_to_spawn = 4


/loot/gun/New(var/desired_loc)
	. = ..()
	if(company_type && !length(loot_table))
		for(var/k in subtypesof(/obj/item/weapon/ranged/))
			var/obj/item/weapon/ranged/R = k
			if(initial(R.company_type) != src.company_type)
				continue
			if(initial(R.value_burgerbux))
				continue
			var/value = initial(R.value)
			if(value <= 0)
				continue
			loot_table[R] = CEILING(100000/value,1)

/loot/gun/nanotrasen
	company_type = "NanoTrasen"



/loot/gun/create_loot_single(var/type_to_spawn,var/spawn_loc,var/rarity=0)

	. = ..()

	if(spawn_loc && magazines_to_spawn > 0)
		for(var/obj/item/weapon/ranged/bullet/W in .) //So weapons don't spawn empty.
			if(SSbalance.weapon_to_bullet[W.type])
				for(var/i=1,i<=magazines_to_spawn,i++)
					var/obj/item/bullet_cartridge/BC = SSbalance.weapon_to_bullet[W.type]
					BC = new(spawn_loc)
					BC.amount = BC.amount_max
					. += BC
			if(SSbalance.weapon_to_magazine[W.type])
				for(var/i=1,i<=magazines_to_spawn,i++)
					var/obj/item/magazine/M = SSbalance.weapon_to_magazine[W.type]
					M = new(spawn_loc)
					. += M








