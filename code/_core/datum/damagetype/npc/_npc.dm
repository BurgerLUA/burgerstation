/damagetype/npc/
	name = "NPC"
	desc = "Damage from NPCs."
	/*
	impact_sounds = list(
		'sounds/effects/impacts/punch1.ogg',
		'sounds/effects/impacts/punch2.ogg',
		'sounds/effects/impacts/punch3.ogg',
		'sounds/effects/impacts/punch4.ogg'
	)
	miss_sounds = list(
		'sounds/effects/impacts/punchmiss.ogg'
	)
	*/

	skill_xp_per_damage = list(
		SKILL_UNARMED = 0,
		SKILL_MELEE = 0,
		SKILL_RANGED = 0
	)

/damagetype/npc/get_attack_delay(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	if(!is_living(attacker))
		return attack_delay

	var/mob/living/L = attacker
	return max(1,attack_delay - (attack_delay * L.get_attribute_power(ATTRIBUTE_DEXTERITY,0,100) * 0.5))

/damagetype/npc/get_attack_message_sound(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	return span("warning","You hear bone hitting flesh.")