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

/damagetype/explosion/process_damage(atom/attacker,atom/victim,atom/weapon,atom/hit_object,atom/blamed,damage_multiplier=1)

	. = ..()

	if(is_living(victim))
		var/mob/living/L = victim
		var/flash_duration = clamp(damage_multiplier,1 SECONDS,4 SECONDS)
		L.flash(flash_duration)
		var/bang_duration = clamp(damage_multiplier,4 SECONDS,10 SECONDS)
		L.bang(bang_duration)
