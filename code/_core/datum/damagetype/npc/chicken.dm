/damagetype/npc/chicken
	name = "Chicken Damage"
	id = "chicken_peck"
	desc = "The peck of a checken."
	attack_verbs = list("pecks","claws","kicks")
	weapon_name = "beak"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = DAMAGE_E,
		BLUNT = DAMAGE_E,
		PIERCE = DAMAGE_E
	)

	//The damage conversion table of the weapon. Useful for when you want blade attacks to deal holy damage or something.
	attack_damage_conversion = list(
		BLADE = BRUTE,
		BLUNT = BRUTE,
		PIERCE = BRUTE
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = ARMOR_F,
		BLUNT = ARMOR_F,
		PIERCE = ARMOR_F
	)


	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_D,
		ATTRIBUTE_DEXTERITY = CLASS_E
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