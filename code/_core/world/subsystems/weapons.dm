SUBSYSTEM_DEF(weapons)
	name = "Weapons Subsystem"
	desc = "A subsystem dedicated to hosting helper variables related to weapons."
	priority = SS_ORDER_PRELOAD

	var/list/weapon_to_magazine = list()

/subsystem/weapons/Initialize()

	for(var/k in subtypesof(/obj/item/magazine/))
		//We have to create it here because initial(list()) doesn't work
		var/obj/item/magazine/M = new k(locate(1,1,1))
		for(var/supported_weapon in M.weapon_whitelist)
			if(!weapon_to_magazine[supported_weapon])
				weapon_to_magazine[supported_weapon] = list()
			weapon_to_magazine[supported_weapon] += M.type
		qdel(M)

	return ..()