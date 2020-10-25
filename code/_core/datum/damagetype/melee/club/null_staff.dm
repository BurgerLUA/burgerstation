/damagetype/melee/club/null_staff
	name = "null staff"

	attack_damage_base = list(
		BLUNT = DAMAGE_SWORD*0.2,
		HOLY = 0
	)

	attack_damage_penetration = list(
		BLUNT = AP_SWORD*0.25,
		HOLY = AP_SWORD*0.75
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = DAMAGE_SWORD*0.1,
		ATTRIBUTE_DEXTERITY = DAMAGE_SWORD*0.2
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT
	)

	skill_stats = list(
		SKILL_MELEE = DAMAGE_SWORD*0.1,
		SKILL_PRAYER = DAMAGE_SWORD*0.40
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT,
		SKILL_PRAYER = HOLY
	)