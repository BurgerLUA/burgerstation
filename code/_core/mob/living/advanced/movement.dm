/mob/living/advanced/dash(var/atom/dash_target,var/dash_direction=0x0,var/instances_left = 0)//Can either input dash target or dash direction.

	if(driving)
		return FALSE

	return ..()



/mob/living/advanced/on_sprint()

	if(health && health.adjust_stamina(-SPRINT_STAMINA_LOSS))
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

	if(health && !has_status_effect(ADRENALINE))
		health_mul = clamp(0.5 + (health.health_current/health.health_max),0.5,1)
		stamina_mul = clamp(0.75 + (health.stamina_current/health.stamina_max),0.75,1)

	//https://www.desmos.com/calculator/9oyrocojgp
	var/cucumber = weight/(weight_max*health_mul*stamina_mul*health_mul)
	cucumber = clamp(cucumber,0,1)
	. *= 2 - ((1-cucumber)**0.42)

	. *= slowdown_mul

	return .

/mob/living/advanced/toggle_sneak(var/on = TRUE)

	if(on && health && !health.adjust_stamina(-10))
		update_health_element_icons(stamina=TRUE)
		stamina_regen_delay = max(stamina_regen_delay,60)
		return FALSE

	return ..()

/mob/living/advanced/on_sneak()

	if(health)
		if(health.adjust_stamina( -(2-stealth_mod)*5 ))
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