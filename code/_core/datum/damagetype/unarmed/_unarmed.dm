/damagetype/unarmed/
	name = "Body"
	draw_blood = TRUE

	impact_sounds = list(
		'sound/weapons/fists/punch1.ogg',
		'sound/weapons/fists/punch2.ogg',
		'sound/weapons/fists/punch3.ogg',
		'sound/weapons/fists/punch4.ogg'
	)

	skill_stats = list(
		SKILL_UNARMED = 100 //100%
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