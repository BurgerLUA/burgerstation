/mob/get_parry_chance(var/atom/attacker,var/atom/weapon,var/atom/target)
	var/base_chance = get_skill_power(SKILL_PARRY,1,100)*50 + get_luck_calc(src,0.5,attacker,-0.5)
	return base_chance

/mob/get_dodge_chance(var/atom/attacker,var/atom/weapon,var/atom/target)
	var/base_chance = get_skill_power(SKILL_DODGE,1,100)*50 + get_luck_calc(src,0.5,attacker,-0.5)
	return base_chance

/mob/get_block_chance(var/atom/attacker,var/atom/weapon,var/atom/target)
	var/base_chance = get_skill_power(SKILL_BLOCK,1,100)*50 + get_luck_calc(src,0.5,attacker,-0.5)
	return base_chance

//TODO: Magic Effect System

/mob/perform_block(var/atom/attacker,var/atom/weapon,var/atom/target,var/damagetype/DT)
	return ..()

/mob/perform_parry(var/atom/attacker,var/atom/weapon,var/atom/target,var/damagetype/DT)
	attack(src,attacker)
	return ..()

/mob/perform_dodge(var/atom/attacker,var/atom/weapon,var/atom/target,var/damagetype/DT)

	var/pixel_x_offset = prob(50) ? -8 : 8
	var/pixel_y_offset = prob(50) ? -8 : 8

	animate(src, pixel_x = src.pixel_x + pixel_x_offset, pixel_y = src.pixel_y + pixel_y_offset, time = ATTACK_ANIMATION_LENGTH * 0.5, flags = ANIMATION_LINEAR_TRANSFORM)
	animate(pixel_x = src.pixel_x - pixel_x_offset, pixel_y = src.pixel_y - pixel_y_offset, time = ATTACK_ANIMATION_LENGTH, flags = ANIMATION_LINEAR_TRANSFORM)

	move_delay += ATTACK_ANIMATION_LENGTH

	DT.do_miss_sound(attacker,src,weapon,target)
	DT.do_attack_animation(attacker,src,weapon,target)
	return ..()