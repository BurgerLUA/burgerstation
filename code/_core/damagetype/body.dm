/datum/damagetype/body/
	name = "MY BODY IS A WEAPON"
	desc = "Your body deals damage."

/datum/damagetype/body/fists/
	name = "Fist"
	desc = "Your fist."
	verbs = list("punch","hit","slap","strike","pummel","pound")
	weapon_name = "right fist"
	impact_sounds = list(
		'sounds/effects/impacts/punch1.ogg',
		'sounds/effects/impacts/punch2.ogg',
		'sounds/effects/impacts/punch3.ogg',
		'sounds/effects/impacts/punch4.ogg'
	)

	attack_damage = list(BRUTE = 5, BURN = 0, TOX = 0, OXY = 0)

/datum/damagetype/body/fists/get_attack_message_sound(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	return span("danger","You hear bone hitting flesh.")

/datum/damagetype/body/fists/left
	weapon_name = "left fist"
