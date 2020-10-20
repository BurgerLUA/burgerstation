/proc/calculate_damage_per_attack(var/damagetype/DT,var/level=50)

	. = 0

	for(var/damage_type in DT.attack_damage_base)
		. += DT.attack_damage_base[damage_type]

	if(level > 0)
		for(var/attribute in DT.attribute_stats)
			. += DT.attribute_stats[attribute] * 0.01 * level

		for(var/skill in DT.skill_stats)
			. += DT.skill_stats[skill] * 0.01 * level

	return .

/proc/calculate_damage_per_second(var/obj/item/I,var/level=50)

	var/damagetype/DT
	var/attacks_per_second = 1

	if(ispath(I,/obj/item/weapon/ranged/bullet))
		var/obj/item/weapon/ranged/bullet/B = I
		var/obj/item/bullet_cartridge/C = SSweapons.weapon_to_bullet[I]
		if(!C)
			return 0
		var/found_DT = initial(C.damage_type_bullet)
		if(!found_DT)
			return 0
		DT = all_damage_types[found_DT]
		attacks_per_second = (1 / (initial(B.shoot_delay)/10))*initial(C.projectile_count)
	else if(ispath(I,/obj/item/weapon/ranged/))
		var/obj/item/weapon/ranged/R = I
		var/found_DT = initial(R.ranged_damage_type)
		if(!found_DT)
			return 0
		DT = all_damage_types[found_DT]
		attacks_per_second = (1 / (initial(R.shoot_delay)/10))*initial(R.bullet_count)
	else if(ispath(I,/obj/item/weapon/melee/energy/))
		var/obj/item/weapon/melee/energy/E = I
		var/found_DT = initial(E.damage_type_on)
		if(!found_DT)
			return 0
		DT = all_damage_types[found_DT]
		attacks_per_second = 1 / (initial(I.attack_delay)/10)
	else
		var/found_DT = initial(I.damage_type)
		if(!found_DT)
			return 0
		DT = all_damage_types[found_DT]
		attacks_per_second = 1 / (initial(I.attack_delay)/10)

	if(!DT)
		return 0

	if(!attacks_per_second)
		return 0

	return calculate_damage_per_attack(DT,level) * attacks_per_second


/client/verb/print_dps(var/type_path = "/obj/item/weapon" as text, var/level = 50 as num)

	set name = "Print DPS Table (WARNING)"
	set category = "Debug"

	. = list()

	for(var/k in subtypesof(text2path(type_path)))
		var/obj/item/I = k
		.[k] = calculate_damage_per_second(I,level)

	sortTim(.,/proc/cmp_numeric_dsc,associative=TRUE)

	for(var/k in .)
		var/v = .[k]
		to_chat(span("debug","[k] = [v] DPS"))
