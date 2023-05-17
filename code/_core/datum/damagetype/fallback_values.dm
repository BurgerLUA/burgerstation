/damagetype/item
	animate = TRUE


/damagetype/item/trivial

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 2,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	//BALANCE EXCEPTION: NO AP
	attack_damage_penetration = list(
		BLUNT = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 5
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT,
	)

	skill_stats = list(
		SKILL_MELEE = 5,
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT
	)

	//BALANCE EXCEPTION: SPEED PENALTY
	attack_delay = 10
	attack_delay_max = 10



/damagetype/item/light

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 5,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	//BALANCE EXCEPTION: NO AP
	attack_damage_penetration = list(
		BLUNT = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 20
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT,
	)

	skill_stats = list(
		SKILL_MELEE = 10,
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT
	)

	//BALANCE EXCEPTION: SPEED PENALTY
	attack_delay = 10
	attack_delay_max = 10


/damagetype/item/medium

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 15,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	//BALANCE EXCEPTION: NO AP
	attack_damage_penetration = list(
		BLUNT = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 30
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT,
	)

	skill_stats = list(
		SKILL_MELEE = 10,
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT
	)

	//BALANCE EXCEPTION: SPEED PENALTY
	attack_delay = 15
	attack_delay_max = 15

/damagetype/item/heavy

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 20,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	//BALANCE EXCEPTION: NO AP
	attack_damage_penetration = list(
		BLUNT = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 50
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT,
	)

	skill_stats = list(
		SKILL_MELEE = 10,
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT
	)

	//BALANCE EXCEPTION: SPEED PENALTY
	attack_delay = 20
	attack_delay_max = 20

/damagetype/item/super

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 20,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	//BALANCE EXCEPTION: NO AP
	attack_damage_penetration = list(
		BLUNT = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 70
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT,
	)

	skill_stats = list(
		SKILL_MELEE = 10,
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT
	)

	//BALANCE EXCEPTION: SPEED PENALTY
	attack_delay = 30
	attack_delay_max = 30