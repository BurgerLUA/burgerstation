/obj/item/weapon/proc/get_dps()

	if(!damage_type)
		return 0

	var/damagetype/D = all_damage_types[damage_type]
	if(!D)
		return 0

	return D.get_damage_per_hit() * (10/D.attack_delay)


/obj/item/weapon/ranged/get_dps()

	if(!ranged_damage_type)
		return 0

	var/damagetype/D = all_damage_types[ranged_damage_type]
	if(!D)
		return 0

	return D.get_damage_per_hit() * (10/shoot_delay)


/obj/item/weapon/ranged/bullet/get_dps()

	if(!standard_bullet_type)
		return 0

	var/obj/item/bullet_cartridge/BC = standard_bullet_type

	var/initial_damage_type = initial(BC.damage_type_bullet)

	if(!initial_damage_type)
		return 0

	var/damagetype/D = all_damage_types[initial_damage_type]
	if(!D)
		return 0

	return D.get_damage_per_hit() * (10/shoot_delay)