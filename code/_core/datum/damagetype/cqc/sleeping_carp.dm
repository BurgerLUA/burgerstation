/damagetype/cqc/sleeping_carp/crashing_wave_kick
	name = "crashing wave kick"
	attack_verbs = list("crashing wave kick")

	impact_sounds = list(
		'sound/weapons/fists/cqc/crashing_wave_kick.ogg',
	)

	hit_effect = /obj/effect/temp/impact/combat/punch

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 10,
		FATIGUE = 5
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 50,
		FATIGUE = 50,
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 20,
		ATTRIBUTE_DEXTERITY = 40
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLUNT,FATIGUE),
		ATTRIBUTE_DEXTERITY = list(BLUNT,FATIGUE)
	)

	skill_stats = list(
		SKILL_UNARMED = 80
	)

	skill_damage = list(
		SKILL_UNARMED = list(BLUNT,FATIGUE)
	)

	allow_friendly_fire = FALSE

/damagetype/cqc/sleeping_carp/crashing_wave_kick/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)

	if(is_living(victim))
		var/list/offsets = direction_to_pixel_offset(get_dir(attacker,victim))
		var/mob/living/L = victim
		if(get_dist(attacker,victim) <= 0)
			L.add_status_effect(STUN,20,20,source = attacker)
		else
			L.throw_self(attacker,null,16,16,offsets[1]*12,offsets[2]*12)

	if(is_living(attacker))
		var/mob/living/L = attacker
		L.add_status_effect(STUN,20,20)

	return ..()


/damagetype/cqc/sleeping_carp/keelhaul
	name = "keelhaul"

	impact_sounds = list(
		'sound/weapons/fists/cqc/keelhaul_01.ogg',
		'sound/weapons/fists/cqc/keelhaul_02.ogg'
	)

	attack_damage_base = list(
		BLUNT = 10,
		FATIGUE = 5
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
	attack_verbs = list("gnashing teeth punch")

	impact_sounds = list(
		'sound/weapons/fists/cqc/gnashing_teeth_01.ogg',
		'sound/weapons/fists/cqc/gnashing_teeth_02.ogg'
	)

	hit_effect = /obj/effect/temp/impact/combat/punch

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 10,
		PIERCE = 20
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 25,
		PIERCE = 50,
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 40,
		ATTRIBUTE_DEXTERITY = 20
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLUNT,PIERCE),
		ATTRIBUTE_DEXTERITY = list(BLUNT,PIERCE)
	)

	skill_stats = list(
		SKILL_UNARMED = 40
	)

	skill_damage = list(
		SKILL_UNARMED = list(BLUNT,PIERCE)
	)

	allow_friendly_fire = FALSE