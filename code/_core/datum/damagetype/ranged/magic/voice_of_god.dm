/damagetype/ranged/magic/voice_of_god/harm
	attack_damage_base = list(
		HOLY = 60*0.25
	)

	skill_stats = list(
		SKILL_PRAYER = 60*0.25
	)

	skill_damage = list(
		SKILL_PRAYER = HOLY
	)

/damagetype/ranged/magic/voice_of_god/bleed
	attack_damage_base = list(
		BLADE = 60*0.125,
		HOLY = 60*0.125 //30 damage base
	)

	skill_stats = list(
		SKILL_PRAYER = 60*0.25,
	)

	skill_damage = list(
		SKILL_PRAYER = list(BLADE,HOLY)
	)

	bonus_experience_skill = list(
		SKILL_MAGIC_OFFENSIVE = 75 //75%
	)

/damagetype/ranged/magic/voice_of_god/bleed/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)
	if(is_living(victim))
		var/mob/living/L = victim
		var/turf/T = get_turf(L)
		if(L.blood_type)
			var/reagent/R = REAGENT(L.blood_type)
			for(var/i=1,i<=rand(3,5),i++)
				create_blood(/obj/effect/cleanable/blood/splatter/,T,R.color,rand(-TILE_SIZE*3,TILE_SIZE*3),rand(-TILE_SIZE*3,TILE_SIZE*3))
	return ..()