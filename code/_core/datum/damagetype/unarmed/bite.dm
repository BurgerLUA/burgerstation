/damagetype/unarmed/bite/
	name = "bite"
	attack_verbs = list("bite")

	hit_effect = /obj/effect/temp/impact/combat/bite


	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 5,
		PIERCE = 10
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 25,
		PIERCE = 50
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 75,
		ATTRIBUTE_DEXTERITY = 10
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLADE,PIERCE),
		ATTRIBUTE_DEXTERITY = list(BLADE,PIERCE)
	)

	skill_stats = list(
		SKILL_UNARMED = 25
	)

	skill_damage = list(
		SKILL_UNARMED = list(BLADE,PIERCE),
	)

	throw_mul = 1


/damagetype/unarmed/bite/zombie
	name = "zombie bite"
	attack_verbs = list("bite","chomp","gnaw")

	impact_sounds = list(
		'sound/weapons/fists/bite.ogg'
	)

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 10,
		BLUNT = 5,
		PIERCE = 20,
		BIO = 30
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 75,
		BLUNT = 75,
		PIERCE = 75,
		BIO = 0
	)


	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 50,
		ATTRIBUTE_DEXTERITY = 25
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLADE,BLUNT,PIERCE),
		ATTRIBUTE_DEXTERITY = list(BLADE,BLUNT,PIERCE)
	)

	skill_stats = list(
		SKILL_UNARMED = 25
	)

	skill_damage = list(
		SKILL_UNARMED = list(BLADE,BLUNT,PIERCE)
	)