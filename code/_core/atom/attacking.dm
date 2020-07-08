/atom/proc/get_attack_delay(var/mob/user) //Return deciseconds.

	if(is_living(user))
		var/mob/living/L = user
		if(attack_delay_max < attack_delay)
			attack_delay_max = attack_delay
		return attack_delay + (attack_delay_max - attack_delay)*(1-L.get_attribute_power(ATTRIBUTE_DEXTERITY))

	return attack_delay

/atom/proc/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/list/damage_table,var/damage_amount,var/critical_hit_multiplier,var/stealthy=FALSE)

	if(health)
		health.update_health(damage_amount,attacker)

	if(ENABLE_DAMAGE_NUMBERS && !stealthy && damage_amount > 0)
		if(isturf(src))
			new/obj/effect/temp/damage_number(src,null,damage_amount)
		else if(isturf(src.loc))
			new/obj/effect/temp/damage_number(get_turf(src),null,damage_amount)

	return TRUE

/atom/proc/change_victim(var/atom/attacker)
	return src

/atom/proc/attack(var/atom/attacker,var/atom/victim,var/list/params,var/atom/blamed,var/ignore_distance = FALSE, var/precise = FALSE) //The src attacks the victim, with the blamed taking responsibility

	if(!attacker)
		attacker = src

	if(!blamed)
		blamed = attacker

	if(!params)
		params = list()

	victim = victim.change_victim(attacker)

	if(attacker && victim && attacker != victim && !ignore_distance)
		attacker.face_atom(victim)

	if(!precise && is_living(victim))
		var/mob/living/L = victim
		if(L.ai && L.ai.alert_level <= ALERT_LEVEL_NOISE)
			precise = TRUE

	if(is_player(attacker))
		var/mob/living/advanced/player/P = attacker
		if(P.client)
			//var/click_flags = P.client.get_click_flags(params,TRUE)

			var/list/attack_coords = P.get_current_target_cords(params)

			/*
			if(click_flags & CLICK_LEFT)
				attack_x = P.attack_left[P.attack_mode][1]
				attack_y = P.attack_left[P.attack_mode][2]
			else if(click_flags & CLICK_RIGHT)
				attack_x = P.attack_right[P.attack_mode][1]
				attack_y = P.attack_right[P.attack_mode][2]
			*/

			params[PARAM_ICON_X] = num2text(attack_coords[1])
			params[PARAM_ICON_Y] = num2text(attack_coords[2])

	var/atom/object_to_damage_with = get_object_to_damage_with(attacker,victim,params)

	if(!object_to_damage_with)
		return FALSE

	if(!ignore_distance && get_dist_advanced(attacker,victim) > object_to_damage_with.attack_range)
		return FALSE

	var/atom/object_to_damage = victim.get_object_to_damage(attacker,object_to_damage_with,params,precise,precise)
	var/desired_damage_type = object_to_damage_with.get_damage_type(attacker,victim,object_to_damage)

	if(!desired_damage_type)
		return FALSE

	var/damagetype/DT = all_damage_types[desired_damage_type]
	if(!attacker.can_attack(victim,object_to_damage_with,params,DT))
		return FALSE

	if(is_advanced(attacker) && DT.cqc_tag)
		var/mob/living/advanced/A = attacker
		A.add_cqc(DT.cqc_tag)
		var/damagetype/DT2 = A.check_cqc(victim,object_to_damage_with,object_to_damage,blamed)
		if(DT2 && attacker.can_attack(victim,object_to_damage_with,params,DT2))
			DT = DT2

	if(!DT)
		log_error("Warning! [attacker.get_debug_name()] tried attacking with [src.get_debug_name()], but it had no damage type!")
		return FALSE

	if(attacker != object_to_damage_with)
		object_to_damage_with.attack_next = world.time + object_to_damage_with.get_attack_delay(attacker)*DT.attack_delay_mod

	attacker.attack_next = world.time + attacker.get_attack_delay(attacker)

	if(!object_to_damage)
		DT.perform_miss(attacker,victim,object_to_damage_with) //TODO: FIX THIS
		return FALSE

	var/damage_multiplier = 1

	if(DT.allow_dodge)
		var/dodging_return = victim.can_dodge(attacker,object_to_damage_with,object_to_damage,DT)
		if(dodging_return && victim.perform_dodge(attacker,object_to_damage_with,object_to_damage,DT))
			return FALSE

	if(DT.allow_parry)
		var/atom/parrying_atom = victim.can_parry(attacker,object_to_damage_with,object_to_damage,DT)
		if(parrying_atom && victim.perform_parry(attacker,object_to_damage_with,object_to_damage,DT,parrying_atom))
			return FALSE

	if(DT.allow_block)
		var/atom/blocking_atom = victim.can_block(attacker,object_to_damage_with,object_to_damage,DT)
		if(blocking_atom && victim.perform_block(attacker,object_to_damage_with,object_to_damage,DT,blocking_atom))
			damage_multiplier *= 0.75
			damage_multiplier *= 1 - clamp(blocking_atom.get_block_power(victim,attacker,object_to_damage_with,object_to_damage,DT) - DT.get_block_power_penetration(attacker,victim,object_to_damage_with,object_to_damage,blocking_atom),0,1)

	if(damage_multiplier <= 0)
		return FALSE

	DT.do_damage(attacker,victim,object_to_damage_with,object_to_damage,attacker,damage_multiplier)

	return TRUE

/atom/proc/get_block_power(var/atom/victim,var/atom/attacker,var/atom/weapon,var/atom/object_to_damage,var/damagetype/DT)
	return 0.5

/atom/proc/get_object_to_damage(var/atom/attacker,var/atom/weapon,var/params,var/accurate = FALSE,var/find_closest=FALSE) //Which object should the attacker damage?
	return src

/atom/proc/get_object_to_damage_with(var/atom/attacker,var/atom/victim,params) //Which object should the attacker damage with?
	return src

/atom/proc/can_attack(var/atom/victim,var/atom/weapon,var/params,var/damagetype/damage_type)

	if(!mouse_opacity)
		return FALSE

	/* TODO: Loyalty Implant
	if(victim && is_valid(victim) && is_living(victim))
		var/area/A1 = get_area(victim)
		var/area/A2 = get_area(src)
		if(A1.flags_area & FLAGS_AREA_NO_DAMAGE != A2.flags_area & FLAGS_AREA_NO_DAMAGE)
			return FALSE
	*/

	if(attack_next > world.time)
		return FALSE

	if(weapon && weapon.attack_next > world.time)
		return FALSE

	if(victim && !victim.can_be_attacked(src,weapon,params,damage_type))
		return FALSE

	if(!isturf(loc))
		return FALSE

	return TRUE

/*
/atom/proc/get_miss_chance(var/atom/attacker,var/atom/weapon,var/atom/target) //Chance that hitting this atom is a miss.
	return 0
*/

/atom/proc/can_parry(var/atom/attacker,var/atom/attacking_weapon,var/atom/victim,var/damagetype/DT)
	return null

/atom/proc/can_dodge(var/atom/attacker,var/atom/attacking_weapon,var/atom/victim,var/damagetype/DT)
	return null

/atom/proc/can_block(var/atom/attacker,var/atom/attacking_weapon,var/atom/victim,var/damagetype/DT)
	return null

/atom/proc/perform_block(var/atom/attacker,var/atom/weapon,var/atom/target,var/damagetype/DT,var/atom/blocking_item)
	return FALSE

/atom/proc/perform_parry(var/atom/attacker,var/atom/weapon,var/atom/target,var/damagetype/DT,var/atom/parrying_item)
	return FALSE

/atom/proc/perform_dodge(var/atom/attacker,var/atom/weapon,var/atom/target,var/damagetype/DT)
	return FALSE

/atom/proc/get_damage_type(var/atom/attacker,var/atom/victim,var/atom/target)
	return damage_type