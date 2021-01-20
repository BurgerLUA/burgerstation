/damagetype/ranged/magic/flame
	name = "flame"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		FIRE = DAMAGE_SWORD*0.4,
		ARCANE = DAMAGE_SWORD*0.1
	)

	attribute_stats = list(
		ATTRIBUTE_INTELLIGENCE = DAMAGE_SWORD*0.2
	)

	attribute_damage = list(
		ATTRIBUTE_INTELLIGENCE = list(FIRE,ARCANE)
	)

	skill_stats = list(
		SKILL_SORCERY = DAMAGE_SWORD*0.3,
	)

	skill_damage = list(
		SKILL_SORCERY = ARCANE
	)

	bonus_experience = list(
		SKILL_SORCERY = 50 //50%
	)