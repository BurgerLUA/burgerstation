/damagetype/chess/

	impact_sounds = list(
		'sound/effects/impacts/shield_wood.ogg'
	)

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 120
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 80
	)

	attack_delay = 10
	attack_delay_max = 10

	crit_multiplier = 20

/damagetype/chess/get_critical_hit_condition(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	return istype(victim,/mob/living/simple/chess_piece)