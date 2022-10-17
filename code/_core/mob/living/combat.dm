/mob/living/proc/can_block()

	if(!(attack_flags & CONTROL_MOD_BLOCK))
		return FALSE

	if(horizontal)
		return FALSE

	if(!can_move())
		return FALSE

	if(!src.z)
		return FALSE

	return TRUE

/mob/living/proc/handle_blocking(var/force_change=FALSE)

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
					animation_time = 3 + get_skill_power(SKILL_PARRY,0,1,2)*3
					parry_time = world.time + animation_time
					parry_spam_time = world.time + 18
				else //Can't parry
					animation_time = 10
					shield_overlay.color = "#FF0000"
					parry_spam_time = max(parry_spam_time,world.time+10)
			animate(shield_overlay,pixel_x=offsets[1]*8,pixel_y=offsets[2]*8,alpha = force_change ? 150 : 200, color="#FFFFFF", time = animation_time, easing = BACK_EASING | EASE_OUT, flags = ANIMATION_LINEAR_TRANSFORM)
			if(!force_change)
				animate(alpha=150, time = parry_spam_time - world.time)

/mob/living/can_attack(var/atom/attacker,var/atom/victim,var/atom/weapon,var/params,var/damagetype/damage_type)

	if(dead)
		return FALSE

	if(has_status_effects(PARALYZE,SLEEP,STAMCRIT,STUN,STAGGER,PARRIED))
		return FALSE

	if(grabbing_hand && grabbing_hand.owner)
		if(horizontal)
			return FALSE
		if(is_behind(grabbing_hand.owner,src))
			return FALSE
		return FALSE

	. = ..()

/mob/living/can_be_attacked(var/atom/attacker,var/atom/weapon,var/params,var/damagetype/damage_type)

	if(is_living(attacker))
		var/mob/living/L = attacker
		if(!damage_type || !damage_type.allow_friendly_fire)
			if(!allow_hostile_action(L.loyalty_tag,src))
				return FALSE

	return ..()

/mob/living/proc/send_pain_response(var/pain_strength=50)
	if(pain_strength < 75)
		do_emote("pain")
	else
		do_emote("scream")
	return TRUE

/mob/living/proc/get_block_data(var/atom/attacker,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/damagetype/DT)
	return list(src,0.5)

/mob/living/proc/on_blocked_hit(var/atom/attacker,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/damagetype/DT,var/atom/block_atom,var/block_multiplier=0,var/total_damage_blocked=0)

	if(is_item(block_atom) && !is_organ(block_atom))
		var/obj/item/I = block_atom
		I.use_condition(-1)
		if(I.block_sound)
			play_sound(I.block_sound,get_turf(src),volume=25+min(75,total_damage_blocked))

	if(client) src.add_skill_xp(SKILL_BLOCK,total_damage_blocked)

	return TRUE

/mob/living/proc/on_unblocked_hit(var/atom/attacker,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/damagetype/DT,var/total_damage_dealt=0)
	if(client) src.add_attribute_xp(ATTRIBUTE_CONSTITUTION,total_damage_dealt)
	return TRUE

/mob/living/advanced/proc/on_parried_hit(var/atom/attacker,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/damagetype/DT,var/damage_multiplier=1)
	if(client)
		src.add_skill_xp(SKILL_PARRY,1)
	return TRUE