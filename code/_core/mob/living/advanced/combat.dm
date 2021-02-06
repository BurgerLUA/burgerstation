


/mob/living/advanced/send_pain(var/pain_strength=50)

	var/species/S = SPECIES(species)

	if(S.flags_species_traits & TRAIT_NO_PAIN)
		return FALSE

	return ..()


/mob/living/advanced/can_be_attacked(var/atom/attacker,var/atom/weapon,var/params,var/damagetype/damage_type)

	if(driving)
		return FALSE

	return ..()

/mob/living/advanced/can_attack(var/atom/victim,var/atom/weapon,var/params,var/damagetype/damage_type)

	if(driving && !driving.can_attack(victim,weapon,params,damage_type))
		return FALSE

	if(attack_flags & CONTROL_MOD_BLOCK)
		return FALSE

	if(handcuffed)
		return FALSE

	return ..()


/mob/living/advanced/defer_click_on_object(var/mob/caller,location,control,params)
	if(driving)
		return driving
	return ..()

/mob/living/advanced/get_object_to_damage(var/atom/attacker,var/atom/weapon,var/list/params = list(),var/accurate=FALSE,var/find_closest=FALSE,var/inaccuracy_modifier=1)

	if(!length(params))
		params = list(PARAM_ICON_X = num2text(rand(0,32)),PARAM_ICON_Y = num2text(rand(0,32)))

	var/x_attack = text2num(params[PARAM_ICON_X])
	var/y_attack = text2num(params[PARAM_ICON_Y])

	if(!accurate && is_living(attacker) && attacker != src)
		var/inaccuracy = !weapon ? 0 : weapon.get_inaccuracy(attacker,src,inaccuracy_modifier)
		x_attack = clamp(x_attack + rand(-inaccuracy,inaccuracy),0,32)
		y_attack = clamp(y_attack + rand(-inaccuracy,inaccuracy),0,32)

	var/best_distance = INFINITY
	var/obj/item/organ/best_organ
	var/obj/item/organ/best_distance_organ

	for(var/k in src.organs)

		var/obj/item/organ/O = k

		if(!O.can_be_targeted)
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

	return FALSE

/mob/living/proc/get_current_target_cords(params)
	if(!params)
		params = list(PARAM_ICON_X = 16, PARAM_ICON_Y = 16)
	return list(params[PARAM_ICON_X],params[PARAM_ICON_Y])

/mob/living/advanced/player/get_current_target_cords(params)
	if(!params || !client)
		return list(16,16)

	var/click_flags = client.get_click_flags(params,TRUE)

	if(click_flags & CLICK_RIGHT)
		return attack_right[attack_mode]

	return attack_left[attack_mode]

/*
/mob/living/advanced/can_block(var/atom/attacker,var/atom/weapon,var/atom/target,var/damagetype/DT)

	. = ..()

	if(!.)
		return null

	var/list/possible_blocks = list()

	var/obj/item/IL = get_held_left(DT.get_attack_type())
	if(IL && IL.can_block(attacker,weapon,target,DT))
		possible_blocks += IL

	var/obj/item/IR = get_held_right(DT.get_attack_type())
	if(IR && IR.can_block(attacker,weapon,target,DT))
		possible_blocks += IR

	if(!length(possible_blocks))
		if(left_hand && left_hand.loc && left_hand.loc.can_block(attacker,weapon,target,DT))
			possible_blocks += left_hand.loc

		if(right_hand && right_hand.loc && right_hand.loc.can_block(attacker,weapon,target,DT))
			possible_blocks += right_hand.loc

	if(length(possible_blocks))
		return pick(possible_blocks)

	return null

/mob/living/advanced/can_parry(var/atom/attacker,var/atom/weapon,var/atom/target,var/damagetype/DT)

	. = ..()

	if(!.)
		return null

	var/list/possible_parry = list()

	if(left_item && left_item.can_parry(attacker,weapon,target,DT))
		possible_parry += left_item

	if(right_item && right_item.can_parry(attacker,weapon,target,DT))
		possible_parry += right_item

	if(length(possible_parry))
		return pick(possible_parry)

	if(left_hand && left_hand.can_parry(attacker,weapon,target,DT))
		possible_parry += left_hand

	if(right_hand && right_hand.can_parry(attacker,weapon,target,DT))
		possible_parry += right_hand

	if(length(possible_parry))
		return pick(possible_parry)

	return null
*/



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

/*
/mob/living/advanced/player/proc/get_defence_key()
	if(attack_flags & CONTROL_MOD_BLOCK)
		return "block"
	else if(movement_flags & MOVEMENT_RUNNING)
		return "dodge"
	else if(attack_flags & CONTROL_MOD_ALT)
		return "parry"
	return "none"

/mob/living/advanced/player/can_parry(var/atom/attacker,var/atom/attacking_weapon,var/atom/victim,var/damagetype/DT)

	if(get_defence_key() != "parry")
		return null

	return ..()

/mob/living/advanced/player/can_dodge(var/atom/attacker,var/atom/attacking_weapon,var/atom/victim,var/damagetype/DT)

	if(get_defence_key() != "dodge")
		return null

	return ..()

/mob/living/advanced/player/can_block(var/atom/attacker,var/atom/attacking_weapon,var/atom/victim,var/damagetype/DT)

	if(get_defence_key() != "block")
		return null

	return ..()
*/



/mob/living/advanced/get_damage_received_multiplier(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/damagetype/DT)

	. = ..()

	if(is_organ(hit_object))
		var/obj/item/organ/O = hit_object
		. *= O.damage_coefficient

	return .