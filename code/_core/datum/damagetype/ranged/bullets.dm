/damagetype/ranged/bullet/
	name = "bullet"
	id = null

	base_attack_damage = list(
		BRUTE = 0,
		BURN = 0,
		TOX = 0,
		OXY = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_F,
		ATTRIBUTE_AGILITY = CLASS_F,
		ATTRIBUTE_INTELLIGENCE = CLASS_F
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BRUTE,
		ATTRIBUTE_AGILITY = BRUTE,
		ATTRIBUTE_INTELLIGENCE = BRUTE
	)

	skill_stats = list(
		SKILL_UNARMED = CLASS_F,
		SKILL_MELEE = CLASS_F,
		SKILL_RANGED = CLASS_F
	)

	skill_damage = list(
		SKILL_UNARMED = BRUTE,
		SKILL_MELEE = BRUTE,
		SKILL_RANGED = BRUTE
	)

	skill_xp_per_damage = list(
		SKILL_UNARMED = 0,
		SKILL_MELEE = 0,
		SKILL_RANGED = 0.5
	)

	hit_effect = null

/damagetype/ranged/bullet/bolt
	name = "metal bolt"
	id = "bolt_metal"

	base_attack_damage = list(
		BRUTE = 50,
		BURN = 0,
		TOX = 0,
		OXY = 0
	)

/damagetype/ranged/bullet/revolver_38
	name = ".38 bullet"
	id = ".38"

	base_attack_damage = list(
		BRUTE = 25,
		BURN = 0,
		TOX = 0,
		OXY = 0
	)


/damagetype/ranged/bullet/revolver_22
	name = ".22 bullet"
	id = ".22"

	base_attack_damage = list(
		BRUTE = 20,
		BURN = 0,
		TOX = 0,
		OXY = 0
	)

/damagetype/ranged/bullet/revolver_22/surplus
	name = ".22 surplus bullet"
	id = ".22_surplus"

	base_attack_damage = list(
		BRUTE = 15,
		BURN = 0,
		TOX = 0,
		OXY = 0
	)

/damagetype/ranged/bullet/sniper_50
	name = ".50 bullet"
	id = ".50"

	base_attack_damage = list(
		BRUTE = 80,
		BURN = 0,
		TOX = 0,
		OXY = 0
	)

/damagetype/ranged/bullet/pistol_50ae
	name = ".50AE bullet"
	id = ".50ae"

	base_attack_damage = list(
		BRUTE = 50,
		BURN = 0,
		TOX = 0,
		OXY = 0
	)

/damagetype/ranged/bullet/pistol_45
	name = ".45 bullet"
	id = ".45"

	base_attack_damage = list(
		BRUTE = 20,
		BURN = 0,
		TOX = 0,
		OXY = 0
	)

/damagetype/ranged/bullet/pistol_9mm //Look, I know there is an intense debate on whether or not .45 is stronger than 9mm. I'm going to just make them equal because FUCK MAKING A STANCE.
	name = "9mm bullet"
	id = "9mm"

	base_attack_damage = list(
		BRUTE = 20,
		BURN = 0,
		TOX = 0,
		OXY = 0
	)


/damagetype/ranged/bullet/rifle_762
	name = "7.62mm bullet"
	id = "7.62"

	base_attack_damage = list(
		BRUTE = 40,
		BURN = 0,
		TOX = 0,
		OXY = 0
	)

/damagetype/ranged/bullet/rifle_556
	name = "5.56mm bullet"
	id = "5.56"

	base_attack_damage = list(
		BRUTE = 30,
		BURN = 0,
		TOX = 0,
		OXY = 0
	)


/damagetype/ranged/bullet/pistol_10mm
	name = "10mm auto bullet"
	id = "10mm_auto"

	base_attack_damage = list(
		BRUTE = 25,
		BURN = 0,
		TOX = 0,
		OXY = 0
	)

/damagetype/ranged/bullet/revolver_44
	name = ".44 revolver bullet"
	id = ".44"

	base_attack_damage = list(
		BRUTE = 40,
		BURN = 0,
		TOX = 0,
		OXY = 0
	)


/damagetype/ranged/bullet/shotgun/buckshot
	name = "12 gauge buckshot pellet"
	id = "12_buckshot"

	base_attack_damage = list(
		BRUTE = 8,
		BURN = 0,
		TOX = 0,
		OXY = 0
	)

/damagetype/ranged/bullet/shotgun/slug
	name = "12 gauge buckshot slug"
	id = "12_slug"

	base_attack_damage = list(
		BRUTE = 50,
		BURN = 0,
		TOX = 0,
		OXY = 0
	)