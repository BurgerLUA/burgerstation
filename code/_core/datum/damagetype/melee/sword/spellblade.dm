/damagetype/melee/sword/spellblade
	name = "spellblade"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = DAMAGE_GREATSWORD*0.1,
		PIERCE = DAMAGE_GREATSWORD*0.05,
		ARCANE = DAMAGE_GREATSWORD*0.2
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = AP_GREATSWORD*0.25,
		PIERCE = AP_GREATSWORD*0.5,
		ARCANE = AP_GREATSWORD*0.25
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = AP_GREATSWORD*0.25
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLADE,PIERCE)
	)

	skill_stats = list(
		SKILL_MELEE = DAMAGE_GREATSWORD*0.3,
		SKILL_SORCERY = DAMAGE_GREATSWORD*0.35
	)

	skill_damage = list(
		SKILL_MELEE = list(BLADE,PIERCE),
		SKILL_SORCERY = ARCANE
	)

	bonus_experience_skill = list(
		SKILL_MELEE = 25, //25%
		SKILL_SORCERY = 25
	)