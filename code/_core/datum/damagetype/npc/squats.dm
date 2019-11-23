/damagetype/squats/
	name = "squats punch"
	id = "squats_punch"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 20,
		PIERCE = 5,
		FATIGUE = 10
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 20,
		PIERCE = 0,
		FATIGUE = 100
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_B,
		ATTRIBUTE_DEXTERITY = CLASS_D
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT,
		ATTRIBUTE_DEXTERITY = PIERCE,
	)

	skill_stats = list(
		SKILL_UNARMED = CLASS_B
	)

	skill_damage = list(
		SKILL_UNARMED = BLUNT,
	)

	skill_xp_per_damage = list()