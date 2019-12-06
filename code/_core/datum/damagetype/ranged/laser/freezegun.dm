/damagetype/ranged/laser/freezegun
	name = "Freeze Gun"
	id = "freezegun"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		LASER = DAMAGE_D,
		COLD = DAMAGE_A,
		FATIGUE = DAMAGE_D
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		COLD = ARMOR_A
	)

	attribute_stats = list()

	attribute_damage = list()

	skill_stats = list()

	skill_damage = list()

	skill_xp_per_damage = list(
		SKILL_RANGED = SKILL_C
	)