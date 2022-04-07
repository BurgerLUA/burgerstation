/mob/living/can_attack(var/atom/attacker,var/atom/victim,var/atom/weapon,var/params,var/damagetype/damage_type)

	if(dead)
		return FALSE

	if(has_status_effects(PARALYZE,SLEEP,STAMCRIT,STUN,PARRIED))
		return FALSE

	if(grabbing_hand && grabbing_hand.owner && is_behind(grabbing_hand.owner,src))
		return FALSE

	. = ..()

/mob/living/can_be_attacked(var/atom/attacker,var/atom/weapon,var/params,var/damagetype/damage_type)

	if(!isturf(src.loc))
		return FALSE

	if(is_living(attacker))
		var/mob/living/L = attacker
		if(!damage_type || !damage_type.allow_friendly_fire)
			var/area/A = get_area(src)
			if(!allow_hostile_action(src.loyalty_tag,L.loyalty_tag,A))
				return FALSE

	return ..()

/mob/living/proc/send_pain(var/pain_strength=50)
	if(!has_trait(/trait/pain_tolerant))
		if(pain_strength < 75)
			do_emote("pain")
		else
			do_emote("scream")
	return TRUE

/mob/living/proc/get_block_multiplier(var/atom/attacker,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/damagetype/DT)
	return 0


/mob/living/proc/on_blocked_hit(var/atom/attacker,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/damagetype/DT,var/damage_multiplier=1,var/block_multiplier=0)
	if(client) src.add_skill_xp(SKILL_BLOCK,1)
	return TRUE

/mob/living/proc/on_unblocked_hit(var/atom/attacker,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/damagetype/DT,var/damage_multiplier=1)
	if(client) src.add_attribute_xp(ATTRIBUTE_CONSTITUTION,1)
	return TRUE

/mob/living/advanced/proc/on_parried_hit(var/atom/attacker,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/damagetype/DT,var/damage_multiplier=1)
	if(client)
		src.add_skill_xp(SKILL_PARRY,1)
	return TRUE