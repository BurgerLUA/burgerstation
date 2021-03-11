/damagetype/ranged/bow/ashen
	name = "bow"
	damage_mod = 2

	bonus_experience_skill = list(
		SKILL_RANGED = 50 //100%
	)

	attack_damage_base = list(
		PIERCE = DAMAGE_GREATSWORD*0.2,
	)

	attack_damage_penetration = list(
		PIERCE = AP_GREATSWORD*2,
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = DAMAGE_GREATSWORD*0.3,
		ATTRIBUTE_DEXTERITY = DAMAGE_GREATSWORD*0.2
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = PIERCE,
		ATTRIBUTE_DEXTERITY = PIERCE
	)

	skill_stats = list(
		SKILL_RANGED = DAMAGE_AXE*0.3
	)

	skill_damage = list(
		SKILL_RANGED = PIERCE
	)