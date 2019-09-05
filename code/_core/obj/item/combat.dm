obj/item/proc/get_block_mul(var/attack_type)
	return block_mul[attack_type]

obj/item/proc/get_parry_mul(var/attack_type)
	return parry_mul[attack_type]

/obj/item/proc/get_damage_type_text(var/mob/living/L)

	var/returning = ""

	var/damagetype_id = get_damage_type()

	if(damagetype_id && all_damage_types[damagetype_id])
		var/damagetype/DT = all_damage_types[damagetype_id]

		var/combat_rating = DT.get_combat_rating(L)
		var/combat_grade = get_combat_grade(combat_rating)
		returning += div("notice","<b>Combat Rating:</b> [combat_rating] (<b>[combat_grade]</b>).")

		var/list/base_damage_list = list()

		for(var/damagetype in DT.attack_damage_base)
			var/base_damage_value = DT.attack_damage_base[damagetype]
			var/attribute_damage_value = 0
			var/skill_damage_value = 0

			for(var/attribute in DT.attribute_damage)
				var/attribute_level = L.get_attribute_level(attribute)
				var/attribute_damage_type = DT.attribute_damage[attribute]
				var/attribute_modifier = DT.attribute_stats[attribute]
				if(attribute_damage_type != damagetype)
					continue
				attribute_damage_value += attribute_level * attribute_modifier

			for(var/skill in DT.skill_damage)
				var/skill_level = L.get_skill_level(skill)
				var/skill_damage_type = DT.skill_damage[skill]
				var/skill_modifier = DT.skill_stats[skill]
				if(skill_damage_type != damagetype)
					continue
				skill_damage_value += skill_level * skill_modifier

			base_damage_list += "[capitalize(damagetype)] ([capitalize(DT.attack_damage_conversion[damagetype])]): [base_damage_value] + [attribute_damage_value] + [skill_damage_value] (<b>[base_damage_value + attribute_damage_value + skill_damage_value]</b>, [DT.attack_damage_penetration[damagetype]]% AP) "

		returning += div("notice","<b>Damage:</b> [english_list(base_damage_list)].")
		if(DT.get_attack_type() == ATTACK_TYPE_MELEE)
			var/attack_delay = DT.get_attack_delay(L)
			returning += div("notice","<b>Attack Speed:</b> [attack_delay].")

	return returning