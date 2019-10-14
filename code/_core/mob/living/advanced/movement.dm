/mob/living/advanced/on_sprint()
	if(adjust_stamina(-SPRINT_STAMINA_LOSS))
		add_skill_xp(SKILL_ATHLETICS,1)
		update_health_element_icons(stamina=TRUE)
		stamina_regen_delay = max(stamina_regen_delay,30)

	return ..()

/mob/living/advanced/handle_movement(var/adjust_delay=0)

	if(driving)
		return driving.handle_movement(adjust_delay)

	return ..()


mob/living/advanced/get_movement_delay()
	return ..() * (1/slowdown_mul)

/mob/living/advanced/toggle_sneak(var/on = TRUE)
	if(on && !adjust_stamina(-10))
		update_health_element_icons(stamina=TRUE)
		stamina_regen_delay = max(stamina_regen_delay,60)
		return FALSE

	return ..()

/mob/living/advanced/on_sneak()
	if(adjust_stamina( -(2-stealth_mod)*5 ))
		update_health_element_icons(stamina=TRUE)
		stamina_regen_delay = max(stamina_regen_delay,30)
	else
		toggle_sneak(FALSE)
		return FALSE

	return ..()


/mob/living/advanced/Move(NewLoc,Dir=0,step_x=0,step_y=0)
	. = ..()

	if(.)
		for(var/obj/chat_text/CT in stored_chat_text)
			CT.glide_size = src.glide_size
			CT.force_move(src.loc)

	return .