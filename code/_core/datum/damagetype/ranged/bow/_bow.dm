/damagetype/ranged/bow/
	name = "bow"
	damage_mod = 2.5

	bonus_experience_skill = list(
		SKILL_RANGED = 50 //100%
	)

	attack_damage_base = list(
		PIERCE = DAMAGE_GREATSWORD*0.3*BASE_MELEE_MUL,
		BLADE = DAMAGE_GREATSWORD*0.1*BASE_MELEE_MUL
	)

	attack_damage_penetration = list(
		PIERCE = AP_GREATSWORD*0.75,
		BLADE = AP_GREATSWORD*0.25
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = DAMAGE_GREATSWORD*0.2,
		ATTRIBUTE_DEXTERITY = DAMAGE_GREATSWORD*0.1
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(PIERCE,BLADE),
		ATTRIBUTE_DEXTERITY = list(PIERCE,BLADE)
	)

	skill_stats = list(
		SKILL_RANGED = DAMAGE_AXE*0.3
	)

	skill_damage = list(
		SKILL_RANGED = list(PIERCE,BLADE)
	)