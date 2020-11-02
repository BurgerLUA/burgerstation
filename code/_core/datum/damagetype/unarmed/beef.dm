/damagetype/unarmed/beef/
	name = "beef"
	attack_verbs = list("maul")

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_CLUB*0.3,
		DARK = DAMAGE_CLUB*0.2
	)

	impact_sounds = list(
		'sound/weapons/beef/beef_hit.ogg'
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = AP_CLUB*0.25,
		DARK = AP_CLUB*0.75
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = DAMAGE_CLUB*0.2,
		ATTRIBUTE_DEXTERITY = DAMAGE_CLUB*0.2
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT,
		ATTRIBUTE_DEXTERITY = BLUNT
	)

	skill_stats = list(
		SKILL_UNARMED = DAMAGE_CLUB*0.1
	)

	skill_damage = list(
		SKILL_UNARMED = BLUNT,
	)

	throw_mul = 1

	damage_type_to_fatigue = list( //What percentage of damage blocked is converted into fatigue.
		BLUNT = 1,
		DARK = 1
	)

	attack_delay = SPEED_CLUB*0.5
	attack_delay_max = SPEED_CLUB