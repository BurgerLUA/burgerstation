/obj/item/proc/get_damage_type_text(var/mob/living/advanced/A)

	var/returning_text = ""

	var/damage_type_to_use = get_damage_type()

	if(damage_type_to_use && all_damage_types[damage_type_to_use])

		var/damagetype/DT = all_damage_types[damage_type_to_use]

		var/list/base_damage_list = list()
		var/list/attribute_damage_list = list()
		var/list/skill_damage_list = list()

		for(var/k in DT.base_attack_damage)
			var/v = DT.base_attack_damage[k]
			if(v)
				base_damage_list += "[v] [k]"

		for(var/k in DT.attribute_stats)
			var/v = DT.attribute_stats[k]
			var/experience/E = A.attributes[k]
			var/grade
			switch(v)
				if(CLASS_S)
					grade = "S"
				if(CLASS_A)
					grade = "A"
				if(CLASS_B)
					grade = "B"
				if(CLASS_C)
					grade = "C"
				if(CLASS_D)
					grade = "D"
				if(CLASS_E)
					grade = "E"

			if(grade)
				attribute_damage_list += "[capitalize(k)]: [grade] ([FLOOR(E.get_current_level()*v, 1)] [DT.attribute_damage[k]])"

		for(var/k in DT.skill_stats)
			var/v = DT.skill_stats[k]
			var/experience/E = A.skills[k]
			var/grade
			switch(v)
				if(CLASS_S)
					grade = "S"
				if(CLASS_A)
					grade = "A"
				if(CLASS_B)
					grade = "B"
				if(CLASS_C)
					grade = "C"
				if(CLASS_D)
					grade = "D"
				if(CLASS_E)
					grade = "E"

			if(grade)
				skill_damage_list += "[capitalize(k)]: [grade] ([FLOOR(E.get_current_level()*v, 1)] [DT.skill_damage[k]])"

		var/combat_rating = DT.get_rating()

		var/combat_rating_text = ""
		switch(combat_rating)
			if(0 to 5)
				combat_rating_text = "E"
			if(5 to 10)
				combat_rating_text = "D"
			if(10 to 15)
				combat_rating_text = "C"
			if(15 to 20)
				combat_rating_text = "B"
			if(20 to 25)
				combat_rating_text = "A"
			if(25 to INFINITY)
				combat_rating_text = "S"


		returning_text += div("notice bold","Combat Rating:") + div("notice","[combat_rating_text] ([combat_rating])")

		if(length(base_damage_list))
			returning_text += div("notice bold","Base Damage:") + div("notice","[english_list(base_damage_list, and_text = ", ")]")

		if(length(attribute_damage_list))
			returning_text += div("notice bold","Attribute Damage:") + div("notice","[english_list(attribute_damage_list, and_text = ", ")]")

		if(length(skill_damage_list))
			returning_text += div("notice bold","Skill Damage:") + div("notice","[english_list(skill_damage_list, and_text = ", ")]")

	return returning_text
