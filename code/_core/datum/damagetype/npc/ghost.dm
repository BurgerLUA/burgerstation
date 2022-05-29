/damagetype/npc/ghost //Needs to do a lot of damage.

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 100,
		DARK = 100,
		COLD = 100
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		DARK = INFINITY
	)

	miss_sounds = list()
	impact_sounds = list()
	impact_sounds_flesh = list()

	ignore_armor_bonus_damage = TRUE

	can_be_parried = FALSE

	attack_delay = 1
	attack_delay_max = 1