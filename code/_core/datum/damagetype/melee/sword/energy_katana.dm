/damagetype/melee/sword/energy_katana
	name = "inactive energy sword"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 15
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 5
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 20
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT
	)

	skill_stats = list(
		SKILL_MELEE = 10,
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT
	)

/damagetype/melee/sword/energy_katana/on
	name = "energy katana"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 10,
		LASER = 20,
		HEAT = 10
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 25,
		LASER = 25
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 10,
		ATTRIBUTE_DEXTERITY = 30
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLADE,LASER),
		ATTRIBUTE_DEXTERITY = list(BLADE,LASER)
	)

	skill_stats = list(
		SKILL_MELEE = 40,
	)

	skill_damage = list(
		SKILL_MELEE = BLADE
	)