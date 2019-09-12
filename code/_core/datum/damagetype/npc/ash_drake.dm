/damagetype/npc/ash_drake/
	name = "Ash Drake Claw"
	id = "ash_drake_claw"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 50,
		BLUNT = 10,
		PIERCE = 20
	)

	//The damage conversion table of the weapon. Useful for when you want blade attacks to deal holy damage or something.
	attack_damage_conversion = list(
		BLADE = BRUTE,
		BLUNT = BRUTE,
		PIERCE = BRUTE
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 20,
		BLUNT = 30,
		PIERCE = 50,
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_B,
		ATTRIBUTE_DEXTERITY = CLASS_B
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLADE,
		ATTRIBUTE_DEXTERITY = PIERCE
	)

	skill_stats = list(
		SKILL_UNARMED = CLASS_D,
	)

	skill_damage = list(
		SKILL_UNARMED = BLADE,
	)

	skill_xp_per_damage = list(
		SKILL_UNARMED = 1
	)