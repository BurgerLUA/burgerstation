/atom/proc/on_damage_received(atom/atom_damaged,atom/attacker,atom/weapon,damagetype/DT,list/damage_table,damage_amount,critical_hit_multiplier,stealthy=FALSE)
	HOOK_CALL("on_damage_received")
	return TRUE

/atom/proc/change_victim(atom/attacker)
	return src

/atom/proc/should_cleave(atom/attacker,atom/victim,list/params)
	return FALSE

/atom/proc/attack(atom/attacker,atom/victim,list/params=list(),atom/blamed,ignore_distance = FALSE, precise = FALSE,damage_multiplier=1,damagetype/damage_type_override) //The src attacks the victim, with the blamed taking responsibility

	if(!attacker)
		attacker = src

	if(!blamed)
		blamed = attacker

	if(!params)
		params = list()

	if(!victim)
		CRASH("[src.get_debug_name()] tried attacking without a victim!")

	if(qdeleting)
		CRASH("[src.get_debug_name()] tried attacking, but it was deleting!")

	if(attacker.qdeleting)
		CRASH("[attacker.get_debug_name()] tried attacking with [src.get_debug_name()], but it was deleting!")

	if(world.time < attacker.attack_next)
		return FALSE

	victim = victim.change_victim(attacker)

	if(!precise && is_living(victim))
		var/mob/living/L = victim
		if(L.ai && L.ai.alert_level <= ALERT_LEVEL_NOISE)
			precise = TRUE

	if(attacker != victim && !ignore_distance)
		attacker.face_atom(victim) //Face first victim

	if(is_living(attacker))
		var/mob/living/L = attacker
		var/list/attack_coords = L.get_current_target_cords(params)
		params[PARAM_ICON_X] = attack_coords[1]
		params[PARAM_ICON_Y] = attack_coords[2]

	var/atom/object_to_damage_with = get_object_to_damage_with(attacker,victim,params)

	if(!object_to_damage_with) //You don't even exist.
		return FALSE

	if(attacker != object_to_damage_with && world.time < object_to_damage_with.attack_next)
		return FALSE

	var/desired_damage_type = damage_type_override ? damage_type_override : object_to_damage_with.get_damage_type(attacker,victim)
	if(!desired_damage_type)
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

	var/damagetype/DT = SSdamagetype.all_damage_types[desired_damage_type]
	if(!DT)
		log_error("Warning! [attacker.get_debug_name()] tried attacking with [src.get_debug_name()], but it had no damage type!")
		return FALSE

	var/inaccuracy = DT.inaccuracy_mod
	if(!precise && inaccuracy > 0)
		inaccuracy *= src.get_inaccuracy(attacker,victim,1)
		params[PARAM_ICON_X] = clamp(params[PARAM_ICON_X] + rand(-inaccuracy,inaccuracy),0,TILE_SIZE)
		params[PARAM_ICON_Y] = clamp(params[PARAM_ICON_Y] + rand(-inaccuracy,inaccuracy),0,TILE_SIZE)

	var/cleave_number = should_cleave(attacker,victim,params)
	var/list/victims = list(victim)
	if(cleave_number)
		for(var/atom/movable/A in range(1,victim))
			if(cleave_number <= 0)
				break
			A = A.change_victim(attacker)
			if(A == victim || A == attacker)
				continue
			if(get_dist(attacker,A) > object_to_damage_with.attack_range)
				continue
			victims += A
			cleave_number--

	if(!length(victims))
		attacker.attack_next = world.time + 1
		return FALSE

	var/list/hit_objects = list()
	for(var/atom/v in victims)
		var/can_attack = attacker.can_attack(attacker,v,object_to_damage_with,params,DT)
		var/can_be_attacked = v.can_be_attacked(attacker,object_to_damage_with,params,DT)
		if(victim == v && !(can_attack && can_be_attacked))
			return FALSE
		if(can_attack && can_be_attacked)
			var/atom/hit_object = v.get_object_to_damage(attacker,object_to_damage_with,desired_damage_type,params,precise,precise,1)
			hit_objects += hit_object //Could be null, but that's fine.
			if(hit_object)
				if(victim == v && DT.cqc_tag && is_advanced(attacker)) //Only check CQC on the first victim.
					var/mob/living/advanced/A = attacker
					A.add_cqc(DT.cqc_tag)
					var/damagetype/DT2 = A.check_cqc(v,object_to_damage_with,hit_object,blamed,DT)
					if(DT2) DT = DT2
				continue
			//No hit object means we missed.

		if(victim == v) //First victim. You must be able to attack the first victim if you want to attack the rest.
			hit_objects = null
			if(can_attack && can_be_attacked) break //Just means we don't have a hitobject.
		victims -= v //Needs to be here.

	if(is_living(attacker))
		var/mob/living/L = attacker
		if(DT.allow_power_attacks && (L.attack_flags & CONTROL_MOD_DISARM) && L.health.stamina_current >= 20 && L.health.adjust_stamina(-20))
			return DT.windup(attacker,victims,object_to_damage_with,hit_objects,attacker,2)

	return DT.swing(attacker,victims,object_to_damage_with,hit_objects,attacker)

/atom/proc/get_block_power(atom/victim,atom/attacker,atom/weapon,atom/object_to_damage,damagetype/DT)
	return 0.5

/atom/proc/get_object_to_damage(atom/attacker,atom/weapon,damagetype/damage_type,list/params = list(),accurate=FALSE,find_closest=FALSE,inaccuracy_modifier=1)
	return src

/atom/proc/get_object_to_damage_with(atom/attacker,atom/victim,list/params=list()) //Which object should the attacker damage with?
	return src

/atom/proc/can_attack(atom/attacker,atom/victim,atom/weapon,params,damagetype/damage_type)

	if(attack_next > world.time)
		return FALSE

	if(weapon && weapon.attack_next > world.time)
		return FALSE

	if(victim)
		if(!victim.z)
			return FALSE
		var/area/A1 = get_area(victim)
		var/area/A2 = get_area(src)
		if(!(A1 && A2))
			CRASH("Tried attacking without valid areas!")
		if( (A1.flags_area & FLAG_AREA_NO_DAMAGE) || (A2.flags_area & FLAG_AREA_NO_DAMAGE) )
			return FALSE

	return TRUE

/atom/proc/get_damage_type(atom/attacker,atom/victim)
	return damage_type