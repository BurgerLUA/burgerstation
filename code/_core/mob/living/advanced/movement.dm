/mob/living/advanced/on_sprint()
	if(adjust_stamina(-3))
		add_skill_xp(SKILL_ATHLETICS,1)
		update_health_element_icons(stamina=TRUE)
		stamina_regen_delay = max(stamina_regen_delay,30)

	return ..()
