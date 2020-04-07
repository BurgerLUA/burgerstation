/ai/advanced/stand
	use_alerts = FALSE
	ignore_immortal = TRUE
	radius_find_enemy = VIEW_RANGE

/ai/advanced/stand/handle_movement_roaming()
	return FALSE

/ai/advanced/stand/handle_movement_crowding()
	return FALSE

/ai/advanced/stand/should_attack_mob(var/mob/living/L)
	if(L.stand && L.stand.linked_stand == owner)
		return FALSE
	return ..()

/ai/advanced/stand/set_objective(var/mob/living/L)
	. = ..()
	owner.set_dir(owner.dir,TRUE)
	return .