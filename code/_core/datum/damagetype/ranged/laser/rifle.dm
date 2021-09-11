/damagetype/ranged/laser/rifle
	attack_damage_base = list(
		LASER = 50,
		HEAT = 10
	)
	attack_damage_penetration = list(
		LASER = 25,
		HEAT = 25
	)

/damagetype/ranged/laser/rifle/hardlight
	attack_damage_base = list(
		BLUNT = 10,
		PIERCE = 30,
		LASER = 10,
		COLD = 10
	)
	attack_damage_penetration = list(
		BLUNT = 50,
		PIERCE = 50,
		LASER = 50,
		COLD = 50
	)

/damagetype/ranged/laser/rifle/xray
	attack_damage_base = list(
		LASER = 30,
		HEAT = 10,
		RAD = 30
	)
	attack_damage_penetration = list(
		LASER = 200,
		HEAT = 200,
		RAD = 200
	)

/damagetype/ranged/laser/rifle/sniper
	attack_damage_base = list(
		LASER = 250,
		HEAT = 50,
		RAD = 10
	)
	attack_damage_penetration = list(
		LASER = 250,
		HEAT = 50,
		RAD = 10
	)
	falloff = VIEW_RANGE + ZOOM_RANGE*5