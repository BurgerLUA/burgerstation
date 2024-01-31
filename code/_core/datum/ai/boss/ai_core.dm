/ai/boss/ai_core
	can_attack = FALSE

/ai/boss/ai_core/set_objective(atom/A)
	. = ..()
	if(.)
		owner.update_icon()