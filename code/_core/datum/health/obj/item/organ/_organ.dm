/health/obj/item/organ/update_health_stats()

	if(!is_organ(owner))
		return ..()

	if(!is_advanced(owner.loc))
		return ..()

	var/obj/item/organ/O = owner
	var/mob/living/advanced/A = owner.loc

	. = ..()

	health_max = O.health_base * ( 1 + A.get_attribute_power(ATTRIBUTE_VITALITY)*A.mob_size)

	//A.update_health_element_icons(TRUE,TRUE,TRUE,TRUE) TODO: CHECK IF THIS IS NEEDED

	return .

/health/obj/item/organ/update_health(var/atom/attacker,var/damage_dealt=0,var/update_hud=TRUE,var/check_death=TRUE)

	. = ..()

	if(. && owner.initialized)

		if(!health_max)
			return .

		if(!is_organ(owner))
			return .

		var/obj/item/organ/O = owner

		if(O.enable_wounds && O.loc && is_advanced(O.loc))
			var/mob/living/advanced/A = O.loc
			var/should_update = FALSE
			for(var/damage_type in O.visual_wounds)
				var/last_amount = O.visual_wounds[damage_type]
				var/current_amount = clamp(CEILING((get_loss(damage_type)/health_max*0.5)*3, 1),0,3)
				if(last_amount != current_amount)
					var/desired_icon_state = current_amount ? "[O.id]_[damage_type]_[current_amount]" : "none"
					O.add_blend("damage_[damage_type]", desired_icon_state = desired_icon_state)
					O.visual_wounds[damage_type] = current_amount
					should_update = TRUE
					if(damage_type == BRUTE && current_amount == 0)
						O.bleeding = 0

			if(should_update)
				A.update_overlay_tracked("\ref[O]")

	return .

/health/obj/item/organ/adjust_loss_smart(var/brute,var/burn,var/tox,var/oxy,var/update=TRUE)

	if(tox || oxy)
		if(owner.loc && is_advanced(owner.loc))
			var/mob/living/advanced/A = owner.loc
			if(A.health)
				. += A.health.adjust_loss_smart(tox=tox,oxy=oxy)

		tox = 0
		oxy = 0


	. += ..(brute,burn,tox,oxy)

	if(. && update && is_advanced(owner.loc))
		var/mob/living/advanced/A = owner.loc
		A.queue_health_update = TRUE

	return .

/health/obj/item/organ/adjust_tox_loss(var/value)
	if(!owner.loc || !is_advanced(owner.loc))
		return 0

	var/mob/living/advanced/A = owner.loc

	if(!A.health)
		return FALSE

	return A.health.adjust_tox_loss(value)

/health/obj/item/organ/adjust_oxy_loss(var/value)
	if(!owner.loc || !is_advanced(owner.loc))
		return 0

	var/mob/living/advanced/A = owner.loc

	if(!A.health)
		return FALSE

	return A.health.adjust_oxy_loss(value)

/health/obj/item/organ/adjust_fatigue_loss(var/value)
	if(!owner.loc || !is_advanced(owner.loc))
		return 0

	var/mob/living/advanced/A = owner.loc

	if(!A.health)
		return FALSE

	return A.health.adjust_fatigue_loss(value)