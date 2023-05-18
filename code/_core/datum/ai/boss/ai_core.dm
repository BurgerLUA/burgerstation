/ai/boss/ai_core
	can_attack = FALSE

/ai/boss/ai_core/set_objective(var/atom/A)
	. = ..()
	if(.)
		owner.update_icon()