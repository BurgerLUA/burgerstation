/damagetype/ranged/
	name = "ranged weapon"

	draw_blood = TRUE

	hit_effect = null //Handled elsewhere.

	miss_sounds = list(
		'sound/weapons/bulletflyby.ogg',
		'sound/weapons/bulletflyby2.ogg',
		'sound/weapons/bulletflyby3.ogg'
	)

	impact_sounds = list(
		'sound/weapons/ric1.ogg',
		'sound/weapons/ric2.ogg',
		'sound/weapons/ric3.ogg',
		'sound/weapons/ric4.ogg',
		'sound/weapons/ric5.ogg'
	)

	impact_sounds_flesh = list(
		'sound/effects/impacts/bullet_meat1.ogg',
		'sound/effects/impacts/bullet_meat2.ogg',
		'sound/effects/impacts/bullet_meat3.ogg',
		'sound/effects/impacts/bullet_meat4.ogg'
	)

	attribute_stats = list()

	attribute_damage = list()

	skill_damage = list()

	throw_mul = 0.25

	can_be_parried = FALSE

/damagetype/ranged/get_block_power_penetration(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	return 0.5

/damagetype/ranged/get_attack_type()
	return ATTACK_TYPE_RANGED

/damagetype/ranged/do_attack_animation(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	return FALSE

/*
/damagetype/ranged/get_attack_message_3rd(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	if(hit_object == victim)
		return span("warning","\The [victim] is hit by \the [src.name]!")
	else
		return span("warning","\The [victim] is hit in \the [hit_object.name] by the [src.name]!")

/damagetype/ranged/get_attack_message_1st(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	if(hit_object == victim)
		return span("danger","You are hit by \the [src.name]!")
	else
		return span("danger","You are hit in \the [hit_object.name] by the [src.name]!")

/damagetype/ranged/get_attack_message_sound(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	return span("danger","You hear an impact.")


/damagetype/ranged/display_hit_message(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)

	if(!ismob(victim))
		return FALSE

	victim.visible_message(\
		get_attack_message_3rd(attacker,victim,weapon,hit_object),\
		get_attack_message_1st(attacker,victim,weapon,hit_object),\
		get_attack_message_sound(attacker,victim,weapon,hit_object)\
	)

/damagetype/ranged/display_miss_message(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/miss_text = "misses!")

	if(!ismob(victim))
		return FALSE

	victim.visible_message(\
		replacetext(get_miss_message_3rd(attacker,victim,weapon,hit_object),"#REASON",miss_text),\
		replacetext(get_miss_message_1st(attacker,victim,weapon,hit_object),"#REASON",miss_text),\
		replacetext(get_miss_message_sound(attacker,victim,weapon,hit_object),"#REASON",miss_text)\
	)

/damagetype/ranged/get_miss_message_3rd(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	return span("warning","\The [victim] #REASON the [src.name]!")

/damagetype/ranged/get_miss_message_1st(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	return span("warning","You #REASON the [src.name]!")

*/






