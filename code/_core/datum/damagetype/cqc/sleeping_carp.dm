/damagetype/cqc/sleeping_carp/crashing_wave_kick
	name = "crashing wave kick"

	attack_damage_base = list(
		BLUNT = 0,
		FATIGUE = 0
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 50,
		FATIGUE = 75,
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 25,
		ATTRIBUTE_DEXTERITY = 25
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(FATIGUE,BLUNT),
		ATTRIBUTE_DEXTERITY = list(FATIGUE,BLUNT)
	)

	skill_stats = list(
		SKILL_UNARMED = 40
	)

	skill_damage = list(
		SKILL_UNARMED = BLUNT
	)


/damagetype/cqc/sleeping_carp/crashing_wave_kick/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)

	if(is_living(victim))
		var/list/offsets = direction_to_pixel_offset(get_dir(attacker,victim))
		var/mob/living/L = victim
		if(get_dist(attacker,victim) <= 0)
			L.add_status_effect(STUN,10,10,source = attacker)
		else
			L.throw_self(attacker,null,16,16,offsets[1]*12,offsets[2]*12)

	return ..()


/damagetype/cqc/sleeping_carp/keelhaul
	name = "keelhaul"

	attack_damage_base = list(
		BLUNT = 0,
		FATIGUE = 0
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = INFINITY,
		FATIGUE = INFINITY,
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 40,
		ATTRIBUTE_DEXTERITY = 20
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(FATIGUE,BLUNT),
		ATTRIBUTE_DEXTERITY = list(FATIGUE,BLUNT)
	)

	skill_stats = list(
		SKILL_UNARMED = 40
	)

	skill_damage = list(
		SKILL_UNARMED = BLUNT
	)


/damagetype/cqc/sleeping_carp/keelhaul/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)

	if(is_living(victim))
		var/mob/living/L = victim
		if(L.horizontal)
			L.add_status_effect(DISARM,10,10)
		else
			L.add_status_effect(STUN,10,10)


	return ..()



/damagetype/cqc/sleeping_carp/gnashing_teeth
	name = "gnashing teeth"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 20,
		FATIGUE = 30
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 25,
		FATIGUE = 25,
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 30,
		ATTRIBUTE_DEXTERITY = 30
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLUNT,FATIGUE),
		ATTRIBUTE_DEXTERITY = list(BLUNT,FATIGUE)
	)

	skill_stats = list(
		SKILL_UNARMED = 50
	)

	skill_damage = list(
		SKILL_UNARMED = list(BLUNT,FATIGUE)
	)