/damagetype/npc/ghost //Needs to do a lot of damage.
	name = "ghost hunt"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 100,
		DARK = 100,
		COLD = 100
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		DARK = INFINITY
	)

	miss_sounds = list()
	impact_sounds = list()
	impact_sounds_flesh = list()

	ignore_armor_bonus_damage = TRUE

	can_be_parried = FALSE

	attack_delay = 1
	attack_delay_max = 1

/*
/damagetype/npc/ghost/swing(var/atom/attacker,var/list/atom/victims = list(),var/atom/weapon,var/list/atom/hit_objects = list(),var/atom/blamed,var/damage_multiplier=1)

	for(var/mob/living/L in victims)
		L.smite()

	return TRUE

/
/damagetype/npc/ghost/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)

	if(is_living(victim))
		var/mob/living/L = victim
		if(L.dead) L.smite()

	return ..()
*/