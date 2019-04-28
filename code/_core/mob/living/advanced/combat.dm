/mob/living/advanced/get_object_to_damage(var/atom/attacker,var/atom/victim,params)

	if(!params)
		params = list("icon-y" = rand(16,32))


	var/y_attack = text2num(params["icon-y"])

	if(y_attack >= 24 && src.labeled_organs["head"])
		return src.labeled_organs["head"]

	if(y_attack >= 12)
		if(prob(50) && src.labeled_organs[BODY_TORSO])
			return src.labeled_organs[BODY_TORSO]
		else if(prob(50) && src.labeled_organs[BODY_ARM_LEFT])
			return src.labeled_organs[BODY_ARM_LEFT]
		else if(src.labeled_organs[BODY_ARM_RIGHT])
			return src.labeled_organs[BODY_ARM_RIGHT]

	if(y_attack >= 9)
		if(prob(50) && src.labeled_organs[BODY_GROIN])
			return src.labeled_organs[BODY_GROIN]
		else if(prob(50) && src.labeled_organs[BODY_HAND_LEFT])
			return src.labeled_organs[BODY_HAND_LEFT]
		else if(src.labeled_organs[BODY_HAND_LEFT])
			return src.labeled_organs[BODY_HAND_LEFT]

	if(y_attack >= 4)
		if(prob(50) && src.labeled_organs[BODY_LEG_LEFT])
			return src.labeled_organs[BODY_LEG_LEFT]
		else if (src.labeled_organs[BODY_LEG_RIGHT])
			return src.labeled_organs[BODY_LEG_RIGHT]

	if(prob(50) && src.labeled_organs[BODY_FOOT_LEFT])
		return src.labeled_organs[BODY_FOOT_LEFT]
	else if (src.labeled_organs[BODY_FOOT_RIGHT])
		return src.labeled_organs[BODY_FOOT_RIGHT]

	return victim

/mob/living/advanced/perform_block(var/atom/attacker,var/atom/weapon,var/atom/target,var/damagetype/DT)

	var/base_chance = get_block_chance(attacker,weapon,target)

	var/obj/item/I_L = get_held_left(DT.get_attack_type())
	var/obj/item/I_R = get_held_right(DT.get_attack_type())

	var/left_block_mul = 0
	var/right_block_mul = 0

	var/blocking_item

	if(I_L)
		left_block_mul = I_L.get_block_mul(DT.get_attack_type())

	if(I_R)
		right_block_mul = I_R.get_block_mul(DT.get_attack_type())

	if(left_block_mul && right_block_mul)
		if(left_block_mul > right_block_mul)
			blocking_item = I_L.name
			base_chance *= left_block_mul
		else
			blocking_item = I_R.name
			base_chance *= right_block_mul
	else if(left_block_mul)
		blocking_item = I_L.name
		base_chance *= left_block_mul
	else if(right_block_mul)
		blocking_item = I_R.name
		base_chance *= right_block_mul
	else
		base_chance *= get_skill_power(SKILL_UNARMED,1,100)

	if(!prob(min(base_chance,BLOCK_CHANCE_MAX)))
		return FALSE

	DT.display_miss_message(attacker,src,weapon,target,"blocked by [src]'s [blocking_item ? blocking_item : "fists"]")
	DT.do_attack_animation(attacker,src,weapon,target)

	var/area/A = get_area(src)
	if(A && istype(A))
		play_sound('sounds/weapons/generic_block.ogg', vector(src.x,src.y,src.z), environment = A.sound_environment, volume = Clamp(100 - base_chance,25,100) )

	add_skill_xp(SKILL_BLOCK,max(1,(100-base_chance)/1))

	return TRUE

/mob/living/advanced/perform_parry(var/atom/attacker,var/atom/weapon,var/atom/target,var/damagetype/DT,var/allow_parry_counter)

	var/base_chance = get_parry_chance(attacker,weapon,target)

	var/obj/item/I_L = get_held_left()
	var/obj/item/I_R = get_held_right()

	var/left_parry_mul = 0
	var/right_parry_mul = 0

	var/obj/item/parrying_item

	if(I_L)
		left_parry_mul = I_L.get_parry_mul(DT.get_attack_type())

	if(I_R)
		right_parry_mul = I_R.get_parry_mul(DT.get_attack_type())

	if(left_parry_mul && right_parry_mul)
		if(left_parry_mul > right_parry_mul)
			parrying_item = I_L
			base_chance *= left_parry_mul
		else
			parrying_item = I_R
			base_chance *= right_parry_mul
	else if(left_parry_mul)
		parrying_item = I_L
		base_chance *= left_parry_mul
	else if(right_parry_mul)
		parrying_item = I_R
		base_chance *= right_parry_mul
	else
		base_chance = 0

	if(!prob(min(base_chance,PARRY_CHANCE_MAX)))
		return FALSE

	if(!parrying_item.click_on_object(src,attacker))
		return FALSE

	DT.do_attack_animation(attacker,src,weapon,target)
	DT.display_miss_message(attacker,src,weapon,target,"parried by [src]'s [parrying_item]")

	if(allow_parry_counter)
		attack(src,attacker)

	add_skill_xp(SKILL_PARRY,max(1,(100-base_chance)/1))

	return TRUE

/mob/living/perform_dodge(var/atom/attacker,var/atom/weapon,var/atom/target,var/damagetype/DT)

	var/base_chance = get_dodge_chance(attacker,weapon,target)

	if(!prob(base_chance))
		return FALSE

	var/pixel_x_offset = prob(50) ? -8 : 8
	var/pixel_y_offset = prob(50) ? -8 : 8

	animate(src, pixel_x = src.pixel_x + pixel_x_offset, pixel_y = src.pixel_y + pixel_y_offset, time = ATTACK_ANIMATION_LENGTH * 0.5, flags = ANIMATION_LINEAR_TRANSFORM)
	animate(pixel_x = src.pixel_x - pixel_x_offset, pixel_y = src.pixel_y - pixel_y_offset, time = ATTACK_ANIMATION_LENGTH, flags = ANIMATION_LINEAR_TRANSFORM)

	DT.display_miss_message(attacker,src,weapon,target,"dodged by \the [src]")
	DT.do_miss_sound(attacker,src,weapon,target)
	DT.do_attack_animation(attacker,src,weapon,target)

	add_skill_xp(SKILL_DODGE,max(1,(100-base_chance)/1))
	return TRUE
