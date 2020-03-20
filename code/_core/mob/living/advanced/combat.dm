/mob/living/advanced/get_object_to_damage(var/atom/attacker,var/list/params = list(),var/accurate=FALSE)

	if(!length(params))
		params = list(PARAM_ICON_X = num2text(rand(0,32)),PARAM_ICON_Y = num2text(rand(0,32)))

	var/x_attack = text2num(params[PARAM_ICON_X])
	var/y_attack = text2num(params[PARAM_ICON_Y])

	if(!accurate && is_living(attacker) && attacker != src)
		var/mob/living/L = attacker
		var/inaccuracy = (1 - L.get_attribute_power(ATTRIBUTE_DEXTERITY))*16
		x_attack = clamp(x_attack + rand(-inaccuracy,inaccuracy),0,32)
		y_attack = clamp(y_attack + rand(-inaccuracy,inaccuracy),0,32)

	var/best_distance = INFINITY
	var/obj/item/organ/best_organ
	var/obj/item/organ/best_distance_organ

	for(var/obj/item/organ/O in src.organs)

		if(!O.can_be_targeted)
			continue

		if(x_attack >= O.target_bounds_x_min && x_attack <= O.target_bounds_x_max && y_attack >= O.target_bounds_y_min && y_attack <= O.target_bounds_y_max)
			best_organ = O
			break

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

	LOG_ERROR("WARNING: Did not correctly run damage on [src] when [attacker] attacked!")

	return ..()

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

/mob/living/advanced/can_block(var/atom/attacker,var/atom/weapon,var/atom/target,var/damagetype/DT)

	. = ..()

	if(!.)
		return null

	var/obj/item/IL = get_held_left(DT.get_attack_type())
	var/obj/item/IR = get_held_right(DT.get_attack_type())

	var/list/possible_blocks = list()

	if(IL && IL.can_block(attacker,weapon,target,DT))
		possible_blocks += IL

	if(IR && IR.can_block(attacker,weapon,target,DT))
		possible_blocks += IL

	if(length(possible_blocks))
		return pick(possible_blocks)

	return .

/mob/living/advanced/can_parry(var/atom/attacker,var/atom/weapon,var/atom/target,var/damagetype/DT)

	. = ..()

	if(!.)
		return null

	var/obj/item/IL = get_held_left(DT.get_attack_type())
	var/obj/item/IR = get_held_right(DT.get_attack_type())

	var/list/possible_parry = list()

	if(IL && IL.can_parry(attacker,weapon,target,DT))
		possible_parry += IL

	if(IR && IR.can_parry(attacker,weapon,target,DT))
		possible_parry += IL

	if(length(possible_parry))
		return pick(possible_parry)

	return .

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


/mob/living/advanced/player/proc/get_defence_key()
	if(attack_flags & ATTACK_BLOCK)
		return "block"
	else if(movement_flags & MOVEMENT_RUNNING)
		return "dodge"
	else if(attack_flags & ATTACK_ALT)
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