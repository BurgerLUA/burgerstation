/damagetype/unarmed/slaughter //i sure hope nothing goes wrong
	name = "demon claw"
	attack_verbs = list("claw")

	hit_effect = /obj/effect/temp/impact/combat/claw

	impact_sounds = list(
		'sound/weapons/fists/claw_flesh_01.ogg',
		'sound/weapons/fists/claw_flesh_02.ogg',
		'sound/weapons/fists/claw_flesh_03.ogg'
	)

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 45*0.3,
		PIERCE = 45*0.1
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 20*0.5,
		PIERCE = 20*0.5
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 30*0.3,
		ATTRIBUTE_DEXTERITY = 30*0.3
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLADE,PIERCE),
		ATTRIBUTE_DEXTERITY = list(BLADE,PIERCE)
	)

	skill_stats = list(
		SKILL_UNARMED = 30*0.1
	)

	skill_damage = list(
		SKILL_UNARMED = list(BLADE,PIERCE),
	)

	throw_mul = 1

	attack_delay = 10*0.5
	attack_delay_max = 10

/damagetype/unarmed/slaughter/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)
	if(is_living(attacker) && is_living(victim))
		var/mob/living/V = victim
		var/mob/living/A = attacker
		if(!A.dead && V.dead)
			var/blood_to_steal = min(V.blood_volume,(A.blood_volume_max - A.blood_volume)) //it took blood, sweat and tears, but...
			if(blood_to_steal > 0)
				V.blood_volume -= blood_to_steal
				A.blood_volume = clamp(A.blood_volume+blood_to_steal,0,A.blood_volume_max) //I successfully stole bloodsteal code.
				A.health.adjust_loss_smart(oxy = -blood_to_steal)
				play_sound(pick('sound/effects/demon_consume.ogg'),get_turf(V),range_max=VIEW_RANGE*0.5)
			else if (V.blood_volume <= 0)
				A.to_chat(span("danger","That enemy has no blood!"))

		return ..()

/damagetype/unarmed/slaughter_heavy
	name = "demon rip"
	attack_verbs = list("rips and tears")

	hit_effect = /obj/effect/temp/impact/combat/claw

	impact_sounds = list(
		'sound/effects/demon_attack1.ogg',
	)

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 45,
		PIERCE = 45
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 20,
		PIERCE = 20
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 30,
		ATTRIBUTE_DEXTERITY = 30
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLADE,PIERCE),
		ATTRIBUTE_DEXTERITY = list(BLADE,PIERCE)
	)

	skill_stats = list(
		SKILL_UNARMED = 30
	)

	skill_damage = list(
		SKILL_UNARMED = list(BLADE,PIERCE),
	)

	throw_mul = 1

	attack_delay = 10*0.5
	attack_delay_max = 10

/damagetype/unarmed/slaughter_heavy/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)

	if(is_living(attacker) && is_living(victim))
		var/mob/living/V = victim
		var/mob/living/A = attacker
		if(!A.dead && !V.dead) //basically, if the attack lands on a living person
			A.blood_volume -= (25)
			A.health.adjust_loss_smart(oxy = 25)

	return ..()
