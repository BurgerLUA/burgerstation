/loot/ammo
	loot_count = 12

/loot/ammo/New(var/desired_loc)
	. = ..()
	for(var/k in subtypesof(/obj/item/magazine/))
		var/obj/item/magazine/M = k
		if(initial(M.value_burgerbux))
			continue
		if(initial(M.value) <= 0)
			continue
		loot_table[M] = 10
	for(var/k in subtypesof(/obj/item/bullet_cartridge/))
		var/obj/item/bullet_cartridge/BC = k
		if(initial(BC.value_burgerbux))
			continue
		if(initial(BC.value) <= 0)
			continue
		loot_table[BC] = 100

/loot/ammo/pre_spawn(var/atom/movable/M)

	if(istype(M,/obj/item/bullet_cartridge/))
		var/obj/item/bullet_cartridge/B = M
		B.amount = B.amount_max

	. = ..()

/loot/gun/
	var/company_type

	var/magazines_to_spawn_min = 3
	var/magazines_to_spawn_max = 5

	var/value_min = 1
	var/value_max = 8000

	var/base_type = /obj/item/weapon/ranged/

/loot/gun/New(var/desired_loc)
	. = ..()
	if(company_type && !length(loot_table))
		for(var/k in subtypesof(base_type))
			var/obj/item/weapon/ranged/R = k
			if(initial(R.company_type) != src.company_type)
				continue
			if(initial(R.value_burgerbux))
				continue
			var/value = initial(R.value)
			if(value < value_min)
				continue
			if(value > value_max)
				continue
			if(ispath(R,/obj/item/weapon/ranged/bullet))
				if(!SSbalance.weapon_to_bullet[R])
					continue
				if(ispath(R,/obj/item/weapon/ranged/bullet/magazine))
					if(!SSbalance.weapon_to_magazine[R])
						continue
			loot_table[R] = 1 + (value_max-(value-value_min)) //R is already a type.

/loot/gun/create_loot_single(var/type_to_spawn,var/spawn_loc,var/rarity=0)

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

/loot/gun/pre_spawn(var/atom/movable/M)

	if(istype(M,/obj/item/bullet_cartridge/))
		var/obj/item/bullet_cartridge/B = M
		B.amount = B.amount_max

	. = ..()



/loot/gun/nanotrasen
	company_type = "NanoTrasen"

/loot/gun/syndicate
	company_type = "Syndicate"

/loot/gun/syndicate/ultra
	value_min = 1000

/loot/gun/solarian
	company_type = "Solarian"
	base_type = /obj/item/weapon/ranged/bullet

/loot/gun/slavic
	company_type = "Slavic"


