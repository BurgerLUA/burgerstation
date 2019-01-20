/damagetype/unarmed/
	name = "Body"
	desc = "Your body deals damage."
	impact_sounds = list(
		'sounds/effects/impacts/punch1.ogg',
		'sounds/effects/impacts/punch2.ogg',
		'sounds/effects/impacts/punch3.ogg',
		'sounds/effects/impacts/punch4.ogg'
	)
	miss_sounds = list(
		'sounds/effects/impacts/punchmiss.ogg'
	)

	skill_xp_per_damage = list(
		SKILL_UNARMED = 1,
		SKILL_MELEE = 0,
		SKILL_RANGED = 0
	)

/damagetype/unarmed/get_attack_delay(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	if(!is_living(attacker))
		return attack_delay

	var/mob/living/L = attacker
	return max(1,attack_delay - (attack_delay * L.get_attribute_power(ATTRIBUTE_DEXTERITY,0,100) * 0.5) - (attack_delay * L.get_skill_power(SKILL_UNARMED,0,100) * 0.5))

/damagetype/unarmed/get_attack_message_sound(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	return span("warning","You hear bone hitting flesh.")

//Fists
/damagetype/unarmed/fists/
	name = "Fist"
	desc = "Your fist."
	attack_verbs = list("punch","hit","slap","strike","pummel","pound")
	weapon_name = "right fist"

	attack_delay = 5


	base_attack_damage = list(
		BRUTE = 0,
		BURN = 0,
		TOX = 0,
		OXY = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_D,
		ATTRIBUTE_AGILITY = CLASS_D,
		ATTRIBUTE_INTELLIGENCE = CLASS_F
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BRUTE,
		ATTRIBUTE_AGILITY = BRUTE,
		ATTRIBUTE_INTELLIGENCE = BRUTE
	)

	skill_stats = list(
		SKILL_UNARMED = CLASS_D,
		SKILL_MELEE = CLASS_F,
		SKILL_RANGED = CLASS_F
	)

	skill_damage = list(
		SKILL_UNARMED = BRUTE,
		SKILL_MELEE = BRUTE,
		SKILL_RANGED = BRUTE
	)

/damagetype/unarmed/fists/left
	weapon_name = "left fist"

//Feet
/damagetype/unarmed/feet/
	name = "Foot"
	desc = "Your foot"
	attack_verbs = list("kick")
	weapon_name = "right foot"

	base_attack_damage = list(
		BRUTE = -10,
		BURN = 0,
		TOX = 0,
		OXY = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_C,
		ATTRIBUTE_AGILITY = CLASS_C,
		ATTRIBUTE_INTELLIGENCE = CLASS_F
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BRUTE,
		ATTRIBUTE_AGILITY = BRUTE,
		ATTRIBUTE_INTELLIGENCE = BRUTE
	)

	skill_stats = list(
		SKILL_UNARMED = CLASS_C,
		SKILL_MELEE = CLASS_F,
		SKILL_RANGED = CLASS_F
	)

	skill_damage = list(
		SKILL_UNARMED = BRUTE,
		SKILL_MELEE = BRUTE,
		SKILL_RANGED = BRUTE
	)

	attack_delay = 20

/damagetype/unarmed/feet/get_attack_delay(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	if(!is_living(attacker))
		return attack_delay

	var/mob/living/L = attacker
	return max(1,attack_delay - (attack_delay * L.get_attribute_power(ATTRIBUTE_AGILITY,0,100) * 0.5) - (attack_delay * L.get_skill_power(SKILL_UNARMED,0,100) * 0.5))

/damagetype/unarmed/feet/left
	weapon_name = "left foot"

