//Fists
/damagetype/unarmed/fists/
	name = "fist"
	attack_verbs = list("punch","hit","slap","strike","pummel","pound")

	hit_effect = /obj/effect/temp/impact/combat/punch

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 45*0.2
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 45*0.3,
		ATTRIBUTE_DEXTERITY = 45*0.1
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLUNT),
		ATTRIBUTE_DEXTERITY = list(BLUNT)
	)

	skill_stats = list(
		SKILL_UNARMED = 45*0.4
	)

	skill_damage = list(
		SKILL_UNARMED = list(BLUNT)
	)

	cqc_tag = "4"

	attack_delay = 10*0.5
	attack_delay_max = 10

/damagetype/unarmed/fists/help
	name = "help fists"
	attack_verbs = list("tap")

	hit_effect = null

	hit_effect = null

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		FATIGUE = 30*0.2
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		FATIGUE = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 30*0.3,
		ATTRIBUTE_DEXTERITY = 30*0.2
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = FATIGUE,
		ATTRIBUTE_DEXTERITY = FATIGUE
	)

	skill_stats = list(
		SKILL_UNARMED = 30*0.3
	)

	skill_damage = list(
		SKILL_UNARMED = FATIGUE
	)

	cqc_tag = "1"

	attack_delay = 8*0.5
	attack_delay_max = 8

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
		FATIGUE = 15*0.5
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		FATIGUE = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 15*0.1,
		ATTRIBUTE_DEXTERITY = 15*0.1
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = FATIGUE,
		ATTRIBUTE_DEXTERITY = FATIGUE
	)

	skill_stats = list(
		SKILL_UNARMED = 15*0.2
	)

	skill_damage = list(
		SKILL_UNARMED = FATIGUE
	)

	attack_delay = 12
	attack_delay_max = 15

	cqc_tag = "2"

	draw_blood = FALSE

	allow_friendly_fire = TRUE

/damagetype/unarmed/fists/disarm/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)

	if(is_living(victim))
		var/mob/living/L = victim

		var/luck_value = (total_damage_dealt/15)*100

		if(is_living(attacker))
			var/mob/living/A = attacker
			if(L.loyalty_tag != A.loyalty_tag)
				if(A.ai && luck(list(attacker,weapon),luck_value) && luck(list(victim,hit_object),100,FALSE))
					L.add_status_effect(DISARM,5,5, source = attacker)
				else
					luck_value *= 4
					if(luck(list(attacker,weapon),luck_value*0.5) && luck(list(victim,hit_object),100,FALSE))
						L.add_status_effect(SHOVED,attack_delay*0.5,attack_delay*0.5, source = attacker)

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

	cqc_tag = "3"

	attack_delay = 10
	attack_delay_max = 10

	draw_blood = FALSE

	allow_friendly_fire = TRUE

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


/damagetype/unarmed/powerfist/
	name = "powerfist"
	attack_verbs = list("pummel","pound")

	hit_effect = /obj/effect/temp/impact/combat/punch

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 90*0.5
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 0
	)

	attribute_stats = list(

	)

	attribute_damage = list(

	)


	skill_stats = list(
		SKILL_UNARMED = 50*0.5
	)

	skill_damage = list(
		SKILL_UNARMED = list(BLUNT)
	)

	cqc_tag = "p"

	attack_delay = 10
	attack_delay_max = 10


/damagetype/unarmed/brass/
	name = "brass knuckle"
	attack_verbs = list("punch","hit","strike","pummel","pound")

	hit_effect = /obj/effect/temp/impact/combat/punch

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 55*0.4
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 55*0.2,
		ATTRIBUTE_DEXTERITY = 55*0.1
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLUNT),
		ATTRIBUTE_DEXTERITY = list(BLUNT)
	)

	skill_stats = list(
		SKILL_UNARMED = 55*0.3
	)

	skill_damage = list(
		SKILL_UNARMED = list(BLUNT)
	)

	cqc_tag = "p"

	attack_delay = 12*0.5
	attack_delay_max = 12


/damagetype/unarmed/brass/spiked
	name = "spiked brass knuckle"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 55*0.4,
		PIERCE = 55*0.1
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 0,
		PIERCE = 50
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLUNT,PIERCE),
		ATTRIBUTE_DEXTERITY = list(BLUNT,PIERCE)
	)

	skill_damage = list(
		SKILL_UNARMED = list(BLUNT,PIERCE)
	)

	attack_delay = 11*0.5
	attack_delay_max = 11