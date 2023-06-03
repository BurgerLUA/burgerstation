/damagetype/unarmed/cqc/boss/fast_grab
	attack_verbs = list("fast grab")

	hit_effect = /obj/effect/temp/impact/combat/disarm

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		FATIGUE = 25
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(

	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 25,
		ATTRIBUTE_DEXTERITY = 25
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = FATIGUE,
		ATTRIBUTE_DEXTERITY = FATIGUE
	)

	skill_stats = list(
		SKILL_UNARMED = 25
	)

	skill_damage = list(
		SKILL_UNARMED = FATIGUE
	)

	attack_delay = 7.5
	attack_delay_max = 15

/damagetype/unarmed/cqc/boss/fast_grab/post_on_hit(var/atom/attacker,var/turf/attacker_turf,var/atom/victim,var/turf/victim_turf,var/atom/weapon,var/atom/hit_object,var/total_damage_dealt=0)

	if(is_advanced(attacker) && ismovable(victim) && is_turf(victim.loc))
		var/mob/living/advanced/A = attacker
		if(is_living(victim))
			var/mob/living/L = victim
			if(!L.add_status_effect(GRAB,200,20,source = A))
				return ..()
		if(istype(weapon,/obj/item/organ/hand))
			var/obj/item/organ/hand/H = weapon
			if(H.id == BODY_HAND_RIGHT)
				A.inventories_by_id[BODY_HAND_RIGHT_HELD].grab_object(attacker,victim)
			else if(H.id == BODY_HAND_LEFT)
				A.inventories_by_id[BODY_HAND_LEFT_HELD].grab_object(attacker,victim)

	return ..()


/damagetype/unarmed/cqc/boss/grab_slam
	attack_verbs = list("grab slam")

	hit_effect = /obj/effect/temp/impact/combat/disarm

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		FATIGUE = 50
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(

	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 50,
		ATTRIBUTE_DEXTERITY = 25
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

	attack_delay = 40
	attack_delay_max = 60

/damagetype/unarmed/cqc/boss/grab_slam/post_on_hit(var/atom/attacker,var/turf/attacker_turf,var/atom/victim,var/turf/victim_turf,var/atom/weapon,var/atom/hit_object,var/total_damage_dealt=0)

	if(is_living(victim) && is_living(attacker))
		var/mob/living/L = victim
		var/mob/living/A = attacker
		if(L.grabbing_hand && L.grabbing_hand.owner && L.grabbing_hand.owner == attacker)
			L.add_status_effect(STUN,40,40,source=A)
			A.add_status_effect(PARALYZE,20,20,stealthy=TRUE)
		else
			L.add_status_effect(STAGGER,10,10,source=A)

	return ..()


/damagetype/unarmed/cqc/boss/staggering_punch
	attack_verbs = list("staggering punch")

	impact_sounds = list(
		'sound/weapons/unarmed/medium_punch_01.ogg',
		'sound/weapons/unarmed/medium_punch_02.ogg',
		'sound/weapons/unarmed/medium_punch_03.ogg',
		'sound/weapons/unarmed/medium_punch_04.ogg',
		'sound/weapons/unarmed/medium_punch_05.ogg',
		'sound/weapons/unarmed/medium_punch_06.ogg'
	)

	hit_effect = /obj/effect/temp/impact/combat/punch

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		FATIGUE = 20,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		FATIGUE = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 50,
		ATTRIBUTE_DEXTERITY = 20
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(FATIGUE),
		ATTRIBUTE_DEXTERITY = list(FATIGUE)
	)

	skill_stats = list(
		SKILL_UNARMED = 30
	)

	skill_damage = list(
		SKILL_UNARMED = list(FATIGUE)
	)

	attack_delay = 10
	attack_delay_max = 15

/damagetype/unarmed/cqc/boss/staggering_punch/post_on_hit(var/atom/attacker,var/turf/attacker_turf,var/atom/victim,var/turf/victim_turf,var/atom/weapon,var/atom/hit_object,var/total_damage_dealt=0)

	if(is_living(victim))
		var/mob/living/L = victim
		if(!L.horizontal)
			L.add_status_effect(STAGGER,10,10,source=attacker)

	return ..()

/damagetype/unarmed/cqc/boss/stunning_punch
	attack_verbs = list("stunning punch")

	impact_sounds = list(
		'sound/weapons/unarmed/heavy_punch_01.ogg',
		'sound/weapons/unarmed/heavy_punch_02.ogg',
		'sound/weapons/unarmed/heavy_punch_03.ogg',
		'sound/weapons/unarmed/heavy_punch_06.ogg',
		'sound/weapons/unarmed/heavy_punch_07.ogg'
	)

	hit_effect = /obj/effect/temp/impact/combat/punch

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		FATIGUE = 40,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		FATIGUE = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 100,
		ATTRIBUTE_DEXTERITY = 40
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(FATIGUE),
		ATTRIBUTE_DEXTERITY = list(FATIGUE)
	)

	skill_stats = list(
		SKILL_UNARMED = 60
	)

	skill_damage = list(
		SKILL_UNARMED = list(FATIGUE)
	)


	attack_delay = 30
	attack_delay_max = 45

/damagetype/unarmed/cqc/boss/stunning_punch/post_on_hit(var/atom/attacker,var/turf/attacker_turf,var/atom/victim,var/turf/victim_turf,var/atom/weapon,var/atom/hit_object,var/total_damage_dealt=0)

	if(is_living(victim) && is_living(attacker))
		var/mob/living/L = victim
		if(!L.horizontal)
			L.add_status_effect(STUN,30,30,source=attacker)

	return ..()


/damagetype/unarmed/cqc/boss/disarm_theft
	attack_verbs = list("tactical disarm")

	hit_effect = /obj/effect/temp/impact/combat/punch

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		FATIGUE = 30,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		FATIGUE = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 10,
		ATTRIBUTE_DEXTERITY = 40
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(FATIGUE),
		ATTRIBUTE_DEXTERITY = list(FATIGUE)
	)

	skill_stats = list(
		SKILL_UNARMED = 50
	)

	skill_damage = list(
		SKILL_UNARMED = list(FATIGUE)
	)


	attack_delay = 8
	attack_delay_max = 16

/damagetype/unarmed/cqc/boss/disarm_theft/post_on_hit(var/atom/attacker,var/turf/attacker_turf,var/atom/victim,var/turf/victim_turf,var/atom/weapon,var/atom/hit_object,var/total_damage_dealt=0)

	if(is_advanced(attacker) && is_advanced(victim))
		var/mob/living/advanced/A = attacker
		var/mob/living/advanced/V = victim

		var/list/possible_thefts = list()

		var/obj/item/left_item = V.inventories_by_id[BODY_HAND_LEFT_HELD]?.get_top_object()
		var/obj/item/right_item = V.inventories_by_id[BODY_HAND_RIGHT_HELD]?.get_top_object()

		if(left_item)
			possible_thefts += left_item
		if(right_item)
			possible_thefts += right_item

		if(length(possible_thefts))
			var/obj/item/I = pick(possible_thefts)
			I.drop_item(get_turf(A))
			A.put_in_hands(I)
			V.visible_message(span("warning","\The [A.name] tactically steals \the [I.name] from \the [V.name]!"),span("danger","\The [A.name] steals your [I.name]!"))


	return ..()


/damagetype/unarmed/cqc/boss/tactical_hug
	attack_verbs = list("tactical hug")

	hit_effect = /obj/effect/temp/impact/combat/punch

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		FATIGUE = 50,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		FATIGUE = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 150,
		ATTRIBUTE_DEXTERITY = 25
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(FATIGUE),
		ATTRIBUTE_DEXTERITY = list(FATIGUE)
	)

	skill_stats = list(
		SKILL_UNARMED = 20
	)

	skill_damage = list(
		SKILL_UNARMED = list(FATIGUE)
	)


	attack_delay = 40
	attack_delay_max = 60

/damagetype/unarmed/cqc/boss/tactical_hug/post_on_hit(var/atom/attacker,var/turf/attacker_turf,var/atom/victim,var/turf/victim_turf,var/atom/weapon,var/atom/hit_object,var/total_damage_dealt=0)

	if(is_advanced(attacker) && is_advanced(victim))
		var/mob/living/advanced/V = victim
		var/mob/living/advanced/A = attacker
		if(!A.horizontal && !V.horizontal)
			V.add_status_effect(DISARM,10,10)
			V.add_status_effect(PARALYZE,40,40,stealthy=TRUE)

	return ..()
