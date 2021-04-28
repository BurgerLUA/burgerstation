//This should only be used for DPS calculation.

SUBSYSTEM_DEF(weapons)
	name = "Weapons Subsystem"
	desc = "A subsystem dedicated to hosting helper variables related to weapons."
	priority = SS_ORDER_REPORT

	var/list/weapon_to_bullet = list()

/subsystem/weapons/Initialize()

	var/list/created_bullets = list()

	for(var/k in subtypesof(/obj/item/bullet_cartridge/))
		var/obj/item/bullet_cartridge/B = new k(locate(1,1,1))
		created_bullets += B

	var/balance_table = list()

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
			break

		balance_table[B.type] = B.get_base_value()
		qdel(B)

	sortTim(balance_table, /proc/cmp_numeric_asc, associative=TRUE)

	var/text_to_write = ""
	for(var/k in balance_table)
		text_to_write += "[k]: [balance_table[k]]\n"

	rustg_file_write(text_to_write,"data/server/weapon_balance.txt")

	for(var/k in created_bullets)
		var/obj/item/I = k
		qdel(I)

	created_bullets.Cut()

	return ..()