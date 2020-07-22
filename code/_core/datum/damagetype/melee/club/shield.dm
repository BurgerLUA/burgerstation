/damagetype/melee/club/shield
	name = "shield"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 20
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 30,
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT
	)

	skill_stats = list(
		SKILL_MELEE = 10,
		//SKILL_BLOCK = 20
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT,
		//SKILL_BLOCK = BLUNT
	)

/damagetype/melee/club/shield/energy/on
	name = "active energy shield"


	//impact_sounds = list('sound/weapon/melee/saberon.ogg')

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 5,
		LASER = 20,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 0,
		LASER = 0,
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 10,
		ATTRIBUTE_RESILIENCE = 20
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT,
		ATTRIBUTE_RESILIENCE = LASER
	)

	skill_stats = list(
		SKILL_MELEE = 20,
		//SKILL_BLOCK = 10,
	)

	skill_damage = list(
		SKILL_MELEE = LASER,
		//SKILL_BLOCK = LASER,
	)

/damagetype/melee/club/shield/energy
	name = "ianctive energy shield"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 20
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 20
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT
	)