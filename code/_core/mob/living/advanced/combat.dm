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

/*
/mob/living/advanced/perform_block(var/atom/attacker,var/atom/weapon,var/atom/target,var/damagetype/DT,var/atom/blocking_item)

	if(attacker == src)
		return FALSE

	charge_block -= 100

	DT.display_miss_message(attacker,src,weapon,target,"blocked")
	DT.do_attack_animation(attacker,src,weapon,target)
	new/obj/effect/temp/impact/combat/block(get_turf(target))

	var/area/A = get_area(src)
	if(A && istype(A))
		play_sound('sounds/weapons/generic_block.ogg', vector(src.x,src.y,src.z), environment = A.sound_environment,alert = ALERT_LEVEL_NOISE)

	if(is_living(attacker))
		var/mob/living/L = attacker
		L.to_chat(span("notice","\The [src.name] blocks your attack!"),CHAT_TYPE_COMBAT)

	src.to_chat(span("warning","You block \the [attacker.name]'s [weapon == attacker ? "attack" : weapon.name]!"),CHAT_TYPE_COMBAT)

	add_skill_xp(SKILL_BLOCK,1)

	return TRUE

/mob/living/advanced/perform_parry(var/atom/attacker,var/atom/weapon,var/atom/target,var/damagetype/DT,var/atom/parrying_item,var/allow_parry_counter)

	if(attacker == src)
		return FALSE

	charge_parry -= 100

	DT.do_attack_animation(attacker,src,weapon,target)
	DT.display_miss_message(attacker,src,weapon,target,"parried by [src]'s [parrying_item]")

	if(is_living(attacker))
		var/mob/living/L = attacker
		L.to_chat(span("notice","\The [src.name] parries your attack with their [parrying_item.name]!"),CHAT_TYPE_COMBAT)

	src.to_chat(span("warning","You parry \the [attacker.name]'s [weapon == attacker ? "attack" : weapon.name] with your [parrying_item.name]!"),CHAT_TYPE_COMBAT)

	if(allow_parry_counter && parrying_item)
		parrying_item.attack(src,attacker)

	add_skill_xp(SKILL_PARRY,1)

	return TRUE
*/

/mob/living/perform_dodge(var/atom/attacker,var/atom/weapon,var/atom/target,var/damagetype/DT)

	if(attacker == src)
		return FALSE

	charge_dodge -= 100

	var/pixel_x_offset = prob(50) ? -8 : 8
	var/pixel_y_offset = prob(50) ? -8 : 8

	animate(src, pixel_x = src.pixel_x + pixel_x_offset, pixel_y = src.pixel_y + pixel_y_offset, time = DODGE_ANIMATION_LENGTH * 0.5, flags = ANIMATION_LINEAR_TRANSFORM)
	animate(pixel_x = src.pixel_x - pixel_x_offset, pixel_y = src.pixel_y - pixel_y_offset, time = DODGE_ANIMATION_LENGTH, flags = ANIMATION_LINEAR_TRANSFORM)

	DT.display_miss_message(attacker,src,weapon,target,"dodged by \the [src]")
	DT.do_miss_sound(attacker,src,weapon,target)
	DT.do_attack_animation(attacker,src,weapon,target)

	if(is_living(attacker))
		var/mob/living/L = attacker
		L.to_chat(span("notice","\The [src.name] dodges your attack!"),CHAT_TYPE_COMBAT)

	src.to_chat(span("warning","You dodge \the [attacker.name]'s [weapon == attacker ? "attack" : weapon.name]!"),CHAT_TYPE_COMBAT)

	add_skill_xp(SKILL_DODGE,1)
	return TRUE

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