/damagetype/unarmed/cqc/sleeping_carp/damagetype/get_critical_hit_condition(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)

	if(is_living(attacker))
		var/mob/living/L = attacker
		if(L.boss)
			return TRUE

	. = ..()

/damagetype/unarmed/cqc/sleeping_carp/crashing_wave_kick
	attack_verbs = list("crashing wave kick")

	impact_sounds = list(
		'sound/weapons/unarmed/cqc/crashing_wave_kick.ogg',
	)

	hit_effect = /obj/effect/temp/impact/combat/punch

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 40,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 0,
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 20,
		ATTRIBUTE_DEXTERITY = 40
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT,
		ATTRIBUTE_DEXTERITY = BLUNT
	)

	skill_stats = list(
		SKILL_UNARMED = 40
	)

	skill_damage = list(
		SKILL_UNARMED = BLUNT
	)

	attack_delay = 20
	attack_delay_max = 30

/damagetype/unarmed/cqc/sleeping_carp/crashing_wave_kick/post_on_hit(var/atom/attacker,var/turf/attacker_turf,var/atom/victim,var/turf/victim_turf,var/atom/weapon,var/atom/hit_object,var/total_damage_dealt=0)

	if(is_living(victim))
		var/list/offsets = get_directional_offsets(attacker,victim)
		var/mob/living/L = victim
		if(get_dist(attacker,victim) <= 0 || !(offsets[1] || offsets[2]))
			L.add_status_effect(STUN,20,20,source = attacker)
		else
			L.throw_self(attacker,null,16,16,offsets[1]*12,offsets[2]*12,lifetime=SECONDS_TO_DECISECONDS(1))

	if(is_living(attacker))
		var/mob/living/L = attacker
		L.add_status_effect(STUN,20,20)

	return ..()


/damagetype/unarmed/cqc/sleeping_carp/keelhaul

	impact_sounds = list(
		'sound/weapons/unarmed/cqc/keelhaul_01.ogg',
		'sound/weapons/unarmed/cqc/keelhaul_02.ogg'
	)

	attack_damage_base = list(
		BLUNT = 20
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 30,
		ATTRIBUTE_DEXTERITY = 20
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT,
		ATTRIBUTE_DEXTERITY = BLUNT
	)

	skill_stats = list(
		SKILL_UNARMED = 30
	)

	skill_damage = list(
		SKILL_UNARMED = BLUNT
	)

	attack_delay = 10
	attack_delay_max = 15


/damagetype/unarmed/cqc/sleeping_carp/keelhaul/post_on_hit(var/atom/attacker,var/turf/attacker_turf,var/atom/victim,var/turf/victim_turf,var/atom/weapon,var/atom/hit_object,var/total_damage_dealt=0)

	if(is_living(victim))
		var/mob/living/L = victim
		if(L.horizontal)
			L.add_status_effect(DISARM,10,10)
		else
			L.add_status_effect(STUN,10,10)


	return ..()



/damagetype/unarmed/cqc/sleeping_carp/gnashing_teeth
	attack_verbs = list("gnashing teeth punch")

	impact_sounds = list(
		'sound/weapons/unarmed/cqc/gnashing_teeth_01.ogg',
		'sound/weapons/unarmed/cqc/gnashing_teeth_02.ogg'
	)

	hit_effect = /obj/effect/temp/impact/combat/punch

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 10,
		BLADE = 10
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 0,
		BLADE = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 25,
		ATTRIBUTE_DEXTERITY = 25
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT,
		ATTRIBUTE_DEXTERITY = BLADE
	)

	skill_stats = list(
		SKILL_UNARMED = 50
	)

	skill_damage = list(
		SKILL_UNARMED = list(BLUNT,BLADE)
	)

	cqc_tag = "4"

	attack_delay = 4
	attack_delay_max = 8