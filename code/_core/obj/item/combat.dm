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
		var/attribute_power = L.get_attribute_power(attribute,0,1,2)
		var/attribute_damage_type = DT.attribute_damage[attribute]
		var/attribute_modifier = DT.attribute_stats[attribute]
		var/attribute_damage = attribute_power * attribute_modifier * 100
		damage_type_list[attribute_damage_type] += attribute_damage
		affected_list[attribute] += attribute_modifier
		total_damage += attribute_damage

	for(var/skill in DT.skill_damage)
		var/skill_power = L.get_skill_power(skill,0,1,2)
		var/skill_damage_type = DT.skill_damage[skill]
		var/skill_modifier = DT.skill_stats[skill]
		var/skill_damage = skill_power * skill_modifier * 100
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