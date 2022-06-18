/ai/advanced/beef
	ignore_immortal = TRUE
	should_find_weapon = FALSE
	roaming_distance = VIEW_RANGE

/ai/advanced/beef/check_aggression(var/mob/living/target,var/aggression_override = src.aggression)

	if(target == hunt_target)
		return is_facing(target,owner)

	return check_aggression(target)
