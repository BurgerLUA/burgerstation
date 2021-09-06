/damagetype/ranged/magic/
	bonus_experience_skill = list()
	attack_damage_penetration = list()

	bonus_experience_attribute = list(
		ATTRIBUTE_INTELLIGENCE = 25 //25%
	)

/damagetype/ranged/magic/get_attack_type()
	return ATTACK_TYPE_MAGIC


/damagetype/ranged/magic/get_attack_damage(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/damage_multiplier=1)

	. = ..()

	if(istype(weapon,/obj/item/weapon/ranged/magic))
		var/obj/item/weapon/ranged/magic/M = weapon
		if(M.stored_powergem)
			.[M.stored_powergem.damage_type_to_add] += M.stored_powergem.damage_to_add

