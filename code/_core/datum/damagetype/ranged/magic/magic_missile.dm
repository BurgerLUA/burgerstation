/damagetype/ranged/magic/magic_missile
	name = "magic missle"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		ARCANE = 60*0.5
	)

	attribute_stats = list(
		ATTRIBUTE_INTELLIGENCE = 60*0.25
	)

	attribute_damage = list(
		ATTRIBUTE_INTELLIGENCE = ARCANE
	)

	skill_stats = list(
		SKILL_SORCERY =  60*0.25
	)

	skill_damage = list(
		SKILL_SORCERY = ARCANE
	)

	bonus_experience_skill = list(
		SKILL_SORCERY = 75 //75%
	)