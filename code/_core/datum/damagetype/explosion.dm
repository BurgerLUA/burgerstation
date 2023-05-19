//Explosion damage follows this graph: https://www.desmos.com/calculator/ia1lj88rdt (OUTDATED)
//Calculated in do_explosion_damage().

/damagetype/explosion/

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BOMB = 20,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BOMB = 0,
	)

	hit_effect = null

	can_be_parried = FALSE

	impact_sounds = null

	target_floors = TRUE

	enable_logs = 1

/damagetype/explosion/process_damage(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/damage_multiplier=1)

	. = ..()

	if(is_living(victim))
		var/mob/living/L = victim
		var/flash_duration = clamp(damage_multiplier,SECONDS_TO_DECISECONDS(1),SECONDS_TO_DECISECONDS(4))
		L.flash(flash_duration)
		var/bang_duration = clamp(damage_multiplier,SECONDS_TO_DECISECONDS(4),SECONDS_TO_DECISECONDS(10))
		L.bang(bang_duration)