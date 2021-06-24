/obj/item/weapon/proc/get_dps()

	if(!damage_type)
		log_error("Warning: [src.type] did not have a valid damage_type.")
		return 0

	var/damagetype/D = all_damage_types[damage_type]
	if(!D)
		log_error("Warning: [src.type] did not have a valid damage_type.")
		return 0

	return D.get_damage_per_hit() * (10/D.attack_delay)


/obj/item/weapon/ranged/get_dps()

	if(!ranged_damage_type)
		log_error("Warning: [src.type] did not have a valid ranged_damage_type.")
		return 0

	var/damagetype/D = all_damage_types[ranged_damage_type]
	if(!D)
		log_error("Warning: [src.type] did not have a valid ranged_damage_type.")
		return 0

	return D.get_damage_per_hit() * (10/shoot_delay)


/obj/item/weapon/ranged/bullet/get_dps()

	if(!SSbalance.weapon_to_bullet[src.type])
		log_error("Warning: [src.type] did not have a valid weapon_to_bullet.")
		return 0

	var/obj/item/bullet_cartridge/BC = SSbalance.weapon_to_bullet[src.type]

	var/initial_damage_type = initial(BC.damage_type_bullet)

	if(!initial_damage_type)
		log_error("Warning: [src.type] did not have a valid initial_damage_type.")
		return 0

	var/damagetype/D = all_damage_types[initial_damage_type]
	if(!D)
		log_error("Warning: [src.type] did not have a valid initial_damage_type.")
		return 0

	return D.get_damage_per_hit() * (10/shoot_delay)