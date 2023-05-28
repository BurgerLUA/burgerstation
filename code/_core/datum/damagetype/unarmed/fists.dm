//Fists
/damagetype/unarmed/fists/
	attack_verbs = list("punch","hit","slap","strike","pummel","pound")

	hit_effect = /obj/effect/temp/impact/combat/punch

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 5
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 25,
		ATTRIBUTE_DEXTERITY = 10
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT,
		ATTRIBUTE_DEXTERITY = BLUNT
	)

	skill_stats = list(
		SKILL_UNARMED = 50
	)

	skill_damage = list(
		SKILL_UNARMED = BLUNT
	)

	cqc_tag = "4"

	attack_delay = 5
	attack_delay_max = 10

/damagetype/unarmed/fists/get_critical_hit_condition(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)

	if(is_living(attacker))
		var/mob/living/L = attacker
		if(L.has_status_effect(BUFF))
			return TRUE

	. = ..()

/damagetype/unarmed/fists/help
	attack_verbs = list("tap")

	hit_effect = null

	hit_effect = null

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		FATIGUE = 10
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		FATIGUE = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 15,
		ATTRIBUTE_DEXTERITY = 20
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = FATIGUE,
		ATTRIBUTE_DEXTERITY = FATIGUE
	)

	skill_stats = list(
		SKILL_UNARMED = 50
	)

	skill_damage = list(
		SKILL_UNARMED = FATIGUE
	)

	cqc_tag = "1"

	attack_delay = 4
	attack_delay_max = 8

	draw_blood = FALSE

/damagetype/unarmed/fists/disarm
	attack_verbs = list("shove")

	hit_effect = /obj/effect/temp/impact/combat/disarm

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		FATIGUE = 20
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		FATIGUE = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 25,
		ATTRIBUTE_DEXTERITY = 10
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = FATIGUE,
		ATTRIBUTE_DEXTERITY = FATIGUE
	)

	skill_stats = list(
		SKILL_UNARMED = 50
	)

	skill_damage = list(
		SKILL_UNARMED = FATIGUE
	)

	attack_delay = 15
	attack_delay_max = 20

	cqc_tag = "2"

	draw_blood = FALSE

	allow_friendly_fire = TRUE

/damagetype/unarmed/fists/disarm/post_on_hit(var/atom/attacker,var/turf/attacker_turf,var/atom/victim,var/turf/victim_turf,var/atom/weapon,var/atom/hit_object,var/total_damage_dealt=0)

	if(is_living(victim) && is_living(attacker))
		var/mob/living/L = victim
		var/mob/living/A = attacker
		if(allow_hostile_action(A.loyalty_tag,L))
			if(L.has_status_effect(SHOVED))
				L.add_status_effect(DISARM,5,5, source = attacker)
			else
				L.add_status_effect(SHOVED,attack_delay,attack_delay, source = attacker)

	return ..()

/damagetype/unarmed/fists/grab
	attack_verbs = list("grab")

	hit_effect = /obj/effect/temp/impact/combat/disarm

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		FATIGUE = 0
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(

	)

	attribute_stats = list(

	)

	attribute_damage = list(

	)

	skill_stats = list(

	)

	skill_damage = list(

	)

	cqc_tag = "3"

	attack_delay = 15
	attack_delay_max = 30

	draw_blood = FALSE

	allow_friendly_fire = TRUE

	inaccuracy_mod = 2

/damagetype/unarmed/fists/grab/post_on_hit(var/atom/attacker,var/turf/attacker_turf,var/atom/victim,var/turf/victim_turf,var/atom/weapon,var/atom/hit_object,var/total_damage_dealt=0)

	if(victim_turf && is_advanced(attacker) && ismovable(victim))
		var/mob/living/advanced/A = attacker
		if(is_living(victim))
			var/mob/living/L = victim
			if(!L.add_status_effect(GRAB,100,20,source = A)) //If we can't grab, return.
				return ..()

		if(is_organ(weapon))
			var/obj/item/organ/H = weapon
			if(H.id == BODY_HAND_RIGHT && A.inventories_by_id[BODY_HAND_RIGHT_HELD])
				A.inventories_by_id[BODY_HAND_RIGHT_HELD].grab_object(attacker,victim)
			else if(H.id == BODY_HAND_LEFT && A.inventories_by_id[BODY_HAND_LEFT_HELD])
				A.inventories_by_id[BODY_HAND_LEFT_HELD].grab_object(attacker,victim)

	return ..()