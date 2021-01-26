/atom/proc/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/list/damage_table,var/damage_amount,var/critical_hit_multiplier,var/stealthy=FALSE)

	if(health)
		health.update_health(attacker,damage_amount)

	if(ENABLE_DAMAGE_NUMBERS && !stealthy && damage_amount > 0)
		if(isturf(src.loc)) new/obj/effect/temp/damage_number(src.loc,null,damage_amount)

	return TRUE

/atom/proc/change_victim(var/atom/attacker,var/atom/object)
	return src

/atom/proc/should_cleave(var/atom/attacker,var/atom/victim,var/list/params)
	return FALSE

/atom/proc/attack(var/atom/attacker,var/atom/victim,var/list/params=list(),var/atom/blamed,var/ignore_distance = FALSE, var/precise = FALSE,var/damage_multiplier=1) //The src attacks the victim, with the blamed taking responsibility

	if(!attacker)
		attacker = src

	if(!blamed)
		blamed = attacker

	if(!params)
		params = list()

	if(!victim)
		CRASH_SAFE("Tried attacking without a victim!")
		return FALSE

	if(qdeleting)
		CRASH("[src.get_debug_name()] tried attacking, but it was deleting!")
		return FALSE

	if(attacker.qdeleting)
		CRASH("[attacker.get_debug_name()] tried attacking with [src.get_debug_name()], but it was deleting!")
		return FALSE

	/* GOTTA TEST THIS
	if(invisibility >= 101 || alpha == 0)
		log_error("Warning: [src.get_debug_name()] tried attacking, but it was invisible!")
		return FALSE

	if(attacker.invisibility >= 101 || attacker.alpha == 0)
		log_error("Warning: [attacker.get_debug_name()] tried attacking with [src.get_debug_name()], but it was invisible!")
		return FALSE
	*/

	var/atom/changed_target = victim.change_victim(attacker,src)
	if(changed_target)
		victim = changed_target

	if(!precise && is_living(victim))
		var/mob/living/L = victim
		if(L.ai && L.ai.alert_level <= ALERT_LEVEL_NOISE)
			precise = TRUE

	if(attacker != victim && !ignore_distance)
		attacker.face_atom(victim) //Face first victim

	if(is_player(attacker))
		var/mob/living/advanced/player/P = attacker
		if(P.client)
			var/list/attack_coords = P.get_current_target_cords(params)
			params[PARAM_ICON_X] = num2text(attack_coords[1])
			params[PARAM_ICON_Y] = num2text(attack_coords[2])

	var/atom/object_to_damage_with = get_object_to_damage_with(attacker,victim,params)

	if(!object_to_damage_with) //You don't even exist.
		return FALSE

	var/attack_distance = get_dist_advanced(attacker,victim)
	if(!ignore_distance && attack_distance > object_to_damage_with.attack_range) //Can't attack, weapon isn't long enough.
		return FALSE

	if(attack_distance > 1)
		var/step_check = attack_distance
		var/direction = get_dir(attacker,victim)
		var/turf/last_turf = get_turf(src)
		while(step_check > 0)
			var/turf/next_turf = get_step(last_turf,direction)
			if(next_turf != get_turf(victim)) //Only do a move check BETWEEN the attacker and the victim.
				if(!next_turf.Enter(melee_checker,last_turf))
					if(ismob(attacker))
						var/mob/M = attacker
						M.to_chat(span("warning","\The [next_turf.name] is in the way!"))
					return FALSE

				for(var/k in next_turf.contents)
					var/atom/movable/M = k
					if(!M.density)
						continue
					if(!M.Cross(melee_checker))
						if(ismob(attacker))
							var/mob/M2 = attacker
							M2.to_chat(span("warning","\The [M.name] is in the way!"))
						return FALSE


			last_turf = next_turf
			step_check--

	var/desired_damage_type = object_to_damage_with.get_damage_type(attacker,victim)
	if(!desired_damage_type)
		return FALSE

	var/cleave_number = should_cleave(attacker,victim,params)
	var/list/victims = list(victim)
	if(cleave_number)
		for(var/atom/movable/A in range(1,victim))
			if(cleave_number <= 0)
				break
			A = A.change_victim(attacker,src)
			if(A == victim || A == attacker)
				continue
			if(get_dist(attacker,A) > object_to_damage_with.attack_range)
				continue
			victims += A
			cleave_number--

	var/damagetype/DT = all_damage_types[desired_damage_type]
	if(!DT)
		log_error("Warning! [attacker.get_debug_name()] tried attacking with [src.get_debug_name()], but it had no damage type!")
		return FALSE

	if(world.time < attacker.attack_next)
		return FALSE

	if(attacker != object_to_damage_with && world.time < object_to_damage_with.attack_next)
		return FALSE

	var/list/hit_objects = list()
	for(var/atom/v in victims)
		var/can_attack = attacker.can_attack(v,object_to_damage_with,params,DT)
		var/can_be_attacked = v.can_be_attacked(attacker,object_to_damage_with,params,DT)
		if(can_attack && can_be_attacked)
			var/atom/hit_object = v.get_object_to_damage(attacker,object_to_damage_with,params,precise,precise)
			if(hit_object)
				hit_objects += hit_object //HOPEFULLY this lines up. Victims aren't removed after this.
				if(victim == v && DT.cqc_tag && is_advanced(attacker)) //Only check CQC on the first victim.
					var/mob/living/advanced/A = attacker
					A.add_cqc(DT.cqc_tag)
					var/damagetype/DT2 = A.check_cqc(v,object_to_damage_with,hit_object,blamed)
					if(DT2) DT = DT2
				continue
			//No hit object means we missed.
		if(victim == v) //First victim. You must be able to attack the first victim if you want to attack the rest.
			hit_objects = null
			if(can_attack && can_be_attacked) break //Just means we don't have a hitobject.
		victims -= v //Needs to be here.

	var/object_attack_delay = DT.get_attack_delay(attacker)

	if(attacker != object_to_damage_with)
		object_to_damage_with.attack_next = world.time + object_attack_delay

	attacker.attack_next = world.time + object_attack_delay*0.5

	DT.swing(attacker,victims,object_to_damage_with,hit_objects,attacker)

	return TRUE

/atom/proc/get_block_power(var/atom/victim,var/atom/attacker,var/atom/weapon,var/atom/object_to_damage,var/damagetype/DT)
	return 0.5

/atom/proc/get_object_to_damage(var/atom/attacker,var/atom/weapon,var/params,var/accurate = FALSE,var/find_closest=FALSE) //Which object should the attacker damage?
	return src

/atom/proc/get_object_to_damage_with(var/atom/attacker,var/atom/victim,params) //Which object should the attacker damage with?
	return src

/atom/proc/can_attack(var/atom/victim,var/atom/weapon,var/params,var/damagetype/damage_type)

	if(attack_next > world.time)
		return FALSE

	if(weapon && weapon.attack_next > world.time)
		return FALSE

	if(!isturf(loc))
		return FALSE

	var/area/A1 = get_area(victim)
	var/area/A2 = get_area(src)

	if(!(A1 && A2))
		return FALSE

	if(A1.flags_area & FLAGS_AREA_NO_DAMAGE != A2.flags_area & FLAGS_AREA_NO_DAMAGE)
		return FALSE

	return TRUE

/*
/atom/proc/get_miss_chance(var/atom/attacker,var/atom/weapon,var/atom/target) //Chance that hitting this atom is a miss.
	return 0
*/

/*
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
*/

/atom/proc/get_damage_type(var/atom/attacker,var/atom/victim)
	return damage_type