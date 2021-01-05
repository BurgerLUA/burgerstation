/damagetype/melee/sword/gladius
	name = "gladius"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = DAMAGE_DAGGER*0.3*BASE_MELEE_MUL,
		PIERCE = DAMAGE_DAGGER*0.2*BASE_MELEE_MUL
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = AP_DAGGER*0.5,
		PIERCE = AP_DAGGER*0.5
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = DAMAGE_DAGGER*0.1,
		ATTRIBUTE_DEXTERITY = DAMAGE_DAGGER*0.2
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLADE,
		ATTRIBUTE_DEXTERITY = PIERCE
	)

	skill_stats = list(
		SKILL_MELEE = DAMAGE_DAGGER*0.2
	)

	skill_damage = list(
		SKILL_MELEE = BLADE
	)

	attack_delay = SPEED_DAGGER*0.5
	attack_delay_max = SPEED_DAGGER