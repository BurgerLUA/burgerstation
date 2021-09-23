/obj/item/weapon/proc/get_dps(var/armor_to_use=0)

	if(!damage_type)
		log_error("Warning: [src.type] did not have a valid damage_type.")
		return 0

	var/damagetype/D = all_damage_types[damage_type]
	if(!D)
		log_error("Warning: [src.type] did not have a valid damage_type.")
		return 0

	return D.get_damage_per_hit(armor_to_use) * (10/D.attack_delay)

/obj/item/weapon/melee/energy/get_dps(var/armor_to_use=0)

	if(!damage_type_on)
		log_error("Warning: [src.type] did not have a valid damage_type_on.")
		return 0

	var/damagetype/D = all_damage_types[damage_type_on]
	if(!D)
		log_error("Warning: [src.type] did not have a valid damage_type.")
		return 0

	return D.get_damage_per_hit(armor_to_use) * (10/D.attack_delay)


/obj/item/weapon/ranged/get_dps(var/armor_to_use=0)

	if(!ranged_damage_type)
		log_error("Warning: [src.type] did not have a valid ranged_damage_type.")
		return 0

	var/damagetype/D = all_damage_types[ranged_damage_type]
	if(!D)
		log_error("Warning: [src.type] did not have a valid ranged_damage_type.")
		return 0

	if("burst" in firemodes)
		var/local_burst_delay = burst_delay ? burst_delay : shoot_delay*max_bursts*1.25
		. = max_bursts*(10/local_burst_delay)

	if("automatic" in firemodes)
		var/possible = (10/shoot_delay) * bullet_count * damage_mod
		if(possible > .)
			. = possible

	if("semi-automatic" in firemodes)
		var/possible = (10/max(1,shoot_delay)) * bullet_count * damage_mod
		if(possible > .)
			. = possible

	. *= D.get_damage_per_hit(armor_to_use)

/obj/item/weapon/ranged/bullet/get_dps(var/armor_to_use=0)

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

	if("burst" in firemodes)
		var/local_burst_delay = burst_delay ? burst_delay : shoot_delay*current_bursts*1.25
		. = max_bursts*(10/local_burst_delay)

	if("automatic" in firemodes)
		var/possible = (10/shoot_delay) * initial(BC.projectile_count)
		if(possible > .)
			. = possible

	if("semi-automatic" in firemodes)
		var/possible = (10/max(1,shoot_delay)) * initial(BC.projectile_count)
		if(possible > .)
			. = possible

	. = min(bullet_count_max,.)

	. *= D.get_damage_per_hit(armor_to_use)

/obj/item/weapon/ranged/bullet/magazine/get_dps(var/armor_to_use=0)

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

	if("burst" in firemodes)
		var/local_burst_delay = burst_delay ? burst_delay : shoot_delay*current_bursts*1.25
		. = max_bursts*(10/local_burst_delay)

	if("automatic" in firemodes)
		var/possible = (10/shoot_delay) * initial(BC.projectile_count)
		if(possible > .)
			. = possible

	if("semi-automatic" in firemodes)
		var/possible = (10/max(1,shoot_delay)) * initial(BC.projectile_count)
		if(possible > .)
			. = possible

	. *= D.get_damage_per_hit(armor_to_use)

/obj/item/weapon/ranged/bullet/pump/get_dps(var/armor_to_use=0)

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

	if("burst" in firemodes)
		var/local_burst_delay = burst_delay ? burst_delay : ((pump_delay*2)+shoot_delay)*current_bursts*1.25
		. = max_bursts*(10/local_burst_delay)

	if("automatic" in firemodes)
		var/possible = (10/((pump_delay*2)+shoot_delay)) * initial(BC.projectile_count)
		if(possible > .)
			. = possible

	if("semi-automatic" in firemodes)
		var/possible = (10/((pump_delay*2)+max(1,shoot_delay))) * initial(BC.projectile_count)
		if(possible > .)
			. = possible

	. = min(bullet_count_max,.)

	. *= D.get_damage_per_hit(armor_to_use)