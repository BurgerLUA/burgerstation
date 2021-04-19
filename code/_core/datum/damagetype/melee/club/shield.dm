/damagetype/melee/club/shield
	name = "shield"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 30*0.1
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 20
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 30*0.5,
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT
	)

	skill_stats = list(
		SKILL_MELEE = 30*0.4,
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT,
	)

	attack_delay = 10*0.5
	attack_delay_max = 10


/damagetype/melee/club/shield/energy/on
	name = "active energy shield"


	//impact_sounds = list('sound/weapon/melee/saberon.ogg')

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 45*0.1,
		LASER = 45*0.4,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 40*0.25,
		LASER = 40*0.75,
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 45*0.4
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT
	)

	skill_stats = list(
		SKILL_MELEE = 45*0.1
	)

	skill_damage = list(
		SKILL_MELEE = LASER
	)

	attack_delay = 12*0.5
	attack_delay_max = 12

/damagetype/melee/club/shield/energy
	name = "ianctive energy shield"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 15*0.1
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 10
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 15*0.5,
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT
	)

	skill_stats = list(
		SKILL_MELEE = 15*0.4,
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT,
	)

	attack_delay = 8*0.5
	attack_delay_max = 8