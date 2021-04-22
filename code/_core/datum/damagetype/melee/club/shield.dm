/damagetype/melee/club/shield
	name = "shield"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 20,
		FATIGUE = 10
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 0,
		FATIGUE = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 20,
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT
	)

	skill_stats = list(
		SKILL_MELEE = 10,
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT,
	)

	attack_delay = 10
	attack_delay_max = 10

/damagetype/melee/club/shield/energy
	name = "ianctive energy shield"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 5
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 15,
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT
	)

	skill_stats = list(
		SKILL_MELEE = 10,
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT,
	)

	attack_delay = 5
	attack_delay_max = 10

/damagetype/melee/club/shield/energy/on
	name = "active energy shield"


	//impact_sounds = list('sound/weapon/melee/saberon.ogg')

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 10,
		LASER = 20,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 0,
		LASER = 25,
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 10
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT
	)

	skill_stats = list(
		SKILL_MELEE = 10
	)

	skill_damage = list(
		SKILL_MELEE = list(BLUNT,LASER)
	)

	attack_delay = 5
	attack_delay_max = 10