/damagetype/melee/club/torch/
	name = "torch"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_AXE*0.2*BASE_MELEE_MUL,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = AP_AXE
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = DAMAGE_AXE*0.7
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT
	)

	skill_stats = list(
		SKILL_MELEE = DAMAGE_AXE*0.1
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT,
	)

	attack_delay = SPEED_AXE*0.5
	attack_delay_max = SPEED_AXE

/damagetype/melee/club/torch/on
	name = "torch"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_AXE*0.1,
		HEAT = DAMAGE_AXE*0.5
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = AP_AXE*0.5,
		HEAT = AP_AXE*0.5
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = DAMAGE_AXE*0.2
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT
	)

	skill_stats = list(
		SKILL_MELEE = DAMAGE_AXE*0.1
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT,
	)

	attack_delay = SPEED_AXE*0.5
	attack_delay_max = SPEED_AXE