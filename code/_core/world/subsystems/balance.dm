SUBSYSTEM_DEF(balance)
	name = "Balance Subsystem"
	desc = "Makes a report of weapons."

	priority = SS_ORDER_POSTLOAD

	var/list/stored_dps = list()
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
			/*
			var/recommended_value = CEILING(100 + (found_dps*0.16)**2,100)
			var/current_value = W.get_base_value()
			if(current_value > 0)
				if(current_value > recommended_value*1.25)
					log_debug("[W.type] seems to be more expensive ([current_value]) than the recommended value ([recommended_value]). Consider decreasing the weapon cost or buffing the weapon.")
				else if(current_value < recommended_value*0.75)
					log_debug("[W.type] seems to be cheaper ([current_value]) than the recommended value ([recommended_value]). Consider increasing the weapon cost or nerfing the weapon.")
			*/

		qdel(W)

	sortInsert(stored_dps, /proc/cmp_numeric_asc, associative=TRUE)

	for(var/k in created_bullets)
		var/obj/item/I = k
		qdel(I)

	created_bullets.Cut()

	. = ..()
