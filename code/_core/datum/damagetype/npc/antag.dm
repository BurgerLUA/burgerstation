/damagetype/npc/antag //Needs to do a lot of damage.
	name = "antag"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		FATIGUE = 100
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		FATIGUE = INFINITY
	)

	miss_sounds = list()
	impact_sounds = list()
	impact_sounds_flesh = list()

	ignore_armor_bonus_damage = TRUE

	can_be_parried = FALSE

	attack_delay = 30
	attack_delay_max = 30


/damagetype/npc/antag/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)

	if(is_living(victim))
		var/mob/living/L = victim
		if(!L.dead)
			L.death()

	return ..()