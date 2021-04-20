SUBSYSTEM_DEF(balance) //Finally. A subsystem dedicated to BALLS.
	name = "Balance Subsystem"
	desc = "Makes a report of weapons."
	priority = SS_ORDER_REPORT

	var/list/stored_dps = list()
	var/list/weapon_to_bullet = list()

/subsystem/balance/Initialize()

	var/list/created_bullets = list()

	for(var/k in subtypesof(/obj/item/bullet_cartridge/))
		var/obj/item/bullet_cartridge/B = new k(locate(1,1,1))
		created_bullets += B

	for(var/k in subtypesof(/obj/item/weapon))

		var/obj/item/weapon/W = new k(locate(1,1,1))

		if(istype(W,/obj/item/weapon/ranged/bullet))
			var/obj/item/weapon/ranged/bullet/B = W
			for(var/v in created_bullets)
				var/obj/item/bullet_cartridge/C = v
				if(C.bullet_length < B.bullet_length_min)
					continue
				if(C.bullet_length > B.bullet_length_max)
					continue
				if(C.bullet_diameter < B.bullet_diameter_min)
					continue
				if(C.bullet_diameter > B.bullet_diameter_max)
					continue
				weapon_to_bullet[B.type] = C.type
				break

		var/found_dps = W.get_dps()
		if(found_dps)
			stored_dps[W.type] = found_dps

		qdel(W)

	sortInsert(stored_dps, /proc/cmp_numeric_asc, associative=TRUE)

	for(var/k in created_bullets)
		var/obj/item/I = k
		qdel(I)

	created_bullets.Cut()
