/mob/living/can_be_attacked(var/atom/attacker,var/atom/weapon,var/params,var/damagetype/damage_type)

	if(!isturf(src.loc))
		return FALSE

	if(src.loyalty_tag && is_living(attacker))
		var/mob/living/L = attacker
		if(L.loyalty_tag == src.loyalty_tag)
			var/area/A1 = get_area(L)
			var/area/A2 = get_area(src)
			if(!(A1.flags_area & FLAG_AREA_NO_LOYALTY && A2.flags_area & FLAG_AREA_NO_LOYALTY))
				if(!damage_type)
					return FALSE
				if(!damage_type.allow_friendly_fire)
					return FALSE

	return ..()


/mob/living/proc/send_pain(var/pain_strength=50)
	if(pain_strength < 75)
		do_emote("pain")
	else
		do_emote("scream")
	return TRUE