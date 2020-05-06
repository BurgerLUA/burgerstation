/damagetype/npc/cow
	name = "cow's head"
	attack_verbs = list("headbutt")

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 5,
	)

	attack_damage_penetration = list(
		BLUNT = 15,
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 20
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT
	)

	skill_damage = list(
		SKILL_UNARMED = BLUNT
	)