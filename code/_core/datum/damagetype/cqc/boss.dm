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
		ATTRIBUTE_STRENGTH = DAMAGE_DAGGER*0.25,
		ATTRIBUTE_DEXTERITY = DAMAGE_DAGGER*0.25
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = FATIGUE,
		ATTRIBUTE_DEXTERITY = FATIGUE
	)

	skill_stats = list(
		SKILL_UNARMED = DAMAGE_DAGGER*0.25
	)

	skill_damage = list(
		SKILL_UNARMED = FATIGUE
	)

	attack_delay = 1
	attack_delay_max = 1

	cqc_tag = "3"

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
		ATTRIBUTE_STRENGTH = DAMAGE_DAGGER*0.25,
		ATTRIBUTE_DEXTERITY = DAMAGE_DAGGER*0.25
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = FATIGUE,
		ATTRIBUTE_DEXTERITY = FATIGUE
	)

	skill_stats = list(
		SKILL_UNARMED = DAMAGE_DAGGER*0.25
	)

	skill_damage = list(
		SKILL_UNARMED = FATIGUE
	)

	attack_delay = 1
	attack_delay_max = 1

	cqc_tag = "3"

/damagetype/cqc/boss/grab_slam/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)

	if(is_living(victim) && is_living(attacker))
		var/mob/living/L = victim
		var/mob/living/A = attacker
		if(L.grabbing_hand && L.grabbing_hand.owner && L.grabbing_hand.owner == attacker)
			L.add_status_effect(STUN,40,40,source=A)
			A.add_status_effect(STUN,20,20,stealthy=TRUE)
		else
			L.add_status_effect(STAGGER,10,10,source=A)

	return ..()