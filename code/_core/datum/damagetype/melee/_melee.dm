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

/damagetype/melee/post_on_hit(var/atom/attacker,var/turf/attacker_turf,var/atom/victim,var/turf/victim_turf,var/atom/weapon,var/atom/hit_object,var/total_damage_dealt=0)
	. = ..()
	if(condition_on_hit && is_item(weapon))
		var/obj/item/I = weapon
		I.use_condition(1)


/damagetype/melee/get_attack_damage(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/damage_multiplier=1)

	if(victim && is_living(victim))
		var/mob/living/L = victim
		if(L.boss && attacker && attacker.is_player_controlled())
			damage_multiplier *= 2

	. = ..()