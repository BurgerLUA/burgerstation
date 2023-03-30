/damagetype/ranged/laser/holy
	attack_damage_base = list(
		PIERCE = 10,
		HEAT = 10,
		LASER = 10,
		HOLY = 25
	)
	attack_damage_penetration = list(
		PIERCE = 75,
		HEAT = 40,
		HOLY = 100
	)

/damagetype/ranged/laser/holy/get_attack_damage(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/damage_multiplier=1)

	damage_multiplier = 0.01

	. = ..()