/damagetype/cqc/boss/fast_grab
	name = "fast grab"
	attack_verbs = list("fast grab")

	hit_effect = /obj/effect/temp/impact/combat/disarm

	impact_sounds = list(
		'sound/weapons/fists/grab.ogg'
	)

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		FATIGUE = 0
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(

	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 15*0.25,
		ATTRIBUTE_DEXTERITY = 15*0.25
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = FATIGUE,
		ATTRIBUTE_DEXTERITY = FATIGUE
	)

	skill_stats = list(
		SKILL_UNARMED = 15*0.25
	)

	skill_damage = list(
		SKILL_UNARMED = FATIGUE
	)

	attack_delay = 8*0.5
	attack_delay_max = 8*0.5

/damagetype/cqc/boss/fast_grab/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)

	if(is_advanced(attacker) && ismovable(victim) && isturf(victim.loc))
		var/mob/living/advanced/A = attacker
		if(is_living(victim))
			var/mob/living/L = victim
			if(!L.add_status_effect(GRAB, source = A))
				A.to_chat(span("warning","\The [L.name] is too strong to be grabbed!"))
				return ..()
		if(istype(weapon,/obj/item/organ/hand))
			var/obj/item/organ/hand/H = weapon
			if(H.id == BODY_HAND_RIGHT)
				A.right_hand.grab_object(attacker,victim)
			else if(H.id == BODY_HAND_LEFT)
				A.left_hand.grab_object(attacker,victim)

	return ..()


/damagetype/cqc/boss/grab_slam
	name = "grab slam"
	attack_verbs = list("grab slam")

	hit_effect = /obj/effect/temp/impact/combat/disarm

	impact_sounds = list(
		'sound/weapons/fists/grab.ogg'
	)

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		FATIGUE = 0
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(

	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 15*0.25,
		ATTRIBUTE_DEXTERITY = 15*0.25
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = FATIGUE,
		ATTRIBUTE_DEXTERITY = FATIGUE
	)

	skill_stats = list(
		SKILL_UNARMED = 15*0.25
	)

	skill_damage = list(
		SKILL_UNARMED = FATIGUE
	)

	attack_delay = 14
	attack_delay_max = 14

/damagetype/cqc/boss/grab_slam/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)

	if(is_living(victim) && is_living(attacker))
		var/mob/living/L = victim
		var/mob/living/A = attacker
		if(L.grabbing_hand && L.grabbing_hand.owner && L.grabbing_hand.owner == attacker)
			L.add_status_effect(STUN,40,40,source=A)
			A.add_status_effect(PARALYZE,20,20,stealthy=TRUE)
		else
			L.add_status_effect(STAGGER,10,10,source=A)

	return ..()


/damagetype/cqc/boss/staggering_punch
	name = "staggering punch"
	attack_verbs = list("staggering punch")

	impact_sounds = list(
		'sound/weapons/fists/medium_punch_01.ogg',
		'sound/weapons/fists/medium_punch_02.ogg',
		'sound/weapons/fists/medium_punch_03.ogg',
		'sound/weapons/fists/medium_punch_04.ogg',
		'sound/weapons/fists/medium_punch_05.ogg',
		'sound/weapons/fists/medium_punch_06.ogg'
	)

	hit_effect = /obj/effect/temp/impact/combat/punch

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		FATIGUE = 45*0.1,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		FATIGUE = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 45*0.3,
		ATTRIBUTE_DEXTERITY = 45*0.2
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(FATIGUE),
		ATTRIBUTE_DEXTERITY = list(FATIGUE)
	)

	skill_stats = list(
		SKILL_UNARMED = 45*0.4
	)

	skill_damage = list(
		SKILL_UNARMED = list(FATIGUE)
	)

	//BALANCE CHANGE. FASTER SPEED.
	attack_delay = 8*0.5
	attack_delay_max = 8

/damagetype/cqc/boss/staggering_punch/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)

	if(is_living(victim))
		var/mob/living/L = victim
		if(!L.horizontal)
			L.add_status_effect(STAGGER,10,10,source=attacker)

	return ..()

/damagetype/cqc/boss/stunning_punch
	name = "stunning punch"
	attack_verbs = list("stunning punch")

	impact_sounds = list(
		'sound/weapons/fists/heavy_punch_01.ogg',
		'sound/weapons/fists/heavy_punch_02.ogg',
		'sound/weapons/fists/heavy_punch_03.ogg',
		'sound/weapons/fists/heavy_punch_06.ogg',
		'sound/weapons/fists/heavy_punch_07.ogg'
	)

	hit_effect = /obj/effect/temp/impact/combat/punch

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		FATIGUE = 60*0.1,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		FATIGUE = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 60*0.3,
		ATTRIBUTE_DEXTERITY = 60*0.2
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(FATIGUE),
		ATTRIBUTE_DEXTERITY = list(FATIGUE)
	)

	skill_stats = list(
		SKILL_UNARMED = 60*0.4
	)

	skill_damage = list(
		SKILL_UNARMED = list(FATIGUE)
	)

	//BALANCE CHANGE. FASTER SPEED.
	attack_delay = 8*0.5
	attack_delay_max = 8

/damagetype/cqc/boss/stunning_punch/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)

	if(is_living(victim) && is_living(attacker))
		var/mob/living/L = victim
		var/mob/living/A = attacker
		if(!L.horizontal)
			L.add_status_effect(STUN,30,30,source=A)
			A.add_status_effect(STUN,20,20,stealthy=TRUE)

	return ..()


/damagetype/cqc/boss/disarm_theft
	name = "stunning punch"
	attack_verbs = list("stunning punch")

	impact_sounds = list(
		'sound/weapons/fists/grab.ogg'
	)

	hit_effect = /obj/effect/temp/impact/combat/punch

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		FATIGUE = 60*0.1,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		FATIGUE = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 60*0.3,
		ATTRIBUTE_DEXTERITY = 60*0.2
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(FATIGUE),
		ATTRIBUTE_DEXTERITY = list(FATIGUE)
	)

	skill_stats = list(
		SKILL_UNARMED = 60*0.4
	)

	skill_damage = list(
		SKILL_UNARMED = list(FATIGUE)
	)

	//BALANCE CHANGE. FASTER SPEED.
	attack_delay = 8
	attack_delay_max = 8

/damagetype/cqc/boss/disarm_theft/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)

	if(is_advanced(attacker) && is_advanced(victim))
		var/mob/living/advanced/A = attacker
		var/mob/living/advanced/V = victim

		var/list/possible_thefts = list()
		if(V.right_item)
			possible_thefts += V.right_item
		if(V.left_item)
			possible_thefts += V.left_item

		if(length(possible_thefts))
			var/obj/item/I = pick(possible_thefts)
			I.drop_item(get_turf(A))
			A.put_in_hands(I)
			V.visible_message(span("warning","\The [A.name] tactically steals \the [I.name] from \the [V.name]!"),span("danger","\The [A.name] steals your [I.name]!"))


	return ..()


/damagetype/cqc/boss/tactical_hug
	name = "tactical hug"
	attack_verbs = list("tactical hug")

	impact_sounds = list(
		'sound/weapons/fists/grab.ogg'
	)

	hit_effect = /obj/effect/temp/impact/combat/punch

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		FATIGUE = 60*0.1,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		FATIGUE = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 60*0.3,
		ATTRIBUTE_DEXTERITY = 60*0.2
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(FATIGUE),
		ATTRIBUTE_DEXTERITY = list(FATIGUE)
	)

	skill_stats = list(
		SKILL_UNARMED = 60*0.4
	)

	skill_damage = list(
		SKILL_UNARMED = list(FATIGUE)
	)

	//BALANCE CHANGE. FASTER SPEED.
	attack_delay = 8
	attack_delay_max = 8

/damagetype/cqc/boss/tactical_hug/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)

	if(is_advanced(attacker) && is_advanced(victim))
		var/mob/living/advanced/A = attacker
		var/mob/living/advanced/V = victim
		if(!A.horizontal && !V.horizontal)
			V.add_status_effect(DISARM,10,10)
			V.add_status_effect(PARALYZE,40,40,stealthy=TRUE)
			A.add_status_effect(PARALYZE,40,40,stealthy=TRUE)


	return ..()
