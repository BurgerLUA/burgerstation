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

/damagetype/unarmed/get_attack_delay(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	if(!ismob(attacker))
		return attack_delay

	var/mob/M = attacker
	return max(1,attack_delay - (attack_delay * M.get_attribute_power(ATTRIBUTE_AGILITY,0,100) * 0.5) - (attack_delay * M.get_skill_power(SKILL_UNARMED,0,100) * 0.5))

/damagetype/unarmed/get_attack_message_sound(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	return span("warning","You hear bone hitting flesh.")

//Fists
/damagetype/unarmed/fists/
	name = "Fist"
	desc = "Your fist."
	attack_verbs = list("punch","hit","slap","strike","pummel","pound")
	weapon_name = "right fist"

	base_attack_damage = list(BRUTE = 1, BURN = 0, TOX = 0, OXY = 0)

/damagetype/unarmed/fists/left
	weapon_name = "left fist"

//Feet
/damagetype/unarmed/feet/
	name = "Foot"
	desc = "Your foot"
	attack_verbs = list("kick")
	weapon_name = "right foot"

	base_attack_damage = list(BRUTE = 1, BURN = 0, TOX = 0, OXY = 0)

	attack_delay = 20

/damagetype/unarmed/feet/left
	weapon_name = "left foot"

