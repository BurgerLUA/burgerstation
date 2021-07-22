/damagetype/ranged/bullet/holybullet
	name = "Holy Bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 20,
		PIERCE = 20,
		HOLY = 20
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 20,
		PIERCE = 20,
		HOLY = 30
	)

	skill_stats = list(
		SKILL_PRAYER = 300,
	)


	skill_damage = list(
		SKILL_PRAYER = list(PIERCE, HOLY, BLUNT)
	)

	bonus_experience_skill = list(
		SKILL_PRAYER = 10, //75%
		SKILL_RANGED = 40
	)

/damagetype/ranged/bullet/holybullet/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL