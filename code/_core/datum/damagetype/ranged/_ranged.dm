/damagetype/ranged/

	draw_blood = TRUE

	hit_effect = null //Handled elsewhere.

	miss_sounds = list(
		'sound/weapons/ranged/generic/bulletflyby1.ogg',
		'sound/weapons/ranged/generic/bulletflyby2.ogg',
		'sound/weapons/ranged/generic/bulletflyby3.ogg'
	)

	impact_sounds = list(
		'sound/weapons/ranged/generic/ric1.ogg',
		'sound/weapons/ranged/generic/ric2.ogg',
		'sound/weapons/ranged/generic/ric3.ogg',
		'sound/weapons/ranged/generic/ric4.ogg',
		'sound/weapons/ranged/generic/ric5.ogg'
	)

	impact_sounds_flesh = list(
		'sound/effects/impacts/bullet_meat1.ogg',
		'sound/effects/impacts/bullet_meat2.ogg',
		'sound/effects/impacts/bullet_meat3.ogg',
		'sound/effects/impacts/bullet_meat4.ogg'
	)

	attribute_stats = list()

	attribute_damage = list()

	skill_damage = list()

	throw_mul = 0.25

	can_be_parried = FALSE

	attack_delay = 0

	var/allow_glancing_blows = FALSE

	allow_power_attacks = FALSE

	alert_on_impact = ALERT_LEVEL_CAUTION

/damagetype/ranged/get_block_power_penetration(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	return 0.5

/damagetype/ranged/get_attack_type()
	return ATTACK_TYPE_RANGED

/damagetype/ranged/do_attack_animation(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	return FALSE

/damagetype/ranged/process_damage_group(var/atom/attacker,var/list/atom/victims,var/atom/weapon,var/atom/blamed,var/damage_multiplier=1)

	if(allow_glancing_blows && is_living(attacker))
		var/mob/living/L = attacker
		var/glancing_blow_chance = 5 + (0.5 - L.get_skill_power(SKILL_RANGED))*95
		if(glancing_blow_chance > 0 && prob(glancing_blow_chance))
			damage_multiplier *= 0.5

	. = ..()


/damagetype/ranged/do_attack_visuals(var/atom/attacker,var/turf/attacker_turf,var/atom/victim,var/turf/victim_turf,var/total_damage_dealt=0)

	if(hit_effect)
		new hit_effect(victim_turf)

	var/multiplier = clamp(TILE_SIZE * (total_damage_dealt / max(1,victim?.health?.health_max)) * 2,0,TILE_SIZE*0.25)
	var/list/offsets = get_directional_offsets(attacker_turf,victim_turf)

	if(is_living(victim))
		var/mob/living/M = victim
		if(M.client)
			M.client.recoil_pixel_x -= offsets[1]*multiplier
			M.client.recoil_pixel_y -= offsets[2]*multiplier




/*
/damagetype/ranged/get_attack_message_3rd(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	if(hit_object == victim)
		return span("warning","\The [victim] is hit by \the [src.name]!")
	else
		return span("warning","\The [victim] is hit in \the [hit_object.name] by the [src.name]!")

/damagetype/ranged/get_attack_message_1st(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	if(hit_object == victim)
		return span("danger","You are hit by \the [src.name]!")
	else
		return span("danger","You are hit in \the [hit_object.name] by the [src.name]!")

/damagetype/ranged/get_attack_message_sound(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	return span("danger","You hear an impact.")


/damagetype/ranged/display_hit_message(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)

	if(!ismob(victim))
		return FALSE

	victim.visible_message(\
		get_attack_message_3rd(attacker,victim,weapon,hit_object),\
		get_attack_message_1st(attacker,victim,weapon,hit_object),\
		get_attack_message_sound(attacker,victim,weapon,hit_object)\
	)

/damagetype/ranged/display_miss_message(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/miss_text = "misses!")

	if(!ismob(victim))
		return FALSE

	victim.visible_message(\
		replacetext(get_miss_message_3rd(attacker,victim,weapon,hit_object),"#REASON",miss_text),\
		replacetext(get_miss_message_1st(attacker,victim,weapon,hit_object),"#REASON",miss_text),\
		replacetext(get_miss_message_sound(attacker,victim,weapon,hit_object),"#REASON",miss_text)\
	)

/damagetype/ranged/get_miss_message_3rd(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	return span("warning","\The [victim] #REASON the [src.name]!")

/damagetype/ranged/get_miss_message_1st(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	return span("warning","You #REASON the [src.name]!")

*/






