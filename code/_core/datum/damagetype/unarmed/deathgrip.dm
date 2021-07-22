/damagetype/unarmed/deathgrip
	name = "punch rush"

	hit_effect = /obj/effect/temp/impact/combat/punch

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 30*0.1,
		DARK = 30*0.2
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 20
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 30*0.3,
		ATTRIBUTE_DEXTERITY = 30*0.3
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLUNT,DARK),
		ATTRIBUTE_DEXTERITY = list(BLUNT,DARK)
	)

	skill_stats = list(
		SKILL_UNARMED = 30*0.3,
		SKILL_PRAYER = 30*0.3
	)

	skill_damage = list(
		SKILL_UNARMED = BLUNT,
		SKILL_PRAYER = DARK
	)

	throw_mul = 1

	attack_delay = 10*0.5
	attack_delay_max = 10

/damagetype/unarmed/deathgrip/pull
	name = "force-grab"

	hit_effect = /obj/effect/temp/impact/combat/punch

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 30*0.5,
		DARK = 30*0.5
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 20
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 30*0.6,
		ATTRIBUTE_DEXTERITY = 30*0.6
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLUNT,DARK),
		ATTRIBUTE_DEXTERITY = list(BLUNT,DARK)
	)

	skill_stats = list(
		SKILL_UNARMED = 30*0.6,
		SKILL_PRAYER = 30*0.6
	)

	skill_damage = list(
		SKILL_UNARMED = BLUNT,
		SKILL_PRAYER = DARK
	)

	throw_mul = 1

	attack_delay = 10*0.5
	attack_delay_max = 10

/damagetype/unarmed/deathgrip/pull/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)

	if(is_living(victim))
		var/list/offsets = direction_to_pixel_offset(get_dir(attacker,victim))
		var/mob/living/L = victim
		var/mob/living/A = attacker
		var/distance = get_dist(A,L)
		if(distance <= 0)
			L.add_status_effect(STUN,20,20,source = attacker)
		else
			L.throw_self(attacker,null,16,16,offsets[1]*(-distance*3),offsets[2]*(-distance*3))
