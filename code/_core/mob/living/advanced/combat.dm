/mob/living/advanced/can_be_attacked(var/atom/attacker,var/atom/weapon,var/params,var/damagetype/damage_type)

	if(driving)
		return FALSE

	return ..()

/mob/living/advanced/can_attack(var/atom/attacker,var/atom/victim,var/atom/weapon,var/params,var/damagetype/damage_type)

	if(driving)
		return driving.can_attack(attacker,victim,weapon,params,damage_type)

	if(attack_flags & CONTROL_MOD_BLOCK)
		return FALSE

	if(handcuffed)
		return FALSE

	return ..()


/mob/living/advanced/defer_click_on_object(var/mob/caller,location,control,params)
	if(driving)
		return driving
	return ..()

/mob/living/advanced/get_object_to_damage(var/atom/attacker,var/atom/weapon,var/damagetype/damage_type,var/list/params = list(),var/accurate=FALSE,var/find_closest=FALSE,var/inaccuracy_modifier=1)

	if(!length(params))
		params = list(PARAM_ICON_X=16,PARAM_ICON_Y=16)

	var/x_attack = text2num(params[PARAM_ICON_X])
	var/y_attack = text2num(params[PARAM_ICON_Y])

	if(!accurate && attacker != src && is_living(attacker))
		var/inaccuracy = weapon ? weapon.get_inaccuracy(attacker,src,inaccuracy_modifier) : 0
		if(inaccuracy > 0)
			x_attack = clamp(x_attack + rand(-inaccuracy,inaccuracy),0,32)
			y_attack = clamp(y_attack + rand(-inaccuracy,inaccuracy),0,32)

	var/best_distance = INFINITY
	var/obj/item/organ/best_organ
	var/obj/item/organ/best_distance_organ

	for(var/k in src.organs)

		var/obj/item/organ/O = k

		if(!O.can_be_targeted)
			continue

		if(!O.check_hit_chance(attacker,weapon,damage_type,params,accurate,find_closest,inaccuracy_modifier))
			continue

		if(x_attack >= O.target_bounds_x_min && x_attack <= O.target_bounds_x_max && y_attack >= O.target_bounds_y_min && y_attack <= O.target_bounds_y_max)
			best_organ = O
			break

		if(find_closest)
			var/center_x = (O.target_bounds_x_min + O.target_bounds_x_max) / 2
			var/center_y = (O.target_bounds_y_min + O.target_bounds_y_max) / 2

			var/distance_x = abs(x_attack - center_x)
			var/distance_y = abs(y_attack - center_y)

			var/distance = sqrt( (distance_x ** 2) + (distance_y ** 2) )

			if(!best_distance_organ || distance < best_distance)
				best_distance = distance
				best_distance_organ = O

	if(best_organ)
		return best_organ

	if(best_distance_organ)
		return best_distance_organ

	return null

/mob/living/proc/get_current_target_cords(params)
	if(ai)
		return list(pick(ai.target_distribution_x),pick(ai.target_distribution_x))
	if(!params)
		params = list(PARAM_ICON_X = 16, PARAM_ICON_Y = 16)
	return list(params[PARAM_ICON_X],params[PARAM_ICON_Y])

/mob/living/advanced/player/get_current_target_cords(params)
	if(!params || !client)
		return ..()

	var/click_flags = client.get_click_flags(params,TRUE)

	if(click_flags & CLICK_RIGHT)
		return attack_right[attack_mode]

	return attack_left[attack_mode]

/mob/living/advanced/proc/update_protection()

	protection_cold = TARGETABLE_LIMBS_KV
	protection_heat = TARGETABLE_LIMBS_KV
	protection_pressure = TARGETABLE_LIMBS_KV

	for(var/obj/item/clothing/C in src.worn_objects)
		if(C.protection_cold)
			for(var/k in C.protection_cold)
				var/v = C.protection_cold[k]
				protection_cold[k] += v

		if(C.protection_heat)
			for(var/k in C.protection_heat)
				var/v = C.protection_heat[k]
				protection_heat[k] += v

		if(C.protection_pressure)
			for(var/k in C.protection_pressure)
				var/v = C.protection_pressure[k]
				protection_pressure[k] += v

	return TRUE

/mob/living/advanced/get_block_data(var/atom/attacker,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/damagetype/DT)

	var/attack_type = DT.get_attack_type()

	var/obj/item/best_item = null
	var/best_value = 0

	//Left
	if(left_item)
		if(left_item.block_defense[attack_type] && left_item.block_defense[attack_type] > best_value && left_item.can_block(attacker,weapon,src,DT))
			best_item = left_item
			best_value = left_item.block_defense[attack_type]
	else if(src.labeled_organs[BODY_HAND_LEFT])
		var/obj/item/organ/O = src.labeled_organs[BODY_HAND_LEFT]
		if(O.block_defense[attack_type] && O.can_block(attacker,weapon,src,DT))
			best_item = O
			best_value = max(.,O.block_defense[attack_type])

	//Right
	if(right_item)
		if((right_item.block_defense[attack_type] > best_value || (best_value > 0 && right_item.block_defense[attack_type] == best_value && prob(50))) && right_item.can_block(attacker,weapon,src,DT) )
			best_item = right_item
			best_value = right_item.block_defense[attack_type]
	else if(src.labeled_organs[BODY_HAND_RIGHT])
		var/obj/item/organ/O = src.labeled_organs[BODY_HAND_RIGHT]
		if(O.block_defense[attack_type] > best_value && O.can_block(attacker,weapon,src,DT))
			best_item = O
			best_value = O.block_defense[attack_type]

	return list(best_item,best_value)

/mob/living/advanced/proc/parry(var/atom/attacker,var/atom/weapon,var/atom/hit_object,var/damagetype/DT)

	if(!is_facing(src,attacker))
		return FALSE

	if(world.time - last_hold > 5 + 5*get_skill_power(SKILL_PARRY,0,1,2))
		return FALSE

	return TRUE