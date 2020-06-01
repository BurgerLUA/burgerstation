/mob/living/advanced/on_sprint()

	if(health && health.adjust_stamina(-SPRINT_STAMINA_LOSS))
		update_health_element_icons(stamina=TRUE)
		stamina_regen_delay = max(stamina_regen_delay,30)

	return ..()

/mob/living/advanced/handle_movement(var/adjust_delay=0)

	if(driving)
		return driving.handle_movement(adjust_delay)

	return ..()


mob/living/advanced/get_movement_delay()

	. = ..()

	if(health && health.health_current <= 0)
		. *= 2

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

/mob/living/advanced/Move(var/atom/NewLoc,Dir=0,desired_step_x=0,desired_step_y=0,var/silent=FALSE)

	. = ..()

	if(. && chat_overlay)
		chat_overlay.glide_size = src.glide_size
		chat_overlay.force_move(src.loc)

	return .