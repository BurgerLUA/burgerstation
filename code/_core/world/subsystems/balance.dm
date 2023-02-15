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
		B = new k(T)
		B.initialize_type = INITIALIZE_NONE
		INITIALIZE(B)
		GENERATE(B)
		FINALIZE(B)
		if(B.qdeleting)
			continue
		if(B.rarity == RARITY_COMMON) //Only consider normal bullets.
			created_bullets += B
		stored_value[B.type] = B.get_recommended_value()
		stored_value[B.type] = CEILING(stored_value[B.type],0.01)
		. += B
		CHECK_TICK_HARD(DESIRED_TICK_LIMIT)

/subsystem/balance/proc/process_magazines(var/turf/T,var/list/magazine_subtypes)
	. = list()
	for(var/k in magazine_subtypes)
		var/obj/item/magazine/M = k
		if(initial(M.bullet_count_max) <= 0)
			continue
		M = new k(T)
		M.initialize_type = INITIALIZE_NONE
		INITIALIZE(M)
		GENERATE(M)
		FINALIZE(M)
		if(M.qdeleting)
			continue
		if(initial(M.rarity) == RARITY_COMMON)
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

		var/found_value = W.get_recommended_value()
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
	var/list/weapons_as_items = process_weapons(T,weapon_subtypes)

	var/list/reported_weapons = list()
	for(var/k in weapons_as_items)
		var/obj/item/I1 = k
		for(var/j in weapons_as_items)
			var/obj/item/I2 = j
			if(reported_weapons[I2.type])
				continue //Already complained about.
			if(stored_value[I1.type] > stored_value[I2.type]) //Prevents double checking. Weird solution, but it werks.
				continue
			if(I1.type == I2.type || I1.parent_type == I2.type || I2.parent_type == I1.type)
				continue
			if(is_ranged_weapon(I1) != is_ranged_weapon(I2))
				continue
			var/list/similarities = list()
			var/similarity_limt = 2
			if(abs(stored_dps[I1.type] - stored_dps[I2.type]) < max(stored_dps[I1.type],stored_dps[I2.type])*0.2)
				similarities += "damage per second"
			if(I1.tier_type == I2.tier_type)
				similarities += "same type of weapon"
			if(is_ranged_weapon(I1))
				var/obj/item/weapon/ranged/R1 = I1
				var/obj/item/weapon/ranged/R2 = I2
				if(abs(R1.shoot_delay - R2.shoot_delay) < 0.1)
					similarities += "fire rate"
				if(abs(R1.heat_max - R2.heat_max) < 0.05)
					similarities += "heat max"
				similarity_limt = 3
			else
				if(abs(stored_dph[I1.type] - stored_dph[I2.type]) < max(stored_dph[I1.type],stored_dph[I2.type])*0.09)
					similarities += "damage per hit"


			if(length(similarities) >= similarity_limt)
				log_error("Warning: SSBalance reports that [I1.type] feels too similiar to [I2.type]. Reason: [english_list(similarities)].")
				reported_weapons[I1.type] = TRUE
			CHECK_TICK_HARD(DESIRED_TICK_LIMIT)

	stuff_to_delete += weapons_as_items

	for(var/k in stuff_to_delete)
		var/obj/item/I = k
		qdel(I)

	var/list/everything_else = subtypesof(/obj/item)
	everything_else -= bullet_subtypes
	everything_else -= magazine_subtypes
	everything_else -= weapon_subtypes

	process_items(T,everything_else)

	sort_tim(stored_dps, /proc/cmp_numeric_asc, associative=TRUE)
	sort_tim(stored_dph, /proc/cmp_numeric_asc, associative=TRUE)
	sort_tim(stored_killtime, /proc/cmp_numeric_asc, associative=TRUE)
	sort_tim(stored_value, /proc/cmp_numeric_asc, associative=TRUE)

	created_bullets.Cut()
	created_magazines.Cut()

	. = ..()
