/mob/living/advanced/player/
	name = "lost soul"
	desc = "Seems a little smarter than most, you think."
	desc_extended = "This is a player."

	starting_factions = list(
		FACTION_PLAYER
	)
	class = "default"

	var/dialogue_target_id

/mob/living/advanced/player/Move(var/atom/new_loc,var/desired_dir=0,var/desired_step_x=0,var/desired_step_y=0)
	. = ..()
	if(. && dialogue_target_id)
		dialogue_target_id = null
		close_menu(src,"dialogue")

	return .

