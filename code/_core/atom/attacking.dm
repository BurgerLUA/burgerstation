/atom/proc/attack(var/atom/attacker,var/atom/victim,params)

	if(attacker && victim)
		attacker.face_atom(victim)

	var/atom/object_to_damage_with = get_object_to_damage_with(attacker,victim,params)
	var/atom/object_to_damage = victim.get_object_to_damage(attacker,victim,params)

	if(!object_to_damage || !object_to_damage_with)
		attacker << "You can't attack that!"
		return FALSE

	if(get_dist(attacker,victim) > object_to_damage_with.attack_range) //Out of range
		return FALSE


	var/datum/damagetype/DT = object_to_damage_with.damage_type

	if(!DT)
		attacker << "You can't see any way you can inflict harm with \the [object_to_damage_with.type]."
		return 0

	if(DT.last_hit + DT.delay > world.time)
		return 0

	DT.last_hit = world.time

	return DT.do_damage(attacker,victim,object_to_damage_with,object_to_damage)

/atom/proc/get_object_to_damage(var/atom/attacker,var/atom/victim,params) //Which object should the attacker damage?
	return victim

/atom/proc/get_object_to_damage_with(var/atom/attacker,var/atom/victim,params) //Which object should the attacker damage with?
	return src