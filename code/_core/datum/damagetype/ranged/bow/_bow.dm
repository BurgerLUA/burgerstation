/damagetype/ranged/bow/
	name = "bow"

	damage_mod = 1
	penetration_mod = 1

	attack_damage_base = list(
		PIERCE = DAMAGE_GREATCLUB*0.50,
		BLADE = DAMAGE_GREATCLUB*0.25
	)

	attack_damage_penetration = list(
		PIERCE = AP_GREATCLUB*0.75,
		BLADE = AP_GREATCLUB*0.25
	)

	attribute_stats = list(

	)

	attribute_damage = list(

	)

	skill_stats = list(
		SKILL_RANGED = DAMAGE_GREATCLUB*0.25
	)

	skill_damage = list(
		SKILL_RANGED = list(PIERCE,BLADE)
	)

	bonus_experience_skill = list(
		SKILL_RANGED = 50
	)

	bonus_experience_attribute = list(
		ATTRIBUTE_STRENGTH = 25,
		ATTRIBUTE_DEXTERITY = 25
	)