/loot/assorted_ammo/

	loot_table = list(
		/loot/random/magazine = 1,
		/loot/random/bullet = 2
	)


/loot/assorted_ammo/lots
	loot_count = 4
	loot_multiplier = 5


/loot/random/gun/
	var/company_type

	var/magazines_to_spawn_min = 3
	var/magazines_to_spawn_max = 5

	value_min = 1
	value_max = 8000

	base_type = /obj/item/weapon/ranged/

	rarity_min = RARITY_COMMON
	rarity_max = RARITY_RARE

	var/debug = FALSE


/loot/random/gun/generate_loot_table()

	for(var/k in subtypesof(base_type))
		var/obj/item/weapon/ranged/R = k
		if(company_type && initial(R.company_type) != src.company_type)
			continue
		var/initial_value = SSbalance.stored_value[k]
		if(initial_value <= 0)
			continue
		if(initial_value < value_min)
			continue
		if(initial_value > value_max)
			continue
		var/initial_rarity = initial(R.rarity)
		if(rarity_to_number[initial_rarity] < rarity_to_number[rarity_min])
			continue
		if(rarity_to_number[initial_rarity] > rarity_to_number[rarity_max])
			continue
		if(!initial(R.can_save))
			continue
		if(initial(R.contraband))
			continue
		if(initial(R.value_burgerbux) > 0)
			continue
		if(ispath(R,/obj/item/weapon/ranged/bullet))
			if(!SSbalance.weapon_to_bullet[R])
				continue
			if(ispath(R,/obj/item/weapon/ranged/bullet/magazine))
				if(!SSbalance.weapon_to_magazine[R])
					continue
		loot_table[R] = 1 //Correct multipliers added later.

	return TRUE

/loot/random/gun/create_loot_single(var/type_to_spawn,var/spawn_loc,var/rarity=0)

	. = ..()

	if(magazines_to_spawn_min > 0 && magazines_to_spawn_max > 0) //Give extra ammo.
		for(var/k in .)
			var/path_fix
			if(spawn_loc)
				if(!istype(k,/obj/item/weapon/ranged/bullet/))
					continue
				var/obj/item/weapon/ranged/bullet/W = k
				path_fix = W.type
			else
				if(!ispath(k,/obj/item/weapon/ranged/bullet/))
					continue
				path_fix = k
			if(SSbalance.weapon_to_magazine[path_fix])
				for(var/i=1,i<=rand(magazines_to_spawn_min,magazines_to_spawn_max),i++)
					var/obj/item/magazine/M = SSbalance.weapon_to_magazine[path_fix]
					if(spawn_loc)
						M = new M(spawn_loc)
					. += M
			else if(SSbalance.weapon_to_bullet[path_fix])
				for(var/i=1,i<=rand(magazines_to_spawn_min,magazines_to_spawn_max),i++)
					var/obj/item/bullet_cartridge/BC = SSbalance.weapon_to_bullet[path_fix]
					if(spawn_loc)
						BC = new BC(spawn_loc)
						BC.amount = BC.amount_max
					. += BC

/loot/random/gun/pre_spawn(var/atom/movable/M)

	if(istype(M,/obj/item/bullet_cartridge/))
		var/obj/item/bullet_cartridge/B = M
		B.amount = B.amount_max

	. = ..()



/loot/random/gun/nanotrasen
	company_type = "NanoTrasen"

/loot/random/gun/nanotrasen/bandit
	value_max = 1000
	rarity_min = RARITY_COMMON
	rarity_max = RARITY_COMMON

/loot/random/gun/syndicate
	company_type = "Syndicate"

/loot/random/gun/syndicate/bandit
	value_max = 1000
	rarity_min = RARITY_COMMON
	rarity_max = RARITY_COMMON

/loot/random/gun/syndicate/ultra
	value_min = 1000

/loot/random/gun/solarian
	company_type = "Solarian"

/loot/random/gun/solarian/bandit
	value_max = 1000
	rarity_min = RARITY_COMMON
	rarity_max = RARITY_COMMON

/loot/random/gun/slavic
	company_type = "Slavic"

/loot/random/gun/slavic/bandit
	value_max = 1000
	rarity_min = RARITY_COMMON
	rarity_max = RARITY_COMMON