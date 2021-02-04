/mob/living/advanced/dash(var/atom/dash_target,var/dash_direction=0x0,var/instances_left = 0)//Can either input dash target or dash direction.

	if(driving)
		return FALSE

	return ..()



/mob/living/advanced/on_sprint()

	if(health && health.adjust_stamina(-1))
		update_health_element_icons(stamina=TRUE)
		stamina_regen_delay = max(stamina_regen_delay,30)

	return ..()

/mob/living/advanced/handle_movement(var/adjust_delay=0)

	if(grabbing_hand && handcuffed)
		return FALSE

	if(driving)
		return driving.handle_movement(adjust_delay)

	return ..()


mob/living/advanced/get_movement_delay()

	. = ..()

	var/health_mul = 1
	var/stamina_mul = 1
	var/pain_mul = 1
	var/adrenaline_bonus = 1 + ((get_status_effect_magnitude(ADRENALINE)/100)*(get_status_effect_duration(ADRENALINE)/100))

	if(health)
		var/pain_bonus = min(1,get_status_effect_magnitude(PAINKILLER)/100) * min(1,get_status_effect_duration(PAINKILLER)/100) * health.health_max
		health_mul = clamp(0.5 + ((health.health_current + pain_bonus)/health.health_max),0.5,1)
		stamina_mul = clamp(0.75 + ((health.stamina_current + pain_bonus)/health.stamina_max),0.75,1)
		pain_mul = clamp(0.1 + (1 - ((health.get_loss(PAIN) - pain_bonus)/health.health_max))*0.9,0.1,1)

	. *= slowdown_mul * (1/adrenaline_bonus) * (1/pain_mul) * (1/stamina_mul) * (1/health_mul)

	return .

/mob/living/advanced/toggle_sneak(var/on = TRUE)

	if(on && health && !health.adjust_stamina(-10))
		update_health_element_icons(stamina=TRUE)
		stamina_regen_delay = max(stamina_regen_delay,60)
		return FALSE

	return ..()

/mob/living/advanced/on_sneak()

	if(health)
		if(health.adjust_stamina( -(2-stealth_mod)*2.5 ))
			update_health_element_icons(stamina=TRUE)
			stamina_regen_delay = max(stamina_regen_delay,30)
		else
			toggle_sneak(FALSE)
			return FALSE

	return ..()

/mob/living/advanced/get_footsteps(var/list/original_footsteps,var/enter=TRUE)

	if(footstep_left_right_counter)
		if(labeled_organs[BODY_FOOT_RIGHT])
			var/obj/item/organ/foot/O = labeled_organs[BODY_FOOT_RIGHT]
			return O.get_footsteps(original_footsteps,enter)
	else
		if(labeled_organs[BODY_FOOT_LEFT])
			var/obj/item/organ/foot/O = labeled_organs[BODY_FOOT_LEFT]
			return O.get_footsteps(original_footsteps,enter)

	return original_footsteps