/atom/proc/attack(var/atom/attacker,var/atom/victim,params)

	if(attacker && victim)
		attacker.face_atom(victim)

	var/atom/object_to_damage_with = get_object_to_damage_with(attacker,victim,params)
	var/atom/object_to_damage = victim.get_object_to_damage(attacker,victim,params)

	/*
	attacker << "ATTACKER: [attacker]"
	attacker << "VICTIM: [victim]"

	attacker << "OBJECT TO DAMAGE WITH: [object_to_damage_with]"
	attacker << "OBJECT TO DAMAGE: [object_to_damage]"
	*/


	if(!object_to_damage || !object_to_damage_with)
		attacker << "You can't attack that!"
		return FALSE

	if(get_dist(attacker,victim) > object_to_damage_with.attack_range) //Out of range
		//attacker << "You miss!"
		return FALSE

	if(victim == object_to_damage)
		attacker << "You attacked \the [victim] with \the [object_to_damage_with]!"
	else
		attacker << "You attacked \the [victim]\s [object_to_damage] with \the [object_to_damage_with]!"

	var/damage_dealt = object_to_damage.adjust_brute_loss(object_to_damage_with.attack_damage[BRUTE]) + object_to_damage.adjust_burn_loss(object_to_damage_with.attack_damage[BURN]) + object_to_damage.adjust_tox_loss(object_to_damage_with.attack_damage[TOX]) + object_to_damage.adjust_oxy_loss(object_to_damage_with.attack_damage[OXY])

	//attacker << "You dealt [damage_dealt] damage!"

	//object_to_damage_with.update_icon()
	//object_to_damage.update_icon()
	//attacker.update_icon()
	victim.update_icon()

	return damage_dealt

/atom/proc/get_object_to_damage(var/atom/attacker,var/atom/victim,params) //Which object should the attacker damage?
	return victim

/atom/proc/get_object_to_damage_with(var/atom/attacker,var/atom/victim,params) //Which object should the attacker damage with?
	return src