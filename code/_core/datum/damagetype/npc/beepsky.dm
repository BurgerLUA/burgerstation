/damagetype/npc/captain_beepsky
	name = "Bluespace Stunbaton"
	attack_verbs = list("stun")
	weapon_name = "bluespace stunbaton"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		FATIGUE = 50
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		FATIGUE = 1000,
	)

	attribute_stats = list()

	attribute_damage = list()

	skill_stats = list()

	skill_damage = list()

	allow_friendly_fire = TRUE

	attack_delay = 10
	attack_delay_max = 10

/damagetype/npc/captain_beepsky/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)

	if(is_living(victim))
		var/mob/living/L = victim
		if(!L.horizontal)
			L.add_status_effect(STAGGER,30,30,source = attacker)
		else
			var/list/possible_teleport_turfs = list()
			for(var/turf/T in range(12,attacker))
				if(!T.is_safe_teleport())
					continue
				possible_teleport_turfs += T

			if(length(possible_teleport_turfs))
				L.force_move(pick(possible_teleport_turfs))

	return ..()




