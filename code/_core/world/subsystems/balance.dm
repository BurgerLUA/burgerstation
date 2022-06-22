SUBSYSTEM_DEF(balance)
	name = "Balance Subsystem"
	desc = "Makes a report of weapons."

	priority = SS_ORDER_LAST

	var/list/stored_dps = list()
	var/list/stored_dph = list()
	var/list/stored_tier = list()

	var/list/weapon_to_bullet = list()
	var/list/weapon_to_magazine = list()

/subsystem/balance/Initialize()

	var/list/created_bullets = list()
	var/list/created_magazines = list()

	var/turf/T = locate(1,1,1)

	for(var/k in subtypesof(/obj/item/bullet_cartridge/))
		var/obj/item/bullet_cartridge/B = new k(T)
		if(B.rarity != RARITY_COMMON || B.value <= 0)
			qdel(B)
			continue
		INITIALIZE(B)
		GENERATE(B)
		FINALIZE(B)
		created_bullets += B

	for(var/k in subtypesof(/obj/item/magazine))
		var/obj/item/magazine/M = new k(T)
		if(M.rarity != RARITY_COMMON || M.value <= 0)
			qdel(M)
			continue
		INITIALIZE(M)
		GENERATE(M)
		FINALIZE(M)
		created_magazines += M

	var/imbalanced_weapons = 0

	for(var/k in subtypesof(/obj/item/weapon))
		var/obj/item/weapon/W = k
		if(initial(W.value) <= 0)
			continue

		W = new W(T)
		INITIALIZE(W)
		GENERATE(W)
		FINALIZE(W)

		if(istype(W,/obj/item/weapon/ranged/bullet))
			var/obj/item/weapon/ranged/bullet/B = W
			for(var/v in created_bullets)
				var/obj/item/bullet_cartridge/C = v
				if(C.bullet_length != B.bullet_length_best)
					continue
				if(C.bullet_diameter != B.bullet_diameter_best)
					continue
				weapon_to_bullet[B.type] = C.type
				break

		if(istype(W,/obj/item/weapon/ranged/bullet/magazine))
			var/obj/item/weapon/ranged/bullet/magazine/B = W
			for(var/v in created_magazines)
				var/obj/item/magazine/M = v
				if(!M.weapon_whitelist[B.type])
					continue
				weapon_to_magazine[B.type] = M.type

		var/found_dph = W.get_damage_per_hit()
		if(found_dph)
			stored_dph[W.type] = CEILING(found_dph,1)

		var/found_dps = W.get_dps(0, found_dph)
		if(found_dps)
			stored_dps[W.type] = CEILING(found_dps,1)

		if(!W.bypass_balance_check)
			var/recommended_tier = FLOOR(max(found_dph-100,found_dps)/100,1)
			if(W.tier >= 0 && recommended_tier != W.tier)
				log_error("Balance Warning: <b>[W.type]</b> had a tier of <b>[W.tier]</b>, but the formula recommends a tier of <b>[recommended_tier]</b>![istype(W,/obj/item/weapon/ranged/bullet) ? "(Bullet used: [weapon_to_bullet[W.type]])" : ""]")
				imbalanced_weapons++
			stored_tier[W.type] = recommended_tier

		qdel(W)

	sortInsert(stored_dps, /proc/cmp_numeric_asc, associative=TRUE)
	sortInsert(stored_dph, /proc/cmp_numeric_asc, associative=TRUE)

	for(var/k in created_bullets)
		var/obj/item/I = k
		qdel(I)
	created_bullets.Cut()

	for(var/k in created_magazines)
		var/obj/item/I = k
		qdel(I)
	created_magazines.Cut()

	log_subsystem(src.name,"Found [imbalanced_weapons] imbalanced weapons.")

	. = ..()
