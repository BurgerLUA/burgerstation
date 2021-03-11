/damagetype/ranged/bow/hardlight
	name = "bow"
	damage_mod = 2

	bonus_experience_skill = list(
		SKILL_RANGED = 50 //100%
	)

	attack_damage_base = list(
		LASER = DAMAGE_GREATSWORD*0.3,
		HEAT = DAMAGE_GREATSWORD*0.1
	)

	attack_damage_penetration = list(
		LASER = AP_GREATSWORD*0.75,
		HEAT = AP_GREATSWORD*0.25
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = DAMAGE_GREATSWORD*0.2,
		ATTRIBUTE_DEXTERITY = DAMAGE_GREATSWORD*0.1
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(LASER,HEAT),
		ATTRIBUTE_DEXTERITY = list(LASER,HEAT)
	)

	skill_stats = list(
		SKILL_RANGED = AP_GREATSWORD*0.3
	)

	skill_damage = list(
		SKILL_RANGED = list(LASER,BLADE)
	)