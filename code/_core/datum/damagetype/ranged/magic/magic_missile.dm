/damagetype/ranged/magic/magic_missile
	name = "magic missle"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		ARCANE = DAMAGE_CLUB*0.5
	)

	attribute_stats = list(
		ATTRIBUTE_INTELLIGENCE = DAMAGE_CLUB*0.25
	)

	attribute_damage = list(
		ATTRIBUTE_INTELLIGENCE = ARCANE
	)

	skill_stats = list(
		SKILL_SORCERY =  DAMAGE_CLUB*0.25
	)

	skill_damage = list(
		SKILL_SORCERY = ARCANE
	)

	bonus_experience = list(
		SKILL_SORCERY = 50 //50%
	)