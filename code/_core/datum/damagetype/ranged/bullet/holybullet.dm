/damagetype/ranged/bullet/holybullet
	name = "Holy Bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 20,
		PIERCE = 20,
		HOLY = 30
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 20,
		PIERCE = 20,
		HOLY = 30
	)

	skill_damage = list(
		SKILL_PRAYER = PIERCE
	)

	bonus_experience_skill = list(
		SKILL_PRAYER = 50 //75%
	)

/damagetype/ranged/magic/holybullet/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL