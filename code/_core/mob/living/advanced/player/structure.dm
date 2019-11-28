/mob/living/advanced/player/proc/set_structure_active(var/obj/structure/S)

	if(S == active_structure)
		return FALSE

	if(active_structure)
		set_structure_unactive()

	active_structure = S

	active_structure.on_active(src)

/mob/living/advanced/player/proc/set_structure_unactive()

	if(active_structure)
		active_structure.on_inactive(src)

	active_structure = FALSE

	return TRUE
