/damagetype/unarmed/
	draw_blood = TRUE

	hit_effect = /obj/effect/temp/impact/combat/punch

	impact_sounds = list(
		'sound/weapons/unarmed/light_punch_01.ogg',
		'sound/weapons/unarmed/light_punch_02.ogg',
		'sound/weapons/unarmed/light_punch_03.ogg',
		'sound/weapons/unarmed/light_punch_04.ogg',
		'sound/weapons/unarmed/light_punch_05.ogg',
		'sound/weapons/unarmed/light_punch_06.ogg',
		'sound/weapons/unarmed/light_punch_07.ogg'
	)

	damage_type_to_fatigue = list( //What percentage of damage blocked is converted into fatigue.
		BLADE = 0.75,
		BLUNT = 0.75,
		PIERCE = 0.75
	)

	experience_mod = 2

	savage_hit_threshold = 0.2

	sneak_attack_multiplier = 4

	allow_power_attacks = FALSE

	animate = TRUE

	can_be_parried = TRUE

/damagetype/unarmed/get_attack_type()
	return ATTACK_TYPE_UNARMED

/*
/damagetype/unarmed/do_wound(atom/attacker,atom/victim,atom/weapon,atom/hit_object,damage_dealt)

	if(is_organ(hit_object))
		new/wound/bruise/(victim,hit_object,attacker,weapon,damage_dealt/20)
		if(damage_dealt > 30)
			new/wound/abration(victim,hit_object,attacker,weapon,damage_dealt/40)

		return TRUE

	return FALSE
*/