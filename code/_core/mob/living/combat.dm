/mob/living/proc/get_current_target_cords(params)
	if(ai)
		return list(pick(ai.target_distribution_x),pick(ai.target_distribution_x))
	if(!params)
		params = list(PARAM_ICON_X = 16, PARAM_ICON_Y = 16)
	return list(params[PARAM_ICON_X],params[PARAM_ICON_Y])

/mob/living/proc/can_block()

	if(!(attack_flags & CONTROL_MOD_BLOCK))
		return FALSE

	if(horizontal)
		return FALSE

	if(!can_attack(src))
		return FALSE

	return TRUE

/mob/living/proc/handle_blocking(force_change=FALSE)

	var/changed = force_change

	if(blocking)
		if(!can_block())
			blocking = FALSE
			changed = TRUE
	else
		if(can_block())
			blocking = TRUE
			changed = TRUE

	if(changed)
		if(!blocking)
			animate(shield_overlay,pixel_x=0,pixel_y=0,alpha = 0, time = 3, flags = ANIMATION_LINEAR_TRANSFORM)
		else
			var/list/offsets = direction_to_pixel_offset(dir)
			var/animation_time = 5
			if(!force_change)
				if(parry_spam_time <= world.time)
					shield_overlay.color = "#FFFFFF"
					animation_time = 3 + get_skill_power(SKILL_BLOCK,0,1,2)*3
					parry_time = world.time + animation_time
					parry_spam_time = world.time + 18
				else //Can't parry
					animation_time = 10
					shield_overlay.color = "#FF0000"
					parry_spam_time = max(parry_spam_time,world.time+10)
			animate(shield_overlay,pixel_x=offsets[1]*8,pixel_y=offsets[2]*8,alpha = force_change ? 150 : 200, color="#FFFFFF", time = animation_time, easing = BACK_EASING | EASE_OUT, flags = ANIMATION_LINEAR_TRANSFORM)
			if(!force_change)
				animate(alpha=150, time = parry_spam_time - world.time)

/mob/living/can_attack(atom/attacker,atom/victim,atom/weapon,params,damagetype/damage_type)

	if(dead)
		return FALSE

	if(has_status_effects(PARALYZE,SLEEP,STAMCRIT,STUN,STAGGER,PARRIED))
		return FALSE

	//Cannot attack if you're being grabbed from behind.
	if(grabbing_hand && grabbing_hand.owner && (src.horizontal || is_behind(grabbing_hand.owner,src)))
		return FALSE

	. = ..()

/mob/living/can_be_attacked(atom/attacker,atom/weapon,params,damagetype/damage_type)

	if(src != attacker && is_living(attacker))
		var/mob/living/L = attacker
		if(!damage_type || !damage_type.allow_friendly_fire)
			if(!allow_hostile_action(L.loyalty_tag,src))
				return FALSE

	return ..()

/mob/living/proc/send_pain_response(pain_strength=50)
	if(pain_strength < 75)
		do_emote("pain")
	else
		do_emote("scream")
	return TRUE

/mob/living/proc/get_block_data(atom/attacker,atom/weapon,atom/hit_object,atom/blamed,damagetype/DT)
	return list(src,0.5)

/mob/living/proc/on_blocked_hit(atom/attacker,atom/weapon,atom/hit_object,atom/blamed,damagetype/DT,atom/block_atom,block_multiplier=0,total_damage_blocked=0)

	if(is_item(block_atom) && !is_organ(block_atom))
		var/obj/item/I = block_atom
		I.use_condition(-1)
		if(I.block_sound)
			play_sound(I.block_sound,get_turf(src),volume=25+min(75,total_damage_blocked))

	if(client) src.add_skill_xp(SKILL_BLOCK,total_damage_blocked)

	return TRUE

/mob/living/proc/on_unblocked_hit(atom/attacker,atom/weapon,atom/hit_object,atom/blamed,damagetype/DT,total_damage_dealt=0)
	if(client) src.add_attribute_xp(ATTRIBUTE_CONSTITUTION,total_damage_dealt)
	return TRUE

/mob/living/proc/on_parried_hit(atom/attacker,atom/weapon,atom/hit_object,atom/blamed,damagetype/DT,damage_multiplier=1)
	return TRUE

/mob/living/proc/parry(atom/attacker,atom/weapon,atom/hit_object,damagetype/DT)

	if(horizontal)
		return FALSE

	if(parry_time < world.time)
		return FALSE

	if(!is_facing(src,attacker))
		return FALSE

	return TRUE