/damagetype/ranged/
	name = "ranged weapon"
	desc = "Shot with a ranged weapon."
	allow_parry_counter = FALSE

/damagetype/ranged/do_attack_animation(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	return

/damagetype/ranged/perform_miss(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	do_miss_sound(attacker,victim,weapon,hit_object)
	//do_attack_animation(attacker,victim,weapon,hit_object)
	//easy_miss_message(attacker,victim,weapon,hit_object,src,"the attack misses!")
	return TRUE

/damagetype/ranged/get_attack_message_3rd(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	if(hit_object == victim)
		return span("warning","\The [victim] is hit by the [src.name]!")
	else
		return span("warning","\The [victim] is hit by the [src.name] in \the [hit_object]!")

/damagetype/ranged/get_attack_message_1st(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	if(hit_object == victim)
		return span("warning","You are hit by the [src.name]!")
	else
		return span("warning","You are hit by the [src.name] in \the [hit_object]!")

/damagetype/ranged/get_attack_message_sound(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	return span("danger","You hear an impact.")

/damagetype/ranged/display_hit_message(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	victim.visible_message(\
		get_attack_message_3rd(attacker,victim,weapon,hit_object),\
		get_attack_message_1st(attacker,victim,weapon,hit_object),\
		get_attack_message_sound(attacker,victim,weapon,hit_object)\
	)

/damagetype/ranged/display_miss_message(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/miss_text = "misses!")
	victim.visible_message(\
		replacetext(get_miss_message_3rd(attacker,victim,weapon,hit_object),"#REASON",miss_text),\
		replacetext(get_miss_message_1st(attacker,victim,weapon,hit_object),"#REASON",miss_text),\
		replacetext(get_miss_message_sound(attacker,victim,weapon,hit_object),"#REASON",miss_text)\
	)



/damagetype/ranged/get_miss_message_3rd(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	return span("warning","\The [victim] #REASON the [src.name]!")

/damagetype/ranged/get_miss_message_1st(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	return span("warning","You #REASON the [src.name]!")









/damagetype/ranged/revolver_38
	name = "bullet"

	base_attack_damage = list(
		BRUTE = 50,
		BURN = 0,
		TOX = 0,
		OXY = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_F,
		ATTRIBUTE_AGILITY = CLASS_F,
		ATTRIBUTE_INTELLIGENCE = CLASS_F
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BRUTE,
		ATTRIBUTE_AGILITY = BRUTE,
		ATTRIBUTE_INTELLIGENCE = BRUTE
	)

	skill_stats = list(
		SKILL_UNARMED = CLASS_F,
		SKILL_MELEE = CLASS_F,
		SKILL_RANGED = CLASS_F
	)

	skill_damage = list(
		SKILL_UNARMED = BRUTE,
		SKILL_MELEE = BRUTE,
		SKILL_RANGED = BRUTE
	)



