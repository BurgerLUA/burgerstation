//Fists
/damagetype/unarmed/fists/
	name = "fist"
	attack_verbs = list("punch","hit","slap","strike","pummel","pound")

	hit_effect = /obj/effect/temp/impact/combat/punch

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_CLUB*0.1,
		FATIGUE = 0
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = AP_CLUB*0.5,
		FATIGUE = AP_CLUB*0.5,
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = DAMAGE_CLUB*0.3,
		ATTRIBUTE_DEXTERITY = DAMAGE_CLUB*0.2
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLUNT,FATIGUE),
		ATTRIBUTE_DEXTERITY = list(BLUNT,FATIGUE)
	)

	skill_stats = list(
		SKILL_UNARMED = DAMAGE_CLUB*0.4
	)

	skill_damage = list(
		SKILL_UNARMED = list(BLUNT,FATIGUE)
	)

	allow_friendly_fire = FALSE

	cqc_tag = "4"

	//BALANCE SPECIAL CASE: SPEED IS DAGGER.
	attack_delay = SPEED_SWORD*0.5
	attack_delay_max = SPEED_SWORD

/damagetype/unarmed/fists/help
	name = "help fists"
	attack_verbs = list("tap")

	hit_effect = null

	hit_effect = null

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		FATIGUE = DAMAGE_AXE*0.2
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		FATIGUE = AP_CLUB*1,
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = DAMAGE_CLUB*0.3,
		ATTRIBUTE_DEXTERITY = DAMAGE_CLUB*0.2
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = FATIGUE,
		ATTRIBUTE_DEXTERITY = FATIGUE
	)

	skill_stats = list(
		SKILL_UNARMED = DAMAGE_CLUB*0.3
	)

	skill_damage = list(
		SKILL_UNARMED = FATIGUE
	)

	cqc_tag = "1"

	allow_friendly_fire = FALSE

	attack_delay = SPEED_CLUB*0.5
	attack_delay_max = SPEED_CLUB

	draw_blood = FALSE

/damagetype/unarmed/fists/disarm
	name = "disarm fists"
	attack_verbs = list("shove")

	impact_sounds = list(
		'sound/weapons/fists/grab.ogg'
	)

	hit_effect = /obj/effect/temp/impact/combat/disarm

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		FATIGUE = DAMAGE_DAGGER*0.5
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		FATIGUE = AP_DAGGER
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = DAMAGE_DAGGER*0.1,
		ATTRIBUTE_DEXTERITY = DAMAGE_DAGGER*0.1
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = FATIGUE,
		ATTRIBUTE_DEXTERITY = FATIGUE
	)

	skill_stats = list(
		SKILL_UNARMED = DAMAGE_DAGGER*0.2
	)

	skill_damage = list(
		SKILL_UNARMED = FATIGUE
	)

	attack_delay = SPEED_DAGGER*0.5
	attack_delay_max = SPEED_DAGGER

	cqc_tag = "2"

/damagetype/unarmed/fists/disarm/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)

	if(is_living(victim))
		var/mob/living/L = victim

		var/luck_value = (total_damage_dealt/DAMAGE_DAGGER)*100

		if(is_living(attacker))
			var/mob/living/A = attacker
			if(A.loyalty_tag != L.loyalty_tag && luck(list(attacker,weapon),luck_value) && luck(list(victim,hit_object),100,FALSE))
				L.add_status_effect(DISARM,5,5, source = attacker)
				return ..()

		if(luck(list(attacker,weapon),luck_value*0.5) && luck(list(victim,hit_object),100,FALSE))
			L.add_status_effect(STAGGER,1,1, source = attacker)

	return ..()

/damagetype/unarmed/fists/grab
	name = "grab fists"
	attack_verbs = list("grab")

	hit_effect = /obj/effect/temp/impact/combat/disarm

	impact_sounds = list(
		'sound/weapons/fists/grab.ogg'
	)

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		FATIGUE = DAMAGE_DAGGER*0.25
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

	cqc_tag = "3"

	attack_delay = SPEED_DAGGER*0.5
	attack_delay_max = SPEED_DAGGER

/damagetype/unarmed/fists/grab/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)

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