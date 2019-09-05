/mob/living/proc/add_stun(var/value,var/max_value = 40)

	//value = max(value,10)

	if(stun_time > max_value)
		return FALSE

	stun_time = min(max_value,stun_time + value)

	return TRUE

/mob/living/get_interact_delay(var/mob/user)
	return interact_delay_base * (2 - get_attribute_power(ATTRIBUTE_DEXTERITY,1,100))

/mob/living/get_parry_chance(var/atom/attacker,var/atom/weapon,var/atom/target)
	if(status & FLAG_STATUS_STUN)
		return 0
	var/base_chance = get_skill_power(SKILL_PARRY,1,100)*50 + get_luck_calc(src,0.25,attacker,-0.25)
	return base_chance

/mob/living/get_dodge_chance(var/atom/attacker,var/atom/weapon,var/atom/target,var/damagetype/DT)
	if(status & FLAG_STATUS_STUN)
		return 0
	var/base_chance = get_skill_power(SKILL_DODGE,1,100)*50 + get_luck_calc(src,0.25,attacker,-0.25)
	return base_chance

/mob/living/get_block_chance(var/atom/attacker,var/atom/weapon,var/atom/target,var/damagetype/DT)
	if(status & FLAG_STATUS_STUN)
		return 0
	var/base_chance = get_skill_power(SKILL_BLOCK,1,100)*50 + get_luck_calc(src,0.25,attacker,-0.25)
	return base_chance

/mob/living/get_miss_chance(var/atom/attacker,var/atom/weapon,var/atom/target)
	if(status & FLAG_STATUS_STUN)
		var/distance = get_dist(attacker,src)
		if(distance <= max(weapon.attack_range,attacker.attack_range))
			return 0
		else
			return 50 + distance*10
	return 0


/mob/living/do_impact_effect(var/atom/attacker,var/atom/weapon,var/damagetype/DT,var/damage_dealt)

	. = ..()

	if(!DT.draw_blood)
		return .

	var/turf/T = get_turf(src)

	var/obj/effect/temp/impact/blood/B = new(T,SECONDS_TO_DECISECONDS(60),"#FF0000")
	B.transform.Scale(0.1,0.1)

	var/offset_x = (T.x - attacker.x)
	var/offset_y = (T.y - attacker.y)

	if(!offset_x && !offset_y)
		offset_x = rand(-1,1)

	var/total_offset = abs(offset_x) + abs(offset_y)

	offset_x = offset_x/total_offset
	offset_y = offset_y/total_offset

	offset_x *= TILE_SIZE
	offset_y *= TILE_SIZE

	animate(B,pixel_x = offset_x,pixel_y = offset_y, transform = null, time = 2)

	return .