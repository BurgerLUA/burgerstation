/damagetype/melee/sword/skana
	name = "skana"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 45,
		PIERCE = 15
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 10,
		PIERCE = 10
	)

	attribute_stats = list(
		ATTRIBUTE_DEXTERITY = 80
	)

	attribute_damage = list(
		ATTRIBUTE_DEXTERITY = BLADE
	)

	skill_stats = list(
		SKILL_MELEE = 20
	)

	skill_damage = list(
		SKILL_MELEE = BLADE
	)