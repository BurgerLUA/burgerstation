/damagetype/item



/damagetype/item/light
	name = "light item"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 30*0.1,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	//BALANCE EXCEPTION: NO AP
	attack_damage_penetration = list(
		BLUNT = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 30*0.6
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT,
	)

	skill_stats = list(
		SKILL_MELEE = 30*0.3,
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT
	)

	//BALANCE EXCEPTION: SPEED PENALTY
	attack_delay = 12*0.5
	attack_delay_max = 12


/damagetype/item/medium
	name = "medium item"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 45*0.1,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	//BALANCE EXCEPTION: NO AP
	attack_damage_penetration = list(
		BLUNT = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 45*0.6
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT,
	)

	skill_stats = list(
		SKILL_MELEE = 45*0.3,
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT
	)

	//BALANCE EXCEPTION: SPEED PENALTY
	attack_delay = SPEED_CLUB*0.5
	attack_delay_max = SPEED_CLUB

/damagetype/item/heavy
	name = "heavy item"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_CLUB*0.1,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	//BALANCE EXCEPTION: NO AP
	attack_damage_penetration = list(
		BLUNT = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = DAMAGE_CLUB*0.6
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT,
	)

	skill_stats = list(
		SKILL_MELEE = DAMAGE_CLUB*0.3,
	)

	skill_damage = list(
		SKILL_MELEE = BLUNT
	)

	//BALANCE EXCEPTION: SPEED PENALTY
	attack_delay = SPEED_GREATSWORD*0.5
	attack_delay_max = SPEED_GREATSWORD