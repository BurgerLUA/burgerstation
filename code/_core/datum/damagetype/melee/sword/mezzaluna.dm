/damagetype/melee/sword/mezzaluna
	name = "mezzaluna"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = DAMAGE_GREATAXE*0.2*BASE_MELEE_MUL,
		BLUNT = DAMAGE_GREATAXE*0.1*BASE_MELEE_MUL
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = AP_GREATAXE*0.5,
		BLUNT = AP_GREATAXE*0.5
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = DAMAGE_GREATAXE*0.5
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLADE
	)

	skill_stats = list(
		SKILL_MELEE = DAMAGE_GREATAXE*0.2,
	)

	skill_damage = list(
		SKILL_MELEE = BLADE
	)

	attack_delay = SPEED_GREATAXE*0.5
	attack_delay_max = SPEED_GREATAXE