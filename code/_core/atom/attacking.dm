/atom/proc/change_victim(var/atom/attacker)
	return src

/atom/proc/attack(var/atom/attacker,var/atom/victim,params) //The src attacks the victim, with the attacker taking responsibility

	if(attacker && victim)
		attacker.face_atom(victim)

	victim = victim.change_victim(attacker)

	if(!attacker.can_attack(victim,params))
		return FALSE

	/*
	if(attacker != src && !can_attack(victim,params))
		return FALSE
	*/

	var/atom/object_to_damage_with = get_object_to_damage_with(attacker,victim,params)
	var/atom/object_to_damage = victim.get_object_to_damage(attacker,victim,params)

	if(!object_to_damage || !object_to_damage_with)
		attacker << "You can't attack that!"
		return FALSE

	if(get_dist(attacker,victim) > object_to_damage_with.attack_range) //Out of range
		return FALSE

	var/damagetype/DT = object_to_damage_with.damage_type

	if(!DT)
		attacker << "You can't see any way you can inflict harm with \the [object_to_damage_with.type]."
		return FALSE

	var/can_attack = DT.can_attack(attacker,victim,object_to_damage_with,object_to_damage)
	if(!can_attack)
		return FALSE

	DT.attack_last = world.time
	attacker.attack_last = world.time

	switch(DT.handle_dodge(attacker,victim,object_to_damage_with,object_to_damage))
		if(DODGE_MISS)
			if(DT.perform_miss(attacker,victim,object_to_damage_with,object_to_damage)) return FALSE
		if(DODGE_BLOCK)
			if(victim.perform_block(attacker,object_to_damage_with,object_to_damage,DT)) return FALSE
		if(DODGE_PARRY)
			if(victim.perform_parry(attacker,object_to_damage_with,object_to_damage,DT,DT.allow_parry_counter)) return FALSE
		if(DODGE_DODGE)
			if(victim.perform_dodge(attacker,object_to_damage_with,object_to_damage,DT)) return FALSE

	DT.do_damage(attacker,victim,object_to_damage_with,object_to_damage)

	return can_attack

/atom/proc/get_object_to_damage(var/atom/attacker,var/atom/victim,params) //Which object should the attacker damage?
	return victim

/atom/proc/get_object_to_damage_with(var/atom/attacker,var/atom/victim,params) //Which object should the attacker damage with?
	return src

/atom/proc/can_attack(var/atom/victim,var/params)

	var/area/A = get_area(src)
	if(A && A.safe)
		src.to_chat(span("notice","You can't attack in a safezone!"))
		return FALSE

	if(attack_last + get_attack_delay(victim,params) > world.time)
		return FALSE

	return TRUE

/atom/proc/get_attack_delay(var/atom/victim,var/params)
	return attack_delay

/atom/proc/get_parry_chance(var/atom/attacker,var/atom/weapon,var/atom/target)
	return 0

/atom/proc/get_miss_chance(var/atom/attacker,var/atom/weapon,var/atom/target)
	return 0

/atom/proc/get_dodge_chance(var/atom/attacker,var/atom/weapon,var/atom/target)
	return 0

/atom/proc/get_block_chance(var/atom/attacker,var/atom/weapon,var/atom/target)
	return 0

/atom/proc/perform_block(var/atom/attacker,var/atom/weapon,var/atom/target,var/damagetype/DT)
	DT.display_miss_message(attacker,src,weapon,target,"blocked")
	return TRUE

/atom/proc/perform_parry(var/atom/attacker,var/atom/weapon,var/atom/target,var/damagetype/DT,var/allow_parry_counter)
	DT.display_miss_message(attacker,src,weapon,target,"parried")
	return TRUE

/atom/proc/perform_dodge(var/atom/attacker,var/atom/weapon,var/atom/target,var/damagetype/DT)
	DT.display_miss_message(attacker,src,weapon,target,"dodged")
	return TRUE