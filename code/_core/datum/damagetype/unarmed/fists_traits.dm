/damagetype/unarmed/fists/shock_touch
	name = "shocking fists"
	attack_verbs = list("punch","hit","slap","strike","pummel","pound")

	hit_effect = /obj/effect/temp/impact/combat/punch

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		SHOCK = 45*0.2
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		SHOCK = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 45*0.3,
		ATTRIBUTE_DEXTERITY = 45*0.1
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(SHOCK),
		ATTRIBUTE_DEXTERITY = list(SHOCK)
	)

	skill_stats = list(
		SKILL_UNARMED = 45*0.4
	)

	skill_damage = list(
		SKILL_UNARMED = list(SHOCK)
	)

	cqc_tag = "4"

	attack_delay = 12*0.5
	attack_delay_max = 12

/damagetype/unarmed/fists/shock_touch/do_attack_sound(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)

	. = ..()

	play_sound(pick('sound/effects/sparks1.ogg','sound/effects/sparks2.ogg','sound/effects/sparks3.ogg','sound/effects/sparks4.ogg'),get_turf(attacker))