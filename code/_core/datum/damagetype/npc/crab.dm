/damagetype/npc/crab
	name = "Crab Claw"
	id = "crab_claw"
	desc = "The claw of a crab"
	attack_verbs = list("pinch","snip")
	weapon_name = "claw"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = DAMAGE_D,
		PIERCE = DAMAGE_E,
	)

	//The damage conversion table of the weapon. Useful for when you want blade attacks to deal holy damage or something.
	attack_damage_conversion = list(
		BLADE = BRUTE,
		PIERCE = BRUTE
	)

	attack_damage_penetration = list(
		BLADE = ARMOR_D,
		PIERCE = ARMOR_B
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_B,
		ATTRIBUTE_DEXTERITY = CLASS_D
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = PIERCE,
		ATTRIBUTE_DEXTERITY = BLADE
	)

	skill_stats = list(
		SKILL_UNARMED = CLASS_D
	)

	skill_damage = list(
		SKILL_UNARMED = PIERCE
	)

	skill_xp_per_damage = list(
		SKILL_UNARMED = SKILL_D
	)