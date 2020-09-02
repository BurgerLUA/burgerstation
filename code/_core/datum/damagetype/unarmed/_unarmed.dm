/damagetype/unarmed/
	name = "Body"
	draw_blood = TRUE

	hit_effect = /obj/effect/temp/impact/combat/punch

	impact_sounds = list(
		'sound/weapons/fists/light_punch_01.ogg',
		'sound/weapons/fists/light_punch_02.ogg',
		'sound/weapons/fists/light_punch_03.ogg',
		'sound/weapons/fists/light_punch_04.ogg',
		'sound/weapons/fists/light_punch_05.ogg',
		'sound/weapons/fists/light_punch_06.ogg',
		'sound/weapons/fists/light_punch_07.ogg'
	)

	skill_stats = list(
		SKILL_UNARMED = 100 //100%
	)

	damage_type_to_fatigue = list( //What percentage of damage blocked is converted into fatigue.
		BLADE = 1,
		BLUNT = 1,
		PIERCE = 1
	)

/damagetype/unarmed/get_attack_type()
	return ATTACK_TYPE_UNARMED

/*
/damagetype/unarmed/do_wound(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/damage_dealt)

	if(is_organ(hit_object))
		new/wound/bruise/(victim,hit_object,attacker,weapon,damage_dealt/20)
		if(damage_dealt > 30)
			new/wound/abration(victim,hit_object,attacker,weapon,damage_dealt/40)

		return TRUE

	return FALSE
*/