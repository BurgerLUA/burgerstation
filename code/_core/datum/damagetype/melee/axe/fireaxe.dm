/damagetype/melee/axe/fireaxe

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 40,
		BLUNT = 10,
		PIERCE = 10
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 60
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLADE,BLUNT,PIERCE)
	)

	skill_stats = list(
		SKILL_MELEE = 40
	)

	skill_damage = list(
		SKILL_MELEE = BLADE
	)

	attack_delay = 15
	attack_delay_max = 20
