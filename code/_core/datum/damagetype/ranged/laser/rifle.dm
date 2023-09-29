/damagetype/ranged/laser/rifle
	attack_damage_base = list(
		LASER = 50,
		HEAT = 10
	)
	attack_damage_penetration = list(
		LASER = 0,
		HEAT = 0
	)

/damagetype/ranged/laser/rifle/hardlight
	attack_damage_base = list(
		BLUNT = 10,
		PIERCE = 30,
		LASER = 10,
		COLD = 10
	)
	attack_damage_penetration = list(
		BLUNT = 0,
		PIERCE = 0,
		LASER = 0,
		COLD = 0
	)

/damagetype/ranged/laser/rifle/xray
	attack_damage_base = list(
		LASER = 30,
		HEAT = 10,
		RAD = 30
	)
	attack_damage_penetration = list(
		LASER = INFINITY,
		HEAT = INFINITY,
		RAD = INFINITY
	)

/damagetype/ranged/laser/rifle/sniper
	attack_damage_base = list(
		LASER = 250,
		HEAT = 50,
		RAD = 10
	)
	attack_damage_penetration = list(
		LASER = 0,
		HEAT = 0,
		RAD = 0
	)
	falloff = VIEW_RANGE + ZOOM_RANGE*5

/damagetype/ranged/laser/rifle/opticor
	attack_damage_base = list(
		LASER = 150,
		HEAT = 25,
		RAD = 10
	)
	attack_damage_penetration = list(
		LASER = 0,
		HEAT = 0,
		RAD = 0
	)
	falloff = VIEW_RANGE + ZOOM_RANGE*5
	allow_glancing_blows = TRUE