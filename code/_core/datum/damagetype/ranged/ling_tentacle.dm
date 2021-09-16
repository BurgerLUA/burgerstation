/damagetype/ranged/ling_tentacle/pull //I'm sorry.
	hit_effect = /obj/effect/temp/impact/combat/punch

	attack_damage_base = list(
		BLUNT = 10,
		BIO = 20,
		FATIGUE = 10
	)

	attack_damage_penetration = list(
		BLUNT = 50
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 20,
		ATTRIBUTE_DEXTERITY = 30
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BIO,FATIGUE),
		ATTRIBUTE_DEXTERITY = list(BIO,FATIGUE)
	)

	skill_stats = list(
		SKILL_MELEE = 20,
	)

	skill_damage = list(
		SKILL_UNARMED = list(BIO,FATIGUE)
	)

	throw_mul = 1

/damagetype/ranged/ling_tentacle/pull/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)

	if(is_living(victim))
		var/list/offsets = direction_to_pixel_offset(get_dir(attacker,victim))
		var/mob/living/L = victim
		var/mob/living/A = attacker
		var/distance = get_dist(A,L)
		if(distance <= 0)
			L.add_status_effect(STUN,20,20,source = attacker)
		else
			L.throw_self(attacker,null,16,16,offsets[1]*(-distance*3),offsets[2]*(-distance*3))

/damagetype/ranged/ling_tentacle/warp

	hit_effect = /obj/effect/temp/impact/combat/punch

	attack_damage_base = list(
		BLUNT = 10,
		BIO = 20,
		FATIGUE = 10
	)

	attack_damage_penetration = list(
		BLUNT = 50
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 20,
		ATTRIBUTE_DEXTERITY = 30
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BIO,FATIGUE),
		ATTRIBUTE_DEXTERITY = list(BIO,FATIGUE)
	)

	skill_stats = list(
		SKILL_MELEE = 20,
	)

	skill_damage = list(
		SKILL_UNARMED = list(BIO,FATIGUE)
	)

	throw_mul = 1

/damagetype/ranged/ling_tentacle/warp/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)
	//Make sure to thank Burger.
	if(is_living(victim))
		var/mob/living/L = victim
		var/mob/living/A = attacker
		var/list/valid_turfs = list()
		for(var/d in DIRECTIONS_ALL)
			var/turf/T = get_step(L,d)
			if(!T || !T.is_safe_teleport())
				continue
			valid_turfs += T
			A.force_move(T)
		L.add_status_effect(STAGGER,5,5, source = attacker)

	return ..()