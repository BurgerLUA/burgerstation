/mob/living/simple/npc/ghost
	name = "?"
	desc = "..."
	desc_extended  = "..."
	mouse_opacity = 0

	ai = /ai/ghost

	var/desired_alpha = 200 //Controlled in AI.

	has_footsteps = FALSE

/mob/living/simple/npc/ghost/handle_alpha()
	return desired_alpha