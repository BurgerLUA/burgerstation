SUBSYSTEM_DEF(balance)
	name = "Balance and Value Subsystem"
	desc = "Makes a balance report of weapons."

	priority = SS_ORDER_PRELOAD

	var/list/stored_dps = list()
	var/list/stored_dph = list()
	var/list/stored_tier = list()
	var/list/stored_killtime = list()

	var/list/stored_value = list() //STORED VALUE SHOULD BE ONLY USED FOR LOOT GENERATION (EXCEPTION: WEAPONS, BULLETS, MAGAZINES)

	var/list/weapon_to_bullet = list()
	var/list/weapon_to_magazine = list()

	var/list/created_bullets = list()
	var/list/created_magazines = list()

/subsystem/balance/proc/process_items(var/turf/T,var/list/everything_else)

	for(var/k in everything_else)
		var/obj/item/I = k
		if(initial(I.value) <= 0)
			continue
		I = new k(T)
		I.initialize_type = INITIALIZE_NONE
		INITIALIZE(I)
		GENERATE(I)
		FINALIZE(I)
		if(I.qdeleting)
			continue
		stored_value[I.type] = I.get_value()
		qdel(I)
		CHECK_TICK_HARD(DESIRED_TICK_LIMIT)


/subsystem/balance/proc/process_bullets(var/turf/T,var/list/bullet_subtypes)
	. = list()
	for(var/k in bullet_subtypes)
		var/obj/item/bullet_cartridge/B = k
		if(initial(B.rarity) != RARITY_COMMON)
			continue
		B = new k(T)
		B.initialize_type = INITIALIZE_NONE
		INITIALIZE(B)
		GENERATE(B)
		FINALIZE(B)
		if(B.qdeleting)
			continue
		created_bullets += B
		stored_value[B.type] = B.get_recommended_value()
		stored_value[B.type] = CEILING(stored_value[B.type],0.01)
		. += B
		CHECK_TICK_HARD(DESIRED_TICK_LIMIT)

/subsystem/balance/proc/process_magazines(var/turf/T,var/list/magazine_subtypes)
	. = list()
	for(var/k in magazine_subtypes)
		var/obj/item/magazine/M = k
		if(initial(M.rarity) != RARITY_COMMON)
			continue
		M = new k(T)
		M.initialize_type = INITIALIZE_NONE
		INITIALIZE(M)
		GENERATE(M)
		FINALIZE(M)
		if(M.qdeleting)
			continue
		created_magazines += M
		stored_value[M.type] = M.bullet_length_best*M.bullet_diameter_best*M.bullet_count_max*0.01
		stored_value[M.type] = CEILING(stored_value[M.type],1)
		if(M.ammo) stored_value[M.type] += stored_value[M.ammo] * M.bullet_count_max
		. += M
		CHECK_TICK_HARD(DESIRED_TICK_LIMIT)

/subsystem/balance/proc/process_weapons(var/turf/T,var/list/weapon_subtypes)
	. = list()
	for(var/k in weapon_subtypes)
		var/obj/item/weapon/W = k
		if(initial(W.value) <= 0)
			continue
		W = new k(T)
		W.initialize_type = INITIALIZE_NONE
		INITIALIZE(W)
		GENERATE(W)
		FINALIZE(W)
		if(W.qdeleting)
			continue
		. += W

		if(istypecache(W,/obj/item/weapon/ranged/bullet))
			var/obj/item/weapon/ranged/bullet/B = W
			for(var/v in created_bullets)
				var/obj/item/bullet_cartridge/C = v
				if(C.rarity != RARITY_COMMON)
					continue
				if(C.bullet_length != B.bullet_length_best)
					continue
				if(C.bullet_diameter != B.bullet_diameter_best)
					continue
				weapon_to_bullet[B.type] = C.type
				break

		if(istypecache(W,/obj/item/weapon/ranged/bullet/magazine))
			var/obj/item/weapon/ranged/bullet/magazine/B = W
			for(var/v in created_magazines)
				var/obj/item/magazine/M = v
				if(M.rarity != RARITY_COMMON)
					continue
				if(!M.weapon_whitelist[B.type])
					continue
				weapon_to_magazine[B.type] = M.type

		var/found_dph = W.get_damage_per_hit()
		if(found_dph)
			stored_dph[W.type] = CEILING(found_dph,1)

		var/found_dps = W.get_dps(found_dph)
		if(found_dps)
			stored_dps[W.type] = CEILING(found_dps,1)

		var/found_killtime = W.get_kill_time()
		stored_killtime[W.type] = CEILING(found_killtime,0.01)

		if(!W.bypass_balance_check)
			var/recommended_tier = FLOOR(max(found_dph-100,found_dps)/100,1)
			stored_tier[W.type] = recommended_tier

		var/found_value = W.get_recommended_value(ARMOR_VALUE_TO_CONSIDER) //The 100 is the armor value. This makes it so that pistols are generally cheaper than rifles that have armor penetration.
		stored_value[W.type] = found_value

		CHECK_TICK_HARD(DESIRED_TICK_LIMIT)

/subsystem/balance/Initialize()

	var/turf/T = locate(1,1,1)

	var/list/stuff_to_delete = list()

	var/list/bullet_subtypes = subtypesof(/obj/item/bullet_cartridge/)
	stuff_to_delete += process_bullets(T,bullet_subtypes)

	var/list/magazine_subtypes = subtypesof(/obj/item/magazine/)
	stuff_to_delete += process_magazines(T,magazine_subtypes)

	var/list/weapon_subtypes = subtypesof(/obj/item/weapon)
	stuff_to_delete += process_weapons(T,weapon_subtypes)

	for(var/k in stuff_to_delete)
		var/obj/item/I = k
		qdel(I)

	var/list/everything_else = subtypesof(/obj/item)
	everything_else -= bullet_subtypes
	everything_else -= magazine_subtypes
	everything_else -= weapon_subtypes

	process_items(T,everything_else)

	sortInsert(stored_dps, /proc/cmp_numeric_asc, associative=TRUE)
	sortInsert(stored_dph, /proc/cmp_numeric_asc, associative=TRUE)
	sortInsert(stored_killtime, /proc/cmp_numeric_asc, associative=TRUE)

	created_bullets.Cut()
	created_magazines.Cut()

	. = ..()
