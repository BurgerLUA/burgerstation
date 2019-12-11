/damagetype/npc/cow
	name = "Cow Headbutt"
	id = "cow_headbutt"
	desc = "The headbutt of a cow."
	attack_verbs = list("headbutt")
	weapon_name = "head"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_C,
	)

	attack_damage_penetration = list(
		BLUNT = ARMOR_D,
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_B,
		ATTRIBUTE_DEXTERITY = CLASS_D
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT,
		ATTRIBUTE_DEXTERITY = BLUNT
	)

	skill_stats = list(
		SKILL_UNARMED = CLASS_D
	)

	skill_damage = list(
		SKILL_UNARMED = BLUNT
	)

	skill_xp_per_damage = list(
		SKILL_UNARMED = SKILL_D
	)