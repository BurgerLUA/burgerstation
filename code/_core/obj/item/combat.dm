/obj/item/proc/get_damage_type_text(var/mob/living/L)

	. = ""

	var/damagetype_id = get_damage_type()

	if(!damagetype_id || !all_damage_types[damagetype_id])
		return ""

	var/damagetype/DT = all_damage_types[damagetype_id]

	var/list/damage_type_list = list()
	var/list/affected_list = list()
	var/total_damage = 0

	for(var/damagetype in DT.attack_damage_base)
		var/base_damage = DT.attack_damage_base[damagetype]
		damage_type_list[damagetype] += base_damage
		total_damage += base_damage

	for(var/attribute in DT.attribute_damage)
		var/attribute_level = L.get_attribute_level(attribute)
		var/attribute_damage_type = DT.attribute_damage[attribute]
		var/attribute_modifier = DT.attribute_stats[attribute]
		var/attribute_damage = attribute_level * attribute_modifier
		damage_type_list[attribute_damage_type] += attribute_damage
		affected_list[attribute] += attribute_modifier
		total_damage += attribute_damage

	for(var/skill in DT.skill_damage)
		var/skill_level = L.get_skill_level(skill)
		var/skill_damage_type = DT.skill_damage[skill]
		var/skill_modifier = DT.skill_stats[skill]
		var/skill_damage = skill_level * skill_modifier
		damage_type_list[skill_damage_type] += skill_damage
		affected_list[skill] += skill_modifier
		total_damage += skill_damage

	for(var/k in damage_type_list)
		var/v = damage_type_list[k]
		var/armor_pen_value = DT.attack_damage_penetration[k]
		. += div("notice","[capitalize(k)]: [v][armor_pen_value ? " ([armor_pen_value] Armor Penetration)" : "" ]")

	. += div("notice bold","Total Damage: [total_damage]")

	if(length(affected_list))
		var/list/final_list = list()

		for(var/k in affected_list)
			var/v = affected_list[k]
			final_list += "[capitalize(k)] (x[v])"

		. += div("notice","Affected by: [english_list(final_list)].")
	else
		. += div("notice","Damage not affected by skills or attributes.")

	return .

/*
/obj/item/proc/get_damage_type_text(var/mob/living/L)

	var/returning = ""

	var/damagetype_id = get_damage_type()

	if(damagetype_id && all_damage_types[damagetype_id])

		var/damagetype/DT = all_damage_types[damagetype_id]
		var/combat_rating = DT.get_combat_rating(L)
		var/combat_grade = get_combat_grade(combat_rating)

		returning += div("notice","<b>Combat Rating:</b> [combat_rating] (<b>[combat_grade]</b>).")

		for(var/damagetype in DT.attack_damage_base)
			var/base_damage_value = DT.attack_damage_base[damagetype]
			returning += div("notice","Base Damage: [base_damage_value] [damagetype]")

		for(var/attribute in DT.attribute_damage)
			var/attribute_name = capitalize(attribute)
			var/attribute_level = L.get_attribute_level(attribute)
			var/attribute_damage_type = DT.attribute_damage[attribute]
			var/attribute_modifier = DT.attribute_stats[attribute]
			var/attribute_damage = attribute_level * attribute_modifier
			returning += div("notice","[attribute_name]: [attribute_damage] [attribute_damage_type]")

		for(var/skill in DT.skill_damage)
			var/skill_name = capitalize(skill)
			var/skill_level = L.get_skill_level(skill)
			var/skill_damage_type = DT.skill_damage[skill]
			var/skill_modifier = DT.skill_stats[skill]
			var/skill_damage = skill_level * skill_modifier
			returning += div("notice","[skill_name]: [skill_damage] [skill_damage_type]")

		if(DT.get_attack_type() == ATTACK_TYPE_MELEE)
			var/attack_delay = DT.get_attack_delay(L)
			returning += div("notice","<b>Attack Speed:</b> [attack_delay].")

	return returning
*/

/*
/obj/item/get_block_power(var/atom/victim,var/atom/attacker,var/atom/weapon,var/atom/object_to_damage,var/damagetype/DT)

	if(is_living(victim))
		var/mob/living/V = victim
		return 0.25 + V.get_skill_power(SKILL_BLOCK)

	return ..()
*/