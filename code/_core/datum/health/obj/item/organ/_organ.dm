


/health/obj/item/organ/update_stats()

	if(!is_organ(owner))
		return ..()

	if(!is_advanced(owner.loc))
		return ..()

	var/obj/item/organ/O = owner
	var/mob/living/advanced/A = owner.loc

	health_max = O.health_base * ( 1 + A.get_attribute_power(ATTRIBUTE_VITALITY)*2)

	//A.update_health_element_icons(TRUE,TRUE,TRUE,TRUE) TODO: CHECK IF THIS IS NEEDED

	return TRUE

/health/obj/item/organ/update_health(var/damage_dealt,var/atom/attacker,var/update_hud=TRUE)

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
				var/current_amount = Clamp(ceiling((get_loss(damage_type)/health_max*0.5)*3),0,3)
				if(last_amount != current_amount)
					var/desired_icon_state = current_amount ? "[O.id]_[damage_type]_[current_amount]" : "none"
					O.change_blend("damage_[damage_type]", desired_icon_state = desired_icon_state)
					O.visual_wounds[damage_type] = current_amount
					should_update = TRUE

			if(should_update)
				A.update_overlay(O)

			A.health_regen_delay = max(A.health_regen_delay,300)
			world.log << "ORGAN HEALTH UPDATE."

	return .

/health/obj/item/organ/adjust_loss_smart(var/brute,var/burn,var/tox,var/oxy)

	. = ..()

	if(. && is_advanced(owner.loc))
		var/mob/living/advanced/A = owner.loc
		A.health_regen_delay = max(A.health_regen_delay,300)
		A.health.update_health()

	return .

/health/obj/item/organ/adjust_brute_loss(var/value)

	. = ..()

	if(. > 0 && is_advanced(owner.loc))
		var/mob/living/advanced/A = owner.loc
		A.health_regen_delay = max(A.health_regen_delay,300)

	return .

/health/obj/item/organ/adjust_tox_loss(var/value)

	. = ..()

	if(. > 0 && is_advanced(owner.loc))
		var/mob/living/advanced/A = owner.loc
		A.health_regen_delay = max(A.health_regen_delay,300)

	return .

/health/obj/item/organ/adjust_oxy_loss(var/value)

	. = ..()

	if(. > 0 && is_advanced(owner.loc))
		var/mob/living/advanced/A = owner.loc
		A.health_regen_delay = max(A.health_regen_delay,300)

	return .

/health/obj/item/organ/adjust_burn_loss(var/value)

	. = ..()

	if(. > 0 && is_advanced(owner.loc))
		var/mob/living/advanced/A = owner.loc
		A.health_regen_delay = max(A.health_regen_delay,300)

	return .

/health/obj/item/organ/adjust_fatigue_loss(var/value)
	if(!owner.loc || !is_advanced(owner.loc))
		return 0

	var/mob/living/advanced/A = owner.loc

	if(!A.health)
		return FALSE

	return A.health.adjust_fatigue_loss(value)