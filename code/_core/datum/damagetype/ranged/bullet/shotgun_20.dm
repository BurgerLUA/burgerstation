/damagetype/ranged/bullet/shotgun_20/

	attack_damage_base = list(
		BLADE = 2,
		BLUNT = 10,
		PIERCE = 3
	)

	damage_type_to_fatigue = list(
		BLADE = 0.20,
		BLUNT = 0.3,
		PIERCE = 0.1,
		BOMB = 1
	)

	attack_damage_penetration = list(
		BLADE = 0,
		BLUNT = 0,
		PIERCE = 0
	)
	falloff = 3

/damagetype/ranged/bullet/shotgun_20/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL

/damagetype/ranged/bullet/shotgun_20/slug
	attack_damage_base = list(
		BLUNT = 60
	)
	attack_damage_penetration = list(
		BLUNT = 0
	)
	falloff = VIEW_RANGE

/damagetype/ranged/bullet/shotgun_20/slug/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL

/damagetype/ranged/bullet/shotgun_20/flechette
	attack_damage_base = list(
		BLADE = 5,
		PIERCE = 10
	)
	attack_damage_penetration = list(
		BLADE = 25,
		PIERCE = 50,
	)
	falloff = 3

/damagetype/ranged/bullet/shotgun_20/flechette/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL