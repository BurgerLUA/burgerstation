/damagetype/unarmed/fists/stand
	name = "stand fist"
	attack_verbs = list("punch","hit","slap","strike","pummel","pound")

	hit_effect = /obj/effect/temp/impact/combat/punch

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_CLUB*0.25,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = AP_CLUB
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = DAMAGE_CLUB*0.25,
		ATTRIBUTE_DEXTERITY = DAMAGE_CLUB*0.25
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT,
		ATTRIBUTE_DEXTERITY = BLUNT
	)

	skill_stats = list(
		SKILL_UNARMED = DAMAGE_CLUB*0.25
	)

	skill_damage = list(
		SKILL_UNARMED = list(BLUNT)
	)

	allow_friendly_fire = FALSE

	cqc_tag = "4"

	attack_delay = SPEED_CLUB*0.5
	attack_delay_max = SPEED_CLUB