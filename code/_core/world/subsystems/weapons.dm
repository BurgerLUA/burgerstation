//This should only be used for DPS calculation.

SUBSYSTEM_DEF(weapons)
	name = "Weapons Subsystem"
	desc = "A subsystem dedicated to hosting helper variables related to weapons."
	priority = SS_ORDER_PRELOAD

	//var/list/weapon_to_magazine = list()
	var/list/weapon_to_bullet = list()

/subsystem/weapons/Initialize()

	var/list/created_bullets = list()

	for(var/k in subtypesof(/obj/item/bullet_cartridge/))
		var/obj/item/bullet_cartridge/B = new k(locate(1,1,1))
		created_bullets += B

	for(var/k in subtypesof(/obj/item/weapon/ranged/bullet))
		var/obj/item/weapon/ranged/bullet/B = new k(locate(1,1,1))
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
		qdel(B)

	for(var/k in created_bullets)
		var/obj/item/I = k
		qdel(I)

	created_bullets.Cut()

	/*
	for(var/k in subtypesof(/obj/item/magazine/))
		//We have to create it here because initial(list()) doesn't work
		var/obj/item/magazine/M = new k(locate(1,1,1))
		for(var/supported_weapon in M.weapon_whitelist)
			if(!weapon_to_magazine[supported_weapon])
				weapon_to_magazine[supported_weapon] = list()
			weapon_to_magazine[supported_weapon] += M.type
		qdel(M)
	*/

	return ..()