SUBSYSTEM_DEF(balance)
	name = "Balance Subsystem"
	desc = "Makes a report of weapons."

	priority = SS_ORDER_POSTLOAD

	var/list/stored_dps = list()
	var/list/stored_dph = list()

	var/list/weapon_to_bullet = list()

/subsystem/balance/Initialize()

	var/list/created_bullets = list()

	for(var/k in subtypesof(/obj/item/bullet_cartridge/))
		var/obj/item/bullet_cartridge/B = new k(locate(1,1,1))
		if(B.rarity != RARITY_COMMON || B.value <= 0)
			qdel(B)
			continue
		INITIALIZE(B)
		GENERATE(B)
		FINALIZE(B)
		created_bullets += B

	for(var/k in subtypesof(/obj/item/weapon))
		var/obj/item/weapon/W = k
		if(initial(W.value) <= 0)
			continue

		W = new W(locate(1,1,1))
		INITIALIZE(W)
		GENERATE(W)
		FINALIZE(W)

		if(istype(W,/obj/item/weapon/ranged/bullet))
			var/obj/item/weapon/ranged/bullet/B = W
			for(var/v in created_bullets)
				var/obj/item/bullet_cartridge/C = v
				if(C.bullet_length != B.bullet_length_best)
					continue
				if(C.bullet_diameter < B.bullet_diameter_best)
					continue
				weapon_to_bullet[B.type] = C.type
				break

		var/found_dps = W.get_dps()
		if(found_dps)
			stored_dps[W.type] = CEILING(found_dps,1)

		var/found_dph = W.get_damage_per_hit()
		if(found_dph)
			stored_dph[W.type] = CEILING(found_dph,1)

		qdel(W)

	sortInsert(stored_dps, /proc/cmp_numeric_asc, associative=TRUE)
	sortInsert(stored_dph, /proc/cmp_numeric_asc, associative=TRUE)

	for(var/k in created_bullets)
		var/obj/item/I = k
		qdel(I)
	created_bullets.Cut()

	. = ..()
