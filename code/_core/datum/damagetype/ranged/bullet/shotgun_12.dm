/damagetype/ranged/bullet/shotgun_12/

	attack_damage_base = list(
		BLADE = 10,
		BLUNT = 20,
		PIERCE = 5
	)
	attack_damage_penetration = list(
		BLADE = 0,
		BLUNT = 0,
		PIERCE = 0
	)

	falloff = 3

	damage_type_to_fatigue = list(
		BLADE = 0.20,
		BLUNT = 0.3,
		PIERCE = 0.1,
		BOMB = 1
	)

/damagetype/ranged/bullet/shotgun_12/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL

/damagetype/ranged/bullet/shotgun_12/slug
	attack_damage_base = list(
		BLUNT = 80,
	)
	attack_damage_penetration = list(
		BLUNT = 0
	)
	falloff = VIEW_RANGE

/damagetype/ranged/bullet/shotgun_12/slug/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL

/damagetype/ranged/bullet/shotgun_12/flechette
	attack_damage_base = list(
		BLADE = 10,
		PIERCE = 25
	)
	attack_damage_penetration = list(
		BLADE = 25,
		PIERCE = 50
	)
	falloff = 3

/damagetype/ranged/bullet/shotgun_12/flechette/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL
