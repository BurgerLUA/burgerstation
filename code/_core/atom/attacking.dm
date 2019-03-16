/atom/proc/change_victim(var/atom/attacker)
	return src

/atom/proc/attack(var/atom/attacker,var/atom/victim,params) //The src attacks the victim, with the attacker taking responsibility

	victim = victim.change_victim(attacker)

	if(attacker && victim)
		attacker.face_atom(victim)

	if(!attacker.can_attack(victim,params))
		return FALSE

	var/atom/object_to_damage_with = get_object_to_damage_with(attacker,victim,params)
	var/atom/object_to_damage = victim.get_object_to_damage(attacker,victim,params)

	if(!object_to_damage || !object_to_damage_with)
		if(is_mob(attacker))
			var/mob/M = attacker
			M.to_chat(span("notice","You can't attack that!"))
		return FALSE

	if(get_dist(attacker,victim) > object_to_damage_with.attack_range) //Out of range
		return FALSE

	var/damagetype/DT = all_damage_types[object_to_damage_with.damage_type]

	if(!DT)
		world.log << "[attacker] can't inflict harm with the [object_to_damage_with.type]!"
		return FALSE

	var/can_attack = DT.can_attack(attacker,victim,object_to_damage_with,object_to_damage)
	if(!can_attack)
		return FALSE

	DT.attack_last = world.time
	attacker.attack_last = world.time

	if(DT.perform_miss(attacker,victim,object_to_damage_with,object_to_damage)) return FALSE
	if(victim.perform_block(attacker,object_to_damage_with,object_to_damage,DT)) return FALSE
	if(victim.perform_parry(attacker,object_to_damage_with,object_to_damage,DT,DT.allow_parry_counter)) return FALSE
	if(victim.perform_dodge(attacker,object_to_damage_with,object_to_damage,DT)) return FALSE

	attacker << "DO DAMAGE"
	DT.do_damage(attacker,victim,object_to_damage_with,object_to_damage)

	return can_attack

/atom/proc/get_object_to_damage(var/atom/attacker,var/atom/victim,params) //Which object should the attacker damage?
	return victim

/atom/proc/get_object_to_damage_with(var/atom/attacker,var/atom/victim,params) //Which object should the attacker damage with?
	return src

/atom/proc/can_attack(var/atom/victim,var/params)

	var/area/A = get_area(src)
	if(A && A.safe)
		return FALSE

	if(attack_last + get_attack_delay(victim,params) > world.time)
		return FALSE

	if(victim && !victim.can_be_attacked(src))
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
	var/base_chance = get_block_chance(attacker,weapon,target)
	if(!prob(base_chance))
		return FALSE
	DT.display_miss_message(attacker,src,weapon,target,"blocked")
	return TRUE

/atom/proc/perform_parry(var/atom/attacker,var/atom/weapon,var/atom/target,var/damagetype/DT,var/allow_parry_counter)
	var/base_chance = get_parry_chance(attacker,weapon,target)
	if(!prob(base_chance))
		return FALSE
	DT.display_miss_message(attacker,src,weapon,target,"parried")
	if(allow_parry_counter)
		src.attack(src,attacker)
	return TRUE

/atom/proc/perform_dodge(var/atom/attacker,var/atom/weapon,var/atom/target,var/damagetype/DT)
	var/base_chance = get_dodge_chance(attacker,weapon,target)
	if(!prob(base_chance))
		return FALSE
	DT.display_miss_message(attacker,src,weapon,target,"dodged")
	return TRUE