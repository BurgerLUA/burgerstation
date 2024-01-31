/damagetype/melee/
	draw_blood = TRUE
	draw_weapon = TRUE

	damage_mod = 1
	penetration_mod = 1

	experience_mod = 2

	var/condition_on_hit = TRUE

	savage_hit_threshold = 0.25

	sneak_attack_multiplier = 4

	animate = TRUE

	alert_on_impact = ALERT_LEVEL_NOISE

	can_be_parried = TRUE

/damagetype/melee/post_on_hit(atom/attacker,turf/attacker_turf,atom/victim,turf/victim_turf,atom/weapon,atom/hit_object,total_damage_dealt=0)
	. = ..()
	if(condition_on_hit && is_item(weapon))
		var/obj/item/I = weapon
		I.use_condition(1)


/damagetype/melee/get_attack_damage(atom/attacker,atom/victim,atom/weapon,atom/hit_object,damage_multiplier=1)

	if(victim && is_living(victim))
		var/mob/living/L = victim
		if(L.boss && attacker && attacker.is_player_controlled())
			damage_multiplier *= 2

	. = ..()