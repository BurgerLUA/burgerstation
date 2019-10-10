//Fists
/damagetype/unarmed/fists/
	name = "Fist"
	id = "fist"
	desc = "Your human fist."
	attack_verbs = list("punch","hit","slap","strike","pummel","pound")
	weapon_name = "fist"

	hit_effect = /obj/effect/temp/impact/combat/punch

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 5,
		FATIGUE = 20
	)

	//The damage conversion table of the weapon. Useful for when you want blade attacks to deal holy damage or something.
	attack_damage_conversion = list(
		BLUNT = BRUTE,
		FATIGUE = STAMINA
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 50,
		FATIGUE = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_B,
		ATTRIBUTE_DEXTERITY = CLASS_C
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT,
		ATTRIBUTE_DEXTERITY = BLUNT
	)

	skill_stats = list(
		SKILL_UNARMED = CLASS_B
	)

	skill_damage = list(
		SKILL_UNARMED = BLUNT
	)

	skill_xp_per_damage = list(
		SKILL_UNARMED = 1
	)
